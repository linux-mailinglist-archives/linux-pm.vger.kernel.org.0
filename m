Return-Path: <linux-pm+bounces-16057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069C9A5BC1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 08:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B1428266F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0561D0E17;
	Mon, 21 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAq8B577"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F471D0B98;
	Mon, 21 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493713; cv=none; b=ujQJKAV6CoBlGyI/Q5Ftz5zrgS+lGdnYAtLzpPo7s78UdcTlvgEeI21Ve/K/ESwCkxbEHVxxo060auEexcEo87bmLo0it3TCTU+iewI50nMoe5xMD5QjIv7ZeD7m+U/hfd2GfxpAe8ViiiI20wm79QRgtgAykRp9H3/dQjhDWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493713; c=relaxed/simple;
	bh=8PCol88A2ncEPIJmEoeILZX16B39Y6hAq9nQ5qaD65Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKUWSWNzdM1JCMtKKoOAeyMF6v5qC5M8erivHAzzq/h1EPc6cKS3WwOc+ZH/UGjBtMZBjWBRnLJpmSJBf9xlod4GW/XAY6nCQoG/SgVu4MJrWZnytz7X00ARP/+gRALLb+qKR0Vm3eXD3R0sFldyW+Htdv6VO6Fxw7g3rLcouWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAq8B577; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EBC4CEC3;
	Mon, 21 Oct 2024 06:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729493712;
	bh=8PCol88A2ncEPIJmEoeILZX16B39Y6hAq9nQ5qaD65Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAq8B577+0ECrnl1hxg57JvaIAERfsMygM1RTe73txDgtUVOofRuD9unBnx4hmSeZ
	 EIQ5qQQPxBsulq9iTwBntYRm/SUYdCu6/HxYgi+lK9WjTb7A+Ls0aRl5aSPmMotDwt
	 N3T/9ZHy09RxzzPqnDa95Hr/vjirO4UDi0ghvjFN8diNiDnFtTcLhqgkCCl0rX6x93
	 wdBRWkuYTfAr3C81FnS3swCEYFUtATB4ivCt6mYDhSSl8TSAI0ZdFS8O1xFMZmAxY8
	 KrIi4Edm8wGXgrUXAP/ZgLI5X6A/bHmLP9XCRQnDOerrdfgsZC2W/acdwYH+nvrpU6
	 rn7KqZeh9D7Eg==
Date: Mon, 21 Oct 2024 08:55:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dang Huynh <danct12@riseup.net>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH RFC 00/14] Add MSM8917/PM8937/Redmi 5A
Message-ID: <gh55k7a3b6rmkloq45mkfcms5g3x6stelzoikag3uo7idvkb7g@ncslfa5tzsnf>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>

On Sat, Oct 19, 2024 at 01:50:37PM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).

Please always give some hint why this is not suitable for merging (you
tagged this as RFC). Every patch is for "comments", so if you mark it as
RFC means it is not ready.

Some maintainers ignore RFC patches because of that. There is a lot of
stuff here, so it's also easier for me to skip it, if this is not ready.

Best regards,
Krzysztof


