Return-Path: <linux-pm+bounces-34673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A56CB57D76
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 15:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FC81887CF9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24214315D44;
	Mon, 15 Sep 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JaPRdf93"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123630DEB4;
	Mon, 15 Sep 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943293; cv=pass; b=ZZd2fg7b3Ryev9d1rALQfenm4hlhRTRkApkMMoURkfzYEQNCJRgf1Z15Jzjbfe/wl8UwRtFMqZWclC2BuqScauRScP8s2kNKEojEOXi5EuNZ6VJsYlgxpn8bDUcvVnyLHYuWOYjns7wMIdhDZHh9Vj8CFDHx2zJ3LI092OOeKMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943293; c=relaxed/simple;
	bh=20jyikSBUeyT4vng1BVzWe3sjyLs9KnrE87dBoLvcs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qh4yUZAH55JeQPwe66fpt8U5oN1vWy25/ggeexIVdZDdjRzyKEeXMVyy9rmHBHUnDyGcyKe4la5NIScSk+9ibxK5CTHoTO7xSq3Xx7nq/nm20IdSkfT1NC6444P85F6nxc85geYBJtQQ51qhSvllbuJigk0cz0z/7mGnuveOF1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=JaPRdf93; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757943252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VcDt09apkXkUPqUSPhPe0SRA9p6NfI7eRJdyWIzzMch+7gA70FlWYClpkVNNIDkCRiW8FjSk4Z4B0ESJYO6ee3Mlz/gkfx/iJWer9WbPVPEtVsJXiEcOoEjm7g2UC7Ot+rHWU+Fl0cau77lVf/DMf4j8OHIwf3C+ZHKk35G4tX4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757943252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JXcBaV2RAfDhKm8EZS+sK4enClIyf2ne3a1dilgi9xY=; 
	b=TLTGdSYp4xC65jkTH8EN2lCbZa8kV7SXj7dnEKDproxSS9RjaoOppJIrePAdJmvnR7je8IyXb3JZZR8D6CA1Q0tB4xBalsHeEpAr4aeyiqmq5RabIjYC+ea5kgJd8cBYQhDku2sTVXW9FNPPms9YH4I+nIUxYMN8esoQEuGg1Zg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757943252;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=JXcBaV2RAfDhKm8EZS+sK4enClIyf2ne3a1dilgi9xY=;
	b=JaPRdf93LIE/7iVb2KC2EHXu+4sEUuVS7aGz2C8x1og5DPXPLyjvMplIhLuE8pZ3
	sQZuJgHphctSz/4SpJF+nPCqdjLwyZ+xH6or/X5vg//iZsA6ebKGVWP762yzDUtydcm
	ruB1tsNh7YV1r7BrDX9IbzmU+/qmOAPgM+fOii0k=
Received: by mx.zohomail.com with SMTPS id 1757943250997458.89106567723354;
	Mon, 15 Sep 2025 06:34:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
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
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
Subject:
 Re: [PATCH v2 10/10] drm/panthor: add support for MediaTek MFlexGraphics
Date: Mon, 15 Sep 2025 15:32:23 +0200
Message-ID: <117198807.nniJfEyVGO@workhorse>
In-Reply-To: <ae482072-c13f-4cb4-be26-50592b086fe6@collabora.com>
References:
 <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
 <20250912-mt8196-gpufreq-v2-10-779a8a3729d9@collabora.com>
 <ae482072-c13f-4cb4-be26-50592b086fe6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 15 September 2025 12:28:09 Central European Summer Time AngeloGioacchino Del Regno wrote:
> Il 12/09/25 20:37, Nicolas Frattaroli ha scritto:
> > MediaTek uses some glue logic to control frequency and power on some of
> > their GPUs. This is best exposed as a devfreq driver, as it saves us
> > from having to hardcode OPPs into the device tree, and can be extended
> > with additional devfreq-y logic like more clever governors that use the
> > hardware's GPUEB MCU to set frame time targets and power limits.
> > 
> > Add this driver to the panthor subdirectory. It needs to live here as it
> > needs to call into panthor's devfreq layer, and panthor for its part
> > also needs to call into this driver during probe to get a devfreq device
> > registered. Solving the cyclical dependency by having mediatek_mfg live
> > without knowledge of what a panthor is would require moving the devfreq
> > provider stuff into a generic devfreq subsystem solution, which I didn't
> > want to do.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   drivers/gpu/drm/panthor/Kconfig        |   13 +
> >   drivers/gpu/drm/panthor/Makefile       |    2 +
> >   drivers/gpu/drm/panthor/mediatek_mfg.c | 1053 ++++++++++++++++++++++++++++++++
> >   3 files changed, 1068 insertions(+)
> > 
> [ ... snip ...]
> > +static int mtk_mfg_eb_on(struct mtk_mfg *mfg)
> > +{
> > +	struct device *dev = &mfg->pdev->dev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/*
> > +	 * If MFG is already on from e.g. the bootloader, we should skip doing
> > +	 * the power-on sequence, as it wouldn't work without powering it off
> > +	 * first.
> > +	 */
> > +	if ((readl(mfg->rpc + RPC_PWR_CON) & PWR_ACK_M) == PWR_ACK_M)
> > +		return 0;
> > +
> > +	ret = readl_poll_timeout(mfg->rpc + RPC_GHPM_RO0_CON, val,
> > +				 !(val & (GHPM_PWR_STATE_M | GHPM_STATE_M)),
> > +				 GPUEB_POLL_US, GPUEB_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_err(dev, "timed out waiting for EB to power on\n");
> > +		return ret;
> > +	}
> > +
> > +	mtk_mfg_update_reg_bits(mfg->rpc + mfg->ghpm_en_reg, GHPM_ENABLE_M,
> > +				GHPM_ENABLE_M);
> > +
> > +	mtk_mfg_update_reg_bits(mfg->rpc + RPC_GHPM_CFG0_CON, GHPM_ON_SEQ_M, 0);
> > +	mtk_mfg_update_reg_bits(mfg->rpc + RPC_GHPM_CFG0_CON, GHPM_ON_SEQ_M,
> > +				GHPM_ON_SEQ_M);
> > +
> > +	mtk_mfg_update_reg_bits(mfg->rpc + mfg->ghpm_en_reg, GHPM_ENABLE_M, 0);
> > +
> > +
> > +	ret = readl_poll_timeout(mfg->rpc + RPC_PWR_CON, val,
> > +				 (val & PWR_ACK_M) == PWR_ACK_M,
> > +				 GPUEB_POLL_US, GPUEB_TIMEOUT_US);
> 
> I wonder if you can check how much time does the GPUEB really take to poweron,
> just so that we might be able to reduce delay_us here.

I already did, that's where the 50us value is from as far as I remember.

> 
> > +	if (ret) {
> > +		dev_err(dev, "timed out waiting for EB power ack, val = 0x%X\n",
> > +			val);
> > +		return ret;
> > +	}
> > +
> > +	ret = readl_poll_timeout(mfg->gpr + GPR_LP_STATE, val,
> > +				 (val == EB_ON_RESUME),
> > +				 GPUEB_POLL_US, GPUEB_TIMEOUT_US);
> 
> Same here - and I think this one is more critical, as I can see this suspend/resume
> control being used more extensively in the future.
> 
> Specifically, I'm wondering if we could add runtime PM ops that will request EB
> suspend/resume - and also if doing so would make any sense.
> 
> I am guessing that the "suspend" LP_STATE stops the internal state machine, making
> the EB MCU to either go in a low-power state or to anyway lower its power usage by
> at least suspending the iterations.

I think I briefly fiddled with this but then it did nothing other than
break everything. Is the current time it takes to resume a problem?

> 
> Of course - here I mean that we could have
> 1. System suspend ops that powers off the EB completely like you're doing here and
> 2. Runtime PM op that may be called (very) aggressively
> 
> ...this would obviously not be feasible if the EB suspend/resume (without complete
> poweron/off) takes too much time to actually happen.

We probably don't want to aggressively suspend the thing doing DVFS
while a workload is running, and if no workload is running, it
already suspends. I can't really say how normal desktop usage will
play out yet, but generally speaking I think it's a bit early to
find a comfortable place on the transition latency vs power draw
curve at this point.

> [... snip ...]
> > +static int mtk_mfg_init_shared_mem(struct mtk_mfg *mfg)
> > +{
> > [... snip ...]
> > +
> > +	dev_info(dev, "initialised mem at phys 0x%016llX\n", mfg->sram_phys);
> 
> I don't like exposing addresses in kmsg. Please just don't.

It's a physical address. This is not a kernel pointer, but something
that can be read from the DTS. But sure, I'll remove it I guess?

> [... snip ...]
> 
> Cheers,
> Angelo
> 

You can assume me not responding to a part of the feedback in this
e-mail means I'll address it in the next revision of the patch
series.

Kind regards,
Nicolas Frattaroli



