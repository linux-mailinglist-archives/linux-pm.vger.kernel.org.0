Return-Path: <linux-pm+bounces-24403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A83CA6C781
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 04:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A4B189820C
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 03:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF204200CB;
	Sat, 22 Mar 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQmcL6S/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858042E337D;
	Sat, 22 Mar 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742615147; cv=none; b=VFc78KluN9AsmcoOT9XWUsRf6DgrQ7gub4JOA07c9/Np/5fN2oz62FElynKC3cYCcAPmPXBdGjqkXKZLSXQy6iU2p946Hz67YIs0yImY1TI6V2j7xFJuv15QWjwOfHvrjzePceXn6DxXFPK/B7FScSXoN5jGCY+4CRJ0GtqBldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742615147; c=relaxed/simple;
	bh=/UCd4h/6gwL0U5r9X2vlvNkmZ7Z//FawotZigJcoF8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kISMKjWotBifqLBe0snJKrtcnX9z32hWnFeCUgOvSkjJbYR84g4hDcGLdAHnoV+IjOofujY8qbtdKiCas+pxgeEcKvSswlr11kBxUPuMrlv3i9RsVBafx8D2wIoJCSqfoRh/ADKBxHNryhNVQWaN4wOITdl+veD1guhoHrlc4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQmcL6S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412CFC4CEDD;
	Sat, 22 Mar 2025 03:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742615146;
	bh=/UCd4h/6gwL0U5r9X2vlvNkmZ7Z//FawotZigJcoF8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yQmcL6S/Llw1LfrnG1OLg59L82Vkw56On2NNBN945yOOZ9kx9UD+SHWrV8/UMJy2G
	 LSruYoVTTpxp2qEwIyeKh3+RIpXGlXg19rKIZnl3yDOSlkveoukLhHuLQPU0BtT5l1
	 w8PXU0gog3/RXFDui3bWAU9QtXMfoNBrhFno9NAM=
Date: Fri, 21 Mar 2025 20:44:24 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Samuel Holland <samuel@sholland.org>,
	David Lechner <david@lechnology.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <2025032119-mammogram-fracture-14e6@gregkh>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
 <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
 <2025030845-pectin-facility-a474@gregkh>
 <0401fdf9-7665-40d6-9ec7-7222b2eda866@oss.qualcomm.com>
 <eqfqv2tkfretqzvt74o5dvj5yixkfc3h3my4bhskvhtsrbmtwp@poryvs4oipnp>
 <2025030831-various-monthly-4ae0@gregkh>
 <5ef97125-2b27-4961-8755-09fcea062f78@oss.qualcomm.com>
 <20250321-famous-acrid-monkey-ab9c07@lemur>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-famous-acrid-monkey-ab9c07@lemur>

On Fri, Mar 21, 2025 at 12:36:53PM -0400, Konstantin Ryabitsev wrote:
> On Sat, Mar 08, 2025 at 07:27:28PM +0100, Konrad Dybcio wrote:
> > > I do use b4, but it wants to suck the whole series down.  If I want to
> > > pick an individual one out, I have to manually cut the message-id out
> > > of the email and type out the command and pick the individual commit
> > > out (or use the -P 3 as was said).
> > > 
> > > But that's a world away from me just hitting a single key in my email
> > > client to suck down the whole thread and apply it to my tree.
> 
> Would it help to have an "interactive cherry-pick mode" where it grabs the
> whole thread but before it applies it to your tree, it lets you pick the
> subset of the patches you want? So, instead of passing -P 3,4, you have a file
> open in your $EDITOR where you can just delete the patches you don't want?

Yes it would!

