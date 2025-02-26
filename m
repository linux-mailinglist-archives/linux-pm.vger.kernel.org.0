Return-Path: <linux-pm+bounces-23010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FAAA466B8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 17:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9B01891768
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582D21D5A1;
	Wed, 26 Feb 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjAWEtEI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874921D599
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586832; cv=none; b=aJanrCs9urJQsjG9Zs3fHW5XMhEssqVLmLrEGjX9PgW60Pq6bvvqsgtpIC85PS9BPTWZCJ8p1WoVlbplgaCWst7t06ZoMX+yyzuRClFFPuAoHi+tZ5s+8tShB91WQPmpej202jqXDIgEiij27PYbmh7Eby0+rGsCLNuua31UfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586832; c=relaxed/simple;
	bh=2nqyqqx0MAd0AgGyAucIaH6EREOxVYygyrAHK6YBIr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvNJdkshRlNfdobuYQJYuVF47XOnoiUCnVj+zps8E0ywZzrxsyi3kolDeENmrvoy8EGW1yJM0cRCS3vIZ3PuGPDBySzrttuKoY+YKFwmtjSg56fyAIcCSMWyuByBlCzIRRJ9UVAUZnsEhqbDFI+H8orh6E2Xa1vlLXzpHgBTdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjAWEtEI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so168775e9.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740586829; x=1741191629; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2nqyqqx0MAd0AgGyAucIaH6EREOxVYygyrAHK6YBIr0=;
        b=cjAWEtEIQJuRE+iO7QUUI0CmBcQ0wqiHs6+i10oD8iO72pb+fWE2t39588F8JZswbN
         on7rSesWbFZORTfzrbkpr3UfLJJE2GjgB9maoRu2QDFnTVAAxAofdbTLuVXtaiv8rHmT
         b6I4P2LzCDJGlwlUSgn5wywJBWpXFJ/iQ51BnSVFOa49eGkIhPLDpdpG+f7n1WsUJm0T
         h6rvst4XE46ao1yzxxsZhGte4VdZfsRMeWiR8iw1to9ybOn2rVAFF75CsyZJ5OsDQt3H
         AZD7wYO2gJAcy6mVYp++MNXkYwAyUkxcC0sQLR/3s9DX2VQD69cVi9VO7RX/Js1vqsOJ
         ggfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586829; x=1741191629;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nqyqqx0MAd0AgGyAucIaH6EREOxVYygyrAHK6YBIr0=;
        b=LoN/gguA/l8HBYjiV6Ho3Rj/blATm/CBL6P229JCIejOXDOZeorC5OT7gV2t444Q5k
         vCGSCh/jZ1O4+N0aK79vCKl9r9KAy9IxSJQKBDnjWJL9yG6jmckBnVOpNFJISMkLA7yr
         pcSPdxDNsJUdB0Tt/OHo09tGcyc1ySKv7EOzJY9ejngC9eowOVaf9DsQ1XFMs9TOIzvm
         d6FYeCnzBf6mHjMDJwjGQU1+D6E0CZxb0cvZiggRnBjPyKd7cWR6qVhKOme1L1IxJJfk
         gAlI7K9FDSME+P6iiAdvo9O028w8V2tFNWTKEEVof23NhddQmaHxDKUhRDZa1jRRsZri
         3U3g==
X-Forwarded-Encrypted: i=1; AJvYcCXy9+ZJL8vTGlY90bQVa0vAlouT+sWV6cMSN4GKHmK2IyVjh+8zYEkHcD2mwqvZwO161zl6Enx8+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyttNOX1FDV0jJMDRp3mSG8jwBhcZMDAAZMcl3mP3kOj1hfeTqS
	7urBBLzC/JV43ehQ85pj/azRlVONYCgjOf1myhkWpbCHzVPMPgIHum1Ow2pD/YQ=
X-Gm-Gg: ASbGncsRDJpUKb1prQx9XKrL8EsYDb9pV8NuQhTEBcnE1obNtwXktraJ42PdSrDBxDq
	Nd5CHC1fUJQ291WG3yN0yGLvad31YER/v/+nBEMpoV28aRsQg22czg7GkNIniT88R4oMWYD8bST
	zv3GL9R5lavGSCG2gR81iFRum6KRFA+4xOWTIgUNYr65+6LR3XdYXAdHjFytrVykXgXs0exo2sA
	nTSVaR7wd5YhgJDOdl1CZ6M+mJpQ+1/azqos1y68VeP1Q8GSmufUTZKW6KYuI7omO3gURd5jVIt
	IWhGWikJdcwAmmFS9sWv0b1mPrEJkg==
X-Google-Smtp-Source: AGHT+IE0+iJG+B7XOAyijX1v1ZMsbEkcNx8hqjN7umdi3u8zQQME8o/j8N4tXvKdeHCV0Qi8VsGsyA==
X-Received: by 2002:a05:6000:400f:b0:38d:dc57:855d with SMTP id ffacd0b85a97d-390d4f8d921mr3807666f8f.35.1740586829046;
        Wed, 26 Feb 2025 08:20:29 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390dd12c30asm1923141f8f.71.2025.02.26.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:20:28 -0800 (PST)
Message-ID: <9c013c053b8677ee6bb2a37bc48e90a25fa16d7e.camel@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Will McVicker <willmcvicker@google.com>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Date: Wed, 26 Feb 2025 16:20:27 +0000
In-Reply-To: <ba98106d00038a9b2a2bfb27dd49a5915cb93b81.camel@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
		 <20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org>
		 <174058375994.2463209.9948592153423144239.robh@kernel.org>
	 <ba98106d00038a9b2a2bfb27dd49a5915cb93b81.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-26 at 15:42 +0000, Andr=C3=A9 Draszik wrote:
> On Wed, 2025-02-26 at 09:29 -0600, Rob Herring (Arm) wrote:
> >=20
> > On Wed, 26 Feb 2025 14:08:20 +0000, Andr=C3=A9 Draszik wrote:
> > > Add support for specifying different register/mask/value combinations
> > > for different types of reset.
> > >=20
> > > In particular, update the binding to allow platforms to specify the
> > > following reset modes: soft, warm, cold, hard.
> > >=20
> > > Linux can perform different types of reset using its reboot=3D kernel
> > > command line argument, and some platforms also wish to reset
> > > differently based on whether or not e.g. contents of RAM should be
> > > retained across the reboot.
> > >=20
> > > The new properties match the existing properties, just prefixed with
> > > one of the reset modes mentioned above.
> > >=20
> > > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > > ---
> > > =C2=A0.../bindings/power/reset/syscon-reboot.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 74 ++++++++++++++++++++++
> > > =C2=A01 file changed, 74 insertions(+)
> > >=20
> >=20
> > My bot found errors running 'make dt_binding_check' on your patch:
>=20
> oops, sorry - the script we usually run didn't cover this binding,

BTW, we did that, because it's easy to miss warnings due to
the amount of bindings and text scrolling past. Ideally make
would exit with !=3D 0 in case of binding errors.

I can see in commit 3e95dfb315de ("dt-bindings: Don't error
out on yamllint and dt-doc-validate errors"), warnings are
never treated as errors.

Is that still relevant, can that commit be revert? Don't we
want the build to fail loudly on binding errors, so that people
don't even submit erroneous bindings in the first place?

Cheers,
Andre'


