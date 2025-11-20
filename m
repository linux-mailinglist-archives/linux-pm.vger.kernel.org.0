Return-Path: <linux-pm+bounces-38312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC2C75252
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 16:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA8034EF522
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C035CB8D;
	Thu, 20 Nov 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ4TwgHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA21358D37
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652994; cv=none; b=H1ZmlFbWlNVuP/RoXWuj/BWZzCyd6tZ4NeVWFVOaGTd7At3Kf8HiVVpdT/zAVNHvj6EQjw1pjpPk22nzxhF8B7vVTLP4L8QIr9At0MfPxgUKHUmGNYAIgx7j7ueIXn/r47FiLAp5YHgJlADntEtRXNh6grtDFPQ4nPC+v5TUJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652994; c=relaxed/simple;
	bh=TMYgwf7hkD87YTnxUAXVsKKx1LWG9vsJhoSUFS0CgfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNHp4EvHbxfZDLO1XNM5ZwOe/4FtcKzZfcR8XZLx/waMS6x7/Nrwo27tFqL4mfb5OysdPSdKSatkD2pw1oAbZYLd1YXukYNSTCRhYy4rwXWHsSw0QvFWFPectEzIwj3LClfMavMrvP//1SRrIY6QtMd3qpjF9fJWe5wlpdczva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ4TwgHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6040FC19425
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652994;
	bh=TMYgwf7hkD87YTnxUAXVsKKx1LWG9vsJhoSUFS0CgfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PZ4TwgHvSspfcsfmtyKxKLwrr35IvzRROk8qigMTEXuu6WNOMHmR9Y1LhHmYKaZpt
	 4zzC0QZsDkUkRYkIc0m6VJIjJABizhVl7CpHg7eHEJKXQ8zvr/O7kUnQKUyORAohKJ
	 NQmDO4aX5+7B4S+FGnT9JAcRgF4Qipqfmxw8HkkPShBUst13oJyK6Gd/dd5ZC2qegp
	 dDryEvp3bzhe25nC3W73Wmkcw+eapBeLzqlkl+LbPoTUatSwmekRZIyD/sFMWK1i51
	 5jT8bctz0jdYIDF3R/2wrXSNotGDYnTDZuMHYxW6KzsKNADUVO2MhlZFRCIRwPuc2g
	 BOMfApLFqRPNw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec5df386acso573973fac.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 07:36:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWn2meGsVA8Ja+LTNJe3bdcLFvfDzY2YHdupou3JEsbaE//ojGDST/1GhUHmHNUpUfMiJhABtpp7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEDE0Hb3l+wxXGTc2Ea3PxGlgBPScFfcB3dNVYGee0KGIQ59O
	7fioZvQ+4Hzt6fSE5p70mk7BE/YrDL31I9Psgy+Xg3XLRaPfECZ9HL1/5xi3NbJaqpWzX1YgZRp
	tZmmijJSgK2yPRm15Mp5nIcgud9i1r1M=
X-Google-Smtp-Source: AGHT+IF9xBWLsH3Z5nSfFId8xBuJcBIV52dg1sLeOV0fhOz4vIu3/ovEOhKmL/0mkqc+jUS6ZiXZm/fPZjNnQVdSIOY=
X-Received: by 2002:a05:6808:c297:b0:450:b947:1d8c with SMTP id
 5614622812f47-450ff427ea3mr1483181b6e.67.1763652993559; Thu, 20 Nov 2025
 07:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119002545.666251-1-atomlin@atomlin.com> <20251119002545.666251-2-atomlin@atomlin.com>
In-Reply-To: <20251119002545.666251-2-atomlin@atomlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 16:36:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUWMgJVAZ36_9k8N3AdZ_rGajKpQSprF6QwUtxmpH2qw@mail.gmail.com>
X-Gm-Features: AWmQ_bk0duygkcKD4CyvKtfHGq81wb1Jogfa2qQHHFvyGdisTUWtIAuoP4xNt64
Message-ID: <CAJZ5v0hUWMgJVAZ36_9k8N3AdZ_rGajKpQSprF6QwUtxmpH2qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cpuidle: sysfs: Display idle state enter function name
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, 
	nathan@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:26=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> This patch introduces a read-only "enter_function" attribute to the
> cpuidle sysfs interface. It exports the kernel symbolic name of the
> enter callback responsible for executing the CPU idle state entry
> state->enter(). It allows users to reliably map an abstract C-state
> e.g., "C0", to its concrete kernel implementation (e.g., poll_idle).
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

I'm not really sure how this helps.

For example, the intel_idle driver uses the same function for all idle
states except for the polling one, which is already advertised as
polling.

Besides, why do you want users to look into the kernel source code to
figure things out?

> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
>  drivers/cpuidle/sysfs.c                            | 9 +++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documen=
tation/ABI/testing/sysfs-devices-system-cpu
> index 8aed6d94c4cd..7be4555d502a 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -217,6 +217,13 @@ Description:
>                 time (in microseconds) this cpu should spend in this idle=
 state
>                 to make the transition worth the effort.
>
> +What:          /sys/devices/system/cpu/cpuX/cpuidle/state<N>/enter_funct=
ion
> +Date:          November 2025
> +KernelVersion: v6.18
> +Contact:       Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +               (RO) Display the symbolic name of the idle state's enter =
callback.
> +
>  What:          /sys/devices/system/cpu/cpuX/cpuidle/state<N>/s2idle/
>  Date:          March 2018
>  KernelVersion: v4.17
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 61de64817604..dbd8d796ad29 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -314,6 +314,13 @@ static ssize_t show_state_default_status(struct cpui=
dle_state *state,
>                        state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "en=
abled");
>  }
>
> +static ssize_t show_state_enter_function(struct cpuidle_state *state,
> +                                        struct cpuidle_state_usage *stat=
e_usage,
> +                                        char *buf)
> +{
> +       return sysfs_emit(buf, "%ps\n", state->enter);
> +}
> +
>  define_one_state_ro(name, show_state_name);
>  define_one_state_ro(desc, show_state_desc);
>  define_one_state_ro(latency, show_state_exit_latency);
> @@ -326,6 +333,7 @@ define_one_state_rw(disable, show_state_disable, stor=
e_state_disable);
>  define_one_state_ro(above, show_state_above);
>  define_one_state_ro(below, show_state_below);
>  define_one_state_ro(default_status, show_state_default_status);
> +define_one_state_ro(enter_function, show_state_enter_function);
>
>  static struct attribute *cpuidle_state_default_attrs[] =3D {
>         &attr_name.attr,
> @@ -340,6 +348,7 @@ static struct attribute *cpuidle_state_default_attrs[=
] =3D {
>         &attr_above.attr,
>         &attr_below.attr,
>         &attr_default_status.attr,
> +       &attr_enter_function.attr,
>         NULL
>  };
>  ATTRIBUTE_GROUPS(cpuidle_state_default);
> --
> 2.51.0
>
>

