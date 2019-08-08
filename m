Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87987862E9
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfHHNT3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 09:19:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46709 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfHHNT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 09:19:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808131927euoutp02d0a6b606e996997c2621427796c3cc78~49Rs2GRt-0347603476euoutp02j
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 13:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808131927euoutp02d0a6b606e996997c2621427796c3cc78~49Rs2GRt-0347603476euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565270367;
        bh=ookusFW9IgM6u0l6dG3jFEGxecF9mJq8IKEqSZsXe3U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H3u6q2EgP214ncKYGJdX+T/HXd0sIC82mr+MytSy9JvkNarnKoHTK5j/9b5crL4L+
         MBBfrz6zd/+eyiEor7wQZY2pKhS3rnwWytohGo8DUGPFId6RuzMWr3ZSne+uTMtcib
         ykFa/zxcxZsMntMWswhZRY7cdWHjTvPbUyVt/c0Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808131926eucas1p27760b9e4918c7ec639731837f737eb78~49RsDnfW82304523045eucas1p2W;
        Thu,  8 Aug 2019 13:19:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.32.04309.E512C4D5; Thu,  8
        Aug 2019 14:19:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808131925eucas1p18cbdebea41d0501bf9f9edb3bb0baf97~49Rq4M_Vg2619826198eucas1p1V;
        Thu,  8 Aug 2019 13:19:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808131925eusmtrp2e2247ca1de6d1cc68f838d639791aa13~49RqqA2ig0955809558eusmtrp2b;
        Thu,  8 Aug 2019 13:19:25 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-8f-5d4c215ea915
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.50.04166.D512C4D5; Thu,  8
        Aug 2019 14:19:25 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190808131924eusmtip1fdcb55f900a56f9267b3b1725f38cee1~49RqA_1gx0713907139eusmtip1h;
        Thu,  8 Aug 2019 13:19:24 +0000 (GMT)
Message-ID: <7f4eeef81c2688c2cb18b7aae71d457197c6d018.camel@partner.samsung.com>
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "inki.dae@samsung.com" <inki.dae@samsung.com>,
        "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Date:   Thu, 08 Aug 2019 15:19:23 +0200
In-Reply-To: <VI1PR04MB5055BED59960B4F4147479AEEED50@VI1PR04MB5055.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87pxij6xBt9+yFtc//Kc1WL+kXOs
        Fle+vmezmL53E5vFpPsTWCzOn9/AbrHi7kdWi02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfd
        4nbjCjaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n32PhuB5NH35ZVjB6fN8kFsEdx2aSk
        5mSWpRbp2yVwZRy4k1DQwFMx588KxgbGDZxdjJwcEgImEhumb2LqYuTiEBJYwSjxfdl7Ngjn
        C6PE1d67LBDOZ0aJHW0LmGFaDl58DlW1nFHi/rFnUM4zRonXi3+AVfEKBEic+TybFcQWFkiS
        WPDoIpjNJuAu8e/5FTBbRCBSYs/uy2ArmAXOskqcm7gOrJlFQFXi7/WpYEWcArESr1pOQa3W
        kXh7qg+ogQNogaDE3x3CIGFmAXmJ5q2zmUHmSAjcY5foXzeHDaLeReLUksuMELawxKvjW9gh
        bBmJ/zvnM0HYxRJPd95nhWhuYJTYtOwI1DJricPHQa7mANqgKbF+lz5E2FHibd9RZpCwhACf
        xI23ghA38ElM2jYdKswr0dEmBGFqSSz4HQ3RKCHRtPoa1GwPiZZHz9knMCrOQvhlFpJfZiFs
        XcDIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwfZ3+d/zLDsZdf5IOMQpwMCrx8Bac
        8I4VYk0sK67MPcQowcGsJMJ7r8wzVog3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS
        1OzU1ILUIpgsEwenVAPjlsUv5W8YHehlufcrWd/s2JrQZP8cK0E54ekzbjG6SctMNN6b1eCc
        d3cL+0leJp5XDRZybv0+e7jZZhiu3rej9+Rh2bg51rs8DioKOt033+FVbZtz1fB3pur2XUtS
        bN3WyT4PvfL6WuB6SfbrciGH72heaZQIjvr6wWf3dhXRMtvjajtsinWVWIozEg21mIuKEwHm
        2kMrWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7qxij6xBgduClpc//Kc1WL+kXOs
        Fle+vmezmL53E5vFpPsTWCzOn9/AbrHi7kdWi02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfd
        4nbjCjaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n32PhuB5NH35ZVjB6fN8kFsEfp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZRy4k1DQwFMx
        588KxgbGDZxdjJwcEgImEgcvPmcDsYUEljJKfGhyh4hLSHxcf4MVwhaW+HOtC6iGC6jmCaPE
        mdXHGEESvAIBEmc+zwYrEhZIkljw6CKYzSbgLvHv+RUwW0QgSuL5jT4mkGZmgXOsEpe3bgdL
        sAioSvy9PhXM5hSIlXjVcooZYsMSJomDmxexgCSYBTQlWrf/Zoc4Q0fi7ak+oDgH0GZBib87
        hCFK5CWat85mnsAoOAtJxyyEqllIqhYwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjMxt
        x35u3sF4aWPwIUYBDkYlHt6CE96xQqyJZcWVuYcYJTiYlUR475V5xgrxpiRWVqUW5ccXleak
        Fh9iNAX6ZyKzlGhyPjBp5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi
        4JRqYJQzXVucOq3T69q1HQ7ObwtuPE67Wn2nc2tl4qTHty4q/O9iPTQ1xO3pXYeOKwG6QnwB
        GY5szhKrX/ut/ycxuf2e+w1PdV4mzaj9R3v+Xz9sdO97nIuI2YlWgav2lz1eCZrOS7tW2h93
        +r1P7nvbqZV6e0IyrE7fW/CpXGBWpcdeP03e2yurCpRYijMSDbWYi4oTAeiNT3XiAgAA
X-CMS-MailID: 20190808131925eucas1p18cbdebea41d0501bf9f9edb3bb0baf97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
        <20190723122016.30279-10-a.swigon@partner.samsung.com>
        <VI1PR04MB5055BED59960B4F4147479AEEED50@VI1PR04MB5055.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thank you for your comments.

On Tue, 2019-08-06 at 13:41 +0000, Leonard Crestez wrote:
> On 23.07.2019 15:21, Artur Świgoń wrote:
> 
> > +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 avg_bw,
> > +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> > +{
> > +	*agg_peak = *agg_avg = peak_bw;
> > +
> > +	return 0;
> > +}
> 
> The only current provider aggregates "avg" with "sum" and "peak" with 
> "max", any particular reason to do something different? This function 
> doesn't even really do aggregation, if there is a second request for "0" 
> then the first request is lost.

Yes, you're right. I adopted an oversimplified solution for the purpose of this
RFC (please bear in mind that currently only one icc_path is used, so there is
no aggregation anyway).

> I didn't find any docs but my interpretation of avg/peak is that "avg" 
> is for constant traffic like a display or VPU pushing pixels and "peak" 
> is for variable traffic like networking. I assume devices which make 
> "peak" requests are aggregated with max because they're not expected to 
> all max-out together.

That's correct (according to my understanding).

> In PATCH 11 you're making a bandwidth request based on resolution, that 
> traffic is constant and guaranteed to happend while the display is on so 
> it would make sense to request it as an "avg" and aggregate it with "sum".
> 
> --
> Regards,
> Leonard
> 
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


