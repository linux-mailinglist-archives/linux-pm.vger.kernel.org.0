Return-Path: <linux-pm+bounces-1784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B7822F4F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF297283A69
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B37312E5E;
	Wed,  3 Jan 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNp/NtiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D51A58A
	for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a279ce3aab9so443151166b.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704291655; x=1704896455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bvb45RnFS+kEP29Py4mFpvqfYdOepUjValoNOpE4LSM=;
        b=hNp/NtiOQtzccHHjdpw2r09WJiL5xuh9EBIvPBrj4WAVE028+NCWgXSP9tB3VrsN/5
         gNDkhFZfoXD2DOqM4p/rQL+q4LxNq5At5ngOBvZSw/qq/WbdJnBL50rh64Mh/xxP9PsK
         TJ8GSSze4mi60G9gPFAgVlDVAF8wsRDFdL4cUq+mwtvJ+1pNepb+raBkWCd/p6Tsge27
         n7ZCFclh0EQ8UZ46ckixFOrt0XaaDmjXL+AbDe8eqtyMqYb3wwiSQJUoSkzlkpJr3Z0r
         So/0CQtwPl0/Yei4nwiUc3Ias3jiXNIXDM/gFte+1TL8elUkleAACcCADKMraVl7w5xD
         z9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291655; x=1704896455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bvb45RnFS+kEP29Py4mFpvqfYdOepUjValoNOpE4LSM=;
        b=fjqjcFP2/6DHfW9Zfmd7lH160LdDCB3+8rnEWTvAjAkKsEvLNQHf6qjJCPbTlJ9F4m
         mMi19kyKmPJ2htdT/RgTVJ6hgrNnhQCwIeUmjibMoT4jaOvwqfE+vWmMa6GsfiocVrGo
         6/mkPmUH4mMcDxDctDcZKc8+0NkJ5PqHBhYO3x2+z7DdNt025Yknj8PqVlaVmx9gIgS6
         fnxZE/dVNnTIy6Yl57wuZMy0RT4gCYXx/9knZUmaBm+qz4IFOtWgTpmPDDaKmEybaWFh
         egi8YKA07Tg/41nV2kYoViLMju+3JzhrBU3snmMluvWpS1bTXkPaeMIf9n2iIDX59uMF
         OwXA==
X-Gm-Message-State: AOJu0YzzQpfakcTDcU+Rxeq9VuBTOxaBK0wJlI40EkgYc6OC4nQd5VRy
	2YMo1o4edetEMg9KTWgaXxvUmtzgAKd1Mw==
X-Google-Smtp-Source: AGHT+IHDZT4bLFqR/GRWN08QLzEICPW0/x7Ga9yWw7doPWkQ11xe2R+5lwJ4fdglYrnv/j5X1LRe6A==
X-Received: by 2002:a17:906:3:b0:a27:908b:e6b2 with SMTP id 3-20020a170906000300b00a27908be6b2mr1793479eja.35.1704291655000;
        Wed, 03 Jan 2024 06:20:55 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26abf393d0sm12229325ejb.138.2024.01.03.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:20:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Amit Kucheria <amit.kucheria@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: thermal: correct thermal zone node name limit
Date: Wed,  3 Jan 2024 15:20:50 +0100
Message-Id: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux kernel uses thermal zone node name during registering thermal
zones and has a hard-coded limit of 20 characters, including terminating
NUL byte.  The bindings expect node names to finish with '-thermal'
which is eight bytes long, thus we have only 11 characters for the reset
of the node name, not 12.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com/
Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4a8dabc48170..bbc883fd4044 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -49,7 +49,7 @@ properties:
       to take when the temperature crosses those thresholds.
 
 patternProperties:
-  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
+  "^[a-zA-Z][a-zA-Z0-9\\-]{1,11}-thermal$":
     type: object
     description:
       Each thermal zone node contains information about how frequently it
-- 
2.34.1


