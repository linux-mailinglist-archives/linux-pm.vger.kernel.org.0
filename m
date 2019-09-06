Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7BAB7E4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbfIFMON (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 08:14:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35372 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfIFMON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 08:14:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190906121411euoutp01cc70dd2d487d9ff347d00b23c1d171bb~B2F-t0Cgs3205132051euoutp018
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 12:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190906121411euoutp01cc70dd2d487d9ff347d00b23c1d171bb~B2F-t0Cgs3205132051euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567772051;
        bh=8bq0zyXxMMGz7JArDAMaWTFTMXYIKCVTlRXFaU/lxLE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BVLCNstXliCJiSTE7hI5qCqLLBUnseQWq+OqvRkBiE7qqylf5ezN3RPTKorz3fW6x
         14vcgFmCV8izPuOgtv/Sy+TDZcra7i3o1It4IfZmyejGd2+jwrTEb/84DAezjuCoWg
         nSAtx6VEbdFTjykv6kxveRDOg6MiJ0eopr1N0YjQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190906121410eucas1p20d604a2935d841fd3c0bfaf07c151ec2~B2F_zQnIv1615716157eucas1p2b;
        Fri,  6 Sep 2019 12:14:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 60.08.04374.29D427D5; Fri,  6
        Sep 2019 13:14:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190906121409eucas1p19c9b4675d6a4a60f3fedae6597be10f3~B2F97UTwZ1740117401eucas1p1e;
        Fri,  6 Sep 2019 12:14:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190906121409eusmtrp14ca8de593255321a04aeaa0d5ddbb3c8~B2F9sce9B2099920999eusmtrp1R;
        Fri,  6 Sep 2019 12:14:09 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-21-5d724d9287d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.F0.04117.19D427D5; Fri,  6
        Sep 2019 13:14:09 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190906121408eusmtip24d7641472ec9002de43140e73e4a2ab1~B2F9DGPpa0190101901eusmtip2x;
        Fri,  6 Sep 2019 12:14:08 +0000 (GMT)
Subject: Re: [PATCH 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3
 memories
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <99d2f2be-80f8-258c-2621-a4b5ff5cd177@partner.samsung.com>
Date:   Fri, 6 Sep 2019 14:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSyVYRjGe877eaxjb4e4+1htp9ZkIWPr2ZJJzU5tUX+0VaY68nYYDp0X
        faloqI6PSiuc6csqnEgOIRPrOIsSslosaUIpH2tFGil5vSz//e7rvp7nvq9nD0soO6mlbJgu
        htfrNBEq2oaseDbe6pK5Qx+0vtG6Cpdml1C4fbSfwjetLRS+2DtI4NbWhwxuPjvEYHPvWwq/
        rs6l8Ui6FeHs1loZLrZ2Mfhue5sMdyYW0Dj5iZXB9UPnKDzW2IN8OHXRjSKkfmzsYtRm0wVa
        XXbnjDqj3ITUI+YVO+l9Nl4hfERYHK938z5oEzpVUUhE319ybLCygU5AVfYGJGeB84TvOUnI
        gGxYJVeAoL+rbrYYRWCsGWakYgRBcf2YbO5I7t0eWmrkI8gy5JFSMYxgMu0FLbrsuN3wMvU3
        I7I9txba//yiRBPBWUjIrh6fvoplac4VqkxHRI+C84PU0c+UyCS3Gi53fSFFXsztgR/d9ZTk
        WQTPc/pmdDm3C9KTemdmEZwjvOu7KZN4JVQO5xLiLOASWbjV+ImU1t4KX8tv0BLbwUBDOSPx
        cmi6kjbrESAh/TaSOB56L16f9WyE+oY2StyZmA5TUu0myZthyphJizJwttAxvEhawRYyK7II
        SVbA+RSl5HaC8rRXs2/oAPlF15hLSGWcF8w4L4xxXhjj/7m3EGlCjnysEKnlBQ8df9RV0EQK
        sTqt66GoSDOa/nJNfxt+VqHayWAL4likWqjo9tEHKSlNnHA80oKAJVT2ipLS6CClIkRz/ASv
        jzqgj43gBQtaxpIqR8XJBd2BSk6rieHDeT6a1891Zax8aQLKrzqg/pjEJOcN+Ha0+18VmA8O
        273GDgdO7DfUOuc0B3v5ugQMbik9kZdIjevej9R9k6908rtd/DPZP8UwKHPYZgpK4gssLZBq
        P+4+hgMKJ9YdzMh+sEl5elddv+cpPjjgTXgZTdY4FUdvuNck31mi9fHY6xzhXal6umb3I008
        ryKFUI27M6EXNP8AELsQK24DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7oTfYtiDQ63qVpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZLb6deMToIOCxZt4aRo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWw
        RenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl/N+2
        krlgtWTF6+3H2RoYd4h0MXJySAiYSMxZ+oiti5GLQ0hgKaPEh8OtrBAJMYlJ+7azQ9jCEn+u
        dUEVvWaUWLdkI1hCWCBU4kz3bzBbREBT4vrf76wgRcwCh1gkPm09zgjRMYlZYvWfqyxdjBwc
        bAJ6EjtWFYI08Aq4SXR/eQa2jUVARWLi3RcsILaoQITE4R2zGCFqBCVOznwCFucUCJTobXnM
        BmIzC5hJzNv8kBnCFpe49WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem
        5xYb6RUn5haX5qXrJefnbmIERva2Yz+37GDsehd8iFGAg1GJh/eBQ1GsEGtiWXFl7iFGCQ5m
        JRHe9RsLYoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5h08kriDU0NzS0sDc2NzY3NLJTE
        eTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MKp53nDxc0m0ZvQ09tv4Z0nUAdYliz+d5ErtEPvy
        52Tl/L87HaqlraW26CbdSdnwqUqzWtYt9ImVWNqNBrFtFy476DOIpE56e9d6+fS4yWZT7Naf
        qLx2mff7ystGOVJWbzfIRcXe3X+89m5H5FKdK/e5XoWtOP3lUJ1M8uJqsZeNy5atWLl+XZ4S
        S3FGoqEWc1FxIgB7L0JuAgMAAA==
X-CMS-MailID: 20190906121409eucas1p19c9b4675d6a4a60f3fedae6597be10f3
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/6/19 1:50 PM, Krzysztof Kozlowski wrote:
> On Fri, 6 Sep 2019 at 13:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On 9/6/19 12:56 PM, Krzysztof Kozlowski wrote:
>>> On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>
>>>> Add description of bindings for Samsung k3qf2f20db LPDDR3 memory.
>>>> Minor fixes in the old documentation.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    .../devicetree/bindings/ddr/lpddr3.txt        | 29 +++++++++++++++++--
>>>>    1 file changed, 27 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>>>> index 3b2485b84b3f..de0905239767 100644
>>>> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
>>>> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>>>> @@ -40,10 +40,34 @@ Child nodes:
>>>>      a given speed-bin. Please see Documentation/devicetree/
>>>>      bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
>>>>
>>>> +Samsung K3QF2F20DB LPDDR3 memory
>>>> +------------------------------------------------------------
>>>> +
>>>> +This binding uses the LPDDR3 binding (described above)
>>>> +
>>>> +Required properties:
>>>> +- compatible:  Should be:
>>>> +               "samsung,K3QF2F20DB"
>>>> +               followed by "jedec,lpddr3"
>>>> +- density  : <u32> representing density in Mb (Mega bits)
>>>> +- io-width : <u32> representing bus width. Possible value 32
>>>> +- #address-cells: Must be set to 1
>>>> +- #size-cells: Must be set to 0
>>>
>>> If you decided to repeat all properties again, then it deserves its
>>> own bindings file. However I though about simpler solution - just
>>> document compatible. Exactly the same as AT24 or AT25 EEPROM bindings.
>>> There is not much benefit from copying all these properties.
>> OK, I see. I will add only 'compatible' and skip the rest then.
>> So the lpddr3.txt file will get this addition:
>>
>> +Samsung K3QF2F20DB LPDDR3 memory
>> +------------------------------------------------------------
>> +
>> +This binding uses the LPDDR3 binding (described above)
>> +
>> +Required properties:
>> +- compatible:  Should be:
>> +               "samsung,K3QF2F20DB"
>> +               followed by "jedec,lpddr3"
>> +
>> +Optional properties:
>> +
>> +The optional properties are the same as in the LPDDR3 generic bindings and
>> +values should be taken from the data-sheet. Detailed bindings are described
>> +above.
>> +
>> +Child nodes:
>> +
>> +Detailed bindings are described in LPDDR3 generic bindings described above.
>> +
>>
>> Is it OK?
> 
> To me it is still a lot of text just for one compatible and I can
> image more of such entries for other memories... However I do not mind
> and anyway, YAML will simplify it. If you're in doubt, wait for Rob's
> reply as this is his part.

You are definitely right, YAML will simplify this.
I will wait a few days with the v2 series, maybe Rob would like to see
something different. If not, I will send v2 with the above change.
Thank you for your comments.

Regards,
Lukasz

