Return-Path: <linux-pm+bounces-29855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE67AEE803
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E081417F92F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119B1F583A;
	Mon, 30 Jun 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsrsb9Cd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8017BD3;
	Mon, 30 Jun 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314628; cv=none; b=YaqsVrym3jRfJmBu7zSL2ztDMlOvMucCa6GOqnP+NEzNSJOVw5vQYi9zSSm06pECCH+i5g+CvPWZ4skZ5GekIyDgnFj/uNs1jZmKeWD3jJSVB7dHRnND04SwTQlwiBaD5p4V1O9p+dZn+dc8qs47iMZRVUoeIxiz9tETLk4muH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314628; c=relaxed/simple;
	bh=aAsNAuHsjR344Fd3da5SxFMjfR93EvLv2BO/bbHMQsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RISemCdrGDl6ICqmzYcNud4Z8jpOMihkDI+lynAKmYlcLkVm1y/2lLBqA0zrbTabfAQ/sKjNaBAxWT2xLBr0IxH6XSDLXqYvoHM7b4pwgL2CUtQUf5qAFXOHYMtJbGU40MYikE2ykSlZYprQLAV7eKqPvtwdOMfI4vwIX3cXHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsrsb9Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5698EC4CEF1;
	Mon, 30 Jun 2025 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751314627;
	bh=aAsNAuHsjR344Fd3da5SxFMjfR93EvLv2BO/bbHMQsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qsrsb9CdnjS8aBsZzTogFwDJtZ/kN8nr4JXWtAnCxhBlivoALMCusBbhwcHnxytvN
	 08Sb9gzcdLgnHVtto7HNJMqvKYL2Rp7jVlo2o35G7+6n85u2ojBZcQidijqscwDjjh
	 kVdXZ/PFTKV1UphJBxO2bHUGw6+bt6dZDHc2MM3+o/OCVwySmYmW1LJhD8QQUM18yN
	 AuMrQoShf+XyxkRRH76Wo9oHb8vVS9RcIBdMitE3pWt++vQ9Bq3O7rPOGLl+73VSs9
	 AcZAecKi6+gTtr+qbGPfsfa23OvUPcSHcI+oWlh1Uj3zOnmV2YtQS0dmvvMBtPxi3+
	 Fi/WzVREycZqw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-611e455116aso661014eaf.1;
        Mon, 30 Jun 2025 13:17:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVNVSi+PkwaurFX1J5KJ6w+K7d449z1N9ux8zJ7dyVlg6UJSdlxK0RJP/TnHvQOFk8Z6lMwPhMrvduLDg=@vger.kernel.org, AJvYcCViCpCxzZ71r9EI1ZBDqM3TGq7BQzrTJsBqS9nce4vYtrUEVSX+Piq6YBhTPxmJ8fUhFLqP+19W/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94AJcV+Kld9+vvAfj7hx+p/62Kr0VytX447uPFmU+uWlqStfU
	GK7pvB/f+zLpi+r63720wtZvGaU3v+SIHEmuGSCfd/7noydDB5SD1OlffV7Z/1v80NO+pSmDuha
	jRH6cheTCGHyBOh30XQm4UGVNXjcLXg0=
X-Google-Smtp-Source: AGHT+IG6nI6hSzCJRBR/esxMVU3rTbhv42O5XI1PlfMUn3jv9xx39C8ZdVdHIRMHR4ZwSlkCdTZ3jpMB509JK8Vb5WU=
X-Received: by 2002:a4a:edcd:0:b0:609:dd17:795 with SMTP id
 006d021491bc7-611b90cb057mr10165680eaf.6.1751314626626; Mon, 30 Jun 2025
 13:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618231632.113471-1-sivany32@gmail.com> <CAJZ5v0jXPten8QwruK_Dqzvc0izLCfecMPBWMMoP8cnG4mDY0Q@mail.gmail.com>
 <CAFcvxdMozCv1mJFKemQKhOnZPLpfkWs3d97bHUijRdw7MdFO1w@mail.gmail.com>
In-Reply-To: <CAFcvxdMozCv1mJFKemQKhOnZPLpfkWs3d97bHUijRdw7MdFO1w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 22:16:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPfkztEFR5T239VOQErUkxBT35piDZgGi4ZtYBSOO_LQ@mail.gmail.com>
X-Gm-Features: Ac12FXz29VxFYMfbWcEghZNOYzrtRv5tZ1n7U4srR6S3UCaPY8__OVL_KbY2SlI
Message-ID: <CAJZ5v0gPfkztEFR5T239VOQErUkxBT35piDZgGi4ZtYBSOO_LQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: dtpm_cpu: Fix NULL pointer dereference race
 during CPU offlining
To: Elazar Leibovich <elazarl@atero.ai>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sivan Zohar-Kotzer <sivany32@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, elazarl@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 12:13=E2=80=AFAM Elazar Leibovich <elazarl@atero.ai=
> wrote:
>
> On Fri, Jun 27, 2025 at 11:07=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > > * DTPM power calculations are triggered (e.g., via sysfs reads) while=
 CPU is online
> > > * The CPU goes offline during the calculation, before em_cpu_get() is=
 called
> > > * em_cpu_get() now returns NULL since the energy model was unregister=
ed
> >
> > But energy models for CPUs are never unregistered.
> >
>
> Can't the following happen (extremely rare, but still):
>
> CPU gets set to impossible during shutdown sequence, e.g.
>
> // arch/alpha/kernel/process.c
> common_shutdown_1(void *generic_ptr)
> ...
>         set_cpu_possible(boot_cpuid, false);
>
> Just before `get_cpu_device` is called by `em_cpu_get`.
> Then `get_cpu_device` returns NULL for impossible CPU, causing
> `em_cpu_get` to return NULL.
>
> It's not a common scenario, but it seems NULL checking doesn't cost much,
> and can assure us no rare case is crashing the system.

It can happen, but in that case (1) the patch changelog is misleading
and (2) the message printed by the new code is not particularly
useful.

Thanks!

