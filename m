Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69C01008D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfD3UEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:04:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60464 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfD3UEj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:04:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190430200437euoutp01731739e8eb3c83060dc25ec8e117119b~aWS5oFjyr1249212492euoutp01q
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 20:04:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190430200437euoutp01731739e8eb3c83060dc25ec8e117119b~aWS5oFjyr1249212492euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556654677;
        bh=Gpy8BLya4g2MHxARJxwy2Jm4W95tw290iv7EKrZLDV8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KISzi5OKkCl1BAoQPlogjigM3qKs+Rx1iQDG5cfcRiFtcP1TrWSIWrwyDhSb9WAox
         6082RJpmA6YFkvXfAMDdRHct3+4arjl2zfFfVukkPddjKFmSLy5piT/wCKxoMJiIo7
         D9BGx5TLRBdkvtnLzh+phnjjvvumIwV39cK7ON1w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430200435eucas1p15920c8ae72064a01a4a7225d354561c4~aWS4TUu_Q3239632396eucas1p1V;
        Tue, 30 Apr 2019 20:04:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.B4.04325.35AA8CC5; Tue, 30
        Apr 2019 21:04:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430200434eucas1p2efc6bb09f7af8ec07a7fdb55d0cb8f96~aWS22uWm12356923569eucas1p2_;
        Tue, 30 Apr 2019 20:04:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430200433eusmtrp1cad2d4fcd586e20f5eb8655faab30509~aWS2nE0Dj1284412844eusmtrp1Z;
        Tue, 30 Apr 2019 20:04:33 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-3c-5cc8aa5331f7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.93.04146.15AA8CC5; Tue, 30
        Apr 2019 21:04:33 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430200432eusmtip14784aaba9aafcbbd8a66b7df6e497250~aWS1mADMd0208402084eusmtip1r;
        Tue, 30 Apr 2019 20:04:32 +0000 (GMT)
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <cb929f1d-409c-ad06-e9b2-83ce104664fd@partner.samsung.com>
Date:   Tue, 30 Apr 2019 22:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJUNw_aDKjWf4TkJWQFhhLCrGYWbTtWpz5jkyeONRcpQw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe95nrun49rTVfqsWrjNpE1YxteyZDMemY1hMxqOnlXTVe5R
        5MeUFEVlleiUq82PXIgkJ4ST7tJv+bXox2Rl6Th1FRVx92T67/V9f97fz+fz/u5LE/JvlDsd
        HrmPU0cqIxRiKVle/bNx3kadKXjByFNnfPt8CYXfWnsorK1qoHDx9y6Es17ki3DdKRXO6PpC
        4MbGWxJcf6xPglsq8sR4IK0K4fONlSJ8o6pNgt8nFInx+EO9BD/rO0Hhx6+C8PtRRzxk+ogC
        ndmhwUySvRDfTLL3NW0StlSXImbTEr+K2fQyHWLv1B5iB0q91tNbpctCuIjwWE49P2CnNOzz
        cD8Vfd/9QFLfEyIe6V1TkQMNzCJIuJZI2FjOFCHIMwalIulftiKwpNSIhcMAgg+dN6lURNtv
        jFuWCvpVBMbmSxMmM4JU0whpa+XMbIPe9FeUjV2YWTCanEPZTAQzSEHy9Wxk6yRmfEGv22vz
        yJhVYBnIta9BMrOhX9tu7+PKbIGO6luU4HGCmtxPdt2B2QDawkRkY4Jxg9ZPWpHAM+CeOY+w
        zQLmMg3tD5IIIedKONtqRgI7Q6+xTCKwJ9RmnSYF5iE+rXDCcxi6MvInPP7wzNhsT08wc6Gk
        Yr4gr4DW6iKx8CiO8M7sJKzgCJnl5whBlsHJZLng9oay000igafD1es5kjNIoZkUTDMpjGZS
        GM3/uQWI1CE3LoZXhXK8XyS335dXqviYyFDf3VGqUvT3G9b+Ng7qUeXYLgNiaKSYJvNeYwqW
        U8pYPk5lQEATChcZa3weLJeFKOMOcuqoHeqYCI43IA+aVLjJDk3p3CZnQpX7uD0cF82p/1VF
        tIN7PPKO2O55JHv0wVdLce4c/6xYq2HBYa3qrL47p7c2M8Cn33p3+ErIY+vikqPH52xucdNX
        eUnbwhreLLm5f8zv8ryxd931HzZ51K19WfCdf3RpXQCnbgpsMwSuKumo7M71nhk7WPG7MLDP
        tKXHvPpX71Qf/a+O0pRlU73GXl+0/Fje86aoXEHyYcqFPoSaV/4BouTD24IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4Xd3AVSdiDC71ylpsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxf89O9gtDr9pZ7XYf8XL4vZvPotvJx4xOgh7fPs6icVjdsNFFo+ds+6ye2xa
        1cnm0dv8js2jb8sqRo/Np6s9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mt48f0Ta8FOqYrWNweYGxh3iHYxcnBICJhI/P9g2cXIxSEk
        sJRRYuaHTyxdjJxAcTGJSfu2s0PYwhJ/rnWxgdhCAq8ZJf7f4wOxhQWiJV71XWEFsUUEFCV+
        t01jBRnELPCTVeLMoSZGiKktzBIn9r1mAdnGJqAnsWNVIUgDr4CbxIfPM5lBbBYBVYlP8++B
        LRYViJA4834FC0SNoMTJmU/AbE6BQIn5C5sZQWxmATOJeZsfMkPY4hK3nsxngrDlJba/ncM8
        gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzABLDt2M/NOxgv
        bQw+xCjAwajEw3vB7USMEGtiWXFl7iFGCQ5mJRFej+NHY4R4UxIrq1KL8uOLSnNSiw8xmgI9
        N5FZSjQ5H5ic8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MCqK
        2M7d9uL+kf8/Fin9OPFcT47hq5Ho3PWZHz9pv5lgUxzVpnre/aXLMs4tj74+OKKpeC/dTFX/
        HtdXyTrmSTwn86Y7nusO2Cz/TkL/HefRJLuyJbJBzqfVTX/uDJzz+HGq9Y6Dlg29z/mSJsye
        0nVLPqxe7KKkxFr5ua7+vgUfYqfNdXjnLKzEUpyRaKjFXFScCACy877cFgMAAA==
X-CMS-MailID: 20190430200434eucas1p2efc6bb09f7af8ec07a7fdb55d0cb8f96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
        <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
        <20190425195156.GA31128@bogus>
        <86715dda-c1b0-5354-17d2-419f8137cb91@partner.samsung.com>
        <CAL_JsqJUNw_aDKjWf4TkJWQFhhLCrGYWbTtWpz5jkyeONRcpQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 4/29/19 6:36 PM, Rob Herring wrote:
> On Mon, Apr 29, 2019 at 7:05 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Rob,
>>
>> On 4/25/19 9:51 PM, Rob Herring wrote:
>>> On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
>>>> The device tree bindings for LPDDR3 SDRAM memories.
>>>>
>>>> For specifying the AC timing parameters of the memory device
>>>> the 'lpddr3' binding uses binding 'lpddr2-timings'.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    .../devicetree/bindings/lpddr3/lpddr3-timings.txt  | 57 +++++++++++++
>>>>    .../devicetree/bindings/lpddr3/lpddr3.txt          | 93 ++++++++++++++++++++++
>>>
>>> Please rename the lpddr2 directory to 'ddr' and add these to it.
>> OK, I will rename it in the nex patch set.
>>>
>>> Maybe whatever properties are common should be put in a common doc.
>> There are maybe a few common properties, but I would not dare to merge
>> lpddr2 and lpddr3 before consulting it with TI engineers who made
>> LPDDR2 support.
> 
> Why not. You aren't changing anything. Just rearranging.
True.
> 
>> Could we work on a common file after the patch set got merged?
> 
> Yes, but please still move everything to a common directory.
OK, I am currently working on it and moving these lpddr* files into
Documentation/devicetree/bindings/ddr/
Then after acceptance I will find the common stuff and do the merge.
> 
>>>
>>>>    2 files changed, 150 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>>>>    create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>>>> new file mode 100644
>>>> index 0000000..ebf3e00
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>>>> @@ -0,0 +1,57 @@
>>>> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
>>>> +* The structures are based on LPDDR2 and extended where needed.
>>>> +
>>>> +Required properties:
>>>> +- compatible : Should be "jedec,lpddr3-timings"
>>>> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
>>>> +- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
>>>> +
>>>> +Optional properties:
>>>> +
>>>> +The following properties represent AC timing parameters from the memory
>>>> +data-sheet of the device for a given speed-bin. All these properties are
>>>> +of type <u32> and the default unit is ps (pico seconds).
>>>> +- tRFC
>>>> +- tRRD
>>>> +- tRPab
>>>> +- tRPpb
>>>> +- tRCD
>>>> +- tRC
>>>> +- tRAS
>>>> +- tWTR
>>>> +- tWR
>>>> +- tRTP
>>>> +- tW2W-C2C
>>>> +- tR2R-C2C
>>>> +- tFAW
>>>> +- tXSR
>>>> +- tXP
>>>> +- tCKE
>>>> +- tCKESR
>>>> +- tMRD
>>>> +
>>>> +Example:
>>>> +
>>>> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
>>>
>>> Since the lpddr2 version was written, we've gotten stricter about
>>> allowing unit-address without reg property. Perhaps 'reg' should be the
>>> max-freq instead.
>> OK, so I will rename 'max-freq' to 'reg' and add a comment with:
>> '/* workaround: it shows max-freq */
>> Does it make sense?
> 
> Sure.
OK. Thank you.

Regards,
Lukasz
> 
> Rob
> 
> 
