Return-Path: <linux-pm+bounces-8568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA08FAFE0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3321F24013
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F81420B7;
	Tue,  4 Jun 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="RIBclG0j"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2872566;
	Tue,  4 Jun 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497153; cv=none; b=L9RGQRhJmcUX+2QECU+kgV3XbfNz4lns9Z5U0YSe8Jzn99Hj1ynivmGQ+FAyyyop7PmPRxvJqsSyj9LDHMRtNlzJI7eUwavmYp+4CeYDEX19bDvF5qA6FH9u73OphBaoqLa7zwuTvAhp/V3jl84EbF323f7lAS8GRwm+zaNOA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497153; c=relaxed/simple;
	bh=wpcAi4enpYzd0kfnEOi1NkxVY22NtCkMLmxRw+8RjlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tN+aFtWUKxXPCSWgpi8nP5WmHj5ARo/Q3/45aCiElgjOfuuprBflhU7kdq7PtjbZNpXPxoDw8DD51bysRes90TY9lV4ApCUujsVQ0bCMUB1WOgigsa9FEpJve1/HWvhxCnKHrk44N0xLZRH5hr9BC7KAtnt9KKtOCAspJceV3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=RIBclG0j; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717497149;
	bh=wpcAi4enpYzd0kfnEOi1NkxVY22NtCkMLmxRw+8RjlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RIBclG0jB9B/SJn7h9s0YCp/Shiu3cAgG5q/J0IZWtD4Lm7DMtXAgMJnvArNJX+ln
	 nKSDw+r1n1FPj4OOwd/+WyLRVxKK3lxFwMPZXk/nEgYCsOHnUmYEnYBKWVNXmhqU4G
	 ZrdgLIlSRU/fejwzMpA9WBnWmRcSEjaRxuLQYHH8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 32D826591E;
	Tue,  4 Jun 2024 06:32:28 -0400 (EDT)
Message-ID: <258ce61c155c28937620f6abe57a39f2b4b0ff56.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2024 18:32:25 +0800
In-Reply-To: <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
	 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
	 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
	 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
	 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
	 <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
	 <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
	 <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 03:29 -0700, srinivas pandruvada wrote:
> On Tue, 2024-06-04 at 17:30 +0800, Xi Ruoyao wrote:
> > On Mon, 2024-06-03 at 21:31 -0700, srinivas pandruvada wrote:
> >=20
> > > > > Second, a delayed work can be added to check the MSR long
> > > > > enough
> > > > > after
> > > > > initialization and update global.turbo_disabled if it is 1.=20
> > > > > However,
> > > > > that would require some code surgery.
> > > >=20
> > > Something like the attached which does same way as user space
> > > no_turbo
> > > update.
> >=20
> > > =C2=A0static int intel_pstate_register_driver(struct cpufreq_driver
> > > *driver)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > @@ -3114,6 +3137,9 @@ static int
> > > intel_pstate_register_driver(struct cpufreq_driver *driver)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.turbo_disabled=
 =3D turbo_is_disabled();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.no_turbo =3D g=
lobal.turbo_disabled;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (global.turbo_disabled)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&turbo_work, HZ);
> > > +
> >=20
> > I have to change it to 20 * HZ to make it work for me.=C2=A0 15 * HZ do=
es
> > not
> > work.
>=20
> Is there any consistency or it is changing every time?

It seems consistent.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

