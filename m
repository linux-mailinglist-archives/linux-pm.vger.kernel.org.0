Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C8446D0D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhKFJBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Nov 2021 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhKFJBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Nov 2021 05:01:19 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D9C061570;
        Sat,  6 Nov 2021 01:58:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u7so9395351qtc.1;
        Sat, 06 Nov 2021 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bxE33X7IpWFgB70FZ2MS1BI8JfapENi/edcV5iiJbfY=;
        b=RuvAuuwfg1DfQC1URohNu1SQxElJJcbJYxfUIJK+OJ2PMbX8dBuAeaVT5BKEKtOVZC
         mCe6qKQRQgO91dvHs/OejpBmFpmVaJ483106Y0hchbUiGUYuEXODyKtHwt8v/sR5YOMp
         P0DfJ59yqeF2orzRYuNg8RWR7XTiXu+gheBBpKRHM5Xr77QDuWz3BohnJKnczRE8vuz7
         9CHjvSM26MQVfxGpxC3Iq1Hw0ZOg9epUZiWiswxcPTfcAtDtMsNnQ8G1GGRLnM0oQUZ4
         tolrX4GW6Hb4Ja/8jts4+cBH3sVs8yB9LLGUCPWbf+NuBqBKANOIh/BMqQ5FJ/CKSaVq
         gdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bxE33X7IpWFgB70FZ2MS1BI8JfapENi/edcV5iiJbfY=;
        b=2dzYGkHKBjHuQFky5L2EX4C4oLrJtVW3W52I1ckGBIJUTDsoOEzj3JiMp/ve6opjxa
         uowo/oy0ANDZDXdofLxNQFunog0aNiNoIQsiaXXH0Vd9aZI1mlJ65lk8l4bCUq1miFC+
         7com7Hr1Qci8xfUS6Hrj0A6JMwY+ogu7seooKjTYfNN+sPID5+x/nIVummTWq0Q9JPa2
         LDjhLBo9UwJXqbjrRh7pFzfSXBjyFmFyk6E/QlR3ZwoijneDFX4c68qUu0lrgaMsJedy
         uJE/uCv563Miy9SCQwIwaC5qAK4dM3KfGAsP+WpwatdDZpyq+JwtRiCuENZFMP4OMaYA
         G0gw==
X-Gm-Message-State: AOAM532XQ6NykOxuMMMNW18QBaA1Hd6PYo5B+3VBJRZMswfpiwkNsVum
        8LUsXPd6kynl+c5InP6Q0Lk=
X-Google-Smtp-Source: ABdhPJwXmrMAm0F0448vH72ueurSUK2mnx+q5lZomnfDhrtDDOPD1cWmpyQI2btss0+TD9NWo7cyTA==
X-Received: by 2002:ac8:4e94:: with SMTP id 20mr52827929qtp.150.1636189117045;
        Sat, 06 Nov 2021 01:58:37 -0700 (PDT)
Received: from [192.168.0.40] ([162.245.63.85])
        by smtp.gmail.com with ESMTPSA id v17sm6817912qkl.123.2021.11.06.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 01:58:36 -0700 (PDT)
Message-ID: <f9323c6fddd4a55d8ca4191a9539ebd056221045.camel@gmail.com>
Subject: Re: [PATCH v3 00/21] cpufreq: introduce a new AMD CPU frequency
 control mechanism
From:   Matt McDonald <gardotd426@gmail.com>
To:     Huang Rui <ray.huang@amd.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Date:   Sat, 06 Nov 2021 04:58:35 -0400
In-Reply-To: <YYVXV/sCbO0mPVK2@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
         <a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz>
         <YYVXV/sCbO0mPVK2@hr-amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > I've tested this driver and it seems the results are a little
> > underwhelming.
> > The test machine is a two sockets server with two AMD EPYC 7713,
> > family:model:stepping 25:1:1, 128 cores/256 threads, 256G of memory
> > and SSD
> > storage. On this system, the amd-pstate driver works only in
> > "shared memory support", not in "full MSR support",
> > meaning that frequency switches are triggered from a workqueue
> > instead of scheduler context (!fast_switch).

Huang, I've also done some detailed testing, and while many synthetic
benchmarks seem to show minimal differences between this new frequency
control mechanism and acpi_cpufreq, the general user experience seems a
bit degraded, but most of all, gaming performance in many instances (if
not all) is cut in half. Fully half. 

I have an RTX 3090 and a Ryzen 9 5900X, with 32GB (4x8) DDR4 3600. In
Control with DLSS and RT enabled, on 5.15.rc5 with acpi_cpufreq, I get
120-130 fps at 1440p. The same exact kernel with v3 of AMD_CPPC gives
me 50 fps. GPU usage is still at 100, but the CPU frequency is being
reported as like 5100Mhz*, and other assorted weirdness, but most
importantly the fps is stuck at 50. This is regardless of performance
scheduler (schedutil, ondemand, userspace or performance). 

*My CPU can indeed boost over 5GHz on a single core here and there, but
this was constant and on all cores, so clearly it wasn't accurate.

Also, from the documentation it looks like there's supposed to be a way
to fall back to acpi_cpufreq, but I found no such way to do that. If
AMD_CPPC was built into the kernel, I had to use amd-pstate, there was
no other option. Maybe I misinterpreted and acpi-cpufreq is only able
to be used as a fallback for CPUs that don't support amd-pstate.

I know that gaming on Linux hasn't historically been one of AMD's
priorities with their CPUs, but with the Steam Deck upcoming I would
imagine this is a pretty important use-case, and I've tested multiple
games and they all lose a full 50% performance. I'm happy to test any
revisions or even kernel parameters or whatever else to try and get
this sorted. 



> Would you mind that we add a module param or filter the known good
> processors (mobile parts) to load amd-pstate. And others can use the
> param
> to switch between amd-pstate and acpi-cpufreq manually? After we
> address the
> performance gap, then we can switch it back.


This would be something I would be interested to try.

> 
> It seems the issue mainly from the processors with big number of
> cores and
> threads. Let's find the similiar family threadripper or EYPC
> processors to
> duplicate the test results. Will contact at you for details. :-)

This may be an interesting route of investigation, I could potentially
try running a game with `taskset -c 0-7` or something similar. 

> 

