Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E8114108
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 13:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfLEMzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 07:55:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44880 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLEMzu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 07:55:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so2382547lfa.11;
        Thu, 05 Dec 2019 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qiyn/834OJWIRhu0XZvdM5LzzzV2eZ2ASR6H3Xv50k=;
        b=sdPdpqV7eZ51owcp/denn3Sm5zZ52nNuZOo5AfbnXgCxUXN/N/dRX9HG8ORXYLqahg
         eeczwMorTzAhvIod8GQef1C1W/HrnTKnghCluMfqBmOVI5zmKof9JgQDcSsoOjwa8prD
         l6Mayp1+sR1N+CfiKvIfJ/unPu/bXHcr3zlqk1ykZa5vHdBPsZFe/SGsYhhBS8RDsMu5
         NIkYcgs0e8dgo+0pC06ohP95GCLjLXfLa5LYGGYR1DcECnYlKRRdKnFOO8HnuTojjWnM
         05ZC3FfDdILf1bcrX4ThjZwbIw2UA5QuhUTmTgkM1VzNAUk9tVUvFSkx7ucBqjsI6HOU
         zdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qiyn/834OJWIRhu0XZvdM5LzzzV2eZ2ASR6H3Xv50k=;
        b=ItAFdVgWGZjQyPFixNzYMdjSv6oXTrREquYsNe2EYzqkQZZijedU9IVpn+Sz+Q0+QP
         Tj8QnjhApT+4TDwSJ2878La/YQB2eNKcKl5+j74G3cFqrqg/vNZdeYZB2mdgPtJ8MiGK
         cCf6nV3OF9x4w+k3LXfJhH4M+B6+1G3dFXLsS3HOzBJ49XwlzN3iwxhD3RJE0c2vOC+T
         N2sBzvzZskFprjE54ArmKGYv5ZyzG7SVShWkRx4yz6ZgwbtREvWhrv9Xp5PQkp/9Xx41
         dVOJlBOaarMLk9wqyq32077o9KSRjHEbQFjy0yMoLVmA1JYSlfMJkb8x5DwBrlGU7GkN
         wcrw==
X-Gm-Message-State: APjAAAWk9Nc8YKT54/O1v1XpSCs10jRir4d2y+Pp9fz6D3KiXpN5qz/N
        NxLhNVRj2tjEIf9j+DiibKc=
X-Google-Smtp-Source: APXvYqxQzn85bdWHUVxwXHtYVTF2R4LVHB0a0B7sZChjdjhVRMnoFP3Z/9lPLRLhcH2/1eQ27Rd3gw==
X-Received: by 2002:ac2:5a43:: with SMTP id r3mr5399483lfn.150.1575550547868;
        Thu, 05 Dec 2019 04:55:47 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e9sm1824997ljp.87.2019.12.05.04.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 04:55:46 -0800 (PST)
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sumitg <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
 <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
 <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
 <0b634341-ea2b-e9cd-4986-dc9a01c839bb@gmail.com>
 <20191205025125.imxnao2qwyons5zl@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c26ed467-0e30-900b-4e69-762ee83e8377@gmail.com>
Date:   Thu, 5 Dec 2019 15:55:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205025125.imxnao2qwyons5zl@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.12.2019 05:51, Viresh Kumar пишет:
> On 04-12-19, 16:57, Dmitry Osipenko wrote:
>> 04.12.2019 14:27, Viresh Kumar пишет:
>>> On 04-12-19, 16:25, sumitg wrote:
>>>> In T194, CCPLEX doesn't have access to set clocks and the
>>>>
>>>> clk_{get|set}_rate() functions set clocks by hook to BPMP R5.
>>>>
>>>> CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).
>>>>
>>>> As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is
>>>>
>>>> used to read the counters and calculate "actual" cpu freq at CCPLEX.
>>>>
>>>> So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not
>>>>
>>>> given by node "scaling_cur_freq".
>>>
>>> Right, but why can't this be hidden in the CPU's clk driver instead,
>>> so cpufreq driver can just do clk_get_rate() and clk_set_rate() ?
>>
>> What about to make use of dev_pm_opp_register_set_opp_helper()?
> 
> It has a different purpose where we have to play with different
> regulators. And that won't help with clk_get_rate() anyway.

Indeed that won't help with the clk.
