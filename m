Return-Path: <linux-pm+bounces-15514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADA99986F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 02:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B827A1F242D2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ECE2F34;
	Fri, 11 Oct 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhetEFl+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FE6FB0;
	Fri, 11 Oct 2024 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728608052; cv=none; b=rQ14eFYfY8cH20WIDqqcNjoEC3AQTznR/DtJJBdzIcsaIUxLbnyfiWafPzQlGLqFHiAGgDXckZEbwff19dry+bfT7q42Iri5nCTykAiGTJMn6p1OqbPPsNZYRcE+5NoLHi3NJFnD2CcKcTM9SSGK5btbilNPG1N8+pfToY2hAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728608052; c=relaxed/simple;
	bh=fZTLaLPTwlOLEkgP9DvEngrjzam0lQ+6VUFxbn0e0U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjGbscdZIWLxC6J7ZpjXX/42bD/lzWxyFmqqxo3w2UXn+RuKXJeEO5g4OMffe9i+r8vdyQS+rUrfniqoTrcVzW9NdWtWuJPTJO6hE1yBlZw5r1FOyfhSUd+6vUPUBaw/o7+ErL+EgeYL3pZkTTEKX5JJLJW7JNb0d5ntn5SedlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhetEFl+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c805a0753so13192055ad.0;
        Thu, 10 Oct 2024 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728608050; x=1729212850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZTLaLPTwlOLEkgP9DvEngrjzam0lQ+6VUFxbn0e0U4=;
        b=WhetEFl+IZ9lZ+CpSYr/Zez9qhGjknX0V48eNP0ZRgPKD/IduA4kQBeaOIk6YEl9ws
         XHifjgRVMSGiBBOWGAoNNxUp0GBbLJ2Prpw9iHliLUofiHkArK4qICFNRo1OjBJSPq1G
         p6ze5dJCSE+e0jpQFkrfwC1IIAd7wvplhDXvxLmwq3ReLxD/b6nspTt2ibLWwCqrXfrS
         lK548c2nE/4BxuxEJLZdBPSTmG4NsAbOx2KBXtSewqmu29svqroLlWm0ZzyOdzVClcuc
         t1fH6d26NqTEbnYRPkOnBtbejS96uQe6qRbNQma7Zgp9SE3yXOEuZde83xUV8ME9JwKZ
         f9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728608050; x=1729212850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZTLaLPTwlOLEkgP9DvEngrjzam0lQ+6VUFxbn0e0U4=;
        b=mFUrM/uOyTTH+qzLaA1fl+ljdx22zxXkE52kJOCEA4nQivWi2XtiUE/kScUNHMNVuV
         WQde/nddE9Tf+PKsmmy/n1i4m/GS25h5A53xGCEYdHWu4ZDBSolUt7v5rmyDOk8n8Flh
         PGmLb7pSiAmC5x85a0uJvZTrvJPc/DKmzfdR4EV0yErwTUNfqvY3jkWg5rHkvp08MFQt
         hi+v1TY9EfQBsim5jqIkL857zuAfIK7jQLJl6wyrF060Odqdyo7NoMIrAablSY3V9LmK
         BA+wIORPBeaXEiVHaNpM3x9swvKKRjCRjuf0KfPO0NH0f51E8i05MUdpJTBCJttMLqtv
         vhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/cGx18Wzz6qxDPs2iu2OG4K6frLO1tBYsv6bYZUPM9pT9Txst1yvMqx24d/DSaRHqz8Wfa1NoEOBIPnuo@vger.kernel.org, AJvYcCVkHMjbyUzW6FNelEEQgwj6YmULrX2KWVogKPvl2+SBShRpIMAfST1EkwFw2PK82biNaOhewRPJKDEVfa8xBc6eEz9GYw==@vger.kernel.org, AJvYcCVsn6cfxjiGfZAi4y5vk05XbJ5wGQqvYbwW307PNIydz9aldWHef8oIAF9/jqsTAcWtFlVM9Vk5KXA=@vger.kernel.org, AJvYcCXTQslNNxvZJb6MHYxImUhl40iyqiaNjFzzrgos9hsZWKPwLB8lmo16ytGaJVrwlG84EWxFDctmdSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxm9YCFYYPDmB7CfVFhnHtwyIpx7Pv2o7WAxhClt9ny9nHW/yF
	cu6D14c/EcQr98Ny4sdwGmwyS/V0/MBRZdwxmwJVBK7TOuMWFVSTTN2RPGqf
X-Google-Smtp-Source: AGHT+IFWCYQzv7FMKeBmT53rTezImf0FEnx3JQWfIvKpSSPUoT/iAnG1iWfaxTj5eMQvTqOGuljkmg==
X-Received: by 2002:a17:903:228d:b0:20c:a04f:927d with SMTP id d9443c01a7336-20ca167865cmr11729355ad.33.1728608049809;
        Thu, 10 Oct 2024 17:54:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33c83esm14936835ad.244.2024.10.10.17.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:54:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7C28C41F3BA9; Fri, 11 Oct 2024 07:54:03 +0700 (WIB)
Date: Fri, 11 Oct 2024 07:54:03 +0700
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
Message-ID: <Zwh3Ky9Qoe6si1qC@archie.me>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mcfns3z60a/iSw8G"
Content-Disposition: inline
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>


--Mcfns3z60a/iSw8G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 02:36:52PM -0500, Mario Limonciello wrote:
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
>=20
> Threads are classified during runtime into enumerated classes.
> Currently, the driver supports 3 classes (0 through 2). These classes
> represent thread performance/power characteristics that may benefit from
> special scheduling behaviors. The real-time thread classification is
> consumed by the operating system and is used to inform the scheduler of
> where the thread should be placed for optimal performance or energy effic=
iency.
>=20
> The thread classification helps to select CPU from a ranking table that d=
escribes
> an efficiency and performance ranking for each classification from two di=
mensions.
>=20
> The ranking data provided by the ranking table are numbers ranging from 0=
 to 255,
> where a higher performance value indicates higher performance capability =
and a higher
> efficiency value indicates greater efficiency. All the CPU cores are rank=
ed into
> different class IDs. Within each class ranking, the cores may have differ=
ent ranking
> values. Therefore, picking from each classification ID will later allow t=
he scheduler
> to select the best core while threads are classified into the specified w=
orkload class.
>=20
> This series was originally submitted by Perry Yuan [1] but he is now doin=
g a different
> role and he asked me to take over.

Sorry but can you specify the base commit/tree of this series? I can't apply
it on top of current platform-drivers-x86.git, though.

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--Mcfns3z60a/iSw8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwh3JAAKCRD2uYlJVVFO
o6oVAP45+qkTKnqnvQOrOKDE/V3Fp0cKL734Zzl5CRe0JGwhZQD/aoX9OuA1UGNV
XOVJPuwNIcCKTCIst1ChOe7h0nF3RAw=
=wzbp
-----END PGP SIGNATURE-----

--Mcfns3z60a/iSw8G--

