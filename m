Return-Path: <linux-pm+bounces-23305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8BA4C03C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7E43AA2CC
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D321129F;
	Mon,  3 Mar 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgZnVEnF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07420F09B;
	Mon,  3 Mar 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004530; cv=none; b=HCAqzaKbdw78kp9MH0qbHS78gLwUz6yrUbJTKwoTrlKsGs5pUbxYShkCOxjAOJodMsPn8BXHE8Lvg4cuYGMVnTQm2Qg58QfSr9L2ZpPi2xEkGHAYRoMv13cR9i+QDx2N7alaBvPfEu1FAGzWQtX5qMcXaMGT34EO/p52BuN9q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004530; c=relaxed/simple;
	bh=3P7plyntZFcl2TvumIvg1gg+MV5fPPzYZIQsPwlnySs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ4CduYRugd+9PaFya7CinQ3j8t8o1Br4mwOi4PCc5hw2Bc6n3SrVzb0cXNPniHGsH3WUgOG4YlltP0O/rXWxfTr4YM9bXIvFthdxNULeflOC7t5eQ8zu42doTNKF5DDqRCSfGbTNgg/ikiyDQr274Xmptxb2ANCbCJt//cA/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgZnVEnF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54838cd334cso5151689e87.1;
        Mon, 03 Mar 2025 04:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004527; x=1741609327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKcPvNO+XMSYUnpyn2o7+FoGqwTbIxZBoY9y1RYbRGE=;
        b=HgZnVEnFIgUeyUwyMGQ+Xs9OrXpry5CgmVPrk9khjDcj1JRDrse6AYf71LrXigtrUj
         i7F9aR7J7KzzWUd1MY1z25G2bofEDNyO5SlG+re0rtXGwOEvBota08mNc1D3agsOnisT
         PpDmuLHxCgCpLsClDoKXdsLwluiP1JmK5PKuAoxq4SdDNDi60kb9I8WtbJ/ebOLrtfXW
         dzwDwju3Z+9wv1pPEXhNiA53Sb3xtQbaBBcrVUazEQ4JFs/FeRxo99gNQwp1nfWnqS48
         AV9ScgpEXDWJeEP0QcEc7iA0C7l+XeWlUkx0ayc23bYKPtzDAoGEWOycVpYrJA+4cMP6
         Sz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004527; x=1741609327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKcPvNO+XMSYUnpyn2o7+FoGqwTbIxZBoY9y1RYbRGE=;
        b=XhKbMtli9XNb61c51I2JzHemUQ0S4lni8v+N9+aVPGItthaFO3tdy9Sq+Yab62ltvw
         l91S9CZhs4Q4tttBQeMlcBXQHsvHT9IH4dlrjJS9nok0RHCSZnnsJCcXNBlO+Es7mRmg
         8fll5TaFDRxvOf1wNH1UbcQsGE8ZoN2zYcGlLSr1fq2xb9HqrGM8p+j9JWtAamRwZ7oq
         lSCUqSBcqeiTwKVUA7KZUnVAIAmvkixNfX0YulaJIiTO1zAYWLRjHva/lCHhZ5DrKSgM
         rayWfPnvbZuxcZ025lDPzRLw+ueC1TzJC0ZL8OoOwR5/wzqcliyxtQkvGpH6cUz5zLtr
         gEVg==
X-Forwarded-Encrypted: i=1; AJvYcCWKhWDFtK63wYFTHCeiLkUtdJQPDOmG+DpZxAfAIhz6jJ3oitT3RMlZc/UMMzqVneRaJM+/vDfDEW1b@vger.kernel.org, AJvYcCWsmXH0OLY2VHoARfFWzqa7to/oedGc3faN6UrtRNHODyYU8bFuX0AORxMcy0TuXZwO2E5UTv7SDAOilXBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGFJwLAcrhB4T885jjU5VNOUAh1EjQRBoFifyL/E91Xuug+J6
	TA0iS7M1AiV6XmdCipTOQkP+z0GExI0+y3Io4LfccghxRvQqRJ8Z
X-Gm-Gg: ASbGncsHelJiHrPIzfWTWZ/OAyiZJ/ghGOxb4yKoMHxjfTcmLr04kFoIvtaNpBNB00l
	S4am3X3/2aR1mOUH2T+wU2GTWVUlFG4rgxGyIV18+RmI5zdUsHyKgKR9EgJlE6EAvzvnJ6B3tY1
	B8idGrl9lgzgk4Qu7fW3yJuY8JMsOZjBZi5P9jYJHlqSMBWtLJbpVs/V9Xh09ajiMqewZdGCzzi
	4xb6NegzA0x/8Ltk+PP1ZNhywmzb3rfqpwACDn9IfhVE4NjfkIauTdRg5TU9wgsJWRiXL21UvY/
	6/eAYqmaMp9SWNCR06VuEk9WpYbJwlk3iZs=
X-Google-Smtp-Source: AGHT+IHWtPDKpHupjft94sSLR1zlyXRW+3TSgQROpvRsH2VJWhrlZkDu//jnxvTGOSOEBQ90KqHuLQ==
X-Received: by 2002:a05:6512:3d19:b0:545:ea9:1a19 with SMTP id 2adb3069b0e04-5494c10c72bmr5744120e87.5.1741004526999;
        Mon, 03 Mar 2025 04:22:06 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b868766desm13486611fa.100.2025.03.03.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:22:06 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: thermal: generic-adc: Add optional io-channel-cells property
Date: Mon,  3 Mar 2025 14:21:50 +0200
Message-ID: <20250303122151.91557-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303122151.91557-1-clamor95@gmail.com>
References: <20250303122151.91557-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements a mechanism to derive temperature values from an existing ADC IIO
channel, effectively creating a temperature IIO channel. This approach avoids adding
a new sensor and its associated conversion table, while providing IIO-based temperature
data for devices that may not utilize hwmon.

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


