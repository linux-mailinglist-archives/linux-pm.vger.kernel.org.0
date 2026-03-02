Return-Path: <linux-pm+bounces-43425-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCfPBOihpWmuCAAAu9opvQ
	(envelope-from <linux-pm+bounces-43425-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 15:42:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9D1DB117
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 15:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8AEF3064EFE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C573FFAA8;
	Mon,  2 Mar 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgTBPLvv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB93FD155
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461911; cv=none; b=mjTUuSdVhG5inudM4B2qZy5dS0+TF0SyuCcnQjSiqGOtyMytrK4fbqDrwQIIz+FeXLOPwZpkFxaQmmr8H6rhIq1hqzKUYuKu9MNtuRjQ+M/D0EHW27J+dKDBnLx9REdVeHRQgBba5/oJwhSXuGXWUGD1IOQdD5X7eL603++6k0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461911; c=relaxed/simple;
	bh=86Ziz7ZkTNiHbyzLt91Sb1neXW3jX6vu7nzwQeYV+l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IhH+C+Py9sznEfef+ZBI2/r+JcWAC24MR00NL3W3SLR/tT6IkTdBIsqSkL1ByxHt+Hharx+NnS+hKjJcjTqLbTlXfXzZMfctAL6TetObjbetKhHFG6aAwxake8oyzKT8vymkQNWKOxyD7OIvSfsxpsUX2oHHgEFhz5W4LuM8B2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgTBPLvv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6f306faaffso1612604a12.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461909; x=1773066709; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oQHoRaGFMus9JOapZuHMAdkvhHYxbOgXj0ogty6xog=;
        b=ZgTBPLvvB/E9c/wpakGx4G4URcVUumaJiCvZ9YuKgOKfTu1TX4kX5G00u21q5n3J6I
         MgA3/vH7b9ye/FtYcVenFiyokLQYKFi40u0WD86vX8aDT4hulxFqcpcKzS9HatNOPzBX
         jlM9Xxvnuu8DREThmS/mejHNucOV2KehcgBvj9rISnMdYn/IqqViR0+G49z+fyLLjrCW
         CUtYUFInX4eQxLWDVuMZUBNO2NCJINLkpnBSa8UDJQeUH35ZJuCKhtgmEhkUgSHE+j3X
         i03jSDLV0xAPjX7aydn7RsJjrYiJ2CTn9CMKMbM0N0RqW8299LG1Amrst8jdEQpT/5Aj
         p8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461909; x=1773066709;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oQHoRaGFMus9JOapZuHMAdkvhHYxbOgXj0ogty6xog=;
        b=BSFwQPBuNuuuWCFkUnrxfRhv2gjrj8G7FIA/nkBvbR7QAqrVsWyxocGgOjpPxLVqhD
         A6ZAih6NxQa80m2md8SC8X8WuRpOWvIg0gAlsgna0SUR8vSyHYvX47W7lYUtSMU3VQ0z
         5SCzGKhbN8npk9RAZ+53oJv7TbXFYjMYMixHlSzuFWW08/2FYbsNQwsLh9AxFxqfgZ/b
         wqbNN6iz+6bXXSxcu0aLAJmKshLhFH1k2kydb6P1RczFCq48/hXHMFwwf/1A6P/ohf1e
         cnt0rLlib8DqeB/2uvr7s3B6DKlApGFw6+ksn95/kH4UEZYnBjYwCG0cBd/RuH/U5Y3g
         RxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqACPdLbydbuw3GmG7lzL4y2Dc9pDmLsF6Vss6oIu3x7mIgo+BfThP6r8UCT8o+I8HReslpdmMuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZP8HA9gGN4fmDyFlZhyMHFBuAi2kExyTwSIuNX6NWqrYQ6OT
	Ytt30+ispDPQPNkSbOj2aqN46Gx7ZygqTCXWOoE+OUUJx1xSeVFgMJG2QONtaQRjJIE=
X-Gm-Gg: ATEYQzyOXoIHirPce1leckj8G5mWjqVFM7DAYlLLNGgA5fQC8s5qBWU9M9WxXS9Yzl7
	pAar3i6H6Jz2Y7EoVcP8bzKFh9mguWsl+2wz3ymFhWVk0CvXd7ea7MLWfAwFYgZr4G/5bSufltn
	n4dy/X9eWZFcDtka3Clwrm2CNGC2Oi55FHJqP7o3T1gOGiEN9hWBU6We4W0XKp4sdSmIPKc/LnF
	M5atN5t9ATCvGDSMItifxS+QfK711bv5Uq7UCXUJupX8joGqn3XGwd8L+BlegegPKq57ih+cIyP
	CQ9PG4PvRRRnsaaJtUnRGAkXbZIkl830PMjnXuUoAxjlBpJ24WMNLtKscM5QbD61ItoUUI8tADq
	4+PfviHU7b8xRwNCRF0uDaK/r4JIcnJlLwdWggek0ZjItBDpBn83ljNVILPN/awPEQUac+XdbIU
	HhjF9sxDcEhn1Qq6Zh4xwVcaB9P8hEDvRTAr8oHlMdU9UfZII=
X-Received: by 2002:a17:90b:3d4e:b0:359:989f:ab3a with SMTP id 98e67ed59e1d1-359989faddfmr407907a91.30.1772461909339;
        Mon, 02 Mar 2026 06:31:49 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4c92:fc5c:54e5:712e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359135ef1d7sm11412355a91.5.2026.03.02.06.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:31:48 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 02 Mar 2026 22:31:44 +0800
Subject: [PATCH] power: sequencing: pcie-m2: Fix device node reference leak
 in probe
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-m2-v1-1-a6533e18aa69@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE+fpWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMj3Vwj3TQzY4sUY0tjM2OjVCWgwoKi1LTMCrAh0bG1tQDBAh8mVAA
 AAA==
X-Change-ID: 20260302-m2-f638d393632e
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772461906; l=1302;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=86Ziz7ZkTNiHbyzLt91Sb1neXW3jX6vu7nzwQeYV+l4=;
 b=zuLSZMTF9biur1Ulrt5Rti0GuKMmowGC/J6f/52NSyh3skq6WPI+2GW69V/u3cI//WyCJp2NS
 KiLsaD4jwbvAMhDBpynEtND8VlhqB3euXEe0XrCsBc2JJvdAmiDKrU8
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Rspamd-Queue-Id: 37E9D1DB117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43425-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

In pwrseq_pcie_m2_probe(), ctx->of_node acquires an explicit reference
to the device node using of_node_get(), but there is no corresponding
of_node_put() in the driver's error handling paths or removal.

Since the ctx is tied to the lifecycle of the platform device, there
is no need to hold an additional reference to the device's own of_node.

Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index d31a7dd8b35c..dadb4aad9d5d 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -109,7 +109,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->of_node = of_node_get(dev->of_node);
+	ctx->of_node = dev_of_node(dev);
 	ctx->pdata = device_get_match_data(dev);
 	if (!ctx->pdata)
 		return dev_err_probe(dev, -ENODEV,

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260302-m2-f638d393632e

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


