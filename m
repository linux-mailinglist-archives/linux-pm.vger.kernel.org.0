Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237A62A7534
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 03:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKECHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 21:07:09 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35930 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbgKECHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 21:07:08 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201105020705epoutp01f5fe25a6cc696d75d6736cebf2d149ee~Eenh1tOc22881028810epoutp01L
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 02:07:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201105020705epoutp01f5fe25a6cc696d75d6736cebf2d149ee~Eenh1tOc22881028810epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604542025;
        bh=pitRzO3m19arHuQUPX0y+i+VT7w1wenaW8mQl65pPLI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZnYyi6HlcoRoeXo6cgd+jVw/DmmCVVjWzEwMaJYtOZvoaykWxWZmy0RbRIvoNJ0CA
         Y83daiqu35cASGMmUA5Lu3tepmK9b0VJm2Ty2Cc8nGtKOWessVCJO7XlpjRCkIeDcY
         EqCvJoe3XabKn7IL1aYAueZV+glGljaL9pPyNgpA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201105020704epcas1p37659b49e474f028357aa1ef1865eae99~EenhMMSWf2487524875epcas1p3C;
        Thu,  5 Nov 2020 02:07:04 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CRRjL26wJzMqYm4; Thu,  5 Nov
        2020 02:07:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.7B.63458.34E53AF5; Thu,  5 Nov 2020 11:07:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201105020659epcas1p1785d0bdc28b3a4356b966b51199d11cd~Eencory1m2178921789epcas1p1p;
        Thu,  5 Nov 2020 02:06:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201105020659epsmtrp284cd9b1d6af1b871615e708170057f0f~Eencnr0tL1423014230epsmtrp2A;
        Thu,  5 Nov 2020 02:06:59 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-b9-5fa35e43739c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.5F.13470.34E53AF5; Thu,  5 Nov 2020 11:06:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201105020659epsmtip2cf6e0d069b227ae5a5976ab4d7d2d2e0~EencPG1Tl0697506975epsmtip2i;
        Thu,  5 Nov 2020 02:06:59 +0000 (GMT)
Subject: Re: [PATCH v8 0/7] Exynos: Simple QoS for exynos-bus using
 interconnect
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        georgi.djakov@linaro.org, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <25228d5e-4bc3-2e61-6bd5-43e66ae82244@samsung.com>
Date:   Thu, 5 Nov 2020 11:20:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmvq5L3OJ4g+nXmSzuz2tltNg4Yz2r
        xfwj51gtrnx9z2Yxfe8mNotJ9yewWJw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        uN24gs2ide8RdovDb9pZLWZMfsnmIOCxaVUnm8eda3vYPO53H2fy2Lyk3qNvyypGj8+b5ALY
        orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DuVlIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZk
        Z1z5cJy54JB2xcFnyg2M25W6GDk5JARMJJp3LGXrYuTiEBLYwSixp7ODCcL5xChxrvMFO4Tz
        jVHi6J1lrDAtl5auZ4FI7GWUeHj8MyOE855R4tfjD0wgVcICQRLtL88AtXNwiAjESKx/FwFS
        wyzwgUni/6uHYDVsAloS+1/cYAOx+QUUJa7+eMwIYvMK2Ek8P/CDDaSXRUBF4vr/ApCwqECY
        xMltLVAlghInZz5hAbE5BWwkLn5uZgexmQXEJW49mc8EYctLNG+dzQyyV0LgCYfE+nu9bBAf
        uEi07FrPCGELS7w6voUdwpaS+PxuL1RNtcTKk0fYIJo7GCW27L8A9b6xxP6lk5lAjmMW0JRY
        v0sfIqwosfP3XEaIxXwS7772sIKUSAjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJ3ZiF5
        YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAIObI3MYKTtJbZDsZJbz/oHWJk4mA8xCjBwawkwnvB
        b1G8EG9KYmVValF+fFFpTmrxIUZTYPhOZJYSTc4H5om8knhDUyNjY2MLE0MzU0NDJXHeP9od
        8UIC6YklqdmpqQWpRTB9TBycUg1MKeeCCvhF0uoVEgKr57mdYt5aGqH84euWOG4dl62H5wU+
        CWWV9LpgXyzh2P3pevbMH/nGDzpf3z6/rvpnXVNLplV16nZV82dLwq/umbM++8f/pEv9V8p2
        6M82/GX6Z3v051Vhoj6rmB7tuyu+OO3FV7cZzVzd30U1ZvjNfKm3TOz0U4ZEkyNLVx/rtLkR
        3Lr70aWr610juCUrb6yVn2C+uiR9w1vxRbMUmEUcXCYKivgcy7ITfvn3ZGy59RG7IsFlPcXy
        gS8qGPg8rK+evbxm6XX9DXrnnlxIsX301aXT54mfrFzm1YVyO38fZNFdG/tdQfPf7+tZeQKx
        NSrKed/P6ySuaH8U8n3t8hVGoQ7ySizFGYmGWsxFxYkAGLBAg1sEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvK5z3OJ4g8PdAhb357UyWmycsZ7V
        Yv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        3G5cwWbRuvcIu8XhN+2sFjMmv2RzEPDYtKqTzePOtT1sHve7jzN5bF5S79G3ZRWjx+dNcgFs
        UVw2Kak5mWWpRfp2CVwZVz4cZy44pF1x8JlyA+N2pS5GTg4JAROJS0vXs3QxcnEICexmlFh7
        opcFIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBLb22awgdQICwRJtL88ww5iiwjESJyaPAtsELPA
        ByaJQ3M7GSE6+hklbr5fzApSxSagJbH/xQ2wbn4BRYmrPx4zgti8AnYSzw/8YAPZxiKgInH9
        fwFIWFQgTGLnksdMECWCEidnPgE7jlPARuLi52awxcwC6hJ/5l1ihrDFJW49mc8EYctLNG+d
        zTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4HjV
        0tzBuH3VB71DjEwcjIcYJTiYlUR4L/gtihfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6NwYZyQ
        QHpiSWp2ampBahFMlomDU6qBKUj2S8hy1z97TXTyrt8QKOd7J//siKxukYtHnXaIaPTsLytL
        lJ1/zE59uDmsxKNp4fFrQuy3Ncy+lT1j1/ascDyR2vL7qyrLspyZIqGHZ4V9+2g92TrkxSWO
        pddn7U/jr6+UZLrgM+vA/cU/G4wqug83/eScsrZ2geruSdV7fef7/wvcqrOb3zX/84KvKs6q
        Im8s+tVK5nF9mbxj5WKzSx6LmvRMowykpzzwYlxo9v7ocpbPC5SfxWQcm1bw7VeHyc7wfH/u
        hJrvP8ND5K9fyytU2sM8O/9qCKPalOpp957Nr31qsP1KT6C6QdeGjswaVqsP6gbJVeovyzMD
        lx0pObPRQM/e1l1pxwHmloRoJZbijERDLeai4kQA7yQn5EYDAAA=
X-CMS-MailID: 20201105020659epcas1p1785d0bdc28b3a4356b966b51199d11cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e
References: <CGME20201104103713eucas1p2d21b6f936aa18725ae4b4878f3be0a8e@eucas1p2.samsung.com>
        <20201104103657.18007-1-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On 11/4/20 7:36 PM, Sylwester Nawrocki wrote:
> This patchset adds interconnect API support for the Exynos SoC "samsung,
> exynos-bus" compatible devices, which already have their corresponding
> exynos-bus driver in the devfreq subsystem.  Complementing the devfreq
> driver with an interconnect functionality allows to ensure the QoS
> requirements of devices accessing the system memory (e.g. video processing
> devices) are fulfilled and aallows to avoid issues like the one discussed
> in thread [1].
> 
> This patch series adds implementation of the interconnect provider per each
> "samsung,exynos-bus" compatible DT node, with one interconnect node per
> provider.  The interconnect code which was previously added as a part of
> the devfreq driver has been converted to a separate platform driver.
> In the devfreq a corresponding virtual child platform device is registered.
> Integration of devfreq and interconnect frameworks is achieved through
> the PM QoS API.
> 
> A sample interconnect consumer for exynos-mixer is added in patches 6/7,
> 7/7, it is currently added only for exynos4412 and allows to address the
> mixer DMA underrun error issues [1].
> 
> Changes since v7:
>  - drivers/interconnect/exynos renamed to drivers/interconnect/samsung,
>  - added INTERCONNECT_SAMSUNG Kconfig symbol,
>  - added missing driver sync_state callback,
>  - improved the DT binding description,
>  - added a patch adding maintainers entry,
>  - updated comment in patch 7/7, typo fix (patch 1/7).
> 
> The series has been tested on Odroid U3 board. It is based on v5.10-rc1.
> 
> --
> Regards,
> Sylwester
> 
> Changes since v6:
>  - the interconnect consumer DT bindings are now used to describe dependencies
>    of the interconnects (samsung,exynos-bus nodes),
>  - bus-width property replaced with samsung,data-clk-ratio,
>  - adaptation to recent changes in the interconnect code
>    (of_icc_get_from_provider(), icc_node_add()).
> 
> Changes since v5:
>  - addition of "bus-width: DT property, which specifies data width
>    of the interconnect bus (patches 1...2/6),
>  - addition of synchronization of the interconnect bandwidth setting
>    with VSYNC (patch 6/6).
> 
> Changes since v3 [4] (v4 skipped to align with patchset [1]), detailed
> changes are listed in patches:
>  - conversion to a separate interconnect (platform) driver,
>  - an update of the DT binding documenting new optional properties:
>    #interconnect-cells, samsung,interconnect-parent in "samsung,exynos-bus"
>    nodes,
>  - new DT properties added to the SoC, rather than to the board specific
>    files.
> 
> Changes since v2 [5]:
>  - Use icc_std_aggregate().
>  - Implement a different modification of apply_constraints() in
>    drivers/interconnect/core.c (patch 03).
>  - Use 'exynos,interconnect-parent-node' in the DT instead of
>    'devfreq'/'parent', depending on the bus.
>  - Rebase on DT patches that deprecate the 'devfreq' DT property.
>  - Improve error handling, including freeing generated IDs on failure.
>  - Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().
> 
> Changes since v1 [6]:
>  - Rebase on coupled regulators patches.
>  - Use dev_pm_qos_*() API instead of overriding frequency in
>    exynos_bus_target().
>  - Use IDR for node ID allocation.
>  - Reverse order of multiplication and division in
>    mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.
> 
> 
> References:
> [1] https://patchwork.kernel.org/patch/10861757/ (original issue)
> [2] https://www.spinics.net/lists/linux-samsung-soc/msg70014.html
> [3] https://www.spinics.net/lists/arm-kernel/msg810722.html
> [4] https://lore.kernel.org/linux-pm/20191220115653.6487-1-a.swigon@samsung.com
> [5] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> [6] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)
> 
> 
> Artur Świgoń (1):
>   ARM: dts: exynos: Add interconnects to Exynos4412 mixer
> 
> Sylwester Nawrocki (6):
>   dt-bindings: devfreq: Add documentation for the interconnect
>     properties
>   interconnect: Add generic interconnect driver for Exynos SoCs
>   MAINTAINERS: Add entry for Samsung interconnect drivers
>   PM / devfreq: exynos-bus: Add registration of interconnect child
>     device
>   ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes
>   drm: exynos: mixer: Add interconnect support
> 
>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  71 +++++++-
>  MAINTAINERS                                        |   7 +
>  arch/arm/boot/dts/exynos4412.dtsi                  |   7 +
>  drivers/devfreq/exynos-bus.c                       |  17 ++
>  drivers/gpu/drm/exynos/exynos_mixer.c              | 146 ++++++++++++++-
>  drivers/interconnect/Kconfig                       |   1 +
>  drivers/interconnect/Makefile                      |   1 +
>  drivers/interconnect/samsung/Kconfig               |  13 ++
>  drivers/interconnect/samsung/Makefile              |   4 +
>  drivers/interconnect/samsung/exynos.c              | 199 +++++++++++++++++++++
>  10 files changed, 456 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/interconnect/samsung/Kconfig
>  create mode 100644 drivers/interconnect/samsung/Makefile
>  create mode 100644 drivers/interconnect/samsung/exynos.c
> 

I tested it. It is well working. Thanks.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
