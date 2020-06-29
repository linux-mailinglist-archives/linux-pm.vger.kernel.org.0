Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3D20CB7B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 03:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgF2BlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 21:41:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33752 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgF2BlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2020 21:41:14 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200629014111epoutp0415af0af7455a36c88dffd5dcc323c656~c4DGc5_C22168721687epoutp04h
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:41:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200629014111epoutp0415af0af7455a36c88dffd5dcc323c656~c4DGc5_C22168721687epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593394871;
        bh=GBtYJ99sK8P3Saiy9sz/V5dmySEOt6so4nPOpaxOd1E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UUj8WJahrsDuezDABul+O8SWNVUMowOPFSORL06gANElWMIOTg7PY+xWUmRbxvG2k
         QZjBa+GawFmQcomkI3Pd7lKksyGozWhFfsxhy4oJ+6+I3h+cu2oisoTKcUCk7/dMtm
         KSxVtyd8mExScWxfqw7hz8b+SiDDsz6ItXGrmiJ0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629014110epcas1p23d5fd74dc3d119a8b3d762064f2f410c~c4DFUz-rO0780107801epcas1p20;
        Mon, 29 Jun 2020 01:41:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49w9Dy0rdbzMqYkj; Mon, 29 Jun
        2020 01:41:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.19.29173.1B649FE5; Mon, 29 Jun 2020 10:41:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200629014105epcas1p4250936a7acd173c58c1b9d46ea80ca42~c4DAVz6v41819118191epcas1p45;
        Mon, 29 Jun 2020 01:41:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200629014105epsmtrp1be4d84a978b4ca06b5cf07daeb95fa91~c4DAVCA5y0344703447epsmtrp1i;
        Mon, 29 Jun 2020 01:41:05 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-1a-5ef946b17701
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.AF.08303.1B649FE5; Mon, 29 Jun 2020 10:41:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200629014105epsmtip18c8499fe2aa0957f7e901300ddd9a1d3~c4DAHua4z0859808598epsmtip1D;
        Mon, 29 Jun 2020 01:41:05 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d66c7aba-c335-db12-5bb6-2b560422a3f7@samsung.com>
Date:   Mon, 29 Jun 2020 10:52:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmru5Gt59xBlMu2Fj0P37NbHH+/AZ2
        i7NNb9gtNj2+xmpxedccNovPvUcYLWac38dksbCphd3iduMKNovDb9pZLb6deMTowO2xZt4a
        Ro+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzpjw7SBrQatAxaIJS5gaGD/wdDFyckgImEjM
        nNnE3sXIxSEksINRYsrs+UwQzidGiRt3rrFAOJ8ZJZq/7GKEaTm+/y1UYhejxLGtE6D63zNK
        LLlxkhmkSljATmL+tV2sIAkRgRWMEm9OLWIEcZgFjjJJ7Go6xgJSxSagJbH/xQ02EJtfQFHi
        6o/HYDt4gbq3POlmBbFZBFQlLnYtBZsqKhAmcXJbC1SNoMTJmU/A5nAK2EvMbN0JVsMsIC5x
        6wnIFyC2vMT2t3OYQRZLCBzhkPh28BELxBMuEnNaGqAeEpZ4dXwLO4QtJfGyvw3KrpZYefII
        G0RzB6PElv0XWCESxhL7l04G2sABtEFTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYE
        UaIscfnBXSYIW1JicXsn2wRGpVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCY+QI38QI
        Tr1a5jsYp739oHeIkYmD8RCjBAezkgjvZ+tvcUK8KYmVValF+fFFpTmpxYcYTYEBPJFZSjQ5
        H5j880riDU2NjI2NLUwMzUwNDZXEeX2tLsQJCaQnlqRmp6YWpBbB9DFxcEo1MBVfyV/Pqh2m
        ZqI52zIucfu6CZrmln17l3tPFG3UmtbpHtTUMLGF4VRc5tcn/xOMGt91/4pM8voWNvVWxb5r
        i4U/210847vgbo/ohS8XChY9v/Y/vKglLeY/70LBmh9Wbx9rT0u/F7N0hcA1+86EjpZ8N4Zj
        Mp/nW3vc/XtbxuHVwuOxctmXFrFy89xU2cR6sGC/T+bD03bLb/KbN7JlPGFuf/+muWKadtQ/
        78bgLce+97Vut9ZUFHtzsjsvwUrjoMeyH48N9mpVNV9+eko+edbhpB9O/4IkX32YduWw+os7
        O+54eb+qnsPw7tT0W8EGZusOfy5piv9xd/0Zg3n8aSnz5Ao23NqXv4glw7l9z3clluKMREMt
        5qLiRADlueccRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnO5Gt59xBtd/8Fn0P37NbHH+/AZ2
        i7NNb9gtNj2+xmpxedccNovPvUcYLWac38dksbCphd3iduMKNovDb9pZLb6deMTowO2xZt4a
        Ro+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlTPh2kLWgVaBi0YQl
        TA2MH3i6GDk5JARMJI7vf8vSxcjFISSwg1Hi9PJn7BAJSYlpF48ydzFyANnCEocPF0PUvGWU
        mND9hwmkRljATmL+tV2sIAkRgRWMErc2/gZzmAWOM0msfb+BGaLlAZPE1nV7wVrYBLQk9r+4
        wQZi8wsoSlz98ZgRxOYFGrXlSTcriM0ioCpxsWspM4gtKhAmsXPJYyaIGkGJkzOfsIDYnAL2
        EjNbd4LVMAuoS/yZdwnKFpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHoJbWDsY9qz7oHWJk4mA8xCjBwawkwvvZ+luc
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd6vsxbGCQmkJ5akZqemFqQWwWSZODilGpjs9ZW2PJ0j
        JDCh9ZYj44KQm3ZcJ3pjveb82B8nahx+cIlBo6DQIsW7OzmUdoduYFR+lVaTyXeozHLnhXnz
        5VI43n5NWv52bePh9U8+6e4zu8UTnPlS9PrfT3HOHcrNuu/zrA1emi9bNTdq+eS3S/fcjNCX
        PXKQ6ey5GUtus11Lu8X9V1lip+EqflPjsDaLxYZZsmb997K8Pvz9ldw97ciOoJs9DAmWfq7C
        ueV8rhcbt/zc+FNuw8qq2SdvLdsRHys6MZh3BU995t9cuYbmI745Nw5MWH9giY7kCQbWRqt3
        5c/37zsfuGDJ0XWsRlr5S+6fXMdSbexr9S+GK6si53CpnPKS4y5yN+LD4/aHXPyoxFKckWio
        xVxUnAgAV5adLjADAAA=
X-CMS-MailID: 20200629014105epcas1p4250936a7acd173c58c1b9d46ea80ca42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
        <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On 6/25/20 12:11 AM, Sylwester Nawrocki wrote:
> Hi All,
> 
> On 24.06.2020 12:32, Lukasz Luba wrote:
>> I had issues with devfreq governor which wasn't called by devfreq
>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>> for it [1]. If the CPU which scheduled the next work went idle, the
>> devfreq workqueue will not be kicked and devfreq governor won't check
>> DMC status and will not decide to decrease the frequency based on low
>> busy_time.
>> The same applies for going up with the frequency. They both are
>> done by the governor but the workqueue must be scheduled periodically.
> 
> As I have been working on resolving the video mixer IOMMU fault issue
> described here: https://patchwork.kernel.org/patch/10861757
> I did some investigation of the devfreq operation, mostly on Odroid U3.
> 
> My conclusions are similar to what Lukasz says above. I would like to add
> that broken scheduling of the performance counters read and the devfreq 
> updates seems to have one more serious implication. In each call, which
> normally should happen periodically with fixed interval we stop the counters, 
> read counter values and start the counters again. But if period between 
> calls becomes long enough to let any of the counters overflow, we will
> get wrong performance measurement results. My observations are that 
> the workqueue job can be suspended for several seconds and conditions for 
> the counter overflow occur sooner or later, depending among others 
> on the CPUs load.
> Wrong bus load measurement can lead to setting too low interconnect bus 
> clock frequency and then bad things happen in peripheral devices.
> 
> I agree the workqueue issue needs to be fixed. I have some WIP code to use
> the performance counters overflow interrupts instead of SW polling and with 

It is good way to resolve the overflow issue.

> that the interconnect bus clock control seems to work much better.
>
-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
