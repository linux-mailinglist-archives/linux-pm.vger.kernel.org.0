Return-Path: <linux-pm+bounces-18059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37F9D8651
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74ED28BF32
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F61AC88B;
	Mon, 25 Nov 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp3fKMBv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790F1AC458;
	Mon, 25 Nov 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541088; cv=none; b=D8//hBZtPaM3krS1yLW5eUV2ltWzx/m5w500D67sEnsW08iF89bCUT+uhD4blMp62SgfkLADkqfiC9kat5509mJFx8wWxStJshAMiNfPwBNlM9hKcDEBp+M647FS7QGZXD7rkN+ZGDohlyQCDbj+phJ5W/OuEZy4YmNnvMstJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541088; c=relaxed/simple;
	bh=+sC5tWdo2IU95xA6S4e4dpVUayhhG4/Dm+IXc61MxP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M75Ja67Z9SwgT2rh6aGX3T4qeseQSq8ETIsssFj+CXxunO8PgORkyr7z2/D8XY7Jq84uiepl9Bi5/dvr+7G/ATKJa104Xi8LC8yiY86H3H2FGUW4oVg1a7R+4mxopkLDPnwi2v6Gjrh1l8K4jmHx7D3TrNO5gw0HwYpdyUnVnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp3fKMBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE60C4CECE;
	Mon, 25 Nov 2024 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732541087;
	bh=+sC5tWdo2IU95xA6S4e4dpVUayhhG4/Dm+IXc61MxP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lp3fKMBvl6yymSnHmmn4A5iXA/97UlfrzM3wVhIBemo3WTLub06P7lDfNKehY8QGH
	 hu7W/tTlhpNHImuxTVX0AUT1+itYEERxiq9OS6Gw4v8GTJu0Rh98dfMDJqhYcBIA+9
	 23OCfpF56EwGPDDPBxK2Y8phip58tMcIP4RqJtd3oIRB7dbr8IOF+XeillBJHU2JhQ
	 W4fsh6bXV5PAUq6LQnFTK2BKfqH7cmB6AbdSQBOBTnQBWs4Yx8FqZesDV+TYosJWyD
	 h3Uedwcp7k/DyXPqdw//dA5fO+k1f8GiP2ZBkMvkV4tG6GVCYW/PC6PwbtWdmyCLLA
	 nIrAroLuwMjGQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29687cd1924so2275629fac.2;
        Mon, 25 Nov 2024 05:24:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6uwdWz62k3V63nvY35VJMaGHmi5e/cQ8F5LjP/HyugdOs0T0QQ1DUdMfqClzwDMmcnXhByuN519Y=@vger.kernel.org, AJvYcCVh5Nw7TDMRU4dOOgjtjxrf/gEG62KfP+Wri/whEeT7QwuW6CF2dzMlPj4+aiEksa/qUCby5pBRpiUWn+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxIUUdvu5bIoZFqhARlvwwHpZdn83KbGR+vASe0XQklDCB2cE
	7yZi99xuJtaK06gmmY2aHzZ0B+nOZZ7qOqm5auxU2DC0Jmx5Em/iSU7+hM0mmvaHUl8vqAG9bBg
	r3y3dJpJUguFht0X9mYFd5oJ1DCk=
X-Google-Smtp-Source: AGHT+IE1KS6PtaXhwa51qvVHerPAqCswhYaVsO60GZIJIK3iGmgKlw+yG7OTVa5wS7oiDpztDO51o39LSzRa82Xcg7U=
X-Received: by 2002:a05:6870:a68c:b0:278:1f2:a23f with SMTP id
 586e51a60fabf-29720ce1995mr9619547fac.13.1732541087064; Mon, 25 Nov 2024
 05:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-4-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-4-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:24:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iD30S1EyfqtV1_RDrxTCDmgbOA60njkdWpNzmpEAGXhw@mail.gmail.com>
Message-ID: <CAJZ5v0iD30S1EyfqtV1_RDrxTCDmgbOA60njkdWpNzmpEAGXhw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/8] ACPI: processor_idle: Use acpi_idle_play_dead()
 for all C-states
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:20=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Notice that acpi_processor_setup_cstates() can set state->enter_dead to a=
cpi_idle_play_dead() for all C-states unconditionally and remove the
> confusing C-state type check done before setting it.
>
> No intentional functional impact.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This already is in the queue of patches to be merged during the 6.13
merge window.

I gather that it has been included here for completeness.

> ---
>  drivers/acpi/processor_idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index ce728cf7e301..698897b29de2 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -800,12 +800,12 @@ static int acpi_processor_setup_cstates(struct acpi=
_processor *pr)
>                 state->enter =3D acpi_idle_enter;
>
>                 state->flags =3D 0;
> -               if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI=
_STATE_C2 ||
> -                   cx->type =3D=3D ACPI_STATE_C3) {
> -                       state->enter_dead =3D acpi_idle_play_dead;
> -                       if (cx->type !=3D ACPI_STATE_C3)
> -                               drv->safe_state_index =3D count;
> -               }
> +
> +               state->enter_dead =3D acpi_idle_play_dead;
> +
> +               if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI=
_STATE_C2)
> +                       drv->safe_state_index =3D count;
> +
>                 /*
>                  * Halt-induced C1 is not good for ->enter_s2idle, becaus=
e it
>                  * re-enables interrupts on exit.  Moreover, C1 is genera=
lly not
> --
> 2.47.0
>
>

