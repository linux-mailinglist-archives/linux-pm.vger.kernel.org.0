Return-Path: <linux-pm+bounces-18042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C19D7FC9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C1B265F4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1818FDBA;
	Mon, 25 Nov 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDwD1bBa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBC18C004;
	Mon, 25 Nov 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525295; cv=none; b=rhp39nAHQCX7sX2g7yDXzYMqFyPTBziYnyhMTy6BsDbZzsMYyXcyatQZEmJ9dO/qEgDh+8TyvMmVoGJbp8DE+NBFTY+CUWuWjb+fehHCGxfD8EKEEGFRqMvqiLZnaIdfcDzrIxGqXoHaSpzUoejs84LQq5BDYU2Bj7aUF6E1vHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525295; c=relaxed/simple;
	bh=j4CgOW/UoFO3+P6ChEexl3YHtLFB7F+E1YeGfiQnv4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNlmRwjs2mBE8Up89DuHwBHpBoATSP6x4CbqBKMSJv5EEZTJuvz+LfLm1P65GYTZUJ1eW/iHePIc4ffvlDyft7kt+McQzerXchMa8PRG/YY1UuUJTW9ciYre/T30QLm40+Q1ZDF3MDPiBMZCqoNsigrTgBSGPg60D6NO7tuugd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDwD1bBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EFDC4CECE;
	Mon, 25 Nov 2024 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732525294;
	bh=j4CgOW/UoFO3+P6ChEexl3YHtLFB7F+E1YeGfiQnv4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDwD1bBaFeQ2VbbSqXhyFTsN4utJIqHEPh6rk3UCG+xAcS3FSE5zh9e42e3goiyZc
	 cAMNaoXaDxrxjyLIXjw4hKSC0GfD4zDJLk9F/MshsrdY5sI2+WY06X2iGM/1WKhOSX
	 /ZQeIB0EumP7v5M1y3V3MNDEMZaw05UrQuEPiLPmee/jPk/YznNYNIHxMlEUEkUQcz
	 +Ksa4Kc4Jeq35jj8BYAt9n59iJ1M/O5NKk0cKaoI4b3BMXhcOZC1xnT6hGIQGbaqeQ
	 3ZCLnrRGJf/D96UrYpDy+i3v6GystY86x/15dqDrXjqYf+dYPn1VyvfBEwsrZeJNpN
	 +PJPFBLX3xlXQ==
Date: Mon, 25 Nov 2024 10:01:31 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Radu Rendec <rrendec@redhat.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, robh@kernel.org, arnd@linaro.org, linux-kernel@vger.kernel.org, 
	Zhipeng Wang <zhipeng.wang_1@nxp.com>, javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
Message-ID: <20241125-eminent-devious-zebu-ec2caf@houat>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
 <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="43rrzlpdnp4ikjdi"
Content-Disposition: inline
In-Reply-To: <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>


--43rrzlpdnp4ikjdi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 06:09:16PM +0100, Javier Martinez Canillas wrote:
> Radu Rendec <rrendec@redhat.com> writes:
>=20
> Hello Radu,
>=20
> > On Thu, 2024-11-21 at 10:13 +0100, Javier Martinez Canillas wrote:
> >> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >>=20
> >> > On 21-11-24, 09:52, Javier Martinez Canillas wrote:
> >> > > Will autload the driver for any platform that has a Device Tree no=
de with a
> >> > > compatible =3D "operating-points-v2" (assuming that this node will=
 be a phandle
> >> > > for the "operating-points-v2" property.
> >> > >=20
> >> > > For example, in the case of the following DT snippet:
> >> > >=20
> >> > > cpus {
> >> > > =A0=A0=A0=A0=A0=A0=A0 cpu@0 {
> >> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 operating-points-v2=
=A0=A0=A0=A0 =3D <&cpu0_opp_table>;
> >> > > =A0=A0=A0=A0=A0=A0=A0 };
> >> > > };
> >> > >=20
> >> > > cpu0_opp_table: opp_table {
> >> > > =A0=A0=A0=A0=A0=A0=A0 compatible =3D "operating-points-v2";
> >> > > ...
> >> > > };
> >> > >=20
> >> > > It will autoload if OF finds the opp_table node, but it register t=
he cpufreq-dt
> >> > > device only if there's a cpu@0 with a "operating-points-v2" proper=
ty.
> >> > >=20
> >> > > Yes, there may be false positives because the autload semantics do=
n't exactly
> >> > > match the criteria for the driver to "match" but I believe is bett=
er to load it
> >> > > and not use for those cases, than needing the driver and not autol=
oading it.
> >> > >=20
> >> > > > I am not sure what's the best way forward to fix this.
> >> > > >=20
> >> > >=20
> >> > > I couldn't find another way to solve it, if you have a better idea=
 please let
> >> > > me know. But IMO we should either workaround like this or revert t=
he commit=20
> >> > > that changed the driver's Kconfig symbol to be tristate.
> >> >=20
> >> > Yeah, this needs to be fixed and this patch is one of the ways. Lets=
 see if Arnd
> >> > or Rob have something to add, else can apply this patch.
> >> >=20
> >>=20
> >> Ok. Please notice though that this is an RFC, since all my arm64 machi=
nes have
> >> their own CPUFreq driver and are not using cpufreq-dt-platdev. So I wo=
uld not
> >> apply it until someone actually tested the patch.
> >
> > I tested the patch on a Renesas R-Car S4 Spider (r8a779f0-spider.dts)
> > board, and it didn't work. I think the problem is that the OPP table DT
> > node does not have a corresponding device instance that is registered,
> > and therefore no modalias uevent is reported to udev/kmod.
> >
>=20
> Thanks for testing! Bummer that the workaround didn't work. But that's why
> I asked you to test. You know, like Donald Knuth said: "Beware of bugs in
> the above code; I have only proved it correct, not tried it" :)
>=20
> > FWIW, the OPP table is defined at the top of r8a779f0.dtsi and
> > referenced just a few more lines below, where the CPU nodes are
> > defined.
> >
> > As far as I understand, there are two options to fix this:
> >    1. Revert the patch that allows the cpufreq-dt-platdev driver to be
> >       built as a module. There's little benefit in allowing that anyway
> >       because the overhead at init time is minimal when the driver is
> >       unused, and driver can't be unloaded.
> >    2. Modify the driver and create an explicit of_device_id table of
> >       supported platforms for v2 too (like the existing one for v1) and
> >       use that instead of the cpu0_node_has_opp_v2_prop() call and the
> >       blacklist. That would of course also eliminate the blacklist.
> >
>=20
> Agreed with this. Likely (1) is the easiest path and (2) would make the
> driver more aligned with the rest of the kernel (that have a list of OF
> device IDs to autoload / match instead of some custom logic).
>=20
> But I guess that (2) would be riskier, since not adding a platform that
> uses v2 will cause a regression.

Also, 2 probably wouldn't work. Devices under /cpus don't get a struct
device created for them, so it wouldn't probe.

Maxime

--43rrzlpdnp4ikjdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0Q85AAKCRAnX84Zoj2+
dmpJAX0cekmVgwNl35X7Nrv66juttUvAd457Z70pGQEcQUIwqsIKsyuTY/5pVwvA
x1wK4RUBf3iuQgsNCOQgHAh6t6l/mrjILAIXQpKwSQx7UP/uBwHOz1aBU5kgqDR9
iyG71jWhvA==
=/4QH
-----END PGP SIGNATURE-----

--43rrzlpdnp4ikjdi--

