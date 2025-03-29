Return-Path: <linux-pm+bounces-24600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC9A753F9
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 03:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F286175DA6
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 02:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D04290F;
	Sat, 29 Mar 2025 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="JWeXMDwF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oBCbwYk5"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A19801;
	Sat, 29 Mar 2025 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743213731; cv=none; b=XVeS3fZs9aO6L6oFVhqfuu7arvWR3tIe4eVNjEXPiFQt+1lOIURtsmjpfHeUPDOy8tCMMFx8gLjsB2EM9alNaTgn5Gp3mQWlvKk2l9AVFvJGfY7Koll1YZ0XuOsuzA6mIlE8qHowgBoczHDjY7tS+OZMwLK53Ry5jUTUDGopeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743213731; c=relaxed/simple;
	bh=e/V1ZHt0uebkLWbaqsJY8znBoXzzMRg+4ELVgEr4G1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/41tUJShroHcBlAZnHhV8OiHl9Kn+nRNufAcagRVhiBJQFiM0qzfgKq2rXesxyAaJhGTfQ+GIxmA9xWwMrTZxsRTeP7laZSB0FmRRJZMDH9vSVJIkNjUvnUwa0I9LKOBRN5PV/OHFyXul3UnqSPsOMuFlZ6Gco1rwkOTI+fz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=JWeXMDwF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oBCbwYk5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D74A13833EC;
	Fri, 28 Mar 2025 22:02:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 28 Mar 2025 22:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743213727;
	 x=1743300127; bh=QycLDA4stR8tZNNCUyXC3JQQhELaYMs4b0Np04+ALWQ=; b=
	JWeXMDwFXIwIgMQgAxRl/OOBwzkqEMPAVsCDFmovtpam5vRiePz3g0Olzx8VCzPc
	aBvutot94Mm5aqEIVEG83C9Mj3RFMqLhRL9INbX8+DCH5lBAzzRVpY0+KR3yc29y
	dKZY8s72hHnB/6FY4dlFs2IXaBz2DWx/eL0OB1RbM25SlA4e4MuZGp1MN+exTh+O
	JNM/aqOJJIAL+nEb3Fqe8yEsRzfopmhXTqAt2STBRiOVfZvuBbulKshbJSFMij9a
	YElXkq3zKbCwz5jFWduNE6OQnuAD2Ng3guiQl8MPBoODtCETjKGB6gHcwA79kdFp
	/hA9+ZATeMXdJNIoJAVwpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743213727; x=1743300127; bh=QycLDA4stR8tZNNCUyXC3JQQhELaYMs4b0N
	p04+ALWQ=; b=oBCbwYk5E6eR/NtyMSNCiff25vhQArhbewUeK2K+SucGgZ72kLk
	Dvr3ySTxA9WNLbcHhsxOOnmON52byOlJpSsma7M3+bAlWonup8yA9s77ynzTWMmV
	pVJVNSDeeMh65NF6sWftMF6iFUToVuT3v7Qs3vYXOfBjYpIMy6yFL/u0z5ZaaIyJ
	FXk3oWsrtMpdmJAg3AaNGQvsbxwKeouEuaXT0vf09pbheG4LUV3JZa7EjwGUL8Ba
	5Da3ULYtXT3AHVaPEi7/yd+6k6cowvB/SASCOGqE9qmfZDLvwpfdR2tz4XXFvM9K
	Feu/NIhfkKWdzrCRPQipPMtrnvM4f+BEjRQ==
X-ME-Sender: <xms:nlTnZ1bDpSkXWkY9849fOc_iQxfNfp9XhXIiv1oLvepGr3uPLBTZXg>
    <xme:nlTnZ8aLUZgBsso7PMi6POvBdkojgITHcB4eKQN50lGRAxM867zXCU66KsQW-Udns
    HWab7s60xKD1g>
X-ME-Received: <xmr:nlTnZ3-_NKQphR5IbPF8vuIXTHl98uxEzL__89-QahmAYZsvRZtRgXPyugV7MLBd2UUFpd_TyJhTCkShJ6cdZVq7lojg5mK0kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    jeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuc
    eomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecu
    ggftrfgrthhtvghrnhepgeehheeludegueeugedvffekjedvvdeludfgieevteeijefhie
    evieejhffhgeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpqhhusggvshdqohhs
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjfiesrh
    hjfiihshhotghkihdrnhgvthdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgr
    rhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslh
    hinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghi
    vghllhhosegrmhgurdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgrsegrrh
    hmrdgtohhm
X-ME-Proxy: <xmx:nlTnZzoPeT6J7_mHr1xLuYNtLB540uk-01M8lnXoY40FgOsScN4fKw>
    <xmx:nlTnZwpc9e7c3BkkRsHPjs_LOh_m2P791xl5LcCcEfd3BJMlWgxdZA>
    <xmx:nlTnZ5TIRzVCqkFYvmxpV85zwsDcNN5xgvMu-rG09CKubbAlrj-ATA>
    <xmx:nlTnZ4rw0uCj87u3zanC1kNgAJVVJrtI3L7CMR40UUlvdN5jX1wDug>
    <xmx:n1TnZ4KT7df4pPBwBXS7j4gA7ubEq4HF6rZr03DZQY6kC1ORnTiWzMfB>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 22:02:05 -0400 (EDT)
Date: Sat, 29 Mar 2025 03:02:01 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in
 cpufreq_update_limits()
Message-ID: <Z-dUm_z8daM_nQoy@mail-itl>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <1928789.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KGJBHCHIqZX+AzAF"
Content-Disposition: inline
In-Reply-To: <1928789.tdWV9SEqCh@rjwysocki.net>


--KGJBHCHIqZX+AzAF
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Mar 2025 03:02:01 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in
 cpufreq_update_limits()

On Fri, Mar 28, 2025 at 09:39:08PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Since acpi_processor_notify() can be called before registering a cpufreq
> driver or even in cases when a cpufreq driver is not registered at all,
> cpufreq_update_limits() needs to check if a cpufreq driver is present
> and prevent it from being unregistered.
>=20
> For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> policy pointer for the given CPU and reference count the corresponding
> policy object, if present.
>=20
> Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of =
_PPC updates")
> Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> Reporetd-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
=2Ecom>

Reported

I wanted to propose also Tested-by tag, but technically it's not me who
tested it: https://forum.qubes-os.org/t/kernel-latest-6-13-6-boot-loop/3292=
6/18

> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2781,6 +2781,12 @@
>   */
>  void cpufreq_update_limits(unsigned int cpu)
>  {
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +
> +	policy =3D cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;
> +
>  	if (cpufreq_driver->update_limits)
>  		cpufreq_driver->update_limits(cpu);
>  	else
>=20
>=20
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--KGJBHCHIqZX+AzAF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmfnVJsACgkQ24/THMrX
1yzUGQf+PQ8QdbuWgXIo+xFm+zARm08zZkxhAzij9gxb8iJgbZZ6WqLoXoAxiiKH
UmMroeB1t/3GAz9a/45XBjregO5HwE8T64lutm+BuYPMaSrHoYqQn4U/7QRixJcr
Ygz3MwpYwe7tICNW6Pmf078NOiVIxys7Na4htfoDP8sJq/B/4RIwg9pDr+TzO6BV
3N6m2H+4IqXXDkNECU9Ow722eH6ObtInbcFuaal1W3kNY7g+fal1gJUFPCC5YBEp
h4CL9s5iOwnPvHgN0sIjT8LV3HhlV2FGKBpWhW891JjF1UH8HETGHNIDe/KzIKiZ
ucjSxUjIF0p6tArlHim3VjhUrbugSg==
=Qk/O
-----END PGP SIGNATURE-----

--KGJBHCHIqZX+AzAF--

