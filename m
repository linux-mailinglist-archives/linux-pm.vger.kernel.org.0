Return-Path: <linux-pm+bounces-21828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D176A30C2A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03F01657F5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5E2236F2;
	Tue, 11 Feb 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qx0ux12T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90921D59F
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278610; cv=none; b=CixNzsXley8A9m+b4fQKvdY23h7qVEDZSmfhSY5vEyAM/XrfUr8JytnYylhLAwfSGWGY1XND5cLMqson0D/SK9rFp1HFhGp3kYR6Dsu18yo3YGXC80+kf4ZD336XXb8KEjouSrDRdMaomvh+sv251ROfpEHVtIVna/d24QNij/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278610; c=relaxed/simple;
	bh=ZElkFFNaQVfyA6jlsV48V8/b9aHZJZEVfmq9Tnxd/qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB83R3nGga0UDLozl3i1cw7UvbGAG3WDUeBc+h1McQ59JuTyABbnwuAbcMdOFPwIVk2Jp2KjDIhnNlgq09eiLUTLZcbyIbr8snp44Jt0tb4Q3k4zDDVAy4wNnorne0ZabRJ/Pig/qFye6pXcDDvrfflWLFv3AIsF6RoXcUMPRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qx0ux12T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43937cf2131so19078605e9.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739278605; x=1739883405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRtaCX/ZKHIEgnZuN9eTd2vxVIRxRn4dVC3Yg6NlT3k=;
        b=qx0ux12TudTCV7TObn0KyRRvJCxlNvo0dKuE5uTwuhdiYcKKZ4CUCxv3LGXkNFzR8w
         sBsjJQo3rL7fdmBoh8N7tJh4Qd/Vjj0vkXhnNrLmoAjX3P6YZ5PloUfTUSMXUNr06olJ
         eCnTAX9YXDuBHJZmn6nnirCYWMtA0rPLM3FbFo72NvzMz2dxbpTX26T1D0cWMOzr8c+3
         VKLmGX1pJ/UKeE9sXlNvCAd117AP+NImGmbUUs5ZiOkMJHmGEhetnIqkkbrB5+1zYObm
         ec4pKrwLlWazYJPAFLTlM8XvEVJPyLMVyDQxmPyLu906Ggzax4HUe7c8+3YcYUUQgZw9
         429w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278605; x=1739883405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRtaCX/ZKHIEgnZuN9eTd2vxVIRxRn4dVC3Yg6NlT3k=;
        b=JCkuDzfbH4Eo8cL+VrXr+zZqUTK++LBh8I4E8x+QwGcK7VVVAF7ejes8zEMbD2M4xZ
         6uH/r80US6nweE3TmmG7Zowo6Jgsc+OYlP9IBXdeTwFXizDPmhlogfkZheQDjfKsGQ1E
         z0z3TiAGdYeiL2hyiRm/vTp2DF5CKD2HoWZFkkShZ7NuAKm40EKGhp23MUmGcLqz2ABN
         ZMgGCRTpVjzgbYpU7iX6haG0AbKcfuDzSv2wrotIwaXSNYN/61g9HV2L7e/c12Bw5an1
         mVVT+UYxN9ST5Z6WVA5MKt88avekxk0mLNV3VVR7KFiktRmSce4lKf8HxNBLKJgAHyLB
         jT2g==
X-Forwarded-Encrypted: i=1; AJvYcCX+3jd4QMptPNFHUNnrwOCEOy5I+EwdgaoWMic5ubv2r6lGL39rjgnvrdmySFr5PJrPgnxKrUjoCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzltsedFhbv0rln21euyWPXr34wIXsrFrvZ+eyIxL+yy1hZZOn6
	HChUtX6tzraZPXiBfxeUQmEq/QQ4WXXc2m9/jrVObKIZJk7UxTBV1d+1W2JjBPg=
X-Gm-Gg: ASbGnctHV+MQy9FTIwuLxjfqs030qRLYRhNbkpLPiWvNwUB6eAXBRq7zi0Nn/ZlYU1U
	hk5m9bOjatBvYAye1MVojYn0rqGwRTbpNyz+f8liNsyLfGAN02G49+P6rhC9y1hNmSrHB4+gLQZ
	oxaxuzxeoxgllLln+tOzqm/KSBAyHfGfaPddkt7YYJ5QAPcOcOpbyC1nWRiStkQrjri64dCVqv+
	6Jv9k0FC0zsLUbDjQir0v8uShUUOqmLGztDoHAEWaJ7Z22y+ncxsD1zA09XATrJeklI+7w6xLb5
	MUC2Eo95oHahvVkMAqh2+DCma5J4fl3SFXu0
X-Google-Smtp-Source: AGHT+IEPBEgV8VC333Tr+Op0prDfAr6OQ0hPkR2+9gUCR63TMWh6MweTEaEpo21ums3GIMmkl5R69g==
X-Received: by 2002:a05:600c:348a:b0:436:f3f6:9582 with SMTP id 5b1f17b1804b1-4394c8185d5mr32223915e9.8.1739278605262;
        Tue, 11 Feb 2025 04:56:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc73c2e00sm12863078f8f.57.2025.02.11.04.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:56:44 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 11 Feb 2025 13:56:39 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8650: add cpu OPP table with
 DDR, LLCC & L3 bandwidths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-topic-sm8650-ddr-bw-scaling-v2-3-a0c950540e68@linaro.org>
References: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
In-Reply-To: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27062;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZElkFFNaQVfyA6jlsV48V8/b9aHZJZEVfmq9Tnxd/qE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnq0kJOSnWe7bsNJuxq5CRowrKCu0GSXSGV5/yJnmM
 f5ZqTTGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ6tJCQAKCRB33NvayMhJ0bYvEA
 DMB5PCrwNlm5ouTaYtl46+5FicraM6qdRQLMJFaQeGNRRQs2wM1YPM8bLe8qB9Qgox26DAD1VKfd6q
 iIKx+65A9qOCqWtucD5DXDWf+a82dO1ut5ktiPVkJMoazOOhffroC6jFzCa3paeVjIS2x5yFxU1JIR
 D3bRQofQFYVzxmbqRm7a/HHPGu+0QdUrxg3t+Vg3qmFKKVsMHoWygQTtldffUw3diFdIT3zGr0qDvS
 pJYuQUIURCK3bYqsukPS3D/3iON/d4Wnzx5lbJKJ/Ny49AOQWirV5rnR0CKS/lGgxap9Rq3Ht0PN2y
 gis5HyUdb+NEWmEi4FiBkSWaN2qMYgkOqgXsOKUXr2NFUa4p5Ln+ft5uh1ZhCGl5W7ExknQcShxLiC
 BHehSIafypPmcbB7Xh/aZ+mjAkt24aVDdjbm/aMf8M3heMyRNTPcLlQWoC9v3g0VT/+kGVd5Q1gPoW
 7/yVvtTRuyx1EUn69Kmp0jF2le2T9zmFJ44XgTBFVeGVqHhOm0Pnv1RKdAqwF1OzxWq7H4hsfbHXf1
 E3BgaPSqf2/PBDVsINKHfRo/WWVc+iwQmhmFmbKC4kRhnCt05UYHMRRASsIvSTsXtymv5z0UImFE2C
 IeHiqBIwPxInLZbq6kQvYswiZsrszQZrpcADT+b1JdUf1r+44u5EQYLZbLIg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the OPP tables for each CPU clusters (cpu0-1, cpu2-3-4, cpu5-6 & cpu7)
to permit scaling the Last Level Cache Controller (LLCC), DDR and L3 cache
frequency by aggregating bandwidth requests of all CPU core with referenc
to the current OPP they are configured in by the LMH/EPSS hardware.

The effect is a proper caches & DDR frequency scaling when CPU cores
changes frequency.

The OPP tables were built using the downstream memlat ddr, llcc & l3
tables for each cluster types with the actual EPSS cpufreq LUT tables
from running HDK and QRD devices.

The cpu2 and cpu5 tables are similar but must be kept separate to
take in account that they define OPP for shared CPUs of two different
clusters that can scale separately, thus vote different bandwidths.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 876 +++++++++++++++++++++++++++++++++++
 1 file changed, 876 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e194a95cdcc0f0f692e62b942331cd9e07a4eae0..09cc884f0969432c53671e804ec6a3f7643fc0a9 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -86,6 +86,8 @@ cpu0: cpu@0 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			operating-points-v2 = <&cpu0_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -126,6 +128,8 @@ cpu1: cpu@100 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			operating-points-v2 = <&cpu0_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -153,6 +157,8 @@ cpu2: cpu@200 {
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
+			operating-points-v2 = <&cpu2_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -187,6 +193,8 @@ cpu3: cpu@300 {
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
+			operating-points-v2 = <&cpu2_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -214,6 +222,8 @@ cpu4: cpu@400 {
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
+			operating-points-v2 = <&cpu2_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -248,6 +258,8 @@ cpu5: cpu@500 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			operating-points-v2 = <&cpu5_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -282,6 +294,8 @@ cpu6: cpu@600 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			operating-points-v2 = <&cpu5_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -316,6 +330,8 @@ cpu7: cpu@700 {
 
 			qcom,freq-domain = <&cpufreq_hw 2>;
 
+			operating-points-v2 = <&cpu7_opp_table>;
+
 			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
 					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
 					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -483,6 +499,866 @@ memory@a0000000 {
 		reg = <0 0xa0000000 0 0>;
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-364800000 {
+			opp-hz = /bits/ 64 <364800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (384000 * 32)>;
+		};
+
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-672000000 {
+			opp-hz = /bits/ 64 <672000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (729600 * 32)>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (844800 * 32)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(466000 * 16) (547000 * 4) (940800 * 32)>;
+		};
+
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <(466000 * 16) (547000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1132800 * 32)>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1440000000 {
+			opp-hz = /bits/ 64 <1440000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1555200 * 32)>;
+		};
+
+		opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1555200 * 32)>;
+		};
+
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1651200 * 32)>;
+		};
+
+		opp-1939200000 {
+			opp-hz = /bits/ 64 <1939200000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2150400000 {
+			opp-hz = /bits/ 64 <2150400000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2265600000 {
+			opp-hz = /bits/ 64 <2265600000>;
+			opp-peak-kBps = <(600000 * 16) (1555000 * 4) (2035200 * 32)>;
+		};
+	};
+
+	cpu2_opp_table: opp-table-cpu2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (844800 * 32)>;
+		};
+
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1075200000 {
+			opp-hz = /bits/ 64 <1075200000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1382400000 {
+			opp-hz = /bits/ 64 <1382400000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2131200000 {
+			opp-hz = /bits/ 64 <2131200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2380800000 {
+			opp-hz = /bits/ 64 <2380800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2438400000 {
+			opp-hz = /bits/ 64 <2438400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2515200000 {
+			opp-hz = /bits/ 64 <2515200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2572800000 {
+			opp-hz = /bits/ 64 <2572800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2630400000 {
+			opp-hz = /bits/ 64 <2630400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2707200000 {
+			opp-hz = /bits/ 64 <2707200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2764800000 {
+			opp-hz = /bits/ 64 <2764800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2841600000 {
+			opp-hz = /bits/ 64 <2841600000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2899200000 {
+			opp-hz = /bits/ 64 <2899200000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2956800000 {
+			opp-hz = /bits/ 64 <2956800000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3014400000 {
+			opp-hz = /bits/ 64 <3014400000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3072000000 {
+			opp-hz = /bits/ 64 <3072000000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3148800000 {
+			opp-hz = /bits/ 64 <3148800000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (2035200 * 32)>;
+		};
+	};
+
+	cpu5_opp_table: opp-table-cpu5 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-460800000 {
+			opp-hz = /bits/ 64 <460800000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (844800 * 32)>;
+		};
+
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1075200000 {
+			opp-hz = /bits/ 64 <1075200000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1382400000 {
+			opp-hz = /bits/ 64 <1382400000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1440000 * 32)>;
+		};
+
+		opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2131200000 {
+			opp-hz = /bits/ 64 <2131200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2380800000 {
+			opp-hz = /bits/ 64 <2380800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2438400000 {
+			opp-hz = /bits/ 64 <2438400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2515200000 {
+			opp-hz = /bits/ 64 <2515200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2572800000 {
+			opp-hz = /bits/ 64 <2572800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2630400000 {
+			opp-hz = /bits/ 64 <2630400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2707200000 {
+			opp-hz = /bits/ 64 <2707200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2764800000 {
+			opp-hz = /bits/ 64 <2764800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2841600000 {
+			opp-hz = /bits/ 64 <2841600000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2899200000 {
+			opp-hz = /bits/ 64 <2899200000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2956800000 {
+			opp-hz = /bits/ 64 <2956800000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3014400000 {
+			opp-hz = /bits/ 64 <3014400000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3072000000 {
+			opp-hz = /bits/ 64 <3072000000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3148800000 {
+			opp-hz = /bits/ 64 <3148800000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (2035200 * 32)>;
+		};
+	};
+
+	cpu7_opp_table: opp-table-cpu7 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (307200 * 32)>;
+		};
+
+		opp-614400000 {
+			opp-hz = /bits/ 64 <614400000>;
+			opp-peak-kBps = <(300000 * 16) (547000 * 4) (499200 * 32)>;
+		};
+
+		opp-672000000 {
+			opp-hz = /bits/ 64 <672000000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-787200000 {
+			opp-hz = /bits/ 64 <787200000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(466000 * 16) (768000 * 4) (499200 * 32)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1075200000 {
+			opp-hz = /bits/ 64 <1075200000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (844800 * 32)>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <(466000 * 16) (1555000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1305600000 {
+			opp-hz = /bits/ 64 <1305600000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1036800 * 32)>;
+		};
+
+		opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			opp-peak-kBps = <(600000 * 16) (2092000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-peak-kBps = <(806000 * 16) (2736000 * 4) (1248000 * 32)>;
+		};
+
+		opp-1939200000 {
+			opp-hz = /bits/ 64 <1939200000>;
+			opp-peak-kBps = <(806000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2169600000 {
+			opp-hz = /bits/ 64 <2169600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2342400000 {
+			opp-hz = /bits/ 64 <2342400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2380800000 {
+			opp-hz = /bits/ 64 <2380800000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2438400000 {
+			opp-hz = /bits/ 64 <2438400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2457600000 {
+			opp-hz = /bits/ 64 <2457600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2496000000 {
+			opp-hz = /bits/ 64 <2496000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1440000 * 32)>;
+		};
+
+		opp-2630400000 {
+			opp-hz = /bits/ 64 <2630400000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2688000000 {
+			opp-hz = /bits/ 64 <2688000000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1651200 * 32)>;
+		};
+
+		opp-2745600000 {
+			opp-hz = /bits/ 64 <2745600000>;
+			opp-peak-kBps = <(933000 * 16) (3686000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2803200000 {
+			opp-hz = /bits/ 64 <2803200000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2880000000 {
+			opp-hz = /bits/ 64 <2880000000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2937600000 {
+			opp-hz = /bits/ 64 <2937600000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-2995200000 {
+			opp-hz = /bits/ 64 <2995200000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3052800000 {
+			opp-hz = /bits/ 64 <3052800000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (1843200 * 32)>;
+		};
+
+		opp-3187200000 {
+			opp-hz = /bits/ 64 <3187200000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (2035200 * 32)>;
+		};
+
+		opp-3302400000 {
+			opp-hz = /bits/ 64 <3302400000>;
+			opp-peak-kBps = <(1066000 * 16) (4224000 * 4) (2035200 * 32)>;
+		};
+	};
+
 	pmu-a520 {
 		compatible = "arm,cortex-a520-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;

-- 
2.34.1


