Return-Path: <linux-pm+bounces-36648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C125FBFBC8E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94103356331
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0F340A7A;
	Wed, 22 Oct 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lLl8SCmj"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246F33F8BB;
	Wed, 22 Oct 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135086; cv=none; b=bDnFBJjE4AAZ5noqZDo/gflrQx42rMopZRQQ2gdqy4Sk+UnUhAbvfTre7+ATh61+APrGV8wvAW2vGNr9XTHRPbb9AvY7PInaSdmG1mY+iw3pRPzg5lERM1cOyhWCWUorvpIyZ9BpfvtGcGX/bnviTenL/xsqopYTeLA8fb42rlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135086; c=relaxed/simple;
	bh=tkrprbrk+8tZuog422XZG37Z2QXOb9I1chAizsk7NAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnZJwdDDDw391QRs/+vxcPISUDygWDZR3sd7pRP/NAdoeaL5sZhwpujkcwp4e3SXpAvZp+Ymyv6Hn7HdloPfYLCdAIGUAY/cP+8eqyGgwtaan26xfM9ckRGG3ewAPvtsLg5EsY/0Jd/SJLfC3ZftQU07hahPnmLPCfOUCfZ1XLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lLl8SCmj; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4E8631C008F; Wed, 22 Oct 2025 14:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1761135080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CZAyeo2gXZA3vhy5DvKfZKov9u9r0S6FpowockZMvg=;
	b=lLl8SCmjEcJgaNs/QavwGsENCBBjhd0ueHRhL2T5VuXrVYy1VPEuHteLR1xhec/kADyaSo
	OgvTVaBD0FJT3CXsUCxTZ13rA8uEPMI0MEB8NjG9fUOkUoGWRU6xYrf+MQ1QLSLKNRoxAW
	9P8RfAs5qlvBAKWM1Aenp0tb2l63tSU=
Date: Wed, 22 Oct 2025 14:11:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Fam Zheng <fam.zheng@bytedance.com>, linux-kernel@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, linyongting@bytedance.com,
	songmuchun@bytedance.com, satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, fam@euphon.net, x86@kernel.org,
	liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: Re: [RFC 0/5] parker: PARtitioned KERnel
Message-ID: <aPjJ53F8kBV0/wLH@duo.ucw.cz>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
 <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ss7tpEO8/hjYlNAz"
Content-Disposition: inline
In-Reply-To: <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>


--ss7tpEO8/hjYlNAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2025-09-24 12:01:52, H. Peter Anvin wrote:
> On September 24, 2025 8:22:54 AM PDT, Dave Hansen <dave.hansen@intel.com>=
 wrote:
> >On 9/23/25 08:31, Fam Zheng wrote:
> >> In terms of fault isolation or security, all kernel instances share
> >> the same domain, as there is no supervising mechanism. A kernel bug
> >> in any partition can cause problems for the whole physical machine.
> >> This is a tradeoff for low-overhead / low-complexity, but hope in
> >> the future we can take advantage of some hardware mechanism to
> >> introduce some isolation.
> >I just don't think this is approach is viable. The buck needs to stop
> >_somewhere_. You can't just have a bunch of different kernels, with
> >nothing in charge of the system as a whole.
> >
> >Just think of bus locks. They affect the whole system. What if one
> >kernel turns off split lock detection? Or has a different rate limit
> >than the others? What if one kernel is a big fan of WBINVD? How about
> >when they use resctrl to partition an L3 cache? How about microcode upda=
tes?
> >
> >I'd just guess that there are a few hundred problems like that. Maybe mo=
re.
> >
> >I'm not saying this won't be useful for a handful of folks in a tightly
> >controlled environment. But I just don't think it has a place in
> >mainline where it needs to work for everyone.
>=20
> Again, this comes down to why a partitioning top level hypervisor is The =
Right Thing[TM].
>=20
> IBM mainframes are, again, the archetype here, having done it
> standard since VM/370 in 1972. This was running on machines with a
> *maximum* of 4 MB memory.

Is there a good resource on IBM mainframes, prefferably written in
language that can be understood by mostly x86 kernel hacker?

BR,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--ss7tpEO8/hjYlNAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPjJ5wAKCRAw5/Bqldv6
8qdmAKCq9aYQRiOyTwhd79KoNue/iyLH+gCfclVJI8E1mVVDi3nacu7Cjp9qv7g=
=enlG
-----END PGP SIGNATURE-----

--ss7tpEO8/hjYlNAz--

