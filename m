Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAB2AB876
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 13:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKIMmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 07:42:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58869 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgKIMmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 07:42:38 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201109124224euoutp01b559689aab9cd53ac65b19f76a5737da~F13YLDG_N2049220492euoutp01h
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 12:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201109124224euoutp01b559689aab9cd53ac65b19f76a5737da~F13YLDG_N2049220492euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604925744;
        bh=t2wsra6pFjd1kLeiYQLJvry2jPgGLVeGgWlbciJIw4E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZvibdLEby3Q65dOGpdg6aP2eH4G/ilUlcsx57H0wIq2rqmCGzr1F2NIzu2pgJeO/a
         Ddu/LobCig/cxVUaKcO8ZE5d+x7NUOjWpiEpabaVh6iar16SYBBQvINracIcCmaIq2
         Y8QiuCc1dKmFr3UaczvD8Qa/WvEyW2eD21egO328=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201109124218eucas1p1e0131db319a18a51d0c453783b02058c~F13TOei4n2417324173eucas1p1O;
        Mon,  9 Nov 2020 12:42:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.AE.06456.A2939AF5; Mon,  9
        Nov 2020 12:42:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8~F13S35i4X2139221392eucas1p1a;
        Mon,  9 Nov 2020 12:42:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201109124218eusmtrp1bf9ebbed4d530f96db5c05157ce7158e~F13S3L83I3056130561eusmtrp1I;
        Mon,  9 Nov 2020 12:42:18 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-f0-5fa9392adb12
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.BC.06017.A2939AF5; Mon,  9
        Nov 2020 12:42:18 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201109124217eusmtip2b3ae529bb7e2f30616335522231b56ac~F13SWnOLY2205422054eusmtip2d;
        Mon,  9 Nov 2020 12:42:17 +0000 (GMT)
Subject: Re: [PATCH 1/2] cpufreq: dt: Don't (ab)use
 dev_pm_opp_get_opp_table() to create OPP table
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2924bddd-d237-aa57-abb1-a67723770e97@samsung.com>
Date:   Mon, 9 Nov 2020 13:42:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuTOzs+Pi6rhanjQS1ogy1LY0JhJ7EDaVQRBBBalrjg90NXZ8
        ZFRoktViZRakk+YDKlvRWjHN1URF3WrVYn0gpoYkgZZFboqZaY1j5X+/797v3HO+w6VwlUXm
        QcUlJnP6RG2CmlQQtR0/un19djwO3zJ5P5Ax5T+RMRXfPiCmx1xIMvbrbYj5PNuFMZ1Wm4xZ
        6DcRzEBRAHO1bQZnTNPsbgWbXbKLrReG5Wy18RrJDvU3kmxN3xWCvVFjRKxloA5j7dXrjlAn
        FUFRXEJcKqf3D45QxNa8zyTOvFp7dkC4hWUgAQzIgQI6AFrG2wkDUlAquhyBaTaDlMR3BLnm
        TlwSdgR9Y1N/BLVUUlYM0vkjBDl19ZgkviKYG/klF991paOg4WYGEtmNPgYV5YNINOF0IQbV
        maNLJpLWgGHSQIqspINhpH5eJjJBrwdrbwMu8io6En7Z53HJ4wKvCsYIkR3oMOhrasJExmkv
        yHp2D5fYHQbHipcmAnpQDj8LmjEp6T4wf7osl9gVJiw1y7wWrLdzCKkgC8Fod6VcEjkIei7l
        I8m1E4a650hxATi9CZ6Y/aXjPTA+U0lKe3GCgUkXaQgnyKu9u7wuJVzNVknuDSBYqv61bXlr
        w3ORWlgRTVgRR1gRR/jftwQRRuTOpfC6GI7XJHJpfrxWx6ckxvidTtJVoz/fy7pgmXqOpm2R
        rYimkNpR2Tz/MFwl06by6bpWBBSudlPu7bKGqZRR2vRznD4pXJ+SwPGtyJMi1O7KbWXjp1R0
        jDaZi+e4M5z+7y1GOXhkoLpr3ryXT9i7iGjC8+jT0O3zeQdDe4KKBfL1ROODhs7e1DeLZTlf
        VqvO20IuVnYHdpUWx1sOv27HNh5YDI+O2JBNvos2taxx9PqIaZJOpPhu3o09NDobiDTZnaLS
        eu9nw3HsrK025OWLRaNnknOfk3mHbuv+Q12h0x0FF7YxEVXH1QQfq9X44Hpe+xuFDfLDWgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7palivjDc7vkLPYOGM9q8Xqj48Z
        LS7vmsNm8bn3CKPFmx9nmSzOnL7EavHv2kYWixtzTSw6jnxjttj41cOBy6Ntgb3Hzll32T02
        repk87hzbQ+bx5ar7SwefVtWMXocv7GdyePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sL
        PSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jC33G1kKTspU3Jg1kamBcZZEFyMHh4SAicSi
        +UAmF4eQwFJGiUd777N3MXICxWUkTk5rYIWwhSX+XOtigyh6yygx5ecLRpCEsECKxIOnZ1lA
        bBGBUImjU7+CNTMLzGGSWNXHD2ILCcRK3P/xig3EZhMwlOh62wVm8wrYSdzb+QdsAYuAisTp
        K7uZQWxRgSSJlxemMkHUCEqcnPkEbD6nQJzE1X37mCDmm0nM2/yQGcKWl2jeOhvKFpe49WQ+
        0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiN127GfW3Yw
        dr0LPsQowMGoxMN74M+yeCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQF
        em4is5Rocj4wieSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBc
        fvXXp0sznoa0VC0U0dNd+MemxP5Lwa8JrfwXbKcui1yg1Tn1AeP6uIZTk4q+KGc0bFeunb7S
        fK5jR8Mk4bJvm4ONiwuO//9vuFjaJzNCuLV5tuC7/TVfX5z/pVD2ULmm/LlmVuavqFD5xV/F
        L7PVFFho/pHcFtt42Zb/iYaQVPDab+tzMmcqsRRnJBpqMRcVJwIAWKZu/OoCAAA=
X-CMS-MailID: 20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
        <CGME20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 06.11.2020 07:24, Viresh Kumar wrote:
> Initially, the helper dev_pm_opp_get_opp_table() was supposed to be used
> only for the OPP core's internal use (it tries to find an existing OPP
> table and if it doesn't find one, then it allocates the OPP table).
>
> Sometime back, the cpufreq-dt driver started using it to make sure all
> the relevant resources required by the OPP core are available earlier
> during initialization process to properly propagate -EPROBE_DEFER.
>
> It worked but it also abused the API to create an OPP table, which
> should be created with the help of other helpers provided by the OPP
> core.
>
> The OPP core will be updated in a later commit to limit the scope of
> dev_pm_opp_get_opp_table() to only finding an existing OPP table and not
> create one. This commit updates the cpufreq-dt driver before that
> happens.
>
> Now the cpufreq-dt driver creates the OPP and cpufreq tables for all the
> CPUs from driver's init callback itself.
>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This patch landed in linux next-20201109 as commit e8f7703f8fe5 
("cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP 
table"). Sadly it causes regression on some Samsung Exynos based boards:

8<--- cut here ---
Unable to handle kernel paging request at virtual address ffffff37
pgd = (ptrval)
[ffffff37] *pgd=4ffff841, *pte=00000000, *ppte=00000000
Internal error: Oops: 27 [#1] PREEMPT SMP ARM
Modules linked in:
usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-00007-ge8f7703f8fe5 
#1908
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at dev_pm_opp_put_regulators+0x8/0xf0
LR is at dt_cpufreq_probe+0x19c/0x3fc
pc : [<c0847694>]    lr : [<c08538b8>]    psr: a0000013
...
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xc1d29da8 to 0xc1d2a000)
...
[<c0847694>] (dev_pm_opp_put_regulators) from [<c08538b8>] 
(dt_cpufreq_probe+0x19c/0x3fc)
[<c08538b8>] (dt_cpufreq_probe) from [<c068eecc>] 
(platform_drv_probe+0x6c/0xa4)
[<c068eecc>] (platform_drv_probe) from [<c068c490>] 
(really_probe+0x200/0x4fc)
[<c068c490>] (really_probe) from [<c068c954>] 
(driver_probe_device+0x78/0x1fc)
[<c068c954>] (driver_probe_device) from [<c068cd3c>] 
(device_driver_attach+0x58/0x60)
[<c068cd3c>] (device_driver_attach) from [<c068ce20>] 
(__driver_attach+0xdc/0x174)
[<c068ce20>] (__driver_attach) from [<c068a218>] 
(bus_for_each_dev+0x68/0xb4)
[<c068a218>] (bus_for_each_dev) from [<c068b54c>] 
(bus_add_driver+0x158/0x214)
[<c068b54c>] (bus_add_driver) from [<c068dc80>] (driver_register+0x78/0x110)
[<c068dc80>] (driver_register) from [<c0102484>] 
(do_one_initcall+0x8c/0x42c)
[<c0102484>] (do_one_initcall) from [<c11011c0>] 
(kernel_init_freeable+0x190/0x1dc)
[<c11011c0>] (kernel_init_freeable) from [<c0b208f8>] 
(kernel_init+0x8/0x118)
[<c0b208f8>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xc1d29fb0 to 0xc1d29ff8)
...
---[ end trace 5879c43bc748d0d3 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU0: stopping

Reverting this patch and d44aca126b03 ("cpufreq: dt: 
dev_pm_opp_put_regulators() accepts NULL argument"), which depends on 
it, fixes the panic on current linux-next.

> ---
>   drivers/cpufreq/cpufreq-dt.c | 158 +++++++++++++++--------------------
>   1 file changed, 68 insertions(+), 90 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

