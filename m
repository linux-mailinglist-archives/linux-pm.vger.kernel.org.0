Return-Path: <linux-pm+bounces-40751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D5D1A173
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 17:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D433032133
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF234676F;
	Tue, 13 Jan 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AXenmkWO"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B63043CE;
	Tue, 13 Jan 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320492; cv=none; b=JSIcza/ZquvXwuXrZOYzmcSmsa74l24G4+kw9mxi2uzT1Vxd/05+VmABfH0/eIFrS5Gj/Drc/KXXjcFmWWdI/YdHMRJNk3VRITEj/8RhTj0B4sZpFdNAo9jeh+vcNZwaIlnGwPo/LZ7mcEJ4WTnBd5kECkOhrEq1n/UHN051Mkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320492; c=relaxed/simple;
	bh=XrcoqIdL7mqLMAZSLEUBjwk3677mywTfFnps1LIr2qA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQCig/njWqBIQoSeA+o8OOhLUCrYvgCt7nJ04MvMhAZ2jrCI7HsGGdOpl9Q1YeWqrkWkTdj0eFTww5BXhCDFnUHePvf49GBTZVrKKXxqwKsqU/zowcqh1VlewPdtOKEmaQ2e/L4VizpmUkEfaYa2TP5aF+hIfou60Nbc4+LTVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AXenmkWO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768320489;
	bh=XrcoqIdL7mqLMAZSLEUBjwk3677mywTfFnps1LIr2qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AXenmkWO0eq5YWShnSaSv3RU3e/vIfy2AYsdeNYFaYb63vC1Wfxa4deyTH9bKjZdA
	 zkIfbiY4MFlNVaAbEHedzyfCo5epss/7f9Fe41KSANOp3W7SJ6jqA3jj5IhjA5cHfp
	 jXMlLjN45Ix9TjPtsQyew8bp+hTWRzToGrBW5tPz9k3W8mUlOtHczuEQWkOnA7tK8E
	 iY9NUTgtz4t5KziPuiYtjkxoj+jZ53hT/w1WayTNHan+buwycMpWWBUpp5tYW2wFgK
	 8AtxVdb+UXSRg183npbS02u28cojtXfs1ns0AwIVQsmKKaVZDsyNpBbd/6qiSZ6l89
	 DWmoRged+oF+w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9819B17E026C;
	Tue, 13 Jan 2026 17:08:08 +0100 (CET)
Date: Tue, 13 Jan 2026 17:08:03 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Make MT8196 get its Mali GPU shader_present from
 nvmem
Message-ID: <20260113170803.6e5ebedb@fedora>
In-Reply-To: <CAPDyKFqkPg5rWYk7cwDywRn_pexQhd2V3R63atjruJnSpYxfZQ@mail.gmail.com>
References: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
	<CAPDyKFqkPg5rWYk7cwDywRn_pexQhd2V3R63atjruJnSpYxfZQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 12:52:13 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Sat, 20 Dec 2025 at 19:50, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > The MediaTek MT8196 SoC's Mali SHADER_PRESENT register does not list
> > only functional shader cores, but also those that are fused off to
> > improve yield.
> >
> > The SHADER_PRESENT bitmask with the one fused off core omitted is to be
> > found in an efuse. However, the efuse address is considered
> > confidential, and is not public knowledge.
> >
> > The MT8196 GPUEB MCU, which does the power management for the Mali GPU
> > on this SoC, knows and reads the efuse however, and exposes it in the
> > shared memory intended to communicate state to the application
> > processor. Reading the bitmask from this shared memory area is the
> > vendor's intended solution.
> >
> > This series models this in the binding and implements it in the
> > corresponding Linux drivers:
> > - the mali-valhall-csf binding gets an nvmem-cells/nvmem-cell-names
> >   property to declare that shader-present is in a different castle
> > - the mt8196-gpufreq binding requires nodes to expose the shader-present
> >   cell
> > - panthor checks for the presence of the shader-present cell and uses it
> >   as the shader-present value if it's found, instead of the Mali GPU
> >   register contents
> > - mtk-mfg-pmdomain becomes an nvmem provider and will happily serve
> >   queries for the shader-present cell
> >
> > While it would be preferable if we could read the efuse directly, it's
> > not possible as things stand, and insisting on it will just keep this
> > hardware from working in mainline. Running a GPU workload with a
> > SHADER_PRESENT bitmask that includes a faulty core results in corrupt
> > GPU rendering output.
> >
> > Modelling the mt8196-gpufreq device as a nvmem-cell provider however is
> > not lying about the hardware's capabilities, as it truly does provide
> > access to the nvmem-cell, even if it acts as a proxy.
> >
> > From a bindings and panthor perspective, this is also generic enough to
> > where hypothetical other vendors doing the same thing (even with direct
> > efuse access) can rely on the same cell name and implementation.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>  
> 
> I have applied the pmdomain changes in patch2 and patch 4 for next, thanks!
> 
> I assume the gpu changes will be funneled via another tree, but let me
> know if there is a reason to keep these changes together.

Yep, I just queued the remaining two patches to drm-misc-next.

Thanks,

Boris

