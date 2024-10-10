Return-Path: <linux-pm+bounces-15466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DED998D11
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41129B29BD4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFADA1CCB49;
	Thu, 10 Oct 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fNgNi+DG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B71CCB25
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573748; cv=none; b=RiIynwFP74nXGfhTG0qNU2Bjs5qrB8eN/4Fqan201PIx8m05rpjf9ZoDZgjkGtK4AK+eGBaff6UwVZ1k+Jzi9YJOUj/vmbVvZgfo3cYWqKg8/5OnpnWDoTf3h1uNeh60fO867xbSeciyU5jnbCvz8R+8pRmpcZ4jvGX/pMBIByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573748; c=relaxed/simple;
	bh=6T+tlGDLDokB4GfAYtP8X1S5WQV/OIF+bJlMqerzrTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SNdT0z80oHmPHHjhiHNMOuZtc8IxVnc2SeEpLuQPdwXpVMf86L5dRQpjyk0dGeOYh/tXiXT6W219ae+GX85dBxWTmS4QnOnHllRE+OUOY0Twb67j8eUwDOYO0IGvC4GJHYrUPgDdqlD0AEwy/usx9Fzl24vFLB3qnkQGORCwQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fNgNi+DG; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728573746;
	bh=4bRpvFkGkbd+C5fU8ls9w7Y7zAU16P8zL2Bhr011Hjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=fNgNi+DGxhNNLlZovmfCZVCjZ/qbnL4MO0+bbexsFc227L6t9chkWXXBQzX2AgpVU
	 LgKAujK+KZUGStfb6mEAOi0VsladyctwAX+jVvLFQkRdIC/m6ganDDOJhUq/6ES9WD
	 0B/C/VDjxvGtSqPF4PgO9ur/7sk/4cPaEz3Nw1kDzpeQ/eTY5zGRpblqeD5SqmxJmf
	 jubAOPQ8KBAaX0OwBXQ1YXPEoHxZ1pjHsrj8gvCvBZENh3KzFVS8UzpipVzHACo+vC
	 kr12smy/63sMc52MYiD9uqMy1y6+9lN029CFMgbvGWCiFKAqga648nSrilaK/MLWu9
	 La+TEivqX7sLw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id 9953FD0079A;
	Thu, 10 Oct 2024 15:22:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Oct 2024 23:22:00 +0800
Subject: [PATCH] PM: domains: Fix return value of API
 dev_pm_get_subsys_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-fix_dev_pm_get_subsys_data-v1-1-2250e8f0051b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABfxB2cC/x3MTQqEMAxA4atI1hbSIswwVxEJrU07WfhDo6KId
 58yyw8e7wblIqzwaW4ofIjKMlfYtoHx6+fMRmI1OHSdRYsmyUmRD1onyryR7kEvpeg3b1z3eof
 gEFNkqIO1cK3/8354nh9H4Yl6bAAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: M_pOUurVt_A_ut6Fg4w9HVdbi7t8ALq7
X-Proofpoint-ORIG-GUID: M_pOUurVt_A_ut6Fg4w9HVdbi7t8ALq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410100102
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


