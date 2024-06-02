Return-Path: <linux-pm+bounces-8498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097B8D733B
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 05:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C431C20BDC
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 03:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172963B8;
	Sun,  2 Jun 2024 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="DGYQFQwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAFB79C2;
	Sun,  2 Jun 2024 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717298531; cv=none; b=gSoFeZw9hphr2G/2bY68PU8qNhJV0K61//2IXay6y2QqmK6AmmHbqN4IqY/HWDK/E2psD+OYu6lw2ltMcnpuofj22U1mY5QRMmSMtLA2qDjxADB9QNQOQZrMYb1LjsRA+q8NOuaMaaoBJ8U2KbZn87O0YUt5nEUx7Co1q+EYPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717298531; c=relaxed/simple;
	bh=ZT4I4nTMNjP+16wPoejISiX4teMein0dpUSm1Zq1j4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKC1U5QnsRqYR6ZKOlXhLZs8R3MQbdyje4/cqowYBMc5vGlbihAkqBPkIYrUN1y+BmIDq3eMURxar6MgdDHomKpBURJ9BpiVls0KkehYqwpkIHOyQTpvcf6l6TlckX8omIgQmXaGLfFMzwc2GbKFcBY9bvpj17YS1tFhnLHoyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=DGYQFQwh; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717298522;
	bh=ZT4I4nTMNjP+16wPoejISiX4teMein0dpUSm1Zq1j4M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DGYQFQwhdWFJkqK6QXKRA7qVl7tR+o4rln86Hj8riI4rd2f0eOXf9PgtxtRinV07p
	 Vqmvzexd+dR/u4XeGT8/tRP3mSgQCMNPPRHnneFWk0tDToT7PTYEGpxhaZrA9NP0DX
	 DJ7uhoRB7CJ5d5VSddXAEsRydzeVNaVQHiC0DCjk=
Received: from [IPv6:240e:358:11e7:eb00:dc73:854d:832e:3] (unknown [IPv6:240e:358:11e7:eb00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 18E356732C;
	Sat,  1 Jun 2024 23:21:59 -0400 (EDT)
Message-ID: <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada
	 <srinivas.pandruvada@linux.intel.com>
Date: Sun, 02 Jun 2024 11:21:51 +0800
In-Reply-To: <8366982.T7Z3S40VBb@kreacher>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 18:02 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The global.turbo_disabled is updated quite often, especially in the
> passive mode in which case it is updated every time the scheduler calls
> into the driver.=C2=A0 However, this is generally not necessary and it ad=
ds
> MSR read overhead to scheduler code paths (and that particular MSR is
> slow to read).
>=20
> For this reason, make the driver read MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> just once at the cpufreq driver registration time and remove all of the
> in-flight updates of global.turbo_disabled.

Hi Rafael and Srinivas,

Thanks for the clean up, but unfortunately on one of my laptops (based
on i5-11300H) MSR_IA32_MISC_ENABLE_TURBO_DISABLE is mysteriously
changing from 1 to 0 in about one minute after system boot.  I've no
idea why this is happening (firmware is doing some stupid thing?)

I've noticed the issue before and "hacked it around"
(https://bugzilla.kernel.org/show_bug.cgi?id=3D218702). But after this
change I can no longer hack it around and the system is much slower.

Is it possible to hack it around again?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

