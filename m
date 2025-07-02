Return-Path: <linux-pm+bounces-29997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F34AF646A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 23:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5867A9644
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF723F40C;
	Wed,  2 Jul 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txYuBzXB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F9231A23;
	Wed,  2 Jul 2025 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493321; cv=none; b=ensT2N5pWslDVfZkK7NcDtRxNh3ckGybv7tjO88m5e+y1R2JuGHbcPm9oaY9PQ21ROcbsGNXAlfgqQOjBgtPUnDasuaUlCvRkyuhuhq8IUnI3XzUIW9VHeG94Tr4JMRDs2sxKAXLbDS46W1O1JafrftpmzJp/V+I863Gc2LLdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493321; c=relaxed/simple;
	bh=iGkBwzIdbza8qoD4B6aj+xlJlyErE9nD591815HAFqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju484IzfxT6Z8nXJPSMtxSyXDMkalErTyg2kcCLUHDOfNjf48nXwyhcQxH7cEo73mzams+4FlYlyVibDbrNnfJrnen5AO3mwM5qRNS8rTp/15qznpUz/9JDd5MuUYidNeBBhlwBrvxUxF9lbiI3p6tLz1jP+ctOglQy7QfjlvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txYuBzXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBC2C4CEE7;
	Wed,  2 Jul 2025 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493319;
	bh=iGkBwzIdbza8qoD4B6aj+xlJlyErE9nD591815HAFqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txYuBzXBSRKbeFVOMXVCBpbM5Smf33hS+2wxhGLkFxlvKyR/BNSy6og0XV5svlqgh
	 RG1Zi5SgKSqpogdRaqjU1RUpaeUHS1qO3AmzIieSclZbNUStETr0pZbAJGp6IP9BWB
	 jFLUU9dFMRTy4NgoyGBSrqcUwzY1daDg1fK7RUDVp72TSmzGt4aDJdQywUuBOuIuGl
	 rdm1BzqTFL3LYmo45rVSfMZ69VsBTvOH7TYTDEUlpPJZpkSy3DtGYIfZ1qL28dfC+L
	 X2Ro4yRfJrby9W5BveTfy3Nn37QD3x0o86ji8oFjbCMkYHq16pXvogeg03y4PXVCby
	 kfdGmOegah1Ew==
Date: Wed, 2 Jul 2025 23:55:12 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/24] driver core: Export get_dev_from_fwnode()
Message-ID: <aGWqwNXy1AcCGf97@pollux>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-18-ulf.hansson@linaro.org>
 <2025070205-ignore-passive-17b4@gregkh>
 <aGWH2mH6iZJ3s3lL@pollux>
 <CAGETcx_yVXgvmbDFYe+Nbdp18D-m14W8xO_G9RyAujpag+M9ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx_yVXgvmbDFYe+Nbdp18D-m14W8xO_G9RyAujpag+M9ow@mail.gmail.com>

On Wed, Jul 02, 2025 at 02:34:04PM -0700, Saravana Kannan wrote:
> On Wed, Jul 2, 2025 at 12:26 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed, Jul 02, 2025 at 09:34:12AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 01, 2025 at 01:47:19PM +0200, Ulf Hansson wrote:
> > > > It has turned out get_dev_from_fwnode() is useful at a few other places
> > > > outside of the driver core, as in gpiolib.c for example. Therefore let's
> > > > make it available as a common helper function.
> > > >
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> > > > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/base/core.c    | 8 ++++++--
> > > >  include/linux/device.h | 1 +
> > > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > > >
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > I'm a bit concerned about exporting get_dev_from_fwnode() -- at least without a
> > clear note on that this helper should be used with caution.
> >
> > AFAIK, a struct fwnode_handle instance does not have a reference count for its
> > struct device pointer.
> >
> > Hence, calling get_dev_from_fwnode() with a valid fwnode handle is not enough.
> 
> Not enough for what?

Having a valid pointer to a fwnode does not guarantee that fwnode->dev is a
valid pointer. Given that fwnode is reference counted itself, but only has a
weak reference of the device behind fwnode->dev, the device may have been
released already.

If the scope this function is called from can't guarantee that fwnode->dev has
not been released yet, it's a potential UAF.

Yes, device_del() sets dev->fwnode->dev = NULL. But that makes it still racy.

If someone has a reference count on the fwnode and calls get_dev_from_fwnode()
while device_del() runs concurrently (assuming that device_del() drops the last
reference of the device), it's a race with a potential UAF.

We should warn about this, when makeing get_dev_from_fwnode() and API that can
be used by *everyone*.

- Danilo

