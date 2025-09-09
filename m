Return-Path: <linux-pm+bounces-34277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEBFB4FF89
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEBEF4E3013
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1EE34F47E;
	Tue,  9 Sep 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnPfaMhM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C3343202;
	Tue,  9 Sep 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428497; cv=none; b=Qk3StAPA/PaQUJaiKZxQeJjn9jrRI6pERRLQaKeGt/5LNYERgfZDF5gFDB3e0lV5SZ+QT9cdkWF4AyEUwaLEqOuIOklNJGv6ud3ItzarU+Au/Zo2ijg6lLRKje/LTnDqnCnEr1mevAIPv4FPzjNGlFL4pfBv9aUoEmFKryE+iFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428497; c=relaxed/simple;
	bh=zoo0rTrZ7Bbf6PhOoVtuF27OU9CmyPGwhIXpeTZkIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGmDZNrllNsmRlmVmkhKotgjK3jVvI3md3EwWVHtJyvn24fB6+FXaiw6rN028bLoXjwmWaqxb0Mxhcu+RGLM9jpH7CC4fnkYDVlDxnx4RT8JzAZLf4L2/CHfYEQy+JgbSkPT0hdlQTFZ6IvaZYa/troJYAki8w4U63uKtdlblTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnPfaMhM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso5834383e87.1;
        Tue, 09 Sep 2025 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757428494; x=1758033294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM2i93cjK4uZ6B0Nc/4sxF8Tl1mZpTrnMm2i+RUoq+c=;
        b=LnPfaMhM45FKrexvD9Gq5iI36xR2EGMdO8af/8u90s4z/kUqgFi3T/f0DtyhKpcpmD
         LHHdbR0qf538G8whOgqnrrOpNoGdOYyQtEd5LQ0x55bHSdF/QqaWLGwE/QNIZ8D3wwpP
         Mtf0y9uNrBstu/Qiqg8SQURiDQxRJqf1ddJrZRRtWUwtDQoDIkA1Pg9HG3ObWR/udIGb
         EtA3LgtN8mxZAGnEKCNL9W3h1FNlnoFe+eALc+0w3EcCaOQIZnYWhh8ayQ7Nr7iJiQak
         +bZCneJq9u4HpR2rX+Wc7YkBTgAVlumYrX4ECNymyAdrAUdzRAPpMcxnnGQgSRlHriVO
         tdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428494; x=1758033294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM2i93cjK4uZ6B0Nc/4sxF8Tl1mZpTrnMm2i+RUoq+c=;
        b=wmiEjOiew5UtbF61an9HKK1kbUgeUUp5b0JqrxfU/8VAPFqsojKO///IuqTiqH9tWl
         loGqgoPrqXhMl4X3zpqq1dPbniOjUS1F7dk/Sd0DXVU/8MTeg1oT4CCHDr5h4fs4pOsV
         dFnq0LStgSYfMrHZhOPbjmf+FlD1WTJJXjxzup5pAn3k6K9BANwu0h8ODs0DEsFbjOvD
         ansm6sw0HRP3FIkFavxs9P65FEA91PvOid1+SV9BBio4cxgppSqwyc+oKmBHoZUO2w4E
         pAOhUAM3qhVUMEal38YwMv0K+xufCF7zzXoIxuHujQtjwQF0lFnW6oKHoqAQL2q365vf
         Qx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHvJp0I/tlQW1c5OdCprruIxbdcVoMsk4owg2ZfiKThSVgCMdE3o+stsIi29AUkOlIVUOB4gYlxkhLWr/u@vger.kernel.org, AJvYcCV8O+FG+MUl1ZozdWmMdH2etu37RgUjD1eQU1XyL0UxY1m49WAy9Ww6L/rN4+y9MmaGk6XNehK2fs9C@vger.kernel.org
X-Gm-Message-State: AOJu0YzyuPNcSokTLV7ncS0fzwvVQt5Ci1NrUB1u+0OrYqLyT7UFlKGA
	Sfe1SKpqyWcaeA+aVTXGhhREzuLs1jJC1B0PhmOq+14Me+zEaY5bJLLN
X-Gm-Gg: ASbGncuc8qarl6hBftEZBccEBps0yu8McO9KO5xJo8/QGFQFAUWrYkpJKS8OVCqZCyL
	X49F//CTRJSwYf3zYMx1sWcFfpUplvqkWkVDzFOg1i9ClwMmews95tTVcofewwaqFIt2/fX8cO6
	sAh0fHCS5GIh7+fkku9nzSIX5dIvu1BOeKwDumIfFRyTmvP5OHML4ztUWXIonpegPtWuVyhjH00
	8E8wmjg5KmHU6TH2UnsKtq8HNNcCx5D+doYh6G05hZDXJnuAhSwHXxSvT/lIrxPVUZuRCsUvObj
	mSAt3IDmhZoQxNFZ1wjj6TzG8qXeC/dXsXgzTuZSaWvGiBeWBB7znpf9xjRcVdycpQCly9xTMbv
	Ajnm1YRReaCeBGA==
X-Google-Smtp-Source: AGHT+IE12i0oNx7PV2wB9ElAkQ2BH0/IIKjJOUBRX4bc/9u0fBB5IiI2IisSWLW/dRDIBRoXoBA+Qw==
X-Received: by 2002:a05:6512:2288:b0:55f:394e:36 with SMTP id 2adb3069b0e04-5626310d905mr3442508e87.47.1757428493653;
        Tue, 09 Sep 2025 07:34:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56818bfc96esm548136e87.132.2025.09.09.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:34:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dt-bindings: power: supply: bq27xxx: document optional interrupt
Date: Tue,  9 Sep 2025 17:34:32 +0300
Message-ID: <20250909143432.121323-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909143432.121323-1-clamor95@gmail.com>
References: <20250909143432.121323-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document an optional interrupt found in some controllers of BQ27xxx
series. The pin to which the interrupt is connected is called SOC_INT or
GPOUT.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/power/supply/bq27xxx.yaml        | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 309ea33b5b25..bc05400186cf 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -16,9 +16,6 @@ description: |
   Support various Texas Instruments fuel gauge devices that share similar
   register maps and power supply properties
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
     enum:
@@ -58,6 +55,10 @@ properties:
     maxItems: 1
     description: integer, I2C address of the fuel gauge.
 
+  interrupts:
+    maxItems: 1
+    description: the SOC_INT or GPOUT pin
+
   monitored-battery:
     description: |
        The fuel gauge uses the following battery properties:
@@ -68,6 +69,36 @@ properties:
 
   power-supplies: true
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,bq27200
+              - ti,bq27210
+              - ti,bq27500 # deprecated, use revision specific property below
+              - ti,bq27510 # deprecated, use revision specific property below
+              - ti,bq27520 # deprecated, use revision specific property below
+              - ti,bq27500-1
+              - ti,bq27510g1
+              - ti,bq27510g2
+              - ti,bq27521
+              - ti,bq27541
+              - ti,bq27542
+              - ti,bq27546
+              - ti,bq27742
+              - ti,bq27545
+              - ti,bq27411
+              - ti,bq27z561
+              - ti,bq28z610
+              - ti,bq34z100
+              - ti,bq78z100
+    then:
+      properties:
+        interrupts: false
+
 required:
   - compatible
   - reg
-- 
2.48.1


