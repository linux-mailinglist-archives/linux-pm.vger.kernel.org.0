Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB842B88CB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 03:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbfITBCt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 21:02:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14758 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394544AbfITBCt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 21:02:49 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190920010245epoutp0446431cce34f913d05e2ca26f8dfdce34~F-9wZQ5tX1303313033epoutp04k
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 01:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190920010245epoutp0446431cce34f913d05e2ca26f8dfdce34~F-9wZQ5tX1303313033epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568941366;
        bh=6ttcWVwBEvo+76KqxEdhtYsT+4exke8Z1DVjZG9VzDE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D58MHs1J/vODHZDot+1FSnYP1V01lKeuaEVoKuC01/YtjemeF4kCcVkRaETKUhaHU
         nHGgn50uCnsU94y3Fl7INdTj1HTWCRXHIf1uAXCOiB1SPSYocTnsvTpAdWI+FF6dk6
         clgQmiHLEcY8pytUQ3TAZsf/djql7MNVnS2WY/dk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190920010245epcas1p2ac88da8ded6620d8535c588b0c357405~F-9vvwKID1014010140epcas1p2G;
        Fri, 20 Sep 2019 01:02:45 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46ZFnG6QJtzMqYkV; Fri, 20 Sep
        2019 01:02:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.FD.04085.235248D5; Fri, 20 Sep 2019 10:02:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190920010242epcas1p3383f81d00544452b8a1f8668cd7980de~F-9srlicq2097720977epcas1p3v;
        Fri, 20 Sep 2019 01:02:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190920010241epsmtrp226d2b93222e97eb0a316ed1fd55262d0~F-9sqHlc00370803708epsmtrp2u;
        Fri, 20 Sep 2019 01:02:41 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-0b-5d84253257ed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.3F.03638.135248D5; Fri, 20 Sep 2019 10:02:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190920010241epsmtip2f41c2d3900df8bf030ca8f96e401b993~F-9sc0Oue1345713457epsmtip2B;
        Fri, 20 Sep 2019 01:02:41 +0000 (GMT)
Subject: Re: [RFC PATCH v2 00/11] Simple QoS for exynos-bus driver using
 interconnect
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fe6d026d-71b5-438d-6932-6a2234fc72c2@samsung.com>
Date:   Fri, 20 Sep 2019 10:07:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmnq6RakuswZcNxhb357UyWmycsZ7V
        4uUhTYv5R86xWlz5+p7NYvreTWwWk+5PYLE4f34Du8WKux9ZLTY9vsZqcXnXHDaLz71HGC1m
        nN/HZLH2yF12i9uNK9gsZkx+yeYg4LFpVSebx51re9g87ncfZ/LYvKTeY+O7HUwefVtWMXp8
        3iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDI
        FKgwITvj4pS6gm/KFfPbTrI2ME6U7WLk5JAQMJGYs6afsYuRi0NIYAejxKIVH1ggnE+MEt+e
        X2CCcL4xSjz6O5sNpmXZqvPMILaQwF5GicXbqyGK3jNKPHz6FaxIWCBcYu7rB6wgCRGB/4wS
        p5etBHOYQUZ9nbeBBaSKTUBLYv+LG2Ad/AKKEld/PGYEsXkF7CTW9y9lArFZBFQlLtx8DbZO
        VCBC4tODw6wQNYISJ2c+AZvDKWAp8WXffDCbWUBc4taT+UwQtrxE89bZzCCLJQQOsUu0fNzB
        DPGDi8SCbZfZIWxhiVfHt0DZUhKf3+2F+rNaYuXJI2wQzR2MElv2X2CFSBhL7F86GWgDB9AG
        TYn1u/QhwooSO3/PZYSweSUaNv5mhziCT+Ld1x5WkHKQeEebEESJssTlB3eZJjAqz0Lyziwk
        L8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIkf3JkZwwtay3MF47JzPIUYBDkYlHl6F8uZYIdbE
        suLK3EOMEhzMSiK8c0ybYoV4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCb5JXEG5oaGRsb
        W5gYmpkaGiqJ83qkN8QKCaQnlqRmp6YWpBbB9DFxcEo1MMqnM7LztmyO7+Q6dH3dxgkuBQ8W
        HSuMaZ7wKck4WEdhue7qpV2BErtvWO/I/SdxNl02f8k5szWprAt2xa2syDaOyVnXEKnJob+v
        4Z/Uya1hbYvYI89d0Y3hEdk2Mzp9r3xQpenPB8zn3e0+eb82TvhVxmG4RCzaYvuX++Gb3YMO
        WLrVBe2vVmIpzkg01GIuKk4EAJVK75XuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSvK6hakuswdX35hb357UyWmycsZ7V
        4uUhTYv5R86xWlz5+p7NYvreTWwWk+5PYLE4f34Du8WKux9ZLTY9vsZqcXnXHDaLz71HGC1m
        nN/HZLH2yF12i9uNK9gsZkx+yeYg4LFpVSebx51re9g87ncfZ/LYvKTeY+O7HUwefVtWMXp8
        3iQXwB7FZZOSmpNZllqkb5fAlXFxSl3BN+WK+W0nWRsYJ8p2MXJySAiYSCxbdZ65i5GLQ0hg
        N6PE2wWf2CESkhLTLh4FSnAA2cIShw8XQ9S8ZZRo3XiZCaRGWCBcYu7rB6wgCRGB/4wSD9uO
        MYI4zALfGCX6Pi9jg2jpYZRYue8vK0gLm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS6/uXgo1l
        EVCVuHDzNTOILSoQIXF4xyyoGkGJkzOfsIDYnAKWEl/2zQezmQXUJf7Mu8QMYYtL3HoynwnC
        lpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5
        mxjBsaultYPxxIn4Q4wCHIxKPLwK5c2xQqyJZcWVuYcYJTiYlUR455g2xQrxpiRWVqUW5ccX
        leakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpg5N30pdiu6oS6W+3jcJkM96i8
        e123Sn1uaHO8TbBgV3Z5zsc4za06I9BaVjvCp+xRVNKsWC8ZrWmrGb3VFicvW+/y1vmDipdf
        TJG7ZJvLy0sMxQs/8ngcbi5RVe6evLb67Xyvns8r82bc1JlXs9Le+iuDhMPCVfmXrItkD//e
        pF5X9TMt5YoSS3FGoqEWc1FxIgASGwU82QIAAA==
X-CMS-MailID: 20190920010242epcas1p3383f81d00544452b8a1f8668cd7980de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec
References: <CGME20190919142321eucas1p164c2591ad402427cb71fd00c348a29ec@eucas1p1.samsung.com>
        <20190919142236.4071-1-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On v1, I mentioned that we need to discuss how to change
the v2 for this. But, I have not received any reply from you on v1.
And, without your reply from v1, you just send v2.

I think that it is not proper development sequence.
I have spent many times to review your patches
and also I'll review your patches. You have to take care
the reply of reviewer and and keep the basic rule
of mailing contribution for discussion.

On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
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
> Integration of devfreq and interconnect functionalities is achieved by
> using dev_pm_qos_*() API[5]. All new code works equally well when
> CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
> interconnect API functions are no-ops.
> 
> This patchset depends on [5].
> 
> --- Changes since v1 [6]:
> * Rebase on [4] (coupled regulators).
> * Rebase on [5] (dev_pm_qos for devfreq).
> * Use dev_pm_qos_*() API[5] instead of overriding frequency in
>   exynos_bus_target().
> * Use IDR for node ID allocation.
> * Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
> * Reverse order of multiplication and division in
>   mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.
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
> [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
> [4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
> [5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
> [6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> 
> Artur Świgoń (10):
>   devfreq: exynos-bus: Extract exynos_bus_profile_init()
>   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
>   devfreq: exynos-bus: Change goto-based logic to if-else logic
>   devfreq: exynos-bus: Clean up code
>   interconnect: Export of_icc_get_from_provider()
>   interconnect: Relax requirement in of_icc_get_from_provider()
>   interconnect: Relax condition in apply_constraints()
>   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
> 
> Marek Szyprowski (1):
>   drm: exynos: mixer: Add interconnect support
> 
>  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
>  drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
>  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
>  drivers/interconnect/core.c                   |  12 +-
>  include/linux/interconnect-provider.h         |   6 +
>  6 files changed, 327 insertions(+), 92 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
