Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6283B218A1B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgGHOZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 10:25:10 -0400
Received: from foss.arm.com ([217.140.110.172]:43460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbgGHOZJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 10:25:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F7F61FB;
        Wed,  8 Jul 2020 07:25:09 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5A703F237;
        Wed,  8 Jul 2020 07:25:05 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] PM / devfreq: Add delayed timer for polling
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     k.konieczny@samsung.com, krzk@kernel.org, kgene@kernel.org,
        s.nawrocki@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742@epcas1p1.samsung.com>
 <20200703062622.11773-1-cw00.choi@samsung.com>
 <20200703123346.6fy6i33ks6nox46a@macmini.local>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a3339c58-6350-9298-6053-9dc021170048@arm.com>
Date:   Wed, 8 Jul 2020 15:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200703123346.6fy6i33ks6nox46a@macmini.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Willy,

On 7/3/20 1:33 PM, Willy Wolff wrote:
> Hi Chanwoo,
> 
> I think it doesn't help on the benchmark I suggested that is doing only memory
> accesses. With both timer, I have the same timing.
> 
> To test the benchmark with these new patches about timer:
> 
> git clone https://github.com/wwilly/benchmark.git \
>    && cd benchmark \
>    && source env.sh \
>    && ./bench_build.sh \
>    && bash source/scripts/test_dvfs_mem_patched.sh
> 
> The benchmark is set by default to run for 1s, but you can increase this by
> tweaking the script as:
> 
> taskset 8 ./bench_install/bin/microbe_cache 33554431 0 9722222 <TIME in sec> ${little_freq}
> 
> 
> Also, as I reported the issue, would it be possible to add a
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com> ?
> Many thanks in advance.

Thank you for your good work and the benchmark. I hope you will continue
to use it and report some issues. I am going to send a follow up patches
for the DMC and I will add your 'Reported-by'. In the tests I can see
the improvements, but it's worth to consult with you if I understand
the new results correctly.

I think there is still some area for improvements in the devfreq and you
could find the interesting bits to contribute.

Regards,
Lukasz

> 
> 
> Best Regards,
> Willy
> 
