Return-Path: <linux-pm+bounces-23556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD23A547F5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E408A16BAB0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90817204F85;
	Thu,  6 Mar 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlqhKDkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68605204F75;
	Thu,  6 Mar 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257479; cv=none; b=hF8EpsvzkmdHboNFF5QwbnjoXUuW1k0ybetRDoO4EiVVuFwaxZw/uaLUNla3e+VootKzprGQGqPWpneEgcxXGceyFZ3XtZvsANLeNrznWNkdM0K0G3w0nzCHeMZpo/KPCSKh3tbbIW3n10+cwuLdp/4zmtFdeXhhZv6UcBCMGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257479; c=relaxed/simple;
	bh=YNg+XgZ1AZ6kclyonPJqBkYdvbYBqR4ivmV7p6WuUlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCEUGDFYpgBTHemw45p23cJUBt3rCTAtIQlr1eJMU3HUDNCAQddS8q4TGJA90tguOknEzGUNlFvIV/R+jP8KzipuMVnVXWtt8Z+eaCpmpQYqabKbH0aKn1OO+NadlRL/beSNuXO8vKLX1nCj+WtcxkFmG6rZkYpglME0uaAi4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlqhKDkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94BFC4CEED;
	Thu,  6 Mar 2025 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741257478;
	bh=YNg+XgZ1AZ6kclyonPJqBkYdvbYBqR4ivmV7p6WuUlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YlqhKDkb7hvLHzOkt9B+0yyFkJi5QXGdSZOtv7A76rs16rcPAk/UCBLkzUxVEcL14
	 //gp0MwZRSS5liC75reC4ytfwXss59R2UwbT5BftrMLZKpoXNcH6k195Tc63Ztnuq3
	 y99Voq8B/U3hFw3iUwy8MzahPS5lCyNy9Zaypu0mLvm7rRgGbesHdTHKa7P01ALn2e
	 /IYXatGyKSg/mHU1C8CdJsUSIKE2+oVfTqfn5MrtUm9QRM7kqW895Y8DqwNV9VNVxr
	 Vy8C07s3rhWPHdzsynP8fUberGlizGjnLYAfczxCGdJ594CFJ27gbGzpocHnNFTwqO
	 6oRLMc8AOJyDQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2bcca6aae0bso333422fac.1;
        Thu, 06 Mar 2025 02:37:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDv5F1Usw8EPcKi0CTSY1K6HKSK/MC1WcmZ8dYTA/LmgOOn/n71TMkVgLbB9R9zY0WokA2yHKBKW8=@vger.kernel.org, AJvYcCWmS8rRWgMKRg0hUfAWqpfumI80CjfT7MYtR63IMDtASr9zj3vFABs0IEzHnQVwSrgHrpABargEDaMZ2wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnZsqjETlqXX+T1skrf27Raxt1MMoswzB5Wn39oHWUbNdkgM+
	9Ux4i6c/7otnh2/DCaakDwPK7Rz5CsS3nE9WGvGLWG2WhEf4sf71RT/PJPZK27HnhXolsrxo4fS
	BAFN7pZC+Q6IsNHMNefHxdh+DvcY=
X-Google-Smtp-Source: AGHT+IH3MUzd3IYGjGngSPT3jt28qznhOZYfbjOgCKDZoTXI1A16WoPmO0MWUmbYmN8AFuZ5cx0hgDeNPJplg4UOXto=
X-Received: by 2002:a05:6871:588:b0:29e:5522:8ee4 with SMTP id
 586e51a60fabf-2c21cd1f13emr3716612fac.25.1741257478205; Thu, 06 Mar 2025
 02:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5880743.DvuYhMxLoT@rjwysocki.net> <1929404.tdWV9SEqCh@rjwysocki.net>
 <92699eb4-8495-4ccd-a9dc-120b14271f9d@arm.com>
In-Reply-To: <92699eb4-8495-4ccd-a9dc-120b14271f9d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Mar 2025 11:37:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0id8ZF+8Q9vaBZfXXhwyiZzbX0NWz0t+4iYTWLo7-X5KA@mail.gmail.com>
X-Gm-Features: AQ5f1JpCJatDg4H_4G0HO3_y4n_KtbONzf6jVYjuP1cxb-3t01EiCBuwp0JKDMY
Message-ID: <CAJZ5v0id8ZF+8Q9vaBZfXXhwyiZzbX0NWz0t+4iYTWLo7-X5KA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PM: EM: Make three functions static
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:01=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 3/5/25 21:11, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Three functions in the Energy Model code, em_dev_update_perf_domain(),
> > em_table_alloc() and em_table_free(), have no users outside that code a=
nd
> > so make them static, remove their headers from the Energy Model header
> > file and remove a piece of documentation associated with them.
> >
> > This also helps to clean up RCU handling in the Energy Model code that
> > will be done subsequently.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This essentially follow the rules that all functions without users in t=
he
> > files where they are defined should be static (with all due respect to =
any
> > out-of-the-tree users of them).
> >
> > This change can be reversed when any new users of these functions appea=
r,
> > but it will have to take changes made by the subsequent patch into acco=
unt.
> >
>
> I see your point and it's valid.
>
> Although, please give me a few days and I will send some patches which
> add a client for this API. It will be a modification of the EM for
> CPUs while the GPU is producing heat to the SoC. Then IPA and EAS
> will get the updated total power values (doe to this this leakage power)
> in the EM.

OK, so I'll need to change the headers in the next patch and I'll drop this=
 one.

> As of now, I had some code downstream for research, that I share with
> partners in the Android world [1].
> I believe the user-space sysfs (like in that top patch) which allows
> such EM modification would not be accepted?

Well, if there's a good enough reason for its existence, then it can
be added I think.  It all depends on how this is expected to be used.

> Such approach might also help the Middle-ware in the OS to influence the
> kernel decisions, mainly on phones, where the app just occupies the
> screen and Middle-ware knows about it.

You need to be cautious about changing the EM too often though as that
would only lead to thrashing and nothing beneficial.

> [1]
> https://gitlab.arm.com/linux-arm/linux-power/-/commits/dynamic_energy_mod=
el/android14-v6.1/v6.1.75/?ref_type=3Dheads

