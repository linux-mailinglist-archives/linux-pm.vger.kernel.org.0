Return-Path: <linux-pm+bounces-11392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7457593BDE9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4F5B211C3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B601741EC;
	Thu, 25 Jul 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="UAeDYq++"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1311741E3;
	Thu, 25 Jul 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896031; cv=none; b=tK32dBD7xcGQt7hUopePwTNP6ZQGta34FFLYZtU3AfnSD0DyTvPojTPCAVsy4ALJdl3jPjmdmnal5yzOQdAQiGxNkBlZ2F2M42IUk/GajRDKgbFDjkmiozYso3JyMoFwzCtMb4/xFm6XNaON+HqqP3r+AcAb7RT/dWf6UrB6dJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896031; c=relaxed/simple;
	bh=9RdhHazpMLiRLf1RJyMzY/cf8/4FQc+lIhbeJLtBnGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwDvkcECUNYEW0AaVBZ+o6hUmlvIft2bS90jcBSdivtYnYIwsg7Nkn0gDI3jSaNFZD8qOyHsS1xUdU/WQqEt7aYEXfd4l2UD0vr6FZBquerjJxQcf0ec4Zc629udXD/FdIvFGYvgAT5eqwrMyGUGWjtEhGNJiUPyPXSjRJ4faIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=UAeDYq++; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 523071C0082; Thu, 25 Jul 2024 10:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1721896025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFbACWo+/4eEnZ8t2mtb6NlZ4dsDG8eMUSb6mhYERNo=;
	b=UAeDYq++YM4N+rJG1g/6V0rlGU3/GSk5LzE5pgb8EB5InTsHRF1xqjfHVh+8gUSEH+axdY
	//L+/HyoS63M3y1fOkWkwHWBRAX+keZ0fyeQFs7SzyRhzDGSc7Nf4JwRfa/t7pxggUnfu6
	WioZBw+ugwVcBel0/MYzs32wKOMc2Sc=
Date: Thu, 25 Jul 2024 10:27:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, dianders@chromium.org,
	tglx@linutronix.de, song@kernel.org, liusong@linux.alibaba.com,
	yaoma@linux.alibaba.com, kjlx@templeofstupid.com,
	lizhe.67@bytedance.com, linux@weissschuh.net,
	j.granados@samsung.com, linux-kernel@vger.kernel.org,
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>,
	"TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, SilviaZhao@zhaoxin.com,
	"Linda Chai(BJ-RD)" <LindaChai@zhaoxin.com>, Felixzhang@zhaoxin.com
Subject: Re: Unknown NMI after S4 resume
Message-ID: <ZqIMWDWn5W9+9RMA@duo.ucw.cz>
References: <14cf0b83-7030-4ec5-97b1-40c90424fe3f@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2csWns10UJmAifA"
Content-Disposition: inline
In-Reply-To: <14cf0b83-7030-4ec5-97b1-40c90424fe3f@zhaoxin.com>


--/2csWns10UJmAifA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When running S4 test on Zhaoxin platform with Ubuntu22.04 kernel-6.10 we =
got
> unknown NMI messages after S4 resumed:
>=20
> [  115.792224] Uhhuh. NMI received for unknown reason 2d on CPU 0.
> [  115.792226] Do you have a strange power saving mode enabled?
> [  115.792228] Dazed and confused, but trying to continue
>=20
> And reproduced on Intel platform.
>=20
> After tracing, we find that the reason for this Unknown NMI occurs is as
> follows:
> a, 1st kernel starts normally and NMI watchdog is enabled on all cores;
> b, NMI watchdog is disabled on all cores through the sys interface, then
> variable active_events goto zero;
> c, Start hibernate, create & save hibernation image, then go hibernated;
> d, S4 resume event happened, 2nd kernel starts normally and NMI watchdog =
is
> enabled on All cores;
> e, 2nd kernel find S4 image and try to restore S4 image;
> f, 2nd kernel disable non-boot CPUs, which would disable NMI watchdog for
> APs;
> g, Restore S4 image saved at step c;
> h, 1st-hibernated kernel restore, re-enable non-boot CPUs, as NMI watchdog
> is disabled in step b, this which would keep APs NMI watchdog disabled;
> Besides, the variable active_events is restored to zero;
>=20
> But BSP NMI watchdog is still enabled, and the PMC will trigger NMI
> interrupt periodically.
> If PMC NMI triggered, perf_event_nmi_handler will be called, but it would
> see active_events is zero, so it goes out directly and return NMI_DONE;
> This then leads to unknown NMI messages.
>=20
> static int
> perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
> {
>        u64 start_clock;
>        u64 finish_clock;
>        int ret;
>=20
>        /*
>        * All PMUs/events that share this PMI handler should make sure to
>        * increment active_events for their events.
>        */
>        if (!atomic_read(&active_events))
>               return NMI_DONE;
> ......
>=20
> It seems that the BSP does not refer to the settings of the NMI watchdog =
sys
> interface previously saved to the S4 image to configure the NMI watchdog
> when doing S4 resume.
> Should consider this situation and patch it?

Yes, please.

The watchdog driver should get suspend/resume hooks, and probably do
same init on boot and on resume.

Best regards,

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/2csWns10UJmAifA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqIMWAAKCRAw5/Bqldv6
8lJOAKCejXEV2l8E/VAtPKNSgf8f0dOo6wCfU8Ir6fwZxJcKg7UK16WguAoe0dc=
=xHYE
-----END PGP SIGNATURE-----

--/2csWns10UJmAifA--

