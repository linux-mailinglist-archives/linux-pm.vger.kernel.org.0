Return-Path: <linux-pm+bounces-2221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9982DE9C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8A81F22B4B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBBD18040;
	Mon, 15 Jan 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PoqmgAEg";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="fLzyaOpu"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDC1803D
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D40A1CF281;
	Mon, 15 Jan 2024 12:46:15 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=zl3zPl56LWpSelyG0PO8IbuR1L9NEPXMPlmG5Y
	fYgJY=; b=PoqmgAEgbcRTIOZIsDTBNwjnwFc9JJ6RErPhU1ywU/XEC5YaJEPqDE
	1svdxTusd0tOT37ph0XVeMX+yLUeERrSVmAgPni/IuSf9ZRgkMAijjnU+jAqitOf
	elAMaO1nRq0ozbe7ovysZo1hC1/q7OxPNap0sYGQv6QQk9cTa5mCo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 13DCD1CF280;
	Mon, 15 Jan 2024 12:46:15 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=zl3zPl56LWpSelyG0PO8IbuR1L9NEPXMPlmG5YfYgJY=; b=fLzyaOpuuy0EIs0iNeXZtqZ1VTAede6LrrumFL3mia7L0llCuXhpOs3NagfTQ8AjX9jSRO6cmKX6OYnqZbIhQufq8p2Ftthc5s1qwXLO4YeeTsabrWkFpSuWvz1Exltml5iItT9nBIzDynl/fuIF+Uu6AxvggODXRifRedqj89A=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78B631CF27F;
	Mon, 15 Jan 2024 12:46:14 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6DF15AE05A6;
	Mon, 15 Jan 2024 12:46:13 -0500 (EST)
Date: Mon, 15 Jan 2024 12:46:13 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: mt8186: add default thermal
 zones
In-Reply-To: <d11047b4-2a7b-4007-801d-dd9d2955fe02@kernel.org>
Message-ID: <n63rs2o2-7osn-9srn-3r9r-65081rs05r68@syhkavp.arg>
References: <20240111223020.3593558-1-nico@fluxnic.net> <20240111223020.3593558-7-nico@fluxnic.net> <d11047b4-2a7b-4007-801d-dd9d2955fe02@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 FA5D17F6-B3CD-11EE-8036-25B3960A682E-78420484!pb-smtp2.pobox.com

On Fri, 12 Jan 2024, Krzysztof Kozlowski wrote:

> On 11/01/2024 23:30, Nicolas Pitre wrote:
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > index 8fc563dce6..91b902a9f0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > @@ -2115,4 +2117,238 @@ larb19: smi@1c10f000 {
> >  			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
> >  		};
> >  	};
> > +
> > +	thermal_zones: thermal-zones {
> > +		cpu_zone0-thermal {
> 
> No underscores in node names. Could one CPU have multiple names? If not,
> then it is just "cpu0-thermal".

Well... I'm not completely clear about this given the available info, 
but this thermal zone would not be matching a single CPU but a few of 
them, hence several "zones of CPUs".


Nicolas

