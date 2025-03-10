Return-Path: <linux-pm+bounces-23736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E8A58D60
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EA67A3E91
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3953223311;
	Mon, 10 Mar 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHlLB94g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383F222595;
	Mon, 10 Mar 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593440; cv=none; b=TEnDzl3BqcQ/s2hZuJnw5xRtvIhWW8ZvphIQEDzLOqxTnAf/YQr58Ye27VOHb8GSDEY3Mb3UqpKuBntz89AB+UVqhIdnQzVdtOiYJQKIKm7P5BohA0BHWR/+ghwsjpZvq4Xs0mc1/sx4u9+qsHwJVCq3AyeuHlgru9AIAnXj9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593440; c=relaxed/simple;
	bh=yU+C+ctdw5d7G7jsiaddrDPo0Urr2NVMzLggVGFVTc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFKgAuNXz5zm9lUBRbejXlIvKKfSMJ51kzw3YhDwc6juTqdd8t+/V6uGVo/dkyPXz4MLva6AnmrkDQsdLG1LCkgeuu9GGhlkIEj9hi4NK1gLJ4SHdPrMYEJ49CRNVQjgS7HoV72mm3sP4Fr0oBob9rXoQ8at122tRaDPXYog66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHlLB94g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so575054766b.0;
        Mon, 10 Mar 2025 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593434; x=1742198234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBlTT1AB0KMrBYwTn3M+sIKO/uDVK4wSMDsGEkLbHK4=;
        b=FHlLB94g6VR6pLe1qjAZVDHnLOet/gFiTca1RcgmIP5nc3f5lTBvnOnV8KySa4rW6t
         G2z87I8yLLuyHzFScymM4Cc8VqkN1FKHjkwjJ8Dj1KUv4YLhjezq7DiU4jqEf5kh5+uL
         mYNa6/F+8Czroo1yiqgS5i4myeM7H92gK+9quuI6Hq/xmHyNForztOEl2cwrzDTRsNm3
         KfWS/OUoTcUxMaQ+csRNH+GMUbMO0FZXamj5bFJQr+Y7Sd0JUElc7M18MztIEDVoE5ys
         BreLjJ0NoA3Yz73Ymi8ym6o7dTpcggXIVM5oDrYwE4Gydy9P/Zfvf7qhKJfIESQqpvCT
         s6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593434; x=1742198234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBlTT1AB0KMrBYwTn3M+sIKO/uDVK4wSMDsGEkLbHK4=;
        b=TkMLbRRpOeDWcvp3Lw1tUQ9yjd3yJahYKd4gQAS1Is7cPMc/yHY3XCjcNTIisQnPNm
         nSs4y2t24oJfniItt3EEoY3UIpnsLzvqQrl7TfVQCSHB85T5tlmmzHbl1rRZ+Kz/d4Uy
         4t8/kCn/6aH2JlthVsLCToncbnIOHg9V4VJpsAL/YFToLk0dAPejmnjztt2PqLkTrEPy
         zsA6qBsoQEgmo4Aq/5a+jTOz7LY4nBGGwuA/Hbv/w3iaeJ6WdqeQu9mw7kN21CCuPmbi
         VtpyFP0g4KrtRI0wsTtyBfZTp+gwfRa+pSDGOJvaP3SDBDg6AgoYKw6baWm31YNYDgkR
         jP0A==
X-Forwarded-Encrypted: i=1; AJvYcCWhceQkT5aL6E3AtYLthw3j2ZQVf4nW7gITd7tueYUP9DvA9uh4sUer8hEGsoq8yk6T+8qTUt7OqxDsCZxs@vger.kernel.org, AJvYcCWjezel8OKr3BlVZumGFYWoklVxdGI7qS3xce2Dsy5RHuG/269QXDsIkyXe1y8PpBqFuDQzjv92+UiC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+QDFEkVumKv1587NABc/KlpjzPdYVDxmar1Db1sc0WJucT4C
	xBTiVn2hHBM+86Dm70ktf0U14koduPZHZcG6+Aiiy//9LSCXEikJ
X-Gm-Gg: ASbGncsOzB/4hIouwN/HRcFFMR1fCMX6GgW/xwPOgSKDmZR1Az2gIwc/Czi+LD9VR94
	DY8QB2/gAOW690LkF93ENqlrRWVE64xlNm614RI1PLfE+5Jrm+dAtW+SDuZ46Ie3+y4zb4hdlRU
	+Kv2fp+vpr/dzCduZITSPAIUNOJAo+H+Wbq6A+0Wal9/ozye+FHny9bOG3NDaNO8kPuiHTxxdqr
	0bGzxgxKQw1WU7Ki/hWklGozyn47ibjJlDHrwNypaCAiMpJjImis+2x4oswJsXvkOv+UWW6f5Jq
	hQwPy6cwIniQlMMPBybbZGYlIgCPs/ToTGwr
X-Google-Smtp-Source: AGHT+IFtYKN/7c+ChwWeAaa28tcqn/iMpy24US0C339Y0FaBl5ubiDBfLwDGvCnIZoUzibDrZoI2Gg==
X-Received: by 2002:a05:6402:34c7:b0:5e5:ba77:6f24 with SMTP id 4fb4d7f45d1cf-5e5e22d4c66mr34927806a12.16.1741593433762;
        Mon, 10 Mar 2025 00:57:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2895e7e6asm274697566b.54.2025.03.10.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:57:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: thermal: generic-adc: Add optional io-channel-cells property
Date: Mon, 10 Mar 2025 09:56:37 +0200
Message-ID: <20250310075638.6979-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310075638.6979-1-clamor95@gmail.com>
References: <20250310075638.6979-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements a mechanism to derive temperature values from an existing
ADC IIO channel, effectively creating a temperature IIO channel. This
approach avoids adding a new sensor and its associated conversion table,
while providing IIO-based temperature data for devices that may not utilize
hwmon.

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


