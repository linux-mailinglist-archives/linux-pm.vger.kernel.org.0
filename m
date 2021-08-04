Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4E3E06B2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbhHDRXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 13:23:05 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33447 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhHDRXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 13:23:04 -0400
Received: by mail-oi1-f178.google.com with SMTP id 26so3753317oiy.0;
        Wed, 04 Aug 2021 10:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ot6+sRJDnG9IEdLmbWzLgDoJPTVltWWliDN67LVwt3M=;
        b=g2VmYFpri/CEJsr/r+amddO1Q6/vqVuJMdH8CPsQT9E0sZpGFeoj7ARSrcGPfIf2AY
         pMT1Mg1dI1dTv4uwFt63QuxY05HKrTKb6+74Ov7lLkqDmy+OwcyGk6tjvK5T/DFDtm6n
         i/OLIDVlHHKrYrZYmwssBVj8chFb+tCNAGhQUx/jCHBLPvodOGCyqvINY9inr8EgHbXr
         kLVH84d9EkqYlFHTaFQd8sQDzV4SNqxYbc25Ol+w5144XJFCmk9hq1G8qD6+k+crF7/q
         gLgT2KL0gm/8I4RLyvJP4IKPt+Bh9/xjMMUxiUU7l3ds5Ovmq4t9e91uOvafU9bcdEFX
         Uieg==
X-Gm-Message-State: AOAM5306OmSOTOcFR81lsCLTp/nPaC0UGO+ab0KgiM/ybzJHrAVozTV3
        nBRVQmuBi76ywOkH/PiPhJGFRrcrfH3YRotX4ac=
X-Google-Smtp-Source: ABdhPJxVZiwA8lZTVCO6Rh7vKMaNJ5VdX2cJIC7ivVZvOJfrmVlciXkJiJL8ssFLJpM7zSeaocjr9CanwuMOgkC9Q8o=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr430848oib.71.1628097770612;
 Wed, 04 Aug 2021 10:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210723182759.74491-1-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20210723182759.74491-1-pankaj.gupta.linux@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 19:22:39 +0200
Message-ID: <CAJZ5v0hV-3KXJM0WiQ=5nLoO06-A5ky_E7FViokj9uDax8zg1Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: set poll_limit_ns out of if-else
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 23, 2021 at 8:28 PM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> From: Pankaj Gupta <pankaj.gupta@ionos.com>
>
>  Since poll_limit_ns is being set at the end of both if and else statement.

But they are if () and else if (), so not really.

>  Moving and setting it out at one place.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> ---
>  drivers/cpuidle/governors/haltpoll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
> index cb2a96eafc02..7d0e95bc94f3 100644
> --- a/drivers/cpuidle/governors/haltpoll.c
> +++ b/drivers/cpuidle/governors/haltpoll.c
> @@ -90,7 +90,6 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>                 if (val > guest_halt_poll_ns)
>                         val = guest_halt_poll_ns;
>
> -               dev->poll_limit_ns = val;
>         } else if (block_ns > guest_halt_poll_ns &&
>                    guest_halt_poll_allow_shrink) {
>                 unsigned int shrink = guest_halt_poll_shrink;
> @@ -100,8 +99,9 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>                         val = 0;
>                 else
>                         val /= shrink;
> -               dev->poll_limit_ns = val;
>         }
> +
> +       dev->poll_limit_ns = val;
>  }
>
>  /**
> --
> 2.25.1
>
