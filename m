Return-Path: <linux-pm+bounces-16571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8079B304C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C10B21E74
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B41D88A4;
	Mon, 28 Oct 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="e51zsqrR"
X-Original-To: linux-pm@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFF1D0DF7
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118701; cv=none; b=iDn9GDGw3Z044/WCrhsb52t/Y/2pzfVtNNibI/XxX8GdujcICP3rucrmtrpCSZpVulOmISC4J2bF3l5KAPUx4LbOYHbu0IWcgA1urKPF2V3aztSG3iEGffNhBCsy4nhqk+p3YRn4n4/DBqmRx4BIxEF2oXoE5vFfB2l32WMZ1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118701; c=relaxed/simple;
	bh=6T+tlGDLDokB4GfAYtP8X1S5WQV/OIF+bJlMqerzrTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LGK4rx6D2QnQFOU8EBmmktRm6Xx7U9YXh6ju72q8chF9i5ZyDMITajaDcLfbmSKxP2SREz59adsLqiOnuvRZraID0S25RIPBYN+FPV5UbuHxZbTfQPySq7MATK2PZRryLiGTEFcPiO+JJVxJbsHG47s7KsDJyCmo0n+q1hLtj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=e51zsqrR; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730118699;
	bh=4bRpvFkGkbd+C5fU8ls9w7Y7zAU16P8zL2Bhr011Hjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=e51zsqrRoC7ewIP31pce2oT2/9QW9M1TQeuR953WFcO/qiZXQ+cZjbIj7yiEQ5EUS
	 9w3fz62rfREKyTn8Ur9sI/tIFNh7vcHEDb9f00v72gLecrxF9LN1XFqlZANcnooRB6
	 Jk3u+VqAaBKQ3DI4N0EuKRO3rCCKdcKZqHEoYv9ouGQ+pz8J+3M5rvvJzIimSZCYS9
	 cFGi1/dXcmtD9iVhXmUpFUrHDzrkllzSqZ2v0Pymtns83H6GFaFjv6GtEIf0tWBZFt
	 ecHTfmTRdrC5D+2Z7+pYZOe9KSszUzpcXbGKtHGU9T2X/fkvWOH23xQ8q/1PZZxRF+
	 9a+lfbUJ9X7kw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id A0D75680304;
	Mon, 28 Oct 2024 12:31:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 28 Oct 2024 20:31:11 +0800
Subject: [PATCH RESEND] PM: domains: Fix return value of API
 dev_pm_get_subsys_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fix_dev_pm_get_subsys_data-v1-1-20385f4b1e17@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: NINEBLinZ5ZaqAeUD491sGSSHkS7bpw5
X-Proofpoint-ORIG-GUID: NINEBLinZ5ZaqAeUD491sGSSHkS7bpw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410280101
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

dev_pm_get_subsys_data() has below 2 issues under condition
(@dev->power.subsys_data != NULL):

- it will do unnecessary kzalloc() and kfree().
- it will return -ENOMEM if the kzalloc() fails, that is wrong
  since the kzalloc() is not needed.

Fixed by not doing kzalloc() and returning 0 for the condition.

Fixes: ef27bed1870d ("PM: Reference counting of power.subsys_data")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/power/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 8c34ae1cd8d5..13cb1f2a06e7 100644
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
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-fix_dev_pm_get_subsys_data-2478bb200fde

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


