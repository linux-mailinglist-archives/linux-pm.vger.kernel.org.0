Return-Path: <linux-pm+bounces-35214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C12B95B28
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 13:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8654C7AFF81
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D078322A27;
	Tue, 23 Sep 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SjDTYPMl"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBB322556;
	Tue, 23 Sep 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627665; cv=pass; b=GBpHEOKvwNX8nB6JUFBzTho3/8t02aUC/wTFYBr7Ove8NYSlRIcSkTpNmJNnupeKGDS9sVjdciRQkiXb63flo7ZJRiHIzoGj9xn/qLu0wVcv/RBMBu1qvivWkgdgXEQDEW+Q5IHZdX5r8ea1QPKzhyC4Vphe3QlbBLTi0RrcMBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627665; c=relaxed/simple;
	bh=hwRx1Snwe4/smiV3oh27+kUr6txpraDNs10MyGQOegk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIne1Y1p4hcD+4rwckcu2nYj+np1GOuFs7E5d782EvhyBOYUElctUfIKEb7R7qUs3LmShQEHScMrSAL9W4tsoON9nZJYZap0qpdCZ7uv/7jqiSKEOjOjCk0LUFDThie3OEWzqtkziJj/XPXzFyfYtgl9u6TVgbjMoaWndSJ2LA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=SjDTYPMl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758627640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rgp8McNENZzRnj2r1cNqPvFh2g+a6ag6snGvabEghvVvFrIi37mqpGzlV0mznEZE0xI5/uIOAGdYvefreSxRaCX3vSwuFYvn7XjKIdRs2O3NvYUlMJDOMYBIiA/qMPFIKOs5HjJXXBZgo2QZpKWphMLhhKkbtnQVE6QpcbKXifo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758627640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SbWzV2vPE++u109IpxS5OpTrsMRMsUHWUjB2MEW5hF8=; 
	b=bHzkaqSxeXNfUSm+xRWZGbDUIWj7tlo6MBlwWas8rDDCDISr6Wmn287VB1io7qqQdfuxVFk9REWnWttaEZG1IYetaY6G2RPbJ4U7JjQK9lxiw/54J820WTzhcTVXIrNSPWphmxmU1mRfAcqHe9RQ2naC+X/rg7L/dHKh3b67dI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758627640;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=SbWzV2vPE++u109IpxS5OpTrsMRMsUHWUjB2MEW5hF8=;
	b=SjDTYPMlppu83vvOIAFjFcZiwoAhoT3OHvazmZAM5Huv7Mf3qKtr9piqiMREAbjO
	iPH2nKg7ONERCDhI/NBvmf28158Ui4a1h6wZGjeiETmAHzVqUCV1pGMP6GtWaYYAfMB
	tPKb0ZABwnFZqYBYDnz2y1IYWIY0jUWlZ1dvzhBk=
Received: by mx.zohomail.com with SMTPS id 1758627638907817.5750146025789;
	Tue, 23 Sep 2025 04:40:38 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 23 Sep 2025 13:39:56 +0200
Subject: [PATCH v4 3/8] dt-bindings: sram: Add compatible for
 mediatek,mt8196-gpufreq-sram
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-mt8196-gpufreq-v4-3-6cd63ade73d6@collabora.com>
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
In-Reply-To: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This compatible is used for an SRAM section that's shared between the
MT8196's application processor cores and the embedded GPUEB MCU that
controls the GPU frequency.

Through this SRAM section, things about the GPU frequency controller
like the OPP table can be read.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


