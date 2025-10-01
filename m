Return-Path: <linux-pm+bounces-35623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB99BAFE9F
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E41752D0
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E8273811;
	Wed,  1 Oct 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewq9gBmB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E52522BE;
	Wed,  1 Oct 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312154; cv=none; b=GTl+iL8G3D62R+wr5gnhi4EX9OH4dK4jOhRIM3hQlTQWAR2fzmL/O090XYAA+XycsfvU/aZaASguGStltKAtNVsGCBGYN344OCyZyeXsNVEbUYuiiWpW8e3BSF9pbm7/QYxR5mVaU+bXRZOLQWS2/4YGIgx3SQ+wc91flCKmu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312154; c=relaxed/simple;
	bh=MgUl2M4I5gy7yfwjFNdxRtYro6QOxzUYdb+CPt8arnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbAYN5niGDz2/CKrZYTc0gY7XyoeSb4quvzfuN+/vJXhOioMCxoILXyVnTg+j2OZkWZBIwIkIgc39ZrSz5pp2/lG8QfA/MZSDTZIdfts7vGol6CZ22UQN/GX/x+aPu6Gh3TTV6xuNC9gilT1JKNuVwzi4zckK6/mpNS9LyGQeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewq9gBmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE26C4CEF4;
	Wed,  1 Oct 2025 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759312152;
	bh=MgUl2M4I5gy7yfwjFNdxRtYro6QOxzUYdb+CPt8arnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewq9gBmBnDgDlDauay/UPPvMY/8xsrxHxg+WBWK/x+csa2eoT964/9xGabXFwpkgd
	 jgHoN/U5JTeacJ/9GV5U44YcNCxL8dOGuUSUOkoGDrjXnTVFtqEsqY9uTpPnT69zda
	 ZEeWVI3eOYBQL8Gjt8bL1Xg2Dbcr58d30g5pY0oPzPzWo3XvGGJe+oWF5n+nONFi9a
	 YqjHy3qTdvRoJqIiJxqiJCY63WFCBZWnNVXBArahqlpBJv7ksNGaluZsTtpUolZfSX
	 uP4iun9MLIpaK9YpvO4KC2F3CIRVVZqjzC2UUzMvBpew5lBVJ3etVNfq0Cew2JxmJu
	 fySNm2JYvXMKQ==
Date: Wed, 1 Oct 2025 10:49:07 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH v8 0/5] Add Texas Instruments BQ25703A Charger
Message-ID: <20251001094907.GN8757@google.com>
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

It's located in an immutable branch.

Probably too late to share now, but it'll be in my PR to Linus.

-- 
Lee Jones [李琼斯]

