Return-Path: <linux-pm+bounces-38581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F3C84E7D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2854E9A5D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310631A81A;
	Tue, 25 Nov 2025 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUXRuzwi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78D319852
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072396; cv=none; b=N8UwF3r8Jr6JLBvdU88wfW5mqNzyXfYHZivGcqJu3M2bE/M6Xu/2zNimYkgekhwoBIsZgTMWcWdHZXRW0UXujB+bYa35/FOpJlnlW01SxAke+ieOyveZ89kY3542unQs9Ff+1zkDUd8YMeg+AGs5Dkv0WTCS+Vg9HC9vo2wV6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072396; c=relaxed/simple;
	bh=23kuWoTWNKvhOROVMoXGvX+wd8gYIFlqPE8dKxScrdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjtVf2mpjbUPffvVLh4lv5Hm4pM9WIdvPbs8Qyyre0WWApCHP/r5rUZMkwFSsRmAyAdv4v83xPp2XYQUAUirVEU8vs3Z+DlyMPOd+R6xuHEn12/Fx/TM3gNNngOeP+zWQejPvbyVbzY7yGMQkD/zU9q6/6SsCDpBFr7SA7YvCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUXRuzwi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so5964029e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072392; x=1764677192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMCaC95H9hS9yxKlb4Uz3MEUVo/SgdFt0jQNHE6SwU0=;
        b=ZUXRuzwis3BHnptx7LFgyUczJ4vAiUvSBxicbHjW5XC8ihOS2YHlel+ntZ41QZy0/p
         TFkPR0sjj81hCTQMpRsK+6fWsmdzM6sJZ4gWsASJ0dwfsTN559qDBeyS2lUh0qLJqbkp
         xg0k77O1FCQ0iy8h4uBRV0DjGSV9TGgZrIdpq5WJVQGkxv6EIeLfbKQgXy07LPD8vaWt
         3ZK2sHUPJBQl9jV4xO+cb/f66SYYq2ijreGbL43aEUxIBM/564JRS+ScjEYZqPKCk1OQ
         jbg0tSNFvRonPPR/tXEj665yB8fKIOmGRdeSNrG4o1HR1qMIXCx5MRNX9WIAUnQJZ4XW
         Doug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072392; x=1764677192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lMCaC95H9hS9yxKlb4Uz3MEUVo/SgdFt0jQNHE6SwU0=;
        b=k/z4oOlQbmAlTlK4EcbEhDlxgXJyHpSwajB96aC1hl/zmWfuwptSVRSHzdxcUaRKUu
         uj2HWAF+ZKIamqfuTY+MzPBzyeJfVXXQlsDgTix5Hf7LuWCsFy1SqfcBAF8H4G0ImJ3z
         hFwgkhds13qCD/1OYC1+GnpJ8f/PL6gj9RgH0qNp1BP4aAiRk9cGpYO3Vy3iioFVRJse
         LZoU2u/ccOy+O+cp+ja9GmMOHpAgudENXrEoJ6sVcW4yF29dkizvCVRjZ1x+X50pOU9x
         FNyqAxPLrKkpMMpdUtlTjf43tIzK8QoVvn/YzoKrUie99Cw7DR3ZKIsXJZ3cdPYbL+Hw
         hT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUqiT3rlf4M8guhQfwnLQD7kA6kU6MY1hycrUg5EuC4+5ERCKLd8etgumD8pqP+bnoj6vV1VxowZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTFKOfBQQPilgXLGbHDkoIgfb7f3mpXOC4zz14QHNS8JZhVIr
	Hj8MIONY5zX4CYLJOmSvfNtfcuWcioUNHl9PfPCYgFbloU2SG1PLVSz4
X-Gm-Gg: ASbGncvuLCyWAIjrNFs1rvooxDVsXVeo3skqF4R3TvVBtsH8CCPCTvWG4nGzQ9kgCsx
	pdAl+DEfUFnFGDaG3DC8L/YoC7C6L9ALS9kETzgQ7Ul8GJSnHbwVVFxhm10r4yXy8CMLnCpfcmk
	eeCUio/1hU64xrThjtFsYO4hj3oqYsXGNWVy1l9niLbxJTe2KwOID7naRUe2OmZCNC30wFeIY2z
	ZyZYjQ8ZgszE24GFHiztrp/zScQJzHTRkC4dsbB3Cb3WcnCU2cw/d/gyg9cwBrg/CPYTj5ioQzB
	vLc/AN1+BBlA8g5tVhk8AOdZbhpJ7e7EeggsAtDCc7JsNb+g9o3mRZmZTTjS+gQrKH6FjbKqUen
	fSMQ3Tkle0QtKsLoRv2JqGiN5ZjcAKvyOvjCxoUbPEXj7ns2oAKz/TMChj/2L2febJK9FUTbzqL
	Y=
X-Google-Smtp-Source: AGHT+IF6vHfga2SRbBlVN5XPN/hZcnukK3C8CPi+5DnZqYSQF6ScQiOLUKDEqTQnFS5G246k7ucsWw==
X-Received: by 2002:a05:6512:3d9e:b0:595:997e:19ad with SMTP id 2adb3069b0e04-5969ea31e39mr6934217e87.21.1764072391479;
        Tue, 25 Nov 2025 04:06:31 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:31 -0800 (PST)
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
Subject: [PATCH v4 10/12] ARM: tegra: Add External Memory Controller node on Tegra114
Date: Tue, 25 Nov 2025 14:05:57 +0200
Message-ID: <20251125120559.158860-11-clamor95@gmail.com>
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

Add External Memory Controller node to the device-tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index ef0618e9eec1..a920ad041c14 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -259,6 +259,8 @@ tegra_car: clock@60006000 {
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+
+		nvidia,external-memory-controller = <&emc>;
 	};
 
 	flow-controller@60007000 {
@@ -655,6 +657,16 @@ mc: memory-controller@70019000 {
 		#iommu-cells = <1>;
 	};
 
+	emc: external-memory-controller@7001b000 {
+		compatible = "nvidia,tegra114-emc";
+		reg = <0x7001b000 0x1000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_EMC>;
+		clock-names = "emc";
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	hda@70030000 {
 		compatible = "nvidia,tegra114-hda", "nvidia,tegra30-hda";
 		reg = <0x70030000 0x10000>;
-- 
2.51.0


