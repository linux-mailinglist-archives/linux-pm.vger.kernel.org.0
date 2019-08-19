Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D269254C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfHSNkA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 09:40:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35249 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfHSNkA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 09:40:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190819133958euoutp02434e2b3e8612d417223ab00cc1d57965~8VpwI9Y-42053520535euoutp02Y
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 13:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190819133958euoutp02434e2b3e8612d417223ab00cc1d57965~8VpwI9Y-42053520535euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566221998;
        bh=Q0d/QLjgBeIMmaaBqKjPm2ypK9ev0gXQo0A01RCJlic=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lL0dpYU/aE5pev9HZdMHlv+DepiafS5qH8ATPtYoNRT98AJGCS1XaH5Mh6I7NUi7w
         nQzs+vuTz3gXHcgp22PyGJums4ts2E2iDC2WOttZ3q7IUHx9LzaeSUq/39xOfmO/Wl
         GfgQ7kfhkmQq4CkzndEKH1rfdkT6JoWMG7tNWYqc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190819133958eucas1p1c3fcdfaf326d631ee2a191e86b5df388~8VpvuxS671424714247eucas1p1u;
        Mon, 19 Aug 2019 13:39:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 98.62.04469.DA6AA5D5; Mon, 19
        Aug 2019 14:39:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190819133957eucas1p148b4efda4c2c63ceb71046d49dc66596~8Vpuqu2m60836908369eucas1p1_;
        Mon, 19 Aug 2019 13:39:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819133956eusmtrp25e8a06e3d65f630ed17eb40ec96ee339~8Vpubznsu1896718967eusmtrp27;
        Mon, 19 Aug 2019 13:39:56 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-d0-5d5aa6ad60bb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.71.04117.CA6AA5D5; Mon, 19
        Aug 2019 14:39:56 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819133956eusmtip17ec91733a55bbf60a5897690bc35640f~8VptxGSbS2624526245eusmtip18;
        Mon, 19 Aug 2019 13:39:55 +0000 (GMT)
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b7093aaf-ea56-c390-781f-6f9d0780bd8e@samsung.com>
Date:   Mon, 19 Aug 2019 15:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSzUcRzu+3tnTl9H+UyNumktk5ettV8rFvnj1qbV1sY01cVvKG/dOVFt
        pJgUmSbcLHLm5TbESRLaOC4TepGijEIbdv3hnE0qOT+W/57n+TzP9/N5ti9HSo20CxcTnyQo
        4xWxMsaWauldHjxYVxUW7tOq9eEbixtovswwSPMPpuZJfmjoKcs3TY3Q/Ie2UoY35xoQXzzU
        SfB1hnGWr3i2yPKZHQaWb7TIef1kL3NcIm/S3WXkX0faGbm+Mk2e16xDcnOT62k6zPZYpBAb
        kywovf0v2kbrl7NQYhZOadYX0Olo0i4H2XCAD4GltZTIQbacFNcgqCwfpUSyiGAsu3GDmBF0
        a830ZmS4SrMRqV5zVegYkZgQtCxVsVaXIw6E9hXL2oDjnLAHzI4KVpnEHwlos6xjBvtCbk8e
        smIJ9ofX5kbCiim8D/4YC9eX7cChsDDZTYseB+grmaas2AYfgZ76OUp80xkyFmtpEbvBc1Mp
        ab0H8HcWJoaNG1cHwfLjMSRiR5gzNrMi3g2rL8oIMXAbwf2XX1iR5COYMJZvJI5Ct/EdbW1D
        4gPQ0OYtygGQN2wgrDJge/hschCPsIeCliJSlCWQnSUV3e6woisiROwC96ZXqXwk02ypptlS
        R7Oljub/3nJE6ZCzoFbFRQkq33jhmpdKEadSx0d5RSTENaG179X/17jQiizvL3UhzCGZnUT+
        KCxcSiuSValxXQg4UuYkSSldkySRitTrgjLhglIdK6i60C6OkjlLbmybPCfFUYok4YogJArK
        zSnB2bikozvdpLrmTbW03zLO1Cq8SQ+3xMtXl363GXZqGF269smpOt89kYuHM6cDM0O9MzxD
        zof4uQeeyBzR7r81FnBmO9ZEWToTS9i3AybTlORHn2c9igg2LLie/YnSLDqnk/PBD/UD836y
        WceONK7um2bvzSri00zQQNmrmV+FteoZLKNU0QpfD1KpUvwDf9oF3loDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7prlkXFGnzuVbfYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLTZ+9bDY
        /OAYmwOvx6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI2/2xjLGgTqNiyeRJrA+MDni5GTg4JAROJ
        K8tmMXUxcnEICSxllFj6to+9i5EDKCElMb9FCaJGWOLPtS42EFtI4DWjxI7mXBBbWMBJYs/v
        r2wg5SICWhIvb6aCjGEWuMoksXjPJRaIma+YJU7cn8QE0sAmYCjRe7SPEcTmFbCTOPF5I1ic
        RUBV4u/xqawgtqhAhMThHbOgagQlTs58wgJicwpYShxd9wrMZhZQl/gz7xIzhC0u0fRlJSuE
        LS+x/e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbq
        tmM/t+xg7HoXfIhRgINRiYfXY1pUrBBrYllxZe4hRgkOZiUR3oo5QCHelMTKqtSi/Pii0pzU
        4kOMpkDPTWSWEk3OB6aRvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwc
        nFINjJNPyc+fbhZ6WlD8xp/phY0zet3Oq/6ae+Vy463OgCvd2/7IL/+t9HYyY+yW1G85e6Me
        vVZLyVP4t8lHfe29vdvKj6/RlrggZrDtp2JB1Mo/GlfVn5668WvLrRPBjb1Rc35OPZ1SJi92
        +grPTPlNk02Pffn6eNGutRm955bIaz2LC5l48N6GVXIvlFiKMxINtZiLihMByBlrN+sCAAA=
X-CMS-MailID: 20190819133957eucas1p148b4efda4c2c63ceb71046d49dc66596
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
        <20190718143044.25066-1-s.nawrocki@samsung.com>
        <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
        <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
        <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
        <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
        <20190819090928.pke6cov52n4exlbp@vireshk-i7>
        <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
        <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/19/19 13:25, Viresh Kumar wrote:
> On 19-08-19, 13:16, Sylwester Nawrocki wrote:
>> On 8/19/19 11:09, Viresh Kumar wrote:
>>> Will something like this help ?
>>>
>>> https://lore.kernel.org/lkml/1442623929-4507-3-git-send-email-sboyd@codeaurora.org/
>>>
>>> This never got merged but the idea was AVS only.
>>
>> It's quite interesting work, it seems to be for a more advanced use case 
>> where OPP voltage is being adjusted at runtime.
>>
>> We could use it instead of removing an OPP and then adding with updated 
>> voltage. On Exynos there is there is just a need to update OPPs once at boot 
>> time, so it is more "static". However the requirements could presumably 
>> change in future.
> 
> The API is about changing the values after they are parsed once from DT. You can
> change it once or multiple times depending on the use case.
> 
>> If that's your preference I could switch to that notifier approach.
> 
> You shouldn't be required to use the notifier. Just add the OPP table and update
> the values right after that. So no one would be using the values at that time.

OK, now I see dev_pm_opp_adjust_voltage() actually changes OPP's voltage 
and the notifier is optional.

> Will this patchset solve the problems for you and make your DT light weight ?

Unfortunately not, the patch set as I see it is another way of updating 
an OPP after it was parsed from DT.  OPP remove/add could work equally 
well in our use case.
 
The problem is that we have the information on how to translate the 
common OPP voltage to a voltage specific to given silicon encoded jointly 
in the ASV tables and the CHIPID registers (efuse/OTP memory). 
Additionally, algorithm of selecting ASV data (OPP voltage) based on 
the "key" data from registers is not generic, it is usually different 
per each SoC type.

I tried to identify some patterns in those tables in order to simplify 
possible DT binding, but that was not really successful. I ended up just 
keeping whole tables.

--
Regards, 
Sylwester
