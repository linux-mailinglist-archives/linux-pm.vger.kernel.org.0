Return-Path: <linux-pm+bounces-21336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF64A276AC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648C01883FFD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECF21516A;
	Tue,  4 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAHFxNBI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E85AD2D;
	Tue,  4 Feb 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684862; cv=none; b=UWg2c/1/v/t6NSVi5gzR2qRrf2qopswI0eLwUmo5IRgC9aKPESka68LPdHgCbtCOJ9FBWqbfbz7k0HmjQSu15A0upho+T03yi1PSS56h6TvhyGNqmHkt6tfWYge02W6tw4zwBY+vXkc1F+agWgOMZH2E8Ub+3u763FPEco0NNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684862; c=relaxed/simple;
	bh=Zw4geiqrec6cHDyNVp5ah68FGJHispIhBZyciy8rD9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6wuc75OFo/0BYxRNdMe7uSye5sKCq/LdLkjTQl2hMdKcb9ZpLP6CygamlNccQsnbPpyza/ei8yLjglKtxPetTtA2kknR6bL9qFBuuT/Jqx4B/gUUigHQFkb9WgSk2kzwSkAec1O4nK6E4JelsO0P8W1YqettsaMcnSIs/knp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAHFxNBI; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb7f3b1342so2807434b6e.1;
        Tue, 04 Feb 2025 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684860; x=1739289660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHlljfy889XgONy8L5QfUbtDDGX6j94H9380ihQ7yjQ=;
        b=iAHFxNBIfJZuTxVc/WkyDv7MVbTXyjCH9Y6RY16ybI7OVzfyvYwIJCCdxbcfGtfOOA
         qYKeNPoNAdqlsKT8x8OAR8ood5PCkdXBqkjkMC0MBL0mY22cV8M+xRgHjajl4GukAD/m
         rNKPPWYrD2qeOK5tpkg7aWp+lAs0BHEHu7GZ6GIfq5YOlWjNJml2UXpAV9PCeCETs/L9
         7SWlscJdo0R9fAbvgbljyRssG1oz0XV3fA0X/gdTAih0oHNmXADg0ky/gEWhkrh490oX
         B1mSleJF2NdqpeX6qwWNnF/+WWBIfzezs3jVBdy7+nVeocxOW95esOol/i7JoRByMZdf
         nSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684860; x=1739289660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHlljfy889XgONy8L5QfUbtDDGX6j94H9380ihQ7yjQ=;
        b=hh32Oo/OmDgEdIhrhf+r25OkOGSc6tSg+TKYLlNcJ5GP0XEnzZJMzJNe0E+7vz85Q2
         B56UDNJa+8L91psZEVR6KiA2z/4AFlg66r4OwVUZK8NMeLlMrlpFi0guLf4vf+cn9AKL
         LgH54+GnQEiwL11ANRXMof2k6N+/TyVPVKGQOPMRGNGA9x/NZty7Xxh3O2pp0khh0gvS
         VT0a4jZjFGa5BSIhdLW4/6fV0x3o89XkLUqy/V5d9lOOIShfMwK6BojmCRDhpY+AySF1
         GdDH0PcsToipJJd1eBneIrhzMaS7q3KGKsIkC1xnLzkKKxTf63eJtvfYFhog0gl15TQY
         hJoA==
X-Forwarded-Encrypted: i=1; AJvYcCUH+RzXvfeCALyqB8a7c5Ho9eHgNOKoM6lfWa5JhjASAaR0hYALSqPsDvRg1UdwNQpGWOIghxodiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/qBSISLFq8XFKqbR4YAhDBeahEkX9MGkaObiJA7QoyPE1V5m
	TsDX6rWWlGjzZTKr1ZAipnEo+/fPeOq8GUsV/mKIczYeMlDr2Y77
X-Gm-Gg: ASbGncsdoHuu22ecbP50sPppJjgm/JA+DXYn1eR6Skl8lJLngfXnyzg0jDgTgNUn6Jp
	pMwwITpgdeHJlkiPaykFFx1/PpvWdoEnasEOmhUvO3wV+mU1xfcP8PD2L2RP58EWu9Q7w2g6heC
	cAhrdPjRJIWE60RMCwMR6DRhtO1fCa7PciEHdGZeWylMbg+G5ucRCKYd6vcSC6YRWh05fasg4AA
	S6tC8WE69UE5EJzW5SiSRAOwgWHMRm6Cy1Q3kw5BtdUWygHy+MJCtFKNtfrZHTwexCQHdL1HoEH
	2sAx4/ICrbMe+sL+hH8tv+LsVpnYa1BvnqE=
X-Google-Smtp-Source: AGHT+IGaIZAPvAttTrRBItEFWc9qMjMXZM9Cgd/5fO7zmh2Rf9f7b6ITgUhhswhFOvU7exbhdKvtSg==
X-Received: by 2002:a05:6808:1793:b0:3f1:b153:3105 with SMTP id 5614622812f47-3f323af0374mr20723191b6e.26.1738684859999;
        Tue, 04 Feb 2025 08:00:59 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:f8ca:b029:fcc5:5836])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365be86sm3039570b6e.31.2025.02.04.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:00:59 -0800 (PST)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/4] dt-bindings: power: supply: axp20x-battery: Add  x-powers,no-thermistor
Date: Tue,  4 Feb 2025 09:58:31 -0600
Message-ID: <20250204155835.161973-2-macroalpha82@gmail.com>
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

Add the vendor specific boolean property of x-powers,no-thermistor.
This property optionally describes hardware where no thermistor is
present on the battery and is specific to the AXP717. In rare
circumstances this value can be set incorrectly in the efuse of the
PMIC, and if it is not hard-coded the device will fail to charge.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../x-powers,axp20x-battery-power-supply.yaml | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index 5ccd375eb294..3504c76a01d8 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -14,9 +14,6 @@ maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Sebastian Reichel <sre@kernel.org>
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -35,7 +32,24 @@ properties:
       this gauge.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  x-powers,no-thermistor:
+    type: boolean
+    description: Indicates that no thermistor is connected to the TS pin
+
 required:
   - compatible
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - x-powers,axp717-battery-power-supply
+    then:
+      properties:
+        x-powers,no-thermistor: false
+
 additionalProperties: false
-- 
2.43.0


