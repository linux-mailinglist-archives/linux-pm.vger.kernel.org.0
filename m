Return-Path: <linux-pm+bounces-35839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A0BC91BC
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E4B3A3FE5
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB802BE04B;
	Thu,  9 Oct 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SThG6o1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B3BA3F;
	Thu,  9 Oct 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014055; cv=none; b=KCRqT5ohSK3zyRdb7TpNjk/2OAGaN3FHVEhXbDJ4BKAh74kuf92TBRHH50ku7/NO0KlXpddCtFWq1p02xdTAGFQLLaP7ioeLpik6sZmUqb78ilCunLgDo9OLICuVsn/MToF5lv/g0u1Ejnt9b5796114chyEv8m0xh6St60HMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014055; c=relaxed/simple;
	bh=zvGRayVs38LUDv89UOLvEh9Jzl8OZV1NLB1WntmzPks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+tz5vLITUg2ShGXPHZXHVrzuaOqLHCrz4A+d/RzBvH3Pe5yN8sFZmvCJch8IaNclAgnl/bBqb8wwttK/IlPJYzZfSa66Mr74I4tKIVWoaPApYtIGvlNVBMYA2NpW+ioe06n8LIhiDGA8EOt39Hd1gqxtFEVJGqTR+OVAlm5yuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SThG6o1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F0CC4CEE7;
	Thu,  9 Oct 2025 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014054;
	bh=zvGRayVs38LUDv89UOLvEh9Jzl8OZV1NLB1WntmzPks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SThG6o1uhMovzEU+6i569x2lBcSday6XW0GeNuM6ICvVT84NJkrdDRfSoGg+P3nT1
	 BnaLNNEYrsfOsqF82aTWrqSoy4CPqe33yYkJHRpmrV1jcdPqKoVfvvrfYhawtV7H3e
	 l06FJsba6uFHfFbiW0vYpc/jw+EIc8L3lrMmqU6y3LQ6KtlTS8fW3w3O31VtOd4qkK
	 NN+zXcazFCJG2iUna2Xm4VC5bS11z7bahoPpcLL9fR5njeuJeegGPJtHm8mg5tqesF
	 RAd1e03Z9lTy08Iy7QlVxy6QXqsv+CqUNltxi0CinpwbBi0+HvkSssQpbdgdXpCcc8
	 mR/UB9MzKr7uw==
Date: Thu, 9 Oct 2025 13:47:29 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH v8 0/5] Add Texas Instruments BQ25703A Charger
Message-ID: <20251009124729.GD2796410@google.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
 <175760259503.1582479.14013409824773713781.b4-ty@kernel.org>
 <CAL_JsqJy9XwNrcwgk4Dhf40ajn8WwD47v2YqZ3iYZz+CjEdv5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJy9XwNrcwgk4Dhf40ajn8WwD47v2YqZ3iYZz+CjEdv5g@mail.gmail.com>

On Mon, 29 Sep 2025, Rob Herring wrote:

> On Thu, Sep 11, 2025 at 9:56 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 04 Sep 2025 11:05:25 -0500, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > > Add support for the Texas Instruments BQ25703A charger manager. The
> > > device integrates a boost converter with the charger manager. This
> > > series adds the device as an MFD with separate regulator and power
> > > supply drivers. This allows us to manage a circular dependency with
> > > a type-c port manager which depends on the regulator for usb-otg
> > > but supplies power to the BQ25703A charger.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
> >       commit: 76bc2203a46ef704a4cd8003986f6bd74139a367
> 
> It seems this is still not in linux-next?
> 
> > [2/5] mfd: bq257xx: Add support for BQ25703A core driver
> >       commit: 3b1bbfb5fce3ca9fffc92ac1b053b0cfbb1f322b
> > [3/5] power: supply: bq257xx: Add support for BQ257XX charger
> >       commit: 1cc017b7f9c7b7cd86fdda4aee36b92d91cc2ad2
> > [4/5] regulator: bq257xx: Add bq257xx boost regulator driver
> >       commit: 981dd162b63578aee34b5c68795e246734b76d70

All of these are now in mainline.

-- 
Lee Jones [李琼斯]

