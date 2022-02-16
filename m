Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015EE4B8DE6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiBPQZ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 11:25:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiBPQZ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 11:25:26 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF86D243A1F
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 08:25:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p29so3912272lfa.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxkPkHWlDqesAD2skkgcNqIUaCQWaLWrTDan3sZiobs=;
        b=yNB4Xrmwgq9AxWLhkABN6H/1ik8qhjNOm9qkClxG5ePbnYtwsSAD1ublNujSl3VsKB
         QBD84lzjKkPCzmR4KrRzn3tkI+g91Ni5on0VXTFr+ZOypw5pd2UmIdDV/TOZLrw74tfN
         xDWQ3/hcZozZ+eyRSUZEeUX9twMoLLJyZD9gBKKAX34JumD4dhbeaHcgF+YdGsOpxZ/P
         AaDFRYXeNMcGI9FKGggPOcCR05Y2OBk9ibCY1PjBipl2vjz1hFJm187OlDcPAcnHKRL3
         Qrr8XBra+cmhnIsydeJkRc3e1Ffd/KgtINWuOw3Q3ZfgxC98xfg5/LFoA0lRuoXKTpKT
         qRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxkPkHWlDqesAD2skkgcNqIUaCQWaLWrTDan3sZiobs=;
        b=4IbgFPklhQjG17wT2xc5G2aOSuNply+qCZ5cN4Bks1rKbpPKPbTMlMNg1/RaLyg0CY
         zIIwh3WXMnG3nXt9hASQVFAWj7mu7EH+QJLdf1fWjfdjiHrnmhhK2h1NvE89Y4YTMEX9
         IT1GYx22p/9cr162pxCoBsxq+1x3ow7Z4O8BW5X9IvUEz4ECcjd03NR22j8M79/UAiQO
         tuCFWkcA9BmcWDVzosYW+fMO9gP0ahjbBqToJzhDm/YWX3H7ShgQpR70ogX8inTnVYac
         pn96Zn88JUHVFtvlOIzF4b3noQGhi+6mRpLpB6Xn/ZMMP5qv62oUImrEWzO33RopVbpD
         iUqw==
X-Gm-Message-State: AOAM5308whU+KHjoSgIjPJLRahUxft/R+9rbcyNH0++tz0QPCBP9pbra
        66mRyYkxqrflZnCw6dKT43rU+zySOrnK6no0foUyrw==
X-Google-Smtp-Source: ABdhPJyX0TdEvg9uB3pvpmmXC+0k7bSy8+mzCwb9mlFCwRXTD7K7MxLD7Sfsg6YDdboBiKTGf156srUKE+eeLt2Cqt8=
X-Received: by 2002:a05:6512:3d2a:b0:443:3198:cb95 with SMTP id
 d42-20020a0565123d2a00b004433198cb95mr2617794lfv.233.1645028712002; Wed, 16
 Feb 2022 08:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-2-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-2-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 17:24:35 +0100
Message-ID: <CAPDyKFpLDEzv7V-jJ-9xVZ=XqEHDdtLFYQQm=Ld7e1h=GJ8a8A@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] powercap/dtpm_cpu: Reset per_cpu variable in the
 release function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The release function does not reset the per cpu variable when it is
> called. That will prevent creation again as the variable will be
> already from the previous creation.
>
> Fix it by resetting them.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/powercap/dtpm_cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index eed5ad688d46..71f45d2f5a60 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -151,10 +151,17 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>  static void pd_release(struct dtpm *dtpm)
>  {
>         struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
> +       struct cpufreq_policy *policy;
>
>         if (freq_qos_request_active(&dtpm_cpu->qos_req))
>                 freq_qos_remove_request(&dtpm_cpu->qos_req);
>
> +       policy = cpufreq_cpu_get(dtpm_cpu->cpu);
> +       if (policy) {
> +               for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
> +                       per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
> +       }
> +
>         kfree(dtpm_cpu);
>  }
>
> --
> 2.25.1
>
