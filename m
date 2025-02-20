Return-Path: <linux-pm+bounces-22541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68827A3DA01
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E3422524
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449211F91D6;
	Thu, 20 Feb 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXqTp3vl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAC1F5434;
	Thu, 20 Feb 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054235; cv=none; b=OUzpydx6O6g+OjNhzNKiDVXE73BGOWXYyXRnBwKJXXJQ/yaCosOFI6HorBUXlj9mMO1iZmJXmecyooQnEN/XNionwFfZrXEFInhSI6ZoodDYXcIZs33qHFHnYvl3vHIe1d2JFbfe/eCxMRNAIeVZ4jluj8QwRW6/dGm8CQK0Rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054235; c=relaxed/simple;
	bh=4aKEMySiAJVJVYx/AJnjzCJsU6EPeAq5oHgkBgI9dvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDwWwC+rMpf6ntBq5wp5ByK+79lT/gPzDMtdwBMCb55fiz5rqJBhxeExxnQpuMaWo9/l/4kIy0wp2oLFqEsQEa1vXw7J4R6fqfKmILXEXDJmzOMXa1iukpsgeVQS7ie4XopbJnTBVz88111vCK6DCuruAm+nVHtgsFMmLrMq+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXqTp3vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CFEC4CED6;
	Thu, 20 Feb 2025 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740054234;
	bh=4aKEMySiAJVJVYx/AJnjzCJsU6EPeAq5oHgkBgI9dvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXqTp3vlpzirOjNP5bHYsEBY+HmooqEGXDfc+jKw+4OPpBPHZ+Z1oN+EmRD6RRFl2
	 I2UB7fkPjtkz1YCK5F/kjci8FpiQo2CGoWCp0FwagSHBffARYs/snPw+fnoulSD2up
	 0Ape2ntF6zxfGnSY1gBw0K5c/AGn1wK7zw3NbnJtZg12UhWvyw6NR3XgoNGctM+trh
	 Lsp9ldx4GKjNxJJ3CpJVDbxWkdL6Csax18nbvBYMQhb+ml4D9APfnhPw4Nl2Vevp1u
	 YEypC8tX8R/qk6/XENmGTZsLR8y0UEXnGmKaVZBjWSt3u0L9RtkD3f3qouqywqDu6B
	 4Mx3OjgjUHtzQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3f149c334so552159b6e.1;
        Thu, 20 Feb 2025 04:23:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDnqDTjGtZxamxoOTuImeC+64FejiPZvTv5tJzcn9Ez9vX78p/ty/HLBEXfM6yPFu74IyLskI8T44=@vger.kernel.org, AJvYcCUu27ZWMiHrh42hrMtArbqInIs2/41pVZaNNmuFknYGyHZdoIwCm+bGHLYdDM4/yXO0eK52lcxIYIU6u+SL@vger.kernel.org, AJvYcCVmvbL5gzhb8R9+I8bDI1+RmZGOXArZDsXDk82go8AYG9UAG7dZRg1nkbnAdxyYgsuw/ZEcLBBf86Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw7J7jQmUvpNP5f85SEqvfBJ8ZoO1gjjkh9OwvJv8vDviASMwl
	5uEISf3pg2rPXrRYzl+HNjNe319lIEcratujR+reHKxMJa/1XirHBSZJG9Zbxbfgx0aQArG+0jY
	0KBCGrNMI1jyeRct1UyqRyET4znU=
X-Google-Smtp-Source: AGHT+IEbYk8iaGUwe2xmupvLSpCyZpOPInIVtA2CfKO/a4GbMJktj9zYc3WXGrkxazPP/IisyQlfjS52cb0RaTBeNuA=
X-Received: by 2002:a05:6808:17a9:b0:3ea:f809:44d0 with SMTP id
 5614622812f47-3f40f24ae91mr5035187b6e.35.1740054234241; Thu, 20 Feb 2025
 04:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128141139.2033088-1-darcari@redhat.com> <20250213160741.445351-1-darcari@redhat.com>
 <CAJZ5v0gUfp+ueLMr1arwgK0r3WAQmfbb7YB54oZP-ySkD0q6YQ@mail.gmail.com> <98c470f1-5c15-4075-958b-9f35e41005c1@redhat.com>
In-Reply-To: <98c470f1-5c15-4075-958b-9f35e41005c1@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 13:23:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iq+JjOny_qfzxKPgni5BmTdNKyF+Bgu7+vfMr0Hpf5tg@mail.gmail.com>
X-Gm-Features: AWEUYZm5o7Pw4JWId4QuqKUNdQZ-OIYV4a-lPEEoo8WSFVZobFaa9oF3oRxEwao
Message-ID: <CAJZ5v0iq+JjOny_qfzxKPgni5BmTdNKyF+Bgu7+vfMr0Hpf5tg@mail.gmail.com>
Subject: Re: [PATCH v4] intel_idle: introduce 'no_native' module parameter
To: David Arcari <darcari@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, 
	Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, Feb 20, 2025 at 1:21=E2=80=AFPM David Arcari <darcari@redhat.com> w=
rote:
>
>
> Hi Rafael,
>
> On 2/19/25 4:27 PM, Rafael J. Wysocki wrote:
> > On Thu, Feb 13, 2025 at 5:07=E2=80=AFPM David Arcari <darcari@redhat.co=
m> wrote:
> >>
> >> Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor mo=
dels
> >> without C-state tables") the intel_idle driver has had the ability to =
use
> >> the ACPI _CST to populate C-states when the processor model is not
> >> recognized. However, even when the processor model is recognized (nati=
ve
> >> mode) there are cases where it is useful to make the driver ignore the=
 per
> >> cpu idle states in lieu of ACPI C-states (such as specific application
> >> performance). Add the 'no_native' module parameter to provide this
> >> functionality.
> >>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: David Arcari <darcari@redhat.com>
> >> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> >> Cc: Prarit Bhargava <prarit@redhat.com>
> >> Cc: linux-doc@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: David Arcari <darcari@redhat.com>
> >> ---
> >> v4: fix !CONFIG_ACPI_PROCESSOR_CSTATE compilation issue
> >> v3: more documentation cleanup
> >> v2: renamed parameter, cleaned up documentation
> >>
> >> Documentation/admin-guide/pm/intel_idle.rst | 18 +++++++++++++-----
> >>   drivers/idle/intel_idle.c                   | 16 ++++++++++++++++
> >>   2 files changed, 29 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentati=
on/admin-guide/pm/intel_idle.rst
> >> index 39bd6ecce7de..5940528146eb 100644
> >> --- a/Documentation/admin-guide/pm/intel_idle.rst
> >> +++ b/Documentation/admin-guide/pm/intel_idle.rst
> >> @@ -192,11 +192,19 @@ even if they have been enumerated (see :ref:`cpu=
-pm-qos` in
> >>   Documentation/admin-guide/pm/cpuidle.rst).
> >>   Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization=
 to fail.
> >>
> >> -The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``i=
ntel_idle``
> >> -if the kernel has been configured with ACPI support) can be set to ma=
ke the
> >> -driver ignore the system's ACPI tables entirely or use them for all o=
f the
> >> -recognized processor models, respectively (they both are unset by def=
ault and
> >> -``use_acpi`` has no effect if ``no_acpi`` is set).
> >> +The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
> >> +recognized by ``intel_idle`` if the kernel has been configured with A=
CPI
> >> +support.  In the case that ACPI is not configured these flags have no=
 impact
> >> +on functionality.
> >> +
> >> +``no_acpi`` - Do not use ACPI at all.  Only native mode is available,=
 no
> >> +ACPI mode.
> >> +
> >> +``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI table=
s for
> >> +C-states on/off status in native mode.
> >> +
> >> +``no_native`` - Work only in ACPI mode, no native mode available (ign=
ore
> >> +all custom tables).
> >>
> >>   The value of the ``states_off`` module parameter (0 by default) repr=
esents a
> >>   list of idle states to be disabled by default in the form of a bitma=
sk.
> >> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> >> index 118fe1d37c22..b0be5ef43ffc 100644
> >> --- a/drivers/idle/intel_idle.c
> >> +++ b/drivers/idle/intel_idle.c
> >> @@ -1695,6 +1695,10 @@ static bool force_use_acpi __read_mostly; /* No=
 effect if no_acpi is set. */
> >>   module_param_named(use_acpi, force_use_acpi, bool, 0444);
> >>   MODULE_PARM_DESC(use_acpi, "Use ACPI _CST for building the idle stat=
es list");
> >>
> >> +static bool no_native __read_mostly; /* No effect if no_acpi is set. =
*/
> >> +module_param_named(no_native, no_native, bool, 0444);
> >> +MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states=
 in lieu of ACPI idle states");
> >> +
> >>   static struct acpi_processor_power acpi_state_table __initdata;
> >>
> >>   /**
> >> @@ -1834,6 +1838,11 @@ static bool __init intel_idle_off_by_default(un=
signed int flags, u32 mwait_hint)
> >>          }
> >>          return true;
> >>   }
> >> +
> >> +static inline bool ignore_native(void)
> >> +{
> >> +       return no_native & !no_acpi;
> >> +}
> >>   #else /* !CONFIG_ACPI_PROCESSOR_CSTATE */
> >>   #define force_use_acpi (false)
> >>
> >> @@ -1843,6 +1852,7 @@ static inline bool intel_idle_off_by_default(uns=
igned int flags, u32 mwait_hint)
> >>   {
> >>          return false;
> >>   }
> >> +static inline bool ignore_native(void) { return false; }
> >>   #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
> >>
> >>   /**
> >> @@ -2328,6 +2338,12 @@ static int __init intel_idle_init(void)
> >>          pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
> >>
> >>          icpu =3D (const struct idle_cpu *)id->driver_data;
> >> +       if (ignore_native()) {
> >> +               if (icpu) {
> >> +                       pr_debug("ignoring native cpu idle states\n");
> >> +                       icpu =3D NULL;
> >> +               }
> >> +       }
> >
> > Why not
> >
> > +       if (icpu && ignore_native()) {
> > +              pr_debug("disregarding built-in CPU idle states table\n"=
);
> > +              icpu =3D NULL;
> > +       }
>
> That's cleaner.  I'll submit a v5 shortly.
>
> Should the pr_debug be a pr_info?  I've waffled on this, but think that
> pr_info is probably a good idea.  Or do you prefer pr_debug?

I think that this is debug mostly as it allows one to verify that
no_native is taken into account as expected.

