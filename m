Return-Path: <linux-pm+bounces-38026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC33C5C5E9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5957505544
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FBC30C354;
	Fri, 14 Nov 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Z9LjKBF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3760309EE1
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112682; cv=none; b=NQpC2Uy+URr938Vg5Kb1gWyunKB37GOu/WN3hWiiDgsQSsHxQzqD//5IJbY2B2jguAAP0e97ss66NRRLTOeMvh9apJTFwxWV3u4Xa8iQ0aUseAxjpPYN5xscQUU2Ra4F4C3CScMdmDpC+jSqI1eLBWZ/MDNZL/EUXx5qF4Xrj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112682; c=relaxed/simple;
	bh=yqSzDl1RCaX1HaatAeY54OvImk7Uy4nbr08LYmEejV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i06HKYENz3k4T4/82E/cMywP1BZlGicOwUYsQJXhf/f/2uCd/0P6Cfd5l1B3SSCbFz3uT4QBNOXMCLRM8/DwA3NS27DOYrZ0uFEJOrUVR8YT82HFJd5o2C/MkaT+9vNZXke1COTksvGj6I/aIvXTpcf1ITbzrGcKlzDudBVf2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Z9LjKBF8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b736fca06ceso38840866b.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 01:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1763112678; x=1763717478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGrlm2KDEYQBkPU0sl6vfScVs7XruSklBsX2xoEpkVM=;
        b=Z9LjKBF8QIAttioZ4H5QqVr3Zg0mSkNjrgW7DFzeSyUmdiJQNhwmxCA26l3hwJFCPy
         0weMZ7GoLBMoYFI/tDPSQ3nhVyp07IWhtwYlemQSnxaJ0bsBIcKITUXsxRW4kNxQzqtR
         A1ulJyFxd3Vc7xPVBoemqK3VAgnoxvLR50EvQOWgwHOKBAs7kHZ64VlS2kZE97HqA0NB
         SGdQXXPbEKHkKlTM0zS7xTTKumdZlHELH2rXiUyVqW5c6bqZ9fsCXX3WepYGxbIXXaPk
         DXGdKwi7zjI4AGxULNEVg7/4NsIFLYOsOS5sMZBt1vaQk/lkYy2aXmCCDu49lZ3kcFQZ
         BJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112678; x=1763717478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGrlm2KDEYQBkPU0sl6vfScVs7XruSklBsX2xoEpkVM=;
        b=GAb5Q1opN4mJq8fBfh8wuCavKbECuidUdlzQJkHmRoiyRjouXDpCCAagIe3yPDqFW3
         E3ZensrXvwuWW6DHKQYDd5XldeVn6UQwMgi3TXUW998fFTQvPZ+TU2dKwGypeaFjLOVk
         jKYGuaNeX8aGqySMcTqFdNYo6cQnojN25THIY1ikOZBhpDEPfcfkgQdQL227C3HpM/U/
         +7oy3y3QAs1jnSpCvzrZg593qWCyMnKYZRCQOpJimCsYzh/TvOCtsjMlPlVaI1hBFdgw
         Uw3z11zCJsO1E1fUfKgT7EscCTAjakbJZ8+/9sfrPGghqLboeqi0GC2uPtG5+eKYq7Pv
         MZAA==
X-Forwarded-Encrypted: i=1; AJvYcCXrtafdLpUgbN0zyKQrWDWwm1UHJv4qvJyRaULeSzRT1RhUSlv2IHllRbiwuiajGfly3wqJyt+kAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjfKhyqSZg5hKvdpwaPFQwgW493ZkRm5z7wp8ZE/q28QIWGrk
	Beu7ujpyxmjt19vq7fyc2/6leJ3Z/H0QEqbzshYvpaiZocCPXwBtRg/yeyEsE3UYtK8=
X-Gm-Gg: ASbGncsR6wqFUIRjAKADJE39zMj6EaUjMWFQukd9J21ExlyuyeiAAbeHZyAZrvr88uX
	Lj5jpdFc5Dm/XFMX9nJZEnSRH1yfAPLWIVAfIsqV0yLsp+G6nAztgRDuVVGLXKGKMQC11i06+TK
	A4IRwDKllRK/ZKtsaLFXu/Q8kO/WVUloo0pYmZ/bxsTVrBOxYsBsbotk503TuVaKOQJ9Jzz+oZi
	+IuroWeY3OBjTxkMNU7ImJ8GZqUXG+1JIs+BViCk7JqIdctiTS1pO2wPo7QAR6y9oitN9xHupCU
	TAE6Cj58Ubl+s23wyLtUbpBk7VV3ztaURS5vnsGx15ojoW37gsEYpfJWIOqsyyk9vc1hc1ChDhj
	A902ClI3O5nQLm8n62Jx7+ALEtTgb8knDKACZo8I8QjsGbdxDXK1s4VGGRwuS5bCXsLfqSxOnMK
	cpPxFEgYfuw7sDPTvRhuMJiBFryV9mq3dMpD9toYTw9OZrdvY3B+keZo/QNpbWSeGQupkkBVNMH
	vdIYen3NERaOIbZMGPdAtTcQ7on6vX01w==
X-Google-Smtp-Source: AGHT+IHbspNfvp0BB+3bdchp4IaaSftVO6pWYPFt2UrlG+9T2k7g+b2H48RGzhLvNurmLynv9vS/gQ==
X-Received: by 2002:a17:907:94d5:b0:b3f:f207:b748 with SMTP id a640c23a62f3a-b7367828a3amr228193566b.10.1763112678188;
        Fri, 14 Nov 2025 01:31:18 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0509-ec01-156d-fa6e-7f19-0b67.cable.dynamic.v6.ziggo.nl. [2001:1c04:509:ec01:156d:fa6e:7f19:b67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80841sm352104366b.41.2025.11.14.01.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:31:17 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Nov 2025 10:31:13 +0100
Subject: [PATCH v2 5/5] arm64: dts: qcom: sm6350: Add clocks for aggre1 &
 aggre2 NoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-sm6350-icc-qos-v2-5-6af348cb9c69@fairphone.com>
References: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
In-Reply-To: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763112672; l=1239;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=yqSzDl1RCaX1HaatAeY54OvImk7Uy4nbr08LYmEejV4=;
 b=W7BMtEgp86OWP9elRKZT2HdAsIQfo9CAk8g01x3SXHE/0H2boM9pmBZ725nJeP6VAilJKtApj
 ykB0iHKUnk5AYjrbO6ASakwvkyOqRfqLjk3NHLAxRm6WS3dDleMd7ch
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

As per updated bindings, add the clocks for those two interconnects,
which are required to set up QoS correctly.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 0c9dc596aa2b..c9a812bc256b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1117,6 +1117,7 @@ aggre1_noc: interconnect@16e0000 {
 			reg = <0x0 0x016e0000 0x0 0x15080>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
@@ -1124,6 +1125,8 @@ aggre2_noc: interconnect@1700000 {
 			reg = <0x0 0x01700000 0x0 0x1f880>;
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
 
 			compute_noc: interconnect-compute-noc {
 				compatible = "qcom,sm6350-compute-noc";

-- 
2.51.2


