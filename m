Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B976BED24
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCQPl1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 17 Mar 2023 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCQPl0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 11:41:26 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA323CE14
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 08:41:25 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id r11so22071455edd.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 08:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PstrEflt63qoUWsP/JfaNiClr8JYCH7JWCuFUL8GKXg=;
        b=mLQ1qMFhNlhQpGr8Skf55PDq5vPymWs83uEXysdcod+qOUgFt+t1mf7yQ9cNdUi4pX
         qAB4ElGWUQVbUbiwZAMkRlQ9qyuqWbVgpITJMHHdwM7pxB1hHKa5nhbMzCFfDQS/jnw9
         KdNluLgZy6CnB15HTO00Q1W2k/4wOBN1IGhqppiPfg8u9OJGwIMlMsRCN9CLmFik8v1a
         y7q8xm73FGoS0772PK5ar8z/3VCzT+HrhZ2ubiTcZpoPwDoQKC0WTeLY5aGGQcNDlUUr
         OBhRoWXZAbTc+b9M3T2utfLhQMmzcW/nluzTImKsweM2cCLXZVkSr47bluQGs2CFi/0v
         GMBw==
X-Gm-Message-State: AO0yUKUkZ+bOB99IWj4+AAomJyQ/rCFn+9h0rc/X3fGLEoTlI3Vz3Y73
        ff64sYdDnjnGGCU0WCV3iZR8DnaYKaGnudLy2A8=
X-Google-Smtp-Source: AK7set9t1YnLZPdb74Aqpjob3nHnUzE0Knz7BbYt2beOMx55HkIT72qhWNNSvDZ8Dt4/r2ZyEfuO76W0r4HPWVv0RCI=
X-Received: by 2002:a17:906:ee8c:b0:931:ce20:db82 with SMTP id
 wt12-20020a170906ee8c00b00931ce20db82mr1588990ejb.2.1679067683388; Fri, 17
 Mar 2023 08:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230316031549.1343340-1-qinyu32@huawei.com>
In-Reply-To: <20230316031549.1343340-1-qinyu32@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 16:41:12 +0100
Message-ID: <CAJZ5v0gFpdWih3Z4Jy6O8t9qz64w1md00ZcQY_exEn9+rC1BOw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: warn about invalid vals to scaling_max/min_freq interfaces
To:     qinyu <qinyu32@huawei.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, zhangxiaofeng46@huawei.com,
        hewenliang4@huawei.com, linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 16, 2023 at 4:11 AM qinyu <qinyu32@huawei.com> wrote:
>
> When echo an invalid val to scaling_min_freq:
> > echo 123abc123 > scaling_min_freq
> It looks weird to have a return val of 0:
> > echo $?
> > 0
>
> Sane people won't echo strings like that into these interfaces but fuzz
> tests may do. Also, maybe it's better to inform people if input is invalid
> or out of range.
>
> After this:
> > echo 123abc123 > scaling_min_freq
> > -bash: echo: write error: Invalid argument
>
> Signed-off-by: qinyu <qinyu32@huawei.com>
> Tested-by: zhangxiaofeng <zhangxiaofeng46@huawei.com>

The changelog doesn't match the actual code changes.  Please make them
match each other.

> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6d8fd3b8d..d61f7308f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -725,9 +725,9 @@ static ssize_t store_##file_name                                    \
>         unsigned long val;                                              \
>         int ret;                                                        \
>                                                                         \
> -       ret = sscanf(buf, "%lu", &val);                                 \
> -       if (ret != 1)                                                   \
> -               return -EINVAL;                                         \
> +       ret = kstrtoul(buf, 0, &val);                                   \
> +       if (ret)                                                        \
> +               return ret;                                             \
>                                                                         \
>         ret = freq_qos_update_request(policy->object##_freq_req, val);\
>         return ret >= 0 ? count : ret;                                  \
> --
> 2.33.0
>
