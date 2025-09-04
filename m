Return-Path: <linux-pm+bounces-33835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F051B43CAA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4293248351B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDAD2FE05F;
	Thu,  4 Sep 2025 13:11:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88845277CA4
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991473; cv=none; b=sanRYPzUiqV9xFlzZFHYQjYZWnCcUi4vYmYGEaGVek0jrC3HlnWma1Wv6NzSfmaRfgT+HN/qJfs2uHXxoymKVZXiDbGnTBRubWweCySoMGA/Y9LrIAoD08svm+5EGP6+p0lovrBdydAkLIJcuSVvRPtCSRF9oOsaYEep79FVneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991473; c=relaxed/simple;
	bh=pe849PwRKqcOykMbF3crbyh2cc4S4Q2UgJdwmrDKICo=;
	h=Message-Id:From:Date:Subject:To:Cc; b=dzmTzIOGhpe4aRvEZgAjGAW9uSAxc2S2dZq8Rrj3MKqkJkSfOitjtAdP3MnmU8PgMnKs2hNENIqrc7+M26q/hDegW+AQtBqYl72q1AcfTSfS/9CtMIcZ8I9eTraUY9yJm1b7ue+ta1JK1k+vzrntxu7FWInKNhDBkuqh2iAGsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 68FB82009D10;
	Thu,  4 Sep 2025 15:11:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 53B8B3FAE00; Thu,  4 Sep 2025 15:11:08 +0200 (CEST)
Message-Id: <22453676d1ddcebbe81641bb68ddf587fee7e21e.1756990799.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 4 Sep 2025 15:11:09 +0200
Subject: [PATCH] xen/manage: Fix suspend error path
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The device power management API has the following asymmetry:
* dpm_suspend_start() does not clean up on failure
  (it requires a call to dpm_resume_end())
* dpm_suspend_end() does clean up on failure
  (it does not require a call to dpm_resume_start())

The asymmetry was introduced by commit d8f3de0d2412 ("Suspend-related
patches for 2.6.27") in June 2008:  It removed a call to device_resume()
from device_suspend() (which was later renamed to dpm_suspend_start()).

When Xen began using the device power management API in May 2008 with
commit 0e91398f2a5d ("xen: implement save/restore"), the asymmetry did
not yet exist.  But since it was introduced, a call to dpm_resume_end()
is missing in the error path of dpm_suspend_start().  Fix it.

Fixes: d8f3de0d2412 ("Suspend-related patches for 2.6.27")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v2.6.27
---
kexec suffered from the same issue ever since it began using the
device power management API in July 2008 with commit 89081d17f7bb
("kexec jump: save/restore device state").  It was fixed this year
by commit 996afb6efd1a ("kexec_core: Fix error code path in the
KEXEC_JUMP flow").  All other callers seem fine.

 drivers/xen/manage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 841afa4..1f5a7a4 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -110,7 +110,7 @@ static void do_suspend(void)
 	err = dpm_suspend_start(PMSG_FREEZE);
 	if (err) {
 		pr_err("%s: dpm_suspend_start %d\n", __func__, err);
-		goto out_thaw;
+		goto out_resume_end;
 	}
 
 	printk(KERN_DEBUG "suspending xenstore...\n");
@@ -150,6 +150,7 @@ static void do_suspend(void)
 	else
 		xs_suspend_cancel();
 
+out_resume_end:
 	dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 out_thaw:
-- 
2.50.1


