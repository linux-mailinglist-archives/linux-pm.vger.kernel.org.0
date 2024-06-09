Return-Path: <linux-pm+bounces-8829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CE901783
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 20:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7FBB20FFE
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343B6F30F;
	Sun,  9 Jun 2024 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0rphp2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB196F2F6;
	Sun,  9 Jun 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957315; cv=none; b=u+KlJYiimnwxQrxTzgTQjzCEOmqRI8rHv/Am8DF8lZP5hRih6847TvETUBkIrEdAjWrJIV+QZ9w6Of4ZhE3piYmK28uqC0H7iBabz6hJxSJSA/c8f9u5avInGXXVb4fOiHbfrKSC0GunuEW8xCjY0IpdAx40JKESdV/UFCuSEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957315; c=relaxed/simple;
	bh=uIrmQEelix3LEmJne/2AfADR5iCGGxuiQSpXb8kYLOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdE0JLGTXRPJzEMZzDUwIu0K7O3KuXmoXWw640CwBsI/MaBC/nB0rIzBj0qEENFOVWEn0P9foU2DcB3Xe4rq8ty+pckJCDbuiHvViSLN8vzZEap7P3X3V4EdTGh5gDiHKv99y2+gx9EptQChqvHMum4QATJIqjkjOkp8qOvMqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0rphp2c; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso54055591fa.3;
        Sun, 09 Jun 2024 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957311; x=1718562111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cTyvCxrK3Xq1bvrTLKc9ITi2Qxz8ox9OMKkDMGhIxo=;
        b=g0rphp2cjviw5tKkBCVY10WW3umPFEz6t69T9k9BhZ6Luga1gXf3jKg/6nopYNfVB6
         kssYQIDS16c1l2hNlPK1cl7MUrg7cL+KD/TZDDkY0u8gyf/4lY9ec+aMJ7aKeq8Ext/R
         6II08aGgpvds6Nwn6v76c6Dnc9l2g4hOpqMbEjEOSC5csgGA/33AqTVqL+ZRb+HeeaOq
         MMMi1+fG9JEyO6vV8pDrMR0AqblA6gcdo8dg4dl5t3fR44AvBEswktq/tEeCkmVs7/se
         lQsOHmYZw/cMtyrlrA5qovSHztHhbq14qmpLxGzvzpx81W39Xz1M1sUgm8SgiUM2ENPn
         Rz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957311; x=1718562111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cTyvCxrK3Xq1bvrTLKc9ITi2Qxz8ox9OMKkDMGhIxo=;
        b=Bm8JWuT/zOkmlv4XsKhbBYRwJ4jo7X9y9RO55AlBODVlNuMnfnRRc92/kl0+UnBMZc
         wvdFXX/8HHqUxSSGxOBNH3fKJWQDJvAG9PEKOxzRLa8L631q/T4Be/TLfRF+jcmBPium
         rpKYtB6BqnE1djv2iAuChHhLrRbt0hy8a+76f3UatWiaThmC+lcmo9YXq64cymdvPBuQ
         PekatUfFr3QdL3WDklui21+K2LJkBL46CQakkAWJ/hPytIdQqZ0jZLspH/DvnxOu9FSM
         fDWUGBjP4PPL8/RytoGdGzRnd3g3Ed9mVNH/GswQea6fQ5VgCdYhauM6GSAB400Pcik2
         Fuww==
X-Forwarded-Encrypted: i=1; AJvYcCUJAmGbDDg9dZ1IZsOJSwIDj4cYnY6tUmfTGQwy1ET5veiEzUxd1otJSVO2xShdtt98Zka+PmE3WO+t2xdjMK+P66ODOHSVCyzAlvQ/9GsrjVheGP6SJa1CUZMlyE+Bj6iE/EblbYrvWq6H/DTxDR9FOCZNLNuNb6p3t6wbzO4cpzuGRysCPhTvkjAZhSpRJbSWdPupajcVGVi96kP0u+2MEw==
X-Gm-Message-State: AOJu0Yyu+npgWJTndhe51zYCeaHhn6R28yH98nfaHBafbilQjrwGrpRR
	5VMPkn9EEX4yUfySWrJZOzNJC9Ew9+Jsrhhakmmsi5lUt0dK4uZwizT5KdCx
X-Google-Smtp-Source: AGHT+IEqaU+iUHneGrvnKrfvs6kEjkdYgmEr5+JnTTFLxGXE8SL8TnFJ/s6teQVEaMPIonG0/glQgg==
X-Received: by 2002:a05:651c:1505:b0:2e0:e470:882f with SMTP id 38308e7fff4ca-2eadce3774amr55597591fa.28.1717957310900;
        Sun, 09 Jun 2024 11:21:50 -0700 (PDT)
Received: from localhost.localdomain (bza83.neoplus.adsl.tpnet.pl. [83.30.46.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd5a63bf2sm6679841fa.33.2024.06.09.11.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:21:50 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] dt-bindings: interconnect: qcom: msm8939: Fix example
Date: Sun,  9 Jun 2024 20:21:00 +0200
Message-Id: <20240609182112.13032-8-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182112.13032-1-a39.skl@gmail.com>
References: <20240609182112.13032-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now example list snoc_mm as children of bimc which is obviously
not valid, change example and include rest of nocs in it.

Fixes: 462baaf4c628 ("dt-bindings: interconnect: qcom: Fix and separate out MSM8939")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/interconnect/qcom,msm8939.yaml   | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index fd15ab5014fb..a77e6aa2fbee 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -56,19 +56,25 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,rpmcc.h>
 
-    snoc: interconnect@580000 {
-        compatible = "qcom,msm8939-snoc";
-        reg = <0x00580000 0x14000>;
-        #interconnect-cells = <1>;
-    };
-
     bimc: interconnect@400000 {
         compatible = "qcom,msm8939-bimc";
         reg = <0x00400000 0x62000>;
-        #interconnect-cells = <1>;
+        #interconnect-cells = <2>;
+    };
+
+    pcnoc: interconnect@500000 {
+        compatible = "qcom,msm8939-pcnoc";
+        reg = <0x00500000 0x11000>;
+        #interconnect-cells = <2>;
+    };
+
+    snoc: interconnect@580000 {
+        compatible = "qcom,msm8939-snoc";
+        reg = <0x00580000 0x14080>;
+        #interconnect-cells = <2>;
 
           snoc_mm: interconnect-snoc {
               compatible = "qcom,msm8939-snoc-mm";
-              #interconnect-cells = <1>;
+              #interconnect-cells = <2>;
           };
     };
-- 
2.45.1


