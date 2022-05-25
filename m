Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C0533663
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 07:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiEYF2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 01:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiEYF2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 01:28:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC7E54BFA
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 22:28:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so17650803plg.5
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZdwl2eDPswcFHumm58a9Iw93tuwUp/qo/Knb69EJQA=;
        b=MvnS1IZExahwrYwhSjOSa7LZQGz23l4AJGJZKt9TrNzWpagf2JON6Tkbb1Gs8JIOPG
         sMSADrHviHKLBHVtfBK0S8dNvq+7jP8gWS/MFZSbF2tsB1wyOQHpFdfx1HCW5F1LEzlU
         EcTsh+4GNnYVAGG+W6PSBJkOPcS+b3vw6UMWaXlsYGUtjcDmO6I8gdasuxSvHHqfuSu2
         bIy1ENOuQ8n2FXiGGAvX6G1CxlJzMx5DuhCMfRxs7t670V/g8kV8hULYvLGKJDCO/Ta1
         d5czWjX3BcbB1o/oqk1xurh4Z3cC4kVtYZuIr3j9920dys1/OZKG3YeSllXCoqe8UAYw
         o0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZdwl2eDPswcFHumm58a9Iw93tuwUp/qo/Knb69EJQA=;
        b=hpI7RKN5oZ1h9cuwqdwk2Zt9IXSBHsg61LEaKXcnXVzR1kI+fWKPG1ZybLTSZenPuM
         fh17Yoc02lstzFrIth6ubuOazl2yLwZ2VhnUba/awbpac91nGu3Tkxsg3UjlFHb5Qpeu
         yRW1yXdS0LR7+45LC60vAk5pLf+QNaVFZKLq04Kj4nibbfclVGzK/Mhe558OF5HRzuwk
         aQG09cl8gj89rZKVSzoESuTJ8WNWtnqZRdiZrltho4NGTNM/mj9SiXFoXvDGFYbkrI/u
         GJXNHnkxhYBDy/ef5ElKXzwI8QNV0SAZBnTJvRtWIq9RKFdNabT4VdnNknr3ph/oFJ4J
         NQcQ==
X-Gm-Message-State: AOAM531pBBPvqRcdQxVNDFeS9XwnP/KEXKdtl1Mj47/KN6OXMrpl50TO
        P44jq0gpUDQ9UdzsKaHtqOif8Q==
X-Google-Smtp-Source: ABdhPJyyH6J2GSGZ4L/l6CNHTd/q71yv4qk6Jqt+7EtQLQPIDkHfF8vTQBVo110kOjNElAvFq6y1SA==
X-Received: by 2002:a17:90b:1d10:b0:1e0:4bbb:3393 with SMTP id on16-20020a17090b1d1000b001e04bbb3393mr8356877pjb.218.1653456487622;
        Tue, 24 May 2022 22:28:07 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id r129-20020a632b87000000b003fadcbccdbasm424308pgr.69.2022.05.24.22.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 22:28:06 -0700 (PDT)
Date:   Wed, 25 May 2022 10:58:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     =?utf-8?B?4oCcUmFmYWVsIEouIFd5c29ja2nigJ0=?= <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: 'schedutil' (possibly) aberrant behavior surrounding
 suspend/resume process (timing/delay/run-away CPU issues)
Message-ID: <20220525052804.rvnp2jinpmz7vukx@vireshk-i7>
References: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Peter

On 21-05-22, 22:13, Danny van Heumen wrote:
> Hi all,
> 
> This is my first report directly to linux kernel mailing lists. I'll
> do my best, but I'll invariably make some mistakes.

That's fine. Just two things you need to take care of normally, keep
the line length to 100 columns (as I have done now) and don't do
top-posting on replies. That's all :)

> This bug report
> is based on "educated" guessing, some insight and intuition, so I
> will do my best to explain all the curiosities and why I blame
> `schedutil`. To clarify, I seems behavior of schedutil triggers
> issues elsewhere.
> 
> I write the message not to say "this is the problem, fix it!" but
> rather, I hope to check with you if you recognize potential things
> to look for, *if the reports make any sense*.
> 
> ## short summary
> 
> On multiple computers, with kernel builds from distros and also
> vanilla custom (minimal) config builds by myself, I have had a
> number of issues that all center around suspend/resume with
> 'schedutil' scaling governor active. Some issues seem to be
> explained by other causes/bug-reports, but I report this here
> because `schedutil` is a common denominator.
> 
> Characteristics:
> - Kabylake, upon suspend, problems with going into suspend, with
> "runaway processor" behavior starting to run at full power causing
> excessive build-up of heat. (intel_pstate=passive) (more details
> follow ...)

If this is actually related to cpufreq subsystem, then maybe the CPU
going down was programmed at a higher frequency (because there was
work to do during suspend) while going offline. I am not sure how it
works on Intel, but on ARM we have something like a
"suspend-frequency", which is programmed right before we suspend to
make sure not to consume a lot of power. Maybe we can do something
like this in intel-pstate driver, not sure though.

> - Haswell laptop, upon suspend, sometimes does not suspend, instead
> screen off but then returned to active.
> - Pinebook Pro: upon resume from suspend (s2idle, I'm fairly
> certain): problems getting "display panel up in time", "eMMC/SDIO
> failing to initialize", screen-flickering from excessive refreshing
> many times the blinking rate. (more details follow ...)
> 
> These issues start to happen upon suspend. The issues do not happen
> when `schedutil` is not involved.
> 
> My interpretation: somewhere just before, or just after entering
> suspend-state/initiating restore, `schedutil` messes up something
> w.r.t. timings: timings/delays/repeats happen at many times the
> intended speed.
> 
> ## `schedutil` before suspend: all good
> 
> I have been using `schedutil` for many months. Upon normal
> operations there never seem to be any issues, or unexpected events.
> What I describe all happens centered around the suspension-process,
> and sometimes as consequence afterwards.
> 
> ## Pinebook Pro issues
> 
> - original Debian kernel,
> - custom-built kernel with very minimal config: versions
> 5.15.{38,39,41} 5.17.9
> - `schedutil` cpufreq scaling governor
> - Debian bullseye (original, no third-party kernels), up-to-date
> install
> - no tlp, manual suspend procedure (either button- or lid-triggered)
> 
> The Pinebook Pro does not exhibit issues (AFAICT) upon entering
> suspend. However, resume will fail often, but not always. I have
> seen different symptoms exhibited:
> 
> 1.) 3-line error message regarding analogix_dp_resume about
>   rockchip-module not succeeding (through analogix) to re-initialize
>   the display panel in time. (It shows on that exact display panel,
>   so clearly it worked.)
> Those 3 lines of error message, are being refreshed at many times
> the necessary rate. The excessive refreshing interferes with the
> ability to switch terminals (TTY1, TTY2, etc.), because I see a
> "single frame blink" of the terminal and then gets overridden with
> the 3-line error message again. Same holds for switch to GUI DISPLAY
> terminal. Display does not have sufficient time to refresh and ends
> up with variations of extra long DPMS-off state before returning to
> the error-message-screen.
> Sometimes I am able to "interrupt" this excessive run-away behavior by keeping e.g. CTRL+ALT+1 pressed such that it will try to switch TTY at "key-repeat"-speed.
> 
> 2.) error message regarding eMMC/SDIO issues. Similar to (1.) issue
>   with failing to initialize eMMC and consequently I lose access to
>   my persistent storage.
> 
> 3.) issue also occurs when entering sleep from prolonged idleness
>   with lid already closed (DPMS off + locked) as starting-point.
> 
> [x.] Not sure if relevant at all: "crashes with wifi firmware". A
> buggy early firmware version for a broadcom wifi chip would
> occasionally crash. However, in particular around the suspend
> process there would be issues.
> I don't want to attribute this to schedutil, but maybe schedutil's
> behavior significantly increases the chance of this happening.
> 
> NOTE: I tried switching back to 'ondemand' scheduler after first
> issues had occurred with 'schedutil' active. However, reverting to
> 'ondemand' did not resolve the outstanding issues at that point.
> 
> ## Kabylake-laptop
> 
> - Distro-kernel (i.e. not vanilla)
> - `intel_pstate=passive` kernel parameter
> - `schedutil` as cpufreq scaling governor (udev-rule)
> 
> 1.) Trigger suspend on the laptop. System goes into suspend state as
>   expected. Then (in about 2 seconds) fans start spinning and
>   apparently excessive heat is being produced. (This was reported
>   somewhere already as being an issue with PCH temp being too high,
>   w.r.t. `S0ix` `intel_pch_thermal`.) However, I suspect that
>   high-temperature may be caused through `schedutil`, because the
>   laptop did not run any intensive tasks of any kind. (idling)
> Upon resuming, the laptop has lost significant amounts of battery,
> corresponding with the excessive CPU usage and cooling fans.
> 
> ## Haswell laptop
> 
> 1.) Not much to say: enter suspend, find out later that it did not
>   truly enter suspend, but was kept back and is rather active.
> 
> ## Without `schedutil`
> 
> In all cases, when taking schedutil out of the loop, these issues
> disappear. In case of the Kabylake laptop, I do set
> intel_pstate=active.

Just to clarify here, from what I understand about the active/passive
parts of intel-pstate driver, if you set intel_pstate=active then none
of the cpufreq governor's will be used. This enables the setpolicy()
callback of the driver, which will decide how the frequency changes
later on. The cpufreq governors, ondemand or schedutil, are only in
play if intel_pstate=passive.

> All have `ondemand` governor. Suspend/resume
> works, repeated many times over. Even if some errors are still
> shown, they no longer pose a problem. The excessive screen blinking
> behavior is not exhibited, for example.
> 
> ## Other things I have tried
> 
> As mentioned before, I have tried looking for other bugs. However,
> the issues seem to be too persistent. I have tried removing all
> external devices, tried using different USB ports, tried different
> suspend/resume settings in `/etc/systemd/sleep.conf`. Tried using
> 'tlp' package for additional power-management tricks. Tried
> switching governors, ... and probably more.
> 
> I realize this bug report is far from perfect. I'm afraid I cannot
> make the report much more exact/clear. I am happy to answer any
> questions you may have. I will keep an eye out for further
> peculiarities.

Also I am not yet sure it is related to cpufreq right now.

-- 
viresh
