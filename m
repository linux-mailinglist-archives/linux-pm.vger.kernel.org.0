Return-Path: <linux-pm+bounces-8109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E248CE719
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0B71C2230E
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956312D754;
	Fri, 24 May 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V8XIZtmX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739812D1FE
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561124; cv=none; b=Nit1tuJLlBAFR4upEzqtC8M5d02sznO5h0gl9ynwRtQ0aTFrht6LPfRA3SxXHW48APXXzUpZlWlWFngDgEf0brRT64NUz6V2cFI2jpbCPyLyNw1CoMVLshNKsYlef7mA0w9sdVCWrJR3xOqFr4HFw+kn38wYQ2ZM/xLCemQ1UhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561124; c=relaxed/simple;
	bh=mGHJTIEqaOM3rGni2f2k2W0qT+PA8lgJbBpgTIxC7k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et5zfrpFNkriBRMxX4ZqISETQx1TcfamUyGG19/XBwbluBQm3Na60Ur6Qi9kkdZl/9I1JSYzVUuujCoQVd6o1kJ7fOT1flMgi7rzsz28d63R0WPKQlA8tyowNxNsbO36qlBXzYvQx9yG+APqIYrI+buuCuM7aHkkyU+wve5ZPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V8XIZtmX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc46bfso71453091fa.3
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561121; x=1717165921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/1Ee6H1I4b4eaa21f1IZfthFOHfX8TRhLVEevdwWj0=;
        b=V8XIZtmXCIif/wk8caetPmdFoyx29DqFpr+cwKfx5KMhPHl8ymU/CCkuBbD4OLYqZh
         Tdxmh9LECY1R66vLE2C67avS54JiwgRQo+ynqnTcWai9sPxLjHtthbYfsLajATvqdqB0
         UqOE15EtlNmxhD7Ktq45e6dAF67F4qBDNDtJBsZ/XDA0BiY08P9kSrhm6OJZj1y0lMAw
         17z9Qisyylrbt60om8G8ZjH8tmxQMB+NB/NmNG4Yvxw+pt7cP2U/FCMjsx3SJwyOZS9G
         fzn22bQAbLRiJTHHWPeAlwp1uaUzpjXwv4sseocijwbjFhGYxLOVp+jKCU66pnlNnFLn
         WtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561121; x=1717165921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/1Ee6H1I4b4eaa21f1IZfthFOHfX8TRhLVEevdwWj0=;
        b=FyaHSm5sCDEl+L6xr1hMpsF6vzGQ2bmVpjGqln655CDVtlgenLKcwG7zJYUwrjrbsk
         jXNA2+acaa9q1PCJajjHdJzWbV95FTIxL3eJUKNG7Qc/DLyqHLdyyatkcUDN3xx18cMP
         ifg6YAtC6Tzdd1UFXFG8SIt8jcfXTRXAUUjpLP/0k6tQTDNltELg5pv1qpiJ4CSe0QOC
         /LipbYL9l5zvxRg5Od1p7cp+mif2vIE8RfM/RKPbXWsk6fAEBJhWKsrSEKdhwAyhRmlq
         sv2CykAAfvgfhnNOMi8GOnckrIQ+lC/o6BCev9x837OLNbkGfh7dw353EfLRmYzbE4zb
         bcTA==
X-Forwarded-Encrypted: i=1; AJvYcCXfOsFV3pZbriZy3R+I1ARUvFeY76jB8bnGVFiQ7qolDiRSMjkSFHK+RWRPGibe/aXGsTBezpW4bWAinON7QU9cTK0mykEvJHY=
X-Gm-Message-State: AOJu0YxIJ4tFXYqqqDk98hGFVLW6mjW2NSHuVmBXtFMTUrNMaoxcX+kc
	eY0M4S+VVwnVueHrxNIkF2bBA96E74xrUrKMhE8S6ZMT7LMXdV5wPKZFPKbL20w=
X-Google-Smtp-Source: AGHT+IGae8vz7FD8oFzDfF3fXF9u1uERG6J8NuAfN29z6HqiuN+X4zLPzr4PMF9xpcgrJ0L2NyAUgw==
X-Received: by 2002:ac2:4c24:0:b0:521:f000:5d1a with SMTP id 2adb3069b0e04-52966ca837fmr1547324e87.59.1716561120954;
        Fri, 24 May 2024 07:32:00 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:31:59 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 4/6] dt-bindings: thermal: Add a property to select the aggregation type
Date: Fri, 24 May 2024 16:31:48 +0200
Message-ID: <20240524143150.610949-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524143150.610949-1-abailon@baylibre.com>
References: <20240524143150.610949-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new property named "aggregation" that could be used to
select the aggregation type when there are multiple sensors assigned
to a thermal zone.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index fa7a72e2ba44..e6e4b46773e3 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -111,6 +111,14 @@ patternProperties:
           coefficients are ordered and are matched with sensors by means of the
           sensor ID. Additional coefficients are interpreted as constant offset.
 
+      aggregation:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - avg
+          - max
+        description:
+          Aggregation type to use compute a temperature from multiple sensors.
+
       sustainable-power:
         $ref: /schemas/types.yaml#/definitions/uint32
         description:
-- 
2.44.1


