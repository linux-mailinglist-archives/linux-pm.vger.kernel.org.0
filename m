Return-Path: <linux-pm+bounces-21198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E9A245A0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773813A6822
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA31F428B;
	Fri, 31 Jan 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvx0G/da"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0B1F3FDB;
	Fri, 31 Jan 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365447; cv=none; b=UPzSJ4Ydbdr3K31I1aZ/z9u0mzDraeAv4pNovXi9PCkN2J8F6T892fciBewsfgx4jdNUcKWR1bwJ2i9MvTxkjdjW+pa72z9MiFuvxQX2yvYuFVnFOjgc92lWW6ngp8ipkFt1XGs5fvROsBSvVtmrlfcSVixe6Qc0kVai9tXue3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365447; c=relaxed/simple;
	bh=7weosOB2tkJzFFCK1j2kvlQUUXPViwlIjKFLoG1vu/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H12wUM51c7nsSwVpt6XwIdfwAqIdkholF5vXckOoJQRLA1+bdtsL6GxXz2k6TxsgqYLch8th30In0qLkuocaVZUnjLDYNlxUE8nRJKElFcKqWE/vSscQz55T2Q+Xdab4JGFtoYeOf2vq5BDIkN491MO3i4cJUB5MuO4TZ+IQx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvx0G/da; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba347aa6fso1638956b6e.3;
        Fri, 31 Jan 2025 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365444; x=1738970244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rSvVS0xRSmkwB2ilC6LIMN2F2AJg2DEhA8U1xiK1AM=;
        b=Rvx0G/dad/pfJWw/M458DKI02+P3tQ1p9PLl7C/edM11C5vJFhr3gAPhrvoj7R+V2H
         HVARlD/LJ71PiNEoW6+JFx10hdzgcG/colPzz776nccX/Kza9bT5YOjOeMzCpsxjJx/c
         bjHghemhfKVJSxwdl+BQlsBI7NFfJrB1j4POoMNbXZQNPKwz/RL9Pp8oBTU1/f6BeYcj
         FGsQTbeftRqsYyoCqHwVsZIfVdt9Z+HblFFjzSsN1B9otcNwyvfy1nNRBiM0P6gQx5x/
         fHlmDuEOIuFKdKCp5CAynEY+mICnxbu5HIM+ViDQ1iUWVjiKoMReCoD1Dwutg/dkbN7X
         /+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365444; x=1738970244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rSvVS0xRSmkwB2ilC6LIMN2F2AJg2DEhA8U1xiK1AM=;
        b=b3XHxT+I8GUq5GB8bUmzNeG0qzbQols4RmYMGx8jVo0hgtGY0iIyjq6kx0gcGTwISj
         Q8g5o97PGVsWXxXOpI9rn5ltLOMNZcIFP9LUwWLvNvBaG/saqLFK8TvW/z5BXV1OsSD8
         eaKz9a8egzE2/LHgYyB1aefnthK0wj1eyMeaU/Nvg3uYCxYRbhthcg/S6aJj/3buVoLJ
         EHOSIUrSIOSawRpXp8/00XemNLbk0FP67MxNS/4DML2p3J87soghZJhUx5HpS/tv2E2+
         ej5P76AWyD8XLt1A0/FiI5pkln/yFoXc2pXEqUOa8CcHLq72CGrqLs8AnGSaRnbbMRHX
         1uoA==
X-Forwarded-Encrypted: i=1; AJvYcCVJsIxZPEn/EoyXEbqP2RWqipJRdOZw2uY6v8IOwN8PSCtfmY6pLCL9sXM9o0Wo667VrdddoNIC7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqk2R9W2nvu8ZZa2Jol3W4hiF+HemGrCo1fqglHSeDSsjtvVQX
	sAitxWrxJxmThO656CWCYorzuTJJ4EsC/Pdxs64BRp5Qy4D65yK1
X-Gm-Gg: ASbGncvwPiKMzLOLINz/XFAc4+jAWLyZ+pSds1tvzMSpoGWx4BoqjiweKzWTt5kPjAR
	CJdjdHsFPpo1d9cBqf2Vg7PXk5he0xKY5bpaY4dG1E+jZHMUmPOT8NeyFNbujmlgfrvE8+OMXk2
	MBqyUrwKHPyiqsCcQgOTybE8fTZOCdNaj8/PsuzNj4KoF0cUmW43WYod4IsYKx4H+bgTJJv+Fcf
	OO1sLDKxhPD6JDVdpoNzTqRVJ74lRIQ715WoRBmOzSMUDsK1vhtJAAHX387qhEz9KOqOXzHIQbT
	ZmqnukSUSZsKz/9vG/jKNk/i474wazaDd3k=
X-Google-Smtp-Source: AGHT+IH9EIO5UKi3zjTou7NgE9ZwpqTCVd5TQ3cdZ+Vw8R7Vh7mtJwLawupTinMPajo6ILkkJKilEw==
X-Received: by 2002:a05:6808:19a4:b0:3e6:580e:f12c with SMTP id 5614622812f47-3f323a3eb95mr9621264b6e.10.1738365444654;
        Fri, 31 Jan 2025 15:17:24 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d061:e6e5:c6da:b514])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365bf31sm1099128b6e.34.2025.01.31.15.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:17:24 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/5] arm64: dts: allwinner: rg35xx: Add no-thermistor property for battery
Date: Fri, 31 Jan 2025 17:14:55 -0600
Message-ID: <20250131231455.153447-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131231455.153447-1-macroalpha82@gmail.com>
References: <20250131231455.153447-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the property of x-powers,no-thermistor for the battery of the
Anbernic RG35XX series of H700 devices.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index a231abf1684a..0c89ccc662a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -237,6 +237,7 @@ axp_adc: adc {
 		battery_power: battery-power {
 			compatible = "x-powers,axp717-battery-power-supply";
 			monitored-battery = <&battery>;
+			x-powers,no-thermistor;
 		};
 
 		regulators {
-- 
2.43.0


