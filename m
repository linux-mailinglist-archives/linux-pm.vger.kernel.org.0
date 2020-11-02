Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964A2A30C4
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 18:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgKBRD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 12:03:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37968 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgKBRD0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 12:03:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id b2so13238870ots.5;
        Mon, 02 Nov 2020 09:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxBlEaVfdyoDCLmLXJGwLjL48itHuyNtFBGRaznxNrY=;
        b=kUJnWY+63meqXcJAaJN+cJXIwib40qOw0v1uEUt+3jQe5Rexa/9fRPXHd1pUlgkPsD
         mp5VPnlzd0JIDs8jiqgG13ngrxurjObdB56+MEopH/lerT90RrEpd1pGTcho566tiTks
         XSwDK+FRPwFnAvJnb1mZxP4xn3O5ShQLPLEvOPaznh5DHuaKqJt8sXjyzpt5yXe8fzS9
         rw/4v3WnQ6pqLSAvZXH3d2un9OWGWOGjAwoYxE6jEEdymeUZctyKtS8qnIoCuOYESNJf
         yhfAT9hfRbqtsoCw2Akx5PSx4gHRNi5lMIVpV2vhZl5nOLCLXy4jdvdJCF8fl9U4PfvC
         lqyw==
X-Gm-Message-State: AOAM532SMnt7QUoGnSFQtjxohHEHZgM1Zp11PaDYRZmnSBsPsEh1/xZD
        pZ5ZW+qFaUcuDDtHCvyXD7JNbybAkVT71BEh4BM=
X-Google-Smtp-Source: ABdhPJw3ExOcLDLQFHftTad29tbUtNQs4yRHMzOmn6nOJtsUJM9e0YNVeSV2V7+ob9CCIZeKFPd9BgCvfZ/uRPaSz/8=
X-Received: by 2002:a9d:311:: with SMTP id 17mr994965otv.260.1604336604825;
 Mon, 02 Nov 2020 09:03:24 -0800 (PST)
MIME-Version: 1.0
References: <1604137179-29537-1-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1604137179-29537-1-git-send-email-Julia.Lawall@inria.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Nov 2020 18:03:13 +0100
Message-ID: <CAJZ5v0hvrF+X-PUsyEuFYUnsDHEop9DteDje-bemS5yWyLoFOQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: correct path name
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 31, 2020 at 11:23 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> cpu/ is needed before cpu<N>/
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  Documentation/admin-guide/pm/cpuidle.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index 37940a0584ec..26a9d648b88c 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -478,7 +478,7 @@ order to ask the hardware to enter that state.  Also, for each
>  statistics of the given idle state.  That information is exposed by the kernel
>  via ``sysfs``.
>
> -For each CPU in the system, there is a :file:`/sys/devices/system/cpu<N>/cpuidle/`
> +For each CPU in the system, there is a :file:`/sys/devices/system/cpu/cpu<N>/cpuidle/`
>  directory in ``sysfs``, where the number ``<N>`` is assigned to the given
>  CPU at the initialization time.  That directory contains a set of subdirectories
>  called :file:`state0`, :file:`state1` and so on, up to the number of idle state

Applied as 5,10-rc material, thanks!
