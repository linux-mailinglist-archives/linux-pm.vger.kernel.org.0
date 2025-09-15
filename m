Return-Path: <linux-pm+bounces-34635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E64B5725C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22B617DE07
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98932ECEB5;
	Mon, 15 Sep 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnyvOUm6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309E2EC546
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923356; cv=none; b=eeNNl7x72rX1IZ1Jcfh2xeh6NM0lzRDeovOoG0T/yPq3Ti5myKWEC7XZtTqjhC8y64QXYclR1M7Q74asYqePN74I0Y/trLUYmtofr85xx3lFgfA3oTXAP60Ur/3OkwU2U3+Ho8x7quQV1foL5qX8IP0zGrYDD/wShVBnlbxOHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923356; c=relaxed/simple;
	bh=oG1UDywpcR9M4x+yKBkhpkuBvFZfw89ujr3kh7eFaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6idEl+M6AIywvtPrfHC4ZfxbB8Zks17lBWOtni3jS0SWwAYEmvlGEBOy+8hkhSni7vOmfASN8ASIUObdfQ0Ryk6JYxzyw9JwKCPaOEcmrTZkKpoZlh5f1aMmwRCRKicLoCD5iaet+g6m9udeCDXAqm7QuFJlS9lrxmvj2HbOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnyvOUm6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5607a240c75so3949859e87.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923351; x=1758528151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u7DncElgdWGoBbTvsNYYCuvHQdiQcUMiPwI+0yQv1U=;
        b=bnyvOUm6EwhZ/kZDNcnJXawAGNBNUAXmQAzhhFwLaq5l1ksZg5WjQmcGcoWwfntRSI
         UwQAEqokjD2rX4W3uJ2U/dssBlqL9/ZpJ5LLfkKwVrWdRPHZ5wyEwuamOTPnozIHOM76
         qDA+fgGQ55q8oyAWMWgXx9V4sazgmNbXd/87ZUpCcJK/GZcSGcY/GgWTn+uo6DE+7osW
         j+tF1dQHcklIywFruPOf25H1wTA6khoafVVwXF1ZJkCW2fv+ucWfqSvEb0GF6fXdUtD4
         61nDoRs1Bo2cuhW5+vXUplXeYQstZZYiXRVAqCmKW4CSTcaQAAvUzS5dMbFomBifv9QJ
         //Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923351; x=1758528151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u7DncElgdWGoBbTvsNYYCuvHQdiQcUMiPwI+0yQv1U=;
        b=HUtTiW8MAe2FYmLblpSd4bBb55hxFeL7hc3+LAclOCRskHbK7ayQvEZfbb9GIukXOB
         WopW9gMEcJxrqnkGOFE74u+vFgiJEeKPMlzX3RM7I3yzHtbccFnJupy0A/VQn+BZMThH
         1CNBiFdnvt9VOu3/A9ZdboAlubyc1mrbmBmDzPI7hhL/Yn1nVGElfuDS2/hTVKrs49Y9
         0IB9ivcgodZhs85Xp33NAwLzPqQfiUDvSFZGRP1n64JskKDQnGD0igEthaz/8ygUqXzt
         6k8v5HtbwmXOkXndyUgebsFozLNWVk29KqX+oXMcvuI83fz0NcQf2pUpRQb2gxJk4x0r
         imKA==
X-Forwarded-Encrypted: i=1; AJvYcCV9DPOui4T50FklDouUUyATYr5fURlbDTA6vDF3Rs17IWbssSu1EEZo8YjOgg4HG7Pd8tE4LAszeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxglrim+BtzJCzykX5kMgjT7t0O4cUA/425Tpvc3KMOWBUiLx+s
	X1+s+WMAb5en+5bgNLoSGNswPOvKgxRTyMb9kzK1xiifR1gt0qA+WBkk
X-Gm-Gg: ASbGncsPXxCt4bNp2KTJxCMXdVf8Ie50B7J/pkFXOGe2eIY6Ke+lY1TgGWr/QOmuhaC
	lV8nLP2LUN5BJGotkEUgq1J/NFqVEC47AAugyd4TabgTceenEkcd/LVGkDlC+/F8qjJZk9e1osN
	ZmHYRWphzS2++QrHDcMK8KrKfRNJy8NPcSnWYD2Ni1eEhMEsvuZpZcOc9EABv0I9xVHI26r8anZ
	lNfvG0PI/4FiCmNfN7UcYek1DhHZOvmwMIxC35q3si03Qny+lB2Q0GcCeIs4mq5v/q2qKju10K9
	lDc9I65ByDxO78X30oAz0wfTGbQt0x/HM8FxPJNufjn4mUJ8Y5Am5UOHzVFZGfnIJd/pV4dUU2s
	YiEKrB2hsC17VVfGptz7HVlU9
X-Google-Smtp-Source: AGHT+IEIzb0MelnrDb6tsvBBgjhy3goeGAgHgtIY40U+klN3eLzXkD55yKXFZdzIpxBI7o+EErrCaQ==
X-Received: by 2002:a05:6512:3599:b0:562:d04d:fa05 with SMTP id 2adb3069b0e04-5704fb8634dmr2789250e87.54.1757923351191;
        Mon, 15 Sep 2025 01:02:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:30 -0700 (PDT)
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
Subject: [PATCH v3 07/11] dt-bindings: memory: Document Tegra114 External Memory Controller
Date: Mon, 15 Sep 2025 11:01:53 +0300
Message-ID: <20250915080157.28195-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
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
 .../nvidia,tegra124-emc.yaml                  | 431 ++++++++++++------
 1 file changed, 283 insertions(+), 148 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index f5f03bf36413..1aeff06c3efe 100644
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
 
@@ -164,153 +169,10 @@ patternProperties:
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
 
         required:
           - clock-frequency
@@ -318,9 +180,7 @@ patternProperties:
           - nvidia,emc-auto-cal-config2
           - nvidia,emc-auto-cal-config3
           - nvidia,emc-auto-cal-interval
-          - nvidia,emc-bgbias-ctl0
           - nvidia,emc-cfg
-          - nvidia,emc-cfg-2
           - nvidia,emc-ctt-term-ctrl
           - nvidia,emc-mode-1
           - nvidia,emc-mode-2
@@ -344,6 +204,281 @@ required:
   - "#interconnect-cells"
   - operating-points-v2
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra114-emc
+    then:
+      patternProperties:
+        "^emc-timings-[0-9]+$":
+          patternProperties:
+            "^timing-[0-9]+$":
+              properties:
+                nvidia,emc-configuration:
+                  items:
+                    - description: EMC_RC
+                    - description: EMC_RFC
+                    - description: EMC_RAS
+                    - description: EMC_RP
+                    - description: EMC_R2W
+                    - description: EMC_W2R
+                    - description: EMC_R2P
+                    - description: EMC_W2P
+                    - description: EMC_RD_RCD
+                    - description: EMC_WR_RCD
+                    - description: EMC_RRD
+                    - description: EMC_REXT
+                    - description: EMC_WEXT
+                    - description: EMC_WDV
+                    - description: EMC_WDV_MASK
+                    - description: EMC_QUSE
+                    - description: EMC_IBDLY
+                    - description: EMC_EINPUT
+                    - description: EMC_EINPUT_DURATION
+                    - description: EMC_PUTERM_EXTRA
+                    - description: EMC_CDB_CNTL_1
+                    - description: EMC_CDB_CNTL_2
+                    - description: EMC_QRST
+                    - description: EMC_QSAFE
+                    - description: EMC_RDV
+                    - description: EMC_RDV_MASK
+                    - description: EMC_REFRESH
+                    - description: EMC_BURST_REFRESH_NUM
+                    - description: EMC_PRE_REFRESH_REQ_CNT
+                    - description: EMC_PDEX2WR
+                    - description: EMC_PDEX2RD
+                    - description: EMC_PCHG2PDEN
+                    - description: EMC_ACT2PDEN
+                    - description: EMC_AR2PDEN
+                    - description: EMC_RW2PDEN
+                    - description: EMC_TXSR
+                    - description: EMC_TXSRDLL
+                    - description: EMC_TCKE
+                    - description: EMC_TCKESR
+                    - description: EMC_TPD
+                    - description: EMC_TFAW
+                    - description: EMC_TRPAB
+                    - description: EMC_TCLKSTABLE
+                    - description: EMC_TCLKSTOP
+                    - description: EMC_TREFBW
+                    - description: EMC_QUSE_EXTRA
+                    - description: EMC_FBIO_CFG6
+                    - description: EMC_ODT_WRITE
+                    - description: EMC_ODT_READ
+                    - description: EMC_FBIO_CFG5
+                    - description: EMC_CFG_DIG_DLL
+                    - description: EMC_CFG_DIG_DLL_PERIOD
+                    - description: EMC_DLL_XFORM_DQS0
+                    - description: EMC_DLL_XFORM_DQS1
+                    - description: EMC_DLL_XFORM_DQS2
+                    - description: EMC_DLL_XFORM_DQS3
+                    - description: EMC_DLL_XFORM_DQS4
+                    - description: EMC_DLL_XFORM_DQS5
+                    - description: EMC_DLL_XFORM_DQS6
+                    - description: EMC_DLL_XFORM_DQS7
+                    - description: EMC_DLL_XFORM_QUSE0
+                    - description: EMC_DLL_XFORM_QUSE1
+                    - description: EMC_DLL_XFORM_QUSE2
+                    - description: EMC_DLL_XFORM_QUSE3
+                    - description: EMC_DLL_XFORM_QUSE4
+                    - description: EMC_DLL_XFORM_QUSE5
+                    - description: EMC_DLL_XFORM_QUSE6
+                    - description: EMC_DLL_XFORM_QUSE7
+                    - description: EMC_DLI_TRIM_TXDQS0
+                    - description: EMC_DLI_TRIM_TXDQS1
+                    - description: EMC_DLI_TRIM_TXDQS2
+                    - description: EMC_DLI_TRIM_TXDQS3
+                    - description: EMC_DLI_TRIM_TXDQS4
+                    - description: EMC_DLI_TRIM_TXDQS5
+                    - description: EMC_DLI_TRIM_TXDQS6
+                    - description: EMC_DLI_TRIM_TXDQS7
+                    - description: EMC_DLL_XFORM_DQ0
+                    - description: EMC_DLL_XFORM_DQ1
+                    - description: EMC_DLL_XFORM_DQ2
+                    - description: EMC_DLL_XFORM_DQ3
+                    - description: EMC_XM2CMDPADCTRL
+                    - description: EMC_XM2CMDPADCTRL4
+                    - description: EMC_XM2DQPADCTRL2
+                    - description: EMC_XM2CLKPADCTRL
+                    - description: EMC_XM2COMPPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL2
+                    - description: EMC_XM2DQSPADCTRL3
+                    - description: EMC_XM2DQSPADCTRL4
+                    - description: EMC_DSR_VTTGEN_DRV
+                    - description: EMC_TXDSRVTTGEN
+                    - description: EMC_FBIO_SPARE
+                    - description: EMC_ZCAL_WAIT_CNT
+                    - description: EMC_MRS_WAIT_CNT2
+                    - description: EMC_CTT
+                    - description: EMC_CTT_DURATION
+                    - description: EMC_DYN_SELF_REF_CONTROL
+
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
+              properties:
+                nvidia,emc-configuration:
+                  items:
+                    - description: EMC_RC
+                    - description: EMC_RFC
+                    - description: EMC_RFC_SLR
+                    - description: EMC_RAS
+                    - description: EMC_RP
+                    - description: EMC_R2W
+                    - description: EMC_W2R
+                    - description: EMC_R2P
+                    - description: EMC_W2P
+                    - description: EMC_RD_RCD
+                    - description: EMC_WR_RCD
+                    - description: EMC_RRD
+                    - description: EMC_REXT
+                    - description: EMC_WEXT
+                    - description: EMC_WDV
+                    - description: EMC_WDV_MASK
+                    - description: EMC_QUSE
+                    - description: EMC_QUSE_WIDTH
+                    - description: EMC_IBDLY
+                    - description: EMC_EINPUT
+                    - description: EMC_EINPUT_DURATION
+                    - description: EMC_PUTERM_EXTRA
+                    - description: EMC_PUTERM_WIDTH
+                    - description: EMC_PUTERM_ADJ
+                    - description: EMC_CDB_CNTL_1
+                    - description: EMC_CDB_CNTL_2
+                    - description: EMC_CDB_CNTL_3
+                    - description: EMC_QRST
+                    - description: EMC_QSAFE
+                    - description: EMC_RDV
+                    - description: EMC_RDV_MASK
+                    - description: EMC_REFRESH
+                    - description: EMC_BURST_REFRESH_NUM
+                    - description: EMC_PRE_REFRESH_REQ_CNT
+                    - description: EMC_PDEX2WR
+                    - description: EMC_PDEX2RD
+                    - description: EMC_PCHG2PDEN
+                    - description: EMC_ACT2PDEN
+                    - description: EMC_AR2PDEN
+                    - description: EMC_RW2PDEN
+                    - description: EMC_TXSR
+                    - description: EMC_TXSRDLL
+                    - description: EMC_TCKE
+                    - description: EMC_TCKESR
+                    - description: EMC_TPD
+                    - description: EMC_TFAW
+                    - description: EMC_TRPAB
+                    - description: EMC_TCLKSTABLE
+                    - description: EMC_TCLKSTOP
+                    - description: EMC_TREFBW
+                    - description: EMC_FBIO_CFG6
+                    - description: EMC_ODT_WRITE
+                    - description: EMC_ODT_READ
+                    - description: EMC_FBIO_CFG5
+                    - description: EMC_CFG_DIG_DLL
+                    - description: EMC_CFG_DIG_DLL_PERIOD
+                    - description: EMC_DLL_XFORM_DQS0
+                    - description: EMC_DLL_XFORM_DQS1
+                    - description: EMC_DLL_XFORM_DQS2
+                    - description: EMC_DLL_XFORM_DQS3
+                    - description: EMC_DLL_XFORM_DQS4
+                    - description: EMC_DLL_XFORM_DQS5
+                    - description: EMC_DLL_XFORM_DQS6
+                    - description: EMC_DLL_XFORM_DQS7
+                    - description: EMC_DLL_XFORM_DQS8
+                    - description: EMC_DLL_XFORM_DQS9
+                    - description: EMC_DLL_XFORM_DQS10
+                    - description: EMC_DLL_XFORM_DQS11
+                    - description: EMC_DLL_XFORM_DQS12
+                    - description: EMC_DLL_XFORM_DQS13
+                    - description: EMC_DLL_XFORM_DQS14
+                    - description: EMC_DLL_XFORM_DQS15
+                    - description: EMC_DLL_XFORM_QUSE0
+                    - description: EMC_DLL_XFORM_QUSE1
+                    - description: EMC_DLL_XFORM_QUSE2
+                    - description: EMC_DLL_XFORM_QUSE3
+                    - description: EMC_DLL_XFORM_QUSE4
+                    - description: EMC_DLL_XFORM_QUSE5
+                    - description: EMC_DLL_XFORM_QUSE6
+                    - description: EMC_DLL_XFORM_QUSE7
+                    - description: EMC_DLL_XFORM_ADDR0
+                    - description: EMC_DLL_XFORM_ADDR1
+                    - description: EMC_DLL_XFORM_ADDR2
+                    - description: EMC_DLL_XFORM_ADDR3
+                    - description: EMC_DLL_XFORM_ADDR4
+                    - description: EMC_DLL_XFORM_ADDR5
+                    - description: EMC_DLL_XFORM_QUSE8
+                    - description: EMC_DLL_XFORM_QUSE9
+                    - description: EMC_DLL_XFORM_QUSE10
+                    - description: EMC_DLL_XFORM_QUSE11
+                    - description: EMC_DLL_XFORM_QUSE12
+                    - description: EMC_DLL_XFORM_QUSE13
+                    - description: EMC_DLL_XFORM_QUSE14
+                    - description: EMC_DLL_XFORM_QUSE15
+                    - description: EMC_DLI_TRIM_TXDQS0
+                    - description: EMC_DLI_TRIM_TXDQS1
+                    - description: EMC_DLI_TRIM_TXDQS2
+                    - description: EMC_DLI_TRIM_TXDQS3
+                    - description: EMC_DLI_TRIM_TXDQS4
+                    - description: EMC_DLI_TRIM_TXDQS5
+                    - description: EMC_DLI_TRIM_TXDQS6
+                    - description: EMC_DLI_TRIM_TXDQS7
+                    - description: EMC_DLI_TRIM_TXDQS8
+                    - description: EMC_DLI_TRIM_TXDQS9
+                    - description: EMC_DLI_TRIM_TXDQS10
+                    - description: EMC_DLI_TRIM_TXDQS11
+                    - description: EMC_DLI_TRIM_TXDQS12
+                    - description: EMC_DLI_TRIM_TXDQS13
+                    - description: EMC_DLI_TRIM_TXDQS14
+                    - description: EMC_DLI_TRIM_TXDQS15
+                    - description: EMC_DLL_XFORM_DQ0
+                    - description: EMC_DLL_XFORM_DQ1
+                    - description: EMC_DLL_XFORM_DQ2
+                    - description: EMC_DLL_XFORM_DQ3
+                    - description: EMC_DLL_XFORM_DQ4
+                    - description: EMC_DLL_XFORM_DQ5
+                    - description: EMC_DLL_XFORM_DQ6
+                    - description: EMC_DLL_XFORM_DQ7
+                    - description: EMC_XM2CMDPADCTRL
+                    - description: EMC_XM2CMDPADCTRL4
+                    - description: EMC_XM2CMDPADCTRL5
+                    - description: EMC_XM2DQPADCTRL2
+                    - description: EMC_XM2DQPADCTRL3
+                    - description: EMC_XM2CLKPADCTRL
+                    - description: EMC_XM2CLKPADCTRL2
+                    - description: EMC_XM2COMPPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL2
+                    - description: EMC_XM2VTTGENPADCTRL3
+                    - description: EMC_XM2DQSPADCTRL3
+                    - description: EMC_XM2DQSPADCTRL4
+                    - description: EMC_XM2DQSPADCTRL5
+                    - description: EMC_XM2DQSPADCTRL6
+                    - description: EMC_DSR_VTTGEN_DRV
+                    - description: EMC_TXDSRVTTGEN
+                    - description: EMC_FBIO_SPARE
+                    - description: EMC_ZCAL_WAIT_CNT
+                    - description: EMC_MRS_WAIT_CNT2
+                    - description: EMC_CTT
+                    - description: EMC_CTT_DURATION
+                    - description: EMC_CFG_PIPE
+                    - description: EMC_DYN_SELF_REF_CONTROL
+                    - description: EMC_QPOP
+
+              required:
+                - nvidia,emc-bgbias-ctl0
+                - nvidia,emc-cfg-2
+
 additionalProperties: false
 
 examples:
-- 
2.48.1


