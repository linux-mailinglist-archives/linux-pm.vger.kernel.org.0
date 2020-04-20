Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA51B05C6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDTJgO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 05:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTJgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 05:36:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D9C061A0C;
        Mon, 20 Apr 2020 02:36:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so9836579qkg.1;
        Mon, 20 Apr 2020 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3syDFruM55e7HQozZGMW1Rq8pizNFPEYU3zJts7jcc=;
        b=jPlNud7IcyvvcC4FDfDaaF2GJOXTaOY9mACZEfQBSkhKxw2DZCnYqHSpqTGEPfimor
         PjSWJpwWjdewLz98XZ/UZIfk/d/51vUoWdhqLHmdQfBUjLAy81WKoFUNUJmySNGtwnlm
         /szq8VzdM6ihajM4VLZ10Bg/ouBqD2rD8P4Y6y+FZ2146MEIhyGRVtdtNbPi8sOrMuzy
         Le86yrjIg4cAZVEsIU28yajgXDgKtthrapoK9jK7m7mTolLO94iLRVJ/lgXUtEr2NKb7
         3USDC1P8FxQUb3Y2Lk5csj4rO7UlziADVkkITlHvfjUtzVnxO6u4ONGsIzgo0HLOy/X+
         pugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3syDFruM55e7HQozZGMW1Rq8pizNFPEYU3zJts7jcc=;
        b=Y2Gs9P7DeYpRy7Yi6nV9eWowL5vfE5QR+fBn+tEyPpo3A+FshZJfIjJ+stVpVlqQAa
         TMl918CfUqSNtdhwr5yhtH2if6SZYPLvwbo6foPa5LE3k2B6VVkVcJ12I0XWObiT4pie
         h7jh30gOUdJVvHxjYPfPQL9qVkNvKO5n1fTSmuaOP8e1JMHTPj2hPeInouTSVZg9hr4I
         PO77izWKyoXFkssMzA8sacGMa2QWoYrqKhqtymxmpVa9RLIeb3RS+TNIepBZxQJhnQvw
         7jwz6RzV40K0dDH2NiaXT95BTTxxsrs1Dj1xOSo8S6Hg0GBrLnVADBsTD/9BOxaARFZg
         ytHg==
X-Gm-Message-State: AGi0PuZI47uCtBGUdGDflaFj8AMrtHrJ1HlgOLrtl3AX8F6SxjVdjSqV
        zJ73zA0XSyZw8Bzhk7TGDQjYLXdA17DVuOw+mF8=
X-Google-Smtp-Source: APiQypLw+gOLHPIU20qEHGA+Tzz3uLgk+8kc5CB4I2cZCht+4GtvYnE+IUKaHLhktJS/u/ZqgBaQaC1xS3anJ+HAJLw=
X-Received: by 2002:a37:6f41:: with SMTP id k62mr14432765qkc.239.1587375372653;
 Mon, 20 Apr 2020 02:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200413070014.12960-1-zhang.lyra@gmail.com> <20200413070014.12960-2-zhang.lyra@gmail.com>
In-Reply-To: <20200413070014.12960-2-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 20 Apr 2020 17:36:01 +0800
Message-ID: <CABOV4+XaTMd=A5_5eTtGG=S3DvgBCTxrqV4aXnp55pTsdbO4NA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] cpuidle: allow idle state to be found as
 deepest state for s2idle only
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Any comments or suggests on this? That would be very appreciated.

Thanks,
Chunyan


On Mon, Apr 13, 2020 at 5:09 PM <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Add a new flag CPUIDLE_FLAG_S2IDLE to allow c-state to be found as
> deepest state for s2idle only, so that users can add a new c-state
> for using s2idle and don't worry disturbing other use cases such as
> play_idle() which probably don't want to enter into so much deep
> idle state since devices are not suspended for that kind of cases.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/cpuidle/cpuidle.c        | 3 ++-
>  drivers/cpuidle/dt_idle_states.c | 3 +++
>  include/linux/cpuidle.h          | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index de81298051b3..bb61f0c271d2 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -89,7 +89,8 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>                     s->exit_latency_ns <= latency_req ||
>                     s->exit_latency_ns > max_latency_ns ||
>                     (s->flags & forbidden_flags) ||
> -                   (s2idle && !s->enter_s2idle))
> +                   (s2idle && !s->enter_s2idle) ||
> +                   (!s2idle && (s->flags & CPUIDLE_FLAG_S2ILDE)))
>                         continue;
>
>                 latency_req = s->exit_latency_ns;
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index 252f2a9686a6..530db2726c05 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -80,6 +80,9 @@ static int init_state_node(struct cpuidle_state *idle_state,
>         idle_state->flags = 0;
>         if (of_property_read_bool(state_node, "local-timer-stop"))
>                 idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +
> +       if (of_property_read_bool(state_node, "for-s2idle-only"))
> +               idle_state->flags |= CPUIDLE_FLAG_S2ILDE;
>         /*
>          * TODO:
>          *      replace with kstrdup and pointer assignment when name
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index ec2ef63771f0..08da701f74cd 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -78,6 +78,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
>  #define CPUIDLE_FLAG_UNUSABLE  BIT(3) /* avoid using this state */
>  #define CPUIDLE_FLAG_OFF       BIT(4) /* disable this state by default */
> +#define CPUIDLE_FLAG_S2ILDE    BIT(5) /* state is used for s2idle only */
>
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> --
> 2.20.1
>
