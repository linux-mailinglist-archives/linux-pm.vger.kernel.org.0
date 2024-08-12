Return-Path: <linux-pm+bounces-12108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9994F51C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBF0B2578B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50818754E;
	Mon, 12 Aug 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQfaukLW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC07187347;
	Mon, 12 Aug 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480902; cv=none; b=UgF6LwJt5JmovNsYBCgDKNz+WTM/W+ZhhvzRhWeQZDfOvC9Tx7Dil7pYqndkm+MOVf7e8ZjDjLqjZWY7jRMHfk4DFVyiaTkfgOILh97wH8iXmDr80Qk07vofEBKxv+50m4VmCydbaE2BcKDkS8kmsUPyelWS82dfkcoiz5VvBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480902; c=relaxed/simple;
	bh=w/foYfrPOgxcK2AUgC3oPzuz6RvE+fU4WtbCKyDaDd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu+yslXAUkk5+9iJhMpiNmzUKMcGlUdLub2a4batxcdGhjiPclR8RTpxU05K0Fo6oAcCFBApyCPbbgiqcWVVWoGB6pQG+CTYuj61g9YJgjWocDD3W0LxHTqmC5fP6U+HWAa0nS85DlOT1NMRWeiY0a4BQWvP45Kof+C8vg3tT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQfaukLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5C5C4AF09;
	Mon, 12 Aug 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723480901;
	bh=w/foYfrPOgxcK2AUgC3oPzuz6RvE+fU4WtbCKyDaDd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQfaukLWVXSdXViNPLTzV2UfFjHeGyu9B3U2wGAbLx9d5OksT+t5fqn9Nm6K15iRj
	 tSmiNJIKPKPbvcROPJ9/QmsMi5/YKwWurxx79RtrpKrKRWijWTdBaR5CK+/Mgf0ik9
	 Kegga2BSy7jBYKzf8OfA1DzWF2LShXYDbbNcR/myrKoAmZCGCgZkIvPqAAMoWl5w7t
	 v/Pe9FAOJcl7Yw0kLkxuDcuPV0+346KYovLc5d04ngZwCGrZi03x+YSdO6ypQINpZq
	 gSdcApK9+5ODXY1tb5BoBk0FHhK6FuQCv9mIM4GAnQ5q28Itoq8426oPBHHv3/94oU
	 fOfeyZFrUzCdA==
Date: Mon, 12 Aug 2024 10:41:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	Zhang Rui <rui.zhang@intel.com>, Conor Dooley <conor+dt@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 6/6] dt-bindings: thermal: samsung,exynos: remove
 driver-specific information
Message-ID: <172348088057.1248578.13184314631777565380.robh@kernel.org>
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
 <CGME20240807084917eucas1p28c675c9da74f0de0bb09689819202c39@eucas1p2.samsung.com>
 <20240807084829.1037303-7-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807084829.1037303-7-m.majewski2@samsung.com>


On Wed, 07 Aug 2024 10:48:25 +0200, Mateusz Majewski wrote:
> The number of supported trip points was only limited by the driver
> implementation at the time, which mapped each trip point defined in the
> devicetree source file to a hardware trip point. An implementation that
> does not have this limitation is possible; indeed, that is how the
> driver works currently. Therefore, this information should be removed
> from the bindings description, which are meant to be independent of
> the details of the driver implementation.
> 
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
> v2 -> v3: reword the commit message to be easier to understand in
>   context of dt-bindings.
> v1 -> v2: remove an unnecessary sentence.
> 
>  .../devicetree/bindings/thermal/samsung,exynos-thermal.yaml | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


