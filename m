Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFCA59313E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Aug 2022 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiHOPEo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Aug 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiHOPEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2022 11:04:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663B205CE
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 08:04:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so9362688wrh.12
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2022 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=11iOYJYT2e13K8s6XgKD9aJwBI/D1n9/1GA9l3T5EdU=;
        b=0l0n8J8oLHQpw4KO8ZATjxzBbGtlxSKPh+Zx6UM+b2l1FA0FDzTM/QPWNO1fZBfrUR
         VBA8H+qC06qDCkiYQ/bmbJ+W8jBscgSQIpgwYr5wQwH6C6ZYLJbz2IsQp/jk7onr+aRZ
         yYwEywQrDeJ4Z1dxbojsOpUyLhuFjYsPNMEBtRO6dYB4TyMjzlsCOQjHxpBmTkhfrWAo
         d/KgW8BaVQjCp/ZclzPwng3lKX0/JTrUO3TxG4MuBaqttdIFwHb4sqyqN4NJohD/tnrh
         VxDH/uetuwZhNWinL+gZYHxHEmeSaTHz8tVsrVdtldSfLZUz8hpGB8V+01//OLrR1i0g
         YntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=11iOYJYT2e13K8s6XgKD9aJwBI/D1n9/1GA9l3T5EdU=;
        b=BieeeGVa5L3CDtwhk8LaWytdSY60jGHAJC+0XUmWt5mUY8yIM4LQtvJHTppF386BBR
         ujyqhuAhYRXBGvvNQMiEjDk2RQ9wI+W8a5r+BcXAoZDsVkkenIozrCqOOHzvO5d7MZes
         mEPu5liW93H2VC1+wrwd1BIGD0cq3Pof+YOrRLlOkc1CIlwZLu9IsWNWg64TiG3lPnKL
         ATSUonW0E3NMLr1DOWydtgpg7c+c5fSdqsbY7KzfDrejD7X3kQYlUZjppOwNTz65gMIM
         G9/wLeIZ8cmROn3WxI+q3PkxJdJUCScQtT58GN/GtfS2wT/h9C2iol6WyneeWaB+Wl9D
         g/dQ==
X-Gm-Message-State: ACgBeo34sqVxcfM+16krQc9//O1C12jSQ7TLhb7JoYyKjvkc3YGEVkhK
        9R72PrKIORC+8pcIrBiTiq5Gjg==
X-Google-Smtp-Source: AA6agR4Cn9TM3OgrdvUAtLqY0NQqp052poL59AH0CMXJaR9rpGCZtSY4D321sbwI25TV4/TqJsBf4A==
X-Received: by 2002:adf:fe4d:0:b0:223:9815:b1e5 with SMTP id m13-20020adffe4d000000b002239815b1e5mr8572076wrs.709.1660575880388;
        Mon, 15 Aug 2022 08:04:40 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b0021eed2414c9sm7364535wrr.40.2022.08.15.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:04:39 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Deepak.Sharma@amd.com>,
        <Mario.Limonciello@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Jinzhou.Su@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-2-Perry.Yuan@amd.com>
Date:   Mon, 15 Aug 2022 16:04:38 +0100
In-Reply-To: <20220814163548.326686-2-Perry.Yuan@amd.com> (Perry Yuan's
        message of "Mon, 15 Aug 2022 00:35:42 +0800")
Message-ID: <87fshxim49.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Perry,

Perry Yuan <Perry.Yuan@amd.com> writes:

> Cleanup the headers declaration which are not used
> actually and some duplicated declaration which is declarated in some
> other headers already, it will help to simplify the header part.

We usually don't get rid of indirectly included headers as long as
definitions from header are used in the code. This avoids problems if
for some reason the included header gets dropped - it'll leave the code
in an uncompilable state.

More below.

>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ac75c1cde9c..19a078e232dd 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -31,19 +31,14 @@
>  #include <linux/compiler.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> -#include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  
> -#include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
>  
>  #include <asm/msr.h>
> -#include <asm/processor.h>

On a quick scan, I noticed that "boot_cpu_data" and "boot_cpu_has()" in
the module init function are defined in "asm/processor.h" that is being
removed here. It may compile for now but makes the code more fragile as
explained above.

Please ensure that only the header files that have no definitions used
in this file (amd-pstate.c) are dropped.

> -#include <asm/cpufeature.h>
> -#include <asm/cpu_device_id.h>
>  #include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
