Return-Path: <linux-pm+bounces-610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE571800A8E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C01C209D6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9E22EE8;
	Fri,  1 Dec 2023 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="momP5KLZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9B103
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 04:13:28 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db5e5647c24so270673276.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2023 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701432807; x=1702037607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2nsGRP7caCr0X/4tRp9A8OXs6GH+R44/pSBp3/fjx8=;
        b=momP5KLZiw1bxLlqTT5xanxHxbz4huzO0A5YohazupqV0shAliPqiiE9CEe5sExCYW
         f3xgIsvEYiGRJ8MS9d1yVzKuqxQpyLJRGlEX6XQIz9oo09/NJMrux7R/q2zgeklAvRt8
         fm0u9a5TbqwC6bK4lqCgT73pAV3bPA2xGAf0gzoXZHeHNWqH7B8x5UDPUcb88tADGJmV
         ZTJhzY2h7IR6j/pYul6/VihHvA0iUIDrMR1Dz78jjPsJwlPrVRi2dST9BIa8qD5DkE2O
         xmOkGvHQqDMriOvp5wIfWg71fESThoz1+nnatXSAb++X+o7e6uI9DGVhqL5S4nkKdlAD
         bEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432807; x=1702037607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2nsGRP7caCr0X/4tRp9A8OXs6GH+R44/pSBp3/fjx8=;
        b=F7n4CBdIKC3ZZIcTMzS7FgTdTHl76rqwR8iyQHxJBeDRtDq/NxSEBCuQ90XSAxhCYG
         X6371DVxIvmWjRGtMRxjOVmMCg9GOISvX8sXIB0HVLsgtA28oH/4LRNTDQn5GONR2j6S
         iKYu1tCMl0kYPsbdB2YNzhmpEN5F8NLzplIHVNi8IgXL1Q3vgoMIpp2lUDUymS+TA9q+
         UsPVIxXar83D9LUKUjT2uhcj3PYbgniJwagStrLFDg+1r1vkbghbembQxNtJ/tzcqO/u
         CleUhGB+G1oI2ETKUHwa85eKW0jju1MfZIeSgVoePV8eLylieImGR3uo+b+QZc+ej2Iw
         xIAg==
X-Gm-Message-State: AOJu0YyyXMFyWF+YBdyGCbbrGeS5MZBhWdx4lVeprRPPS9ywU+z4RDtF
	Vg7AhB4iG6+VyNOhzZlOQai5bHfy9aYPnU4Bmr39aQ==
X-Google-Smtp-Source: AGHT+IEJR8NSAYiKwLWctlXB5JYbw2RE8N4yfLlSL0e+ygFSQtH6rjtGMoL3+UBzZRBr8IKlm7xLrieX1iJUhxuatn4=
X-Received: by 2002:a25:31c5:0:b0:db4:3a1:ed94 with SMTP id
 x188-20020a2531c5000000b00db403a1ed94mr22559658ybx.5.1701432807589; Fri, 01
 Dec 2023 04:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWl3xd7lc5pnnIcz@google.com>
In-Reply-To: <ZWl3xd7lc5pnnIcz@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Dec 2023 13:12:51 +0100
Message-ID: <CAPDyKFrzta2cbXpmWKCBK2Dn8fpQ5kOUdoDGqouGzCaNnWHb4g@mail.gmail.com>
Subject: Re: Lets not expect domains marked as `RPM_ALWAYS_ON`/`ALWAYS_ON` to
 be ON at boot
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Leonard Crestez <leonard.crestez@nxp.com>, linux-pm@vger.kernel.org, 
	manugautam@google.com, mshavit@google.com, quangh@google.com, 
	vamshigajjela@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 07:06, Ajay Agarwal <ajayagarwal@google.com> wrote:
>
> Hello Linux PM experts
>
> For a given power domain, if the `genpd->flags` has the GENPD_FLAG_RPM_ALWAYS_ON
> flag set, then pm_genpd_init expects that domain to be ON:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/domain.c?h=v6.7-rc3#n2102
>
> I have a usecase where the power domain is not ON by default on kernel boot,
> but I also want it to stay ON during RPM. But the current logic fails the
> `pm_genpd_init` for me.
>
> IMO, the kernel should not force a PD which needs to stay ON during RPM to be ON
> at boot also. It is quite possible that the PD will be turned ON for the very
> first time by a client driver in the kernel itself.

Right, you have a point. However, there is a problem with allowing this.

A consumer driver for an "irq_safe" device that is attached to a
"non-irq-safe" genpd, may call pm_runtime_get_sync() to turn on its
device/PM domain. This wouldn't work unless the PM domain has already
been powered-on by genpd.

This problem is only present when a device has multiple PM domains to
attach to, as it's only in this case when genpd leaves the PM domain
in it's current state (which could be powered-off). In the single PM
domain case, we are always powering-on the genpd, upfront, when
attaching.

The simple solution would be to always always power-on the PM domain
during attach. Perhaps the upsides of doing this are greater than the
downsides. For example, the consumer driver will get consistent
behaviour, no matter whether its device is attached to a single or
multiple PM domain(s).

What do you think?

>
> Additionally, I think the kernel as well should not enforce this for PDs which
> do not want to turn OFF ever, i.e., the ones which have `GENPD_FLAG_ALWAYS_ON`
> flag set. Let the kernel turn ON these PDs when it wants and only then prevent
> the RPM or system suspend from turning these domains OFF.

No, I don't agree with this.

The whole purpose of GENPD_FLAG_ALWAYS_ON is to allow representing PM
domains that are really supposed to be powered-on always. Like always
on power-islands/rails.

Moreover genpd makes assumptions about these PM domains during
initializations and in other paths too, which would then break.

>
> Proposed patch in pm_genpd_init:
> ```
> -       /* Always-on domains must be powered on at initialization. */
> -       if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
> -                       !genpd_status_on(genpd)) {
> -               pr_err("always-on PM domain %s is not on\n", genpd->name);
> -               return -EINVAL;
> -       }
> -
> ```
>
> Looking for your views here.
>
> Thanks
> Ajay

Kind regards
Uffe

