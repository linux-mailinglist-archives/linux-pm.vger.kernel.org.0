Return-Path: <linux-pm+bounces-41791-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DvlLrHjfGkQPQIAu9opvQ
	(envelope-from <linux-pm+bounces-41791-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:00:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF39BCC4F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30894305B466
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C73587D7;
	Fri, 30 Jan 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocwzdLxs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E935773F;
	Fri, 30 Jan 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792104; cv=none; b=Trp+NEBEHurq3LNtbMLWK5cyQsEj6EF7ehM+U+NXRfdKrOVhbB9MYqnQSPWA2xRpUe/SmcFyavkwpNudPIUOE8D2i7ZvolTqhHEMikvLcN5zw0sAvZK6ftF+Cgfb8PSp1f/mMoD4K106NMw0bK6YjB0SHFIZdJYC1i+pvkwXMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792104; c=relaxed/simple;
	bh=dM6ywpWOByIu1UZJyYxKcmpZP8XQxaOuztl8PUCyAug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=luqkUK/lgP0GYMbaZ1syRwmZOGt9/qBR4kPfgrzPRaI/kuU9fCW4Ye6QuLdQ1ZcIDD1mI3wa1B/hDs1vQefKKKiEHt86I+EEfNDLQDWOH+jdIdxhysptTW4H3imxH9AlsOgcWc74VPNVxI1nU3cwVIOaH2uQixYQ8r5O1AqAozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocwzdLxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F55C16AAE;
	Fri, 30 Jan 2026 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769792103;
	bh=dM6ywpWOByIu1UZJyYxKcmpZP8XQxaOuztl8PUCyAug=;
	h=From:Date:Subject:To:Cc:From;
	b=ocwzdLxsuPFxhBP39QxSReO2ZrhA+Tjmq0FlL6qfY7J8xXJzP3f7pxmdSg/rb4z7A
	 5TlB15Ph6zXfTwj1rwLL47m37ObmLgfjvjUSSKkORCrxudc8EytBCyGtWtq8jk9yp6
	 wIY5zHmKCXUjxFsfVr63dGeWkwew6Si3NxSWoxFtUyPZykDkqlHmSzIze6xLzpcqqh
	 mbyY0kIeo36bRS4eqBL9ndnVi/CwvuJUGwa9Q5kZQDDnP9gR5BMfPrtJ7M4HswKcLM
	 L2f4FF1KW4p3DoU2XepgyhUXdADEIUHO2vQQlMeW8o71w+RUzf5+kXN0Xffl6jmLIx
	 1yE/QQCDvCoSg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 30 Jan 2026 16:54:45 +0000
Subject: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFTifGkC/yXMQQrCMBBG4auUWTuQjljBq4iLJv41I20imShC6
 d2NuvwW761kKAqjU7dSwUtNc2rodx2FOKYbWK/NJE4G1+8d14iyjDPPS+ScYDFXPgQcnYj3kwz
 UykfBpO/f9Xz5257+jlC/K9q2D6yeglJ3AAAA
X-Change-ID: 20260130-thermal-lmh-oneshot-5ce7022bbf26
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aishwarya TCV <Aiswarya.TCV@arm.com>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dM6ywpWOByIu1UZJyYxKcmpZP8XQxaOuztl8PUCyAug=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpfOJkDc9DZd38l/z9fSyCjZxjSYU7zqk3EigJs
 5XHAyxAcSGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaXziZAAKCRAk1otyXVSH
 0HvbB/9nZ0sXz3btbZcW4vmORAmDGBE0St3AWpKFslcDPZXiBJnLxeKyk+3vHC2B7m5z+nb1Tz5
 FopmF+icQCTKtkBel8G60ghkt6g24NuakbX74gH40V/IYh1p4PnhKPf3b2qiJs6S8bMByO/x1Pc
 zM64Q8EK4GkKrJwE4BJ4KFdwtHwKjrJJl5fREK+sHkhJjoTECJWnH01EF+eI81Q3D2jv83qX4V0
 KCz+IgX4aGECB7wG7tLo6P4tZCaML4c57dSjaKYgFb97kCQblmF2KfwkRKmkldWckiPLmPMMiHo
 elwno0BCwNrEqc/uA0EVpDTK7w/wH63mSm26jPoxKxZv0AR5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41791-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CF39BCC4F
X-Rspamd-Action: no action

The lmh driver triggers a WARN_ON() due to requesting an interrupt with
IRQF_ONESHOT without a threaded handler:

[   17.414825] WARNING: kernel/irq/manage.c:1502 at __setup_irq+0xd0/0x7a0, CPU#7: (udev-worker)/154

...

 2361 18:49:55.941384  <4>[   17.415074]  __setup_irq+0xd0/0x7a0 (P)
 2362 18:49:55.981820  <4>[   17.415085]  request_threaded_irq+0xec/0x1a4
 2363 18:49:55.982122  <4>[   17.415095]  devm_request_threaded_irq+0x80/0x134
 2364 18:49:55.982365  <4>[   17.415103]  lmh_probe+0x31c/0x4c8 [lmh]
 2365 18:49:55.982594  <4>[   17.415118]  platform_probe+0x5c/0x98

This warning is there because IRQF_ONESHOT is only meaningful when there is
a threaded interrupt handler and this driver does not register one. Just
remove IRQF_ONESHOT, it wasn't doing anything.

Reported-by: Aishwarya TCV <Aiswarya.TCV@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/thermal/qcom/lmh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index ddadcfada513..b6b7f1193c44 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -220,8 +220,7 @@ static int lmh_probe(struct platform_device *pdev)
 	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
-			       "lmh-irq", lmh_data);
+			       IRQF_NO_SUSPEND, "lmh-irq", lmh_data);
 	if (ret) {
 		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
 		irq_domain_remove(lmh_data->domain);

---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260130-thermal-lmh-oneshot-5ce7022bbf26

Best regards,
--  
Mark Brown <broonie@kernel.org>


