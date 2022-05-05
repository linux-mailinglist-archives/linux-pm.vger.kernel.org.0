Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C251B8FB
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbiEEHcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbiEEHcV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 03:32:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F1488BA
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 00:28:25 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7ca2ce255so39257807b3.7
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48+VPlemZJQL+qvD7CaffUbdWdX7cgwHukCbmFSwzDA=;
        b=DlDNwa0ZgSuGFaPb9/5V4xdJuzdc1qvt84MDes0CBs0+t3E5jO2bQtLFtvOgOGVpY/
         K3EDNQt/lzJdGsDI2h1TldQhtUIJQXkflCiTjhHmgu7gIFp7yHW3fsp2Hy8uIf+2HBRV
         hoWXI70o7DYT+XVPsNsYYbmiaqG27BxNGD54j5VBu8oR9Bf5oY8ITksM2oLOiBgsP7JK
         4PnpFjptob373B7FmzkOO64UL0fF4fWokILUdrWeQb/9YKAQGLi36glJ1Tcqkox4VwDO
         kH48CKYKvfxteTh4CzEZxOUG6UN3tO4j0xfpWcogcQz0PXcxEY2jA5/ZuqOrYtquWhF0
         bobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48+VPlemZJQL+qvD7CaffUbdWdX7cgwHukCbmFSwzDA=;
        b=sn9RocO1B3dJcTkYuAeXKgprkCM2Byj58dgC1CvvrxdHkHGdgOodPklG7v9uRZPoca
         oDL4BxszfLf2wHa+UyC3AML7uuZPg4hvvgoeczWvDe9GbM4fm5cR1Wfnd0e+V0b2zv9r
         Dfy5zMPApmNeJPg/7ZZ/QPlWQ5p5j+tpiV1dmLfINxm8LM5bBh7WDDh/oBi09pcIkMoc
         oWhKOIrsMjmzUWyZtdk1r8yTsHkMdzVXipKdZMUYodoY9yXp2SicuZo908bpD5B69evy
         QJq8acEVMUo4QoMp7mMMpnFpQeBYW5QIWk0tW7SURjF/DIIL07HOjhzswwUG4FhI/DEx
         DbGg==
X-Gm-Message-State: AOAM533k5iV+z34tGqoNXJeyIo5yKvnR2mtD/tjDFlbEBVYlj3ltXZCz
        xNv3punV8xX/tdfF/cn4W51g66x4iLeaaDhmRj7fQw==
X-Google-Smtp-Source: ABdhPJySMA4IYtf0tSy4AlHAEslsKT1Sgz5FwyhMbz396ZGiZIF5CHRLdSW+QVBf1xsup+mUhFKCXMJ8YCqPwplVMDA=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr21387188ywb.319.1651735705105; Thu, 05
 May 2022 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
In-Reply-To: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 May 2022 09:28:13 +0200
Message-ID: <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to mismatch
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 May 2022 at 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> For some platforms, the frequency returned by hardware may be slightly
> different from what is provided in the frequency table. For example,

Do you have more details ?

Do you mean that between 2 consecutives reads you can get either
500Mhz or 499Mhz ?

Or is it a fixed mismatch between the table and the freq returned by HW ?

> hardware may return 499 MHz instead of 500 MHz. In such cases it is
> better to avoid getting into unnecessary frequency updates, as we may
> end up switching policy->cur between the two and sending unnecessary
> pre/post update notifications, etc.
>
> This patch has chosen allows the hardware frequency and table frequency
> to deviate by 1 MHz for now, we may want to increase it a bit later on
> if someone still complains.
>
> Reported-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d58b0f8f3af..233e8af48848 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -28,6 +28,7 @@
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/tick.h>
> +#include <linux/units.h>
>  #include <trace/events/power.h>
>
>  static LIST_HEAD(cpufreq_policy_list);
> @@ -1708,6 +1709,16 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>                 return new_freq;
>
>         if (policy->cur != new_freq) {
> +               /*
> +                * For some platforms, the frequency returned by hardware may be
> +                * slightly different from what is provided in the frequency
> +                * table, for example hardware may return 499 MHz instead of 500
> +                * MHz. In such cases it is better to avoid getting into
> +                * unnecessary frequency updates.
> +                */
> +               if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
> +                       return policy->cur;
> +
>                 cpufreq_out_of_sync(policy, new_freq);
>                 if (update)
>                         schedule_work(&policy->update);
> --
> 2.31.1.272.g89b43f80a514
>
