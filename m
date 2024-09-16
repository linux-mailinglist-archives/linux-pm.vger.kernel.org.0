Return-Path: <linux-pm+bounces-14347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E87897A578
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199B4B23B17
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D215A84A;
	Mon, 16 Sep 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ExslBwo1"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194BA94F;
	Mon, 16 Sep 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501586; cv=pass; b=r2YWG/WQJRw4VX9F+gzOnzZcPOcOYdK9APFy1HR6R1JJ0zHghJz9BpXm+/8J7wCYWtyw7LnCUZXnhGtDRoinnHoPSiwcgrVaFKS2lBHjvFyOHaFSqBQEnPhTmw3r8IsE2h2Iv+EPbmBAqOqGiBeCsTZCkBSwINiIOr9el2mYkXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501586; c=relaxed/simple;
	bh=8c454KAuHHnh3S3JWDs5YesF4bGjhW7u0NheEV6WLn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFcouLqZf44ggcPd2pyrnt4kL58PlK8cLEGsyS9U3gIvagqvI2ex4qXqQmdRpk6/0KT81TEdvD0KIO+Y6KcTO36koFsMDSlEdv0iFqu2DMbiP2vJGzVl4QgtwYdUpXJinpIPeXK7B1Z9CwDKF8Yqmpe6EWI5EKY9sv3/hwXM9Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=ExslBwo1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726501560; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LhiurA48EpisqqZ0he4yr2KgWvnbjwYiwvuJUJKoKw8l0u1SB8eyiBBxKPkxNV8FML7eg4D1PIzpipMu9EepsQTdTg2WwKeC7BqKF0duEomoKPxO3JUCyBk9ogYubmglcaRtacUJBNEan+covTsDFeRlPwDnqk+wKfBgu/IHxRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726501560; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TjwJ4FDCdt734YAQPc/f2Tm44fHky68i9g69jZnst8o=; 
	b=NVgsKp+phprM340tifR6Zf3HfXSd538n2mMpf7Sxn6fAIffRkLWIYGQN9jlW23AKrhsaPvOLNo6ejG+M2zty3vQ3lSbfKvs2+Z7nI/SKZ5dyVYmzTtgcrXEdp26E6nFDuzVZ0jMTIWH6bw8pGwFeGCHf+FrsGaXQIrbUIY+xtUM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726501560;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TjwJ4FDCdt734YAQPc/f2Tm44fHky68i9g69jZnst8o=;
	b=ExslBwo1iemmyAQusGX7f+Lik0IfWnvNj5sSWaHLMNfZLT4izEgdzeJz0q32dVay
	rr75PHSqPl+d0E0T44hrj9w4M1b+9sX65K0gzIzL+zyLhbqZMSv8pZ3SFGTk8VlAJ5O
	TEQrqAzvlbAwcGeLw2Y3z0ONKvTVbr6WVFx6a9J4=
Received: by mx.zohomail.com with SMTPS id 1726501557780427.4745003950086;
	Mon, 16 Sep 2024 08:45:57 -0700 (PDT)
Date: Mon, 16 Sep 2024 16:45:53 +0100
From: =?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/6] Fix RK3588 GPU domain
Message-ID: <36ddjlsivqd4kzxckegxvjfuddkhigj5kjt3gurossfaihbddv@3stp2dnidusn>
References: <20240910180530.47194-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910180530.47194-1-sebastian.reichel@collabora.com>

Hi, Sebastian, thanks for the patches.

I've tested it on a Rockchip 5b board and now I can reload the driver at any time.

Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com>

On 10.09.2024 19:57, Sebastian Reichel wrote:
> Hi,
> 
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
> 
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'gpu', val=0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to get ack on domain 'gpu', val=0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> 
> This series first does some cleanups in the Rockchip power domain
> driver and changes the driver, so that it no longer tries to continue
> when it fails to enable a domain. This gets rid of the SError interrupt
> and long backtraces. But the kernel still hangs when it fails to enable
> a power domain. I have not done further analysis to check if that can
> be avoided.
> 
> Last but not least this provides a fix for the GPU power domain failing
> to get enabled - after some testing from my side it seems to require the
> GPU voltage supply to be enabled.
> 
> I'm not really happy about the hack to get a regulator for a sub-node
> in the 5th patch, which I took over from the Mediatek driver. But to
> get things going and open a discussion around it I thought it would be
> best to send a first version as soon as possible.
> 
> Greetings,
> 
> -- Sebastian
> Sebastian Reichel (6):
>   pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain errors
>   pmdomain: rockchip: cleanup mutex handling in rockchip_pd_power
>   pmdomain: rockchip: reduce indention in rockchip_pd_power
>   dt-bindings: power: rockchip: add regulator support
>   pmdomain: rockchip: add regulator support
>   arm64: dts: rockchip: Add GPU power domain regulator dependency for
>     RK3588
> 
>  .../power/rockchip,power-controller.yaml      |   3 +
>  .../boot/dts/rockchip/rk3588-armsom-sige7.dts |   4 +
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |   2 +-
>  .../boot/dts/rockchip/rk3588-coolpi-cm5.dtsi  |   4 +
>  .../rockchip/rk3588-friendlyelec-cm3588.dtsi  |   4 +
>  .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   4 +
>  .../boot/dts/rockchip/rk3588-ok3588-c.dts     |   4 +
>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |   4 +
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
>  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |   4 +
>  .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   4 +
>  .../dts/rockchip/rk3588s-khadas-edge2.dts     |   4 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |   4 +
>  drivers/pmdomain/rockchip/pm-domains.c        | 130 +++++++++++++-----
>  14 files changed, 144 insertions(+), 35 deletions(-)
> 
> -- 
> 2.45.2

Adrian Larumbe

