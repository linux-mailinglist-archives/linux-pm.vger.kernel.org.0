Return-Path: <linux-pm+bounces-8500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE128D73D2
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 06:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8AEB21096
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 04:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B5BA42;
	Sun,  2 Jun 2024 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Pix/kfCr"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE5AD2D;
	Sun,  2 Jun 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717302314; cv=none; b=oJfYUaKzBUkm2bZNJIjfepVf6T8E93TcBmQruzGbBlVW0DdH2U57neuD5xD1DBseNgmLmKoZ4dTruCvd4pVJVVFuKPfcbMgT5JCWWmLv4mJ8B8vgsQv6nV24XOr0RkCWsw/WL6rW9hLaIkSviaq/t/sEmA9eCxCats+WFqfQSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717302314; c=relaxed/simple;
	bh=ZosBth80LyMdqOo6UU8+6GNKhEAgGgSWrz6ZGI1sWcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5u3/U3Q08izk+OYH3gjkyQqDNzP0E27CfF3Bf77Hb+VG8//VLcKWxXEGqaEgPup/PO/eStOrtznWLt6yrVusucTOOC2wMJbHnwQVLAKm3wT+SB5FmKnvX+yAVk0b+6bn/qz+GeLA/sdF612BLlIyrl/dWXSGY7zTbBWMaTvHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Pix/kfCr; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717302310;
	bh=ZosBth80LyMdqOo6UU8+6GNKhEAgGgSWrz6ZGI1sWcY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pix/kfCr2EAwk4bT1w75YXJIKdGumxsefudGZEPBhJ8aoARFziIhd9PIrEVZ7L7/X
	 u7dCs91LQJ0kLAyRCSYE/1gChpXL/ui6z+vnjzvI046TlYJG84H4AtbHVNihHeXrX2
	 kvuQRbLSFw79bl0y9efh1frxPIsMLiEyD3XY9vgY=
Received: from [IPv6:240e:358:11e7:eb00:dc73:854d:832e:3] (unknown [IPv6:240e:358:11e7:eb00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 46B1A67445;
	Sun,  2 Jun 2024 00:25:07 -0400 (EDT)
Message-ID: <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sun, 02 Jun 2024 12:25:01 +0800
In-Reply-To: <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-01 at 21:03 -0700, srinivas pandruvada wrote:
> Hi Xi,
>=20
> On Sun, 2024-06-02 at 11:21 +0800, Xi Ruoyao wrote:
> > On Mon, 2024-03-25 at 18:02 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
> > > The global.turbo_disabled is updated quite often, especially in the
> > > passive mode in which case it is updated every time the scheduler
> > > calls
> > > into the driver.=C2=A0 However, this is generally not necessary and i=
t
> > > adds
> > > MSR read overhead to scheduler code paths (and that particular MSR
> > > is
> > > slow to read).
> > >=20
> > > For this reason, make the driver read
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > > just once at the cpufreq driver registration time and remove all of
> > > the
> > > in-flight updates of global.turbo_disabled.
> >=20
> > Hi Rafael and Srinivas,
> >=20
> > Thanks for the clean up, but unfortunately on one of my laptops
> > (based
> > on i5-11300H) MSR_IA32_MISC_ENABLE_TURBO_DISABLE is mysteriously
> > changing from 1 to 0 in about one minute after system boot.=C2=A0 I've =
no
> > idea why this is happening (firmware is doing some stupid thing?)
> >=20
> > I've noticed the issue before and "hacked it around"
> > (https://bugzilla.kernel.org/show_bug.cgi?id=3D218702). But after this
> > change I can no longer hack it around and the system is much slower.
> >=20
> > Is it possible to hack it around again?
> >=20
> Please try the attached diff and build kernel and try.
>=20
> git apply update_max_freq.diff
>=20
> Then build kernel and install.

Unfortunately it didn't work.  Then I tried:

@@ -1304,6 +1310,10 @@ static ssize_t store_no_turbo(struct kobject *a, str=
uct kobj_attribute *b,
 	if (no_turbo =3D=3D global.no_turbo)
 		goto unlock_driver;
=20
+	global.turbo_disabled =3D turbo_is_disabled();
+	global.no_turbo =3D global.turbo_disabled;
+	arch_set_max_freq_ratio(global.turbo_disabled);
+
 	if (global.turbo_disabled) {
 		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
 		count =3D -EPERM;

and my old hack worked again.  Curiously after I writing 0 to
/sys/devices/system/cpu/intel_pstate/no_turbo successfully, your code is
triggered.

$ dmesg | grep intel_pstate
[    0.554425] intel_pstate: Intel P-state driver initializing
[    0.554877] intel_pstate: HWP enabled
[    1.780021] intel_pstate: Turbo disabled by BIOS or unavailable on proce=
ssor
[   21.789044] intel_pstate: intel_pstate_update_limits cpu:0
[   21.789053] intel_pstate: intel_pstate_update_limits cpu:1
[   21.789060] intel_pstate: intel_pstate_update_limits cpu:2
[   21.789189] intel_pstate: intel_pstate_update_limits cpu:3
[   21.789198] intel_pstate: intel_pstate_update_limits cpu:4
[   21.789203] intel_pstate: intel_pstate_update_limits cpu:5
[   21.789209] intel_pstate: intel_pstate_update_limits cpu:6
[   21.789276] intel_pstate: intel_pstate_update_limits cpu:7

The message at [1.780021] is from the first attempt writing 0 to
/sys/devices/system/cpu/intel_pstate/no_turbo when
MSR_IA32_MISC_ENABLE_TURBO_DISABLE is still 1.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

