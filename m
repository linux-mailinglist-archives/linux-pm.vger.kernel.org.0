Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1775C20B78D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgFZRud (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 13:50:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49191 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZRud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 13:50:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200626175031euoutp01bafce4a53d0cdd793aaa29c11df79960~cKVkwLJCn1504415044euoutp01Q
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 17:50:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200626175031euoutp01bafce4a53d0cdd793aaa29c11df79960~cKVkwLJCn1504415044euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593193831;
        bh=xSiB+0bcJ6gqaHQQW/JlglYx4ltOHCmHixD8o+J+bJ4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iegxD2XbOSUIk9KYF3h0+50BUjoFJJnNv1u0uTPkv9+qvTYRlNS0H6al+dIJtw6hV
         Y3XsskLnRo7WswEy1A9As4n9j7kp5gpXZzTtTRpGGj5Z7qlvAUTA1PPGTp3HNShHeD
         LNU+DqBOUBvOJKvmCjNmm5qFM4GBHHSTW/2REsR8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200626175030eucas1p20d63917468dd11dad46e3915ba694847~cKVkBDO9X0495504955eucas1p2e;
        Fri, 26 Jun 2020 17:50:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 63.03.06456.66536FE5; Fri, 26
        Jun 2020 18:50:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200626175029eucas1p131a223f6371e01f88c9bc245e10d2699~cKVjmFJlh2464324643eucas1p1-;
        Fri, 26 Jun 2020 17:50:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200626175029eusmtrp201557a4ce0eeccc9b477761d8452c616~cKVjlbZe_1801118011eusmtrp2q;
        Fri, 26 Jun 2020 17:50:29 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-11-5ef635662503
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.CA.06017.56536FE5; Fri, 26
        Jun 2020 18:50:29 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200626175028eusmtip1faefa4680763a54bc73309bdb88ce92e~cKVicMkDa2150821508eusmtip1e;
        Fri, 26 Jun 2020 17:50:28 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <708feba7-6b11-4943-1073-a1b5e54b6283@samsung.com>
Date:   Fri, 26 Jun 2020 19:50:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87pppt/iDE5uF7K4/uU5q0X/49fM
        FufPb2C3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWC5ta2C1uN65gs/h24hGjA7fHmnlr
        GD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV0XfxN1vBdomK3T95
        GxhfCHcxcnJICJhI3HjwhL2LkYtDSGAFo8TrJX9YIZwvjBKnb21ig3A+M0osWtbFCtMy/9k3
        ZojEckaJF60ToVo+Mkoc2nGKHaRKWMBOYv61XWAdIgKqEtcu3GUBKWIWOMgssffLGWaQBJuA
        oUTv0T5GEJsXqOHOnglgzSxADQfeHQdrFhWIlehbuoANokZQ4uTMJywgNqeAtcTLq2fA4swC
        4hK3nsxngrDlJba/nQN2noTALXaJO5eusEHc7SIx78cGqB+EJV4d38IOYctI/N8J0gzS0Mwo
        0bP7NjuEM4FR4v7xBYwQVdYSd879AprEAbRCU2L9Ln2IsKPE22NvmEHCEgJ8EjfeCkIcwScx
        adt0qDCvREebEES1isTvVdOZIGwpie4n/1kmMCrNQvLaLCTvzELyziyEvQsYWVYxiqeWFuem
        pxYb5qWW6xUn5haX5qXrJefnbmIEpq3T/45/2sH49VLSIUYBDkYlHt4XD77GCbEmlhVX5h5i
        lOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYO
        TqkGxt27q7RuLWCvnZfCNONM4IRJk/xmHZ09VZFTUHTqgicPSviWLpBXPfc0+JMHW9yul53u
        y5c1V4k4Rbp7PCkxtqlct6/U1jIrVmZ+kslCvrmrBWzN1rQcebe184K75OnpuvUWBgXxpXvs
        e0SMq7tvS0sIdB277Deb6YHgPi9be68Z5vHnXSWSlViKMxINtZiLihMBVqHxulcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7qppt/iDO6cMLe4/uU5q0X/49fM
        FufPb2C3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWC5ta2C1uN65gs/h24hGjA7fHmnlr
        GD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0XfxN1vBdomK3T95GxhfCHcxcnJICJhIzH/2jbmL
        kYtDSGApo0T7811sXYwcQAkpifktShA1whJ/rnWxQdS8Z5SYdPcfE0hCWMBOYv61XawgtoiA
        qsS1C3dZQIqYBQ4zSxw7dZgVomMis8SD1ntsIFVsAoYSvUf7GEFsXqDuO3smsIPYLEDdB94d
        B5skKhAr8e3eFjaIGkGJkzOfsIDYnALWEi+vngGLMwuoS/yZd4kZwhaXuPVkPhOELS+x/e0c
        5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbptmM/t+xg
        7HoXfIhRgINRiYf3xYOvcUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK
        9NxEZinR5HxgAskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC4
        j/2K/XZdlhI//SMmPx/suHboVq7gzJJTkoqLfTxf3jzNaH4ryjkpgDn2pfA8Rs41O7dKJGxS
        8Haw13etVdfvPSzkqK28Te5w8f5PumqTnmoGJBW3hJlcXv87WXmL6b8kt7U3PzkKNPV1VZf6
        VWfMUnJcP2njr98aYv1/VK0uZevdzvKqvqDEUpyRaKjFXFScCAASuzkY6AIAAA==
X-CMS-MailID: 20200626175029eucas1p131a223f6371e01f88c9bc245e10d2699
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
        <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
        <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 25.06.2020 12:02, Lukasz Luba wrote:
> Regarding the 'performance counters overflow interrupts' there is one
> thing worth to keep in mind: variable utilization and frequency.
> For example, in order to make a conclusion in algorithm deciding that
> the device should increase or decrease the frequency, we fix the period
> of observation, i.e. to 500ms. That can cause the long delay if the
> utilization of the device suddenly drops. For example we set an
> overflow threshold to value i.e. 1000 and we know that at 1000MHz
> and full utilization (100%) the counter will reach that threshold
> after 500ms (which we want, because we don't want too many interrupts
> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
> threshold after 50*500ms = 25s. It is impossible just for the counters
> to predict next utilization and adjust the threshold.

Agreed, that's in case when we use just the performance counter (PMCNT)
overflow interrupts. In my experiments I used the (total) cycle counter
(CCNT) overflow interrupts. As that counter is clocked with fixed rate
between devfreq updates it can be used as a timer by pre-loading it with 
initial value depending on current bus frequency. But we could as well 
use some reliable system timer mechanism to generate periodic events. 
I was hoping to use the cycle counter to generate low frequency monitor 
events and the actual performance counters overflow interrupts to detect 
any sudden changes of utilization. However, it seems it cannot be done 
with as simple performance counters HW architecture as on Exynos4412.
It looks like on Exynos5422 we have all what is needed, there is more 
flexibility in selecting the counter source signal, e.g. each counter
can be a clock cycle counter or can count various bus events related to 
actual utilization. Moreover, we could configure the counter gating period 
and alarm interrupts are available for when the counter value drops below 
configured MIN threshold or exceeds configured MAX value.

So it should be possible to configure the HW to generate the utilization 
monitoring events without excessive continuous CPU intervention.
But I'm rather not going to work on the Exynos5422 SoC support at the moment.

> To address that, we still need to have another mechanism (like watchdog)
> which will be triggered just to check if the threshold needs adjustment.
> This mechanism can be a local timer in the driver or a framework
> timer running kind of 'for loop' on all this type of devices (like
> the scheduled workqueue). In both cases in the system there will be
> interrupts, timers (even at workqueues) and scheduling.
> The approach to force developers to implement their local watchdog
> timers (or workqueues) in drivers is IMHO wrong and that's why we have
> frameworks.

Yes, it should be also possible in the framework to use the counter alarm
events where the hardware is advanced enough, in order to avoid excessive 
SW polling.

--
Regards,
Sylwester
