Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79D5E7C52
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfJ1W0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 18:26:51 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38248 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfJ1W0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 18:26:50 -0400
Received: by mail-ua1-f65.google.com with SMTP id u99so3229014uau.5
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cC1XjViNTOeEsQeTmUGVciEbRA1xexeqXxkOO6VDgww=;
        b=DM5oOo8+rEyJnwVGouMVDBiWRU0VJ1/FJfFl8NoT8fVM9CHjPw8BjRpJIp+OdZKjDh
         WY8S0GO54x0cf5mbLl8vQIS4zoGjDGxKEsTPxeyHZ4klvEcePB9k5463oeMG32Sxjm/U
         HYc0YhOp12rMz0PpP/yBsS5bFGtozF6X4W6EDm6IIxYGJam/iWpwVKXtmxOWEIyjc3t8
         ROZdqmWXdxy7agE76hKXjpAEht6Dy2XurOc7c2jRPQlrOAu78buXLaldLrylDLZzhJ+U
         cKT/o6k3CoXmXoy75ksjerBrbaGhFUSFlCME5GpvcVIraT7RQIJiSXq8F9CNI83HJFlW
         Xs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC1XjViNTOeEsQeTmUGVciEbRA1xexeqXxkOO6VDgww=;
        b=Vt6oQyaDm9vu/UHOUahmfLzLw5R6Ol67RzwHrluRrK5vox/dFtdP5/uNTU9SJSWZYZ
         /UxHolnTypVSCEGFc4b0LpQ4P3525FYpRbhiImLJFwHLLEe+8UM6YexMq30fU1f4HEjK
         5EvRG9o0FfpR2ZccH/2acgo+sl8iAnV5lB37VtkgffrY4Dr2Pflazf7k0rq1IzeMwrP7
         Ju9MFnnaCt5nWIuMc/tOMI4p/hXBFzEZ1VnSnt7HiYdHmS9SKxPPFsdxOg+xOJfrv9PO
         Bn7qGC3RCbCluZiH3Hsd5gNSTqjk7GVRsWj46OVLJVWl6ZRVoKoCHsIdevNNqJk/V8Rd
         YTrQ==
X-Gm-Message-State: APjAAAUK/Z2q7J/qNfSyngvf0Mnk6jUzqsZ5bhIKDVUkjL6GamZksJC4
        vmSYZt+zmz1Ubs9vVF6xKzG83qI+YFvGcZCHFd91FA==
X-Google-Smtp-Source: APXvYqzJn+qL6YJppYUuZ8U925SMp11P9pHmNsx1nzk/9DVgTW43awkHkRz7X1RA4Iu7rte3ZVmMmtwa2RLJ2ZOrBtg=
X-Received: by 2002:ab0:2258:: with SMTP id z24mr8741922uan.100.1572301609097;
 Mon, 28 Oct 2019 15:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191028143419.16236-1-daniel.lezcano@linaro.org> <20191028143419.16236-3-daniel.lezcano@linaro.org>
In-Reply-To: <20191028143419.16236-3-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Oct 2019 23:26:12 +0100
Message-ID: <CAPDyKFodr8+7W8FP_P4Ha6h3dgq-K93Hwn-_uAeY-Amwq1Q=qw@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] powercap/drivers/idle_inject: Specify the idle
 state to inject
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 28 Oct 2019 at 15:34, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Currently the idle injection framework only allows to inject the
> deepest idle state available on the system.
>
> Give the opportunity to specify which idle state we want to inject by
> adding a new function helper to set the state and use it when calling
> play_idle().
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/powercap/idle_inject.c | 14 +++++++++++++-
>  include/linux/idle_inject.h    |  3 +++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index 233c878cbf46..5e1efc71ed1c 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -66,6 +66,7 @@ struct idle_inject_thread {
>   */
>  struct idle_inject_device {
>         struct hrtimer timer;
> +       int state;
>         unsigned int idle_duration_us;
>         unsigned int run_duration_us;
>         unsigned long int cpumask[0];
> @@ -140,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
>         iit->should_run = 0;
>
>         play_idle(READ_ONCE(ii_dev->idle_duration_us),
> -                 cpuidle_find_deepest_state());
> +                 READ_ONCE(ii_dev->state));
>  }
>
>  /**
> @@ -171,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>         *idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>
> +/**
> + * idle_inject_set_state - set the idle state to inject
> + * @state: an integer for the idle state to inject
> + */
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
> +{
> +       if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
> +               WRITE_ONCE(ii_dev->state, state);
> +}
> +
>  /**
>   * idle_inject_start - start idle injections
>   * @ii_dev: idle injection control device structure
> @@ -299,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>         cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>         hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         ii_dev->timer.function = idle_inject_timer_fn;
> +       ii_dev->state = 0;
>
>         for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index a445cd1a36c5..e2b26b9ccd34 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>                                  unsigned int *run_duration_us,
>                                  unsigned int *idle_duration_us);
> +
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
> +
>  #endif /* __IDLE_INJECT_H__ */
> --
> 2.17.1
>
