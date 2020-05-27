Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217021E4634
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgE0Olr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 10:41:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39128 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgE0Olq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 10:41:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200527144145euoutp029d93bcdceb9810980cb8d0ae0e034338~S6aMd30yd1958819588euoutp02H
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2020 14:41:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200527144145euoutp029d93bcdceb9810980cb8d0ae0e034338~S6aMd30yd1958819588euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590590505;
        bh=t4EzPguwX4E7bHoRYGdEfAqtcPaah4R31keDabGtleQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oV5uCXq79taHhvDZnk5AKvxMzBd0UmASBrJTbB/eVCREPvM3bMD+H/jc8rRCKGh9a
         nQAZjeRzHsYIokOmiyYQLX3KmH1ReAKspJvu1PwjlnBXgvp4MgEuTRsGrgl38U60zD
         i5M9N7MAZS/V98D9/6IKmP6H2ZdgjY+vKX5L3bAU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200527144144eucas1p1fc3e1875238ccbd1080e4b93389aff45~S6aMEYbHD2003620036eucas1p1u;
        Wed, 27 May 2020 14:41:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.15.61286.82C7ECE5; Wed, 27
        May 2020 15:41:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200527144144eucas1p1cdd660c7d737f98d5f53c2d58db6d0ea~S6aLr5GQe2201722017eucas1p1J;
        Wed, 27 May 2020 14:41:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200527144144eusmtrp1d9df50ff3a8527146794319df8721a4f~S6aLrNNw82814928149eusmtrp16;
        Wed, 27 May 2020 14:41:44 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-8f-5ece7c28989f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.7C.07950.82C7ECE5; Wed, 27
        May 2020 15:41:44 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200527144143eusmtip2a72e4f585f5874a80c474890b819c2fe~S6aKkwIN42212222122eusmtip2J;
        Wed, 27 May 2020 14:41:43 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] interconnect: Support Samsung Exynos use-case
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     a.swigon@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <479885f5-41cb-a3d5-8506-353a6f261bc3@samsung.com>
Date:   Wed, 27 May 2020 16:41:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <edf16797-4c1d-5b92-fbe2-28557c2fcdf0@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7oaNefiDG6c07G4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y+7A6bFpVSebx51re9g8+ras
        YvT4vEkugCWKyyYlNSezLLVI3y6BK+P9IfWC6zwV115sZWxg/MzZxcjJISFgItEz+yZjFyMX
        h5DACkaJoz9WsUA4XxglJh1rYQapEhL4zCixYrIdTMePmw+YIYqWM0pc6V4JVfSRUeL5qXQQ
        W1jAU+Lv52+MILaIgI7E0tm/waYyC1xmlGg71c0GkmATMJToPdoHVsQrYCcx++wuJhCbRUBV
        or3lMthQUYFYidOLN0PVCEqcnPkEaBAHBydQff8/IZAws4C4xK0n85kgbHmJ7W/ngB0nIbCP
        XWL75w/sEFe7SJzv3cQGYQtLvDq+BSouI3F6cg8LREMzo0TP7tvsEM4ERon7xxcwQlRZS9w5
        94sNZDOzgKbE+l36IKaEgKPEskWqECafxI23ghA38ElM2jadGSLMK9HRJgQxQ0Xi96rpTBC2
        lET3k/8sExiVZiF5bBaSb2Yh+WYWwtoFjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
        AhPR6X/HP+1g/Hop6RCjAAejEg9vh9e5OCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwLjjDocE78xAhpLrZ/cx8d2+
        1lZozlI77easRuGf0dv59q/fWOZd8PtU9IOpBwzW1Wz5PPlV6NX3H459NCpPmNM1YVX0lb9y
        z9g+LdeVOrfoybtYx7eqB56JWD46U2782nSdzsQZClmrLC5/Dz0pL/NhiWROYxLj1DtTlG1u
        1BpFnV8RwCPPoMSjxFKckWioxVxUnAgAPu+dSUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oaNefiDBYeEbK4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y+7A6bFpVSebx51re9g8+ras
        YvT4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
        3y5BL+P9IfWC6zwV115sZWxg/MzZxcjJISFgIvHj5gPmLkYuDiGBpYwSX3a+Z+ti5ABKSEnM
        b1GCqBGW+HOtiw2i5j2jxOIL89lAEsICnhJ/P39jBLFFBHQkls7+zQJSxCxwmVFi0fn97BAd
        hxglurevYwGpYhMwlOg92gfWwStgJzH77C4mEJtFQFWiveUyM4gtKhArsfpaK1SNoMTJmU9Y
        QC7iBKrv/ycEEmYWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGIVmIemehaRlFpKWWUhaFjCy
        rGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMvm3Hfm7Zwdj1LvgQowAHoxIPr4HHuTgh1sSy
        4spcoP84mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5HxgYsgriTc0NTS3sDQ0
        NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cB4RXNRjIv5dtap9nNCP6sr/4/fHbf5
        lc2mmr0TdILurpotcah6n7frasuChNW9G15vuXYlJsxCrOjbFDm7RaZbjwS61klorC1luWeh
        8l1ordy7U4HCs6KKfH48Vd76aMJGuepdj8KMRD8VW1Q/DDVSSeNpdfZzjYtpfCezaM/P9Za9
        G061ODxSYinOSDTUYi4qTgQA8oiQm9QCAAA=
X-CMS-MailID: 20200527144144eucas1p1cdd660c7d737f98d5f53c2d58db6d0ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21
References: <CGME20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21@eucas1p2.samsung.com>
        <20200521122841.8867-1-s.nawrocki@samsung.com>
        <edf16797-4c1d-5b92-fbe2-28557c2fcdf0@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On 27.05.2020 15:49, Georgi Djakov wrote:
> Hi Sylwester,
> 
> Thank you for re-sending these!
> 
> On 5/21/20 15:28, Sylwester Nawrocki wrote:
>> Hi All,
>>
>> This is a continuation of Artur's efforts to add interconnect and PM QoS
>> support for Exynos SoCs. Previous version of the patch set can be found 
>> at [1]. The only change comparing to v4 is an addition of missing 'static
>> inline' qualifier to the of_icc_get_from_provider() function stub, i.e.
>> addresing Georgi's review comments.
>>
>> The patches have been tested on Odroid U3 (Exynos4412 SoC). 
>>
>> Below is detailed description of the patch set as in v4.
>>
>>                               ---------
>> Previously posted as a part of a larger RFC [2].
> 
> The patches look good to me and i am planning to apply them for v5.9,
> but what happened to the devfreq patches, which will make use of this?
> Are they posted separately?

Thank you, remaining patches are not posted yet. I'm still working on them
and should be posting them this week. They are almost ready and I'm doing
some more tests. 

I have converted the code that was previously added to the exynos-bus driver
to a separate interconnect driver as you suggested. In the exynos devfreq 
only a child platform device is registered for the interconnect driver,
which then registers a PM QoS request for its parent device. After rebasing 
today I noticed something very similar has been recently added in the devfreq
subsystem for the imx platforms. Let's discuss further after I actually post 
the patches.

--
Regards,
Sylwester
