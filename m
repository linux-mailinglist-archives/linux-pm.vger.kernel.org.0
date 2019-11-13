Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707E6FBB82
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfKMWUA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 17:20:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36506 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMWUA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 17:20:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id j7so3359030oib.3;
        Wed, 13 Nov 2019 14:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhC+B20+FTz9NJj4JPT/8lQ7JvQjQ6WqW7ZCRG5f+Vg=;
        b=Ub1/mV/zCGfO2vy3xHrzcZns6OIZVixcUQEerKturQOy491s7oJZ3jQizA21ce6IfB
         hqDdx1MFFYc4+GD+t5JbNqK2ZNRCpZsFjoQSbWlfA0akJvx02tEyywGqOoc6igTe7RyY
         RtorQC62zxXq5Yq8UwT2qOWmtLZyGuwIGSKQVNhSW43doP5ZDiLk0WxsuQvAD77i1v3M
         ZJBR2Qc+rSkDUm47MTHkYHKMc8sV70HskKmOL5iNP8UKkJ8gG2/UPWO+n1xCOlM/ZNNE
         mDu0dbzG82CbV3+Rpmm+Hw0l3ZeOqA0E2aK6NAma1T/DoNNS/CTT98ytb9/yLP4nhIPC
         oDBA==
X-Gm-Message-State: APjAAAVrlLDkWzr76odLGpnpHVPS4Me8I09YRz2C9J5s8ZdSTdlBWaJk
        xXuXnXzCKQgnQtSQd+JS7CISoDTeGVZgdsjJ7Ck=
X-Google-Smtp-Source: APXvYqxpax1t3hzGYkrALrEWtg4SRBO1K58Tod8d9PqOJHwSgAtzRZfm2Tosxoht11KNdcsBFGLlwlJ4KNoMYP2B7sk=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr803926oig.68.1573683599592;
 Wed, 13 Nov 2019 14:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20191113185419.13305-1-daniel.lezcano@linaro.org> <20191113185419.13305-3-daniel.lezcano@linaro.org>
In-Reply-To: <20191113185419.13305-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Nov 2019 23:19:48 +0100
Message-ID: <CAJZ5v0jQmnj8dmt7TaaVh+8VmGuh1uVMN0VR1EMfMwiaEf6ikg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] cpuidle: Use the latency to call find_deepest_idle_state
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 7:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> As the dev->use_latency is filled with the latency value when this
> function is called, use it as a parameter to the
> find_deepest_idle_state() function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index f68a6c9e8482..659d8b1ece6d 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -124,7 +124,7 @@ void cpuidle_use_latency(unsigned int latency)
>  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>                                struct cpuidle_device *dev)
>  {
> -       return find_deepest_state(drv, dev, UINT_MAX, 0, false);
> +       return find_deepest_state(drv, dev, dev->use_latency, 0, false);

This breaks the suspend-to-idle case when ->enter_s2idle is NULL for
all of the enabled states, because the latency limit for forced idle
should not be applied then.

Maybe pass the latency limit to cpuidle_find_deepest_state() and
rearrange the code in cpuidle_idle_call() to use U64_MAX in the s2idle
case.

BTW, note that find_deepest_state() will take a u64 latency limit in
ns now (and going forward).

>  }
>
>  #ifdef CONFIG_SUSPEND
> --
