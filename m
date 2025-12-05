Return-Path: <linux-pm+bounces-39251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCDCA8F77
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 20:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75BA43022889
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DB285050;
	Fri,  5 Dec 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5DzquLf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC242D73B2
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961346; cv=none; b=Co7HijhhiZkKzt9BhGnXoiZtFHtLX+EBozFX/u25tz4TurGBgZR3DXNp3QZpY2D0Dp1qnlSZ3V1TmOPogr0KQ6uTM/RBGWHtxBmmEu9GunQi+rNAmtltbvT4siSXvs57rGIVVy/tgn1PITEPbaMAu62Ufen1NVH937QVHJKdtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961346; c=relaxed/simple;
	bh=BZ40Qr+VCK0a19X541gPydfySH8VknjOkzRAW0odqYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UT6yWl0rKAiyb+um9Znt+oReFYbmS6feEJOaZYsnGEQsXfIAiDUdfYZhPigo0TTyRsOfWZFNOk74f64XY+fO7uUYOJcXiNJHVbD4atV/TgB7eW1Yt/Xwn2OdWjmRAOTgJl/6+wAuKwdpM5oAdJNp4y7ZRgkvWaYEEZuMWjilcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5DzquLf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34101107cc8so2152325a91.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Dec 2025 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764961345; x=1765566145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVgkDGLlp+gBx2zQWaI190FEJKwlN+nT2HtV4xsm0D8=;
        b=c5DzquLf1OB+N9rmAFgTdcrBh0MQR7Hq7NXNY7k1QVA/Y1O27pgcNnr1ucgQ9cPdqK
         ydLRzdJJtCZ0ITHoP3UjCarpwTTZ5T3As7grYnC3/zuzyMEc/V6Ew3x+aNgmxXXLyIBG
         pZmJm+Ia2kOxwF34nfzokq4gIweyb2TyHYJfOeIlo+opZJLlYxoKPEOEqI37tlj/tkqe
         f538J6OK/Kh0Ek8p5Lqsx3STfNk/m8pVPPe2/Tla1WiPCtg/N2EOljR/WPg0vUkmPaYL
         h4n4jcqtioXzc3/Uc8gKEZe0yfngnynvMHfqRzBnS7ojo8vOmOoWwfMoOMbUS9HUYGeM
         s5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764961345; x=1765566145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVgkDGLlp+gBx2zQWaI190FEJKwlN+nT2HtV4xsm0D8=;
        b=NvpfRgeSW2pRlaZz7iW1EwOSVCNgZrZqZ4eOMak76YA+wyeZe8FDQLgmUtX9KaALAl
         x1zTUgiLhBneWyLs/h28n4GPs2W+iRq0+I/JuYEXaRf9LIJZGsqhCb7LZ3pYytDEdp9T
         1UYVwFpORdtEmgNmmc3ZYYxwLI3jJ6fO6IMFiuO+slPHQam/YTeaAucMmdJbbIkZHvPG
         mLJY1nICj5hlggLNW9ZSYJzyuKZydg7++jAoDzIqqmw3jx15shZNUwcJOXx7Umn93B1a
         DBp4a+DpbsejdnZdRVblXWY4GRiOIQha0Q5ppU0NNfPIYD9NlUDpSggqTiRaf7upIxvw
         Xc8g==
X-Forwarded-Encrypted: i=1; AJvYcCXxdRRS+xJRijbeBJ7O4v/y3v7+u59kPBoul+O6qfvcsTK1UvAjEkmphObpSzbfzCy/Mk9Bc8pI2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwixNDpHrDRK9jSz4VsJazFDi7ANBYCVWAfoeo76uVpTa0aEUVv
	6ehUspk/304GY5VEU737Uhh+Nl+JIpX/xxxEJhD4lZZEAtT/FVwpraMC
X-Gm-Gg: ASbGncvXD9QjFKYRCfqxvW7RnA7rn8uW20hDbSZuR+tWkYRXkKdndTaLPNrV7WHgKdJ
	f2fm+zFGHohKvFH/gqVRBGkp9/jQuJkcistzwW+VnpNzXOXLLI2PhE2IahXS6aMJaPeQHGdBmNY
	9mxjSQyfGZOK7CjwtIxscY5bDrzXooDuKEqajIhlOPaUGz33HQ5EL4ayfbVYYHjJjINZeZfB85n
	XSvh/S353UWFAiW1qwRvmmStASPJB7+JBFjx1ZKNTv64uxHvHXSTJUgxnN46jiLAVAk5lRU3UEJ
	rCKLJM51jpsDlynos7mH0LXYV8Pj62Huqa+t0CmFbqjNJA28sVp6YRh2IvFgNHiGdpLpRvRYJ34
	rERGmGSGPh3NTOw11jLgFW1wzwuslEisVVZq/Mu0OJVIrMESGJnNBP6z/PmUn8m8199Yv1jDEk0
	3vnlZaXqmwfz0eW0c=
X-Google-Smtp-Source: AGHT+IHRnnUB9BZoTPQGE/aH5IPRU062dEZHTF0y6Fy2pggR9iHt/qtwWzkxg+Yr9YVd/3FxsMtvXw==
X-Received: by 2002:a17:90b:4d8d:b0:340:f422:fc76 with SMTP id 98e67ed59e1d1-349a23f7b44mr158083a91.0.1764961344665;
        Fri, 05 Dec 2025 11:02:24 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:e515:8350:8116:2469])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f2e43d9sm5169439a91.0.2025.12.05.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 11:02:24 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: fix race condition in register_control_type
Date: Sat,  6 Dec 2025 00:32:16 +0530
Message-ID: <20251205190216.5032-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device becomes visible to userspace via device_register()
even before it fully initialized by idr_init(). If userspace
or another thread tries to register a zone immediately after
device_register(), the control_type_valid() will fail because
the control_type is not yet in the list. The IDR is not yet
initialized, so this race condition causes zone registration
failure.

Move idr_init() and list addition before device_register()
fix the race condition.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/powercap_sys.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 4112a0097338..bdc65e040d17 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -625,17 +625,22 @@ struct powercap_control_type *powercap_register_control_type(
 	INIT_LIST_HEAD(&control_type->node);
 	control_type->dev.class = &powercap_class;
 	dev_set_name(&control_type->dev, "%s", name);
-	result = device_register(&control_type->dev);
-	if (result) {
-		put_device(&control_type->dev);
-		return ERR_PTR(result);
-	}
 	idr_init(&control_type->idr);
 
 	mutex_lock(&powercap_cntrl_list_lock);
 	list_add_tail(&control_type->node, &powercap_cntrl_list);
 	mutex_unlock(&powercap_cntrl_list_lock);
 
+	result = device_register(&control_type->dev);
+	if (result) {
+		mutex_lock(&powercap_cntrl_list_lock);
+		list_del(&control_type->node);
+		mutex_unlock(&powercap_cntrl_list_lock);
+		idr_destroy(&control_type->idr);
+		put_device(&control_type->dev);
+		return ERR_PTR(result);
+	}
+
 	return control_type;
 }
 EXPORT_SYMBOL_GPL(powercap_register_control_type);
-- 
2.43.0


