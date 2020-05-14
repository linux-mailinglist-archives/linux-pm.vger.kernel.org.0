Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5211D2E92
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENLnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 07:43:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43313 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENLnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 07:43:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id a68so2045964otb.10;
        Thu, 14 May 2020 04:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NS81db2WlAKMw750j0Vkkc7VOtrTVlN07aaoyD593YE=;
        b=iWd8YsJ8gMAsewHv7hUB+1DRvJfDWwQuI79cna1iibz7xp8B2GikaKruJb3hJ3O8tG
         aIWKimf2Lk0ERlQMDdlgXmLodPgmIo4ObOkwKFfB+/QQ08kD9bg2XXoOonkROWG3pCnR
         wk6bCUPS7JFPsBERqy59F9ZH3qoYojfe7UVzphz0RYORT+iUrwim6tp7xkJ1kuYExZfy
         HVH5tXMM9jeXhS9OGRyAyYt5gX9npc/Ek9BdsGFHi5NkkGx+30qd+JfJFY6DkAOgiQT5
         IuMN+sXqXRu6xOqBQkUzv5mvq/rRDnJ2Bdmq7YiKrL7HU7O6cJNGUNaf1OErDLvR3Nvp
         Fa+w==
X-Gm-Message-State: AOAM531KnNgTu1PfAadRPpib31ehDfxaQu4ZTKgmvQe5BVO87t7JXxa9
        RG3c249K6leefekrXFBXUlTQ8edhepVVpqPVG1Y=
X-Google-Smtp-Source: ABdhPJyzhN/gdsuRBgS7a7zU2LSl2miiuZORSHSpQIDzx+jZm6FIXM7zz2uaaNZ4WouoFvZQk2blbM2G/amuLKCT0A0=
X-Received: by 2002:a9d:6356:: with SMTP id y22mr3000318otk.167.1589456594965;
 Thu, 14 May 2020 04:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200513141854.18451-1-wenhu.wang@vivo.com>
In-Reply-To: <20200513141854.18451-1-wenhu.wang@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 May 2020 13:43:04 +0200
Message-ID: <CAJZ5v0jHVMA5=fYkDqSLdpvxFi8iHvxVa-ZkT71cbd4hr1ohDg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix a minor typo for cpufreq_driver doc
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 4:26 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
>
> Delete the duplicate "to" possibly double-typed.
>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpufreq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index f7240251a949..67d5950bd878 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -330,7 +330,7 @@ struct cpufreq_driver {
>          *
>          * get_intermediate should return a stable intermediate frequency
>          * platform wants to switch to and target_intermediate() should set CPU
> -        * to to that frequency, before jumping to the frequency corresponding
> +        * to that frequency, before jumping to the frequency corresponding
>          * to 'index'. Core will take care of sending notifications and driver
>          * doesn't have to handle them in target_intermediate() or
>          * target_index().
> --

Applied as 5.8 material with some minor subject changes, thanks!
