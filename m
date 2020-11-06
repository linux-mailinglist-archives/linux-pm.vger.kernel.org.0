Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2012A9062
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgKFHct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:32:49 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:34919 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFHct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:32:49 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201106073245epoutp037c656d13e1874bde0f62709001aa7527~E2tKzOyan0691606916epoutp03J
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 07:32:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201106073245epoutp037c656d13e1874bde0f62709001aa7527~E2tKzOyan0691606916epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604647965;
        bh=0rqql/AnqaWWFy6qtLaVabfXJuNsw9cGFDeNJQrDOTw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fsiX54DgkD0thFq+ImsmSob1QeibpnV4oVSiWYfQM3XimG1r1tulE6Jh6ExLWh56D
         8AGCanTX92Ct2mvwcBM/Czbzh6NhKHaUMBL9bcV5CnMpQg5F5VFIRaQ7zHYeCPETAf
         nGtrPiNQLEEbzXQEDwKOEbtlF61JvitkHX3S6Wuo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201106073245epcas1p41cb8e38f46cdfa549158483dd5aa9df9~E2tKVC5kj1825318253epcas1p4p;
        Fri,  6 Nov 2020 07:32:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CSBtf1ZzCzMqYkj; Fri,  6 Nov
        2020 07:32:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.E0.02418.A1CF4AF5; Fri,  6 Nov 2020 16:32:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201106073241epcas1p26fb32e0cbc18e23748709a0a87cbf7ca~E2tGq9S7u0911509115epcas1p2a;
        Fri,  6 Nov 2020 07:32:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201106073241epsmtrp19b95df712872920039be7386e4b31a4d~E2tGqGa-j0161001610epsmtrp19;
        Fri,  6 Nov 2020 07:32:41 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-cc-5fa4fc1a1a1f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.02.08745.91CF4AF5; Fri,  6 Nov 2020 16:32:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201106073240epsmtip2f2a656110a246d25728aaad680ff40f8~E2tGUJICs2203622036epsmtip2z;
        Fri,  6 Nov 2020 07:32:40 +0000 (GMT)
Subject: Re: [PATCH 4/7] devfreq: exynos: dev_pm_opp_put_*() accepts NULL
 argument
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <4b13f82c-fa2a-939f-e26f-e8fc4d34d567@samsung.com>
Date:   Fri, 6 Nov 2020 16:46:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <a2f9dbba-1c07-8b60-fda5-737843be92e0@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmrq7UnyXxBrNvclis/viY0aL/8Wtm
        i/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaL240r2Cze/DjLZHHm9CVWi3/XNrJY
        dBz5xmyx8auHA5/Hzll32T02repk87hzbQ+bx+Yl9R5brrazePRtWcXocfzGdiaPz5vkAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRn
        NB1ew1awg7fiWt9DxgbGFu4uRk4OCQETiakz97B2MXJxCAnsYJQ4cvE7G0hCSOATo8Sn6/kQ
        ic+MEo8XLmKC6bg4ZSYrRNEuRoklvyogit4zSix+uZIFJCEsECLR8P4omM0moCWx/8UNNpAi
        EYETjBKz+r8xgTjMAmuYJPrXvAYbyy+gKHH1x2NGEJtXwE7i/971YHewCKhI3D0/G2ySqECY
        xMltLVA1ghInZz4Bi3MK2EtM+NXGDmIzC4hL3HoynwnClpfY/nYOM8gyCYE3HBLXJv1khvjB
        ReLn2T6of4QlXh3fwg5hS0m87G+DsqslVp48wgbR3MEosWX/BVaIhLHE/qWTgZo5gDZoSqzf
        pQ8RVpTY+XsuI8RiPol3X3tYQUokBHglOtqEIEqUJS4/uAu1VlJicXsn2wRGpVlI3pmF5IVZ
        SF6YhbBsASPLKkax1ILi3PTUYsMCQ+To3sQITtNapjsYJ779oHeIkYmD8RCjBAezkgjvBb9F
        8UK8KYmVValF+fFFpTmpxYcYTYEBPJFZSjQ5H5gp8kriDU2NjI2NLUwMzUwNDZXEef9od8QL
        CaQnlqRmp6YWpBbB9DFxcEo1MFU8Oxp67jmv7w23iisLTmu3Po4Kfutg8U3p7j3Fr203JUIs
        17p+MzsnxJvjWGPeNCvMKe9wvrTawa4LDgqeXzT+Mf3Xm2bxwSur4LkZl2GW/ozv+f+F/mnM
        S1016frdNzb89hzeC7iSjfxvRzB1mjacW1sQaCRjYVe9Pn7TPRu1aIOuLcwbPqxZ8K576mnH
        wv63/3bN0T/Jv1v2i0r1gpvRD59Zpp/76LKk7FrdhQKWn6W/zhv+M//wQz3hyuzT6i8Sotft
        /X6ksHrHxYBjr9QLA6QERA0VFBwsrsiuWj2b5yWrQdOx9zYCDbmGFhWW7N7fdf4YKT/Yv8Ka
        U/TXRNHinrcfjI1eLixNDFOxUGIpzkg01GIuKk4EABRlZD5cBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvK7knyXxBuc6OC1Wf3zMaNH/+DWz
        xfnzG9gtzja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbBZvfpxlsjhz+hKrxb9rG1ks
        Oo58Y7bY+NXDgc9j56y77B6bVnWyedy5tofNY/OSeo8tV9tZPPq2rGL0OH5jO5PH501yARxR
        XDYpqTmZZalF+nYJXBlNh9ewFezgrbjW95CxgbGFu4uRk0NCwETi4pSZrF2MXBxCAjsYJR7+
        PMcEkZCUmHbxKHMXIweQLSxx+HAxRM1bRonZd3czgtQIC4RINLw/ygJiswloSex/cYMNpEhE
        4BSjxM0X/ewgDrPAGiaJK6cWsIFUCQlMZ5K4/0saxOYXUJS4+uMx2CReATuJ/3vXg9WwCKhI
        3D0/G2yqqECYxM4lj5kgagQlTs58AhbnFLCXmPCrjR3EZhZQl/gz7xIzhC0ucevJfCYIW15i
        +9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQI
        jlgtrR2Me1Z90DvEyMTBeIhRgoNZSYT3gt+ieCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8X2ct
        jBMSSE8sSc1OTS1ILYLJMnFwSjUwLSu/eLdwbpnln2kTavM2MT6fETjX4tGnpowrQp0TZZ5F
        lOfMiZmbvGjqnJMGpz8uui/NsZ9xcffxhVffOuRLbtzR8iyw/efxCXKfttiHJysznONkXtiY
        KWLr6LVP5dzaX4dOHNmROS2wyfZQnWPO7Z8aUY8e8ZjfrOip5H/8wXl+9b5TG9OE3HPF+iOP
        PVNJ3pOZetHS+U+60YLc4mU7n6zUmL6Ts2iiy5T/uaGc+rOWCn2+sV38tqJBn+FpjU9qbxZU
        Jx+wF7aYf9h8PXfDAs4v811mOceLF7uc7Jhsq/jgusW7/gNyNy+tm7Zh7dYjW4rYHSayRU67
        effryTc3pHYeWhOsIXScRXmtjXJW2RolluKMREMt5qLiRAAs0NusRwMAAA==
X-CMS-MailID: 20201106073241epcas1p26fb32e0cbc18e23748709a0a87cbf7ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201106070533epcas1p480406659e38528d1263641612fcff8bb
References: <cover.1604646059.git.viresh.kumar@linaro.org>
        <CGME20201106070533epcas1p480406659e38528d1263641612fcff8bb@epcas1p4.samsung.com>
        <b3c936d862b8c81ab568f38bd7acc438cb7efac8.1604646059.git.viresh.kumar@linaro.org>
        <a2f9dbba-1c07-8b60-fda5-737843be92e0@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/6/20 4:42 PM, Chanwoo Choi wrote:
> Hi Viresh,
> 
> On 11/6/20 4:03 PM, Viresh Kumar wrote:
>> The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
>> there is no need for us to carry the extra check. Drop them.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/devfreq/exynos-bus.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index 1e684a448c9e..143fd58ec3dc 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -158,10 +158,8 @@ static void exynos_bus_exit(struct device *dev)
>>  
>>  	dev_pm_opp_of_remove_table(dev);
>>  	clk_disable_unprepare(bus->clk);
>> -	if (bus->opp_table) {
>> -		dev_pm_opp_put_regulators(bus->opp_table);
>> -		bus->opp_table = NULL;
>> -	}
>> +	dev_pm_opp_put_regulators(bus->opp_table);
>> +	bus->opp_table = NULL;
>>  }
>>  
>>  static void exynos_bus_passive_exit(struct device *dev)
>> @@ -444,10 +442,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>  	dev_pm_opp_of_remove_table(dev);
>>  	clk_disable_unprepare(bus->clk);
>>  err_reg:
>> -	if (!passive) {
>> -		dev_pm_opp_put_regulators(bus->opp_table);
>> -		bus->opp_table = NULL;
>> -	}
>> +	dev_pm_opp_put_regulators(bus->opp_table);
>> +	bus->opp_table = NULL;
>>  
>>  	return ret;
>>  }
>>
> 
> Applied it. Thanks.
> 

It seems that this patch depends on first patch.
So, need to be merged to one git repository.

Instead of applying it to devfreq.git,
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
