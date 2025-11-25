Return-Path: <linux-pm+bounces-38652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B08C86BF6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 20:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D983B0790
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB2333434;
	Tue, 25 Nov 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZRrFutD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A432D452
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098073; cv=none; b=P4MVbC6rKx/rXIeVaOuvfGFVBS4bCxDQQJWN0i2VLMOX86q/JsDe7XxS+8QfOIybWk1v8G9+KJ2rTxo8Jkdj3i7wf/GN6Iy+PXyvFSSJQ33D1A6zuLFOWsdJYOUrYGRVbr5cRC0wxT0KLioW1b+jvbxLUbQW5zrHmbH1FGj5pE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098073; c=relaxed/simple;
	bh=bc1xrHRQ+ZKqPHAoHl/Bd8rZahikEbOPGmatzumClfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlFsfwFUuYXT+T9TwazvEOce4PwWcKDWyJQ4kqOkbAmczyjqTmOT2JAiIsbzTXAwJ3tv29+U6HzBME9feZGtFIB1Yl5fFZqJl2bh3MyXfUzdq71QF/ovmWNFF6sHSkU0l6bfFaEjk8evDUymZsa3rwA3Ig+p2RPOUSLATaeQ7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZRrFutD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9BAC116B1
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764098073;
	bh=bc1xrHRQ+ZKqPHAoHl/Bd8rZahikEbOPGmatzumClfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nZRrFutD6i8EaIDcc1TAbI/3ERHiGjmvlhAf+gB15Zj7MIJh0thA4dN56fkfGncOy
	 Eme6LlS8/smts4qyFcWUtjr3ejeOXzTnMgIXkl7cZGe5AhMpHvNNOuRdcmNI28sBAm
	 ACeChL54Ly328hUNFjzs+82ab4Sl/2sowWWuo6sy6oagnYF4/d7rE6sqiwNFrVUo7+
	 ME+M5cGfvMzH/guIvUMiNI8683xXtAjLAV3lJ4gC3cJlT6oJ433zGJNEHrq5kjyVLh
	 4Uz2KsVQ2vRSFWTpfNgERy3MtBF7MsnETA0jTk4AR6Q85jDDMIhBUORN5QEGgL5+IB
	 a1Ysn4vj6PAyw==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c77ed036c3so62903a34.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:14:33 -0800 (PST)
X-Gm-Message-State: AOJu0YyfqyumeU4tllEi0JvLuFj3O4kfhXgs+n2hiNXnbAQlSjtT4hpV
	O21btaZl0nsVYZyPtFqmQqD/VLcyJPkZ+J0W8pw98SgXaDELRhYTtDQLIUvu6LnVcdHUdKAnlCz
	uLAtVVIoZ78MrkZTbZkU+r+RXP7LyajU=
X-Google-Smtp-Source: AGHT+IEoddkKApXN+UwOBw9fwFogvnl4zMV0vzyeJJ6TDe7rlHdkQPjRubLqyAULwBwL9vQgyXMNUTz0waE1ZpMZghw=
X-Received: by 2002:a05:6808:17a6:b0:44f:6d6a:55a4 with SMTP id
 5614622812f47-451128e353bmr7802695b6e.14.1764098072525; Tue, 25 Nov 2025
 11:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-4-darcari@redhat.com>
In-Reply-To: <20251118155813.533424-4-darcari@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 25 Nov 2025 14:14:21 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnFi2QSyoN2i2SlPoRLZnckLX6P7BtVVAAmjxPwJCx3Ad8Kj2qh2EUX5Tc
Message-ID: <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It would be helpful if you could describe exactly what environment you
are running in.

are there any MSRs?
Is APERF available via perf, but not via MSR?
etc.

On Tue, Nov 18, 2025 at 10:58=E2=80=AFAM David Arcari <darcari@redhat.com> =
wrote:
>
> Currently when aperf is not available the function has_amperf() still
> returns true.  The end result is that the program gets an error in
> delta_thread() which causes turbostat to restart.  We can avoid this
> by not setting msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present
> when aperf is not available allowing turbostat to execute normally.
>
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 5567b9ecd516..b3f1e4ae5813 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -8592,6 +8592,10 @@ void msr_perf_init_(void)
>                                 continue;
>
>                         if (cai->needed) {
> +                               /* check to see if APERF is available */
> +                               if (cidx =3D=3D MSR_ARCH_INFO_APERF_INDEX=
 && !has_aperf)
> +                                       continue;
> +
>                                 /* Use perf API for this counter */
>                                 if (add_msr_perf_counter(cpu, cci, cai) !=
=3D -1) {
>                                         cci->source[cai->rci_index] =3D C=
OUNTER_SOURCE_PERF;
> --
> 2.51.0
>
>


--=20
Len Brown, Intel Open Source Technology Center

