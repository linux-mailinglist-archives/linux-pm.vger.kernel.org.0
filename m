Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBFB112D0C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 14:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfLDN55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 08:57:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44709 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfLDN55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 08:57:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so8159610lji.11;
        Wed, 04 Dec 2019 05:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLSQXMzVG7swZ/e2rtQnLP6u3joRR7UaM1wgCcu+ICA=;
        b=GBCEQDEd/RigkNNY6V8k56hcEXgv1oGrqA4Sk5jqPw9gRxAUoE6DSV4wgmVobAmjiO
         y/hMq98ujSr9yJ0waZF6+f6Dl7e3iUTI+opAqkfR6JDRqrwIlXYKKzZBc9n0WCEbbUsr
         JVNTa0iNMbKl8A776pXac0EnqUthD73y2pmukSmXhsx12C6/iWRzcR6vGs3+q12lqRYJ
         Hxm67bi8j//nv+B6fjEDLYGDuDFfDhy6wJp6Af4aM/J7ctH4MudCyQkpFTfBUtILYbJa
         xGBWDBAGV+s6WPAk9/v9/xhnX4KSwmDDKKJgXBBjBtlwkXL9/3KXHGB5w4M3wBdcFtxO
         RhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLSQXMzVG7swZ/e2rtQnLP6u3joRR7UaM1wgCcu+ICA=;
        b=snhY7uKywy+nedy+YKdN6WLfNHKt7lVdcvV29pGQIoTAqTUgTgkSM77xnO3HW8JTWb
         thgwD2tOHsA63A2b13wv+JpH5MPnCv7OGv6FtRYv9pzSDRr2tVMm+e9S2zfgTHLJ0kGQ
         liH8lF/TXfElXHLS4AuHBxNF6yO3hH09FvOZ4C3GDV4/fW+eJoS3EjwkHwEuuowBdj0T
         V9zwtSNwXaVtPl07HFMOsOPlUoBhj4tG833w1uyzp22CvgsmWrTcSfitj+MtMelL/ga8
         fwYCN9e62mX0Np/6X+lXKrYm0cZoxxWwSvzy+kh0HaPGAuc5gbfj6GUqBdiYHvM/JIyK
         Irmg==
X-Gm-Message-State: APjAAAVZ5cXYZXRNZT661/nox53hD8q12r5dqxe0HrzU7d0ChMgcfzM0
        dbd6BP40eUAwfvmUyUgvUjqik148
X-Google-Smtp-Source: APXvYqwPUyYNLY1YxBHRZjdAA1FL89xaYpCwqzoggRVxnCZoi49/FwzOsVjl7zgNf1dRjeX2HDj4Mw==
X-Received: by 2002:a05:651c:32a:: with SMTP id b10mr2142347ljp.132.1575467875071;
        Wed, 04 Dec 2019 05:57:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y23sm3238750ljk.6.2019.12.04.05.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 05:57:54 -0800 (PST)
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>, sumitg <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
 <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
 <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b634341-ea2b-e9cd-4986-dc9a01c839bb@gmail.com>
Date:   Wed, 4 Dec 2019 16:57:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.12.2019 14:27, Viresh Kumar пишет:
> On 04-12-19, 16:25, sumitg wrote:
>> In T194, CCPLEX doesn't have access to set clocks and the
>>
>> clk_{get|set}_rate() functions set clocks by hook to BPMP R5.
>>
>> CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).
>>
>> As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is
>>
>> used to read the counters and calculate "actual" cpu freq at CCPLEX.
>>
>> So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not
>>
>> given by node "scaling_cur_freq".
> 
> Right, but why can't this be hidden in the CPU's clk driver instead,
> so cpufreq driver can just do clk_get_rate() and clk_set_rate() ?

What about to make use of dev_pm_opp_register_set_opp_helper()?


>>> - populating cpufreq table, you can probably add OPPs instead using
>>>    the same mechanism
>>
>> We are reading available frequencies from BPMP to populate
>>
>> cpufreq table and not using static opp table.
> 
> Right and lot of other platforms read it from firmware (I believe BBMP
> is a firmware here), and create OPPs at runtime. Look at this for
> example:
> 
> drivers/cpufreq/qcom-cpufreq-hw.c
> 
> and search for dev_pm_opp_add().
> 

