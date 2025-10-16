Return-Path: <linux-pm+bounces-36229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FABE21F4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA418A477E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8E6303A03;
	Thu, 16 Oct 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gOt/ef1F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9A2FBE1C
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602811; cv=none; b=XwYaaVAkCN8XrXljhAeo2Pd+8G0XkwpCAArvKgtVgbfb99K9F1ID/j3aywn4pH0eFsLd/AhuneBOfiFn6oaJJnx9z9Xpon/tS0vWl+ELD8XPVQpsTJ5T/iavdVrCmT2TJzyLM0EpO5EJIe7tZYS6DPPryQczGW9IdE0udAd6Owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602811; c=relaxed/simple;
	bh=nquAaNfx6pYCWXER78qha80sffd1fOhWV8/6TUPD354=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRLimyUeqd4LqFyWnEgxeJh4wEE3RrYn8SubIFQsk/i7DhhsVLK+xSyDmk6k7H1R3bK8SO0cgf146l8kDAxu76pfG0tZMpbmHHA/Qjs4qt/JiqUvKHaHf63GvTLc+5pWiV8xMC0W+N64shnQsCQ8VYHPqHrO+WMHRBaB5OiOKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gOt/ef1F; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=YixC
	XPlMaqrkZziFdLm6znkrHf724LnyFL5V9yYKXEs=; b=gOt/ef1FHGv+ejGnncsz
	+ZjTYIhgKDQ4f5yl/+0A73Yd671/d+aJOjRER2IqBlVTgmk5Y4OgV27fW0lmkmk/
	FAsVfZYFoBI7vX1sal3ugPhYg1D+mjVF98BEXtfnNzJ0HwbOuociZ5LVv4Gqsoj1
	Nx0JsgcAL8Y0DQENRcWpqD/gzQO3RyqGEDQtZ/ean9w5vU/foyChDrOoGlb8t7pj
	2P9VmPFS0Fvp3qlWmNWJawEIdxJ2x8iMFP3AsyrmTk/eq8lUkjEEr2UWqx0GX1Fe
	Qsuv8AytThXsBqnbwgTRQHWYt3rST+7suOVOYERSGcYFeawn4Gl3khU0ZMb9o56P
	ig==
Received: (qmail 3724143 invoked from network); 16 Oct 2025 10:20:07 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Oct 2025 10:20:07 +0200
X-UD-Smtp-Session: l3s3148p1@bi/mSEJBcNQgAwDPXwQHAL/S9V79e5yL
Date: Thu, 16 Oct 2025 10:20:06 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"niklas.soderlund" <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"magnus.damm" <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
Message-ID: <aPCqtn3OwY1NRCD5@shikoro>
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <aO_eLEFLAnjc8n4G@shikoro>
 <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
 <aPCmZp8sM5oV2jPa@shikoro>
 <TY3PR01MB113468C08443256EC6D99209386E9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113468C08443256EC6D99209386E9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>


> > > > I am not opposed to the patch. Just want to mention that such
> > > > information gets stale all the time, so I would suggest:
> > > >
> > > > + R-Car Gen3 THS and compatible thermal sensor driver
> > > This won't cover RZ/G2 which something else, and Gen5 seems like it
> > > will be also a bit different, so maybe the list is now exhaustive?
> > 
> > Sorry, I don't understand: If RZ/xx THS is compatible with R-Car Gen3 THS, why is this not covered?
> 
> RZ/G2{H,M,N,E} thermal sensors should be compatible with R-Car Gen3{H,M3W,M3N,E}
> But RZ/{G2L,G2LC,G2UL,V2L} uses different compatible.

I do understand this.

But if I say "this driver supports R-Car Gen3 THS and all THS instances
compatible with it", this includes all RZ which are, well, compatible
with it. And not those which are, well, not compatible with it?

Where is the misunderstanding? I am feeling a little awkward here...


