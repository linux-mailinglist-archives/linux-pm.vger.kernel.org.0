Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2946B3780
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfIPJuA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 05:50:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41176 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbfIPJuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 05:50:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190916094957euoutp02248086f3fe2685eb118a83975cb2c7b7~E4k6z5BBE0407104071euoutp02B
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2019 09:49:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190916094957euoutp02248086f3fe2685eb118a83975cb2c7b7~E4k6z5BBE0407104071euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568627397;
        bh=iuHLb85Z2D3Szb5HcwZ4eEWC4tX/t5FH2HMb/lXL8xM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LUYpa4Sh3S8XjbZGY7vITT/EJ2IwD14Svik/lE5EvSYeHsJJ2Gg9EfVQmJ6I4DS1f
         IVz8ZJFtLTOd/DZ/78TydKSRZjizifz9P7Ut2Ak33BDiZjoavUaf1UIKqt4Zk08s7N
         ppojjdbIUeBAgzWV0v50tmR2hIQwVSrrt82gbEmI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190916094957eucas1p1035b14c56a867a0206e2e1d11c19645b~E4k5-3U-E2395523955eucas1p1O;
        Mon, 16 Sep 2019 09:49:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.1B.04374.4CA5F7D5; Mon, 16
        Sep 2019 10:49:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190916094956eucas1p24cc2a1dfa8565ba6e1ff3d4fd1f09f73~E4k5KmyED0502405024eucas1p2M;
        Mon, 16 Sep 2019 09:49:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190916094955eusmtrp2debf0d072bbc1b2e06241b7ea59df52d~E4k48V3iW1858618586eusmtrp2l;
        Mon, 16 Sep 2019 09:49:55 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-2e-5d7f5ac4b73e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.F0.04166.3CA5F7D5; Mon, 16
        Sep 2019 10:49:55 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190916094954eusmtip11d9afbb904d4a61073bd82cea965e2cb~E4k33i_DG2359023590eusmtip12;
        Mon, 16 Sep 2019 09:49:54 +0000 (GMT)
Subject: Re: [PATCH 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3
 memories
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <a06caf21-b2a9-919f-6e73-69122fee5f66@partner.samsung.com>
Date:   Mon, 16 Sep 2019 11:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d7ba95a.1c69fb81.bfd81.77ba@mx.google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2Li4nn1PzRaNwEN1Q0/rjWNIFREYEldGFYtmqg0Zu051W
        qyRXoGml3cDLMldQrdZqtWxeikW6vJS6ZFR2o4uDoKaBWiSrzHkm+d/vfd7n430e+BhC9paM
        Y/Zo9nE6jSpPTknEzrbRnkT31iLloiFHInu32k6yr0a+kKzZ3UOyp/u/EazHc4dmu4/5adbR
        /5Jkvc21FDtc7kZstcclYm+539Ps1Ve9Ivbt0esUO/awkWZb/cdJ9mfHZ7QSK2x1NqRoMr2n
        FQ5rGaW4d6VIUVFvRYphx6x11FZJ+m4ub89+Tpe8fIckt/mkXZTfFGfwtV6mjMgZcwKFMYCX
        wOO2TnQCSRgZvo6gq+sJIQwjCDpGn9DCMIygu26Qmnxy8/yN0MKCoMVRGRoGEHjbAqKgKwpv
        hK6TATrI0VgB72ptEyYC28RgMn4Yv8gwFE6CRmtB0CPFmeC7cVYcZDGeA2W9T4kgx+AtMPSx
        lRQ8kdBZ45vwhOE0KGnwTDCBY+GNzywSeDY0DNROdAD8h4bOd15CiJ0Bpe02kcBR8LW9nhZ4
        Jow1mUM6D8byy0jgQug/fTHkWQat7b1kMDOB54O9OVmQV8GY6RwVlAFHQN9ApBAhAs45qwhB
        lkJpiUxwz4P6U89Dh2aAxVZJn0Fy05RipillTFPKmP7fvYTEVhTL6Xl1Dscv1nAHkniVmtdr
        cpJ2adUONP7lnv1t/9GIXL93tiDMIHm41Fh8RCkjVfv5g+oWBAwhj5ZuLj2slEl3qw4e4nTa
        bJ0+j+NbUDwjlsdKD0/7uE2Gc1T7uL0cl8/pJrciJizOiLJvv+bM14pS5Pq4NE6XubT7bL4y
        zeBiZlesfxO/qVird4UXfE/Aqele/xp11vOM1Bff+fslqwt/NfMa1+AKrVnVEzhQ98DlvjBk
        8cf0Wa55PznnagwdJnPkM7stkMlNpz4zfQs/VSVkFNdkJb3WSdfKDIOPvsQGyjbEt22/Khfz
        uaqUBYSOV/0DAL2IlG4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7qHo+pjDU5OMLHYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvF/z072C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsat7
        PVPBTqmKJ4cXsjUwbhPtYuTkkBAwkVg9eSV7FyMXh5DAUkaJ5/eOskAkxCQm7dvODmELS/y5
        1sUGYgsJvGaUuDufB8QWFgiVONP9G6xGRMBD4s6cNWCDmAXWsUgsnviaCaLhILNE51G9LkYO
        DjYBPYkdqwpBwrwCbhJPVk4E28UioCrRefEUM4gtKhAhcXjHLEaIGkGJkzOfgNVwClhKtG0/
        D2YzC5hJzNv8kBnCFpe49WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem
        5xYb6hUn5haX5qXrJefnbmIERvW2Yz8372C8tDH4EKMAB6MSD29Da12sEGtiWXFl7iFGCQ5m
        JRHe8I7qWCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByacvJJ4Q1NDcwtLQ3Njc2MzCyVx
        3g6BgzFCAumJJanZqakFqUUwfUwcnFINjDxuaQvCPuYennXzMbu58wXbnBnc6bO2yy6aaavs
        Oenz3hNLQ/3izCduPJInuJb9+CeefN4NLUZCM7+n9NUJXlOXDJ7KP6/h57726lsm7Q+jUk59
        beZnP7ms/4R0z4/8sGU1wWY7SoqdObMZn625e+GX0g2n3GL53/LS5ms0rLqXLdz7mL3ipRJL
        cUaioRZzUXEiACZDB4wAAwAA
X-CMS-MailID: 20190916094956eucas1p24cc2a1dfa8565ba6e1ff3d4fd1f09f73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190906101407eucas1p15eb0df53374b27497b4793eab24becf6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190906101407eucas1p15eb0df53374b27497b4793eab24becf6
References: <CGME20190906101407eucas1p15eb0df53374b27497b4793eab24becf6@eucas1p1.samsung.com>
        <20190906101344.3535-1-l.luba@partner.samsung.com>
        <20190906101344.3535-4-l.luba@partner.samsung.com>
        <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com>
        <52963d0d-cf48-7085-5581-a94c6e15e0bd@partner.samsung.com>
        <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
        <5d7ba95a.1c69fb81.bfd81.77ba@mx.google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 9/13/19 4:36 PM, Rob Herring wrote:
> On Fri, Sep 06, 2019 at 01:50:26PM +0200, Krzysztof Kozlowski wrote:
>> On Fri, 6 Sep 2019 at 13:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>
>>> Hi Krzysztof,
>>>
>>> On 9/6/19 12:56 PM, Krzysztof Kozlowski wrote:
>>>> On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>>
>>>>> Add description of bindings for Samsung k3qf2f20db LPDDR3 memory.
>>>>> Minor fixes in the old documentation.
>>>>>
>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>> ---
>>>>>    .../devicetree/bindings/ddr/lpddr3.txt        | 29 +++++++++++++++++--
>>>>>    1 file changed, 27 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>>>>> index 3b2485b84b3f..de0905239767 100644
>>>>> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
>>>>> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>>>>> @@ -40,10 +40,34 @@ Child nodes:
>>>>>      a given speed-bin. Please see Documentation/devicetree/
>>>>>      bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
>>>>>
>>>>> +Samsung K3QF2F20DB LPDDR3 memory
>>>>> +------------------------------------------------------------
>>>>> +
>>>>> +This binding uses the LPDDR3 binding (described above)
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible:  Should be:
>>>>> +               "samsung,K3QF2F20DB"
>>>>> +               followed by "jedec,lpddr3"
>>>>> +- density  : <u32> representing density in Mb (Mega bits)
>>>>> +- io-width : <u32> representing bus width. Possible value 32
>>>>> +- #address-cells: Must be set to 1
>>>>> +- #size-cells: Must be set to 0
>>>>
>>>> If you decided to repeat all properties again, then it deserves its
>>>> own bindings file. However I though about simpler solution - just
>>>> document compatible. Exactly the same as AT24 or AT25 EEPROM bindings.
>>>> There is not much benefit from copying all these properties.
>>> OK, I see. I will add only 'compatible' and skip the rest then.
>>> So the lpddr3.txt file will get this addition:
>>>
>>> +Samsung K3QF2F20DB LPDDR3 memory
>>> +------------------------------------------------------------
>>> +
>>> +This binding uses the LPDDR3 binding (described above)
>>> +
>>> +Required properties:
>>> +- compatible:  Should be:
>>> +               "samsung,K3QF2F20DB"
>>> +               followed by "jedec,lpddr3"
>>> +
>>> +Optional properties:
>>> +
>>> +The optional properties are the same as in the LPDDR3 generic bindings and
>>> +values should be taken from the data-sheet. Detailed bindings are described
>>> +above.
>>> +
>>> +Child nodes:
>>> +
>>> +Detailed bindings are described in LPDDR3 generic bindings described above.
>>> +
>>>
>>> Is it OK?
>>
>> To me it is still a lot of text just for one compatible and I can
>> image more of such entries for other memories... However I do not mind
>> and anyway, YAML will simplify it. If you're in doubt, wait for Rob's
>> reply as this is his part.
> 
> We can't have multiple (top-level) schema in one file, so better to add
> in where the existing compatible strings are.

Thank you for your comment. I will add the needed string into existing
compatible then.

Regards,
Lukasz

