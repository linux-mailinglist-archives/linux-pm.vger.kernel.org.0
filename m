Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93E69DA1F
	for <lists+linux-pm@lfdr.de>; Tue, 21 Feb 2023 05:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjBUEhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Feb 2023 23:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjBUEhA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2023 23:37:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED124C87
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 20:36:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ei9-20020a17090ae54900b002349a303ca5so3456064pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 20:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iOetp7KOSbS2oHA8GhFHZWh0mINOTnZj7zT+8oUIWQU=;
        b=LeGzq7wdURi8StllD8CXn4PTHiv8on5YA1SC5gwdZ4SBHsTsWu/1dJTjbhdlo7V0rw
         fgECr/Lb/1yjzNoX9aYkkEtB+I4sQEHv8F+sg4bI7E2IPQSekoJprOzC3eCS+ihbPJWr
         DNNde0Nj0m8b/dgMwPHEJR6yK9mFKKYO7J6iVkrfx6vmXzv10V7R7ibpx9q3a+etJVE8
         Xx7G91M76MaKboniTZt38IN0v3Hm4gtdQfDC0enpGjTqfnJHhF4vmMbpAw8TX3PEUOQ1
         5ddLzG4X2wKO7ivTajzY1AuZdZjHcsUZ22R+y8z+sjRo6S/8oes7rbjG6OzbbQjQ/0C1
         kKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOetp7KOSbS2oHA8GhFHZWh0mINOTnZj7zT+8oUIWQU=;
        b=IKJbXDHIUT4g0c+XfFHS/7R+WuTchnfMKHy2cS21Wja1Kq8oSxTsypAE4v3DpRXxwi
         6L8kLwgR7m+u9yXnGW8MYkNQZ6u24DLnKeTI68va1kp20p711sV8W4qtRg17Rm79PAAh
         70cSkzWHombCXqFXQ1xNDFxDY+L2bj6Cc0Iu+hh7mSC7teYEdEYQumdBE6t7pA3gFIse
         rXSaJSTUshJ9ewHcccFO9kw+9ERvlPgdg30zgxC2KaU3sgaxN9MEihgbKExauo0dwetK
         SrD3wR2wgh82tyRASXOLnbAXgqap2c1AoUNZ+gkrpXgJBNEB2FJRnhFoFFb41vqKQbdb
         OrHA==
X-Gm-Message-State: AO0yUKU5FYgTTKTlZwXXbQNpXTXXATX9kxHZ2BJUBdjlwEvPi5G4pjh3
        8sOM8g0BTi4RE5mP+KyL2l9OgQ==
X-Google-Smtp-Source: AK7set9AN8D6LRbWqAZjj5540we9C+jh+Tg3R+bard1qHizJkTgty0GMqzWrXdz6oj06C3+bZqzO2g==
X-Received: by 2002:a17:90a:4b4a:b0:234:9fa0:300b with SMTP id o10-20020a17090a4b4a00b002349fa0300bmr3822338pjl.13.1676954216837;
        Mon, 20 Feb 2023 20:36:56 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id 69-20020a17090a0fcb00b00234ba1cfacbsm930680pjz.17.2023.02.20.20.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 20:36:56 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:06:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: make kobj_type structure constant
Message-ID: <20230221043654.6gb454cabnjfg44k@vireshk-i7>
References: <20230220-kobj_type-cpufreq-schedutil-v1-1-7d1c92293457@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230220-kobj_type-cpufreq-schedutil-v1-1-7d1c92293457@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-02-23, 23:28, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1207c78f85c1..4c073bd9b001 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -543,7 +543,7 @@ static void sugov_tunables_free(struct kobject *kobj)
>  	kfree(to_sugov_tunables(attr_set));
>  }
>  
> -static struct kobj_type sugov_tunables_ktype = {
> +static const struct kobj_type sugov_tunables_ktype = {
>  	.default_groups = sugov_groups,
>  	.sysfs_ops = &governor_sysfs_ops,
>  	.release = &sugov_tunables_free,
> 
> ---
> base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
> change-id: 20230220-kobj_type-cpufreq-schedutil-783c6be6ff14

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
