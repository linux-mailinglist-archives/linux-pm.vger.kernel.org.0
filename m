Return-Path: <linux-pm+bounces-12197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67612951984
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 12:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0CD1F222C1
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D11AE872;
	Wed, 14 Aug 2024 10:59:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAFAD5A
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633164; cv=none; b=SIhaaLsSPYag1ligWeALlYHz6yT6oANiAceCWty0wCadFmGbFHhI86swDbkt5/Uk11f1B3i5kPCruIxAD/gN+jMO2wW5zMcSZVqUOwNpVtfv6lu1MvxPXV4ibmMNxEgv7XQaeD/8tPPhn4BDCliDdh6TBekPdBh8ZwyLtaTDkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633164; c=relaxed/simple;
	bh=FDGJ3XkEIaTOpwp5kPnPZXSAuVrkVe3XypLywdy1494=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWvJWikKqLggrTgAFhSjghj7tO7S+KoZmPALLBxSBMfupNZRg14X9O3xH40+qt8S9NSs7mAVhAann236umAp5b1TuE72M9GTE0tAzteRet4kPOoatvswd+txUXNsw6eOMBnpkwY2o0O53CXEYqjSAiS0Fv/AC0s/3oy63hwpEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1seBiM-0007qt-4B; Wed, 14 Aug 2024 12:58:50 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1seBiJ-000LFZ-HT; Wed, 14 Aug 2024 12:58:47 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1seBiJ-002Wsl-1H;
	Wed, 14 Aug 2024 12:58:47 +0200
Date: Wed, 14 Aug 2024 12:58:47 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ma Ke <make24@iscas.ac.cn>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Peng Fan <peng.fan@nxp.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	imx@lists.linux.dev, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
Message-ID: <20240814105847.tise4jzneszdxetb@pengutronix.de>
References: <20240808042858.2768309-1-make24@iscas.ac.cn>
 <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
 <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com>
 <CAPDyKFqd=haDWB3tATZ_E1BMpCReNh=hLa5qPGATc3h1NUx09A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqd=haDWB3tATZ_E1BMpCReNh=hLa5qPGATc3h1NUx09A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 24-08-13, Ulf Hansson wrote:
> On Thu, 8 Aug 2024 at 08:53, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Aug 8, 2024, at 08:12, Marco Felsch wrote:
> > >
> > > On 24-08-08, Ma Ke wrote:
> > >> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> > >> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev
> > >> is either error or NULL.
> > >>
> > >> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> > >> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> > >> then used, which leads to NULL pointer dereference.
> > >
> > > Argh.. there are other users of this API getting this wrong too. This
> > > make me wonder why dev_pm_domain_attach_by_name() return NULL instead of
> > > the error code returned by of_property_match_string().
> > >
> > > IMHO to fix once and for all users we should fix the return code of
> > > dev_pm_domain_attach_by_name().
> >
> > Agreed, in general any use of IS_ERR_OR_NULL() indicates that there
> > is a bad API that should be fixed instead, and this is probably the
> > case for genpd_dev_pm_attach_by_id().
> >
> > One common use that is widely accepted is returning NULL when
> > a subsystem is completely disabled. In this case an IS_ERR()
> > check returns false on a NULL pointer and the returned structure
> > should be opaque so callers are unable to dereference that
> > NULL pointer.
> >
> > genpd_dev_pm_attach_by_{id,name}() is documented to also return
> > a NULL pointer when no PM domain is needed, but they return
> > a normal 'struct device' that can easily be used in an unsafe
> > way after checking for IS_ERR().
> >
> > Fortunately it seems that there are only a few callers at the
> > moment, so coming up with a safer interface is still possible.
> 
> I am not sure it's worth the effort, but I may be wrong.
> 
> It's been a bit tricky to keep the interfaces above consistent with
> the legacy interface (dev_pm_domain_attach()). Moreover, we need a way
> to allow a PM domain to be optional. By returning NULL (or 0), we are
> telling the consumer that there is no PM domain described that we can
> attach the device to.

Other subsystems like GPIO, regulator have a ..._optional API for this,
could this be an option?

Regards,
  Marco

> 
> Kind regards
> Uffe
> 

