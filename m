Return-Path: <linux-pm+bounces-11833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E3945E0E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 14:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84598280FF4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF61E3CBF;
	Fri,  2 Aug 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOPuNjPv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76071E3CA7;
	Fri,  2 Aug 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602821; cv=none; b=LJ9/Fqg+GW/2zXAZfAmHrYoT2OpB9W+HajPTEsSr64CJ+kmdApNksV8A8ZqzhNjSXdHg4ZYRwL8/r7q957T/i+RdZ8Kg03qOgyKMpAeWnJH033PhCnSf1xetI+5lsDMOtEYMeni6cuz4Slzw/in9a/pDW/toD3TP6Pm+6Q7PShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602821; c=relaxed/simple;
	bh=1QgdOFHc5UJ7JLTaVxoYYVwQrMYFGF8fQ1SbQIxZkhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rddlQvwAA9Fs2zGVd3Sv5xVE1pVWkAiG9FkFQwnnP8/go8cnr9okzOMp7lcjIZorok1hVyzBS+YjePWcLg6AP95HVhVda2rPNCjOm07sHsiqf1si4NHr/hVUpQ7FTq3bya4RMMpJNy4OZ/cySu6Gi0SDqq1HbynEwKZ/BpKQx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOPuNjPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B977C4AF0E;
	Fri,  2 Aug 2024 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722602820;
	bh=1QgdOFHc5UJ7JLTaVxoYYVwQrMYFGF8fQ1SbQIxZkhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOPuNjPvTZZBsjB3tap/xqosF5SQqQYpnAfbYzS12d+zdYkiM8SP/fcVGUBeqc3HC
	 lMinvM1uFnU4HZra2cN5wfQlihPihtSBfTfDViH3rmj7nQhlY6S7WA3QZqoWhGTK1d
	 tq+btNcsaMnEszrxEHUYcedP9A5FKqoLRU7J2bkS5FJk38Op8v/vD+BPaqBs66udDs
	 HnTHjIQCM/iUXUNA3U8wNWM49K0nW5Mt5AnXisVBfznEoiNeCqudJfa49jbHwyrOz/
	 h2kMC8TAuykWtLdIkBV6vjeVmkM31QuC9wJiPOO8ftEYrwSXC7XVAeZ5Iejvb3RsSM
	 RDGqnl3DweuEw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db199ec527so671535b6e.0;
        Fri, 02 Aug 2024 05:47:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+c0YUmfqvNXhkeg9tDXA94RlU0p0ZiVmXIN1KfnjRVh3pT7kW+0vn5xyrQ0Gc5KtRSqY6/7lmzdGnlzZEwfOD212GXAYacfIlIim2WTBeUpJNX3O/HxLFUns069Q/1gvd8kgbJTVtMR2/EUXMHWnsceFY2RHZ88kz2gSX1h+s9ff29cSGEp8=
X-Gm-Message-State: AOJu0YxHm0Idt/4K9CXuwKYqpdBheVFtlVFa58PG9ycM+uXpx+BBCVpf
	8p8F6OIpPJxgqq104CRjtEzJrWCcN0OOcx/gsm6mrXDBgmie8qCBOD16jijwdF+MdToK14ITJEH
	ywjs7GImJZCxxMAIAJYkMZPzFgvs=
X-Google-Smtp-Source: AGHT+IFEVv8eZDY5b3H89JJWLVBnt5m9XtSne/AH0CAwtm0pD7to6WgcNrLrHJUClqgyEggleITIiM5TGHtAKB4tRuk=
X-Received: by 2002:a05:6870:56ab:b0:260:23bb:1087 with SMTP id
 586e51a60fabf-26891732bc5mr2122828fac.0.1722602819834; Fri, 02 Aug 2024
 05:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>
 <20240724043941.5wpa5di7ta4fjyl5@vireshk-i7>
In-Reply-To: <20240724043941.5wpa5di7ta4fjyl5@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 14:46:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYDDQkPpnHsuJ_7du7Efg4zuLuhj2RHobJ6UiciuhphQ@mail.gmail.com>
Message-ID: <CAJZ5v0iYDDQkPpnHsuJ_7du7Efg4zuLuhj2RHobJ6UiciuhphQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
To: Viresh Kumar <viresh.kumar@linaro.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 6:39=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 22-07-24, 10:14, Jeff Johnson wrote:
> > With ARCH=3Dpowerpc, make allmodconfig && make W=3D1 C=3D1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-c=
be-cpufreq.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/power=
nv-cpufreq.o
> >
> > Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> > files which have a MODULE_LICENSE().
> >
> > This includes three additional files which, although they did not
> > produce a warning with the powerpc allmodconfig configuration, may
> > cause this warning with specific options enabled in the kernel
> > configuration.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> > Changes in v2:
> > - Per Michael Ellerman updated maple-cpufreq.c and powernv-cpufreq.c
> >   descriptions
> > - Did not carry forward Viresh Kumar's Acked-by due to this change
> > - Link to v1: https://lore.kernel.org/r/20240614-md-powerpc-drivers-cpu=
freq-v1-1-de4034d87fd2@quicinc.com
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.12 material, thanks!

