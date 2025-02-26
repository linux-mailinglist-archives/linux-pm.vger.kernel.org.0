Return-Path: <linux-pm+bounces-22986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE07A45BAA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6311889C77
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4E23815E;
	Wed, 26 Feb 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbh0LX3O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC242AB4;
	Wed, 26 Feb 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565472; cv=none; b=nmQMFbfRJet0YZR6jASTlqdLFHhs8XnjIgoFCFDgV5vIopZaWlZ4olHxLZQ+5zfn05d8YpjO9LMnJTEut1XzKGmQxLMyF+YZIjQwsc+ZEzTx8W7Aaeyd1eEO5j8WVOsGC80YfD89PmeToEXNHCAEwa3p36qBsl5WygH45A/xPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565472; c=relaxed/simple;
	bh=W3UsMTl1eRoZNqDh2olgWY2KMFo9sL5/ZGwphflCQTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4laiW0lZU+kcac+rgIN+Ln16ncgcp4E+oakdlvdTY2uusyv+SNVSvQGSd+yd00kjM9G0V18bm5gPiiAzNbO7PYJyKG8eu0Xnz4RFGFRX0dLJQ5B+XmLuZCp8OJ3k6MTZ+6t2fHtRbhK6F83hJb5YKdcLTgyF/Zsf+LtsbTmAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbh0LX3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDEEC4CEE2;
	Wed, 26 Feb 2025 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740565471;
	bh=W3UsMTl1eRoZNqDh2olgWY2KMFo9sL5/ZGwphflCQTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hbh0LX3OvqnEzXqoqBSlj+0QUOI0stsyv5l/YUTRzvHxhxhfJ1LfarmaQqLeK/PPX
	 Nf21o64OI4SCRX28t4aiFSGyusLwvQx840jKEJHB+fZxT694bEi8IzpYvRbxaXycLi
	 NJ3GqiVldGVUopIPO1mkyyqrhsJjFgQ+CyLV6SIWddcCZBSG/k4Mxfu/jRD/aCQNDJ
	 my2P9E+PTlzSEztoe9ys00pcRBMNXsSKf7ead1UPUnlNUK72fqq4Q9SKntdaRVz1zJ
	 o2aU9/8+I42b4h0S76IbryxhfNP5lJ3+ZdjpP216QDAfp7kYpj6TozMkOIBgRYRkqk
	 jSnPTfQfm2jng==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fd28093334so2400227eaf.3;
        Wed, 26 Feb 2025 02:24:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVONQwkX/4wF3g0Mga9OUzzolRuQAtvs7VeEsOjBeDFjmVkngNHM8xf5euOYc24l9FeP1CEx62hB2v4+60=@vger.kernel.org, AJvYcCW36SG9BsFbnbP2f282T44+SYIJvTRxKUZNuXtPqx/NVBG5qCZTl6vs0cLB1QsYhqfP2GyXVWpXLxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZFvaVsHyMa3FDxHJmhsGZJ7mwWzo9V/CW5GIDBydJS1sCIYf
	fX146636A9WEcrlssYTbzafU4hnzhKLi+VwpuCbpEy59MOJTMo+swHzRAmTOf4DfvF2FFK4vEuX
	rVaN0c45h/S4387E8ZWSo3Q2ZGqs=
X-Google-Smtp-Source: AGHT+IGgEx4OXnx9BIFtFtCp5NL6tvorlL2rEvgAw6hgpWmJrhzDYNJls6DAs1pEStloVcNXyD5vvTw3VdxBifERd/0=
X-Received: by 2002:a05:6871:7b87:b0:29e:559b:d694 with SMTP id
 586e51a60fabf-2bd518598bdmr15408803fac.32.1740565471114; Wed, 26 Feb 2025
 02:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10cf96aa-1276-4bd4-8966-c890377030c3.ref@yahoo.fr>
 <10cf96aa-1276-4bd4-8966-c890377030c3@yahoo.fr> <22539099.EfDdHjke4D@debian>
 <CANDhNCqdpbi=r81NyXVWBbB5POj5nmrc7qo3r2bi1yYqYBgiAg@mail.gmail.com>
 <CANDhNCqFi1adk_MdejQC1bod5STHPDjaSB9imSGpRtJt3TbW1Q@mail.gmail.com>
 <c1d1b79c-bb2e-4a69-888d-a3301bcbfeb2@yahoo.fr> <CANDhNCreiCQUKccmW1wBtvVzQrfB=xC0GFRO65SHG-+Wfu1wtA@mail.gmail.com>
 <b9b58a9e-eb56-4acd-b854-0b5ccb8e6759@yahoo.fr> <87plkoau8w.ffs@tglx>
 <15f4f44d-6f73-4031-a7dc-d2105672bc81@yahoo.fr> <874j0jhiag.ffs@tglx>
 <5114de6a-e6ef-4459-9570-6dd2245fabd5@yahoo.fr> <87eczlg6ls.ffs@tglx> <87bjupfy7f.ffs@tglx>
In-Reply-To: <87bjupfy7f.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 11:24:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hCqV+=05ojjzvymwC5Z97WccbihCwXT22_my0TRJiWoA@mail.gmail.com>
X-Gm-Features: AQ5f1JrACA-XbyyVs587zDWqD6pwPNTSLsblqgkJ_LQqoUVOrDE7wdkknfHvWQc
Message-ID: <CAJZ5v0hCqV+=05ojjzvymwC5Z97WccbihCwXT22_my0TRJiWoA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Handle older CPUs, which stop the TSC in
 deeper C states, correctly
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Fab Stz <fabstz-it@yahoo.fr>, John Stultz <jstultz@google.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:37=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> The Intel idle driver is preferred over the ACPI processor idle driver,
> but fails to implement the work around for Core2 generation CPUs, where
> the TSC stops in C2 and deeper C-states. This causes stalls and boot
> delays, when the clocksource watchdog does not catch the unstable TSC
> before the CPU goes deep idle for the first time.
>
> The ACPI driver marks the TSC unstable when it detects that the CPU
> supports C2 or deeper and the CPU does not have a non-stop TSC.
>
> Add the equivivalent work around to the Intel idle driver to cure that.
>
> Fixes: 18734958e9bf ("intel_idle: Use ACPI _CST for processor models with=
out C-state tables")
> Reported-by: Fab Stz <fabstz-it@yahoo.fr>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Fab Stz <fabstz-it@yahoo.fr>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/10cf96aa-1276-4bd4-8966-c890377030c3@=
yahoo.fr
> ---
>  drivers/idle/intel_idle.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -56,6 +56,7 @@
>  #include <asm/intel-family.h>
>  #include <asm/mwait.h>
>  #include <asm/spec-ctrl.h>
> +#include <asm/tsc.h>
>  #include <asm/fpu/api.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
> @@ -1799,6 +1800,9 @@ static void __init intel_idle_init_cstat
>                 if (intel_idle_state_needs_timer_stop(state))
>                         state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
>
> +               if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE=
_NONSTOP_TSC))
> +                       mark_tsc_unstable("TSC halts in idle");
> +
>                 state->enter =3D intel_idle;
>                 state->enter_s2idle =3D intel_idle_s2idle;
>         }

Applied as a fix for 6.14-rc5, thank you!

