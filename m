Return-Path: <linux-pm+bounces-4106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F185B68B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2622928A1DA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20A5FDA7;
	Tue, 20 Feb 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L++1ZMrc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC25FBBE
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419750; cv=none; b=OS2BuJrrJuoN2BSYR/9SJw8lpRbVFPvxEt+PWGf6n+tydToyxuNqh6Jgi7cqCAL6rWhNgqtxzn6G9NgSXrwq5oxUlAaTAlxYAFY+mknRHR9Yv2P4dDIhv9l3og3bx7QF3PnnQIxNGKgbe+oI13Jl/h0OiEcwZ+HwmDTWaSp8gVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419750; c=relaxed/simple;
	bh=KkdvrdrLCm8OQrPK+czFlLaYo1JrtJ3rNvWITsPyWBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L1LuyIUeOu7Jg4ehZa6Xs4BcFbvluYcmKDkItf//ujpWU41Ne0ST5jTI11wKItwb7dprXvFBd/DdvinLx4u8OT61GVgexqk6j0kyScS3P5rUSKjYKFVIGVYmFvTaNIWHoogQi+zx9I9M2iKOfm6zLTjB7WedVaOmWH3Z5+0tQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L++1ZMrc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a30f7c9574eso665212466b.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 01:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708419747; x=1709024547; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GySeikmcOETTtUkW23ZAy9xSze7pMX1co+DBAoFFtok=;
        b=L++1ZMrcA87+UCoRJwNqCkJS7F7NjPmFQG4LOmyo8au3KzMhVERSaypbb1x/ycszjU
         Y1Set/ojJWLeEbT7cW+MzEyvt2hWL4BW3b1RELOXZykZKcU2TY0CzsGzwnumjofquvgU
         LROp3az+8alvECAWpT3ADV19lapVSbGPwKaoRVwFW7dSnxOJH+RcD+fGMPpF4ckhDq7k
         ehjqGKaygEMJwfNw/4g8bdS5ANgdCRSqS4mAT7lMMaVHL2m1FQyNxQxK0SPH4hQRS1Gc
         w8XbzHEQcDaGPGIsp6/nA44jFi/5N5Rq4tC7Zcd7IXuxbsn+rY7HKp++AGx39pyXpTR6
         DPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419747; x=1709024547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GySeikmcOETTtUkW23ZAy9xSze7pMX1co+DBAoFFtok=;
        b=JTlMnC+pTZfMPzWM2E87rjDkRyZgW14QctLFSdSRT9g4Hlv/KlH+pKUWpbQtq9pfFZ
         Ujh0ymEaPsgSfewye223eYPBIl9tuagcYT/1ly/APzrh+dp0y/tXhyw+cKkrI8Tn6qHs
         ZZkJASZ2BTznmuLdiLbhmmnC/CsIDcfCMNZkBhKbe5LAspCuqMIMeUFMgEqc/R09Nofj
         m+tUEEc8U/jY024FcVWrwZB75kswxehBEOXuomdSE0QDs1eRsYjLZGxO4e98suI+Rv6N
         JuliuDyyH8oNlCLWpGaR4SRUTM4aQRoYfNZp0j/hv04OMkPh+dqc7TzHtIHwIQxZ3HQo
         rgsA==
X-Forwarded-Encrypted: i=1; AJvYcCUXneK96tEYtDnmYXdGH+wI527hNB7hvJMM3EjcbCO/7mD/vMd9G9q7yYx45PZiFUC8Fgz1iRijxEb0UqeFVzPeXP4AihNJPiY=
X-Gm-Message-State: AOJu0Yy/HethdDmNbiiKNAQJJMzeNb1tUT9+192/mjJpQyIyTFNIxhKb
	UXYBVWXfAf5Oq7JTLx+Vthnyu6gItHfGsOQ3lVOnyR+F0ZLaKe6JlPEAPAD5Y9M=
X-Google-Smtp-Source: AGHT+IGRNgfAmknQQNAQTmkYMX7dHuxxFdKG4tPqJyx65Xsqquei5GLgk/bTHagMZc1sLtAZLPPT+g==
X-Received: by 2002:a17:906:594b:b0:a3e:9df6:7f0a with SMTP id g11-20020a170906594b00b00a3e9df67f0amr3294880ejr.68.1708419746720;
        Tue, 20 Feb 2024 01:02:26 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id wb8-20020a170907d50800b00a3e9c4fa24esm1757200ejc.96.2024.02.20.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:02:26 -0800 (PST)
Date: Tue, 20 Feb 2024 12:02:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] power: reset: xgene-reboot: Fix a NULL vs IS_ERR() test
Message-ID: <fe1b90d0-7234-4e03-accc-69a119f6a7eb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_platform_ioremap_resource() function returns error points.  It
never returns NULL.  Update the check accordingly.

Fixes: 7ddfd33c6ee5 ("power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/reset/xgene-reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index 867162dfe7ea..b5eee19bac42 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -51,9 +51,9 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->csr = devm_platform_ioremap_resource(pdev, 0);
-	if (!ctx->csr) {
+	if (IS_ERR(ctx->csr)) {
 		dev_err(dev, "can not map resource\n");
-		return -ENODEV;
+		return PTR_ERR(ctx->csr);
 	}
 
 	if (of_property_read_u32(dev->of_node, "mask", &ctx->mask))
-- 
2.43.0


