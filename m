Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D2342153
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 16:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCSPzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 11:55:52 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40660 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhCSPzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 11:55:31 -0400
Received: by mail-oi1-f180.google.com with SMTP id i3so5239749oik.7
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 08:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4kt5f5CElYAiiHWcopBZBcVZ8n6YDkESD6uXSonfCo=;
        b=rColCOdqDx9Ke1W16YIZZ4tO0v54997mB9nhPHEPDKGR+Z0wkYkDm+BDNJ91VsBzR2
         xRYbRoCjx0v5L2RP4yDFvO7VMMVaO8fLqzMt7UFooJ4y9zQVMzJE0Tz4SFLlMPYN3lTD
         fIuIHi9yNEwSixK9sUWZ52Fq0bRPGzPhd8tXKxWpWGCog8S4hUK2XWIhoY/ZDVmYAVIT
         u3jsfnImh0K9XsXcrVL+pM0ncWGGYOA3aMSB6S0h35h4PxGmdRPsur1i4C4SQsQf1Npc
         N33jUGdCjBHRHBQSl6bCEfXEDZZO+ct3/FVhRqT13lqoHTpGnbKAT2hyiPU+Hv92q/4J
         pPVg==
X-Gm-Message-State: AOAM530U5DUM/L6Juu557zjwv4HyWl6yluKWVxO4r/gBGHoHgol6LAFj
        T0mX7rk2/wqAeW4qnAiTgJIuC0qjSI/2IWz9yq0=
X-Google-Smtp-Source: ABdhPJwFjKUNT6AOQOty3MAMm1DQOV5Z8cWhLohz+VZqI4H6o9tYK9TRKTD1QGAhY5g3mhUGEETAQ3kUDYjOLYlIMKU=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr1420867oib.69.1616169330477;
 Fri, 19 Mar 2021 08:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210317182349.1055-1-daniel.lezcano@linaro.org>
In-Reply-To: <20210317182349.1055-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 16:55:19 +0100
Message-ID: <CAJZ5v0i8nfexeFHWdcWZk3=cD4ZQRNPvJ1kEoBKWzAjP5rhOGg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add DTPM subsystem maintainer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 17, 2021 at 7:24 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The DTPM framework is a new framework allowing to do power limitation
> on devices by using different techniques. Those will be added,
> improved and complexified.
>
> The framework falls under the power management umbrella, it is more
> traffic to handle for Rafael.
>
> Add myself as the maintainer of the DTPM so I can help by taking care
> of the changes for this framework.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa84121c5611..ff7a7a875014 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14315,6 +14315,15 @@ F:     include/linux/pm_*
>  F:     include/linux/powercap.h
>  F:     kernel/configs/nopm.config
>
> +DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
> +M:     Daniel Lezcano <daniel.lezcano@kernel.org>
> +L:     linux-pm@vger.kernel.org
> +S:     Supported
> +B:     https://bugzilla.kernel.org
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> +F:     drivers/powercap/dtpm*
> +F:     include/linux/dtpm.h
> +
>  POWER STATE COORDINATION INTERFACE (PSCI)
>  M:     Mark Rutland <mark.rutland@arm.com>
>  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> --

Applied as 5.13 material, thanks!
