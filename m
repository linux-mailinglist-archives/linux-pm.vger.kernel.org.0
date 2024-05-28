Return-Path: <linux-pm+bounces-8286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3352B8D23E7
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9348AB22CA5
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68E17B4E5;
	Tue, 28 May 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VRhjGJrE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD9172BC8
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923037; cv=none; b=BW1eBeRu7qnhRFhI4OWF1EFDOuCbGSqs8Z2ju4hTsjmwNHCA56nz84xYrIlVKpA8gvcvm7Bx/Zokkf42PVrtP9Op/QFLkI9Ou3SRwJcCXguXkcoRJo3pNfX0pT25N4Gr5sWXHQkXGiC2+J3rFXv0vChP+++YGpx7CLMesBp0mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923037; c=relaxed/simple;
	bh=6z/qJnjZFNUbmAlLhny56elZj9ozwT+lQ2sCSVhGFpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7inrtG9JpLqcRLwU7XnZNhyo8yRXlPwtCe/jR9ukHGW5Ag9lUaP+tM2+WiwY1kaT/jnx9PnGHcpYQ00pOpIWviXfxIE22n8I8ezBF3wzHmumyrqHrtgPWSE432lz0UkNriX3OM4vswh/tXlg4WquvmWavLHREju/v4Uj5ZGkeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VRhjGJrE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529648cd69dso357356e87.2
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923033; x=1717527833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huLiadmUz+IKovUjcSJbnzDkoK16xIfjWSoucG+1C78=;
        b=VRhjGJrEQ4c6ui95u4MjV1KZfQr2ZqloPTAyoyPRE0wswNjsCBdkDjRY1t51msMO5k
         +ciLIUgXBkCRqnP5sSb8tjBC4bgAwy3RRuPvB/3tR95W+ttWJX+UyVmwPvjKaOF2v0FN
         GRSxnRtVd0aYnRzW1bGQYyDOSSbKmmC9Y9s2+WQ1Z4JITMRX+R6HnK1ayDMIsZsC+prD
         md0Xs94Ni+3odVcBvgzR2yJ5F/cvRs2vyQ2y3tWyrt0bm2UXwJFaPbmDtOCB9pheJrik
         gKASDFradg3RomXicH5aLFYqIFhJyXK5qp58MYEqY5LLzKwr0kr7FaS9Jr4t75+Rc/Lh
         A1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923033; x=1717527833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huLiadmUz+IKovUjcSJbnzDkoK16xIfjWSoucG+1C78=;
        b=Nku0NK2m+wbVdih8wOu9sXnDJooF7xF6HFG5TSpc0Np0ZFcXBW885Y6iSZzmNDSmWp
         HIZkYJleJc1oR/YLLEujKc2Ac00PZCcauWGowOCH29S0rQWjgHakdxDaDl1oUP7XrY7Y
         femBP8THR7h/erwPEUAiG2dFPnm6lnb6g38ox8DhyHUuOGFMPcor+QqnPM7+Iaq2520Z
         dgQ0ppW7XAx7SuTUq0mRClewcLxhxOljF8q0FJm8krVPGFgXJiFsdHQeWsYyOeq0GGXr
         olaZ7/14vWcT3HLNEbLZy5TA6TkReTpf0EF1v4IQi0y0xv3VhxAHdnlOTIZIBmWvtto4
         zSyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfd35IGVDUDhhWQzehfg7zI6xf63Mee9zPnqGxrVkHw4s7JrxnnLLS7b1FFVUwzao5u/gvs1zYQ5qaROZDnmPVIoQLIr8ZI2g=
X-Gm-Message-State: AOJu0YwvypH+u/DP3gikxuR9Kbur8B8So5QXq97Lm88xha26D82h08x2
	0tAPD0WSiL02dXTOfxI7DNiK39Ixa93nTZtWayvR0Yw/gsANmo4zc9VjdiN3HSU=
X-Google-Smtp-Source: AGHT+IGFGGk0GMudsEze7kMtpyQJ8IBvfOB3ee+pM19AIHFnbjGqUee/tlRtalt4CsxR0dQKz7CsVA==
X-Received: by 2002:a19:f017:0:b0:51b:4df3:540e with SMTP id 2adb3069b0e04-52967465414mr10858521e87.65.1716923032974;
        Tue, 28 May 2024 12:03:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:12 +0200
Subject: [PATCH v8 04/17] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-4-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=pd2tdTUrKzxnMcTe6bYRN1TYgIvngJc2eLHs9UA91ec=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqN+kfChui5js4evaxmA30HWm4lKFUb+3rJ2
 Yb+lm7qdqeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjQAKCRARpy6gFHHX
 cuhRD/4laLPrXaMS8hVWtDgWhYJYFOorDw9gabUO1iP0fRSOx7T+NRx7JAG8R0dmDflPmpm9lCz
 nYYQtKqqc4GHl1szH5GAemRFwnZhPLkn34Y8dNBt/puruKuDEAgVFnQhsugClW9kytmY9xut0aF
 nSbanQgQjgLSlumQr/lVE+xi36pVpg7h3p9cNbUMyIbOxHb8AWptNw1jzp6E2DUJ6s2Sh3CNUWC
 gwE2YEppiAUcHNdfPv8HJNciTJr2Rpw3F91K/ZqwzPKi/TB4N7aTwjYizPoK/R9owVtBq6cfl3G
 JplasZ3EhcP6sKcxBBxsYs2VYbPeue4f6/oYHBBa2QtgUkkqEBRJ8x2iuZwS7/nRIPj/EZ8l0ob
 Vgl7spB52PHoGQOqjq9hjOSz9Z/D62D62pJgBPFMbwVdBrBdpDq9jryH9JI9PX8t7uBu7nxyyiy
 CC1q99TenfPStNBerx70x3TW4vnd6LYewxyPukvGVGk7FPqlyqsTyoP9a5g5r5dULN3kuZZWZ4m
 LckKHfbaBj9e+YO1DsF0MSF8DiKjQt2kQTuSx8sryZO0W816+/8ul6v8IyR+Kd7TpXhi4uFhzzZ
 /CQrRYrYMMwSdL3R9u1l9zJV5qh5d4AzfkSpnG8UIHgPWmjiMpkPd5kElyqWK/fi9/F1crbZERS
 YtG7I7WjbIuzAXA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI compatible for the ATH11K module on QCA6390 and describe the
power inputs from the PMU that it consumes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 41d023797d7d..8675d7d0215c 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
 
   reg:
@@ -28,10 +29,55 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WL_CX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WL_MX supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p7-supply:
+    description: VDD_RFA_1P7 supply regulator handle
+
+  vddpcie0p9-supply:
+    description: VDD_PCIE_0P9 supply regulator handle
+
+  vddpcie1p8-supply:
+    description: VDD_PCIE_1P8 supply regulator handle
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: pci17cb,1101
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
+        - vddpcie0p9-supply
+        - vddpcie1p8-supply
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


