Return-Path: <linux-pm+bounces-15564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAD99B012
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 04:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC1D1C20FC9
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD3DF60;
	Sat, 12 Oct 2024 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5LCdg4m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7553A7;
	Sat, 12 Oct 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699675; cv=none; b=WJTgXsNkUNOuDYlwGuf0buXpnsVYOXaumCnoFSg8eZGfKJ1s2UPEPZF9KZPgWXLuhV+/AaKRnBX4DCG4l5r4rtveEDZAV7G4Nq3OkogNBLIbQp8rgFtNRto8e2Bwp9iPj9V9ZCVIxUYNfC+9Lhevce8wW84u/uuzsuJjL+3/bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699675; c=relaxed/simple;
	bh=VMxTAuuLSwpvF14j63KDL8Q8eddsXGX+MXQKvX8BNmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/rDMGX8x1UdWMQotsELDfrpH1iSmmkYWOAPpE8J36DTW1uIP4lM2D+KanqeQ8FjMjkKLlI8s7Cq5bQfb4mLYAVkEB1MH34bc5VgM1+8weRDPn3RLvAo98k0nU4XvSORImPyuANrfGETY0o6K+iviKjFKOV5X+lZfLkblcbRY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5LCdg4m; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-207115e3056so21722375ad.2;
        Fri, 11 Oct 2024 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728699673; x=1729304473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RQTG/zd6RilzriZO+uy7TCnbIOwmxbC6TCGxLYsp8Q=;
        b=b5LCdg4mhiG2rFNVUegETY8OeYR21QOKtuMk4W0exSowv4t/YTqfB+jLTTk5BWuOzA
         YJw0OizeuVoLrWVX1XFRVFIpfDHcRh4UxjgWW28jHvorjVzvUqfuNNOOJSixp2NCZYrO
         G65r0sB4IWvP2NHhIaoboFqmVAPwSArG/NRb3NmTR/Cwt4RXrDldYZYYwO+VsA4teoH3
         eiDZ6O9ILj8Ve3U1SV0RkfiBH/3W41VKjwnkInw3GrRwO9M3b+/dlnBgxronPsz8vHL5
         tHRtr72w9L+uk39DYQVl/V3gyd5VE79Y1wCazIMLA27GlHS7fkJh5L/I0/Te+e4SvCcZ
         LsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728699673; x=1729304473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RQTG/zd6RilzriZO+uy7TCnbIOwmxbC6TCGxLYsp8Q=;
        b=tkpGjUxfypWuvfAbHZwf1K2AoliJibEKlKjcgpPeu/bGCpBUOQsVZhJD2D+qDP+uzR
         f8ENWONzdQQIYtntW2nQiYUP1NtHBWtZbGv5DrHgd/8uOahYW5xiXHepH49T+tPdEjst
         RpVpquRQ1ph8qpX8pCu2Kj0nNgb6EXCxxGBtprcg//FpMDFXHKyyIM99nGR0cGj87sn7
         QtkTlEufZib3pmhsdjXrhVdMLMaaXUkBBdiYUfz7DQZLQIa5iEsRxUC2tpbWxWZCA4u1
         4TImp39s5CXUzqlbqGKUm66/8hFV4C9kNsYyAG8bDAWeJTRXxfeTg1yPxykygv6ZOeLb
         0kNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ey+UMAztpy9xaCJ5xJ1qObtzK0ArSodrW+y1HNZLGKz629qCFNao+k104XLvYjaXQuAMcD+B2RicNO+u@vger.kernel.org, AJvYcCWhHqghZ3rw9MifTPQXO8MHZgqeTxn/0kI+gr3XOXxqjjMOvc21mtEHDvMytqiRBWBtpwwnnfVVgVQ=@vger.kernel.org, AJvYcCXIGdYJO0fIwX8vTuylJFqP5ytN3Gv5cS4zcs4b9xSWhwsEVwUwDPS/9T7CdfRWe1KxuzwZkw+yI8Cbz3LqV+YzmUpTXQ==@vger.kernel.org, AJvYcCXnxzNNDezjqw0qOflw/c4OPFjgByeJN6sHzr4gJgNGg19eR6WKB/qNL5rc4MSvA4WdCv3iecRdYeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIHTq+BCMxCEfcmtEtBgwsUoMmG+06ga3bzWpzk0RWmt7nfhe
	wNTDJupzGQR68crDvlax/7vkJT2ilzMsR+BOkQ49E6Z+PBfjX+qIG1CUh0re
X-Google-Smtp-Source: AGHT+IFbA8cJKdZ90eXXEgZkPH/TjtxxJPEZLNNH2+HD4LKNuAv26Da2Q1cZVEVZRm5g0wdbk8e04w==
X-Received: by 2002:a17:902:c942:b0:20c:7485:892c with SMTP id d9443c01a7336-20ca16b5f83mr64243865ad.45.1728699672939;
        Fri, 11 Oct 2024 19:21:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad33c0sm29965785ad.35.2024.10.11.19.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 19:21:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 89AD8441B369; Sat, 12 Oct 2024 09:21:09 +0700 (WIB)
Date: Sat, 12 Oct 2024 09:21:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v2 00/13] Add support for AMD hardware feedback interface
Message-ID: <ZwndFfdpevdwxurj@archie.me>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <Zwh3Ky9Qoe6si1qC@archie.me>
 <6d7e5cc5-db07-423b-b39c-0de213fedaf5@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecUbuLzqmr6wswmv"
Content-Disposition: inline
In-Reply-To: <6d7e5cc5-db07-423b-b39c-0de213fedaf5@amd.com>


--ecUbuLzqmr6wswmv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 08:29:47PM -0500, Mario Limonciello wrote:
> On 10/10/2024 19:54, Bagas Sanjaya wrote:
> > On Thu, Oct 10, 2024 at 02:36:52PM -0500, Mario Limonciello wrote:
> > > The AMD Heterogeneous core design and Hardware Feedback Interface (HF=
I)
> > > provide behavioral classification and a dynamically updated ranking t=
able
> > > for the scheduler to use when choosing cores for tasks.
> > >=20
> > > Threads are classified during runtime into enumerated classes.
> > > Currently, the driver supports 3 classes (0 through 2). These classes
> > > represent thread performance/power characteristics that may benefit f=
rom
> > > special scheduling behaviors. The real-time thread classification is
> > > consumed by the operating system and is used to inform the scheduler =
of
> > > where the thread should be placed for optimal performance or energy e=
fficiency.
> > >=20
> > > The thread classification helps to select CPU from a ranking table th=
at describes
> > > an efficiency and performance ranking for each classification from tw=
o dimensions.
> > >=20
> > > The ranking data provided by the ranking table are numbers ranging fr=
om 0 to 255,
> > > where a higher performance value indicates higher performance capabil=
ity and a higher
> > > efficiency value indicates greater efficiency. All the CPU cores are =
ranked into
> > > different class IDs. Within each class ranking, the cores may have di=
fferent ranking
> > > values. Therefore, picking from each classification ID will later all=
ow the scheduler
> > > to select the best core while threads are classified into the specifi=
ed workload class.
> > >=20
> > > This series was originally submitted by Perry Yuan [1] but he is now =
doing a different
> > > role and he asked me to take over.
> >=20
> > Sorry but can you specify the base commit/tree of this series? I can't =
apply
> > it on top of current platform-drivers-x86.git, though.
> >=20
> > Confused...
> >=20
>=20
> Sorry about that.  As it crosses a few subsystems it will require some
> coordination to properly land once it has review comments.
>=20
> It's (currently) based off:
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=
=3Dlinux-next
>=20
> commit 57533bc760ae ("cpufreq/amd-pstate: Fix non kerneldoc comment")

Series successfully applied for review, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--ecUbuLzqmr6wswmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwndFQAKCRD2uYlJVVFO
o6P2AP0Uc7qUmd7kX74wkUxR44feaSmbqnUXz+/KVhUh9N0XDgEA/ceDdiODFul3
EUVcDMeokgEfMJELaJDqX1ehL5O+WQQ=
=gDEV
-----END PGP SIGNATURE-----

--ecUbuLzqmr6wswmv--

