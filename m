Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4C7D6C87
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 14:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjJYM6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 08:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344308AbjJYM6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 08:58:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21995182
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 05:58:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565334377d0so4254851a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238715; x=1698843515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RXdPX/Ew6vUAH8RT3E33QyyRiIgHD1/PeR48oEvaIy0=;
        b=ujgIsFmSj0ixw/CUVChpg7tghbDRnMDBnj8ynQbY4JzSZ2NPxJYML6jWhckAY0ASPE
         GBX2jaVGsJkii10l/vWJfd1XmwRQpZqxxDFEtIEEkYTd1UtGqw1QZ6k+ivz4FRx5slZ9
         6Q0QteUAspYiRuX9Ien74naace8pNatLxtZTD2MeeoJ6R2MBjHTTNyWutoj4eA7x/BkN
         EbRU9AJPl9k4CNWxKKtauJlwGlx7Bz+UHeYlaWWzP82CqRn4+t1V4ZXKE1ghIKWGBD/4
         EjQbFTsng4kPff8s19tBLAoe/kEiq0jDcCZV5p60EQ7S2d7rGk0SmaLAY7skvOLYKubZ
         /4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238715; x=1698843515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXdPX/Ew6vUAH8RT3E33QyyRiIgHD1/PeR48oEvaIy0=;
        b=SqH8psNusCiY5TcjP0gYBagf7FpplYWEnWP623umGAJEEGWnPG9Jh2jYsKcjPbw3Kc
         gQ1cH9ZRwVEe/qj4nvuZXmB3S5HRUkBncFZ9BME3i46eBsMbkJ9xlBE4TqjNbi8J8OFD
         HZ5B08xm9k9lovXHLsxcOGt27aQmceSMeSn1sUztrI/mmnYtKxsyzPqFYdWbTP2B8GVr
         Xxs8OziQbdtBB5tkFbD8stFnw2qkqI8fwGiHCw69EEPAvEHxIQ+FKvYOamjXsWg9gQ6M
         uMopsS7MLMNiANCjRme8rUqwjZqAzZJaKq1RT5PsLv2Yfvtz0rhMPw41C7LzHk3asp4+
         kBbA==
X-Gm-Message-State: AOJu0YxaJWDn4cCLYf9P9Us2/5ZSW56V63KFsASwSfFPD9U6UKJYFSQl
        ChILkZA9e4UxBDzIgzFCCCuIt7phyUHg5TXDOur6Fg==
X-Google-Smtp-Source: AGHT+IHmoJ9xE85jGvst0QuZ8mIaONL518f/RiO/u3OpvoeRZ4onqE5R7ha2FlOK0X/zBrOO+EbV/QXuM3FR8wyWxTg=
X-Received: by 2002:a17:90a:f312:b0:27d:2cc3:c805 with SMTP id
 ca18-20020a17090af31200b0027d2cc3c805mr15222491pjb.46.1698238715427; Wed, 25
 Oct 2023 05:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org> <20231025125151.GF31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025125151.GF31201@noisy.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 Oct 2023 14:58:24 +0200
Message-ID: <CAKfTPtAb-9VcNKNf1HJOi83STrC_eNRD1Qf0Ra2fm6qspqme7w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for computing
 the capacity
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Oct 2023 at 14:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:39PM +0200, Vincent Guittot wrote:
> > Save the frequency associated to the performance that has been used when
> > initializing the capacity of CPUs.
> > Also, cppc cpufreq driver can register an artificial energy model. In such
> > case, it needs the frequency for this compute capacity.
> > We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> > outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
> >  drivers/base/arch_topology.c   |  15 +++-
> >  drivers/cpufreq/cppc_cpufreq.c | 141 ++++++---------------------------
> >  include/acpi/cppc_acpi.h       |   2 +
> >  4 files changed, 133 insertions(+), 118 deletions(-)
>
> Perhaps split this patch into code movement and actual change for ease
> of review? As in, I'm having trouble finding the actual changes ;-)

yes, I can split it.

The actual change is located in drivers/base/arch_topology.c

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
