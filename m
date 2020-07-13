Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62A21D047
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 09:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGMHNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 03:13:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:31041 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 03:13:23 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200713071320epoutp042c9b21c06b1f897b1253851bbf9f852f~hPnGEzBvp1957319573epoutp04V
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 07:13:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200713071320epoutp042c9b21c06b1f897b1253851bbf9f852f~hPnGEzBvp1957319573epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594624400;
        bh=6Ad1pb4JX816o4fM1DBUhs+HDCb9B16r4xRMa5wAt3c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eqrI1fsHTgbSUzctQTJZXuDp3TqIOuO7kwMM70MD4Va+c5agOAZH00EHIFKNgDnXk
         RMI5tN3C4rgRm0VRlghJvg1VA/MEknYkqrDUR2a8PaScL6j3SeTNXuiAqgJ5rFQ78/
         aPT5WRiGKIckEn5ZwU4QiunmNtJRhf/DW1SpmANU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200713071319epcas1p4cd94e53771ba78d1873e46b7cd196cd5~hPnFpTVqf1823818238epcas1p4a;
        Mon, 13 Jul 2020 07:13:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B4vxn70y5zMqYkn; Mon, 13 Jul
        2020 07:13:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.A2.28578.B890C0F5; Mon, 13 Jul 2020 16:13:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200713071315epcas1p3e533b02feb2f6a80cb655440e9175a81~hPnBmbFxS0162901629epcas1p3p;
        Mon, 13 Jul 2020 07:13:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713071315epsmtrp21616d82417c358eb56f99f9f85545c7c~hPnBloV9-2052020520epsmtrp2v;
        Mon, 13 Jul 2020 07:13:15 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-74-5f0c098b6768
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.D6.08382.B890C0F5; Mon, 13 Jul 2020 16:13:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200713071315epsmtip17da4e1533c42078276d211f6393027ac~hPnBSk1jL2351623516epsmtip1t;
        Mon, 13 Jul 2020 07:13:15 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] PM / devfreq: Add delayed timer for polling
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a6fb8011-40b5-b88a-e667-eb4926f7d5a6@samsung.com>
Date:   Mon, 13 Jul 2020 16:24:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200709054504.656-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmrm43J0+8QfN/I4uNM9azWky8cYXF
        YsGnGawW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWSxsamG3uN24gs3i
        8Jt2VotvJx4xOvB5rJm3htFj56y77B6bVnWyeWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqp
        ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA1yoplCXmlAKFAhKLi5X0
        7WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjMuHZrMXHCSs2Lh
        vvVMDYyr2bsYOTgkBEwklp3U6mLk4hAS2MEo0XHtGjuE84lRYvmNjVDON0aJ8y/72boYOcE6
        ph5uYIVI7GWUeLiglw3Cec8ose/5JVaQKmEBd4n5306xgNgiAqESs+9NZQYpYhZYzCRx8f1T
        ZpAEm4CWxP4XN8DG8gsoSlz98ZgRxOYVsJM48fQ7WJxFQFVi+eKn7CC2qECYxMltLVA1ghIn
        Zz4BW8ApYCmx5cY0sMXMAuISt57MZ4Kw5SW2v50DtlhC4AaHxKVf3SwQP7hINK7bwwRhC0u8
        Or6FHcKWkvj8bi/Un9USK08eYYNo7mCU2LL/AitEwlhi/9LJTKDgYxbQlFi/Sx8irCix8/dc
        RojFfBLvvvawQkKYV6KjTQiiRFni8oO7UGslJRa3d7JNYFSaheSdWUhemIXkhVkIyxYwsqxi
        FEstKM5NTy02LDBFju5NjOCkrGW5g3H62w96hxiZOBgPMUpwMCuJ8EaLcsYL8aYkVlalFuXH
        F5XmpBYfYjQFBvBEZinR5HxgXsgriTc0NTI2NrYwMTQzNTRUEuf9d5Y9XkggPbEkNTs1tSC1
        CKaPiYNTqoEpxujGWc+wit3Ki5yZFB9OKWE9UhfhvcNdgk1199MMdUf1+7NMfneLbWxJmjRt
        WcR21bUMZTWT3bxc/nq9mp0yh9fr9z/W7rmGh/68OaLYnBu5dF+gJKuRmJjeFJWXTM3fOd8d
        q31ZvW+51J05npq7joRYVF5c8JhTxlF5b5XFvEdfalwrSlMnW9w5vGh1kAGLAuvzTdPjjpS1
        J+q9sf0T2WZyR3TZjduZ789ffzwzj3fPyzOJ5ysV3rUsMIl7tihk2TbOXXstF7/bvOHUoyMv
        JDjvnFViCVj5rf+9dQWz9u9Cvtt7hLe+ivT3bs/Q45Fi9SxmvlE2oXtV8caDepfFX7lnnKxh
        2d/vvv5R9QEBJZbijERDLeai4kQAu9D341MEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnG43J0+8wbwV4hYbZ6xntZh44wqL
        xYJPM1gt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jsljY1MJucbtxBZvF
        4TftrBbfTjxidODzWDNvDaPHzll32T02repk89i8pN6jb8sqRo/Pm+QC2KK4bFJSczLLUov0
        7RK4Mi4dmsxccJKzYuG+9UwNjKvZuxg5OSQETCSmHm5g7WLk4hAS2M0o8ap7ElRCUmLaxaPM
        XYwcQLawxOHDxSBhIYG3jBJNexVAbGEBd4n5306xgNgiAqESrd/fsYPMYRZYzCSx5NIsNoih
        PYwSbzYfZAKpYhPQktj/4gYbiM0voChx9cdjRhCbV8BO4sTT72BxFgFVieWLn4IdISoQJrFz
        yWMmiBpBiZMzn4Bt4xSwlNhyYxoriM0soC7xZ94lZghbXOLWk/lMELa8xPa3c5gnMArPQtI+
        C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERydWpo7GLev+qB3
        iJGJg/EQowQHs5IIb7QoZ7wQb0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1ML
        UotgskwcnFINTNUvXJax8iyasDFCLvDVskSPHTm9yxs5Jv7zWhCn4rgno+Kz2dzzi55LqSxc
        eWiafecCsyPe3AZu5WfSj5/smPqjpuWtYPNaLgmPnWr3lsRVuTw4UBeVmGak+re0fqLzu5LN
        pcWVof8cBKwfxhvwl86ev2lawKZ4ibfuu0J3SmS87TphKb9V+ZnNkha3qyoLmgNLitfvzZTy
        uxa094HIztNzZ+1+/DenM/akyKEr6fLP3wn4nvofo7lYp//lCWmbvm1X5pm3n38XZnThVdp2
        EcYTr14f1O3eLbu7fe7CxhN1wqZJd3Z+vKngPaUxrl23QcDk1o4rc+r6q6xzRRP6ROpn9Ob8
        dzcKFm4/G9PipsRSnJFoqMVcVJwIADEorhM9AwAA
X-CMS-MailID: 20200713071315epcas1p3e533b02feb2f6a80cb655440e9175a81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709053339epcas1p23fb1c080b21c758940514c4672949cfa
References: <CGME20200709053339epcas1p23fb1c080b21c758940514c4672949cfa@epcas1p2.samsung.com>
        <20200709054504.656-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear all,

On 7/9/20 2:45 PM, Chanwoo Choi wrote:
> Add the delayed timer to devfreq framework in order to support
> the periodical polling mode without stop caused by CPU idle state.
> Some Non-CPU device must need to monitor the device status like
> utilization regardless of CPU state.
> 
> - patch1 explains the detailed reason why the delayed timer is required.
> - patch2 initializes that exynos5422-dmc device use delayed timer as default
> instead of deferrable timer.
> 
> Changes from v2:
> - Add reviewed-by tag
> - Fix typo on patch description
> - Remove 'RFC' work from patch title
> - Check whether 'df->governor' is NULL or not on timer_store()
> 
> Chanwoo Choi (2):
>   PM / devfreq: Add support delayed timer for polling mode
>   memory: samsung: exynos5422-dmc: Use delayed timer as default
> 
>  Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
>  drivers/devfreq/devfreq.c                     | 86 ++++++++++++++++++-
>  drivers/memory/samsung/exynos5422-dmc.c       |  1 +
>  include/linux/devfreq.h                       |  9 ++
>  4 files changed, 107 insertions(+), 1 deletion(-)
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
