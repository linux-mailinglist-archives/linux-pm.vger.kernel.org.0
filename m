Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13D2351CF0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhDASXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbhDASLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:11:41 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B64C08EBB1;
        Thu,  1 Apr 2021 06:41:10 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2149284otr.4;
        Thu, 01 Apr 2021 06:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NoJkPq4zQdTHoZTxopL+2N6VYZj6FaKcFy4WNq08MA=;
        b=FWVtKf+liiT1xYjii+/BELjuBQrfQxy7+GEvGeEqJ/AsdRSIYyx71kHxUgJurph5h5
         o6YoeUlZXwyqLyKBSPLXeio9Al+ojaYvVN53ovCkP3ivzSZEHiUg6yUc971Iaw1xFriR
         XuzFQA2YLa2q/K7WSddvTs8ZONwcVbb7dtuKgnJwzE8iCthvnM4EEXqTkDd+r3LhYMdS
         A46LhXrFn1Sjfdoj15hOc6wRPRfBFQN5Qj9sTBjk5qDbpYpKX90QEzSXCtyTUkQLnTL2
         J8195UtAGXueC5LidtyISq6D9Utx4/h3UGIEUfL7lflvPfy+z/1JCRZpvNJ+GKYbVQOq
         JUiw==
X-Gm-Message-State: AOAM531AqJqwjW4qM/ENjdox2FJqPov5rLMiV0vtIBqYpC1D8PHy8wJE
        9aaQDXuseHMTkGW4td0PeHQB19m26OcXJpqRVZQ=
X-Google-Smtp-Source: ABdhPJwc0WXpqYznTofwrvExvKI+jDR9Wu3nkiFl6RKeYLFaRFDzM7rj4ga9EyBvNGejAY4PRuA0a7tO0EbvLV6WN1A=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr7183919otf.206.1617284469641;
 Thu, 01 Apr 2021 06:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com> <20210331232614.304591-4-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210331232614.304591-4-pierre-louis.bossart@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 15:40:56 +0200
Message-ID: <CAJZ5v0jS0Wfzq0M45ZbP2vNX4y=e+tvZjrmn4AiE+ycxij+CWg@mail.gmail.com>
Subject: Re: [PATCH 3/7] PM: runtime: remove kernel-doc warnings
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 1:26 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> remove make W=1 warnings
>
> drivers/base/power/runtime.c:926: warning: Function parameter or
> member 'timer' not described in 'pm_suspend_timer_fn'
>
> drivers/base/power/runtime.c:926: warning: Excess function parameter
> 'data' description in 'pm_suspend_timer_fn'
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index fe1dad68aee4..1fc1a992f90c 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -951,7 +951,7 @@ static void pm_runtime_work(struct work_struct *work)
>
>  /**
>   * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
> - * @data: Device pointer passed by pm_schedule_suspend().
> + * @timer: hrtimer used by pm_schedule_suspend().
>   *
>   * Check if the time is right and queue a suspend request.
>   */
> --

I can apply this along with the [4-5/7].  Do you want me to do that?
