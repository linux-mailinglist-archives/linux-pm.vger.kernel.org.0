Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33E3AB35D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 14:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhFQMRJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 08:17:09 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:44968 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhFQMRI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 08:17:08 -0400
Received: by mail-oi1-f182.google.com with SMTP id a26so6268957oie.11;
        Thu, 17 Jun 2021 05:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il0YVEJ4LTnZZbFctE8FNLc2eOIfsG2A+MLI98TWHXM=;
        b=aR+Ie9GINrCXmhTlsrbfVzjWoP4700E4S/YDyi0C5La9FY7vdfn9CPQoYT50KrH5gu
         Rp2rbxjycAsg1J+co75freHVLD9vGOF6oBx7JkMdwwRTRfbpltS4nPpLcitOCCEwS3Sc
         fzYSegXQc6OMXzB7LrZickwzfKMF8rGw2RWdoodFGGyx8cVQV0zNh/j8tyBRx0uW1pY8
         cueA0VSk+gX3TA8daPbQTRtMY2ps2tddeNl+Fzz1jGiVF7GWuUeA9bjLtvBQZCGp9fLG
         bseEQtcu+ieAl1YDg5+tTJOI/BMHGaQyLfBagpIEZsI+GAVhwtC8JBi13exA6/GoexXh
         pTEQ==
X-Gm-Message-State: AOAM532TleMJ/eZan847Q5BM8SMd7kFXCf7CmqwDbwMNsX88oXXpH9ua
        d0MNqoWi4dhkoxO8PPMiQ4MbdBX6TOk6ArF9oXw=
X-Google-Smtp-Source: ABdhPJwEJ95hqDTAnX77P36ntjuOEayBgpcNAsCu5KWsNYZ2gU9OVAoth1zg3Y/nJdE1ted+kdRUaUZWNI9EOeyxLqE=
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr3043926oiw.69.1623932099706;
 Thu, 17 Jun 2021 05:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210615114921.8340-1-wanjiabing@vivo.com>
In-Reply-To: <20210615114921.8340-1-wanjiabing@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:14:48 +0200
Message-ID: <CAJZ5v0gH5qsy2RWAc547znnCVoZmctSQtC5Q90sSg+dGGiW8hw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: remove unneeded semicolon in teo.c
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 15, 2021 at 1:49 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix following coccicheck warning:
> drivers/cpuidle/governors/teo.c:315:10-11: Unneeded semicolon
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/cpuidle/governors/teo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 1e0b2f828abb..7b91060e82f6 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -312,7 +312,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>
>         /* Check if there is any choice in the first place. */
>         if (drv->state_count < 2) {
> -               idx = 0;;
> +               idx = 0;
>                 goto end;
>         }
>         if (!dev->states_usage[0].disable) {
> --

Applied as 5.14 material, thanks!
