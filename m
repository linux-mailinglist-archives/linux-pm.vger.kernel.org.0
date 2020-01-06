Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACD130B84
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 02:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgAFBba (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 20:31:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:58016 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAFBb3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 20:31:29 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200106013126epoutp024b89b2e3cab1d5dbc06c058eb7d11432~nKBoMrdEo3141931419epoutp02f
        for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2020 01:31:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200106013126epoutp024b89b2e3cab1d5dbc06c058eb7d11432~nKBoMrdEo3141931419epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578274286;
        bh=3VT2jsnbqSwTZB49bAGF93TSEbfGxtSZE2W2NtD5GKg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IFjvS9gWfzR/5IqUANVNWMF6w+8lzxWSC/djOd4S07OGCFjG+9Ew4OOXQdXGeVn1V
         TJzoGVtAixOfvsIJsjEi2BqS12UlrEp+VE4W85yZTYDNhWlMrZ255OpFO1Hi8qjCHJ
         wIUnEhgjzwygKSLWYgj+Zm9WO1F6lqQcd3ulS98o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200106013126epcas1p139555304382a9b47900ba799655158ca~nKBnieZMJ0763307633epcas1p1f;
        Mon,  6 Jan 2020 01:31:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47rdJW4lWBzMqYkd; Mon,  6 Jan
        2020 01:31:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.CD.48498.BED821E5; Mon,  6 Jan 2020 10:31:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200106013123epcas1p49edbebd5bf248f8814d56240ef670218~nKBk1VO5f0639406394epcas1p4G;
        Mon,  6 Jan 2020 01:31:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200106013123epsmtrp10e2268e22f89952b99c6a2893017c241~nKBk0Y2YR2423224232epsmtrp19;
        Mon,  6 Jan 2020 01:31:23 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-7a-5e128debde22
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.47.10238.AED821E5; Mon,  6 Jan 2020 10:31:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200106013122epsmtip1d1087755a7ebce07ebc8ba09f1acd44f~nKBkfaiSH1136211362epsmtip1c;
        Mon,  6 Jan 2020 01:31:22 +0000 (GMT)
Subject: Re: [PATCH 4/9] PM / devfreq: exynos-bus: Replace deprecated
 'devfreq' property
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzk@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Organization: Samsung Electronics
Message-ID: <76616499-7c19-06b1-461a-28ae17a76c60@samsung.com>
Date:   Mon, 6 Jan 2020 10:38:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <a54e4275-012e-77d9-bdbe-1aab64b5c12b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmge7rXqE4g6cf1Szuz2tltJh/5Byr
        xf9Hr1kt+h+/ZrY4f34Du8XZpjfsFivufmS12PT4GqvF5V1z2Cw+9x5htPj04D+zxYzz+5gs
        Fja1sFusPXKX3WLp9YtMFrcbV7BZ/N+zg91B0GPNvDWMHptWdbJ5bF5S77Hx3Q4mj74tqxg9
        tl+bx+zxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyMl3+vMBacEqtoWdzC1sC4SKiLkZNDQsBE4uTixcwgtpDADkaJ/4vCuxi5
        gOxPjBKPp/9jhXC+MUq8+t/HBtMxrXk6C0RiL6PE7fO/2SCc94wSm5beYgWpEhaIkth2YBGY
        zSagJbH/xQ2wbhEBRYnfbdPAxjILrGGWaJvymwUkwQ+UuPrjMSOIzStgJ7F1/xmgIg4OFgEV
        idvNFSBhUYEwiZPbWqBKBCVOznzCAlLCKWAvceWUPUiYWUBc4taT+UwQtrzE9rdzmEFWSQic
        YpeYdnITE8QHLhIt++ZBfSMs8er4FnYIW0riZX8blF0tsfLkETaI5g5GiS37L7BCJIwl9i+d
        zASymFlAU2L9Ln2IsKLEzt9zGSEW80m8+9oDdr6EAK9ERxs0qJUlLj+4C3WCpMTi9k62CYxK
        s5B8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgVGyJG9iRGcuLXMdjAuOudziFGAg1GJh5ch
        WChOiDWxrLgy9xCjBAezkghvo5tgnBBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB2aVvJJ4
        Q1MjY2NjCxNDM1NDQyVxXo4fF2OFBNITS1KzU1MLUotg+pg4OKUaGFXm7eLaacTF9XOK68Lr
        +Xonv0Q8Wfp6rcZW4euJuQbMZlon2qtkfVfqbT3wM/xmeMHE+OjZry+nR39zTfiv+ObgrvRX
        z3WsDbZnWDVaxW5ebdi5f+F5qz2ePwL+bq3bzfBeu/X2hwf7gxeKvlm43n6tRnhUM4ONlzJ7
        PkcYC3PG1HyFE9PidymxFGckGmoxFxUnAgCG0r0r8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSnO6rXqE4g7edNhb357UyWsw/co7V
        4v+j16wW/Y9fM1ucP7+B3eJs0xt2ixV3P7JabHp8jdXi8q45bBafe48wWnx68J/ZYsb5fUwW
        C5ta2C3WHrnLbrH0+kUmi9uNK9gs/u/Zwe4g6LFm3hpGj02rOtk8Ni+p99j4bgeTR9+WVYwe
        26/NY/b4vEkugD2KyyYlNSezLLVI3y6BK+Pl3yuMBafEKloWt7A1MC4S6mLk5JAQMJGY1jyd
        pYuRi0NIYDejRO/Kn0wQCUmJaRePMncxcgDZwhKHDxeDhIUE3jJK/G8PBLGFBaIkth1YxApi
        swloSex/cYMNxBYRUJT43TaNFWQms8AaZonzPd1QCyYxSax8sxGsih+o6uqPx4wgNq+AncTW
        /WdYQZaxCKhI3G6uAAmLCoRJ7FzymAmiRFDi5MwnLCAlnAL2EldO2YOEmQXUJf7Mu8QMYYtL
        3HoynwnClpfY/nYO8wRG4VlIumchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGCI1hLcwfj5SXxhxgFOBiVeHhXBAjFCbEmlhVX5h5ilOBgVhLhbXQTjBPiTUms
        rEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBUavr0C3B4Cn8z4zv
        Nd+p0fP4fuhobP/17esrHpvwHk+ZPJPVevKKd5oN2reCPDUfzOdvapjLKdlcvTJV4BFba03k
        BRun6aKfbI0+mgWbfWZ4a5v2uzyaeTPbX8fIg/89a132rm5cn+B2xcLpcprVYsdq35x0XkbJ
        QE6m3Q9vRU8VqdnzO3uLEktxRqKhFnNRcSIAgoO6E9wCAAA=
X-CMS-MailID: 20200106013123epcas1p49edbebd5bf248f8814d56240ef670218
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055106epcas1p11f2bc81d6bb2db3fc4bc257d78c337b9
References: <20191217055738.28445-1-cw00.choi@samsung.com>
        <CGME20191217055106epcas1p11f2bc81d6bb2db3fc4bc257d78c337b9@epcas1p1.samsung.com>
        <20191217055738.28445-5-cw00.choi@samsung.com> <20191226210119.GA8706@bogus>
        <a54e4275-012e-77d9-bdbe-1aab64b5c12b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Gently Ping.

On 12/27/19 9:09 AM, Chanwoo Choi wrote:
> On 12/27/19 6:01 AM, Rob Herring wrote:
>> On Tue, Dec 17, 2019 at 02:57:33PM +0900, Chanwoo Choi wrote:
>>> In order to remove the deprecated 'devfreq' property, replace with
>>> new 'exynos,parent-bus' property in order to get the parent devfreq device
>>> in devicetree file instead of 'devfreq' property. But, to guarantee the
>>> backward-compatibility, keep the support 'devfreq' property.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  .../bindings/devfreq/exynos-bus.txt           | 16 +++++++--------
>>>  drivers/devfreq/exynos-bus.c                  | 20 ++++++++++++-------
>>>  2 files changed, 21 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> index e71f752cc18f..c948cee01124 100644
>>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> @@ -45,7 +45,7 @@ Required properties only for parent bus device:
>>>    of buses.
>>>  
>>>  Required properties only for passive bus device:
>>> -- devfreq: the parent bus device.
>>> +- exynos,parent-bus: the parent bus device.
>>
>> If you are going to do something new, why not use the interconnect 
>> binding here?
> 
> As I knew, interconnect make the data path among multiple nodes
> and set the average and peak bandwidth to the specific data path.
> 
> It means that some data will be flowed from node_a to node_d
> or the reverse way because each node has the tightly coupled
> dependency for data flow.
> 
> 	node_a <-> node_b <-> node_c <-> node_d
> 
> 
> On the other hand, exynos-bus.c driver is not related to 'data path'.
> Each bus just need to control the their own frequency and voltage.
> But, share the power line (regulator) between exynos-bus device
> even if there are no any dependency of data flow.
> 
> 'exynos,parent-bus' property just indicate the specific
> devfreq device(parent bus device) which controls
> the shared power line(regulator) in order to prevent
> the h/w problem due to the wrong pair of frequency and voltage.
> 
> 'exynos,parent-bus' property is only used to catch
> the change timing of shared power line.
> 
> 
> And,
> as you commented, there are some data path among the exynos-bus
> devices for the display h/w as following:
> 
> 	bus_display -> bus_leftbus -> bus_dmc
> 
> In order to make the data path between bus devices,
> interconnect binding is required. This approach[1] was posted.
> [1] https://patchwork.kernel.org/cover/11305265/
> - [RFC,v3,0/7] PM / devfreq: Simple QoS for exynos-bus using interconnect
> 

Are there any other commentss?


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
