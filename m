Return-Path: <linux-pm+bounces-41001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2BD31ADD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72C15306E442
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835B26C3B0;
	Fri, 16 Jan 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="T+o61sVb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC7524E016
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569450; cv=none; b=XGFWmw9J5NkwGf+93dKZAq5kgWwQjLIoYS94Hg3CE2gXPr7qaPxIXwKYmStX8YO8oAK19uoRty5Hdzr7OIh/pSrrKJLwkZsF6C1M2pk7hp1qgACFL+DN4J9YomToo1j5P4O2t2eNsH57piBEZDU8nOGeYCYtQXtIoy2mGlhM+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569450; c=relaxed/simple;
	bh=RFosUcjwMh27o+Q0KFX/mCWwbK9ioGqTrDSRkowE9Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXsfH7ytnJrFz5+koV43+47pBWmHcLU8IOKLuI+Sd2kuJ3d9XBvRm57ZZNNI2hfX9mpBH5/+50p+v9LYVzpMXJIL8/UPvdHN4b634SuCD5wN+0gD0kWlJabj7u+14csZDMn+MDI76fzQJLRy2PonnGwOmOIwFTT8p4vCK2i2QMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=T+o61sVb; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so3192943a12.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1768569446; x=1769174246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcR1dmGQ0EElYWldmNS71m4JZ3C7rndmOwBL8aoBqb8=;
        b=T+o61sVbhnn6bIlhuZLu1xPXtQuo7Zgxn5V4NGuWt+DLSSWVRdwFdR310OwQ1ow2PM
         XANcXOm3h+RcOCLupWMZZsqijD5HCN77RoC1k3j0THCKzBaWuUEvdtrkgNMdyP+OjL77
         JLmwD/qtKTFyMmjDwjbPLCjsve4XV0kUgPKvXwqBgPsmgmkphct6BzNzZin2tRvD2fo6
         sYmwY3tjwujcfZ/LpypN5qFJ8ib46Clqa/pdj31jcb6LJO0dfU9VSusbL3mBehZG6F7j
         3VZne8gDet1U1TXj7+X3vruzKOgY4CETPTedN3wBD/8b4nPSaU+EWLxZAEsLCek82DE3
         Hi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569446; x=1769174246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wcR1dmGQ0EElYWldmNS71m4JZ3C7rndmOwBL8aoBqb8=;
        b=aR7Nv2vmAZrUG6F3eyZCUIbyDAkDLgpVWf8sKdYlAgPvsZm1Md3/teg9oEq9pG05gY
         dygSX7Cq378LymiBPa8KMoETc+J+COYe8ilwYMbOMPtNFMmUzw4x8yzmn007cyTRvurq
         sXwM3McaUyFDwWZCxslyWpYy4fVIkipjRT9/jH+ikZmW4nmGKuXhjgUb+MqEglFUtpDe
         h5xwYHgqsVt83RvRjG2w0qbR+zxNkmXr3UN/tD5pY+bAreKdzxqJztv7r8oGliGSEYhG
         4vN2sAqzARKa70nqlahpmUiQqKgidcqX8JK9bYPIvyz0KujTKT6ohdCYqwb87RUmH7p8
         Px0w==
X-Forwarded-Encrypted: i=1; AJvYcCWN6SFmLHlsC3w1Zoiho+OZPT6wEoRqKzdL8rzDK0JVW8hTtH22C/U7/dguImWR7dSxdqPz/SJL+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93A7m1WyyeHPZjq2tKtccItC0GSvJkf5BPbKEnh9krQX3ACFy
	Jg3A06bVzux4kAV26NVqNazuVGAdMtv9I/7hwLHeKZQqutY47w16nqs7pugnsNeowSw=
X-Gm-Gg: AY/fxX5P5SXvFGpH5VBcGdsTCJF64h58CMfwPSJPiDgIb5tYqM8l6YFCdDI+DjpnZeg
	k8gqdoljFxtoaM7uMxq3KCcWB9t5TQ/3CY//ibYxosjfcqrE6gx9s1/qb4CKQOk2qUoKoMgrzzn
	Xw45y6JjOtdgP8EYEVN//C9GZcC1mVqlKrxHR7nSW80pgGZPEsOlaumMfPWewraRPMm0/+yexXy
	bZgFjUkUXhRWw1LQ4ckCi2OEcXWSxkUCCPqcBVFRWm4Mq0fYt1GiM5JPJ/tsOFVX9JbC+N1a+L9
	+Tp1rUVxH2A1a3FcWBBJkwxRbxkjLpz3n5u4FhTNTjGsFJyamI4HYK5CLTzutFPo/6Y9YsGXE8p
	PXifQPWTwwCmxASEKBGWRLKceAsIp3O3vE1fBUSkkbPlhechmGCUksF0i8eOLOOMM43EdBMbkpf
	H1UMZMnHwUno+IJg88C1zgxIS+aqZcfduwIzDh2ZiUsfq0tDI9ZdLQXRu6/SXGCUV7
X-Received: by 2002:a17:907:6ea3:b0:b7c:fe7c:e383 with SMTP id a640c23a62f3a-b87968e56f3mr211104066b.22.1768569445696;
        Fri, 16 Jan 2026 05:17:25 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a350dbsm235507366b.69.2026.01.16.05.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:17:25 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Jan 2026 14:17:21 +0100
Subject: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
In-Reply-To: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768569443; l=1598;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=RFosUcjwMh27o+Q0KFX/mCWwbK9ioGqTrDSRkowE9Gc=;
 b=F3TPfwyBjFhqKF+HInQg1A97Mf+OjLhk6olL+d0GTCGtvDhv0vHvyzaFIZ0sGqrZJTnArQl1p
 Qj4XSnuvOF/Ast/91GKxv4KyvwPnFE8nsTermX1yRcoTl4vnkMG8kVf
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document an interconnect path for camcc that's required to enable
the CAMSS_TOP_GDSC power domain.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
index f63149ecf3e1..707b25d2c11e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
@@ -25,6 +25,10 @@ properties:
       - description: Sleep clock source
       - description: Camera AHB clock from GCC
 
+  interconnects:
+    items:
+      - description: Interconnect path to enable the MultiMedia NoC
+
 required:
   - compatible
   - clocks
@@ -37,12 +41,16 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,milos-gcc.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,milos-rpmh.h>
     clock-controller@adb0000 {
         compatible = "qcom,milos-camcc";
         reg = <0x0adb0000 0x40000>;
         clocks = <&bi_tcxo_div2>,
                  <&sleep_clk>,
                  <&gcc GCC_CAMERA_AHB_CLK>;
+        interconnects = <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+                         &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ALWAYS>;
         #clock-cells = <1>;
         #reset-cells = <1>;
         #power-domain-cells = <1>;

-- 
2.52.0


