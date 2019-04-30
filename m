Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C418EFCD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 06:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfD3EzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 00:55:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46968 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfD3EzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 00:55:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430045512epoutp022683800c588c67f8de6c13d1ffbd7bff~aJ44sfURP2131721317epoutp02W
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 04:55:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430045512epoutp022683800c588c67f8de6c13d1ffbd7bff~aJ44sfURP2131721317epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556600112;
        bh=Kr2EJtQBEjvLCyCDiIHvPHj47DooKA1ezT8asW04amk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=r7g3pzNC27OEfvgALYh48GdC2omwF2HviuTs+2OXdgbDwzcBEU6JhX5GCs4K3Tq+I
         SP5hgHL5MEsNJlzQwQPIbv4YYIoh23pkvmR5m/vTFUJBWLVGN9ii2PR+xm0TmmxEag
         YCbaihHFL5QD6U4T1KAc2lf9vPTi8Ww16n/4VR0s=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430045509epcas1p2302c64dfbd4a8ab28246de25e11fd1bd~aJ41LZ7E50715107151epcas1p2r;
        Tue, 30 Apr 2019 04:55:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.BD.04143.C25D7CC5; Tue, 30 Apr 2019 13:55:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430045508epcas1p2bd7798f5d17968714afc0fb029932f9b~aJ40uIxav0935909359epcas1p2M;
        Tue, 30 Apr 2019 04:55:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430045508epsmtrp1d456c57b94621fed9fb12ad1823bd74a~aJ40sgk9L1373413734epsmtrp1i;
        Tue, 30 Apr 2019 04:55:08 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-be-5cc7d52c12a2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.5E.03662.C25D7CC5; Tue, 30 Apr 2019 13:55:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430045508epsmtip1938639aed89129727ab18664d4554cef~aJ40ZzIa52651326513epsmtip1D;
        Tue, 30 Apr 2019 04:55:08 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a1ff3566-6117-b670-a2f3-b60a2bbec14a@samsung.com>
Date:   Tue, 30 Apr 2019 13:56:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmvq7O1eMxBp97LC02zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3
        G1ewWbTuPcJucfhNO6vFtxOPGB0EPNbMW8PosXPWXXaPTas62Tw2L6n3OPhuD5NH35ZVjB6f
        N8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAy
        BSpMyM44tDixYJJwxeEVf1gaGE/zdzFyckgImEis27OIrYuRi0NIYAejxI2GHYwQzidGiQPr
        lkBlvjFK3NvYwQ7T0jphATNEYi+jxI+GS1At7xklJh/bCFYlLBAnsW7LTHaQhIjAWUaJB03b
        wGYxC3xmlDj54BorSBWbgJbE/hc32EBsfgFFias/HjOC2LwCdhKLdz0Cm8QioCrReOUgmC0q
        ECFx/9gGVogaQYmTM5+wgNicAt4SLx+/BpvDLCAucevJfCYIW16ieetsZoi7D7FLTJiYBGG7
        SCzfdpsJwhaWeHV8C9RvUhIv+9ug7GqJlSePgB0tIdDBKLFl/wVWiISxxP6lk4GaOYAWaEqs
        36UPsYtP4t3XHlaQsIQAr0RHmxBEtbLE5Qd3oVZJSixu72SDsD0k7r6ayjiBUXEWkm9mIflg
        FpIPZiEsW8DIsopRLLWgODc9tdiwwBg5ujcxghO2lvkOxg3nfA4xCnAwKvHwerw7FiPEmlhW
        XJl7iFGCg1lJhNfj+NEYId6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwPzCZ5JfGGpkbGxsYW
        JoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6mDg4pRoYSyQmdIiaM25WF9ziV5IkPeF8glxo
        5gPDe3mMVyenTHwyw+Uj33qzKcxPPtvU3XjyaNbPPXJRu+ouMMtoyYYUT49fPeW2EoO5TBrD
        bc9ZOqvu5CeyK705LXPAaMbDhuuavje7f31T0d9kYRnlwG2npdsRqrhAWmZ1Zql397+v+TPl
        medw9KYrsRRnJBpqMRcVJwIA/3wlNe4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnK7O1eMxBrNvSltsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlaLbyceMToIeKyZt4bRY+esu+wem1Z1snlsXlLvcfDdHiaPvi2rGD0+
        b5ILYI/isklJzcksSy3St0vgyji0OLFgknDF4RV/WBoYT/N3MXJySAiYSLROWMDcxcjFISSw
        m1Hi9o3FTBAJSYlpF48CJTiAbGGJw4eLIWreMko8Ov2cGaRGWCBOYt2WmewgCRGBs4wSiyYt
        AHOYBT4zSkxfcxlq7H1GicY7l9hAWtgEtCT2v7gBZvMLKEpc/fGYEcTmFbCTWLzrETuIzSKg
        KtF45SCYLSoQIXHm/QoWiBpBiZMzn4DZnALeEi8fvwabwyygLvFn3iVmCFtc4taT+UwQtrxE
        89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQI
        jl0trR2MJ07EH2IU4GBU4uH1eHcsRog1say4MvcQowQHs5IIr8fxozFCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGF0uz85/e0H9zg3djE96YhtFX+nr
        VzMy7ll0fkXARt6F0R9Ntm81n7jzHNtM3wW3OKqFD/ouCjl+4mfv5b7vU9l9GspmWd1xzp82
        t+Zf7p2JvrY7t7+U+Slwm/WCQdzKtbN8nD5zvOdQ+Kq/oKRO5qHVjYnFdq6HZO5sEN7QdHnR
        ZU3DN8EOraeVWIozEg21mIuKEwHrghTB2QIAAA==
X-CMS-MailID: 20190430045508epcas1p2bd7798f5d17968714afc0fb029932f9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
        <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I agree of this patch. But, I add the minor comments.

If you edit them according to my comment, feel free to add my following tag:
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
> This patch add support of a new feature which can be used in DT:
> Performance Monitoring Unit with defined event data type.
> In this patch the event data types are defined for Exynos PPMU.
> The patch also updates the MAINTAINERS file accordingly and
> adds the header file to devfreq event subsystem.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                           |  1 +
>  include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3671fde..1ba4b9b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4560,6 +4560,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>  S:	Supported
>  F:	drivers/devfreq/event/
>  F:	drivers/devfreq/devfreq-event.c
> +F:	include/dt-bindings/pmu/exynos_ppmu.h
>  F:	include/linux/devfreq-event.h
>  F:	Documentation/devicetree/bindings/devfreq/event/
>  
> diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
> new file mode 100644
> index 0000000..08fdce9
> --- /dev/null
> +++ b/include/dt-bindings/pmu/exynos_ppmu.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Samsung Exynos PPMU event types for counting in regs
> + *
> + * Copyright (c) 2019, Samsung

Mabye, "Samsung Electronics" instead of 'Samsung'.

> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
> + */
> +
> +#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +
> +

Remove unneeded blank line.

> +#define PPMU_RO_BUSY_CYCLE_CNT		0x0
> +#define PPMU_WO_BUSY_CYCLE_CNT		0x1
> +#define PPMU_RW_BUSY_CYCLE_CNT		0x2
> +#define PPMU_RO_REQUEST_CNT		0x3
> +#define PPMU_WO_REQUEST_CNT		0x4
> +#define PPMU_RO_DATA_CNT		0x5
> +#define PPMU_WO_DATA_CNT		0x6
> +#define PPMU_RO_LATENCY			0x12
> +#define PPMU_WO_LATENCY			0x16
> +#define PPMU_V2_RO_DATA_CNT		0x4
> +#define PPMU_V2_WO_DATA_CNT		0x5
> +#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
