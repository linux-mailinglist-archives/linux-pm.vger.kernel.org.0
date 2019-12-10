Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14D61183C9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 10:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLJJjT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 04:39:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46251 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfLJJjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 04:39:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191210093917euoutp0293c75fb3998eba5d3e40433e29990a0e~e_Q3F1aJs0992409924euoutp02X
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 09:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191210093917euoutp0293c75fb3998eba5d3e40433e29990a0e~e_Q3F1aJs0992409924euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575970757;
        bh=F0z+QAlm0CEiQ1aizr+w2Zw8aUWhjedLWNcx+ym5BWo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UfJNLvLKtJytLRbG4R7z2/jqqh2RH+CyqeYWh4D1zpNneEhLaH+4HfuGcvpHwC5eV
         Pkv290qBp4wqGaigpLHqxHfhafm5Tqdix3cPe1hcvrxRC39CINEKiMaFYCWdCu1s2V
         4noNrNGPPkFxcAYfH+IWq4S+wtOZySPlQnD+U3t0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210093916eucas1p2373b150fa34a77df18406dc23fe8af50~e_Q2y9wFw1754517545eucas1p2C;
        Tue, 10 Dec 2019 09:39:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.46.61286.4C76FED5; Tue, 10
        Dec 2019 09:39:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191210093916eucas1p189d01ac35e2c93731f9d6a446cf777bd~e_Q2eweYV2385123851eucas1p1Z;
        Tue, 10 Dec 2019 09:39:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210093916eusmtrp1a0604489d600515da443f6124c0be1e6~e_Q2eK0rx2000920009eusmtrp1v;
        Tue, 10 Dec 2019 09:39:16 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-71-5def67c483af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.DC.08375.4C76FED5; Tue, 10
        Dec 2019 09:39:16 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210093916eusmtip1b5817b00398b8129dfb354eee82b01d2~e_Q2C7sL31723417234eusmtip1w;
        Tue, 10 Dec 2019 09:39:16 +0000 (GMT)
Subject: Re: [PATCH 3/4] PM / devfreq: Kconfig: add DEVFREQ_DELAYED_TIMER
 option
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <4c998511-e825-f2da-cfce-7242cdb63902@samsung.com>
Date:   Tue, 10 Dec 2019 10:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209193432.GQ228856@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7pH0t/HGvx+Y2SxccZ6VovrX56z
        Wpw/v4Hd4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwebA6TG74SKLx6ZVnWwefVtW
        MXp83iQXwBLFZZOSmpNZllqkb5fAlTHt7UymgpkCFT+6tzM3MH7i6WLk5JAQMJHYsuIXWxcj
        F4eQwApGib5Fi5ghnC+MEs23nrFDOJ8ZJbZcb2SFabm9dCkTRGI5o8SVH3egnLeMEpfWfmUC
        qRIWCJJ49+UzG4gtIqAh8eT3eUaQImaBY0wSuw79BRvFJqAvcfDsSRYQm1fATuLb5v1gcRYB
        VYneh3OBmjk4RAUiJE5/TYQoEZQ4OfMJC0iYU8BQ4sE5K5Aws4C4xK0n85kgbHmJ7W/ngL0g
        IbCPXWLyz9fsEFe7SEw62c0CYQtLvDq+BSouI3F6cg9UvFzi6cI+dojmFkaJB+0foRLWEoeP
        X2QFWcwsoCmxfpc+RNhR4uCO1WBnSgjwSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1aoSz0/1MEHY
        0hJd/9exTmBUmoXksVlIvpmF5JtZCHsXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93E
        CExGp/8d/7SD8eulpEOMAhyMSjy8CxzexQqxJpYVV+YeYpTgYFYS4T3eBhTiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qBMe33l1TGxwJPPmV+vlfClbWW
        7YP0DIbC9pN/kiocHjtu1sxax7zTYGO4yI/kPvscTkXzOqYmHZfEsAVSqzt+Wy7Y+cjJ0LxO
        XmHBkeJZKk1nH561drj09/YTz5w/SzUyndcsTGm79jjQprH0rPISC90Kvh0/eUq/KH9mPaV8
        4hd/9p9MlzJnJZbijERDLeai4kQAZwaM3UIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7pH0t/HGqw7K2uxccZ6VovrX56z
        Wpw/v4Hd4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwebA6TG74SKLx6ZVnWwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5eglzHt7UymgpkCFT+6tzM3MH7i6WLk5JAQMJG4vXQpUxcjF4eQwFJGiQUPpzJCJKQlGk+v
        ZoKwhSX+XOtigyh6zShxc8VEZpCEsECQxLsvn9lAbBEBDYknv88zghQxCxxjkniw6CUzRMcr
        RokN176BdbAJ6EscPHuSBcTmFbCT+LZ5PyuIzSKgKtH7cC7YJFGBCInn228wQtQISpyc+QSo
        noODU8BQ4sE5K5Aws4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoNAtJ9ywkLbOQtMxC0rKA
        kWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYARuO/Zz8w7GSxuDDzEKcDAq8fAucHgXK8Sa
        WFZcmXuIUYKDWUmE93gbUIg3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgckhryTe0NTQ3MLS
        0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY+e/4HvK/p5vGJYs2LTzdZSzrsEm
        402F5e4CS50uTGhc071vZURw9ZIv9pbXRLuW/7HLWJIvKjrBZM6a+vSqGZe05JVWsLg+W+jg
        K9Kh+rVFMuRIU/li5u32r6Mbph8t0/yXFHJh5WPb+XN2PQn8GsubWvTp35cH0frdHG7iZgw5
        O6zW5IglK7EUZyQaajEXFScCAHDjVirWAgAA
X-CMS-MailID: 20191210093916eucas1p189d01ac35e2c93731f9d6a446cf777bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144442eucas1p1e4f5cf4a1716262e2b6715fb41876f91@eucas1p1.samsung.com>
        <20191209144425.13321-4-k.konieczny@samsung.com>
        <20191209193432.GQ228856@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 09.12.2019 20:34, Matthias Kaehlcke wrote:
> On Mon, Dec 09, 2019 at 03:44:24PM +0100, Kamil Konieczny wrote:
>> Add Kconfig option DEVFREQ_DELAYED_TIMER. If set, devfreq workqueue
>> will use delayed timer from its start.
> 
> s/from its start/by default/
> 

thank you for review, I will correct this

>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>>  drivers/devfreq/Kconfig | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 38a94df749a2..c799917c34c9 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -74,6 +74,18 @@ config DEVFREQ_GOV_PASSIVE
>>  	  through sysfs entries. The passive governor recommends that
>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>  
>> +comment "DEVFREQ Options"
>> +
>> +config DEVFREQ_DELAYED_TIMER
>> +	bool "Use delayed timer in Simple Ondemand Governor"
> 
> Is the use really limited to the Simple Ondemand Governor? I don't think
> so, at least the Tegra devfreq driver also does monitoring and others
> might follow.

There are currently:

simple_ondemand
performance
powersave
userspace
passive

From them perfomance, powersave and userspace are fixed max, min or user provided,
so only left simple_ondemand and passive which could benefit from change.

>> +	default false
>> +	help
>> +	  Simple Ondemand Governor uses polling for reading buses counters.
>> +	  A default timer used is deferred, which saves power, but can
>> +	  miss increased demand for higher bus frequency if timer was
>> +	  assigned to idle cpu. If you want to change this to delayed
>> +	  timer at the cost of more power used, say Yes here.
>> +
>>  comment "DEVFREQ Drivers"
>>  
>>  config ARM_EXYNOS_BUS_DEVFREQ
> 
> 
> This patch on it's own does nothing. Squash it with '[4/4] PM / devfreq:
> use delayed work if DEVFREQ_DELAYED_TIMER set'.
> 
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

