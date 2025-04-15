Return-Path: <linux-pm+bounces-25470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CDCA89EF7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE8F7A2DE8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A72973BA;
	Tue, 15 Apr 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="g1vL/jWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIsj/ITX"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92402949F9;
	Tue, 15 Apr 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722505; cv=none; b=qH6Uudy82Gn29vngm/MAyb6dDQH4f3jxu33QW4QNbDMv8hV9ZkbqzjQtM6J49cAInmL9qmtN+0lH2Yq71w3LWQdbBO3aXcLyWfEvnplPmwXZaK01DWMREsxofv6FxwKcFhorRx5F9886Aejjfcxhqm2xAvNt2OjE84NdSX3XA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722505; c=relaxed/simple;
	bh=LFHHOdKIEHi28QunVdPZ/PA6tBElS1oeV9WZk8dvqyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIv99LA8wXECliyc76d7zqTvtEHbcwQ5sKscvwEABkR4OCTZchTxZjboryf2XzkoVErUQWGHwcAqCzOUWuW6KsjfoGZyVnodqlXfhBvOKIDY/0iC+uXlKi8i/yLhAdadzYin6BF7OC9jwMf1vUA9uuAprvSoxD5aSxr1cCw2rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=g1vL/jWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIsj/ITX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8197111403AB;
	Tue, 15 Apr 2025 09:08:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 09:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744722501;
	 x=1744808901; bh=xA9Xlxmq09ENSXnxA5kYNDInLOQ3lpFIKckJl2wyvaY=; b=
	g1vL/jWZr3xkJdvosSFyNpaQEwlrs+73YlTa3DGoJ2K8qE590Lt91C94eIJMLP4n
	mUVT2QcuGomlo3bJj+WQLpgj7WEVx32qa4KdeVg/K92WRUBVnP53Sfx/Yi2HXmIw
	ik276X+c91Pr3B41mjTN5lS4QLuG5f0PtIm8d4vqte0MBWCKvDh+REjWPpDvtKoF
	WOZNa6YPJ9YysE+Bu8ncET9aQCO0+ekCJn9hiBjkZkUhMoDrhOJNcC8dJ88UTq4x
	hOtSNSf5+rK+l60VjoRS/IyWLkvvpdZsYTWwuN5GyMEaA8ThMidbI/WfgicsT/ai
	vR9v/h8iRuEc4SjYxBQOjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744722501; x=1744808901; bh=xA9Xlxmq09ENSXnxA5kYNDInLOQ3lpFIKck
	Jl2wyvaY=; b=AIsj/ITXRvXP8HSHn5v7D5jPmeFus07tcwjNZBQe9WOR8Eydwrt
	99gZsQ98cQPRaJribXXIorfYekWjutv1qkUsR6BFTjpTiCRVcgCJg/aqBlviH1a6
	pliO51bpkBn+uGCTR7n6kNSBaYY+5gwUWO3nqNzLrKxO3SkmuRcxWu4uKhiNWapv
	KSuabtdmi0R/bCnZAbLYLt7IHJIX2YVEg3Wzy5IQwhrifMertSCu53Y/1UGozSdV
	tLHACvQB7lP0oRw6PWrj8bhDOQgL2EPjfirqNgUwhXSTHGtGJ9z7UWIiiCL/MDCe
	nUqrd1q++ZWSzg6JGHGE+5s1+jO8ct2h/Hg==
X-ME-Sender: <xms:RVr-Z2-TPWDoW7h1aJm1kaX8KOYgu_zF_AKnW949Oa_m86QTnWG3_Q>
    <xme:RVr-Z2uc98BzCabdwRI6zn-I81OIKdBgoZxXUvX7OtNxz2Jp0ydNYYV_VTnejz7F_
    sQjSuIn-6tofg>
X-ME-Received: <xmr:RVr-Z8AT-pO4Y-BlwPRB88Yb9X6ziy9NkJhtPWoVdOcD2e9Wu7PpmNqepUsHnc5QSJv8iY16lp3Ot97cDJ2ZPwfAA4332Juptg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    jeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuc
    eomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecu
    ggftrfgrthhtvghrnhepieeluddvkeejueekhfffteegfeeiffefjeejvdeijedvgfejhe
    etuddvkeffudeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhrtghpthht
    oheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinh
    hivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghp
    thhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtth
    hopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomh
X-ME-Proxy: <xmx:RVr-Z-dUHKnSdf-w9rXPpVuPNkRVVpQJEE9PBrK8bL6P674zxAsDXA>
    <xmx:RVr-Z7N0j0hzCIdyd9hMv5sUfen1276k32BuET95lKPOK6IejgL3Vw>
    <xmx:RVr-Z4ke2BfIe0JpTytFypMnrqV1X4H-leQJURJnr0Yg_f0BzEd8rw>
    <xmx:RVr-Z9unXbn7phtJyIj_NwqtMhc9b-CscMtKd30cLMZt0NH9IppzEw>
    <xmx:RVr-Z2szoRQdYP3IO5AIgkOfuvltUKW3bn65M2OMWwaZZTLkQWaJGPap>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 09:08:19 -0400 (EDT)
Date: Tue, 15 Apr 2025 15:08:17 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in
 cpufreq_update_limits()
Message-ID: <Z_5aQdqYJCFkcHLi@mail-itl>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <1928789.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eMX8NdoxMYxrK7da"
Content-Disposition: inline
In-Reply-To: <1928789.tdWV9SEqCh@rjwysocki.net>


--eMX8NdoxMYxrK7da
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Apr 2025 15:08:17 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
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
=2Ecom>=20
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It looks like this patch is missing in stable branches.

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

--eMX8NdoxMYxrK7da
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmf+WkEACgkQ24/THMrX
1yz5hgf/S6i//LIDY5LglLWFfkwReDhT9lIsdeaE8WVCNsUbsduRvWJoSRduxa2f
ZvLbGwAxs5KMdrp9/3iW/1g8lC/OP15/U+yEXnAl3aSt4Qp+xOmizbSSPe8pPU+R
G738/u7TNhAekKTEG4+AFs+H6ezuBf2nflDvjmMO7jzk9MhfMeJV26maKWYTedEc
NKVUTHWVMpfqMb/gS3HGCg7gHiX3uHcnkaiOJb4oejWQziq12IPxVwtsfjecbGRR
T/NyBFVJcfuAGQa2n8H19oxAPQJqK/AQdSiXJh8hZ8qBRfHkQViTzWC4ocLu639B
i3p9StmI2FwzJhmmutWgP0D1UxK1BQ==
=BhXG
-----END PGP SIGNATURE-----

--eMX8NdoxMYxrK7da--

