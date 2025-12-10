Return-Path: <linux-pm+bounces-39376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690ADCB1A0D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 02:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AF37310AC16
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 01:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05722F177;
	Wed, 10 Dec 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="TKDHQREs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CF230D35
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331031; cv=none; b=Xt0LrUNTBi2O5gIkm+uOOC9sBzf3+ym8PBMVR+bTSyN7Z8FlXaI6B7oA7ovKeCEIE/toxWK87oLfxShWQzFLADhAI42bzywUTEzSpiAymkARSe4LUxT3BphWA5DXiWSHOCvfFxUb2siez+naU3XtzWVVJZlrVzSmUYFS1PDi3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331031; c=relaxed/simple;
	bh=xhCXot8hsmFt2DLcSKtSiw4vNTASFIkZ8KLq7GSl+P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H09ks1IVjx57iks4cDHLzUCcpTyYmxrM3//oVrVyhza1hHDB+C23iMrGKUIMoCaEzo85+iFNBfDVdo7WFfnmIGW+5kOecKdCAP1b6puebW+YH8fJa1yDRcmik2D9Yo+Y1GjNFpg4anvV3nNDTYHjWATT47CxRYMKSA6Ip3kwzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=TKDHQREs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477563e28a3so3078725e9.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1765331027; x=1765935827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1N0IBwFgNK9lNAZzgqz99M2zuZW1zwkUP1bnHP+9GJI=;
        b=TKDHQREs54sbkjIhQkuFn/XV6kK+54opSLZ6QEKOAU5/EbEJ2CZTvKFZ8x7Cw63YEM
         k7rXeKv01RwL8bSnW6aKACEBZGLkZspsEGtiFumr9SkkUAtSNR2BxyBPy8oLJnxe9tDT
         4mzITkCSGwMNHrwR6vIA+V+MamKRLq5smB5EnbslbX5XQIh+BcsfiHLPf5UOG7HtMY/F
         p1nb37fs1mHyp98HeRV3h1dmcIAdq62loFtp6G2PVmMWhcHGEsVptY11sEVQ+KzzGpzC
         AnQoGjGyyd171mH7fBbh9SY4KorjMHVr89t3Lj9J4NXw8ZAOmHPZD9TpZ9XppEH3AArL
         3Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765331027; x=1765935827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1N0IBwFgNK9lNAZzgqz99M2zuZW1zwkUP1bnHP+9GJI=;
        b=QP7hTZd6NnMGJDAc4Rz2EMWf6jo0dYrP1jHHrQL1v3oY+l3cmFL3STaUtQIndqoBV/
         rK/CxkF9waW70AwMUi0zWu0nXyMTL31CcrxsIxylMiBbJR/3UwLKtSeSGXk+3RyGGrnP
         /LCi7KuTcgxH42kFD0wqGhI80sSUyRO2aBi6HWIrZx9O2H21jDnIgePfKRPXXLLFUS0P
         e+WHdpOxaNnap3Tj7FUuVMj9xo4eRUxGl3JCw8fNcr1al4TTAYv2AMU5hjqzJd3nxZAn
         lpNIsDyVW4i2CyVtO4uJg0wyy0SAo3ZYAaCniQLdm4UpjWDQ6nzrztBaUDvlr4tlh+sp
         LgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/+sqkMWCqgY92+gV5qX+DZytKc9Mj/5TdDPAJPGdKDzNfANqf/kqyMRfU0rMFZV4tptdiD3sIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLmKwF00TOtDhJvJ4gRK3+/VZTfrQFwwXCfet5A0f2tlmdtC9
	5zrPXHdQVYub3yj43DdCWpz7pFp89k6WXjgtrUWa7B8k0+2CP2E3q8L++S8GGCCyBQA=
X-Gm-Gg: ASbGnctOQcPt50E0ycBoP471bgmFr0jDyHaHPxjmRJadjYRTS0RyKh7Url4pjcYUphC
	iwch+cPr+48rG8YYp4FDMKI35eY9ylbLIgG+gHWOYSmwkqst6ikT5aPok3AqscVCCfll6qY26VL
	7GpDeSBuSS6vKxRa1DVMHoH+nbSCcYjSBSTugMX12IrpYxGOhCJNFDxQPaQPuMT9j9oPxxjqkNa
	mlkONc+FO6L+ltmAb1lJu3iHGpB7yGgaUC623lAZiLLD7tF4dUOjUdtjs0efvI1JBidkeuSJxXV
	1etIYpOEllagsVo5IDALdMKdW2rUN8QOWpReDOho782iijZujUlbzecrAFVp8V4QeBWHm6tR2Eq
	5yp08UdxuptpTxgU+uJwxg3c/NtzqwCKhqCrQuIsmoq95qYvRy3tcSmVq94gFW70Gsk9QTJUNzZ
	UV3k+eyU1PXcittqeAUINDQVtTGXljlxUkxMxdNwREdzhC84jcWg==
X-Google-Smtp-Source: AGHT+IHIpDjAlaX67+EUBebH5WfoD8XeTaU8Q1moEvenJxA2sXGjjcYDyHTWr5ZiRpqzWMTjThGA4A==
X-Received: by 2002:a05:600c:4341:b0:477:14ba:28da with SMTP id 5b1f17b1804b1-47a7f919251mr23649585e9.5.1765331027253;
        Tue, 09 Dec 2025 17:43:47 -0800 (PST)
Received: from [10.200.8.8] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm705234a91.6.2025.12.09.17.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:43:46 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 10 Dec 2025 10:43:26 +0900
Subject: [PATCH v4 2/9] dt-bindings: crypto: qcom,prng: document Milos
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-sm7635-fp6-initial-v4-2-b05fddd8b45c@fairphone.com>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
In-Reply-To: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765331010; l=921;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=xhCXot8hsmFt2DLcSKtSiw4vNTASFIkZ8KLq7GSl+P8=;
 b=uiHgbBzSh/cvk/RRJg9TS9wPZ3NQ27X91ICPemjxsmFWX4ZAsH6iHP01WgSN8lo1qZwesg/1h
 kEnQZwCIdjIAGmxpMUxDCitqwcrIBDFnbc/XAkCmlbc6L36YYyelCEc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document Milos SoC compatible for the True Random Number Generator.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 597441d94cf1..a9674e29144e 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -21,6 +21,7 @@ properties:
               - qcom,ipq5424-trng
               - qcom,ipq9574-trng
               - qcom,kaanapali-trng
+              - qcom,milos-trng
               - qcom,qcs615-trng
               - qcom,qcs8300-trng
               - qcom,sa8255p-trng

-- 
2.52.0


