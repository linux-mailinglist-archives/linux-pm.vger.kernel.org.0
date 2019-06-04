Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5033C8D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 02:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfFDAsB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 20:48:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49942 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFDAsB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 20:48:01 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190604004758epoutp016c5c9ca130e3a3fe9e5a95f5d521974c~k2GAXsvan0681906819epoutp01k
        for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2019 00:47:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190604004758epoutp016c5c9ca130e3a3fe9e5a95f5d521974c~k2GAXsvan0681906819epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559609278;
        bh=UVoVZsEOgg1NnZlddSvqw+nOBKf/TPyZq+/XKx68wrM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IX/8FEV9jOt8paA8NiUO+re9+Ws/0wC/qp40poNh83a6NdYlLY4yGDvKQAgsv29F+
         4jhlFFAY/5A+yyIJ1f2kd+Li2EKb0gUtp9QpYM17DL1IkvdNoZKCvmqsJu79/BqdAm
         o/sM8fNyCEU7LU3MnuUp6T4ikfW7vcOsi2Wp+yos=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190604004755epcas1p415ce6d1486bdb02719fa2b61ea7f27ba~k2F_Id_1w0371903719epcas1p42;
        Tue,  4 Jun 2019 00:47:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.B7.04139.9BFB5FC5; Tue,  4 Jun 2019 09:47:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190604004752epcas1p250835a92cd7f9c97ecbb7d160a8ad02f~k2F7aLrlA1566915669epcas1p2h;
        Tue,  4 Jun 2019 00:47:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190604004752epsmtrp2126b0c96c6730aeeac34076d3ec447ea~k2F7ZXgHE1748017480epsmtrp2i;
        Tue,  4 Jun 2019 00:47:52 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-eb-5cf5bfb98560
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.5F.03692.8BFB5FC5; Tue,  4 Jun 2019 09:47:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190604004752epsmtip27e6014869c6d24518822cd757b00ba96~k2F7Lw_4d1715317153epsmtip2_;
        Tue,  4 Jun 2019 00:47:52 +0000 (GMT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and
 Tegra20/30 support
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <683b343a-e64f-8345-ac44-10f5c00521bd@samsung.com>
Date:   Tue, 4 Jun 2019 09:49:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDHfd1lu6jVtVxjP2hdjQkkQBcorgfGK6ZGQzAkaExN3dC1JfRK
        t3hrQPAC64kHFdGIBsUoSsC0DdAIRMIHDUJIFIKKVwwiHoCKROO2i5Fvv5n5v/nPvPdITFlD
        qMgcm4t32jgLTUzFH7TEJsT7AqN6jbs/gr399Q1iizzXcPbxwUE52+UvJ9hhdytij414CLa3
        4CbBjvkrcPbEnU5iRbjO23cd6XyePrnOXThE6E7UVSPdcO2cjLAtucvMPGfknWrelm035thM
        afT6TMNqgzZVw8Qzi9lFtNrGWfk0es2GjPi1ORZxIFq9g7PkiakMThDoxOXLnPY8F6822wVX
        Gs07jBbHYkeCwFmFPJspIdtuXcJoNElaUbgt1zxY2o87GqhdX140EfmoWFGMwkmgUqBk7DsR
        ZCXlReDPNxSjqSJ/Q+A+U4VLwXcEvd6L6N+JT94iuVRoRPCnvHEi+IzgfmmnPKiKoDbDwLW7
        WJAjqY0w9L4JC4ow6rAMjjz9LQsWCCoOAh+ehcxnUvOg++ebkIWCWg5j/vFQI5xaAOcfPg41
        ihKbjvhqJzSzoL3sLR7kcCoNOk8Wh/IYFQM9b6/IJJ4LhfWXMGnsQjm8uzhH4jVQ9mtgYp0I
        GGirk0usguGhRkLivXCrvZUIDg3UUQR1gY4wqZAMgRtnRQNSNIiFGn+ilJ4HvvHLEzPMgKHR
        42FBCVAKOHpYKUnmQ9erPpnEs6HyyDHiFKI9k7bxTNrAM2kDz3+zqwivRtG8Q7CaeIFxMJNf
        uxaFPmuc1otKn2xoRhSJ6OmKXTGjemUYt0PYbW1GQGJ0pILrHdErFUZu9x7eaTc48yy80Iy0
        4mWfxlRR2Xbx69tcBkablJyczKYwqVqGoWMUhmnP9UrKxLn4XJ538M5/52RkuCofVUZ3v2yv
        u9cxRVnBflvX2cRv3//IeeWjaZ26+sO+1tSehlec+fghzdfN5EEUM7xw/GfJ2jaL+t3ryMqe
        swcSGF989MpzP8oSzXp1SRvaviK2KCugc1wocFszlxrLGNXdTa1fBtSr0ke3VpmU9WT6zoLB
        pKyKKbbBzI+qVflkSx+NC2aOicOcAvcXlfS/OsIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO6O/V9jDHYc0rNY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKeDPlIUvBHoGKD/f2sTUwdvF2MXJySAiYSLzd
        0cLexcjFISSwm1FiztTZTBAJSYlpF48ydzFyANnCEocPF0PUvGWU2PpjLSNIjbBAhMT8C5fA
        6kUEAiVOP9jKCFLELNDBJPFk/U+wIiGBJUwSu58rgdhsAloS+1/cYAOx+QUUJa7+eAxWwytg
        J/Fz1292EJtFQEVi2sGzzCC2KNCC2bsaWCBqBCVOznwCZnMK2Epc6u8C62UWUJf4M+8SM4Qt
        LnHryXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YW
        l+al6yXn525iBMeYluYOxstL4g8xCnAwKvHwVoh/jRFiTSwrrsw9xCjBwawkwpt4+0uMEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYxpl3Mnbmo5oWh8
        4bsvS92JafzrfK86/kladvud3KZX/GXie2fPY37M8rb4eL6ZsrjuZRkb3uR4/UveX5zqds+d
        wsV3fq3KPtN1U19PK+oWspoz7QbDKxuRwKTLL1+YibaZvLnBW+VodiMzt0DDQTAyMoDx5c2T
        D7tYlq4/7BLvyCq9cnYLE78SS3FGoqEWc1FxIgD99jm2rQIAAA==
X-CMS-MailID: 20190604004752epcas1p250835a92cd7f9c97ecbb7d160a8ad02f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
        <20190501233815.32643-1-digetx@gmail.com>
        <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
        <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
        <0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 6. 4. 오전 1:52, Dmitry Osipenko wrote:
> 03.05.2019 3:52, Dmitry Osipenko пишет:
>> 03.05.2019 3:31, Chanwoo Choi пишет:
>>> Hi Dmitry,
>>>
>>> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>>>> Changelog:
>>>>
>>>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>>>
>>>>     - changed the driver removal order to match the probe exactly
>>>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>>>
>>>>     Chanwoo, please also note that the clk patch that should fix
>>>>     compilation problem that was reported the kbuild-test-robot is already
>>>>     applied and available in the recent linux-next.
>>>
>>> I knew that Stephen picked up your path about clock.
>>
>> Hi Chanwoo,
>>
>> Okay, good. Thank you very much for reviewing this series! I assume it's
>> too late now for v5.2, but it should be good to go for v5.3.
>>
> 
> Hello Chanwoo,
> 
> Will be nice to see the patches in the linux-next before they'll hit mainline. We have tested that
> everything works fine on a selective devices, but won't hurt to get some extra testing beforehand.
> AFAIK, at least NVIDIA people are regularly testing -next on theirs dev boards. Please note that
> this not very important, so don't bother if there is some hurdle with pushing to the tracking branch
> for now. Also please let me know if you're expecting to see some ACK's on the patches, I'm sure
> we'll be able to work out that with Thierry and Jon if necessary.
> 
> 

Hi Dmitry,
I think that it is enough for applying to mainline branch.
The devfreq.git is maintained by Myungjoo. He will be merged or
reviewed if there are th remained review point.


Hi Myungjoo,
I reviewed the Dmitry's patches from v1 to v4 patches.
And then I tested them on my testing branch[1] for catching
the build warning and error. In result, it is clean.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

Please review or apply these patches for v5.3.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
