Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8F6CC68
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfGRJ5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:57:50 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62397 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfGRJ5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:57:50 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190718095747epoutp02807512f053ab975e2f23f5dd7d69274b~yd_oVwpWw3200032000epoutp02q
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:57:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190718095747epoutp02807512f053ab975e2f23f5dd7d69274b~yd_oVwpWw3200032000epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563443867;
        bh=4GaePmyoAtte+S8v4cYY4Z26sJLBpx/Tg0E80gjluWo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WqMdshyqCJ2e1DCSPCkMOqMz5lXI0OjpdZedeFSJM0NbDouzFgE54huH/nsYKTqc9
         sBq88OB1dqldPPPAH89a/erWIoKTgPdfhZRLOGvhZMxVqPY0TGrmnnGvVsR/BFeZR9
         ELVvLtVOlaPb6Rx7+yH9cBD9LtM7tn4OZdJ2YT2Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190718095747epcas1p46f65aab582c0e06a6821286f29136d8d~yd_n7Fbu21796117961epcas1p4p;
        Thu, 18 Jul 2019 09:57:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45q8h81h7RzMqYlh; Thu, 18 Jul
        2019 09:57:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.9C.04088.892403D5; Thu, 18 Jul 2019 18:57:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718095743epcas1p152702a3de7adce67a3744f339c303ab8~yd_kenNhz2022120221epcas1p1n;
        Thu, 18 Jul 2019 09:57:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718095743epsmtrp222c257abb5a505298be8a02d2535b854~yd_kdw6e81455114551epsmtrp2Y;
        Thu, 18 Jul 2019 09:57:43 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-99-5d30429835a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.CC.03638.792403D5; Thu, 18 Jul 2019 18:57:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718095743epsmtip1b3f029b76eb5e619ca28169f19a51173~yd_kUvRsZ2451724517epsmtip1H;
        Thu, 18 Jul 2019 09:57:43 +0000 (GMT)
Subject: Re: [PATCH v4 23/24] PM / devfreq: tegra30: Increase sampling
 period to 16ms
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2dbe4ea5-13af-4b88-5539-b4a738f6fb1c@samsung.com>
Date:   Thu, 18 Jul 2019 19:00:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-24-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmnu4MJ4NYg/P7eCxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ1y/upqp4ANHxYQLJ1gaGLvYuxg5OCQETCSWtkp1MXJxCAnsYJT4vukw
        axcjJ5DziVGieYIeROIbo8Tcaw1MIAmQhk1b/jFDFO1llPi72hzCfs8ocf4mJ4gtLBAucWl1
        AxtIs4jAP0aJzp/NbCAJZoFIicM7V4MNYhPQktj/4gZYnF9AUeLqj8eMIDavgJ3ErZMnwGpY
        BFQlutu3gS0TFYiQOHVkHgtEjaDEyZlPwGxOATOJE9t2sEPMF5e49WQ+E4QtL9G8dTYzyBES
        Ar/ZJKbcbYP6wEVi7Z8uRghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0dzBKbNl/gRUiYSyx
        f+lkJlDYMQtoSqzfpQ8RVpTY+XsuI8RiPol3X3tYIcHLK9HRJgRRoixx+cFdqBMkJRa3d7JN
        YFSaheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBEjutNjOCkqmW6g3HKOZ9DjAIcjEo8
        vDeU9GOFWBPLiitzDzFKcDArifDefgkU4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnAhJ9X
        Em9oamRsbGxhYmhmamioJM47749mrJBAemJJanZqakFqEUwfEwenVAMjj3zH0/6/rsxLi3ir
        AnkXvvrF2+8aVZHS6zx1bl66e92/unbhY9/4rxUV/JBTfvro9jRLpso1vmrrohSv7p+y48q2
        4kn9i3Y7Lfp86r7CNrHnXCoHX1nqeRTU62myLTy1V2/1BemFlwVEixd/WJf2m6f7d/jcnxs0
        0ra4aJhWLG+viRaryLVSYinOSDTUYi4qTgQAmfqmKcADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO50J4NYg21PdCxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyrl9dzVTwgaNiwoUTLA2MXexdjJwcEgImEpu2
        /GPuYuTiEBLYzSgxd/45VoiEpMS0i0eBEhxAtrDE4cPFEDVvGSX+vW0FiwsLhEvcPe8PEhcR
        aGKS2NR7AWwos0CkRM/cLWwQDVsYJVa+es4IkmAT0JLY/+IGG4jNL6AocfXHY7A4r4CdxK2T
        J5hAbBYBVYnu9m3MILaoQITEpGs7WSBqBCVOznwCZnMKmEmc2LYDapm6xJ95l5ghbHGJW0/m
        M0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10v
        OT93EyM4xrS0djCeOBF/iFGAg1GJh/eGkn6sEGtiWXFl7iFGCQ5mJRHe2y+BQrwpiZVVqUX5
        8UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhh53NPMn7TMWXFMacPs83vu
        P9Yx2m+j3/I/j5tVXmuumPmmxSqqjnnfz7kX/eeb2zGlOeiSzdsrPZ8E39iaLzvAte9T1z62
        WScP51zaHyOpcuiF+I+vrlx8svfu9c8+nrKBJ5T90ieBesEXDVlTw6aUddjxVynOPHeWbW7E
        263vDc/wBnW6C6YqsRRnJBpqMRcVJwIA2+3lVa0CAAA=
X-CMS-MailID: 20190718095743epcas1p152702a3de7adce67a3744f339c303ab8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223611epcas1p47b94d7e80981515efcc4ef0d7b00733c
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223611epcas1p47b94d7e80981515efcc4ef0d7b00733c@epcas1p4.samsung.com>
        <20190707223303.6755-24-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:33, Dmitry Osipenko wrote:
> Increase sampling period by 4ms to get a nicer pow2 value, converting
> diving into shifts in the code. That's more preferable for Tegra30 that
> doesn't have hardware divider instructions because of older Cortex-A9 CPU.
> In a result boosting events are delayed by 4ms, which is not sensible in
> practice at all.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 19e872a64148..bde19b758643 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -71,7 +71,7 @@
>   * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
>   */
>  #define ACTMON_AVERAGE_WINDOW_LOG2				6
> -#define ACTMON_SAMPLING_PERIOD					12 /* ms */
> +#define ACTMON_SAMPLING_PERIOD					16 /* ms */
>  
>  #define KHZ							1000
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
