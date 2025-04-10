Return-Path: <linux-pm+bounces-25093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E10A83F9A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 11:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3358C1DEB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D662686AB;
	Thu, 10 Apr 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0IVZ+hC9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A79269D0C;
	Thu, 10 Apr 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278805; cv=none; b=FgVpJFvf9NQ6OpfxT4BXMpzmL2hOAuyI7XsYliZQmm34f2iTn8g0lcW+IskE32ANCs96GsWl7Ue0g25jY6lMmqEYjW9H6GgOwkBpnIjABmD2BhNPJmEEUe3tBV51A69pZJHfrNaxDOpt0uZQ7vKTr7/9YL12DQx0GEnmZ5ijvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278805; c=relaxed/simple;
	bh=fSkAnjVVS+AHmWl0ZhB0OpWiIhMLloTvzfi8Nl/MrsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo7rr98vrQYl4+9zA1aVe3r0ywXrzKyFiLmOPfBhdK78UaQnO4ciiCZbDAsgby62QFOXFwP/R3W9WE0v+rEFWSyban+IUhU9yaaL0KDcnKHnOakVY9UWPtV1Z2LD6zlyU7aCD3PaMwIDMaPqRu6SRNatGXbctn2ZzUo31RcX/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0IVZ+hC9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CD1AC1F935;
	Thu, 10 Apr 2025 11:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744278800;
	bh=xII/97dcDQDppFwmTFdjE+lkcwxiBTmdu4aYXUIv9Io=;
	h=Received:From:To:Subject;
	b=0IVZ+hC9lH6g+5zA81dvvjZS1vHnx4+NtZC5P3XFpsY4Q3VbUeaeESv/YICRw9kew
	 tDkbf9+jg1Ut5WuIaFG7TpPvuasKCBNenLLE0j7BqU6P4Y0gpDYTPBdnrrS8/RVoYm
	 ANiOYbIV4jPshhk397wbbOMPocE/OgsHzGkM+CP8k3I/qA8zj9D980cZ8Dx3ynTkFg
	 AZd9yWvlQt8ncEajWkXqmKMscNsjU+fO/s2K/jAlRMkfwC9pNFlah/zZKr9I6UkulA
	 Po30uDOQ/ezYkFfBRCYD8z573sbSb3oUtcTQU3sLeowy6Vx6CzNMM7FoLti23iUwRq
	 oCfZuHo6Yl36A==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 56D7D7F976; Thu, 10 Apr 2025 11:53:20 +0200 (CEST)
Date: Thu, 10 Apr 2025 11:53:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: Kernel WARNING (RCU) with btnxpuart on TI AM62 platform
Message-ID: <Z_eVEKQn04-2nhpL@gaggiata.pivistrello.it>
References: <20250408083512.GA26035@francesco-nb>
 <24b28bda-e294-4680-bed5-c44efcb6c455@ti.com>
 <20250410062006.GA7506@francesco-nb>
 <4107dda8-25fe-4f30-a0e6-906441f9b4c9@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4107dda8-25fe-4f30-a0e6-906441f9b4c9@molgen.mpg.de>

On Thu, Apr 10, 2025 at 08:34:23AM +0200, Paul Menzel wrote:
> Am 10.04.25 um 08:20 schrieb Francesco Dolcini:
> 
> > On Tue, Apr 08, 2025 at 09:15:26PM +0530, Vignesh Raghavendra wrote:
> > > On 08/04/25 14:05, Francesco Dolcini wrote:
> > > > I do have the following kernel warning with 6.15-rc1, on a TI AM62
> > > > platform (arm64), single CPU core, using btnxpuart driver, any idea?
> > > > PREEMPT_RT is enabled, if it matters.
> > > > 
> > > > Either the issue is not systematic, or multi cores SoCs are not affected
> > > > (no error on the exact same image on a dual nor on quad core TI AM62).

...

> CVE-2024-26959 [1] has the same trace, and supposedly was fixed by Marcel’s
> commit 664130c0b030 (Bluetooth: btnxpuart: Fix btnxpuart_close) present
> since v6.9-rc1, that is also signed off by you.

It seems that the conclusion at that time was just wrong, the real issue seems
what Vignesh suggested.

Francesco


