Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E129217C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 05:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgJSDml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 23:42:41 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46316 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgJSDmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 23:42:40 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201019034237epoutp016a749ae2151a5726caa55be9c190f7ab~-R9FxKIg43073030730epoutp01j
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:42:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201019034237epoutp016a749ae2151a5726caa55be9c190f7ab~-R9FxKIg43073030730epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603078957;
        bh=oRJpa3IYSgzpxiEPraiJpZ41NHzoahgdfRcWkR+DQBA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L5BIFXm03c2TkvSSywztk/IDp/Vnj2bk4J7JjYd0SWWaoX2RcnRAz8PLtRMBV7qnY
         X6CkKbLvmRp4UVEZJ2e4UDqDGcHMgFpagdN9huU2259gG9oIVK3M2YjaUT/Th/QI8/
         MRu85QLsCQnexar4bDq+J3ipbgLDgnLWVI86NtWU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201019034236epcas1p282ec51c5a586068851723318ae8d89a8~-R9FQNWiX0388903889epcas1p2x;
        Mon, 19 Oct 2020 03:42:36 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CF2dQ1Y6mzMqYm8; Mon, 19 Oct
        2020 03:42:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.A2.09582.A2B0D8F5; Mon, 19 Oct 2020 12:42:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201019034233epcas1p1ef81512dec819d2e2f269b5ab8600c07~-R9Ciyvp-0092100921epcas1p1f;
        Mon, 19 Oct 2020 03:42:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201019034233epsmtrp121eb7337688477ba9c3fb2bf8bbc5bd5~-R9Ch7LCJ1750317503epsmtrp16;
        Mon, 19 Oct 2020 03:42:33 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-f3-5f8d0b2a19a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.91.08745.92B0D8F5; Mon, 19 Oct 2020 12:42:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019034233epsmtip18c87992ec19756baaae868213e31094f~-R9CMmaMD0773107731epsmtip1j;
        Mon, 19 Oct 2020 03:42:33 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <70d5e625-aae0-cb86-e5d5-1c362098876e@samsung.com>
Date:   Mon, 19 Oct 2020 12:55:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <63ac80e9-7f31-8447-06ca-e7d830a4aed4@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmrq4Wd2+8wa41LBbLLh1ltNg4Yz2r
        xcQbV1gsVn98zGix5vYhRosfG04xW7TMWsRiseDTDFaLs01v2C1W3P3IanF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoD+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZUx79Yi84J1+x+8NntgbGO5JdjJwcEgImEmtW7GTsYuTiEBLY
        wShx6dI9VgjnE6PEsaer2SCcz4wSe5aeZINp6d94mAUisYtRYu7JH8wQzntGicUf5jCCVAkL
        xEvcXP+NGcQWEaiVOHLxAdgoZoEVTBJr1p9lAUmwCWhJ7H9xA2wsv4CixNUfj8GaeQXsJI7c
        agGzWQRUJZ6v/gRWLyoQJnFyWwtUjaDEyZlPwOKcArYSm+ZPYgKxmQXEJW49mQ9ly0tsfzsH
        7DoJgQ8cEg9/LgD6jgPIcZHoeZUB8Y6wxKvjW9ghbCmJl/1tUHa1xMqTR9ggejsYJbbsv8AK
        kTCW2L90MhPIHGYBTYn1u/QhwooSO3/PZYTYyyfx7msP1CpeiY42IYgSZYnLD+4yQdiSEovb
        O9kmMCrNQvLNLCQfzELywSyEZQsYWVYxiqUWFOempxYbFhgjR/cmRnAi1zLfwTjt7Qe9Q4xM
        HIyHGCU4mJVEeCMFu+KFeFMSK6tSi/Lji0pzUosPMZoCw3cis5Rocj4wl+SVxBuaGhkbG1uY
        GJqZGhoqifP+0e6IFxJITyxJzU5NLUgtgulj4uCUamCSfC/9Yj5/kjjzt9XxD/UmfsiytXu4
        M7WF5zzDec8rj6Ir5VY6MOyOcql4HHqWke+tzak/76urrXj9/Rl/qrYEiE/QtlZ95+7T1G+8
        S26mqFvNaS/l76InzQJYflyqD/F6eFRa1/ZmiNbMvUETdr5qi5+1as/EnEMfKlQ8a/27V08z
        b0wqPOIlx7jiaFD885XfW/peqqqZiIeZJ525xhsaO5N5+1VhRT/XwlsqiTw1WkkeRTfnlxoZ
        3nBlC6nfdvDGPxthKX3B9P4XtYLThTR+zf9WvYlJmcc5znb/2cR385mvV266e/JE6u1Na6+c
        ly1WsD5g18N892rtN0Y/9+mr5L9+fNB4+Iap1eEtqUosxRmJhlrMRcWJAB6T6/ZtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSnK4md2+8wd3FahbLLh1ltNg4Yz2r
        xcQbV1gsVn98zGix5vYhRosfG04xW7TMWsRiseDTDFaLs01v2C1W3P3IanF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM4oLpuU1JzMstQifbsErowpj36xF5yTr9j94TNbA+MdyS5GTg4J
        AROJ/o2HWboYuTiEBHYwSjy5v4QZIiEpMe3iUSCbA8gWljh8uBii5i2jRP+uk2wgNcIC8RI3
        138DqxcRqJV4tXo6K4jNLLCCSWLhZyGIhk+MEuuXHWYESbAJaEnsf3EDrJlfQFHi6o/HYHFe
        ATuJI7dawGwWAVWJ56s/sYDYogJhEjuXPGaCqBGUODnzCVicU8BWYtP8SUwQy9Ql/sy7xAxh
        i0vcejIfKi4vsf3tHOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBEe0ltYOxj2rPugdYmTiYDzEKMHBrCTCGynYFS/Em5JYWZValB9fVJqTWnyI
        UZqDRUmc9+ushXFCAumJJanZqakFqUUwWSYOTqkGpoUfdG+9jFo6pYcpc+oGgX5v5pephWd7
        a51XH7eqyD3++HLT2djeDMeoejYvsW9TUyRFNrRb3PoasyHcPiVdYObd54fkJtZyMx7u99i+
        +710wdTVK4wdY6Kumwb+dYjYKTBpkXbHZU8hG4vQBF1JLtnW8xrOTIEnxeTYnd47mneo9HcV
        TZzX5PQgY/KZW8rVXW3+X5aelYy54VVrbtHE/f+OhPfET/7nuioV+9W//ZncpXd3s9Oe7gyd
        C0cm5hwwfpse1cIYr2N7S05JgT+rgNu4kDXx4cbva6dknqtScxabPqEz5YzquyiWuaUvpvVF
        WXdy+6grZC80chS7uu1X5i3nHgNt5ifmSc4R55VYijMSDbWYi4oTAezS0UdXAwAA
X-CMS-MailID: 20201019034233epcas1p1ef81512dec819d2e2f269b5ab8600c07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767@epcas1p3.samsung.com>
        <20201007050703.20759-3-cw00.choi@samsung.com>
        <63ac80e9-7f31-8447-06ca-e7d830a4aed4@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/19/20 9:38 AM, Dmitry Osipenko wrote:
> ...
>> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
>> index deefffb3bbe4..67af3f31e17c 100644
>> --- a/Documentation/ABI/testing/sysfs-class-devfreq
>> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
>> @@ -37,20 +37,6 @@ Description:
>>  		The /sys/class/devfreq/.../target_freq shows the next governor
>>  		predicted target frequency of the corresponding devfreq object.
>>  
>> -What:		/sys/class/devfreq/.../polling_interval
>> -Date:		September 2011
>> -Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>> -Description:
>> -		The /sys/class/devfreq/.../polling_interval shows and sets
>> -		the requested polling interval of the corresponding devfreq
>> -		object. The values are represented in ms. If the value is
>> -		less than 1 jiffy, it is considered to be 0, which means
>> -		no polling. This value is meaningless if the governor is
>> -		not polling; thus. If the governor is not using
>> -		devfreq-provided central polling
>> -		(/sys/class/devfreq/.../central_polling is 0), this value
>> -		may be useless.
>> -
>>  What:		/sys/class/devfreq/.../trans_stat
>>  Date:		October 2012
>>  Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>> @@ -65,14 +51,6 @@ Description:
>>  		as following:
>>  			echo 0 > /sys/class/devfreq/.../trans_stat
>>  
>> -What:		/sys/class/devfreq/.../userspace/set_freq
>> -Date:		September 2011
>> -Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>> -Description:
>> -		The /sys/class/devfreq/.../userspace/set_freq shows and
>> -		sets the requested frequency for the devfreq object if
>> -		userspace governor is in effect.
>> -
>>  What:		/sys/class/devfreq/.../available_frequencies
>>  Date:		October 2012
>>  Contact:	Nishanth Menon <nm@ti.com>
>> @@ -109,6 +87,35 @@ Description:
>>  		The max_freq overrides min_freq because max_freq may be
>>  		used to throttle devices to avoid overheating.
>>  
>> +What:		/sys/class/devfreq/.../polling_interval
>> +Date:		September 2011
>> +Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>> +Description:
>> +		The /sys/class/devfreq/.../polling_interval shows and sets
>> +		the requested polling interval of the corresponding devfreq
>> +		object. The values are represented in ms. If the value is
>> +		less than 1 jiffy, it is considered to be 0, which means
>> +		no polling. This value is meaningless if the governor is
>> +		not polling; thus. If the governor is not using
>> +		devfreq-provided central polling
>> +		(/sys/class/devfreq/.../central_polling is 0), this value
>> +		may be useless.
>> +
>> +		A list of governors that support the node:
>> +		- simple_ondmenad
>> +		- tegra_actmon
>> +
>> +What:		/sys/class/devfreq/.../userspace/set_freq
>> +Date:		September 2011
>> +Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>> +Description:
>> +		The /sys/class/devfreq/.../userspace/set_freq shows and
>> +		sets the requested frequency for the devfreq object if
>> +		userspace governor is in effect.
>> +
>> +		A list of governors that support the node:
>> +		- userspace
>> +
>>  What:		/sys/class/devfreq/.../timer
>>  Date:		July 2020
>>  Contact:	Chanwoo Choi <cw00.choi@samsung.com>
>> @@ -120,3 +127,6 @@ Description:
>>  		as following:
>>  			echo deferrable > /sys/class/devfreq/.../timer
>>  			echo delayed > /sys/class/devfreq/.../timer
>> +
>> +		A list of governors that support the node:
>> +		- simple_ondemand
> 
> Hello, Chanwoo!
> 
> Could you please explain the reason of changing the doc? It looks like
> you only added the lists of governors, but is it a really useful change?
> Are you going to keep these lists up-to-date?

I think that is is useful. Because user cannot know why specific sysfs node
(like 'timer') is absence according to governor. So, in order to remove
the user confusion, better to add the information to documentation.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
