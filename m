Return-Path: <linux-pm+bounces-10354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CE92416C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6D1F2229D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7111BB680;
	Tue,  2 Jul 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/j11lhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752001B581C
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931975; cv=none; b=eMu8gvRnyzQ5sN9Rwv1lt/RvtZcsOqjDYAHF6A03nrfjZUi83LL7YJYfuuZ9CEk+a7s8N6Yu53oA7eOJfpPnyDTRt226/bykkC/IMlhc+wb9YVnMFXPRUj1HR+s/GGtDXd0VQV0GPRgvwYcik7gN15obP9HanqAHiejAyJHQKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931975; c=relaxed/simple;
	bh=s2/SN+aY294KJBk46ApgAbGwP+XkttNkKRk5A23rcOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwTHokVr3oUyjwffg9+6daUv4OJAo8IH/XNtZe4sYjOub5GFS+YN9uY2NScPdDO9rJ0/AEKUL57ibJzsw59EG6Uz+HByADeMpgvqysgwNvuqnAIkBkMyXL8dUaog/tdkhpJt8AxWcTEkXo/C+p0cr4lRZSt4MwXzi78YAsYLLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/j11lhy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so2501264f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719931971; x=1720536771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqZRZ5JDAvuLJzijPzrtSFCWbmFBLmXDFXM1EkI0A84=;
        b=a/j11lhyKrL3SQqEFkjo0RH+Ed7/lCjnDCLkuPe5hdG9mm02/gmMXC7+91ejsKP0X4
         p071mue58al6hQt3ffr4g5dOUR2XXPmb0zrtazQ7b4AovXjC15jpw4NsnPR3cEVlLXw9
         xFDcwtGuVjicYsOTDeMRvOmdXwsnY+kTFl5wliJp3rPZmEU8fPByGWG7ti/DfreZXH1B
         3R/9xfiGOqfTPve7ioTCxxauNXGEdLCAUZTXOVJVdzy8vs1C2ieMn4jHctM3+p+X0WkD
         2MgdXhdTGwiKh2o5anjc8sCYxtE8OMeiNvOWr7l3wG5/2tjFcXNGUgNlBNqjyYy89DAj
         NWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931971; x=1720536771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqZRZ5JDAvuLJzijPzrtSFCWbmFBLmXDFXM1EkI0A84=;
        b=YBDCq39C93yrYkEwBn2U8m/L1sDlmx4tUXmGClCnYZk7fHiMu95R/ag6/PTlczc1y4
         GPDf/tgGl480UBD5Cw3pElWEO2hj2k2LcPoGXcsCzNEPu1JS6vISmTf3+VXgvPP0GnP8
         MmEIcls9zUZ+xLIUL7H97Z9wdItuziMpQe45fLUV123WqwAhxEGbJABuR1TutKCF96vL
         wSCQVrrrna5emNGPrraQI+p4U0i1CFynTJbl7FwPbLVw/vkkBW0fqPnhfxLwJD1xjMI7
         us7F8W0ITylueA1EGWBGoGxbYXB1KWN1qeGqfN0RKWOwOMLRJm9RIARBXh0iRrTGLezI
         mD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw2LQAFjWoePYKAS1MidJh9mdxvvaXQUXuFxXeKfJRaRon/YdlGy7B/YSBPpK5bymNEst9YltwbaXK0W5pTDGsIkaSX/oY+qQ=
X-Gm-Message-State: AOJu0YyR0z6neYk6MzTtHk/lnq7TMCg/FEwN654BNXk0sqfRVlqwUPGb
	PQCilq2YGvc9KJAfw+QX12UTJ0td/RHK/Pv6OQyLljKIvBq0WlaOwX8ZiQEzXn8EGaahVgL/YVg
	R
X-Google-Smtp-Source: AGHT+IGrmxHz8Jxtr4a4AWna5zv+DQYMBNjG5ZT83E29iudMDCAjgjL8DXgVHasB+X4Bhig1Sha5Qg==
X-Received: by 2002:a5d:484e:0:b0:360:9e8b:e849 with SMTP id ffacd0b85a97d-36774f935f4mr6734918f8f.31.1719931970887;
        Tue, 02 Jul 2024 07:52:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd712sm13468483f8f.20.2024.07.02.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:52:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amit.kucheria@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] dt-bindings: thermal: correct thermal zone node name limit
Date: Tue,  2 Jul 2024 16:52:48 +0200
Message-ID: <20240702145248.47184-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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
of the node name (thus 10 for the pattern after leading fixed character).

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com/
Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Shorten the pattern and mention source of size requirement (Rob).
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 68398e7e8655..606b80965a44 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -49,7 +49,10 @@ properties:
       to take when the temperature crosses those thresholds.
 
 patternProperties:
-  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
+  # Node name is limited in size due to Linux kernel requirements - 19
+  # characters in total (see THERMAL_NAME_LENGTH, including terminating NUL
+  # byte):
+  "^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$":
     type: object
     description:
       Each thermal zone node contains information about how frequently it
-- 
2.43.0


