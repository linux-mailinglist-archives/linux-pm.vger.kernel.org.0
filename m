Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09F42939AF
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393535AbgJTLTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391221AbgJTLTl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 07:19:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989AC0613CE
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 04:19:39 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id n6so2548783ioc.12
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtk99RwcRA15uSBpHZ9WSY9fTeGcllWRUv7IrCjoHfA=;
        b=weLCdE0usbOet0EWnWguVvlLfrwcqKTSvkkQrzmyiverKkvCuGEV05S+QZiTWrvm49
         VFThS7jKturUsJU0mHwRb/zSCwBrSmPnxIQutX/oEMN6e4b9Gtfs+cXqvLJVqgP4moKQ
         vJb8xMmi2rs9weO07JGr/wskYsBywZXHzh9+bgrJkq6XmgVUj0bNJsxEEi4El+ldXTZz
         Wc+ZwILqmvSI3cLb85F7jKQEGor4U03h60U6MqS9Txz0Q9hftoDnmrRj9w2iRKLIgCuS
         TjDPKFxaOAjhomCExryvsCM2U3iVbPUbjX2UirdageVbTTLPMBHuPFo1BxSiMkeTvLwF
         efhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtk99RwcRA15uSBpHZ9WSY9fTeGcllWRUv7IrCjoHfA=;
        b=AQluKE8U5EDs9j8g4G+QkQ0b/ejd3pVjYfW1k4u5HNrExj0TQ+UHow35ttXJR+Z2yf
         upnVNChqLFJggbU14faQxu6XaxIy9R7AR1QtMWlLS8A3NSP4niPGBIbSdr4u7ujx8agY
         ZJ9obBTVuf5wwE/1ZGAUyyvpNr4hbaSexokVFkhQB7SX5lxC+lY2h5SM8kiFyYU+KkLL
         hJl4DZ5xA+XqDVoCpm0RxZ844zJsnWuPm5T2NVTQMH3R6Nj+lPAlVgw03tUq0a0IiaOZ
         o0warK382Zl2O0IqP/28gwS/O5ZwPJ0nwptDU9JbE2jVZztOm9ZZh5VH3ZfrOKmSfRFb
         PScA==
X-Gm-Message-State: AOAM5319AaFZbXx4RPnuYaywDj5FmmL/0ezsJe7JXpGQ1sSLasr3ttva
        blO17XhrSv/8rWWxeHGk2zDOP6QZ276grAC3Aw35Kg==
X-Google-Smtp-Source: ABdhPJzvsIwdzT7Gv11jBW1P3MT1XIo8YMqg3PJg9QbFt1HhANRvCM8uT2e2adD13uvb9gPpq39+IQv8UU3OltjkCzk=
X-Received: by 2002:a02:a317:: with SMTP id q23mr1488129jai.35.1603192778651;
 Tue, 20 Oct 2020 04:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <be911bcddc1dbf4a152513cb3d83f8eed7d2574c.1603189831.git.viresh.kumar@linaro.org>
In-Reply-To: <be911bcddc1dbf4a152513cb3d83f8eed7d2574c.1603189831.git.viresh.kumar@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Oct 2020 16:49:27 +0530
Message-ID: <CA+G9fYvUw=KeWjkTuXbzuU-R+AT+-4k=FnN1qYVPgU3RGOvHAA@mail.gmail.com>
Subject: Re: [PATCH] opp: Fix early exit from dev_pm_opp_register_set_opp_helper()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the fix patch.

On Tue, 20 Oct 2020 at 16:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> We returned earlier by mistake even when there were no failures. Fix it.
>
> Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.com>

> ---
> Rafael: Please pick up this one as well for 5.10-rc1/2 once Naresh gives
> his tested by. Thanks.
>

This patch applied on linus mainline master branch and the reported problem
on another email thread [1] has been resolved.
Test log showing arm device TI x15 boot pass [2].

>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2483e765318a..4ac4e7ce6b8b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1930,7 +1930,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
>                 return ERR_PTR(-EINVAL);
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!IS_ERR(opp_table))
> +       if (IS_ERR(opp_table))
>                 return opp_table;
>
>         /* This should be called before OPPs are initialized */
> --
> 2.25.0.rc1.19.g042ed3e048af
>

[1] https://lore.kernel.org/linux-next/20201020103617.qramu2ejlp44qxcz@vireshk-i7/T/#m21db3fcc53dc9a5833797fc1ddbc3c58b576b13b
[2] https://lkft.validation.linaro.org/scheduler/job/1863591#L1884


- Naresh
