Return-Path: <linux-pm+bounces-14447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F4797C68D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CDF1F25CBB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D3199E8D;
	Thu, 19 Sep 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="aP0e28+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB5199957;
	Thu, 19 Sep 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736815; cv=pass; b=JYkbLfNezkniIXOEHgm+HHpkz4FY4UFQnyXbSKXUnVX7nED3Jp82K5tjgAdcOHqyVQWFGh6pPSK3uFR6/tafVKlR3HFZ4CYdNvWMo44yTuyrb5h9yGRdP1fcDgRT4v1uHtLUJSoEivU7CGnmHp7e0AohsIzFkzQK2WJYXslGX08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736815; c=relaxed/simple;
	bh=WIyPR9I7SW6Am8W2Xo7ZAkLcKedMPAaJoNrnX9TxwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZwSJqGaYHqgpk//5R9F14omA1a+gpgDl3McyvQk6eTvdvAqvdAPqoW90q1jIQwj5WjEG5Ln8+td3kf5tZR88WE4MczJoFSA9iRusKZOU6zJpJOVdgMYfszRDEj37SC/Z6z2t7za0e9WLgliqfc2RhcPsHey9mU6pA/4NQlqmyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=aP0e28+9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726736744; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WjG2BOdH75Al6lv/8HNX+J4MZwf54noq6XT02LOFdOST4yvSHm7s95wvHBehc1ibo3irRiz3EWoRQEfwJhJ7u9CeVpnhvL7MTS5K2mYQfVTSH3SXdAG35+ZRgae8HPAaioQEvJy2l3iE527Jc2Trwe+kFkT66DgUIjRkZaSYpO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726736744; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WIyPR9I7SW6Am8W2Xo7ZAkLcKedMPAaJoNrnX9TxwDI=; 
	b=IX+AgYHmn9h0/JFMcQSb76kpnvvprbj+30Z/H7NWsE6UCw8CilmwCNIXi+zYyi5O0EwTEHF7dWTtTgeutdXSbgyO0GTcO5G+N5JbeljfaBuCKRLmu4urFbgkZFA7CX1S9zkT7mbMBtGO1RF80yyiAQysRRuT46Z63hmBrJwYLUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726736744;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WIyPR9I7SW6Am8W2Xo7ZAkLcKedMPAaJoNrnX9TxwDI=;
	b=aP0e28+9MF1DAD9w61R9zdYhgHkXUjJgjquFdB9epwQpmoan9kk060se3CanuevN
	gsKRjfRHKDNUukrlUk6TAVHjDo8/aLBau64DRYxp1VAeWihDccx0PvsOsXTxDubD0Ky
	tYRiunm+tSWSE5RV/g6BCsqF+yTAIof8Vyj8OOew=
Received: by mx.zohomail.com with SMTPS id 1726736742399817.1293742983563;
	Thu, 19 Sep 2024 02:05:42 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 3C03B106031C; Thu, 19 Sep 2024 11:05:35 +0200 (CEST)
Date: Thu, 19 Sep 2024 11:05:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/6] Fix RK3588 GPU domain
Message-ID: <vh5gsouseahs6ddauzevcdtcjutl35dcyoc5cv4pvn56lyyilv@rekmpklpbbyh>
References: <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <CAPDyKFoMyGUagDdjdaBJXL_OEgewQjCeJcBBK+2PFk=vd+kjRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ey5cyrmazej6g4l"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoMyGUagDdjdaBJXL_OEgewQjCeJcBBK+2PFk=vd+kjRg@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--2ey5cyrmazej6g4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 13, 2024 at 01:59:10PM GMT, Ulf Hansson wrote:
> On Tue, 10 Sept 2024 at 20:05, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > I got a report, that the Linux kernel crashes on Rock 5B when the panth=
or
> > driver is loaded late after booting. The crash starts with the following
> > shortened error print:
> >
> > rockchip-pm-domain fd8d8000.power-management:power-controller: failed t=
o set domain 'gpu', val=3D0
> > rockchip-pm-domain fd8d8000.power-management:power-controller: failed t=
o get ack on domain 'gpu', val=3D0xa9fff
> > SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> >
> > This series first does some cleanups in the Rockchip power domain
> > driver and changes the driver, so that it no longer tries to continue
> > when it fails to enable a domain. This gets rid of the SError interrupt
> > and long backtraces. But the kernel still hangs when it fails to enable
> > a power domain. I have not done further analysis to check if that can
> > be avoided.
> >
> > Last but not least this provides a fix for the GPU power domain failing
> > to get enabled - after some testing from my side it seems to require the
> > GPU voltage supply to be enabled.
> >
> > I'm not really happy about the hack to get a regulator for a sub-node
> > in the 5th patch, which I took over from the Mediatek driver. But to
> > get things going and open a discussion around it I thought it would be
> > best to send a first version as soon as possible.
>=20
> That creates a circular dependency from the fw_devlink point of view.

Yes.

> I assume that isn't a problem and fw_devlink takes care of this, so
> the GPU power domain still can probe?

This has been tested on Radxa Rock 5B and RK3588 EVB1. It properly
probes the GPU power domain and fixes late probing of the GPU driver :)

> Other than this, I think this looks okay to me.

I will send a V2 with the minor things pointed out.

Greetings,

-- Sebastian

--2ey5cyrmazej6g4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbr6VsACgkQ2O7X88g7
+prM1A//Tz6tsfCtFAfD+esskzA7MDO9OW+icEYWp1LK1xBvIu+Sx9kB+ggKKHar
q09BTcQD+NSweJfBeabKpIScdmw4YRpMkbpqkGKQkQOYuy2h5udtt6g8nUrvbfIG
BtCo3N1VELMevzo1bW2uYafy2HLqH9rBTUS9kRRxXTfUyYKSwRnmmxrgrhiZJjGx
nrBPWVbj5HouXNoa2X4yuFs3XNG9MP3FkuFBFNZnKb6hcFCv6IApWvrJ71ESUivD
JJjDDKcy3yoVzRxb/AvA49WpCefKi/L2ilOOlZQswtLbLjxJ0ED+3nsHCxDA4RDU
6imPttrxcuEn+bKb8URAYGuxgK110w3TvaBY260JRaPS8EfiI8b439riBllY8aHv
ydpVBNdpvVaT/qG2RvLntsYlk+vx0M+nGRQCFJ4N+JudicQWmHuExncL8qBe8XiL
or6gVTsgmcZ9t3EiC8K/9d+S+icu0utnCDwyEV00byRbxKTrSBeZ2y+FUeEZLUSP
GmpniTJtQ2QkF3afhJZaN/57qZchTg4HmedHlFmqHEBuoh/U1LGG/SDcjiWnKmvp
DL6WYLIshIEAb1edyPmO/y/PdSUolodr2oeJhD9tFul8wC+eAirXa70AlOsS+EHH
wHVJ9BXeOfwEornBUsr41u7LDkCnAcX43WBKVobwDIWltnHXW3I=
=mFbG
-----END PGP SIGNATURE-----

--2ey5cyrmazej6g4l--

