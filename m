Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BF140344
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 06:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAQFYe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 00:24:34 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:15663 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgAQFYe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 00:24:34 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200117052432epoutp0224a573752be0c84ea0f431fae283211d~qlTSVLpmO0459604596epoutp02L
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 05:24:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200117052432epoutp0224a573752be0c84ea0f431fae283211d~qlTSVLpmO0459604596epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579238672;
        bh=LpAZucFo3MWS+uBKvQq4uuFCJnXYaFjEyROzq9cyT1w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SbqLkqMxPHdZlUpNDfncu8rvEfx8sKlpYj8glFY4pCPx8s+wZZzle1ozphwavl9ts
         TqIk9cAJ/XFTcbX6gHeiDcr73hXEdQKjf1c4y+NflGGZgCNiQuoXwHjNBmM4azSiU4
         TXFVpTSSOkljvuf+ywUjTwrQAsQ+XOhfIhSgOmAg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200117052431epcas1p3d34f713fdddfcb0fffd72c59a4795400~qlTRsoyRm2199121991epcas1p32;
        Fri, 17 Jan 2020 05:24:31 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47zTyP54R9zMqYkb; Fri, 17 Jan
        2020 05:24:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.B0.51241.D05412E5; Fri, 17 Jan 2020 14:24:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200117052429epcas1p1330615b219b4ebcd27e8816784263661~qlTPfP-Yi3013230132epcas1p1O;
        Fri, 17 Jan 2020 05:24:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117052429epsmtrp112ace2fd7372c5621868750405edeffb~qlTPehQC31928519285epsmtrp1W;
        Fri, 17 Jan 2020 05:24:29 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-3a-5e21450d9c30
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.79.06569.D05412E5; Fri, 17 Jan 2020 14:24:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200117052429epsmtip1ae286f5f72b185cf84e5b9ad358ed86e~qlTPUKs_T0073000730epsmtip1W;
        Fri, 17 Jan 2020 05:24:29 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] interconnect: Support Samsung Exynos use-case
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     georgi.djakov@linaro.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <95ac808c-aacf-8ca8-94a7-98bbdb37b39d@samsung.com>
Date:   Fri, 17 Jan 2020 14:31:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200116144202.12116-1-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURTm7mOcLaemNeskmOuElNLWjro1ikrRGhsZaFGIhDbpRcV9sbOK
        WpJlqdlLKcjWNMmeRpmLlm6apJJYkJolJkWBElmUoWmRFe3uGPnvO/d85zvnO/eQUuUVwo/M
        NNmw1cQbGGKB7F5XsEZNxQYma+4Or+be1hxDXGNlg5w73+4guL6+u17coPMiwU2d6kZcZd9D
        CXe7+43XJlLvqD9O6F8PtRH60031SD/lWBkvS8qKysB8GraqsCnVnJZpSo9mtu9K2ZKi3aBh
        1WwEt5FRmXgjjmZ0cfHqrZkG1xiMKoc3ZLue4nlBYNbHRFnN2TasyjALtmgGW9IMlgjLOoE3
        Ctmm9HWpZmMkq9GEal3EfVkZzW1jhGXcJ/fCCFGIfi0uQwoS6HC4eKYVlaEFpJJuQTDxpJEQ
        g0kELc4nXmIwg6BiuEzyr+RlS+scqx1BzccjMjGYQDBc89jD8qG3wfc//R7WUtruSgyUSN0J
        KZ0KzdUDMjcm6BDo+DBMuPFiOhBe/hhFbkzRMTDbfsIjJKODoLSrx8PxpfdA772jc5wl0Hth
        zKVDkgo6EqZGg0T55TAydkki4gAoaq6SumcAeoKAc58bJW4+0DqonvEV3fjAx54mLxH7wfiZ
        4jl8AG72dhNibSmCpo5+uZgIg46rZz06UjoYGpzrxedAaJ2tRmLfRfBl+qRcbEVBabFSpKyC
        wXdv5pa4AupKjhPliLHPM2Of58A+z4H9f7NaJKtHy7BFMKZjgbVo53+2A3kuNCSiBT1+FteJ
        aBIx3lTlTlWyUs7nCHnGTgSklFlK9Vb6JyupND4vH1vNKdZsAxY6kda16wqpn2+q2XXvJlsK
        qw0NCwvjwtkNWpZlllPndS4dOp234SyMLdj6r05CKvwKUe6tjskAhirSmR7oumJfqNcmXeW/
        /jQGVTmnNicVD15/+vwZDqheE7RGXuTou+xse9XTGt7w9emRrL05/gm1ud73l3wi7yT8/jK0
        +9poXIj6Wzmbf7BfEbu2anxT2f7p3QuVib4FxTeo93dQwYO9iQlb8x/m1D3yNuzQKw4NHR44
        hRmZkMGzIVKrwP8F84S/V7cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTpfXVTHOoO2qkMX9ea2MFhtnrGe1
        mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y+7A4bFpVSebx51re9g8+rasYvT4vEku
        gCWKyyYlNSezLLVI3y6BK2PrnidsBS+FK2beYmtg/MPfxcjJISFgInF1x062LkYuDiGB3YwS
        izc1MUIkJCWmXTzK3MXIAWQLSxw+XAxR85ZR4vq5F0wgNcICnhLf/10AaxYRmMUocfBHH1gD
        s0CyxJ1ZORANvYwSV/4fYQVpYBPQktj/4gYbiM0voChx9cdjsGW8AnYSv/d2gw1lEVCV6Dh8
        HKxGVCBMYueSx0wQNYISJ2c+YQGZzylgJfH5sSpImFlAXeLPvEvMELa4xK0n85kgbHmJ5q2z
        mScwCs9C0j0LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHEta
        WjsYT5yIP8QowMGoxMM7I0ghTog1say4MvcQowQHs5II78kZsnFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGKMXzhP/0XWN22hmg3BFgG/2AlmHsunF
        xysiey73nJ78WVVnzaWgiBqPd5ICzp+nHr8b3bvZw9qPoWPSxMiFAXdXOv5rF/cO3709+8FV
        o12v5Zb6W8m3Ms9LMv2s4nbjUMLWM7c59zqbXIwNn5p1kmV29pW/H4/6lVXor9m54N8u27nJ
        gavELJRYijMSDbWYi4oTAd6njcChAgAA
X-CMS-MailID: 20200117052429epcas1p1330615b219b4ebcd27e8816784263661
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff
References: <CGME20200116144241eucas1p226c1d7fc2fad5bd1b9fb6d0fb1b22bff@eucas1p2.samsung.com>
        <20200116144202.12116-1-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

I'm concerned about that make it the separate series
without use-case like exynos-bus, exynos-drm.
If this series is applied to v5.6, it doesn't make
the problem and the patches for exynos-bus/exynos-drm
will be reviewed and then merged on later kernel version.

But, if not, the interconnect, exynos-bus and exynos-drm
patches should be merged into the same kernel version,
it must require the immutable branch among interconnect,
devfreq and exynos-drm. I think that you need to consider
it between different subsystems.

Regards,
Chanwoo Choi

On 1/16/20 11:41 PM, Artur Świgoń wrote:
> Previously posted as a part of a larger RFC: [1].
> 
> The Exynos SoC family relies on the devfreq driver for frequency
> scaling. However, a way to programmatically enforce QoS contraints
> (i.e., minimum frequency) is desired. A solution which uses the
> interconnect framework to ensure QoS is currently being developed[1].
> 
> The exynos-bus hierarchy is composed of multiple buses which are probed
> separately. Sometimes the DMC is even handled by a different driver.
> Since the exynos-bus driver is generic and supports multiple differing
> bus hierarchies, IDs for nodes (i.e. buses) are assigned dynamically. Due
> to the unspecified relative probing order, every bus registers its own
> interconnect provider.
> 
> Rationale for each patch in this series:
> * Patch 01 (exporting of_icc_get_from_provider()) makes it easy to
>   retrieve the parent node from the DT (cf. patch 05 in [1]).
> * Patch 02 (allowing #interconnect-cells = <0>) allows to remove dummy
>   node IDs from the DT.
> * Patch 03 (allowing inter-provider node pairs) is necessary to make
>   such multi-provider hierarchy work. A new approach implemented in v3
>   ensures not to break any existing drivers.
> 
> ---
> Changes since v3 (to patches in this series):
> * Improve commit messages.
> 
> ---
> Artur Świgoń
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> ---
> References:
> [1] https://patchwork.kernel.org/patch/11305287/
> 
> Artur Świgoń (3):
>   interconnect: Export of_icc_get_from_provider()
>   interconnect: Relax requirement in of_icc_get_from_provider()
>   interconnect: Allow inter-provider pairs to be configured
> 
>  drivers/interconnect/core.c           | 16 ++++++++--------
>  include/linux/interconnect-provider.h |  8 ++++++++
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
