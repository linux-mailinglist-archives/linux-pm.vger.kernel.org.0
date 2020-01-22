Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749E8145F43
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 00:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAVXmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 18:42:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45088 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 18:42:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so1160786oie.12;
        Wed, 22 Jan 2020 15:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg4jSAKM7gmdLrtuj+ZTDRE7RMikkrcGhdjxjXqcPwY=;
        b=dfVGJVG/vuXTN1b0YMtBAD83xwYyzisB07fuJgYJS6vZGlzt+ZtPqkernahswhqWwt
         zp8bAi0RQYOvY8t8jQN8TV0NKB0hB7hjIOfleA3Q38m0/ZqPOgLU4n3tlsgtH6wwvvUX
         lfyfQSER88grTurrDioIT0fjAS7WyNjTw4+BSsbH3oWpEIkyRzkZGCwBPqNrS+gWOTs5
         dhz9XlcYmV7aEF9Aj2qWCv9g1aV+fI/WG35YmOLR1/TebiMOmo055w3e8xKdWOU9lmN1
         MvBNPNxKLnZ29rN+daMtc+2wadeDzHD70WF3t/eUkwitwNKYI8PkcXA33OlJvZN1kHbY
         cVGQ==
X-Gm-Message-State: APjAAAX29bHwKzBaHkmVNR4su3a19LGMfMPKsERys9QtgcetJtcBNL1V
        GPdfdm0/nPLF6u65uhIE6f0+MduhMgRDYsCUsnk=
X-Google-Smtp-Source: APXvYqx0KUdPviphjZXMv7xv8oGPvXkntdpn0I4YSxlFArilKhN1hREAynd6/g1m8hUwNe1Qr5fYsDivPupMDr+4EEE=
X-Received: by 2002:a54:488d:: with SMTP id r13mr8401732oic.115.1579736565557;
 Wed, 22 Jan 2020 15:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20200120132408.20734-1-benjamin.gaignard@st.com>
In-Reply-To: <20200120132408.20734-1-benjamin.gaignard@st.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 00:42:34 +0100
Message-ID: <CAJZ5v0jUiazEKB6keMXYLOgPQrRBMxhrLk2rVVwPsVg7O-iJ0A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: coupled: fix warning when compiling with W=1
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 2:24 PM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Fix the warning that show up when compiling with W=1
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/cpuidle/coupled.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index b607278df25b..04003b90dc49 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -89,6 +89,7 @@
>   * @coupled_cpus: mask of cpus that are part of the coupled set
>   * @requested_state: array of requested states for cpus in the coupled set
>   * @ready_waiting_counts: combined count of cpus  in ready or waiting loops
> + * @abort_barrier: synchronisation point for abort cases
>   * @online_count: count of cpus that are online
>   * @refcnt: reference count of cpuidle devices that are using this struct
>   * @prevent: flag to prevent coupled idle while a cpu is hotplugging
> @@ -338,7 +339,7 @@ static void cpuidle_coupled_poke(int cpu)
>
>  /**
>   * cpuidle_coupled_poke_others - wake up all other cpus that may be waiting
> - * @dev: struct cpuidle_device for this cpu
> + * @this_cpu: target cpu
>   * @coupled: the struct coupled that contains the current cpu
>   *
>   * Calls cpuidle_coupled_poke on all other online cpus.
> @@ -355,7 +356,7 @@ static void cpuidle_coupled_poke_others(int this_cpu,
>
>  /**
>   * cpuidle_coupled_set_waiting - mark this cpu as in the wait loop
> - * @dev: struct cpuidle_device for this cpu
> + * @cpu: target cpu
>   * @coupled: the struct coupled that contains the current cpu
>   * @next_state: the index in drv->states of the requested state for this cpu
>   *
> @@ -376,7 +377,7 @@ static int cpuidle_coupled_set_waiting(int cpu,
>
>  /**
>   * cpuidle_coupled_set_not_waiting - mark this cpu as leaving the wait loop
> - * @dev: struct cpuidle_device for this cpu
> + * @cpu: target cpu
>   * @coupled: the struct coupled that contains the current cpu
>   *
>   * Removes the requested idle state for the specified cpuidle device.
> @@ -412,7 +413,7 @@ static void cpuidle_coupled_set_done(int cpu, struct cpuidle_coupled *coupled)
>
>  /**
>   * cpuidle_coupled_clear_pokes - spin until the poke interrupt is processed
> - * @cpu - this cpu
> + * @cpu: this cpu
>   *
>   * Turns on interrupts and spins until any outstanding poke interrupts have
>   * been processed and the poke bit has been cleared.
> --

Queued up as 5.6 material, thanks!
