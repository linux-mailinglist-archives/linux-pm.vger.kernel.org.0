Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BEF2A30B9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgKBRBZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 12:01:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42654 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgKBRBZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 12:01:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id w145so9681877oie.9;
        Mon, 02 Nov 2020 09:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNtvSGgBt1giOW8HJR7XmcvKgmZDcMXf9oOzUI8ztVc=;
        b=EpvFBM0wBdJulMScFRwMj6PCMb6K32EtnXO7EODoxbHnaVZ5f9+oMIJCcyma/jyfbO
         ycnSLRxrm3HL/96sw1WiKCZZD7+s2oLu9t8CVOY71gtnVtSBSXPkkZF+dODBae0lQXAt
         xxT+Jn9xjlX7VwaSwxhNJGOS+d6AIEDL61u4GJd8nmcymSFFKkuf2aZlRml+acFdmzzb
         lfZ6GRdLHtix6UjscfhDJOYvGx8x9TGFDJz/CMQ5ITPN25hGIBkqH+b59cbKY3U2SKN0
         GFjFDihsfrelgGc7P+CvOe+nd8cyuD1uAWclK0GFXcn/zwpzM997GJmW/mMGhyTxncoc
         eoYg==
X-Gm-Message-State: AOAM530cUVw2qzkVjjv95sUaA6rtCug3RDt5Og6CdlaCiP8ON0gR3qy3
        6zmjO03bh0AcQ426nzJkD/LcTGtup1mnJLPyh9Q=
X-Google-Smtp-Source: ABdhPJyqrOmkuzKv1JL2iXlctFyhVbD00NcAIFQ+jUAbwIcFDj1EJbEnTgx7mvaTB16Zo78zZaKDW1rEzREIK/2CeMY=
X-Received: by 2002:a54:478f:: with SMTP id o15mr2564481oic.71.1604336484467;
 Mon, 02 Nov 2020 09:01:24 -0800 (PST)
MIME-Version: 1.0
References: <1604137168-29502-1-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1604137168-29502-1-git-send-email-Julia.Lawall@inria.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Nov 2020 18:01:13 +0100
Message-ID: <CAJZ5v0gRAjO=mL5mLs10DPZ8WapnS08yM6W6hRq63FXpg4dn8Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: correct typo
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
> cerainly -> certainly
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  Documentation/admin-guide/pm/cpuidle.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index 37940a0584ec..a26a94bc0071 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -494,7 +494,7 @@ object corresponding to it, as follows:
>         residency.
>
>  ``below``
> -       Total number of times this idle state had been asked for, but cerainly
> +       Total number of times this idle state had been asked for, but certainly
>         a deeper idle state would have been a better match for the observed idle
>         duration.

Applied as 5.10-rc material, thanks!
