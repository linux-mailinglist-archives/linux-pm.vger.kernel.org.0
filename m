Return-Path: <linux-pm+bounces-16080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6ED9A668B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CA7282D21
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD81E5731;
	Mon, 21 Oct 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep4kxYow"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55707198E6F;
	Mon, 21 Oct 2024 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509953; cv=none; b=rfwJ3xL1lC/x4s4hmZJR85H4+IpPqk0cK4MsWR4bbMvnQoaaa+5Do/mkxLM1s5rS31orcDao5UdWeaybtMGqEbgcpiHDp7KWYREh83l15k3QbALgKer+NgoMHFPYKNpGEwVdh/B2Nnrbo1jTrkojDvh+hvQrJEO66IvwuEc8HuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509953; c=relaxed/simple;
	bh=kidBKixLtnMuE9rR19t/2A2K9WwQ8lRlnp3CMuwuu8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+oxPh4VDsKokUD3nu9zLqj6w3+r12u+Jhl8WXMNFnoebDk+KhRtR9Akmc25Oey+vErnPAKGg7m2+3xq+K5ihopxKoLgCrpTuvVsuYXmv2abVhgi7XDyhPVb/CbfcPsHWgl0tWdkhzqP/Zp6npK3kbgyz08UNCUYL/Se67WNyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep4kxYow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DF2C4CEE8;
	Mon, 21 Oct 2024 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729509953;
	bh=kidBKixLtnMuE9rR19t/2A2K9WwQ8lRlnp3CMuwuu8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ep4kxYowAlls3QUxskCza2E5n0THxWIW3Ct+kM4AKuawXGkpYPH+s0isw9e3cP7kI
	 dv0FusCzKoWCyHnlopUrz5eaFwRzXLTVGh9wM+g+uAwXBN1uF4sl7dbfayBVABJFvN
	 G3iSTo7kF1Mx5Oe94ywOx6C7aR0876RRRv82PIhzMmVlUTd6NxcYky/7+S1Vu1kBjP
	 iP9K3fl+p6wclj8xS7kh/Q5csUDj6wtGUleGUh4YnkbXBzSYFR9h1KhoMukA46X7H6
	 gukiQUKNPpmZTReQVFpmlqgnJmyP10cAM7qmZILOgal5sBj3ObcwRzhRAw4jpI8LAv
	 Fd9BvU9RSHUbw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-718065d6364so1879260a34.3;
        Mon, 21 Oct 2024 04:25:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlMtVJRGIRIGQWgZ7NcXKQgpBHPoN+NiEL6j0j+kwd+jBeqFea2OQPKo81xQt0K/aTZPIQ32XlUPxls4A=@vger.kernel.org, AJvYcCV/U1lqBQtMpQLqeCusovYpxJx498Ga2ddOlX/u+k/C852ZZux7q6CAHxpdCQI+orzwBG9gwp8c30g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJxcrAECfWdw687upSkk2CWfLPPJYxDyVGlHJfLHhdUqc2nWR
	xHDbglt56Gm/cOUvlkNd/y4b0nNBxsfzk0UQyHZBb4H5hsFw1FQwgByCNnCQ/MqDlywyMkxE7jx
	ROt+B5SlMZHb6zzorDwasquumXds=
X-Google-Smtp-Source: AGHT+IGFFNpp6aTsR4aUfp2235k+qBsJMEgTGd6S2hLn6tmVFPVkE1Gb+cptvWXlnAFq6hhnEDIFpZxK7Hfw4+METnY=
X-Received: by 2002:a05:6870:440e:b0:277:f51d:3ed3 with SMTP id
 586e51a60fabf-2892c2def2emr8700988fac.16.1729509952304; Mon, 21 Oct 2024
 04:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <46853b6e-bad5-4ace-9b23-ff157f234ae3@arm.com>
In-Reply-To: <46853b6e-bad5-4ace-9b23-ff157f234ae3@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:25:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iBHEA3PPST1TxUbBrJKYxwb89GU6JzqRz1QkzmU_j_Uw@mail.gmail.com>
Message-ID: <CAJZ5v0iBHEA3PPST1TxUbBrJKYxwb89GU6JzqRz1QkzmU_j_Uw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: docs: Reflect latency changes in docs
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:00=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> There were two changes related to transition latency recently.
> Namely commit e13aa799c2a6 ("cpufreq: Change default transition delay
> to 2ms") and
> commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER").
>
> Both changed the defaults / maximums so let the documentation
> reflect that.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/adm=
in-guide/pm/cpufreq.rst
> index fe1be4ad88cb..a21369eba034 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -425,8 +425,8 @@ This governor exposes only one tunable:
>
>  ``rate_limit_us``
>         Minimum time (in microseconds) that has to pass between two conse=
cutive
> -       runs of governor computations (default: 1000 times the scaling dr=
iver's
> -       transition latency).
> +       runs of governor computations (default: 1.5 times the scaling dri=
ver's
> +       transition latency or the maximum 2ms).
>
>         The purpose of this tunable is to reduce the scheduler context ov=
erhead
>         of the governor which might be excessive without it.
> @@ -474,17 +474,17 @@ This governor exposes the following tunables:
>         This is how often the governor's worker routine should run, in
>         microseconds.
>
> -       Typically, it is set to values of the order of 10000 (10 ms).  It=
s
> -       default value is equal to the value of ``cpuinfo_transition_laten=
cy``
> -       for each policy this governor is attached to (but since the unit =
here
> -       is greater by 1000, this means that the time represented by
> -       ``sampling_rate`` is 1000 times greater than the transition laten=
cy by
> -       default).
> +       Typically, it is set to values of the order of 2000 (2 ms).  Its
> +       default value is to add a 50% breathing room
> +       to ``cpuinfo_transition_latency`` on each policy this governor is
> +       attached to. The minimum is typically the length of two scheduler
> +       ticks.
>
>         If this tunable is per-policy, the following shell command sets t=
he time
> -       represented by it to be 750 times as high as the transition laten=
cy::
> +       represented by it to be 1.5 times as high as the transition laten=
cy
> +       (the default)::
>
> -       # echo `$(($(cat cpuinfo_transition_latency) * 750 / 1000)) > ond=
emand/sampling_rate
> +       # echo `$(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand=
/sampling_rate
>
>  ``up_threshold``
>         If the estimated CPU load is above this value (in percent), the g=
overnor
> --

Applied as 6.12-rc material, thanks!

