Return-Path: <linux-pm+bounces-34555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD9B551D6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2738B1887E89
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791B30DEB7;
	Fri, 12 Sep 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSULSN5f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7D19D8A3
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687460; cv=none; b=ebfWYsxOj0DoJC9moN3J0BIg0S6MiRog7O5y/0/kVgI1Gv4qnb8ZaxzlI03G3J634QHZ3m5sa0st7VFJ/M26BNkrt0bvCfpNEhEhBZHb0oVwvQVNZQSUiaRBPsRpflKlZaN7HUYDatordYYEdQzCi+niYW4c1C2eNyrg1GQxmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687460; c=relaxed/simple;
	bh=wucKZjXUVtRxrGoS9CppvLYgJwFvEG8gqGPWzlZGBag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gW2It0Rahtghwi1brBk92SVzE/1HJ04GZnRBdVZFQ+dtl9XjmE0O9LcGRTT7Wuh59P/8rUjV56m0NoSW4mlM00DRS3JUIF3wzs9H4jHazop5Q5/rRJQr1koAgQXQCSyS4CAG5QK8l0RejhUCG9aES22Bpk1b+djMqSc0Q+0HJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSULSN5f; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-336c79c89daso17200121fa.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757687456; x=1758292256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=PSULSN5fQEZrzG3AEkIAZty38UMeDyZyA9dltEdJUV9lEDSj7xa824HwTQsKe5OLFn
         nDx8hdbTlIIIwYmvI4rnoSExWtFmq3XXfEIq6N5MBC/fWRU8l8039iQWnh+lbZueo83P
         n2QqZEUqqZI8szY2OwwnaPHDloRAzE3tRiphOt8C9w+1KVlwn5CCy4EkwIHqnQ9KgzLl
         5/rdWmZPeLWdYIK8eS6CRKfWjsZ1mtPFdAv0y9O5aT+VsT5GtJ1vS8VBb+4dHXyXJPU9
         VEtpiSdWEkFWpcIE8XTR+AgYjoF/Hmfb2E7iwNbZPkfdaimnTHBSWmccAfwLBUAuZFD2
         0ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687456; x=1758292256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=qlfAUUr0lCKzYgl9dmgZcJIn4lWfyep18NXTJjBfo+dOdqs9Gcla2P/8Nnsdh+P8Is
         ax7NXT8+bM4peYbI0Q9Gcg9nnAVhqEDFMWFeQAAzg7XCLYiHOpP0jbaczMrDpUELlaZx
         PWOs87M2GKurtXsP8xR92lNgWoqwRya7vP5h198wMDC9B1Wcwx72Z+wKfKvyouaxsbYh
         tbZ4demx5OporxUPb1W+ly5arjZUtq0ivOkw57071Csc2sKvEbtBkGSYSjRweIbsd2X3
         roiLZqXgBAyg3reBqDOsujgjK7khgEjWSrxzRaVZ6iOmE8i67ojH0or0W3KT+JUKGstU
         uVwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdocQm2wLk1m3L6Rg776rU6MP1gFuva5GncOFAeMdI9HrKVwCi/YSF/tv0MA6xwv33q/hWZXqj+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbQ+u4WJHVzZ+ETQUPTGJ1j9FtBvNOkYSEKiWl01TaDVXoFcY
	PbQoi0ThFnKl8rE0kNkG/4qBFAKUCmxEqaQ4N/Fj+Wfls1j4dQqly40vP6I4x2BSN6s=
X-Gm-Gg: ASbGncsqjMkhhk6xoF89jGWLnnMk6aID79LZPjOLcOzsUnP58ro/AMYZhAYeH/7/Htv
	2wJ8JFa09nqPog5TBLeut+h5I2dSc8gnH9zzLQeNn6zR80ZHfuFBvNdkz3ORMZ3O9kngUp59mNU
	WDo84i4HEk7L1ohHu3OPvhUSm6k+bnKX0sMex3nBaLRjtE2g3PgPOwUCid5MbVISqs26FWg5fag
	RpEQ37Y2x3cx5snmKNFF+u8GDRsMu+Zhnn6XiVzIaR0CFUz5EAuyBis9BA0bDFHAeybbHyd7ykt
	xzxIyV7wsjCm0tpEYu8HztvYrIxEXXFRXvI2u/Gj2yldONzPoQfhC/JFgSSL/ZMGMnmOp+wWUrn
	YULYeKUaUAPcz1+0YVwLUfePdHjAeT+wZqHkT124f0LxICsA/0uFgAlmkY6FlUEThlA==
X-Google-Smtp-Source: AGHT+IEVbatrp/SxHPXDJ7XzOlydV9X5r4NdpCXVehaL+u52W8sQ2+DoFuN3K9k4u9FvHmP6U/Ibmg==
X-Received: by 2002:a2e:bea6:0:b0:335:4d0e:9493 with SMTP id 38308e7fff4ca-3513fc380f1mr9860391fa.28.1757687455991;
        Fri, 12 Sep 2025 07:30:55 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c6ca914sm8495711fa.67.2025.09.12.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:30:55 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 4/4] ARM: rockchip: remove REGULATOR conditional to PM
Date: Fri, 12 Sep 2025 17:30:36 +0300
Message-ID: <20250912143036.2844523-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
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


