Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4038F44E
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 22:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhEXUZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhEXUZN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 16:25:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA5C061574;
        Mon, 24 May 2021 13:23:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v5so35239410ljg.12;
        Mon, 24 May 2021 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y2vTah5KbgiaERVpRfAWsrrH7McZ4pgWjXKBOUsAUE4=;
        b=CNwwO0tWtR2frBsnxLOqTJKS7fBBaJTUQO+UR2w1p4Zq1EhllEcbC2BMfva6pIqKS1
         AWazCz8N9r0c8Mp/SYYzo+0AwzFudxKpkgV5E1YGNnOmUaU1TIMSb6CyuDHn1DIjcfwR
         +da7sQ0WQ/ct1odcoTlcs1VIHEDbw/alWiGnDUWA44gxwHhjKosnRoJU3jnWh4vWv5JN
         R4dgClmg8paLBb3YhbheulNg5w960SM+kwQklk7U71slgMre3JoxJ0wpmkV96NmdGlt4
         CPUo/JWEisTmIUgaGHRQwbHZIgoITeSMOG7e7mzTyzR+dE0bhIqyOB83fIEvrrd3W36j
         +oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y2vTah5KbgiaERVpRfAWsrrH7McZ4pgWjXKBOUsAUE4=;
        b=Ef0hfXuoEj7iPzbHaLIRX4MJBZzPDlttqP/2XI/s+1XL2FP91oNlA1e9LIwXzcQgGy
         sI1auRaYHQEU70PnF8o0tqmwV/JVhP1teAaKRIEqxWL4kaSwlndxEqQv8JCs7UEgHAFS
         u+82uB9tYnDXyn5FR9s6eWvvJtXwyRQgL1I++600RgqIVXXQtZlN4xeaTmInATKg6fPN
         8srb3lrWkYQeegETpZzLNQhZqVtvQ4MQgueN/F8yn0rWBcR8fWvsQQdmYkpO0C31nAt9
         tv5Z9eUSmuzV9qOUePoupPyLCdAmlruHVBC+jF1PfBZAIEJ6puo6LjNmQHDe0DMFr7QJ
         k81g==
X-Gm-Message-State: AOAM533H7YvsT6r2MjQ+M2/6GsD8WKRZuTlCrY5YtpjB+O/kfeQsnKW4
        pTmgmVjG+Pjfbaw97WfoSxqVy+AWREI=
X-Google-Smtp-Source: ABdhPJwyihuJWXEfp/sQXXk3TQcoTyqN68bdqeMj8Mi4sUe9ASp4N+Db2zxfxG9pQgZpUQNhjre03A==
X-Received: by 2002:a2e:9912:: with SMTP id v18mr18379523lji.42.1621887821657;
        Mon, 24 May 2021 13:23:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.googlemail.com with ESMTPSA id m8sm1610700lfo.80.2021.05.24.13.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:23:41 -0700 (PDT)
Subject: Re: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210523231335.8238-1-digetx@gmail.com>
 <20210523231335.8238-14-digetx@gmail.com>
 <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f0b1bea7-0752-5584-8bcc-d8b602f22c13@gmail.com>
Date:   Mon, 24 May 2021 23:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.05.2021 20:04, Ulf Hansson пишет:
> On Mon, 24 May 2021 at 01:13, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
>> to an external SoC power rail. Core power domain covers vast majority of
>> hardware blocks within a Tegra SoC. The voltage of a power domain should
>> be set to a level which satisfies all devices within the power domain.
>> Add support for the core power domain which controls voltage state of the
>> domain. This allows us to support system-wide DVFS on Tegra20-210 SoCs.
>> The PMC powergate domains now are sub-domains of the core domain, this
>> requires device-tree updating, older DTBs are unaffected.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> [...]
> 
>> +
>> +static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
>> +{
>> +       static struct lock_class_key tegra_core_domain_lock_class;
>> +       struct generic_pm_domain *genpd;
>> +       const char *rname = "core";
>> +       int err;
>> +
>> +       genpd = devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL);
>> +       if (!genpd)
>> +               return -ENOMEM;
>> +
>> +       genpd->name = np->name;
>> +       genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
>> +       genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
>> +
>> +       err = devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
>> +       if (err)
>> +               return dev_err_probe(pmc->dev, err,
>> +                                    "failed to set core OPP regulator\n");
>> +
>> +       err = pm_genpd_init(genpd, NULL, false);
>> +       if (err) {
>> +               dev_err(pmc->dev, "failed to init core genpd: %d\n", err);
>> +               return err;
>> +       }
>> +
>> +       /*
>> +        * We have a "PMC pwrgate -> Core" hierarchy of the power domains
>> +        * where PMC needs to resume and change performance (voltage) of the
>> +        * Core domain from the PMC GENPD on/off callbacks, hence we need
>> +        * to annotate the lock in order to remove confusion from the
>> +        * lockdep checker when a nested access happens.
>> +        */
> 
> Can you elaborate a bit more on this?
> 
> Are you saying that when the child domain (PMC pwrgate) gets powered
> off, you want to drop its aggregated votes it may hold for the
> performance state, as otherwise it may affect the parent domain (core
> domain)?

Yes, in particular we want to remove/add the performance vote when clk is disabled/enabled, see tegra_clock_runtime_resume/suspend() of the clk-runtimePM driver [1]. I'll send that clk patch separately once this series and some other tegra-clk patches will be merged, otherwise there are too many dependencies and it's too difficult to review.

[1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20201217180638.22748-33-digetx@gmail.com/

Please see the example lockdep trace in the end of the email that is fixed by the mutex annotation. What we have there is the tegra-host1x device driver that resumes PMC powergate domain on Tegra30, the PMC driver enables clock from the genpd.power_on callback of the powergate domain and this propagates to the clock's RPM callback which sets the performance vote of the core domain. Hence core domain vote is set from within of the powergate domain. 

> I guess this would be a valid scenario to optimize for, especially if
> you have more than one child domain of the core power domain, right?
> 
> If you have only one child domain, would it be sufficient to assign
> ->power_on|off() callbacks for the core domain and deal with the
> performance stare votes from there instead?

The core domain is the parent domain of the PMC domains + some devices directly belong to the core domain. The GENPD core aggregates the performance votes from the children domains and from devices of the parent core, this all works great already.

It sounds to me that you're suggesting to reinvent the aggregation logic within the PMC driver and create a fake hierarchy that doesn't match hardware. It won't help the lockdep warning anyways.

I actually don't quite understand what problem you're trying to solve, could you please explain? The lockdep warning is harmless, we just need to annotate the mutex lock class.

If you don't feel comfortable with the usage of lockdep_set_class() in the driver, then maybe it should be possible to make it a part of the pm_genpd_init(). For example like we did that for tegra-host1x driver recently [2].

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a24f98176d1efae2c37d3438c57a624d530d9c33


 LOCKDEP
 ============================================
 WARNING: possible recursive locking detected
 5.13.0-rc3-next-20210524-00202-g80a288f17147-dirty #7935 Tainted: G        W        
 --------------------------------------------
 kworker/u8:2/96 is trying to acquire lock:
 c202e494 (&genpd->mlock){+.+.}-{3:3}, at: genpd_runtime_resume+0x95/0x174
 
               but task is already holding lock:
 c35d9454 (&genpd->mlock){+.+.}-{3:3}, at: genpd_runtime_resume+0x95/0x174
 
               other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&genpd->mlock);
   lock(&genpd->mlock);
 
                *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by kworker/u8:2/96:
  #0: c2024ea8 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x15a/0x600
  #1: c2a31f20 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x15a/0x600
  #2: c35f04d8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x29/0xdc
  #3: c35d9454 (&genpd->mlock){+.+.}-{3:3}, at: genpd_runtime_resume+0x95/0x174
  #4: c13fbbcc (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0x17/0xac
 
               stack backtrace:
 CPU: 0 PID: 96 Comm: kworker/u8:2 Tainted: G        W         5.13.0-rc3-next-20210524-00202-g80a288f17147-dirty #7935
 Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
 Workqueue: events_unbound deferred_probe_work_func
 [<c010d1cd>] (unwind_backtrace) from [<c0109639>] (show_stack+0x11/0x14)
 [<c0109639>] (show_stack) from [<c0ba6dab>] (dump_stack_lvl+0x97/0xb0)
 [<c0ba6dab>] (dump_stack_lvl) from [<c017b24f>] (__lock_acquire+0x7fb/0x2534)
 [<c017b24f>] (__lock_acquire) from [<c017d75b>] (lock_acquire+0xf3/0x424)
 [<c017d75b>] (lock_acquire) from [<c0bb0daf>] (__mutex_lock+0x87/0x7f4)
 [<c0bb0daf>] (__mutex_lock) from [<c0bb1535>] (mutex_lock_nested+0x19/0x20)
 [<c0bb1535>] (mutex_lock_nested) from [<c0669ced>] (genpd_runtime_resume+0x95/0x174)
 [<c0669ced>] (genpd_runtime_resume) from [<c0660167>] (__rpm_callback+0x7b/0xc8)
 [<c0660167>] (__rpm_callback) from [<c06601cd>] (rpm_callback+0x19/0x60)
 [<c06601cd>] (rpm_callback) from [<c065fde3>] (rpm_resume+0x47f/0x65c)
 [<c065fde3>] (rpm_resume) from [<c066000f>] (__pm_runtime_resume+0x4f/0x78)
 [<c066000f>] (__pm_runtime_resume) from [<c05857f7>] (clk_pm_runtime_get.part.0+0x13/0x54)
 [<c05857f7>] (clk_pm_runtime_get.part.0) from [<c05881e9>] (clk_core_set_rate_nolock+0x81/0x1cc)
 [<c05881e9>] (clk_core_set_rate_nolock) from [<c0588353>] (clk_set_rate+0x1f/0x44)
 [<c0588353>] (clk_set_rate) from [<c0597cd3>] (tegra_powergate_prepare_clocks+0x2f/0x94)
 [<c0597cd3>] (tegra_powergate_prepare_clocks) from [<c059a4d1>] (tegra_powergate_power_up+0x45/0xec)
 [<c059a4d1>] (tegra_powergate_power_up) from [<c0ba7211>] (tegra_genpd_power_on+0x2b/0x50)
 [<c0ba7211>] (tegra_genpd_power_on) from [<c0667231>] (_genpd_power_on+0x6d/0xb8)
 [<c0667231>] (_genpd_power_on) from [<c066999d>] (genpd_power_on.part.0+0x85/0xf0)
 [<c066999d>] (genpd_power_on.part.0) from [<c0669cfb>] (genpd_runtime_resume+0xa3/0x174)
 [<c0669cfb>] (genpd_runtime_resume) from [<c0660167>] (__rpm_callback+0x7b/0xc8)
 [<c0660167>] (__rpm_callback) from [<c06601cd>] (rpm_callback+0x19/0x60)
 [<c06601cd>] (rpm_callback) from [<c065fde3>] (rpm_resume+0x47f/0x65c)
 [<c065fde3>] (rpm_resume) from [<c066000f>] (__pm_runtime_resume+0x4f/0x78)
 [<c066000f>] (__pm_runtime_resume) from [<c065675f>] (__device_attach+0x83/0xdc)
 [<c065675f>] (__device_attach) from [<c0655d55>] (bus_probe_device+0x5d/0x64)
 [<c0655d55>] (bus_probe_device) from [<c06560b7>] (deferred_probe_work_func+0x63/0x88)
 [<c06560b7>] (deferred_probe_work_func) from [<c0139993>] (process_one_work+0x1eb/0x600)
 [<c0139993>] (process_one_work) from [<c0139fcf>] (worker_thread+0x227/0x3bc)
 [<c0139fcf>] (worker_thread) from [<c0140ab3>] (kthread+0x13f/0x15c)
 [<c0140ab3>] (kthread) from [<c0100159>] (ret_from_fork+0x11/0x38)
 Exception stack(0xc2a31fb0 to 0xc2a31ff8)
