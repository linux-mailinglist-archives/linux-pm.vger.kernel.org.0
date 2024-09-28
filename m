Return-Path: <linux-pm+bounces-14889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C18988F18
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD45B20E2A
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6D17DFFC;
	Sat, 28 Sep 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B9TX8qQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2717085A
	for <linux-pm@vger.kernel.org>; Sat, 28 Sep 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727524282; cv=none; b=JOIgrTB6c2vUr8HNxswD3ypF+zmNGJr8/Qek+naWAmNreYGyOBA/i6sqeztYBbAk5tU3AnF86jRAFEGi6l0FssmEhQJ0Dn+4TjyCFiTI9OCX/JWiQk2sr3igaKSgrwWYhEcUNjkqduSIMtZTlIUR9Zf1M224D2XNwBuEbsWBktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727524282; c=relaxed/simple;
	bh=W/sGthTrHg2+rnVrhitVYbaDyzOm++jxwY8NP+C0RfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMD802kkL44mLf9WXG8Cq0Kk2Iu2biGR0zTFw4KRYTyTZnps90P+lc8+zIZ1JdBm0rI7SmpRKe4+H1vw/N3lkuBqASGZGL1oM/xnoqR1u1D9jX6G17TJaNrkEM7ifM7L2WaOeYavkKzxDEl/VSMOFpuPx+K6+eVTpoAwvGhB5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B9TX8qQk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso3740735a12.1
        for <linux-pm@vger.kernel.org>; Sat, 28 Sep 2024 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727524278; x=1728129078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAMlCUjml3DAK3libUi7fTN1dV4zXkr078zCmgRlBsw=;
        b=B9TX8qQkdNnIzY5oPFftn3e8iSJ7MoLBeWeSiCzaITm8kA8u7PHiB36O7XIXbdMN4B
         e6o/GwsILDngyoWzpNqLoo2LUDiLtoi4QTzK6VcHKeShNlBtxIFyJ7oSpNi6Su9tY3kD
         b0K5CfQfJLo3D86OmtsgmY5lN3u4M547eUFoXSB+qbhmPECj1wnf3kaJVqDYfqLvADdc
         1tEc77Ux8ZN3cvXteJEoxrtnm3pfmqxW0doXqAlhxZI6ajpDrxil6IHofadXJPuL924W
         87am2zezqHa5QlC4I7azUYkJV2On13Fp43g7/60Y0hwAJyvgegTlpmOZPfFf/565mq5X
         KcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727524278; x=1728129078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAMlCUjml3DAK3libUi7fTN1dV4zXkr078zCmgRlBsw=;
        b=px90w1FegqfLnjF+OxzH61oMm+005LLpYlCftV8UVnyd0Osu0/72fNo4HwgDUQfTE6
         aF7FnD5akWLDNdV5uu8cloFxOlaRopLGQZbv760436ZbRUaySQOCqafewOqTSLO17uyA
         Rrp58jNL/GoiiuGzprDY7fVE9QP25ZxRedUQaYUwFtvpaSOE3GNrmXm9nELjdmw4wG8H
         vKHUx4yw2sYYFh3WEO923U7xIyopg/xrLe3Uo6vtzR0IGG1xF1hzn5d2DhbACsXO0AHb
         QIV6dkpIP8V7yMe+vhinUEwhc+Wtc7LpZGI37GV4m3t6HnfcumSwPU5ksR/m8RYX5Nwh
         cioQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoxD4MiQtp2Fn3ZBEFGBo7lC1Dybp2MdCfWy33mbQcFiEhH1shsgGYL0OlKsDsTUAvUZjFEEcJHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySUu1lt05y61PvtXmsvVOMnskRz8R50MLQ+MxFVCOiCmDgbvwM
	gib9JyLFiDA1ZwfdTtqGuJ358BhBWBd8AWAKNl/3mqqmjjE4NZxpYomd39pzrZc=
X-Google-Smtp-Source: AGHT+IEkOL4DSNIcDJeD0gDlb0phDRVOzJpVEPozDzLi1nNa9X5/by0q5w2itm1dZJeTA0yKcYh67w==
X-Received: by 2002:a17:906:c113:b0:a8a:7d13:297e with SMTP id a640c23a62f3a-a93c4c284cfmr637614466b.55.1727524278124;
        Sat, 28 Sep 2024 04:51:18 -0700 (PDT)
Received: from localhost ([89.207.171.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d7dsm240829466b.195.2024.09.28.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 04:51:17 -0700 (PDT)
Date: Sat, 28 Sep 2024 13:51:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	xiao sheng wen <atzlinux@sina.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
Message-ID: <tehuoiymoyorpsyefsigeyn3fbdngi6jqgrhx4zerzonpezrz2@o7zuls45rtxl>
References: <20240919081121.10784-2-ukleinek@debian.org>
 <229b9ff9ef6cf201b4e56d6ccb03c028c2d8f51f.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvelzrlboxupsdk7"
Content-Disposition: inline
In-Reply-To: <229b9ff9ef6cf201b4e56d6ccb03c028c2d8f51f.camel@linux.intel.com>


--qvelzrlboxupsdk7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 27, 2024 at 03:47:08AM -0700, srinivas pandruvada wrote:
> On Thu, 2024-09-19 at 10:11 +0200, Uwe Kleine-K=F6nig wrote:
> > notify_hwp_interrupt() is called via sysvec_thermal() ->
> > smp_thermal_vector() -> intel_thermal_interrupt() in hard irq
> > context.
> > For this reason it must not use a simple spin_lock that sleeps with
> > PREEMPT_RT enabled. So convert it to a raw spinlock.
> >=20
> > Reported-by: xiao sheng wen <atzlinux@sina.com>
> > Link: https://bugs.debian.org/1076483
> > Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@debian.org>
>=20
> Missing Tested-by?

Neither I nor anybody else did test that patch before I sent it to the
list (apart from a build test). I guess xiao sheng wen might have
replied with a Tested-by tag.

>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks
Uwe

--qvelzrlboxupsdk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb37a8ACgkQj4D7WH0S
/k4z1wgAldQj1AAKnKUONvJW51taLLRErmiVEx5PAyuvl5dPZRrSXzzF+JpiXM1L
OhJ/7ipt/x4VMZh3LiKXNZIHw47u5sApQoPbOmxIdgzWa0MhLO99n1GWIZPkEKDI
K73DlDQH2CL200BRtynb+ATzVdBVNhBjS/qXyxFP1B4LabjDgpvkQug7uSR9NFEs
D50SkD4b8ZWJWeV+GG5BJKxTCu7QXFw1PD1gQwDehsIQ8il3VIC0v1aT5ssQwtFe
FGc3YH4qMBo2DDq8jCCrr1Yhb7sLFzimXeXYHp1H7on9KrT+4rGaBK4N7Xta85BA
nKSegZ2fojfYsb/1erEU+mFqQniJ1Q==
=vnd3
-----END PGP SIGNATURE-----

--qvelzrlboxupsdk7--

