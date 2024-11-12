Return-Path: <linux-pm+bounces-17425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C649C5BB9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6B5287310
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F1C2003C6;
	Tue, 12 Nov 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tX3qfyS9"
X-Original-To: linux-pm@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F02003CB
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424937; cv=none; b=RMwHLX5QLdcHkqgQD0Pu+fz8gCrxAjoO2R4TaXoZhRw6G0161GR4haoSJTsGDZusM1ljC4vtaxwuLpfYz+H20N2i2SoRtXrcQb0MIh/+68JtPUGy5FzdGFA1RRl8I2MMD4JDAKeQBVvx4vJKBi2bf9vBTjvNIgMBWPIlDaarJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424937; c=relaxed/simple;
	bh=DjwzB9wR3hCHJ/jmCvydX7qHDWYSNTkF/cIgh1KFGqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lKUUke9DmokW2FuWxtpFHvQ1eTScEtSty8LCHesLogHNLCehMNwwXkj76C//2gURHwOxKIDyf54pYYuGUb6iVeL5h4m8qUYwnLZ9yBY9pIS0zX/cb9ad7DHZ+5olz2ai5fL+ORr6vAjLcqhiVo+hdx82g9+wO38nF0GDe++W5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tX3qfyS9; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731424936;
	bh=Zay688FL54iPGlwqJao+cjW8sbujCzTCJ0i2J2TYacc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=tX3qfyS90RxkCulXGU6UCVR8SJFbz8VMalN2Is4tgl9y+B/7hDXRSYLIOYnGmcFHG
	 K/bDLn9bQBkEegj98H6qcJlIHfyLH2mM8/r/JokGKwypViCO2plFThvDqGkrKU5Pnj
	 /eyZ0AZAIeN50ys4R0qC6e5rF4aeLXmeNgFdRfSZXyqREZmxG9TVqJmu9156dTmhnr
	 vw2hhlXx0LEMCkWl/BnORx4SsZq8xU/3y1evJ9aPShLoZXz4qOAaUoGWTf7dIlAtQc
	 thhW0GWOYDbEQ+/HidcnK2n3yo6PFcn171xlbcgujR/MWdTjPy/AT1b0zD4Illx+p/
	 YEJojQMlB5bsg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 67843680367;
	Tue, 12 Nov 2024 15:22:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 12 Nov 2024 23:21:45 +0800
Subject: [PATCH v2] PM: domains: Fix return value of API
 dev_pm_get_subsys_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-fix_dev_pm_get_subsys_data-v2-1-3774257ede73@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIhyM2cC/42NTQqDMBBGr1KybspkUCpd9R5FgklGnYU/zWioi
 Hdv6gm6fI+P9+1KKDKJelx2FSmx8DRmwOtF+b4ZO9IcMisELAwY0C1/bKBk58F2tFhZnWxiQ7M
 0Got75RwCtIFUDsyR8vqMv+rMPcsyxe38SuZn/8omo41GLIGqFqA07vle2fPob34aVH0cxxfJE
 CzJxgAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 28ktdltU_XQhkPVWQvv7A6hFiEgDzoPM
X-Proofpoint-GUID: 28ktdltU_XQhkPVWQvv7A6hFiEgDzoPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120123
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

dev_pm_get_subsys_data() has below 2 issues under condition
(@dev->power.subsys_data != NULL):

- it will do unnecessary kzalloc() and kfree().
- it will return -ENOMEM if the kzalloc() fails, that is wrong
  it should return 0 since the kzalloc() is not needed.

Fix by not doing kzalloc() and returning 0 for the condition.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove both stable and fix tag
- Correct commit message
- Link to v1: https://lore.kernel.org/r/20241010-fix_dev_pm_get_subsys_data-v1-1-2250e8f0051b@quicinc.com
---
 drivers/base/power/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index cca2fd0a1aed..a3cec013092c 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -26,6 +26,14 @@ int dev_pm_get_subsys_data(struct device *dev)
 {
 	struct pm_subsys_data *psd;
 
+	spin_lock_irq(&dev->power.lock);
+	if (dev->power.subsys_data) {
+		dev->power.subsys_data->refcount++;
+		spin_unlock_irq(&dev->power.lock);
+		return 0;
+	}
+	spin_unlock_irq(&dev->power.lock);
+
 	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
 	if (!psd)
 		return -ENOMEM;

---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20241010-fix_dev_pm_get_subsys_data-2478bb200fde

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


