Return-Path: <linux-pm+bounces-42658-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAeQEmW9kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42658-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:22:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C813CDBF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A675305F4A3
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85730F7E8;
	Sat, 14 Feb 2026 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djPGrhcS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41530DD18
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093235; cv=none; b=b7IOhuudX9CJZT03DDoANrx1wO3yeSesOpIGYjksSj5cL2vi7df3Z1e6WIGG/cYTB1JA0KZsrimurRbA4Czo0g5H0Dc0nf9W9CnvHy6fJxAMZwj6X5Y0OsWIHCcQfyZqow4YTNfE1sXLi/NUwAJ+lUOi8D8ZsLWebwDDnpyovp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093235; c=relaxed/simple;
	bh=r/8ZmvZDpyYTuUajvJSg4YeDXohAr8BNWTYEx/6FpJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSMnj2F3XEV8nFq35e5xDpvxmjR8X7GbiwAYBCNgmqTUo7+c0ict56zw2kiyKVNmYFmzFUZScnKA0HSFX1xXnSr5BcF4OEtaiTGzvnyxcQ+sVmdl3UcFjgKloYw5sbglXbLxy23oMO6dCecJZ8NjJ4sXLOBTiFU/GTHd0qUlt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djPGrhcS; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6e1d3e4dc4so395406a12.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093233; x=1771698033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQs0hMS3ix8i+/wRWb9Dj6VqM++U0M+jFLpORX82XoQ=;
        b=djPGrhcSocMb/tinOez9HXYLiC2YQ2FxydO9nQKEU6AaZIGFRwxEYN9THpVwO7k+7r
         9c/cMICs5tunEQ/rm/Ycqkee/PvBPzp+RkX4OHhvdEI4SAJ7HviJDD0NVsSByqeExu4N
         ++JlP0ZNPckvWJl90cTHxVXhGF80e4orPwcdcnQ1f9bpX92cVSbLVfEvKrNTsLCZxX+Z
         5/T5FCD3H06oOkrbfpDkIRkLxXukIlbPUFL8flaB0FBktJwsYtKua9+pAoVHtAKxxqod
         M6hWq9fBHKP3hml49oanJGDMFwtAMaVJeyDDHs0yfd9sRTQidStCLHq/mT/9a+rUFx7X
         BbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093233; x=1771698033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQs0hMS3ix8i+/wRWb9Dj6VqM++U0M+jFLpORX82XoQ=;
        b=K5g/1KX1DCT7f960zJt4ui3g1ZD4hqUoe5e1zH/XiFnfG53qsSDHDtxwcFeqmN5yHt
         3CgSRGcH5pX9roPx3/0fZbCAiCvgx3aouGna8c84+hR/TIglA1RpwMwasTnDNWtCVMiI
         tBM/N8X/RE3FUH9lGUeJyVqTmEXgLfmh2tjGtPPeRDIPFFTybKIhGvRAWWVqs92TtpQo
         3YRc5c2fAAhQEMBPkjAlym9WP+HXY8pPLj/BmBjkDS9o+fqIr07gQLHqRJtJeH1npYvF
         Y9sZtKjcbfztyFtvthjH74CBU4xd9d3CJkWe2WuiA6WOv77QMAVz/1oam1HtfG6jPOzR
         qZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWT1XVktDpqiG0r3L5feFqXTayZrpmCg0YU9ggXAxL8bPtfFkeMW8WOCL7/3d80v5ZsfGznO/5v4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF//gEAaIFXYA0jibr85sV3AMD/yVWHm1Fq//lptWGv8y0YKL8
	+kkX6SbF/xgCsHA3d4F9/3+QOI2pULL60WHn700+SKJv4LQOSKS+Zwrw
X-Gm-Gg: AZuq6aL0ArtoqctsvShPLTfK2LmLyCipZAV6gwe8ut40FTU2cadsnvXGlJy+tQozPbm
	nrd5hpgSL2eK7KqlZTEyQMe0RAszSbef08PKAgowRDdCdB/GoCXkPn/P4VIakyRR7sgHYVQ6Jah
	qPHX1eWCJJ75/tnjiGGRAifD5q0uRQyci/X1TcTQDly4y05i7jSejNJ95TZce2hCd0Lcjf9RJp1
	OwupdZDlVqRyfAh0lfYa1ckW7A0ko5P+Ef7EVxR2ituUZvLfqGg16WWPYk5O3/lld168g3sWEjB
	YzqiYbHpTwWd9RE26VaBm6RpHQisIkoMtPNgU4RB7K0Ua3rAEqn7WVj8ke0fNhbr4MwPGaZP3jV
	JwbVrEp11DEEGEvaWl/+/NLRmWI8auVKuTgSUUWFI61P6I5IMF+/dJ44Qvam9havE/xnar4oudn
	nDMpiGwHWNRtJIqzPkinM=
X-Received: by 2002:a17:902:ce12:b0:2a9:3211:29f0 with SMTP id d9443c01a7336-2ab5063261cmr51537235ad.58.1771093232858;
        Sat, 14 Feb 2026 10:20:32 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:20:32 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 8/9] thermal/drivers/exynos: Add missing drvdata assignment in Exynos TMU probe
Date: Sat, 14 Feb 2026 23:49:05 +0530
Message-ID: <20260214181930.238981-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214181930.238981-1-linux.amoon@gmail.com>
References: <20260214181930.238981-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42658-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 004C813CDBF
X-Rspamd-Action: no action

Add dev_set_drvdata(&pdev->dev, data) early in the probe function,
ensuring that the driver data is properly registered and accessible
throughout the lifecycle of the device.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v8: new patch.
---
 drivers/thermal/samsung/exynos_tmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1d657802a310..47b92c84ae98 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1070,6 +1070,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dev_set_drvdata(&pdev->dev, data);
+
 	data->clk = devm_clk_get_enabled(dev, "tmu_apbif");
 	if (IS_ERR(data->clk))
 		return dev_err_probe(dev, PTR_ERR(data->clk),
-- 
2.50.1


