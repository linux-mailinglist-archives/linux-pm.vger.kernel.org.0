Return-Path: <linux-pm+bounces-34644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA20B57303
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE50189B8BB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32E2F1FC4;
	Mon, 15 Sep 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLTOx798"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD372F0C6A
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925228; cv=none; b=bMAT0aaxyXbQPoahLV4b5W4P2wQoUv4wuPa1hYy7hXZ79koKtBL9fG2HgMsZV+rQor9ozedC64HtdjKzbzNa3Aaai5xHdgSAr8kxrrX6DJa19LnGohCHPCDHmJU3YHjqXeIHM461k86W41k3kTc26AQUkeIYfGiqA1HqXMhHT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925228; c=relaxed/simple;
	bh=wucKZjXUVtRxrGoS9CppvLYgJwFvEG8gqGPWzlZGBag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBjwZRHfh76HR0+/bTzVu/x1DpGt/CbDi+fuOZypE2vbbs9ElCkUxAqjDxeRb8zUnxcXjbMVYa3/Z2/pmtlRpza6jkhrbVWxf9oSm1PPNdcblGCNSJtzPQUJLBMCOtiVeWzXnDpA44E7ASN5DLwvXi5ySZsgBlvgueqVrSmHnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLTOx798; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so4182522e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925225; x=1758530025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=ZLTOx79863Y9dBGRIyWS02ByXJ5b3dBO7796MWO2BA9YvYPYyrfqyKOgPJ/9O9jEcx
         sh5ls7fehOXmv2n2NgbYuj6zvE/6WlesqtRxA2ppoFQKhxfRvwJ9ywJ1trLtSeqmO5i9
         8rAzhG3em7G6C1rlf82Br1v205tdwLwfMqUF8+5MXsKFcMHRvsLqqeFSaAtyP+NhdZWH
         JwIrhyPLIX/6xL6SV6p8DoBm+nx+ijjeC2QzPBpeudP/7nsbB9/C1bxzWMTSZuKBVmdd
         ECkGS3LcnjuhKsknbC5fYIurpy211mPzM/S7nWiGEUwgrPfwtPglZrRSncoGx+SZk78m
         vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925225; x=1758530025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=dACqmVVXsTuOHeCTrtxI3Hr/vMBmasfgRS2U0GpayB0KHskUPLTqM+ykg3Nv9dYII7
         +x8LxuRXAtjshnOw3VmpW3DrDm9T4uTIWMR26IVMQ3sOYCAwVobJ0yXLsUCkPkRTq0YI
         ozd6FAu3B4Yz4yRhEKeWD05yYUrL1ZMSLLCNLdKciV5jyHchD6QQKTQr1Z+oUknW7hPF
         JYzbgmsq50I3JjgGEg3AH/qEJqOxZpTzTnk/Ulqhsu5JWRGf36iZrhRQr53NHcPM8Ovn
         9R/0+7AQoUddEVdjS3D80d59CsPk0CP5W6xkoNHsEz3zFnwwvJo/AQiyQfyO+XCBr0et
         Gvow==
X-Gm-Message-State: AOJu0YzCD8hLGZGo6P0Efz9qpsTCOvD9WSvS/IWc5eMv2LpbMPb/ndN0
	vt0bUy5FlECeA7LZo70GkNoWpQhKtBkw5WCyT8Bb5En0QbpL7HI5vCgISR46M5847c76L8jjBtt
	oVxrRAf0=
X-Gm-Gg: ASbGncsXCZ25+TWmThEqpsIGicj4aFxA0pqw+W19XHglkvyf0QW0HQMYHlHFqdPzi6P
	nHQnwx14eBXLLaI78ROeRIjtMJYqTWTlXdwPd+XUKRzd5/qr+eQ3qkb7Aq9r8o0kidbfMELhLsA
	gbZYWhKu4DX3dD3XN3HceG5FRaNwKtFepY2BXKBbUsf3cqEH2/c8kCvvB7n/KdhiWdQsikJzjDV
	hgmcpyjtX14uUGzgmfl+gZVeSzFfXh+BlS5rgtBMs4QfnL0SS6UALk3zxeuhAjtG6/9arLzCY3p
	YoJ0VVwwDms77CYj1jX1tL4l+OqUzm/0O0pxrdvIeJ4x+TRM56eLf3xFJU3zv8VgVBJYqrh6SBB
	KiP9E/1tQFoY14IMygNMZ9y/EY4tIqhK8roum4Bss44j+YyEhrb27xLo=
X-Google-Smtp-Source: AGHT+IFCaOIerdSvA+z61cnaMnc6f4/AxdvboyLIWVzD2Istbx7t/KAwnGHxWdDUQK//4BQjlegbXg==
X-Received: by 2002:a05:6512:3f05:b0:55f:3e4d:fb3b with SMTP id 2adb3069b0e04-5704d0071c6mr4042367e87.30.1757925224185;
        Mon, 15 Sep 2025 01:33:44 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:43 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 4/4] ARM: rockchip: remove REGULATOR conditional to PM
Date: Mon, 15 Sep 2025 11:33:17 +0300
Message-ID: <20250915083317.2885761-5-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM is explicitly enabled in lines just below so
REGULATOR can be too.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc665e94..c90193dd39283 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
-	select REGULATOR if PM
+	select REGULATOR
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.34.1


