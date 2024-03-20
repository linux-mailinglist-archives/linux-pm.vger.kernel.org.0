Return-Path: <linux-pm+bounces-5168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3363881949
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 22:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3460C1F2232A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36785C42;
	Wed, 20 Mar 2024 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PuC7LEMR";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="mSTdvtuz"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252C33062;
	Wed, 20 Mar 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971548; cv=none; b=lesAzpvny6FqiWYCFyhL2GYOKWbwFaGXKpsbgtY6xgGtuSCzicDYIq9Veyiy/4Hd+MxeL8GvRyzzjWNSgMd30Osmbwp+ZTmpa8CEdnPmQBYGNyvl1/xKl7/iiXHq6k9Z9Y+VdG3XitKDoZ/JgC9qrEfJzZVuryR1/+7Oc6g/9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971548; c=relaxed/simple;
	bh=e2r3a9OUT67BeS0KOQ2laDNvlxbwQEjUIU2HcUwGQBc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YPxyho6O5Bte5ysvonh7PLa6uDLn6DOzj3lRBtDlv4QBtu8Rl73A5aR+3oXuylGZmT0T+69h4BWVIgE0ZYAx/ljxLuelUlQjEpmCWvmWZiioB+zni/Kd2Dlf4W3mO+kPxFPKR4x2S0tvbEfIBzNJBOX+yCqG+hsCDIiS+vvuoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PuC7LEMR; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=mSTdvtuz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A5D1E7E88;
	Wed, 20 Mar 2024 17:52:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=e2r3a9OUT67BeS0KOQ2laDNvlxbwQEjUIU2HcU
	wGQBc=; b=PuC7LEMRVEoziVdJVWuQuIavcZMrcthhG23/wPYxLyCiLNURdfzvdF
	UPHHM5r6mOiaHMhwFr9MmsFzuNQJXY4hjhjskXq5PVLfmFa1uMThZ+Zjq6EbTpP5
	b504Bc5TwfDiiRr/ENVf+0pHRXvmD9IZlRCKm57xWqROZAxB2RFLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B73A81E7E86;
	Wed, 20 Mar 2024 17:52:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=e2r3a9OUT67BeS0KOQ2laDNvlxbwQEjUIU2HcUwGQBc=; b=mSTdvtuz0uwoVvK/km4jnKpaAAXB1iriSgCSK6dwLOO6hLCCLjo9dP5e9JfejrSx+BuudkEB0OTDWjMiq+YH/mZUzdbV5jCcStAtyH1dHjQaG5CCJVuUxv+VA1ilxR/1qmjM74vB3B4GR+E6ojueD4bM0DrW307bKbyOO6AFdEU=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34BA51E7E85;
	Wed, 20 Mar 2024 17:52:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 251E6BEA1E6;
	Wed, 20 Mar 2024 17:52:16 -0400 (EDT)
Date: Wed, 20 Mar 2024 17:52:15 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
    linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/13] arm64: dts: mediatek: mt8186: add default
 thermal zones
In-Reply-To: <34e75ebd-b01c-430a-a051-47489492c189@collabora.com>
Message-ID: <ron9o4o3-qror-o1o9-3911-7189925o1os2@syhkavp.arg>
References: <20240318212428.3843952-1-nico@fluxnic.net> <20240318212428.3843952-9-nico@fluxnic.net> <34e75ebd-b01c-430a-a051-47489492c189@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 1E7B3744-E704-11EE-83FE-78DCEB2EC81B-78420484!pb-smtp1.pobox.com

On Tue, 19 Mar 2024, AngeloGioacchino Del Regno wrote:

> Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Inspired by the vendor kernel but adapted to the upstream thermal
> > driver version.
> > 
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 236 +++++++++++++++++++++++
> >   1 file changed, 236 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > index 7b7a517a41..9865926459 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > @@ -13,6 +13,8 @@
> >   #include <dt-bindings/power/mt8186-power.h>
> >   #include <dt-bindings/phy/phy.h>
> >   #include <dt-bindings/reset/mt8186-resets.h>
> > +#include <dt-bindings/thermal/thermal.h>
> > +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
> >     / {
> >   	compatible = "mediatek,mt8186";
> > @@ -2115,4 +2117,238 @@ larb19: smi@1c10f000 {
> >   			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
> >   		};
> >   	};
> > +
> > +	thermal_zones: thermal-zones {
> > +		cluster0-thermal {
> 
> Please use the names that are expected by the SVS driver.

And what would those be in this case?

I've used the names that were suggested here:

https://lore.kernel.org/all/20240111223020.3593558-1-nico@fluxnic.net/T/#m05936e84a2efe5c431bad39c24d66c246fb8ca38


Nicolas

