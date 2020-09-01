Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F160D258C4D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 12:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIAKFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 06:05:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59383 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIAKFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 06:05:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200901100542euoutp0290a5deaa3a35f9b41305e89695daf436~woN3sFuG02585925859euoutp02f
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 10:05:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200901100542euoutp0290a5deaa3a35f9b41305e89695daf436~woN3sFuG02585925859euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598954742;
        bh=oKlzZ1wi6gyjXy/12j5RExJfEQqhIaRJ24AIhIodeCo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EyEgPr6nPwXhQzQTFWmIhB6Dtr2ng3TQC+AJ0wEt8vEoC9KGzKQF2rhEqL74lr/4A
         Xb/Fcu2P365u8SPt6MFbwto2nvyzqTfzAp8sLPPz7iMtyJlgEf+lFMSuXk+ULeIrTf
         JXH6smY1hg8OT6iAQ9p7YM3vuj/TSAo60Jp6K7Hs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200901100542eucas1p1ec0858d2ff0561690b0e61535d57d94d~woN3U46EY2621526215eucas1p1Z;
        Tue,  1 Sep 2020 10:05:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.7D.06456.6FC1E4F5; Tue,  1
        Sep 2020 11:05:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901100541eucas1p2e90129d3c6d65be011a7968c07fc8ba6~woN250bt92068420684eucas1p2j;
        Tue,  1 Sep 2020 10:05:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200901100541eusmtrp110b5db743aa85785794d2020ac45c72a~woN24-YGU0509505095eusmtrp1s;
        Tue,  1 Sep 2020 10:05:41 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-28-5f4e1cf60f41
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.12.06314.5FC1E4F5; Tue,  1
        Sep 2020 11:05:41 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901100540eusmtip19eea193e6a220fb8bb274edbf1e5dcde~woN2E1pty1696416964eusmtip1g;
        Tue,  1 Sep 2020 10:05:40 +0000 (GMT)
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Refactor initialization to handle
 probe deferral properly
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        nks@flawful.org, georgi.djakov@linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <383b7a8b-4cbf-d156-d9f0-4990cdde8d43@samsung.com>
Date:   Tue, 1 Sep 2020 12:05:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901094508.4sgyfv3yj575wlzp@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXbv7q7S9HEaO6lprAgStGQWN4rsjbj0In4Iil6cKy+r3DQ2
        Xyq/mJXp0ojMl4am2IeksHKFmpWlxFZON3Nqy7RS/KI4BN1Wlkpdr5bffv9z/uc55w8PTci+
        ikPps2kZnD5NrVVQ/mSjZcYR7QtPUG1qnA1gSodHKab8tZliHI6nEsbXWyBinC2VFDNd/A4x
        FY5WEdN155OEmfjZJWI6bT1iZr6/gWRcVXGMtf4IU/DORzANXnZnIJtXXSli82vi2RemIQlr
        flhIsYP9ryj2ed91krW6mkTstDkikT7mvz2F057N4vQbdyT7n+ksmyXPF0Ze+FZmEeeiR2BE
        fjTgOPjsmBUZkT8tw3UIcs1thCA8CBqGapEgphGU5l+TLI1UDdaKhcYDBDbv5UUxicD39oaY
        dwXjFKj/MvKXaToER8HYZ44vE3icgKZbcTxTOBaMbiPFsxTvAPd7J8EzidfBh7pHJM8rcRJY
        OkZIwRMEH+6OLrAf3gpF43kS4c1IaHJXEgLLYWC0eiEP4Ms0eK7NiISr94LdbV/kYBi3Pl9M
        Ew62kiJSGLiCYNheLxFEEQJnXgUSXNtg0P6L4tMQeAM8adkolHdB3dCUhC8DDgCXO0g4IgBu
        N5YTQlkKBfkywb0eTNbH/9a2dfcQt5DCtCyaaVkc07I4pv97axD5EMm5TINOwxli07jsGINa
        Z8hM08ScTteZ0d9fZ5u3TjUjb8+pdoRppFghTfQcVMnE6izDRV07AppQhEh3d9mSZNIU9cVL
        nD5dpc/UcoZ2FEaTCrlUWTt2UoY16gwulePOc/qlroj2C81FL/dbnoaoVn9kLiX7NXcfyBn0
        RiYEKo5as++5wjZDWA/2lWyZmZMftqS7mlLn4wYyEkwJz8yqtco3WT59R/GK+D2bmzvx/d6p
        72OeaPPvsaurzhlbGzUX9sWEF8rCu7VzSYnvI0445TcLDiXqlPc6lGuifyRPSL9Q9sm+nG+t
        xxWk4Yw6NorQG9R/AK+t9+5xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7pfZfziDf69M7SY+vAJm8X0vZvY
        LM6f38Bu8e1KB5PF5V1z2Cw+9x5htJhxfh+Txdkp19kt3vw4y2Rx5vQlVot/1zayWNyYa2Jx
        fG24RceRb8wWG796OPB7NM2fw+TRtsDeY+esu+wem1Z1snncubaHzWPL1XYWj+M3tjN5fN4k
        F8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx
        ZtofloJO+Yr7046xNjCuluhi5OSQEDCRmHtnEWsXIxeHkMBSRok1V1YwQyRkJE5Oa2CFsIUl
        /lzrYoMoesso8XLfUyaQhLBAisTa24+Aijg4RAS0JF7eTAWpYRZ4wyxxeP1ldpAaIYGXTBKT
        r3qC2GwChhJdb0EGcXLwCthJvD1xGWwZi4CKxMkVq1lAbFGBOIkzPS+gagQlTs58AhbnFLCU
        6HnVBDaTWcBMYt7mh8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMwtrcd+7l5B+OljcGHGAU4GJV4eAO++MQLsSaWFVfmHmKU
        4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgWknryTe0NTQ3MLS0NzY3NjM
        Qkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo4j1nDuB6UkSVmqvY7/5+/ZPDEh1dJ7Xvufv
        IWcRJZVT7JMqNl7+ffRreb37pshbJbb378+a//bfl4WzPDznh51X6V3Pn7D40V7tuWbhk2S7
        mBZMkJju3hn1Kzzh8j1+yR3TbM/+mckUfyXALLIh1vH0abMmLutJ1/p0HZ4cPZLKaXrLQvfd
        FSWW4oxEQy3mouJEABVLqHYDAwAA
X-CMS-MailID: 20200901100541eucas1p2e90129d3c6d65be011a7968c07fc8ba6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
        <f75c61f193f396608d592ae2a9938264d582c038.1598260050.git.viresh.kumar@linaro.org>
        <CGME20200901085708eucas1p231ccacd7b41685ece92ee21e3b726f28@eucas1p2.samsung.com>
        <00a87bad-f750-b08c-4ccb-545b90dd87fc@samsung.com>
        <20200901094508.4sgyfv3yj575wlzp@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 01.09.2020 11:45, Viresh Kumar wrote:
> On 01-09-20, 10:57, Marek Szyprowski wrote:
>> This patch landed in linux-next about a week ago. It introduces a
>> following warning on Samsung Exnyos3250 SoC:
>>
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 1000000000, volt: 1150000, enabled: 1. New: freq: 1000000000, volt:
>> 1150000, enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 900000000, volt: 1112500, enabled: 1. New: freq: 900000000, volt:
>> 1112500, enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 800000000, volt: 1075000, enabled: 1. New: freq: 800000000, volt:
>> 1075000, enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 700000000, volt: 1037500, enabled: 1. New: freq: 700000000, volt:
>> 1037500, enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 600000000, volt: 1000000, enabled: 1. New: freq: 600000000, volt:
>> 1000000, enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 500000000, volt: 962500, enabled: 1. New: freq: 500000000, volt: 962500,
>> enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 400000000, volt: 925000, enabled: 1. New: freq: 400000000, volt: 925000,
>> enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 300000000, volt: 887500, enabled: 1. New: freq: 300000000, volt: 887500,
>> enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 200000000, volt: 850000, enabled: 1. New: freq: 200000000, volt: 850000,
>> enabled: 1
>> cpu cpu1: _opp_is_duplicate: duplicate OPPs detected. Existing: freq:
>> 100000000, volt: 850000, enabled: 1. New: freq: 100000000, volt: 850000,
>> enabled: 1
>>
>> I've checked a bit and this is related to the fact that Exynos3250 SoC
>> use OPP-v1 table. Is this intentional? It is not a problem to convert it
>> to OPP-v2 and mark OPP table as shared, but this is a kind of a regression.
> It took me 20 minutes for me to see "where has my patch gone" :(
>
> I wrote a small patch for that to work without any issues, but not
> sure how I missed or abandoned it. Anyway, here is the diff again and
> I will send it out again once you confirm it fixes the issue. Can you
> please also test your driver as a module with multiple insertion/removals ?

Indeed, this patch seems to fix/hide that warning. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 5dac8bffd68c..e72753be7dc7 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -905,6 +905,16 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>          const __be32 *val;
>          int nr, ret = 0;
>   
> +       mutex_lock(&opp_table->lock);
> +       if (opp_table->parsed_static_opps) {
> +               opp_table->parsed_static_opps++;
> +               mutex_unlock(&opp_table->lock);
> +               return 0;
> +       }
> +
> +       opp_table->parsed_static_opps = 1;
> +       mutex_unlock(&opp_table->lock);
> +
>          prop = of_find_property(dev->of_node, "operating-points", NULL);
>          if (!prop)
>                  return -ENODEV;
> @@ -921,10 +931,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>                  return -EINVAL;
>          }
>   
> -       mutex_lock(&opp_table->lock);
> -       opp_table->parsed_static_opps = 1;
> -       mutex_unlock(&opp_table->lock);
> -
>          val = prop->value;
>          while (nr) {
>                  unsigned long freq = be32_to_cpup(val++) * 1000;
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

