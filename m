Return-Path: <linux-pm+bounces-18064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162109D86E2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0401682FC
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C5C1ACDE8;
	Mon, 25 Nov 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+i60vZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0121A76CC;
	Mon, 25 Nov 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542418; cv=none; b=dIdw9J9UCP1LXXtXl4R2wx5cMwaYwqoua3n3FwtQphF0VJMDswPnuT/J1MUvuDbcbglrtOoTd05jciAwllA5y4b/WjfSFDTcgGd3v7NKCO15TlflnwLmmpKgBNjsWhUSbYezUot3hE2wLFwduTGWR7qkiU6SCKEnPnsuRDvJd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542418; c=relaxed/simple;
	bh=mroihxv6J8304pbZdIIHLXRdnuFl1KhpKRnoJlLdjkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhB+ELT7df0LN0QRN9ji+EYbW794y29qQb/G/q6g5RnH94V5eip3t9oTOG1SoR+RqcU1JG6V3eR9xD8pvYSs8DQ+v3XTrW9AUAPPXLkaxEDK0C2VQIqoj2OYK4ul+lxwtg4diPLeJFg5jDN9YKKrGHrBCvQJtY9+5qGWTFN57NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+i60vZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6213DC4CED3;
	Mon, 25 Nov 2024 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732542418;
	bh=mroihxv6J8304pbZdIIHLXRdnuFl1KhpKRnoJlLdjkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J+i60vZZcwZp4lMiHAY4OHGwwrgXrAmedke365MtBYhQqLCoHMOncM4qnzmbFiBMX
	 aCFEf8fC95Z7m6kudiPJP86Y0J4VhkUEtOkQJ9GiV7KVV2kRgZdaNccsA/5gFDI6M+
	 vsdSpb1hBJkH0EUYJFsVJyuuSJ88+5nrGseL4mJWxqs1ipXKyAXuRhYYu94EXkLh8+
	 7m63nGKhAfixuKLS0DTkxjjbeGMIhzumFuo4yZJyZjcX71nXz1EG+oDovRmeQzYeh2
	 nqZg4D19VSuLREV30I2x/opgCyTdCBcL9TjGRTpmu0UN0NdrYP2MYz7B4oYSiHGja4
	 mZui8TKe0DZ4Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso3487487fac.1;
        Mon, 25 Nov 2024 05:46:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVf8ASmZHU3C7CFDgUWfXRRwRaF3JbBl26jNf7S0wWHzbUzCCAhCk9b3t4/6lr4rYktIAKOm32KjhAStPs=@vger.kernel.org, AJvYcCXigZKUXU4HSM2E83vjBmyzD6ZgAd0xmldSxrHQKk26txc8jUlZ+FBRake6+3mFERKN7Vf1B260YXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4Be4QBAbhulv/tqC6TfAfPj/XKZsMAHJGGR8vmvcQDd2i6bv
	FJ6l0ZaGX+wUPgT4Ckor9Q2kEEUNNT77D3AWv/KDusf+SiXi5JCRTgg5hc4Glf0oaQsTUiGu6nb
	Uq5NJSzLEqguudg84D0ZrG0eEtIw=
X-Google-Smtp-Source: AGHT+IFQm2CUCUEGiPrl35EraOrE0IH2vcRfT0PtKEdoaCMTxeF9qLYJUeuHBIkbdbCxl1ucLnv8fzX4rURaQpkuwdY=
X-Received: by 2002:a05:6870:9728:b0:296:fff8:817 with SMTP id
 586e51a60fabf-29720e33783mr12116561fac.35.1732542417730; Mon, 25 Nov 2024
 05:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:46:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jnbf-BpikaVayfW=5Rrf61XNtW1JyraJ_V=advADe_VQ@mail.gmail.com>
Message-ID: <CAJZ5v0jnbf-BpikaVayfW=5Rrf61XNtW1JyraJ_V=advADe_VQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate
 on AMD platforms
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:21=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 586cc7d1d8aa..4b4ac8d55b55 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -803,7 +803,11 @@ static int acpi_processor_setup_cstates(struct acpi_=
processor *pr)
>
>                 state->flags =3D 0;
>
> -               state->enter_dead =3D acpi_idle_play_dead;
> +               /* AMD doesn't want to use mwait for play dead. */
> +               bool amd_or_hygon =3D boot_cpu_data.x86_vendor =3D=3D X86=
_VENDOR_AMD ||
> +                                   boot_cpu_data.x86_vendor =3D=3D X86_V=
ENDOR_HYGON;
> +               if (!(cx->entry_method =3D=3D ACPI_CSTATE_FFH && amd_or_h=
ygon))
> +                       state->enter_dead =3D acpi_idle_play_dead;
>
>                 if (cx->type =3D=3D ACPI_STATE_C1 || cx->type =3D=3D ACPI=
_STATE_C2)
>                         drv->safe_state_index =3D count;
> --

I don't think this is needed.

There is a vendor check in mwait_play_dead() already, no need to
duplicate it in the otherwise arch-agnostic ACPI code.

