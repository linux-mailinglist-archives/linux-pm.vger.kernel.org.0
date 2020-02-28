Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983511735C2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 12:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1K74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 05:59:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58863 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1K74 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 05:59:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200228105953euoutp0183075da0bc84b647720e7dd12a32b048~3i_FTxeEk0763307633euoutp01Z
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 10:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200228105953euoutp0183075da0bc84b647720e7dd12a32b048~3i_FTxeEk0763307633euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582887593;
        bh=BguuZDvU6azV9XPd525Wmqpvtk9ygCrcA613uyM+G5Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hrwoIBQpAYkIZgiSnHkKnOXeVkhK7W2rOeMhBPlF3G8Gzv+yXTwtEGPhpV/QL1w8o
         anKByvciWGUSAerf64ECvEw90Df5Uq7UUAYo7K2NbDFxZnjAE2t8ejcrGs152Dl34z
         bKk2T54p9OsUbwC93Ufm7Xpa4gIymrPG4TF7Xvrw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200228105953eucas1p1de6c97755e10841e0e712e9bcd5ef945~3i_E-rSCe2307623076eucas1p1T;
        Fri, 28 Feb 2020 10:59:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.7F.61286.9A2F85E5; Fri, 28
        Feb 2020 10:59:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200228105953eucas1p111c667e8841ec152ecf3e302e736e9cc~3i_EqURnN2315323153eucas1p1s;
        Fri, 28 Feb 2020 10:59:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200228105953eusmtrp2979943f68ef2c63a3bad0952dfd31cf8~3i_Epf7ZV2783027830eusmtrp2Y;
        Fri, 28 Feb 2020 10:59:53 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-4b-5e58f2a978da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.0C.08375.9A2F85E5; Fri, 28
        Feb 2020 10:59:53 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200228105952eusmtip1e43ebe3dfd0ade530835a9ffade7a889~3i_D3ig_a2996329963eusmtip1F;
        Fri, 28 Feb 2020 10:59:52 +0000 (GMT)
Subject: Re: [RESEND PATCH v2 0/2] Enable Odroid-XU3/4 to use Energy Model
 and Energy Aware Scheduler
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dietmar.eggemann@arm.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fb6961ce-846e-3c26-5227-6327c6d511f6@samsung.com>
Date:   Fri, 28 Feb 2020 11:59:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <597f1475-754c-d77a-b599-0fa07d8ee948@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87orP0XEGcx6LG+xccZ6VovrX56z
        Wsw/co7V4umErcwW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWSxsamG3
        WHr9IpPF7cYVbBate4+wO/B7rJm3htFj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI
        3y6BK+P/tC8sBWc1K3YsesXcwNiu3MXIySEhYCLRceoKYxcjF4eQwApGidZ/v6CcL4wSy3Yv
        YgGpEhL4DJR5XwjT8WDyHzaI+HJGifkTvCAa3jJKPLz8nx0kISyQLvF99QWgSRwcIgI+Ekte
        q4PUMAs8ZZLYcO4dK0gNm4ChRNfbLrBBvAJ2EvPPLWMCsVkEVCWaztwCi4sKxErMXnmYBaJG
        UOLkzCdgNqeAtcS+yR1g9cwC8hLNW2czQ9jiEreezGeCOPQtu8TtwxEQtovE+/UnGCFsYYlX
        x7ewQ9gyEv93gtRzAdnNQA+cW8sO4fQwSlxumgHVYS1x59wvNpBvmAU0Jdbv0ocIO0qs+PaZ
        BSQsIcAnceOtIMQNfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzULy2Swk38xC8s0s
        hL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKaz0/+Of9rB+PVS0iFGAQ5GJR7e
        BTvC44RYE8uKK3MPMUpwMCuJ8G78GhonxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0
        xJLU7NTUgtQimCwTB6dUA2NH957LmUe2/9klp6C3VXPm/fPXFte6iLznucOz1kg7XdVKkvX6
        guX7PvOwvjrtMr9lqXft8t8sr+cczjnh+l4+M3338uNHGm/qHDr8+5p6d5lJzq78qfETE9zU
        mtLWHY1V7X9yLothQVfi9x7VD+cu/jmkuHJtbhxfyY6Wg+0n1Ep2zTOWWPZTiaU4I9FQi7mo
        OBEA8Q0Ao2MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7orP0XEGRx5z2WxccZ6VovrX56z
        Wsw/co7V4umErcwW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWSxsamG3
        WHr9IpPF7cYVbBate4+wO/B7rJm3htFj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+P/tC8sBWc1K3YsesXc
        wNiu3MXIySEhYCLxYPIfti5GLg4hgaWMEt+7drNAJGQkTk5rYIWwhSX+XOtiA7GFBF4zSjyd
        JgxiCwukS7ScPwFUz8EhIuAjseS1OsgcZoGnTBLvV8xhhKh/yCjRcNEQxGYTMJToegsxh1fA
        TmL+uWVMIDaLgKpE05lbYHFRgViJGzM7mCBqBCVOznwCdg+ngLXEvskQcWYBM4l5mx8yQ9jy
        Es1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+
        7iZGYARvO/Zz8w7GSxuDDzEKcDAq8fAu2BEeJ8SaWFZcmXuIUYKDWUmEd+PX0Dgh3pTEyqrU
        ovz4otKc1OJDjKZAz01klhJNzgcml7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2amp
        BalFMH1MHJxSDYxMPIkRPhLaTtcN9f3X9N7fce0bR9CspqL0t4GVz5tSag+dfyZRlxiy9pzb
        2ov28kuLUtepTZ18YqbevPNKTB5vHyza1vvwvJHl+/vvD299PfvUZpbs11kzDN9cjdSvz+xW
        O6E3/3ZX8/d356xqOVa2ekg6/bTo2ny2oHNuuqeT7sbFpw68V7qrxFKckWioxVxUnAgAtmO/
        1/YCAAA=
X-CMS-MailID: 20200228105953eucas1p111c667e8841ec152ecf3e302e736e9cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200221103307eucas1p2bc51b3b5d6d0a9739ab97cdd39078505
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200221103307eucas1p2bc51b3b5d6d0a9739ab97cdd39078505
References: <20200220095636.29469-1-lukasz.luba@arm.com>
        <20200220180040.GA8338@kozik-lap>
        <CGME20200221103307eucas1p2bc51b3b5d6d0a9739ab97cdd39078505@eucas1p2.samsung.com>
        <597f1475-754c-d77a-b599-0fa07d8ee948@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz

On 21.02.2020 11:32, Lukasz Luba wrote:
> On 2/20/20 6:00 PM, Krzysztof Kozlowski wrote:
>> On Thu, Feb 20, 2020 at 09:56:34AM +0000, Lukasz Luba wrote:
>>> This is just a resend, now with proper v2 in the patches subject.
>>>
>>> The Odroid-XU4/3 is a decent and easy accessible ARM big.LITTLE 
>>> platform,
>>> which might be used for research and development.
>>>
>>> This small patch set provides possibility to run Energy Aware 
>>> Scheduler (EAS)
>>> on Odroid-XU4/3 and experiment with it.
>>>
>>> The patch 1/2 provides 'dynamic-power-coefficient' in CPU DT nodes, 
>>> which is
>>> then used by the Energy Model (EM).
>>> The patch 2/2 enables SCHED_MC (which adds another level in 
>>> scheduling domains)
>>> and enables EM making EAS possible to run (when schedutil is set as 
>>> a CPUFreq
>>> governor).
>>>
>>> 1. Test results
>>>
>>> Two types of different tests have been executed. The first is energy 
>>> test
>>> case showing impact on energy consumption of this patch set. It is 
>>> using a
>>> synthetic set of tasks (rt-app based). The second is the performance 
>>> test
>>> case which is using hackbench (less time to complete is better).
>>> In both tests schedutil has been used as cpufreq governor. In all tests
>>> PROVE_LOCKING has not been compiled into the kernels.
>>>
>>> 1.1 Energy test case
>>>
>>> 10 iterations of 24 periodic rt-app tasks (16ms period, 10% duty-cycle)
>>> with energy measurement. The cpufreq governor - schedutil. Unit is 
>>> Joules.
>>> The energy is calculated based on hwmon0 and hwmon3 power1_input.
>>> The goal is to save energy, lower is better.
>>>
>>> +-----------+-----------------+------------------------+
>>> |           | Without patches | With patches           |
>>> +-----------+--------+--------+----------------+-------+
>>> | benchmark |  Mean  | RSD*   | Mean           | RSD*  |
>>> +-----------+--------+--------+----------------+-------+
>>> | 24 rt-app |  21.56 |  1.37% |  19.85 (-9.2%) | 0.92% |
>>> |    tasks  |        |        |                |       |
>>> +-----------+--------+--------+----------------+-------+
>>>
>>> 1.2 Performance test case
>>>
>>> 10 consecutive iterations of hackbench (hackbench -l 500 -s 4096),
>>> no delay between two successive executions.
>>> The cpufreq governor - schedutil. Units in seconds.
>>> The goal is to see not regression, lower completion time is better.
>>>
>>> +-----------+-----------------+------------------------+
>>> |           | Without patches | With patches           |
>>> +-----------+--------+--------+----------------+-------+
>>> | benchmark | Mean   | RSD*   | Mean           | RSD*  |
>>> +-----------+--------+--------+----------------+-------+
>>> | hackbench |  8.15  | 2.86%  |  7.95 (-2.5%)  | 0.60% |
>>> +-----------+--------+--------+----------------+-------+
>>>
>>> *RSD: Relative Standard Deviation (std dev / mean)
>>
>> Nice measurements!
>
> Glad to hear that.
>
>>
>> Applied both, thank you.
>>
>
> Thank you for applying this.


After applying the patches I see the following warnings during boot (XU4):

energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 1 >= em_cap_state0
energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 3 >= em_cap_state2
energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 4 >= em_cap_state3
energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 5 >= em_cap_state4
energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 8 >= em_cap_state7
energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 10 >= em_cap_state9
energy_model: pd0: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 11 >= em_cap_state10
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 1 >= em_cap_state0
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 2 >= em_cap_state1
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 3 >= em_cap_state2
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 4 >= em_cap_state3
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 5 >= em_cap_state4
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 6 >= em_cap_state5
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 8 >= em_cap_state7
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 9 >= em_cap_state8
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 10 >= em_cap_state9
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 13 >= em_cap_state12
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 15 >= em_cap_state14
energy_model: pd4: hertz/watts ratio non-monotonically decreasing: 
em_cap_state 16 >= em_cap_state15

Is it okay?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

