Return-Path: <linux-pm+bounces-22394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44FA3B3B4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5351B16642A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018E1C5D5C;
	Wed, 19 Feb 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxhzdNoV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212671C82F4;
	Wed, 19 Feb 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953723; cv=none; b=oVqBmfLYTM5SB645+NHmOb5VThudQT5RIvTMI/bHYgNdcUPbZJ+gEPSt+P93UsbAlnGGnSXswPXVk2xNKt2H91A7YyEgr2tIKzu7J/0Tpj7foSBRbraxThG0V3K5tf31VJoTzssken5VQMNEXFqgtYtZDHaLOMFIYir1F1Y8PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953723; c=relaxed/simple;
	bh=4JzvjrWls8MKSWJG9gzPifIffzcDoP0jfVQK+Hf4xX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDbNPNJPG0PAJ/YK1/VhoJygh+s5j8YnFvUMwtVmS3u9AB06w1Sat7DzT0mVTzRw0UKX0pcK0DwxESbxftXO9+/BQLFXxu0eWfg6rn/731a6tyGoVr4Ht1Ef8Li+6uw4OTO0sB2Jn+/ORXwn6eXZdtQ5ks4+IG5I8blSheVxJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxhzdNoV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30737db1aa9so60716101fa.1;
        Wed, 19 Feb 2025 00:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739953720; x=1740558520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzczu/KeE3eNkMX5hnweWTDCNf2r7BW02oA1kIbmbSU=;
        b=UxhzdNoVHXmfPIu6UErT4Q5TwayQzxge6CC8zhpimaqPiWCz9ARUQkB0vwXASlAQDI
         65QsXG539CU0zp0RXwrS9r7ki/YhV0fyrzmzYnRhnnaaG4Tz9DFHVX7PTyJLsDIM900Q
         5qSPkZPsOri1nwIy9Lp4gd7FO0TchjywFkzVXLr8/qIOsQ347dKgW/Fcl7+IIiNXX5L6
         BHuYLXRz8zwYWg3LzzxzukdEyCNj3hEIEmEMO513BlGTywMGVS0hxLQrNsOe/NDii9jf
         0JbjYDh81GJnyFLqgHJ1IPS1duDX98egjv5ffx+ach7USrdm4FuQaEPMYxU2e0c3ISU1
         3ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739953720; x=1740558520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzczu/KeE3eNkMX5hnweWTDCNf2r7BW02oA1kIbmbSU=;
        b=Ggh/AN85ZTZMVm8+rw6ED7FZ76/xoZQcdqaOfkz34BY9yH1kmeHZ+pNrN3Sc7XgZrI
         TZhEJf7rHkFB5cfNRDCtJ9pxiqmX99A1onxSBNKSWdePGv5VoYv/8eRG23wxuAYPpvBR
         db8SmdGbtO8Qgsyn4GwnFrLGPNeS20R3iT4C+tkYe+fn1NL+6CnKJzjI0e/+cJX1rj82
         SKtPKKHv/lHg5aZViMTjcqLCJwNrHr6Mv1Iee54q0KuF5yIaIppd6W973z5Rs/8Zms5Y
         vRJQw9lXfEGg8pwcqLcS3y3rSbsaffjFSR1Yt4WbTPnZ0UiHEyvGMJsP9VvMea5UK55v
         XI7A==
X-Forwarded-Encrypted: i=1; AJvYcCVTMDpdVkdxkaKkO4SkD1b1YSqqUsqnitCGeL1dbMTmN5RfnmgygB3kKkGveVmrsRds9wI1wbRmZZKg@vger.kernel.org, AJvYcCW7rMtnW116Mazb7WX8i+fIO8yIekfLXltnA2NEkemxlJauephFCdTExcqshIkLuqw6WUCDSyYYHO8mflhG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ip+lfWzFzcnWG59cNeGoH4sgnsDQYF9Rz+FoHfWPrCskRLXN
	EDYHn8/SMzvO+X1vrcodXl1wekQBHHViY64/BziDj3b2zzkhzasO
X-Gm-Gg: ASbGncs7jTVOGo4yLCIfwg9AWFb1BZLjNeZCAH3HVo0r/vYfQOq4HSKEMqRLcCzW/+8
	pwQcwX3JqByhBGmlWOoE1Pe4oNR4fmenbrJMLN3+SZBre6/ccadGDb3euCtXrOGZ4Q6WkrQDPlE
	GCENzSpDCND6nWOxNUzNuNRiZqIQXFs+bGelO6xNNOseSfWpVIXYjkt0KKpBs97yNdb9IGBfmtS
	X9fkZepWUU9K5W4hKGRo9nyBknIIgMMgEsaz0IHLvt8p25Je8H9PvS2imL0n/sbX85h0CU8Lz/G
	Ag3qcA==
X-Google-Smtp-Source: AGHT+IGye2FAZHsucHh4OJcLXHKm/UEJ2InJFf96ynQ3Aj7FuDucOiJ0+O1GWE1ItBmeYP4TcUTUBQ==
X-Received: by 2002:a2e:9e87:0:b0:308:db61:34cf with SMTP id 38308e7fff4ca-30a44dcd022mr7798931fa.14.1739953719917;
        Wed, 19 Feb 2025 00:28:39 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2699d0f5sm12645911fa.78.2025.02.19.00.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:28:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: thermal: generic-adc: Add optional io-channel-cells property
Date: Wed, 19 Feb 2025 10:28:16 +0200
Message-ID: <20250219082817.56339-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219082817.56339-1-clamor95@gmail.com>
References: <20250219082817.56339-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since device is a thermal sensor it needs '#io-channel-cells' to allow
exposure of thermal data via IIO means.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
index 12e6418dc24d..4bc2cff0593c 100644
--- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -30,6 +30,9 @@ properties:
   io-channel-names:
     const: sensor-channel
 
+  '#io-channel-cells':
+    const: 1
+
   temperature-lookup-table:
     description: |
       Lookup table to map the relation between ADC value and temperature.
@@ -60,6 +63,7 @@ examples:
         #thermal-sensor-cells = <0>;
         io-channels = <&ads1015 1>;
         io-channel-names = "sensor-channel";
+        #io-channel-cells = <1>;
         temperature-lookup-table = <
               (-40000) 2578
               (-39000) 2577
-- 
2.43.0


