Return-Path: <linux-pm+bounces-34568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF141B55661
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FDE16A7B2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85E335BBB;
	Fri, 12 Sep 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="dRLmfSxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255E33471C;
	Fri, 12 Sep 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702294; cv=pass; b=JQhtTIeN8r1a86IlCkxG9OGpGKyZaJxplnEdW7zorJnQ8Q5pjMDYcnSN5vyWhkgLw5GosV2tGH8kSVbvk6fyEFTGUhazUzSbEhzmVH0N+fR3dluxc4KDRKW0wGj2w25qEEVt27sSRx8aE8bCBhTAoyddJhI3C47qiAWMCHiCRYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702294; c=relaxed/simple;
	bh=421VgOvXlFdib7pr2C3QvpqejdW2jnU9weK0/zlHcCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvGZY6Phmg/zeqSl+lP+S8LoEGUTTe0irfzqkB1SeyAdn7THNcbJ7fM+VvPy42ETJolf57W/7ZMTsl6dt1VVH+sQe/pKt97nMnRFoq9Kridc5haoUMju8lPiiE4YuqFu36YD9lop75aQDf85cV5CbyRb+Z6vKC4SYhxj8AYJnWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=dRLmfSxX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757702268; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jp3Yjg5LkIuQKesNw6/utyRuTv0nybYZ5coe0YBXK71r24f7rdxKMI682bA6vr3KvXX+dQThuadURLrH+aj8rCRnjgvSiQoRp6FWojTRpYsllyEj5AeK8XZtdlb0cBU1LUnNQH6uQlVv+K4wfnJoXnvVdFAb6/qRXHTys8hqQOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757702268; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5o2cb+RS3e9vM6xcSLE475S0MGwfkgp0FUKoEaEDRlU=; 
	b=BLDOvsVzVwwie42bi+SVmvubUZzQ7r4CGAALrVL8n59qjbN2tDUifPqEDmUDsdkV0Ey0u0tHpVLP75AGZXnsJdJyS/Ewc2jGN1k3gNr18OsUEN459NPetRMVCzl2QIgEAg5u5vyKonO34Z3JDFFc0jKv9j61lJcF0goaDXGXSEY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757702268;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=5o2cb+RS3e9vM6xcSLE475S0MGwfkgp0FUKoEaEDRlU=;
	b=dRLmfSxXaRzFWG65htj2aEJIZWuCyvok2GtdATgyx7cMuVqUsXZA1++mspb72y9B
	gu2jp+Y3e98c6JtQliKmEnrHXojq7dDdFyNLZyX7ZBXAZztzCp5Y3vI4dJXitD6SLa8
	4knxxAeunr03KcCpmsyLb5u0RWC1PZIysGXo1MmI=
Received: by mx.zohomail.com with SMTPS id 1757702266927437.838415080814;
	Fri, 12 Sep 2025 11:37:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 12 Sep 2025 20:37:02 +0200
Subject: [PATCH v2 03/10] dt-bindings: sram: Add compatible for
 mediatek,mt8196-gpufreq-sram
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-mt8196-gpufreq-v2-3-779a8a3729d9@collabora.com>
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
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
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
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


