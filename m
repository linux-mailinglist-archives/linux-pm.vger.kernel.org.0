Return-Path: <linux-pm+bounces-11447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB093D94B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E37C1F24124
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497E13C906;
	Fri, 26 Jul 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsmC0JAh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853857CBE;
	Fri, 26 Jul 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023541; cv=none; b=A0QZzhFN1TQivNfF2EPQNDM70Fg++iSIr8gj+yh46CcDMVcmjrsV+3hMHNc58Gcd4XtAy3NULbIFuwM3a+nkPxFBx7eZ2em1BgTmjBD/rR3hsFDtKDB4CgC9EgxdQv5NoPXfvRrUOsBHfIcm3aD9DzkAKNWPFUX8l6OA6kv7YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023541; c=relaxed/simple;
	bh=LFM9PFIR9IbGtOZpA6vNbeiXMowkml4+wA1Zh5gQWAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTHtQolvdFT8cUFYVn1A3/ofbi4Zu1jNSyA8Jg2cKWxE4XvwFTFgr+pycs3bA1E9Tsxx7fzn5unGAzP98fbPPVfXW8dYDyP8QZOBe/86yOKP6qwieYtXjD/6N6Dtbf32n6yKdWKFHZ3PdGDKs7V1ysRxlO4ysPf/U4ZILT4mKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsmC0JAh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-708cf5138b6so1020355a34.0;
        Fri, 26 Jul 2024 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023539; x=1722628339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6rmiAxGwGeB9IJv4k45WD7DbCveUNV1yEEf/83JRaI=;
        b=ZsmC0JAhPUnk9VOKXr3YD5KPvoZShsr4TC82BNZBK05xrO1EVAKWh9ARi3eByzotCd
         AY74Pa9knRIQz9psDNSZRSnsV8oxFNSS35Tdj+Aw2X/vDMAiHXhXfjodA86cU56kZaS6
         FlqLpV9aQulOflYnKtm2ZTvCNEIbfy0/1AvctgTKxO52bd1EmCfbHAywWJjFvZ1hBK6i
         4Dau9StrVvbTS8Jc2AA3vRurYOmWdsEPD77QS9qyFNlaaoOayAkzcegdKn+wHNMxWGA7
         t1Ii4TwSPAPA/0VCMQag4sYBWqi/NwilduI5tQJu7Eh6KKv4wwqRKBANf6yYZXOAFeU7
         p9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023539; x=1722628339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6rmiAxGwGeB9IJv4k45WD7DbCveUNV1yEEf/83JRaI=;
        b=gD8disPj+hHPgj6cFP2FT/vyic+j2auJ1rNQWxYTR8dRKSEVJ6MHaEN2uxOkgG9bWk
         Tkf0RWjNNlmbiXY9nbP15wfRA7JxjJWtMjNyqzud+yL03fZcneSl5iOmZMkefR1A8zR8
         Pk/H09cS/YczZO5YzLfd6rkXCpZJvCUjAB+ZYGOMtCTa0zRqYuk5bzEE/ihKeoehUF2m
         cT89C8dlljfSX+2dgBElT+DGDNE3wCNEBk7PNLR2cdHd44WyoeUNGlssYM8seu4JuZXv
         I/jLm4UCO+PNfPPton72oEr2xVRY2/auNqlcOBAAbi44d/3RV8WW+mX++K+HfQFXh9Ah
         oMgg==
X-Forwarded-Encrypted: i=1; AJvYcCWjyX77byetg5edMUTunRt8qf55k4Po4BaTNBxhsEQKQLSQxfgPsD50yEvs9SnpjYbngNSWhVJ2sGSrOZBsgKcv0XS2UW6aTcZj9g==
X-Gm-Message-State: AOJu0Yz3BMPIE94AGU34xx5hl3KuOjPpWwMmj3KaUupJg9GY4SH+MOgB
	EPUxkeJIONWQEEAEu8rYoiZKrpm7/hEwWFDxo4U3TrhX/PIiV0g5
X-Google-Smtp-Source: AGHT+IF0f29yKR6vZmoW9R2ZZFUMQXzYcT8J4lUuOIvw9i6Fucmn9tM77BX2/R1rNf1Ei5yrVKN1pw==
X-Received: by 2002:a05:6830:2aa5:b0:703:6cdf:461b with SMTP id 46e09a7af769-70940c05695mr890633a34.6.1722023539199;
        Fri, 26 Jul 2024 12:52:19 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c1f3:7caa:bc8b:ab10])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778069sm889972a34.59.2024.07.26.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:52:18 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	jagan@edgeble.ai,
	andyshrk@163.com,
	jonas@kwiboo.se,
	sre@kernel.org,
	t.schramm@manjaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/5] arm64: dts: rockchip: Pull up sdio pins on RK3588
Date: Fri, 26 Jul 2024 14:49:46 -0500
Message-Id: <20240726194948.109326-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726194948.109326-1-macroalpha82@gmail.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

When using an Ampak derived bcm43456 on an RK3588s based GameForce Ace
the WiFi failed to work properly until I set the SDIO pins from
pull-none to pull-up. This matches the vendor kernel located at [1].
I tested this then on an RK3588s based Indiedroid Nova and did not
observe any adverse effects.

[1] https://github.com/rockchip-linux/kernel/commit/b96485b7af46a99c14f3c4818eb18c7836eb809c

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
index 30db12c4fc82..d1368418502a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
@@ -2449,15 +2449,15 @@ sdiom1_pins: sdiom1-pins {
 				/* sdio_clk_m1 */
 				<3 RK_PA5 2 &pcfg_pull_none>,
 				/* sdio_cmd_m1 */
-				<3 RK_PA4 2 &pcfg_pull_none>,
+				<3 RK_PA4 2 &pcfg_pull_up>,
 				/* sdio_d0_m1 */
-				<3 RK_PA0 2 &pcfg_pull_none>,
+				<3 RK_PA0 2 &pcfg_pull_up>,
 				/* sdio_d1_m1 */
-				<3 RK_PA1 2 &pcfg_pull_none>,
+				<3 RK_PA1 2 &pcfg_pull_up>,
 				/* sdio_d2_m1 */
-				<3 RK_PA2 2 &pcfg_pull_none>,
+				<3 RK_PA2 2 &pcfg_pull_up>,
 				/* sdio_d3_m1 */
-				<3 RK_PA3 2 &pcfg_pull_none>;
+				<3 RK_PA3 2 &pcfg_pull_up>;
 		};
 	};
 
-- 
2.34.1


