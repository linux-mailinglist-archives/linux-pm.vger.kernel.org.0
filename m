Return-Path: <linux-pm+bounces-15565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4DA99B084
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 05:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2579328488D
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 03:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D884FAD;
	Sat, 12 Oct 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csDHdqpd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E428A41;
	Sat, 12 Oct 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705202; cv=none; b=NXFaCizuvWsRDYVvpxB79vLJg3mrtlYM7ZACqSjm5yflBlHeSsFOdo0zRmjjGBFFMItgQ/AumlMMJIdf6kqA67s9l1bTNRiRZvxnuZ167vbvLIaL2jLDbU7Oya/8Dy4XEcXb6ntBbOLGyyl+dn9iuikouuU/HFIa7xkzFTXh7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705202; c=relaxed/simple;
	bh=AW5DZ/uxFTAsik+BDblAe2m6pQ/3cvs37Qf6PUBtKcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mspvjr6/mT0olBN5bxLZACJSn2a2N5TWXm6sKBqcJD9Ndgmdj1nfeCqz8GEmLhqPGZOzM42M34T7uVj1mBtYL2Df0UnJq9njcKRmZApCKER+DKb/8qL0n5UULsSLDItMu+fmrNFjPrf4BYzLQAfFC467AtnQsM2YIlo1X3iHzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csDHdqpd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso1809917a91.0;
        Fri, 11 Oct 2024 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728705198; x=1729309998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFlRn4ys9Cl5MtaYHqxLNUhoFIlLy79+wr8gd8xYoFI=;
        b=csDHdqpdCr36TA/eZ7vYhOxSKHDwsj5sWeuI4GgXBelufL+bkhpbH0iTYYPgKb5G0N
         eZk0pFdWS+DbE1ES/LFqQgchfqC1/oq06hRu/ooSwhhgUqV0AKkLOp+rrS/Y0hnUwp9a
         349z8ndd5Xx4JD22i/VWJKHn+5eg5LAgvEyE1/FSrIx4TGKzQ2ACaWDJd6IB/i3Xxab/
         VPVMLKK4ZzvyZodR2jjgET9sVpnovudlgR0gXjzsUpwdF1kLSsskv67afCDJHjRM+m7B
         hminNrvQEjkj+RGeByHeJR6fA5JB3GCQqcr8umGEsf2USY6xOW6Kb+mdYnUxrglq+gXD
         ldbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728705198; x=1729309998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFlRn4ys9Cl5MtaYHqxLNUhoFIlLy79+wr8gd8xYoFI=;
        b=KDiKOi4H3XKQdrByIsqELzLdqnWLWdHfLAr3V6U2uZoPbzEHRzbB0hW3sjhNm7AdOK
         jv04b5ZQiddZpouE5DzgRI1QsA9p8ygp+Ts+4QoIjCG6HHcA7+jAEB/6EU6n49VVuo9n
         qycJt3SlPyAF937qHQ9NQ3Znp+h3YpdvVKg3uy5XeqpiBWWTv7aHwHa14HS56tkRQiNp
         LW3ykiwwrnPKNTKYJnoHlqbPi0xP2qZoXwH6fLOCDu5Iz5gFR63I/FCB1joV9nATLpU+
         HWF+xCAkUgTStpOHQWt54C6SlsILqldjXlizmnuB0lou6ZvNtlvwIqUxx3N9PDL94Yzr
         zf+w==
X-Forwarded-Encrypted: i=1; AJvYcCVgz5LuTj7M7qEMP3eYMOkWhrMSqarjRKHoSqFEAoYTSkJ4vKCUF/dGEVi/gPuVmF1YxMJyEASgwpc=@vger.kernel.org, AJvYcCVlc7V9K4RGEFj7ktQV35d9nr5adMNJuNYL3YDTgbd1P3CebdvordJg7EtmsxGRCWE7YNokT6L+SqMWoA8d@vger.kernel.org, AJvYcCVoh4HYCz9G8SDyqzyg424wSWiieQkJ54dK1jPJGcwflCI1LfRbFsZIkf+SYWs6JSsuKqTAI7BKHJqsYqFcFlmGSdpW7w==@vger.kernel.org, AJvYcCWkmZ4S45vQcClY6pPM026jFvbJV2jj5fGER19hv4IZAJ3hEVOcbI8iFlU06XruyjtyE9c7ybQZ8mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMO7k3qbGSxWNwlJEHTmeWg8x0B+TRwp1vLYWRqmaz89U6HIxA
	2q1hpSCjUUKsmQRc5H0GrB9a1+crwDoRTmiMlrT8ngY3SlFILamZKmOpjOmY
X-Google-Smtp-Source: AGHT+IFBRR4v4JycUj40IR+Djj+Y51UpeKooSlN57VO1csE3pWQErWmVuCZBFo15g5B2LK1eZcDxUg==
X-Received: by 2002:a17:90a:6845:b0:2e2:eba1:a1a1 with SMTP id 98e67ed59e1d1-2e2f0d9d935mr6606210a91.36.1728705197767;
        Fri, 11 Oct 2024 20:53:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3060ba4besm1739046a91.19.2024.10.11.20.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 20:53:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D5D7345E17CA; Sat, 12 Oct 2024 10:53:13 +0700 (WIB)
Date: Sat, 12 Oct 2024 10:53:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v2 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
Message-ID: <ZwnyqRF-j7Epd_kA@archie.me>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ScYld6gsAtJ/5B+U"
Content-Disposition: inline
In-Reply-To: <20241010193705.10362-2-mario.limonciello@amd.com>


--ScYld6gsAtJ/5B+U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 02:36:53PM -0500, Mario Limonciello wrote:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> +
> +:Author: Perry Yuan <perry.yuan@amd.com>

Don't forget to correct the copyright reST field:

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/am=
d-hfi.rst
index 5ada5c5b79f4b5..82811be984799d 100644
--- a/Documentation/arch/x86/amd-hfi.rst
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -4,7 +4,7 @@
 Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-:Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+:Copyright: 2024 Advanced Micro Devices, Inc. All Rights Reserved.
=20
 :Author: Perry Yuan <perry.yuan@amd.com>
=20

> +
> +Overview
> +--------
> +
> +AMD Heterogeneous Core implementations are comprised of more than one
> +architectural class and CPUs are comprised of cores of various efficiency
> +and power capabilities. Power management strategies must be designed to =
accommodate
> +the complexities introduced by incorporating different core types.
> +Heterogeneous systems can also extend to more than two architectural cla=
sses as well.
> +The purpose of the scheduling feedback mechanism is to provide informati=
on to
> +the operating system scheduler in real time such that the scheduler can =
direct
> +threads to the optimal core.
> +
> +``Classic cores`` are generally more performant and ``Dense cores`` are =
generally more
> +efficient.
> +The goal of AMD's heterogeneous architecture is to attain power benefit =
by sending
> +background thread to the dense cores while sending high priority threads=
 to the classic
> +cores. From a performance perspective, sending background threads to den=
se cores can free
> +up power headroom and allow the classic cores to optimally service deman=
ding threads.
> +Furthermore, the area optimized nature of the dense cores allows for an =
increasing
> +number of physical cores. This improved core density will have positive =
multithreaded
> +performance impact.
> +
> <snipped>...
> +
> +The mechanism used to trigger a table update like below events:
> +    * Thermal Stress Events
> +    * Silent Compute
> +    * Extreme Low Battery Scenarios

What about below wording?

---- >8 ----
diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/am=
d-hfi.rst
index 351641ce28213c..5ada5c5b79f4b5 100644
--- a/Documentation/arch/x86/amd-hfi.rst
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -12,16 +12,15 @@ Overview
 --------
=20
 AMD Heterogeneous Core implementations are comprised of more than one
-architectural class and CPUs are comprised of cores of various efficiency
-and power capabilities. Power management strategies must be designed to ac=
commodate
-the complexities introduced by incorporating different core types.
-Heterogeneous systems can also extend to more than two architectural class=
es as well.
-The purpose of the scheduling feedback mechanism is to provide information=
 to
-the operating system scheduler in real time such that the scheduler can di=
rect
-threads to the optimal core.
+architectural class and CPUs are comprised of cores of various efficiency =
and
+power capabilities: performance-oriented *classic cores* and power-efficie=
nt
+*dense cores*. As such, power management strategies must be designed to
+accommodate the complexities introduced by incorporating different core ty=
pes.
+Heterogeneous systems can also extend to more than two architectural class=
es as
+well. The purpose of the scheduling feedback mechanism is to provide
+information to the operating system scheduler in real time such that the
+scheduler can direct threads to the optimal core.
=20
-``Classic cores`` are generally more performant and ``Dense cores`` are ge=
nerally more
-efficient.
 The goal of AMD's heterogeneous architecture is to attain power benefit by=
 sending
 background thread to the dense cores while sending high priority threads t=
o the classic
 cores. From a performance perspective, sending background threads to dense=
 cores can free
@@ -78,7 +77,8 @@ Power Management FW is responsible for detecting events t=
hat would require
 a reordering of the performance and efficiency ranking. Table updates would
 happen relatively infrequently and occur on the time scale of seconds or m=
ore.
=20
-The mechanism used to trigger a table update like below events:
+The following events trigger a table update:
+
     * Thermal Stress Events
     * Silent Compute
     * Extreme Low Battery Scenarios

> diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/in=
dex.rst
> index 8ac64d7de4dc..7f47229f3104 100644
> --- a/Documentation/arch/x86/index.rst
> +++ b/Documentation/arch/x86/index.rst
> @@ -43,3 +43,4 @@ x86-specific Documentation
>     features
>     elf_auxvec
>     xstate
> +   amd_hfi

Sphinx reports mismatched toctree entry name:

Documentation/arch/x86/index.rst:7: WARNING: toctree contains reference to =
nonexisting document 'arch/x86/amd_hfi'

I have to fix it up:

---- >8 ----
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/inde=
x.rst
index 7f47229f3104e1..56f2923f52597c 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,4 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
-   amd_hfi
+   amd-hfi

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ScYld6gsAtJ/5B+U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwnypAAKCRD2uYlJVVFO
o6+GAQDrEa+eXvEryM52GrfrRsgFJemg9iRNdruOpF5csqRb7QD/dIlwwqoqSq3N
aEclgc9riuX7haD/M3JqTJcey6S7qQ0=
=LzcE
-----END PGP SIGNATURE-----

--ScYld6gsAtJ/5B+U--

