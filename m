Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0F258AD8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIAI5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 04:57:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58236 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAI5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 04:57:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200901085709euoutp02eb0d54309a64eadfe5adb551dc635670~wnSAp-dD81055410554euoutp02h
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 08:57:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200901085709euoutp02eb0d54309a64eadfe5adb551dc635670~wnSAp-dD81055410554euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598950629;
        bh=AH1jb8nTf9FyiyQjqccqupk/5L/OMBQYmwo67xczGnU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GdU3zOmrXy2xn+rpACP935sbW9Uxl0pq2pPyh7m8W8FSsyimk6kscrHVP886oIsRM
         mtN8J+lPd05v2H1THjWww7mgXoVYh9/cnumQSaycBJCwMcZHkWhhLP+jRboEKrhHF+
         ZpOsUe52vIOWvKtDdBJoBRRwATJmVoBVFrMfv9aM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200901085708eucas1p25e4d058e9f54de3e552e14b8828a1758~wnSAJ62OL1189711897eucas1p2Z;
        Tue,  1 Sep 2020 08:57:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2F.F8.06318.4EC0E4F5; Tue,  1
        Sep 2020 09:57:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28~wnR-yrw151189711897eucas1p2Y;
        Tue,  1 Sep 2020 08:57:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901085708eusmtrp2f9bc146a457c3f5323b660efc13d8d8b~wnR-xxf0O0816408164eusmtrp2P;
        Tue,  1 Sep 2020 08:57:08 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-b9-5f4e0ce49b4b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.76.06314.4EC0E4F5; Tue,  1
        Sep 2020 09:57:08 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200901085707eusmtip254c384354dd462d2080c433619779de2~wnR__i8nM2392323923eusmtip2M;
        Tue,  1 Sep 2020 08:57:07 +0000 (GMT)
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Refactor initialization to handle
 probe deferral properly
To:     Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        nks@flawful.org, georgi.djakov@linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <00a87bad-f750-b08c-4ccb-545b90dd87fc@samsung.com>
Date:   Tue, 1 Sep 2020 10:57:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f75c61f193f396608d592ae2a9938264d582c038.1598260050.git.viresh.kumar@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjlvffu7ipOr7PysSJthKBQKkldTOwDf9wgy36UaKTOvH6UTttV
        yyCQIlurwCzRhqUo2BqaOkyz8iOxVq05c7XMD0yzyHBkalpZmtvN8t95zjnPe54DL4VLh0Sr
        qVRFFqdUyNNkpDPR+OSHeeOoy964wHGLD1M0PEoyxS16kjGb68TMzCsVxljul5LM1OVOxJSY
        WzHGdO2NmBn/bsKYF8YeETNvrSeY3hvBjKEmilF1zuBM/Td2hxt7pqwUY/PLt7PNmkExq9dd
        INkB60OSbXh9nmANvU0YO6VfF0nFOIcmcmmpOZwyICzeOaXIUI1lWrxP1g7Vi/LQoJcaOVFA
        B0P7Yx2hRs6UlNYiaKj5TdgFKT2NoCvfXxCmEFS2PiWWNuq1lSJBuIWgSDWEC8MXBB+N3SK7
        y4NOhJr+EYdrBX0XQcWHPNIu4PQQBnVj/nZM0kGgtqkdvIQOg0+qmw5M0Bug3Gp1xK2kY+HJ
        8xFC8LjDs+ujDuy0yE+NXMWFN72hyVb6F3tC32gZZg8G+ocYZpvPiYS7w2HiXdvfDh7w2dAg
        FvBaWGheWjiLYLirRiwMlxBYzpQgwbUNBrp+Lp5HLUb4Qe39AIHeCdrBSbGdBtoVem3uwhGu
        UNhYjAu0BFT5UsHtCxrDnX+xj7p78AIk0yyrpllWR7OsjuZ/bjkidMiTy+bTkzl+s4I7sYmX
        p/PZiuRNRzLS9Wjx2xnnDd/uodZfCR2IppDMRaKd2RMnFclz+Nz0DgQULlsh2WUyxkolifLc
        U5wyI06ZncbxHWgNRcg8JZsrxg5L6WR5FneM4zI55ZKKUU6r89BW28/K8cnY4/HxusLbGcE7
        S06/MYf0vtSYdpsGC2KjE6KMfT7tZmtE2lGlNqShKvNt5FftwuyB5ujTqnwPfVjghN/6uUOW
        g7UXre3qlmlDtSbKN2c+kgxPco0Z29fm51Z1pX82gNyiSGrkbWX3kCXifbfXXFnbg/2h5lWN
        1o3tMoJPkQf540pe/geiIl7XcgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7pPePziDdZN5bSY+vAJm8X0vZvY
        LM6f38Bu8e1KB5PF5V1z2Cw+9x5htJhxfh+Txdkp19kt3vw4y2Rx5vQlVot/1zayWNyYa2Jx
        fG24RceRb8wWG796OPB7NM2fw+TRtsDeY+esu+wem1Z1snncubaHzWPL1XYWj+M3tjN5fN4k
        F8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx
        9fgapoLL8hXr729kbWC8K9nFyMkhIWAisXHFYtYuRi4OIYGljBJzmm+yQSRkJE5Oa2CFsIUl
        /lzrYoMoessocXHvIbCEsECKxNrbj8C6RQS2Mkq8On4ArIpZ4CGTxL2utewQLRsZJc4f/MsM
        0sImYCjR9bYLbAevgJ3Ei455YDaLgIrEgmvXWEBsUYE4iTM9L6BqBCVOznwCFucEin9+NBls
        DrOAmcS8zQ+hbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGh
        XnFibnFpXrpecn7uJkZghG879nPzDsZLG4MPMQpwMCrx8AZ88YkXYk0sK67MPcQowcGsJMLr
        dPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA5NPXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGRhdTtylNBVMFIsoMJxf9vK/vlVJQKtVQ2cYUf1xpx/e7
        /GIJFyPsjl+VW6wYujnhkHdcuzDH4YjdV5SFtVx8eZa9b7trsywrQHW93uxTDIdqnKZX1m+b
        IcSy8PL99df/FDL+ze1La1ilbVw2adnHXdONbjh7tMnLZOwT2R9iFrvW9MOXVCVdJZbijERD
        Leai4kQAAwJlvwYDAAA=
X-CMS-MailID: 20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
        <f75c61f193f396608d592ae2a9938264d582c038.1598260050.git.viresh.kumar@linaro.org>
        <CGME20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh

On 24.08.2020 11:09, Viresh Kumar wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
>
> cpufreq-dt is currently unable to handle -EPROBE_DEFER properly
> because the error code is not propagated for the cpufreq_driver->init()
> callback. Instead, it attempts to avoid the situation by temporarily
> requesting all resources within resources_available() and releasing them
> again immediately after. This has several disadvantages:
>
>    - Whenever we add something like interconnect handling to the OPP core
>      we need to patch cpufreq-dt to request these resources early.
>
>    - resources_available() is only run for CPU0, but other clusters may
>      eventually depend on other resources that are not available yet.
>      (See FIXME comment removed by this commit...)
>
>    - All resources need to be looked up several times.
>
> Now that the OPP core can propagate -EPROBE_DEFER during initialization,
> it would be nice to avoid all that trouble and just propagate its error
> code when necessary.
>
> This commit refactors the cpufreq-dt driver to initialize private_data
> before registering the cpufreq driver. We do this by iterating over
> all possible CPUs and ensure that all resources are initialized:
>
>    1. dev_pm_opp_get_opp_table() ensures the OPP table is allocated
>       and initialized with clock and interconnects.
>
>    2. dev_pm_opp_set_regulators() requests the regulators and assigns
>       them to the OPP table.
>
>    3. We call dev_pm_opp_of_get_sharing_cpus() early so that we only
>       initialize the OPP table once for each shared policy.
>
> With these changes, we actually end up saving a few lines of code,
> the resources are no longer looked up multiple times and everything
> should be much more robust.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [ Viresh: Use list_head structure for maintaining the list and minor
> 	  changes ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This patch landed in linux-next about a week ago. It introduces a 
following warning on Samsung Exnyos3250 SoC:

cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
1000000000, volt: 1150000, enabled: 1. New: freq: 1000000000, volt: 
1150000, enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
900000000, volt: 1112500, enabled: 1. New: freq: 900000000, volt: 
1112500, enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
800000000, volt: 1075000, enabled: 1. New: freq: 800000000, volt: 
1075000, enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
700000000, volt: 1037500, enabled: 1. New: freq: 700000000, volt: 
1037500, enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
600000000, volt: 1000000, enabled: 1. New: freq: 600000000, volt: 
1000000, enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
500000000, volt: 962500, enabled: 1. New: freq: 500000000, volt: 962500, 
enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
400000000, volt: 925000, enabled: 1. New: freq: 400000000, volt: 925000, 
enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
300000000, volt: 887500, enabled: 1. New: freq: 300000000, volt: 887500, 
enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
200000000, volt: 850000, enabled: 1. New: freq: 200000000, volt: 850000, 
enabled: 1
cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq: 
100000000, volt: 850000, enabled: 1. New: freq: 100000000, volt: 850000, 
enabled: 1

I've checked a bit and this is related to the fact that Exynos3250 SoC 
use OPP-v1 table. Is this intentional? It is not a problem to convert it 
to OPP-v2 and mark OPP table as shared, but this is a kind of a regression.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

