Return-Path: <linux-pm+bounces-21339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF8A276B3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D413A2C84
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7F2153CF;
	Tue,  4 Feb 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMrULHvC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A9215193;
	Tue,  4 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684864; cv=none; b=g9iWUsZwpCbbqLkVBseYCkaX3g/Hv5h5Gx5IqOGl8NUYJBLhjyyH20vTmOGmkW8LjlGvhlirB/2ShMxtWWEu3cGZjIVy6ip5CQOh4q7hLj/ukaOT5ZQmVRtIY5znDAHcwnQzfkBgyt2VTvr80dnvCGsO2E5i6+N2AtgR3LaQaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684864; c=relaxed/simple;
	bh=7weosOB2tkJzFFCK1j2kvlQUUXPViwlIjKFLoG1vu/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seTZI+S6L2TkU/8ZUJNJZbYVPvNDSonalxTAp998m+HXrHKRqbqEQ3f2gVWa1d7tYrXvd/KOPlXZNxqQxMcggKJGPebSqLJEcGo2cUp3seruHEvDLemqQl2yWyrEdOkbIFTvq9Uv81q9Awow2lXjhkYBSDgfhDKRGK9C8YX4Zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMrULHvC; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eba50d6da7so1622853b6e.2;
        Tue, 04 Feb 2025 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684862; x=1739289662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rSvVS0xRSmkwB2ilC6LIMN2F2AJg2DEhA8U1xiK1AM=;
        b=eMrULHvCK5HnghdjIaxXbiD+cLh/elT+2TXobt/aWM7i/fbvVU5f/7ST9iu0tWPeP+
         HdttYrCzuXBeD5s7TbtSrsVVPRMeCzIAIUbIDDVxfWzPcQPAqg4L1Ph0GQZQYk9bHRgg
         2ThQQYeHWPIvL9p9ixRVv/xX6fHMbGolHqMlsA3bi5tEjsROEVNcEh5OfA7iCByhEiN0
         Wvz1PjG1lW0EZ6pQRWQmq0+IwMaQKGjugxIMJzQOdFNJ8Lr4uI+A25QYL4KCA9UZ1KqU
         EEp8RyDE0Lf55hqP8T1b0ohL9V3xE2Hr8WZ0dQFegJivtOjZ/RXy4RJsVPh9I2jpDCUl
         6xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684862; x=1739289662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rSvVS0xRSmkwB2ilC6LIMN2F2AJg2DEhA8U1xiK1AM=;
        b=PytG/SC3SekNMB59dJiUX1YbbmMCZZ2N17bNPsM7bTpTinjXOausdq4xHfOdWHpsOm
         I8crOMgG6242gcmarRNpMKPZmvcTn23EYwPlYRSlNgZbCVmDZRTeuol7T6EKaF3YclDF
         3WWDKkcB21WRLqwsRCWBco9b4LtKK4uPPIBl6GCfO/8VBWIwMNEA6d+5pubMdSc4c5U1
         yZ9/uoiJZ7pogaA12ga4bJyJuAC3dnrNAlHKSs6af4OlI4GBLQSU8yyPjDlxtz/Altt4
         +eiBcCSsjdniyftN6I/O5TPImwwoqFyB+35Wrfp6dpvQmo4hrDL6o17WlMBg4apqTR5p
         ma0A==
X-Forwarded-Encrypted: i=1; AJvYcCWrDbJVevsO/wfumnbp9TQt2weC13Nm/3Lo8YhUnaDF+Z834YmxTTSEfQATmHrQzzZBTPs302/OLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeGqHtV0O1ApPKF4y8JSOiamxyTNNZMwdtsxKHVH98qXbljYg
	tfylb0bVGD7s2xogocxHyrF75NSwwxOJm8LMWfKGzbJXBI6wLRv/
X-Gm-Gg: ASbGncuXJZQRRZv642yW063Wfe86AQ+VlTeQHPph7DrdqQZVGuopsOyVhFJgMu4eUsv
	BeIawErvK0gFE2I1qUTnFBKOmzisGU3spENqFxydwCBi/9rPyn2+FqoF9Tp0Vwar8laNcLVO7zR
	puJp/hkwa25E4jlba5aaUUucW4MrJ2WqPAA8vDn+HsvCmQ0WRk3Nk5GqCA6+x1Kop3V7fSuCHH3
	bPgbap3ncC2Saw5SirZBZRy3xXoRzqFBDRFPVROVZmYo1HBGB6T4bv479bYnXPsYfNjSnm33Kl8
	dMDoTjdTdiuft67LJnZmJJVAk/9T2EWCPAc=
X-Google-Smtp-Source: AGHT+IE3z8YgAXuefr7n/D2BdGgHaUpfeLviUWLi9pX/f/gVplrK/fZcFaRQf6HzqmNZD0k+ePy/Aw==
X-Received: by 2002:a05:6808:3319:b0:3e6:63bb:ed4e with SMTP id 5614622812f47-3f323b3d227mr17390749b6e.27.1738684862198;
        Tue, 04 Feb 2025 08:01:02 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:f8ca:b029:fcc5:5836])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365be86sm3039570b6e.31.2025.02.04.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:01:01 -0800 (PST)
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
Subject: [PATCH V2 4/4] arm64: dts: allwinner: rg35xx: Add no-thermistor property for battery
Date: Tue,  4 Feb 2025 09:58:34 -0600
Message-ID: <20250204155835.161973-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204155835.161973-1-macroalpha82@gmail.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
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


