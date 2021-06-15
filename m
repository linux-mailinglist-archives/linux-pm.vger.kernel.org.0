Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAC3A787A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhFOHxF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhFOHxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 03:53:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C14C0617AF
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 00:51:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1701866pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o6pjvvM+6w/bHAmPBwGapPbhyq1d/rv2UppiVk/Vk9E=;
        b=fYRFQ5a40T5aLxPE2K/JfhyRHPUhkBGsJZm1fK3EcL1bHOzqOx9MABuYZ0DAdWjCjK
         oSMvkIQradD00ZD1K5u/3Ak9eblpNW/XK+FOQX5Vdk4h0m/v/pOL4zOOHBN4vzTWDHdo
         C65P1kISrFfJbfdmgUtb0O7ephAW7DMrP+Z/1FaDyK6TN7NUr1H13v9Ck6W4uKEKPO2T
         LdMOcXGVHhBwnu+QMM9ZE9URNCmQCrDHuSPK1aqkYaKcjVsew6lMW+aPp1/rwIR4Pazj
         XMl1MsnLPkGiFf3aw/8x5huhdHtoRBzCTUS5YWRhU1cPPBsSVk664KHuWzFpibtrO1Q3
         q8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o6pjvvM+6w/bHAmPBwGapPbhyq1d/rv2UppiVk/Vk9E=;
        b=Up8olC5tOtY4oeXLFoB1iA/Vv6pzgHGBFC1yusTv+O8aasffoXTttu6FC745LgOo6x
         GsY17h6tkMeP8HUxtcXMzUGTK1Y88kI6nlVbCBYyeB2FSNHcDmh9GHjKK7wYrJhx8VYO
         KnLe1QYAI/0YrHgrExgQJbFyO4lHwZjoTUG2Ikv046xud7Hlmp/6APPLZaF9SoLtYO80
         kAS59PtfvRwsfzW+34ROjiqN4odF98NLP2+XCX70BBIy4RnJ1694KqiJaM0nOYG5B+Lm
         5j8RqCzSQIsSSakYi/9hljr7ro+jO2OVyf5p9TgXk/DTGDeQNdV/lslk5iAizLfFdjQU
         +v6A==
X-Gm-Message-State: AOAM5321jHaNVwLVqxUCNFXvhyOfL7rWVt4AIVLkEhaErmezzQYoAw+X
        Nh4mESLhb+kfy7dTNTrRFKGlMA==
X-Google-Smtp-Source: ABdhPJzPKm/IfKwXRrMkBKTrt3+fICn4R+w0D83sOoiEVwVBYjGg7LV6k2TSGhePw0fawgRZeALYnA==
X-Received: by 2002:a17:903:2308:b029:110:41c3:70b0 with SMTP id d8-20020a1709032308b029011041c370b0mr3091032plh.32.1623743459534;
        Tue, 15 Jun 2021 00:50:59 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id q12sm15373043pgc.25.2021.06.15.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 00:50:58 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:20:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5] cpufreq: cppc: Fix suspend/resume specific races
 with FIE code
Message-ID: <20210615075056.dfkbiftuoihtrfpo@vireshk-i7>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
 <eaaaf171-5937-e0f2-8447-c1b20b474c62@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaaaf171-5937-e0f2-8447-c1b20b474c62@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Qian,

First of all thanks for testing this, I need more of your help to test
this out :)

FWIW, I did test this on my Hikey board today, with some hacks, and
tried multiple insmod/rmmod operations for the driver, and I wasn't
able to reproduce the issue you reported. I did enable the list-debug
config option.

On 14-06-21, 09:48, Qian Cai wrote:
> Unfortunately, this series looks like needing more works.
> 
> [  487.773586][    T0] CPU17: Booted secondary processor 0x0000000801 [0x503f0002]
> [  487.976495][  T670] list_del corruption. next->prev should be ffff009b66e9ec70, but was ffff009b66dfec70
> [  487.987037][  T670] ------------[ cut here ]------------
> [  487.992351][  T670] kernel BUG at lib/list_debug.c:54!
> [  487.997810][  T670] Internal error: Oops - BUG: 0 [#1] SMP
> [  488.003295][  T670] Modules linked in: cpufreq_userspace xfs loop cppc_cpufreq processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core nvme_core firmware_class
> [  488.021759][  T670] CPU: 1 PID: 670 Comm: cppc_fie Not tainted 5.13.0-rc5-next-20210611+ #46
> [  488.030190][  T670] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> [  488.038705][  T670] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> [  488.045398][  T670] pc : __list_del_entry_valid+0x154/0x158
> [  488.050969][  T670] lr : __list_del_entry_valid+0x154/0x158
> [  488.056534][  T670] sp : ffff8000229afd70
> [  488.060534][  T670] x29: ffff8000229afd70 x28: ffff0008c8f4f340 x27: dfff800000000000
> [  488.068361][  T670] x26: ffff009b66e9ec70 x25: ffff800011c8b4d0 x24: ffff0008d4bfe488
> [  488.076188][  T670] x23: ffff0008c8f4f340 x22: ffff0008c8f4f340 x21: ffff009b6789ec70
> [  488.084015][  T670] x20: ffff0008d4bfe4c8 x19: ffff009b66e9ec70 x18: ffff0008c8f4fd70
> [  488.091842][  T670] x17: 20747562202c3037 x16: 6365396536366239 x15: 0000000000000028
> [  488.099669][  T670] x14: 0000000000000000 x13: 0000000000000001 x12: ffff60136cdd3447
> [  488.107495][  T670] x11: 1fffe0136cdd3446 x10: ffff60136cdd3446 x9 : ffff8000103ee444
> [  488.115322][  T670] x8 : ffff009b66e9a237 x7 : 0000000000000001 x6 : ffff009b66e9a230
> [  488.123149][  T670] x5 : 00009fec9322cbba x4 : ffff60136cdd3447 x3 : 1fffe001191e9e69
> [  488.130975][  T670] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000054
> [  488.138803][  T670] Call trace:
> [  488.141935][  T670]  __list_del_entry_valid+0x154/0x158
> [  488.147153][  T670]  kthread_worker_fn+0x15c/0xda0

This is a strange place to get the issue from. And this is a new
issue.

> [  488.151939][  T670]  kthread+0x3ac/0x460
> [  488.155854][  T670]  ret_from_fork+0x10/0x18
> [  488.160120][  T670] Code: 911e8000 aa1303e1 910a0000 941b595b (d4210000)
> [  488.166901][  T670] ---[ end trace e637e2d38b2cc087 ]---
> [  488.172206][  T670] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [  488.179182][  T670] SMP: stopping secondary CPUs
> [  489.209347][  T670] SMP: failed to stop secondary CPUs 0-1,10-11,16-17,31
> [  489.216128][  T][  T670] Memoryn ]---

Can you give details on what exactly did you try to do, to get this ?
Normal boot or something more ?

I have made some changes to the way calls were happening, may get this
thing sorted. Can you please try this branch ?

https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/cppc

I can see one place where race can happen, i.e. between
topology_clear_scale_freq_source() and topology_scale_freq_tick(). It
is possible that sfd->set_freq_scale() may get called for a previously
set handler as there is no protection there.

I will see how to fix that. But I am not sure if the issue reported
above comes from there.

Anyway, please give my branch a try, lets see.

-- 
viresh
