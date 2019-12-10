Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2D11810A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 08:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLJHFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 02:05:40 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41920 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfLJHFj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 02:05:39 -0500
Received: by mail-pg1-f175.google.com with SMTP id x8so8427573pgk.8
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 23:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UKgD5HDTPtH6cr1QNlP2BuIxHtwVylqxIvFMWJP7XGo=;
        b=cax7V5fRvUSrLcLm9J9IQL6Cbsg2PeoJiqrJYcRHfZO4gFZGHGZkqfmrcd90/HXu0W
         N2vRQhDwzLoTxMw3Y0fMGat7ueVrlM8HURvXXehW+fXYx+WKYd7hFUt3IufJsF1192ta
         trczygsp7/Fj5S8F57t3XZLpTPB3olVKBrvvXNgXEM7xWpZpjZh8N0dvWxJJjjdzdVfW
         onpyMFrs6GPCp0tPfDrcGBR11khXyS26Ss0J5DWVbhyIvAz6+XvJGhhjc6/V8velLYYq
         Ni3w1z8uI9qTfld6wMsZOA9b5M7KWrdKjYNVVdgPOnlw3oHUZhRvddwREEWoq5gyek5O
         0BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKgD5HDTPtH6cr1QNlP2BuIxHtwVylqxIvFMWJP7XGo=;
        b=DsEdi9JbBv931ooRtk3x0Wc3gRA82IMKIcaD5NOHvPkQdA/Fenvqy/JiT+5Pps2Pwy
         eTf5M/McX6oh7OBNrjGeZjETtG04PXHdBYkcbaRJ4es7qe1rIYIita26Pj69qGEm/RdZ
         sJznOVZg0xdPpvEPr0N5I6tcoUGrZ3iQvNFqiB5gSbGuy0yXUS97ECp4auNmZ3IxUIMB
         51nFN7XwTUT12AGUPU4h0TCDaQTTbk6rk5FF0SgRC4bZHftowwMqdHwOTqL3UDz5CB0g
         V8OGsGPtBJfy6KcfA81Jui5g4cx+2uBAxTRo2dAvw9kas+fVqWLjhCY0TXqQYIkZLah3
         LLXw==
X-Gm-Message-State: APjAAAUgUuO1ZWaWwe9iJ+BAD2hsavWyrjQIsZwENeK9CxW82aOUZqQj
        ZXWs7bY5w3ZE6Js15e4RLMkctQ==
X-Google-Smtp-Source: APXvYqzi6iA9lYmaWZ2yBV5E83kfR+8EFR+QIMS8Crk3wwEGHpTGNb4++LwV1rNZztohbLyiIefXsQ==
X-Received: by 2002:a63:48d:: with SMTP id 135mr22884471pge.66.1575961538922;
        Mon, 09 Dec 2019 23:05:38 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id 200sm1834782pfz.121.2019.12.09.23.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 23:05:37 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:35:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        vincent.guittot@linaro.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher>
 <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+few more guys

On 10-12-19, 05:53, Peng Fan wrote:
> But per https://elixir.bootlin.com/linux/v5.5-rc1/source/kernel/sched/sched.h#L2293
> cpu_of(rq) and smp_processor_id() is possible to not the same,
> 
> When cpu_of(rq) is not equal to smp_processor_id(), dbs_update_util_handler
> will use irq_work_queue to smp_processor_id(), not cpu_of(rq). Is this
> expected?
> Or should the irq_work be queued to cpu_of(rq)?

Okay, sorry for the long weekend where I couldn't get time to reply at all.

First of all, lets try to understand dvfs_possible_from_any_cpu.

Who can update the frequency of a CPU ? For many architectures/platforms the
eventual code that writes to some register to change the frequency should only
run on the local CPU, as these registers are per-cpu registers and not something
shared between CPUs.

But for the ARM architecture, we have a PLL and then some more registers to play
with the clk provided to the CPU blocks and these registers (which are updated
as a result of clk_set_rate()) are part of a block outside of the CPU blocks.
And so any CPU (even if it is not part of the same cpufreq policy) can update
it. Setting this flag allows that and eventually we may end up updating the
frequency sooner, instead of later (which may be less effective). That was the
idea of the remote-wakeup series. This stuff is absolutely correct and so
cpufreq-dt does it for everyone.

This also means that the normal work and irq-work both can run on any CPU for
your platform and it should be okay to do that.

Now, we have necessary measures in place to make sure that after stopping and
before starting a governor, the scheduler hooks to save the cpufreq governor
pointer and updates to policy->cpus are made properly, to make sure that we
never ever schedule a work or irq-work on a CPU which is offline. Now it looks
like this isn't working as expected and we need to find what exactly is broken
here.

And yes, I did the testing on Hikey 620, an octa-core ARM platform which has a
single cpufreq policy which has all the 8 CPUs. And yes, I am using cpufreq-dt
only and I wasn't able to reproduce the problem with mainline kernel as I
explained earlier.

The problem is somewhere between the scheduler's governor hook running or
queuing work on a CPU which is in the middle of getting offline/online and there
is some race around that. The problem hence may not be related to just cpufreq,
but a wider variety of clients.

-- 
viresh
