Return-Path: <linux-pm+bounces-33958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483CFB45491
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E907A427B5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773982DD5F0;
	Fri,  5 Sep 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cpZi6IsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D082D6E62;
	Fri,  5 Sep 2025 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067862; cv=pass; b=hPyjhXhwNrP59hekqTygG+A5oJ0iM7ZetuQSAkzzJYdFT8beNTSxOkZJnD/IoNMP5uXLiUnj7LZ9e529cqFx8pHtpZNGHvxCET43Ho+xWCdMoX1y1ea0WwQye6qpRGnfK+MG9FHHE+XRr6z6YW2AFPGEBda3DXoH13h9g+ufmm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067862; c=relaxed/simple;
	bh=Wk1WuCPAy63+DfPu+yCY5hSD1PmaFUWsdVDHkjsS/+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQwE3Bekr2Yx1ba5SnTYwKa/bH2IQBgZBGhM/UNqVTMTopX8aMdSer9hpxLqrnWWAZ861ujBxnibt1f9KfaHWYsTFmPYCq2wpZ11xjvk8smueMfiPHbce9ZEvcXxH4azHof7omyOat1V4ENvzMqVsEbNYkfTWXrkb0QXG/WA4LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=cpZi6IsO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757067836; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ATg3h1zfv3/jS6zXhkHRoPD3g9DIqIS+2eN2G4Jo5dnkbCpTKlN97xxnoMyqm+4VEEpq8uKQ4WNKloi2BB983gMCvWM4lTZJ/sSsB3MwL950b0VxSTCrNMRVZutQD0vA2bYko24KR/29ciL0w7IH54uP3eZWncEGMZU6BgGpsnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757067836; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mG1dwW8e+KHt5M47urUQVsE3NGGmomoS29HjaU5lJmw=; 
	b=SoCr2YzRUQWKK3GYq4uMzKPrwztceuMJHaOjBv8SSvqMZHU/VyoxwMCEpEtO62onwgNhocPbEU5f1UyXobly7dnv4RxSk49+euG4EXYuXJkjd6bX3URLE69dLEXrHSACDEwG+BXoalm36VHTp5yR1Zh4xDuP0HXWEoKBcDTIWRk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757067836;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=mG1dwW8e+KHt5M47urUQVsE3NGGmomoS29HjaU5lJmw=;
	b=cpZi6IsOGzsNtksRZR7kgEozkeRs1S/z6eupPnXQ7jCjm8Molu0n31MS0CujbVAH
	JEx+Lwi2KkSDkymGRZ4yS/shYv/yhDUBx4EpLgsqpbIOjb4CEgxAxXSD907vhyBjlCN
	TonGngEYG+70JBlUgPfYDMAJ055NKA04HXLjDQKU=
Received: by mx.zohomail.com with SMTPS id 175706783425443.237791990502046;
	Fri, 5 Sep 2025 03:23:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 05 Sep 2025 12:22:59 +0200
Subject: [PATCH RFC 03/10] dt-bindings: sram: Add compatible for
 mediatek,mt8196-gpufreq-sram
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-mt8196-gpufreq-v1-3-7b6c2d6be221@collabora.com>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
In-Reply-To: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This compatible is used for an SRAM section that's shared between the
MT8196's application processor cores and the embedded GPUEB MCU that
controls the GPU frequency.

Through this SRAM section, things about the GPU frequency controller
like the OPP table can be read.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7c1337e159f2371401ae99313375656fff014ed4..6ba0dd6a66def11f56a1d5276d7397b655bff11e 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -89,6 +89,7 @@ patternProperties:
             - arm,juno-scp-shmem
             - arm,scmi-shmem
             - arm,scp-shmem
+            - mediatek,mt8196-gpufreq-sram
             - renesas,smp-sram
             - rockchip,rk3066-smp-sram
             - samsung,exynos4210-sysram

-- 
2.51.0


