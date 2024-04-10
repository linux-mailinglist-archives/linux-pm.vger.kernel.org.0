Return-Path: <linux-pm+bounces-6187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0413D89F2BA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3691F25AC4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BA15DBA5;
	Wed, 10 Apr 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="v0YhClE5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69515ECEA
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753221; cv=none; b=Pa9fDLXy9mycaJQsBK4h0N9OPTsaqKHz04NxEVUZGcBeHwTUK2iLvFIB4JZifuv0FIl4f813SM+QEA6qk9RGkkOG+jPzEAySAwxl4eWsLiZi18OiOUvdCg6R7RFDiu4YLgLS1Y7eg4Y/uYuTirWSYXnH5AgAxOMvjFKgaHaH+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753221; c=relaxed/simple;
	bh=hfgHIMnmFRtgUtFw/WNES77oLFQa+HHCcDhOj+ME/vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TD4Z5h3kPt79t28RT4lIaST41iakdrqmjjLjyUSUM32nFdjrWwU4yugWwkRnt8MuCCEm1dQdKw3dtxtMlVZwWPwy1GDl61SxqLQAMhTYYnAjw1tmD/7J6H3aqAKn2MTmTZsUn3QZ2jZlp2P4F9xz2xiy/F8fEiRopkME5sStiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=v0YhClE5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4155819f710so52841915e9.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712753216; x=1713358016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGOfh5Up2s4Hsb0xRVMMugzy1VQqOQKd6pFoEiLe/18=;
        b=v0YhClE5wSMArSLzH9M/avXIhn/TOqlhw9bW1k57yC19APfsTGunH0/PkHEi5sVQ3R
         1yJW52HPrYAqBwCLCA6Qrnd1DOHaL3AR44+L97O3eyiqTeLdPlc6iBt6SlE9pqc+OFA6
         X43r9eFaW5rMCv1WboUFO1Ihme8V/sGTG9GC9D0qZAjbXQyI8w5KMiqMR3n++45UMFkI
         gFoe15MQGeGzUqRZDFXJbWF4d7bNUN69cpEYbJwTd9iloZO4M70CdzZLRj3zkzy8vr5R
         edG9L4dyB//bhvIKY2xXTZfC3tHna1qzxBhezVebfgL93PGKWnJ9f+OG1563PtrCr8Ev
         MOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753216; x=1713358016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGOfh5Up2s4Hsb0xRVMMugzy1VQqOQKd6pFoEiLe/18=;
        b=d2V8J18WU5t+C2RTVNV67j7yEUaupz83ZbikwQR18IwyYfXAVCp/KOnE2xP0+FEsv5
         6lJSmOhLfeAMXMbgjM+uBJW+EJryMyP82lhV10RW/mSv2Jtc01XsQELkQebOqEabIFnu
         1jqQKga/O3my4W5SM0wq6KpWLq5AGl1RVV+LA8mGmOJfIQ1kibaN8iF7mCY3ixDM2B/D
         DlVNFcLJAqiHAoEc5LGQOZnm2AeP6hlSnyOYNUZBjeLg0lzJQgdGhYwaqnJ1rdIolWoi
         XE1WtbAwEG8JXYbvQfl7UQnnbXLiuVA3GB+qL4GWmZX8oilOv99Qjy3N9qBHX6DhHC2N
         1Thg==
X-Forwarded-Encrypted: i=1; AJvYcCXu9oc7kn9y5eaiIG943PbmkV/WJk7Y+b1HrszBpBsXlZZYaHfpZtwKrvCy2MikDZVLiDDgxvsYPGyFDGKr+1MdM2v8/j5EzNQ=
X-Gm-Message-State: AOJu0YwgzPtuXs69wMGZrsixZgs7+FeHQfraM255WWI0nTUN2ctlikJH
	fVfxZ1CTT7rj4On6eLpWyEN9oYkTg8ypa4TzS/XPyJPrOoBqidmuzSA9IVixzmw=
X-Google-Smtp-Source: AGHT+IHuiQPNEhSs2alAkar6Ry8nKKjPSw5soWANGYDXELipXJ0jnxe7ZElulh4MMYxeQapVJ/PgPg==
X-Received: by 2002:a05:600c:350b:b0:414:868d:1cbe with SMTP id h11-20020a05600c350b00b00414868d1cbemr1909889wmq.9.1712753216245;
        Wed, 10 Apr 2024 05:46:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:6908:7e99:35c9:d585])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm2150929wmn.45.2024.04.10.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:46:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v7 04/16] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
Date: Wed, 10 Apr 2024 14:46:16 +0200
Message-Id: <20240410124628.171783-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410124628.171783-1-brgl@bgdev.pl>
References: <20240410124628.171783-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI compatible for the ATH11K module on QCA6390 and describe the
power inputs from the PMU that it consumes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 46 +++++++++++++++++++
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
2.40.1


