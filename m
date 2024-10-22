Return-Path: <linux-pm+bounces-16172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5E9A9510
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 02:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372581F23AAF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066A4A07;
	Tue, 22 Oct 2024 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B86wTg8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344E360;
	Tue, 22 Oct 2024 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557932; cv=none; b=iiB035pKt+6Vc6EyGYFoO+3fCFV1cMEdRT3HgVtJLJVxYfwWPD35UQOpVDqbB/cQn6mQMWmb9E2DeIWLpzkPoaVR+q+5Wa3eTe5wb/1zdfs1AmnL5yDEr2juHqvy/gw8VWq2ZvWWdfI/qfzomETlFVZhXcyjjELB9iU/yDNl/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557932; c=relaxed/simple;
	bh=rkO4HQM7SizrGfprQ3ljcA2cJGSWdKVoqleXtchmey4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp2E40HyMrppgwQEO485yulKHVyQo5bVf9sjk2BteY68cF7O/KmqCxCvxu/HlXPltcgArUT3/cx7L7DApuH8KIGdKl9cEWBx+qb4+NCi4Qoj5OdK7WpXvDQV50EyvPTNG8lzBAR1W6A+RPGjJi9yY9MS2T//DmxDRFVElfLScCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B86wTg8t; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4162874b3a.1;
        Mon, 21 Oct 2024 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729557931; x=1730162731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkO4HQM7SizrGfprQ3ljcA2cJGSWdKVoqleXtchmey4=;
        b=B86wTg8ty3WBYLGSfHx4LHwBIUlP/Czjl004eHXuItPJ1ObpMAk9voWFnTUTrIw0bR
         wFPK8FGtKoN72vQKjTOPYG6yftL8U1+0idZoZnI6CDItH2OE04pCYFJ6YlumRLZjdotX
         CLZ56ZUVZqQ4J6Stlr71k4d4ol8nW6HLEtVOHNT99xcJLDDlnUNEbR9jCki5WP5F7Ya2
         y4Mebg9FHV3t2Gb5k1JGCW1OLZBH9z8HqNFi8Q6r3OzjypornliezXD8TS8Ui8V5FGoy
         483mQFQ+qaEsYv+QoGGzEfC3e/Mhn8io4fzxy8PEa1qwAtAg7XyCeMRqlF/Lz2stnPDU
         oshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557931; x=1730162731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkO4HQM7SizrGfprQ3ljcA2cJGSWdKVoqleXtchmey4=;
        b=L1n8xy12xhkHyBJt8TP0KSNQaUVNHHHZ+9zZAOatzR0WY8SYtoQMSZ4yVDrVMnQqZW
         P57O+DRxk+Yf+qgdn8uhn8mfJgDPkn1K3t+icEbJn+NGFL5HN53O/HTDVetPAyMgwFda
         sHoYEuttBfD8pUYISt/9Ir7O9J7vNfRKYLuKiQSaHX1zO6GU6pWNfuJgNC6mvoNPRtCG
         jwlEBHUeSgZoox1RFaTC3v0KAjW3VazvbY6z1fxjF7MNI49mPtAiSbmd/GxZLwFkvm99
         fCcirvjdrUIpf9ZFPQxsb5zc2RZHTcaFUvj0jUVvay3mfCEEuo6KxEgpUbLIKhi+zMCR
         RsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH1RT4jjWiQUQogW31Zu+USfcKJHtstOyxzkSx1F42vM4nV9OIgFNAPAV9M0NyVQTw3Jl/q38FOtFEe9/EMoSUBzDtIA==@vger.kernel.org, AJvYcCWNXKUsGwJRREjgtAFdv9cCYBcUEzIFfEZqf7VyEy3d6wck4FoberjtQIYqgLpX+twt+VuS5ZIHMtM=@vger.kernel.org, AJvYcCXTOBRDpbxIRAfJDC8+JMCBoCxQuJ7m4zyLbGkIiO/eGvK490AG/xnEYIViEXg2K3fyfodSy/LIOqM=@vger.kernel.org, AJvYcCXsrPgevuPNqDhhNdFlGticfo4AEr0dHTmQBOuMalyxPd3x/Vc3gvbQE5o63Eaaj10FBQ7GmgDKDmLyfFTQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Gn9ZbrFQhY5LALGxitCgcF3ylRJW9nulhPI8IRaZh7YvsSYL
	HBU2K68grsSqZx0JklpAXbLURZIfuZ8B9uR4RpocuWaurLZ38C2T
X-Google-Smtp-Source: AGHT+IEaN4XZFPrN3nD/QTLshZZNGUJSk1MAp7HuzF4HK7yRgsWTvFrVsHwAp9zDfAAIOEuKojXEuQ==
X-Received: by 2002:aa7:8e06:0:b0:71e:674b:474 with SMTP id d2e1a72fcca58-71edc15f84fmr2018208b3a.8.1729557930342;
        Mon, 21 Oct 2024 17:45:30 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d767esm3515322b3a.114.2024.10.21.17.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:45:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 810F8425A747; Tue, 22 Oct 2024 07:45:26 +0700 (WIB)
Date: Tue, 22 Oct 2024 07:45:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 01/13] Documentation: x86: Add AMD Hardware Feedback
 Interface documentation
Message-ID: <Zxb1psmK05_xSXYH@archie.me>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EiFZ20l18MgsAYaW"
Content-Disposition: inline
In-Reply-To: <20241021180252.3531-2-mario.limonciello@amd.com>


--EiFZ20l18MgsAYaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 01:02:40PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
>=20
> Introduce a new documentation file, `amd_hfi.rst`, which delves into the
> implementation details of the AMD Hardware Feedback Interface and its
> associated driver, `amd_hfi`. This documentation describes how the
> driver provides hint to the OS scheduling which depends on the capability
> of core performance and efficiency ranking data.
>=20
> This documentation describes
> * The design of the driver
> * How the driver provides hints to the OS scheduling
> * How the driver interfaces with the kernel for efficiency ranking data.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--EiFZ20l18MgsAYaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxb1oQAKCRD2uYlJVVFO
o2W5AP9eArac6T9AE3et/1yG+qIYjyEo74c7IJg5uJzRKTUa6QEAiMnYPsaLTJ1K
92Vz9xCv2BZme+lqTyZrz1gMUbJXwgM=
=qVoF
-----END PGP SIGNATURE-----

--EiFZ20l18MgsAYaW--

