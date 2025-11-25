Return-Path: <linux-pm+bounces-38579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC5C84E4D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E143A9C9D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD09320CD6;
	Tue, 25 Nov 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEGOcggA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C34320A0B
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072391; cv=none; b=rux2Ny9+nQXdsa8M00s/sGoXXX67A8VaJbGKR3ZPyCded5T5YvGOwRNcTY0YGZpXY10HH2vdMeTMpuk7TppkGyiUGvkq+nrFJRuoDtYPDJXWHsFsZa0i5DJTUuPFnkS2dfVfXA2DaVkwwiOKH/bE4ozvB0charU9X7kFpJ8NyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072391; c=relaxed/simple;
	bh=oofrnjhZanrLkWatPeyuYrbv1Q6MvPZXu89wFAQHc/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGwfNla0tOiX15aq2Xcq39IzdFriFquryxJqNdbjLwQH9F0AeXwGg8Yyyd2LZCJDypdfxm/SgfM6ugN1N4rU2yJtOwlyQYA8s1H/J2PgI2BYKxaNWwh3PYk/yxWeeWv/eGdwfnJW/Ra3NbQZwEbqXrBQ4hl9kLLo9YjvIgzv++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEGOcggA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-595819064cdso7586383e87.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072388; x=1764677188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mvXM/OjnCbNqb+efTyw9EZlzwSyRJRkUMKBRDIIvhA=;
        b=fEGOcggA9hHFsvswUFl2cnXquHKWMwMuFNguQAhR02WJzVh1NeWXChUvamk+4GLL2M
         kq9+Z6WczAwwPLEt6rVe/KmjT7LouK5gtKb7v0ba9fcH5Y6LXVjIzDGORrb5WQMvkMxa
         1I0KTRy5Hi/CbJomxUbv5zYswF0vhs5N9vgNHb1he74uIVteiNHd6NHGK6OM7nEB6CXe
         bolLffo7lcnrOtf7DujcxQGz4tstlqChrgf9aaWHa4xK85PizpoZPX4Oq4PRNQjI8Mzl
         c8oJCSwZXLEL4QOoStplwr5gMRXfCiZC8c6qtLK4o17ixYqs6scRXHuh6tLzsn+s52Hr
         5sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072388; x=1764677188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mvXM/OjnCbNqb+efTyw9EZlzwSyRJRkUMKBRDIIvhA=;
        b=ZSDP/iTqxwKIChME9Imj0yAzMiMnGuVwDFD8bVbhu3fxKXzj3JTjbomFooxdtOBtTj
         rq0XYqz+pdzaJXEWsB99QLZ5LlWJpRyEyEF+Jp2uncOC6hqBzwXsuJTXYcOVhQ+kPPbu
         PZWNBy+LojajHVhXTUVkMrqWkbjL6Vdm7/RBNCgaz4N7s6uplLvbHx2+FKi/8drA0WXR
         6YBo79ZHBkBTvrpG3uekxDTvHNoMhcodFWixxaKoIhjc0IKa8TwZg1uNt04+frpiDnE6
         +tGTooYaDwtPyIxHemesayjggWI7Zy+YMDldIVZab5RnCp4Dv6N2qfTgZKgDE2Aa40BM
         5QEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJUL08XUXEAjMYAUoj1EV3s4soOJo7wYqb/fGDo7pCt/mOzi8Xi/z6Id7v+6Ngw02bqsY65KzO+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGBJ6NFj2z4rznctxYGX+fkXbKByGiuVJQRDisNx8cdkPjcVm
	WXsNZbcj9kQgJNmFWGpuFxOuLqmpLOVPnMdFGltgUhKAO9QXjacTfmY/
X-Gm-Gg: ASbGncsZzfAXd0DzDswGkh2YY4iFgR7Z2VFim4spZT4BrSJloiYF+JSTRhNVYNuUKYC
	JYeRKFVP34poRvmt6suVGHwMgRLBLU8qfr1d1gipb3gzZR6bsOyteeyU7FlSSs353mWFgAZbmhD
	X9LRv0H44JsKUhyCl6jdt8QyjqiY2RLQk+dFde4JL3S0XIc2FTTD5x6UpIscCljTEm5zLKGFDhn
	wg0ijYd2qWSIK+JXNCnwd1DHgNO+NT57IdSCDPjs5k2SSdxbBsZTe3mQsBF4GodVOfSlxrmJK+C
	113EuSNvMvPbjYl2Sjv/1r9mfWWxlxMCAXWmTv2MyJ6FJHIZQ+qWStDi6v6HuBTUwXFsUbaZ8Hy
	JJwMYYGGqvxQ4wLG/KQ2bXEiOkOpVciI4ZKvbbxQJFGFcjeySD8bUMr7Q0EveIr4FlriP1c1tej
	4=
X-Google-Smtp-Source: AGHT+IGHYbw79llgjzVhdJNpY+OeL/blXkBr7o7aN3N9BTj1dRXSku3hTW54mmH916DBOqG/DxkWuQ==
X-Received: by 2002:a05:6512:1390:b0:595:83e7:c74e with SMTP id 2adb3069b0e04-5969ea192d6mr6467252e87.13.1764072387266;
        Tue, 25 Nov 2025 04:06:27 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 07/12] dt-bindings: memory: Document Tegra114 External Memory Controller
Date: Tue, 25 Nov 2025 14:05:54 +0200
Message-ID: <20251125120559.158860-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125120559.158860-1-clamor95@gmail.com>
References: <20251125120559.158860-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include Tegra114 support into existing Tegra124 EMC schema with the most
notable difference being the amount of EMC timings and a few SoC unique
entries.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../nvidia,tegra124-emc.yaml                  | 174 +++---------------
 1 file changed, 26 insertions(+), 148 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index f5f03bf36413..9398aae49093 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -16,7 +16,9 @@ description: |
 
 properties:
   compatible:
-    const: nvidia,tegra124-emc
+    enum:
+      - nvidia,tegra114-emc
+      - nvidia,tegra124-emc
 
   reg:
     maxItems: 1
@@ -29,6 +31,9 @@ properties:
     items:
       - const: emc
 
+  interrupts:
+    maxItems: 1
+
   "#interconnect-cells":
     const: 0
 
@@ -164,153 +169,12 @@ patternProperties:
           nvidia,emc-configuration:
             description:
               EMC timing characterization data. These are the registers (see
-              section "15.6.2 EMC Registers" in the TRM) whose values need to
+              section "20.11.2 EMC Registers" in the Tegra114 TRM or section
+              "15.6.2 EMC Registers" in the Tegra124 TRM) whose values need to
               be specified, according to the board documentation.
             $ref: /schemas/types.yaml#/definitions/uint32-array
-            items:
-              - description: EMC_RC
-              - description: EMC_RFC
-              - description: EMC_RFC_SLR
-              - description: EMC_RAS
-              - description: EMC_RP
-              - description: EMC_R2W
-              - description: EMC_W2R
-              - description: EMC_R2P
-              - description: EMC_W2P
-              - description: EMC_RD_RCD
-              - description: EMC_WR_RCD
-              - description: EMC_RRD
-              - description: EMC_REXT
-              - description: EMC_WEXT
-              - description: EMC_WDV
-              - description: EMC_WDV_MASK
-              - description: EMC_QUSE
-              - description: EMC_QUSE_WIDTH
-              - description: EMC_IBDLY
-              - description: EMC_EINPUT
-              - description: EMC_EINPUT_DURATION
-              - description: EMC_PUTERM_EXTRA
-              - description: EMC_PUTERM_WIDTH
-              - description: EMC_PUTERM_ADJ
-              - description: EMC_CDB_CNTL_1
-              - description: EMC_CDB_CNTL_2
-              - description: EMC_CDB_CNTL_3
-              - description: EMC_QRST
-              - description: EMC_QSAFE
-              - description: EMC_RDV
-              - description: EMC_RDV_MASK
-              - description: EMC_REFRESH
-              - description: EMC_BURST_REFRESH_NUM
-              - description: EMC_PRE_REFRESH_REQ_CNT
-              - description: EMC_PDEX2WR
-              - description: EMC_PDEX2RD
-              - description: EMC_PCHG2PDEN
-              - description: EMC_ACT2PDEN
-              - description: EMC_AR2PDEN
-              - description: EMC_RW2PDEN
-              - description: EMC_TXSR
-              - description: EMC_TXSRDLL
-              - description: EMC_TCKE
-              - description: EMC_TCKESR
-              - description: EMC_TPD
-              - description: EMC_TFAW
-              - description: EMC_TRPAB
-              - description: EMC_TCLKSTABLE
-              - description: EMC_TCLKSTOP
-              - description: EMC_TREFBW
-              - description: EMC_FBIO_CFG6
-              - description: EMC_ODT_WRITE
-              - description: EMC_ODT_READ
-              - description: EMC_FBIO_CFG5
-              - description: EMC_CFG_DIG_DLL
-              - description: EMC_CFG_DIG_DLL_PERIOD
-              - description: EMC_DLL_XFORM_DQS0
-              - description: EMC_DLL_XFORM_DQS1
-              - description: EMC_DLL_XFORM_DQS2
-              - description: EMC_DLL_XFORM_DQS3
-              - description: EMC_DLL_XFORM_DQS4
-              - description: EMC_DLL_XFORM_DQS5
-              - description: EMC_DLL_XFORM_DQS6
-              - description: EMC_DLL_XFORM_DQS7
-              - description: EMC_DLL_XFORM_DQS8
-              - description: EMC_DLL_XFORM_DQS9
-              - description: EMC_DLL_XFORM_DQS10
-              - description: EMC_DLL_XFORM_DQS11
-              - description: EMC_DLL_XFORM_DQS12
-              - description: EMC_DLL_XFORM_DQS13
-              - description: EMC_DLL_XFORM_DQS14
-              - description: EMC_DLL_XFORM_DQS15
-              - description: EMC_DLL_XFORM_QUSE0
-              - description: EMC_DLL_XFORM_QUSE1
-              - description: EMC_DLL_XFORM_QUSE2
-              - description: EMC_DLL_XFORM_QUSE3
-              - description: EMC_DLL_XFORM_QUSE4
-              - description: EMC_DLL_XFORM_QUSE5
-              - description: EMC_DLL_XFORM_QUSE6
-              - description: EMC_DLL_XFORM_QUSE7
-              - description: EMC_DLL_XFORM_ADDR0
-              - description: EMC_DLL_XFORM_ADDR1
-              - description: EMC_DLL_XFORM_ADDR2
-              - description: EMC_DLL_XFORM_ADDR3
-              - description: EMC_DLL_XFORM_ADDR4
-              - description: EMC_DLL_XFORM_ADDR5
-              - description: EMC_DLL_XFORM_QUSE8
-              - description: EMC_DLL_XFORM_QUSE9
-              - description: EMC_DLL_XFORM_QUSE10
-              - description: EMC_DLL_XFORM_QUSE11
-              - description: EMC_DLL_XFORM_QUSE12
-              - description: EMC_DLL_XFORM_QUSE13
-              - description: EMC_DLL_XFORM_QUSE14
-              - description: EMC_DLL_XFORM_QUSE15
-              - description: EMC_DLI_TRIM_TXDQS0
-              - description: EMC_DLI_TRIM_TXDQS1
-              - description: EMC_DLI_TRIM_TXDQS2
-              - description: EMC_DLI_TRIM_TXDQS3
-              - description: EMC_DLI_TRIM_TXDQS4
-              - description: EMC_DLI_TRIM_TXDQS5
-              - description: EMC_DLI_TRIM_TXDQS6
-              - description: EMC_DLI_TRIM_TXDQS7
-              - description: EMC_DLI_TRIM_TXDQS8
-              - description: EMC_DLI_TRIM_TXDQS9
-              - description: EMC_DLI_TRIM_TXDQS10
-              - description: EMC_DLI_TRIM_TXDQS11
-              - description: EMC_DLI_TRIM_TXDQS12
-              - description: EMC_DLI_TRIM_TXDQS13
-              - description: EMC_DLI_TRIM_TXDQS14
-              - description: EMC_DLI_TRIM_TXDQS15
-              - description: EMC_DLL_XFORM_DQ0
-              - description: EMC_DLL_XFORM_DQ1
-              - description: EMC_DLL_XFORM_DQ2
-              - description: EMC_DLL_XFORM_DQ3
-              - description: EMC_DLL_XFORM_DQ4
-              - description: EMC_DLL_XFORM_DQ5
-              - description: EMC_DLL_XFORM_DQ6
-              - description: EMC_DLL_XFORM_DQ7
-              - description: EMC_XM2CMDPADCTRL
-              - description: EMC_XM2CMDPADCTRL4
-              - description: EMC_XM2CMDPADCTRL5
-              - description: EMC_XM2DQPADCTRL2
-              - description: EMC_XM2DQPADCTRL3
-              - description: EMC_XM2CLKPADCTRL
-              - description: EMC_XM2CLKPADCTRL2
-              - description: EMC_XM2COMPPADCTRL
-              - description: EMC_XM2VTTGENPADCTRL
-              - description: EMC_XM2VTTGENPADCTRL2
-              - description: EMC_XM2VTTGENPADCTRL3
-              - description: EMC_XM2DQSPADCTRL3
-              - description: EMC_XM2DQSPADCTRL4
-              - description: EMC_XM2DQSPADCTRL5
-              - description: EMC_XM2DQSPADCTRL6
-              - description: EMC_DSR_VTTGEN_DRV
-              - description: EMC_TXDSRVTTGEN
-              - description: EMC_FBIO_SPARE
-              - description: EMC_ZCAL_WAIT_CNT
-              - description: EMC_MRS_WAIT_CNT2
-              - description: EMC_CTT
-              - description: EMC_CTT_DURATION
-              - description: EMC_CFG_PIPE
-              - description: EMC_DYN_SELF_REF_CONTROL
-              - description: EMC_QPOP
+            minItems: 97
+            maxItems: 143
 
         required:
           - clock-frequency
@@ -318,9 +182,7 @@ patternProperties:
           - nvidia,emc-auto-cal-config2
           - nvidia,emc-auto-cal-config3
           - nvidia,emc-auto-cal-interval
-          - nvidia,emc-bgbias-ctl0
           - nvidia,emc-cfg
-          - nvidia,emc-cfg-2
           - nvidia,emc-ctt-term-ctrl
           - nvidia,emc-mode-1
           - nvidia,emc-mode-2
@@ -344,6 +206,22 @@ required:
   - "#interconnect-cells"
   - operating-points-v2
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-emc
+    then:
+      patternProperties:
+        "^emc-timings-[0-9]+$":
+          patternProperties:
+            "^timing-[0-9]+$":
+              required:
+                - nvidia,emc-bgbias-ctl0
+                - nvidia,emc-cfg-2
+
 additionalProperties: false
 
 examples:
-- 
2.51.0


