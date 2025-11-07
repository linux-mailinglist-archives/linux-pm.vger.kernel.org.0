Return-Path: <linux-pm+bounces-37628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F46FC40C87
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F832567A45
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80B331A6E;
	Fri,  7 Nov 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="A0pxNnp/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35F32ED3C
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531738; cv=none; b=mb98Yiotz13X4ciaQqw6s77Feg4/Lq9gPWHNqB/GBaYjun9Y6mZ/pI8m9PV91Gk9mGaoqsTId0aMmaC5PHXt5j2rlNGMinxSaXcyGbSazY/2uy7QLKhtdxf2tMW7bks9ndlppGvNHD+1ZlhcW+n/hdlfgrMhDcOC1nMqKfjToN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531738; c=relaxed/simple;
	bh=i/zVTdeMZ54Xl+f6Uuj7idYd+OZeYrqPQPp6jVP3UlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfR/h6ibzejpBPG91KQZYvWS5iHn+skwvEl1IcwQ4c8dVO/bcCO73LGSBx7Il3TVGs/ynlLMLHdQz+Ep+jG5OmWLGri+nQ3xde7ysx9566Xldxt8J7sS85xFo60SF0CR0WveQbqj/bLuRVJIVCC/0pIOR/r3SjojPZj3ohO7SII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=A0pxNnp/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641458f71ffso1322036a12.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762531734; x=1763136534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMnJBfQ+JcAHBt+A0k4m4Y2IWS16rpzOGX2Y0e5bHG0=;
        b=A0pxNnp/5WoH3GCQwqTypCgkx/ftR3V6uYuZG23OoewFUrog4QRkT8WGTck6SkEn3o
         +wiiueXb+ZXDYSJS2JBDtxD39l6hV+DSrMbU9niMexVU+Sbik5O4aKfj6WjGNI0uADQA
         pa1VmeiJaY/rLXYvbr9M4ttrHX9OCRqCvwHXlrD97sP8fAgyiOIwQo9y/zsldIfdxwXB
         +luWsqsA73E6z4WaI6MSu79KD0u8SA2RZiwmesoGtabfIJa/IBKZNayXopc7RCS8WlFo
         DvBFZSYlx7QLHtMZpnAltzVrQvwa35B/K9oKou4aMedo0TSD0HM4FW/8Is969McL1GBi
         7Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531734; x=1763136534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMnJBfQ+JcAHBt+A0k4m4Y2IWS16rpzOGX2Y0e5bHG0=;
        b=p+Vl8bFeiNBEYmNH5ZSbuwzAHIs+P+7eFICYeVOmrOI5OIWDjGOzEtavx0JlcKbCgT
         5OR179VNljEQWqu3NrfoeqSerDSKECE7DA484dgDXyyIJr85sFD8pmtUHKeSNyZq5/w4
         buXkEb/K7KY63tTOvWKBSlI7th029nlpzka0HlowrsirEBSFyEwROjiimBAQgUUD7zqE
         buO7Ud867h4DisumfwkH18F0tkqALQ4RZ9QV9P2lhNOXoMkSvY4JtwN/pBAQVogGLdMt
         CvbHeOYKJggP/eLnBirkCoewXB4ALsW4J64aMKatyb6Ghk+C6wPtJmmAnE7NwilKCsmA
         H+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNduJAC3+5Bp6eIxe41hM+YkIyV7MfQw5XsR1aJ9Y216hGm4v0JzzvOxATYyXH1XqTx4xfbCHw8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Itwfn0iLG2SL119sUnxaCV5qTg0V5eykzqCpNZURlcogGqS4
	KHoBSR23jsP8CuuqSQxXIEkqTMUOIfD6rUViv+vq2Dq/4gfJhosyX1i4dZDAB7Bha5Y=
X-Gm-Gg: ASbGncsmh4Fxlbal/E/ABgOHQ1uRZZdnzQllFkpIM8enDPPO3uH/OywpUl9BsPM/Fvi
	mr1rJL2Zy2UJD9Rdnpx6xXWmVZMxoEy5FK+3ZbxnNQTFxxzAIZ7JF8dwQ/MrhM9bcaFdObCSHPv
	+DUJmLlVXyMjz2f1IWRR10+YauCPEIF4vNPnVxoatpds1171D57yU5IDnPmECazmayYFy4xOABf
	iuSroluy4jTEymKKFfEjbMMM7KT2YHUOv588GMoaFEcFRC/dFQ2UxUzcVBytXwItdzAJyaVppbX
	oM7krqIpkHrgfLMnkCAZHjb141b/j7ry1Fh+r3Tn7ELm4fmOMnLZhwTEdLidIpiy32d5RMybIy4
	U6P+LXWBBxxBOhkGMVBAmOQbL+3EDcneggfB2pmXnaoRwKR8xg1aTBg5DSjLhpfirk8f80Z4P9P
	W0rFphFE5ptHRj2pIANvwTsNxnNitrgoLrb84bxrpgY5IUZCwcYEWYYwO4zs4Zjgp4tg==
X-Google-Smtp-Source: AGHT+IEGN1YqULo6BeVvW1SEuQeF0QBYa7kxAWMnbouxC/PnpzFufbpWQvOCzdHSkpyFakInFAEjXg==
X-Received: by 2002:a05:6402:2793:b0:640:b9c5:8c7b with SMTP id 4fb4d7f45d1cf-6413ef033efmr3827798a12.15.1762531733607;
        Fri, 07 Nov 2025 08:08:53 -0800 (PST)
Received: from [172.16.220.100] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713959sm4444376a12.5.2025.11.07.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:08:53 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 07 Nov 2025 17:08:51 +0100
Subject: [PATCH 5/5] arm64: dts: qcom: sm6350: Add clocks for aggre1 &
 aggre2 NoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-sm6350-icc-qos-v1-5-8275e5fc3f61@fairphone.com>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
In-Reply-To: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762531729; l=1111;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=i/zVTdeMZ54Xl+f6Uuj7idYd+OZeYrqPQPp6jVP3UlU=;
 b=PiC3z4QTLZs98rmiEeLKQeKe7Tx7B7T3YjwsMCoa58NO85pAHVrafZ7ofCkKZne2/b+dgR8Da
 6rRb2VnmUQmA7T9eGbSGozCVKcu3EOy/cmKQgdC5w3MldBXuk2dh1z8
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

As per updated bindings, add the clocks for those two interconnects,
which are required to set up QoS correctly.

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


