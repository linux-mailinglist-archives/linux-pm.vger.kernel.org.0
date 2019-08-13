Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA78AFB5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 08:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfHMGNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 02:13:50 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:47816 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHMGNu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 02:13:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190813061347epoutp018d5ee98b7a0c2cf5d0ffe32db2794c1e~6ZseAHol71548215482epoutp01k
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 06:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190813061347epoutp018d5ee98b7a0c2cf5d0ffe32db2794c1e~6ZseAHol71548215482epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565676827;
        bh=Xwj0sV5zR7XRN9JsppcP+03CQuzpX+VyXv5U3/Qahdw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t8tB56C0LVWph7/uYpYyCO2569fT0+RmWVZlLghkU77NNtBBsncvxKQSqJu+wd3iv
         oBqyLylOzH5yLKuJ3gYhlE4nvps16zzRLed/vjwIsvbXSgrpTrygTbQkzbmem29zG8
         1SviHyp6JuNOSz8cirwHB54xPS8wpN6En6BdEFhg=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190813061346epcas1p4dd6a6b6d56622b5d4c0b0cb19d0e8b14~6ZsdTkDF00949109491epcas1p4g;
        Tue, 13 Aug 2019 06:13:46 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 4672Th37xtzMqYkc; Tue, 13 Aug
        2019 06:13:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.B7.04085.815525D5; Tue, 13 Aug 2019 15:13:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190813061343epcas1p3bb333a7ccbb59c83c9b53d2b3f19ed3a~6ZsarhEst0550605506epcas1p3f;
        Tue, 13 Aug 2019 06:13:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813061343epsmtrp15a3de5ec4bba0edf932904ec3adb5909~6Zsaqtnf82809428094epsmtrp1y;
        Tue, 13 Aug 2019 06:13:43 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-24-5d5255187eb4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.D3.03638.715525D5; Tue, 13 Aug 2019 15:13:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190813061343epsmtip10738a981ac385fbd3d6c7a7ff029371c~6ZsaTwK5n2339723397epsmtip1G;
        Tue, 13 Aug 2019 06:13:43 +0000 (GMT)
Subject: Re: [RFC PATCH 00/11] Simple QoS for exynos-bus driver using
 interconnect
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        m.szyprowski@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6be31199-a93d-c440-e0cd-7453e3ac1648@samsung.com>
Date:   Tue, 13 Aug 2019 15:17:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmga5EaFCsQec7MYtDx7ayW8w/co7V
        4srX92wW0/duYrOYdH8Ci8X58xvYLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        Zkx+yebA67FpVSebx51re9g87ncfZ/LYvKTe4+C7PUwefVtWMXp83iQXwB6VbZORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtjUsNtxoK7chXz
        p+xla2B8L9HFyMkhIWAise7BIqYuRi4OIYEdjBKzZ/xhB0kICXxilNh8QRwi8Y1RovfmLqAE
        B1hH+yF/iPheRol3T34yQjjvGSVez9rKAtItLBAicXzzV0YQW0SgnUmieaMDSBGzwERGiefH
        /zOBJNgEtCT2v7jBBmLzCyhKXP3xGKyBV8BO4nHPWVYQm0VAVeL4nFtg9aICERKfHhxmhagR
        lDg58wnYMk4BJ4muo+1gc5gFxCVuPZnPBGHLSzRvnc0MslhCYB27xPPJy1ggnnaRuP65jxHC
        FpZ4dXwLO4QtJfGyvw3KrpZYefIIG0RzB6PElv0XWCESxhL7l05mAoUFs4CmxPpd+hBhRYmd
        v+cyQizmk3j3tYcVEly8Eh1tQhAlyhKXH9xlgrAlJRa3d7JNYFSaheSdWUhemIXkhVkIyxYw
        sqxiFEstKM5NTy02LDBFju1NjOCUrGW5g/HYOZ9DjAIcjEo8vBUJgbFCrIllxZW5hxglOJiV
        RHgvmQTFCvGmJFZWpRblxxeV5qQWH2I0BYb2RGYp0eR8YL7IK4k3NDUyNja2MDE0MzU0VBLn
        XfjDIlZIID2xJDU7NbUgtQimj4mDU6qBUcPOy2rX8/XCm7mznU/qen+ysJ11c7LCkds8H170
        Nixcv+oga9aP2V9ufOGe9O9s1veJT9vmmk3JCNvObvvN+W7ik/6IBo76eR2e4dfDYy19Xv9f
        LPImpmKKkc9dl0UhRZE/HnVOOZhUtH7Ov9oGp66iG4GdZ+tPrK//sff016dqnX1vH3Pc8lVi
        Kc5INNRiLipOBAC9LmVj3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnK54aFCswcouY4tDx7ayW8w/co7V
        4srX92wW0/duYrOYdH8Ci8X58xvYLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        Zkx+yebA67FpVSebx51re9g87ncfZ/LYvKTe4+C7PUwefVtWMXp83iQXwB7FZZOSmpNZllqk
        b5fAlTGp4TZjwV25ivlT9rI1ML6X6GLk4JAQMJFoP+TfxcjFISSwm1Hi1N+rbF2MnEBxSYlp
        F48yQ9QISxw+XAxR85ZRYlHTNbAaYYEQieObvzKCJEQE2pkkulu3gjnMAhMZJR4fXssM0TKV
        UWL9z9ssIC1sAloS+1/cAGvnF1CUuPrjMSOIzStgJ/G45ywriM0ioCpxfM4tJhBbVCBC4vCO
        WVA1ghInZz4Bm8Mp4CTRdbQdbA6zgLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR9FpKW
        WUhaZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzg+tbR2MJ44EX+IUYCD
        UYmHtyIhMFaINbGsuDL3EKMEB7OSCO8lk6BYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy+cci
        hQTSE0tSs1NTC1KLYLJMHJxSDYwFfMvemAiVGrdavxZylUg4NqOEQyc0OiqjppY/fkLQba4f
        CsKMj640/u9+UOzqpfBC4s2NTW7F1nF3bc++Yev59mPG5HzPa2kWqnuebF3Dfqy0c9r5mMSf
        0qczsqbM/q4dEP3y5a2LF2+fi10hvOvGiztyy/gcp4iu/3FavihMdMf3Dxec799UYinOSDTU
        Yi4qTgQAsaEb6ssCAAA=
X-CMS-MailID: 20190813061343epcas1p3bb333a7ccbb59c83c9b53d2b3f19ed3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5
References: <CGME20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5@eucas1p2.samsung.com>
        <20190723122016.30279-1-a.swigon@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur.

The patch1-4 in this series depend on other patches[1] on mainline.
On next v2 version, please make some patches based on patches[1]
in order to prevent the merge conflict. 

[1] [RESEND PATCH v5 0/4] add coupled regulators for Exynos5422/5800
- https://lkml.org/lkml/2019/8/8/217

Also, as I commented, we better to discuss it before sending the v2.

On 19. 7. 23. 오후 9:20, Artur Świgoń wrote:
> The following patchset adds interconnect[1][2] framework support to the
> exynos-bus devfreq driver. Extending the devfreq driver with interconnect
> capabilities started as a response to the issue referenced in [3]. The
> patches can be subdivided into four logical groups:
> 
> (a) Refactoring the existing devfreq driver in order to improve readability
> and accommodate for adding new code (patches 01--04/11).
> 
> (b) Tweaking the interconnect framework to support the exynos-bus use case
> (patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
> avoid hardcoding every single graph edge in the DT or driver source, and
> relaxing the requirement contained in that function removes the need to
> provide dummy node IDs in the DT. Adjusting the logic in
> apply_constraints() (drivers/interconnect/core.c) accounts for the fact
> that every bus is a separate entity and therefore a separate interconnect
> provider, albeit constituting a part of a larger hierarchy.
> 
> (c) Implementing interconnect providers in the exynos-bus devfreq driver
> and adding required DT properties for one selected platform, namely
> Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
> generic driver for various Exynos SoCs, node IDs are generated dynamically
> rather than hardcoded. This has been determined to be a simpler approach,
> but depends on changes described in (b).
> 
> (d) Implementing a sample interconnect consumer for exynos-mixer targeted
> at the issue referenced in [3], again with DT info only for Exynos4412
> (patches 10--11/11).
> 
> Integration of devfreq and interconnect functionalities comes down to one
> extra line in the devfreq target() callback, which selects either the
> frequency calculated by the devfreq governor, or the one requested with the
> interconnect API, whichever is higher. All new code works equally well when
> CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
> interconnect API functions are no-ops.
> 
> ---
> Artur Świgoń
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> ---
> References:
> [1] Documentation/interconnect/interconnect.rst
> [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
> [3] https://patchwork.kernel.org/patch/10861757
> 
> Artur Świgoń (10):
>   devfreq: exynos-bus: Extract exynos_bus_profile_init()
>   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
>   devfreq: exynos-bus: Change goto-based logic to if-else logic
>   devfreq: exynos-bus: Clean up code
>   icc: Export of_icc_get_from_provider()
>   icc: Relax requirement in of_icc_get_from_provider()
>   icc: Relax condition in apply_constraints()
>   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
> 
> Marek Szyprowski (1):
>   drm: exynos: mixer: Add interconnect support
> 
>  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
>  drivers/devfreq/exynos-bus.c                  | 296 ++++++++++++++----
>  drivers/gpu/drm/exynos/exynos_mixer.c         |  68 +++-
>  drivers/interconnect/core.c                   |  12 +-
>  include/linux/interconnect-provider.h         |   6 +
>  6 files changed, 314 insertions(+), 79 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
