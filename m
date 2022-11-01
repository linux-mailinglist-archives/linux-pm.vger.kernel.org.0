Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAF61449B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 07:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKAGYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Nov 2022 02:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAGYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 02:24:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ABF12ADC
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 23:24:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sc25so34684842ejc.12
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LLx4Ifa4+PSEGpr0FQ+28GXR7ZIhAE1v1s6IMskmnU=;
        b=DWZFRdtYK/P/3ZIO7X+Nq0goFrrxDVcePCn514GOND4IeIilSDrw/7c5szBUPveT3N
         88T20ZQj9zXctkSmrbeszLsyoLbY9Hh1l5/ZtXR4m5Mf/KPH3RmOB8SYwG9e5UW9Jh9V
         qxf0Y7ztD1AnMwwKo1Ib0wc9J1c5I/mdkJervmGJ/X/7EoMScSiQNtICDgd2D8pkQx30
         kiIKRjBhk9/SZsqowbaON6E622YYTVgP5yUgWCDJ9qREmo/1CGkPoB9VhP29OwALsxLV
         Fd4TF7QYqvtwgvojOhZy5RaWgZ5Ndx0keYLBQ30z38R548R4ToM04QiBmz1X/AV33udI
         vNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LLx4Ifa4+PSEGpr0FQ+28GXR7ZIhAE1v1s6IMskmnU=;
        b=4Z1L9dkJmhtQotsmh9dt3hgzoTZkmd3hndqNfxUu/vovVbr8TTR/nSX2VmPrWRej/2
         FnHuENR38XY37AWEdNfKQb25MjWNvW/HL25ziI7AdbylNLKG0DbYWuvvagg2KfuDzBXz
         d7NSu0TQ2mFQlDQa70Eq5W0MfCfb+ogyoP81lpkHoSY3tzL9EiUSGAg03hNSaBEiinTz
         XhZ4jMiJG7XtwG0S3neo3HiizCIq7RZmlpXrS15TKCeRad+tN08xIjP7QiEmN3q4ARRL
         vzi84KdgmAsxHtzzJmFXiQ5F/DzMt7BRCis6fJpqrRqHKhbNcM3C7iW6KEteZnxnpqqy
         Cd/g==
X-Gm-Message-State: ACrzQf23xZUhURpetsE4TU68E0SThG4TlXWZ4ayw8fV7hf7XYlK/5qFR
        lAPoxgW1s4Oe+xMsnoqaZAYkRuH2393sCLHCj+/hGw==
X-Google-Smtp-Source: AMsMyM7Du0UIuYV+hwXaSlpQiq4ksOMny9Dob0AHjZWcMHGqbFi2FmFZLmBYdUbIlmkBFjT/Kus5krOvDsKTnAJBQm0=
X-Received: by 2002:a17:907:6d9c:b0:7ad:b45c:dc18 with SMTP id
 sb28-20020a1709076d9c00b007adb45cdc18mr15338182ejc.406.1667283855131; Mon, 31
 Oct 2022 23:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com> <20221031121314.1381472-3-kajetan.puchalski@arm.com>
In-Reply-To: <20221031121314.1381472-3-kajetan.puchalski@arm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Mon, 31 Oct 2022 23:24:06 -0700
Message-ID: <CAAYoRsUDxsbexq5KmNTk60Ki7V4q-LxHeCzJmm9DEB6O49ks2w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kajetan,

On Mon, Oct 31, 2022 at 5:14 AM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:

... [delete some]...

>  /**
>   * teo_update - Update CPU metrics after wakeup.
>   * @drv: cpuidle driver containing state data.
> @@ -303,7 +359,9 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         int i;
>
>         if (dev->last_state_idx >= 0) {
> -               teo_update(drv, dev);
> +               /* don't update metrics if the cpu was utilized during the last sleep */
> +               if (!cpu_data->utilized)
> +                       teo_update(drv, dev);
>                 dev->last_state_idx = -1;
>         }

Ignoring the metrics is not the correct thing to do.
Depending on the workflow, it can severely bias the idle states deeper
than they should be because most of the needed information to select
the appropriate shallow state is tossed out.

Example 1:
2 pairs of ping pongs = 4 threads
Parameters chosen such that idle state 2 would be a most used state.
CPU frequency governor: Schedutil.
CPU frequency scaling driver: intel_cpufreq.
HWP: Disabled
Processor: i5-10600K (6 cores 12 cpus).
Kernel: 6.1-rc3
Run length: 1e8 cycles
Idle governor:
teo: 11.73 uSecs/loop ; idle state 1 ~3.5e6 exits/sec
menu: 12.1 uSecs/loop ; idle state 1 ~3.3e6 exits/sec
util-v3: 15.2 uSecs/loop ; idle state 1 ~200 exits/sec
util-v4: 11.63 uSecs/loop ; idle state 1 ~3.5e6 exits/sec

Where util-v4 is the same as this patch (util-v3) with the above code reverted.

Note: less time per loop is better.

Example 2: Same but parameters selected such that idle state 0 would
be a most used idle state.
Run Length: 4e8 cycles
Idle governor:
teo: 3.1 uSecs/loop ; idle state 0 ~1.2e6 exits/sec
menu:  3.1 uSecs/loop ; idle state 0 ~1.3e6 exits/sec
util-v3: 5.1 uSecs/loop ; idle state 0 ~4 exits/sec
util-v4: ? uSecs/loop ; idle state 0 ~1.2e6 exits/sec (partial result)

Note: the util-v4 test is still in progress, but it is late in my time
zone. But I can tell from the idle state usage, which I can observe
once per minute, that the issue is, at least mostly, fixed.

... Doug
