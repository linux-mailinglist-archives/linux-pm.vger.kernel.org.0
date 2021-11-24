Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7343545C314
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 14:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352202AbhKXNfS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 08:35:18 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:35790 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349686AbhKXNcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 08:32:23 -0500
Received: by mail-oo1-f44.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so922098oog.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 05:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akbRClLPhfXBbW/TufdVzTe9bZgbKW/SjUWywEYbIJo=;
        b=3RyH1PAjcxJp1XOUTpD/eMt0sEILYY7RBo1jRWZIsvFjLoOThAIrw+8OXU7AE2fCKL
         gpSqK4FlagmTEVS0wDelxJSUvnSTUXWjCshfZe7t/BLjrx+RMs1Ne5Dl2iurQTPOsHIX
         W3sOyQF4UZ5nkqPyCntwrb0Kd3qlasFZOiDYt23bEdy3pKh7O+loXobltfmPjceBJZAO
         GRyzjKA4Dr6XVImgXFwuZiAmtKzdR7FLv1kIHN4BBcIk1HPgRwU1Htdrlp+fBwqGazGt
         vm2FHzsWoPufktWAv2j6vJM09zp4imSzk//9NY6LI5DHH1gD7L6JBunb43OId1kjrbGn
         L22g==
X-Gm-Message-State: AOAM5301jYZ8RQ6yhhEHjXtAIqjbQNBAmfElIyWeS2a2nVNlVSacyPgF
        zp3ZLGFQ7s/vQN6KN4GbisPQ52OCG7jjfseXh5E=
X-Google-Smtp-Source: ABdhPJzYLCh6wQAGRMvfLU/Z1QBhj7UYgT6IJKkeuIdVwA3M30/bIyU3u9vtJnyan6A1+w1KP1LNGNsvgxo+FEdgWa4=
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr8915911ooj.0.1637760553519;
 Wed, 24 Nov 2021 05:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20211027082237.26759-1-rui.zhang@intel.com> <20211027082237.26759-2-rui.zhang@intel.com>
In-Reply-To: <20211027082237.26759-2-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 14:29:02 +0100
Message-ID: <CAJZ5v0hnPX13tFYjgT7PhY-MYjmYuipXPxCHoaLbPKREnhvX2A@mail.gmail.com>
Subject: Re: [PATCH 2/3] intel_idle: cleanup cpuhotplug setup
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 10:07 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Only limited number of CPUHP_AP_ONLINE_DYN callbacks can be registered,
> thus cpuhp_remove_state() should be invoked to release the resource when
> it is not used.
>
> Fixes: fb1013a01673 ("intel_idle: Convert to hotplug state machine")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ae9d8c43e6a5..e7f2a5f85bf9 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1676,6 +1676,8 @@ static int intel_idle_cpu_online(unsigned int cpu)
>         return 0;
>  }
>
> +static enum cpuhp_state intel_idle_cpuhp_state;
> +
>  /**
>   * intel_idle_cpuidle_unregister - unregister from cpuidle framework
>   */
> @@ -1683,6 +1685,8 @@ static void __init intel_idle_cpuidle_unregister(struct cpuidle_driver *drv)
>  {
>         int i;
>
> +       if (intel_idle_cpuhp_state > 0)
> +               cpuhp_remove_state(intel_idle_cpuhp_state);

It would be more straightforward to do that directly in
intel_idle_init(), because intel_idle_cpuhp_state could be a local
variable in that function then.

>         for_each_online_cpu(i)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
>         cpuidle_unregister_driver(drv);
> @@ -1710,11 +1714,11 @@ static int __init intel_idle_cpuidle_register(struct cpuidle_driver *drv)
>                 return retval;
>         }
>
> -       retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> -                               intel_idle_cpu_online, NULL);
> -       if (retval < 0) {
> +       intel_idle_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +               "idle/intel:online", intel_idle_cpu_online, NULL);
> +       if (intel_idle_cpuhp_state < 0) {
>                 intel_idle_cpuidle_unregister(drv);
> -               return retval;
> +               return intel_idle_cpuhp_state;
>         }
>         return 0;
>  }
> --
> 2.17.1
>
