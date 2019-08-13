Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E808AFC0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 08:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfHMGQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 02:16:07 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49286 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfHMGQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 02:16:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190813061605epoutp0194400da1f9ecd9f626414ca06da2a11c~6ZueSfpni1785017850epoutp01T
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 06:16:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190813061605epoutp0194400da1f9ecd9f626414ca06da2a11c~6ZueSfpni1785017850epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565676965;
        bh=aJ0BBXg/PQedMyWJYwbpKNP9D6ywJDdijDmPYYIiPy4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bT/OhGwWBS3YbDJUKMtt8wULIC/f9JDR+Su61V3orZAkCvAS+zE+dZBapCCFlPM/8
         aCyWbA8+Hz1SG6edv1WDzXvUAkVIx2mg0hjWYHaYAiAgy1TDp/sUrv5/m7vDTOgGD/
         nLFPZU+bFwwSJEKnljsDelOhXnVPVqh6tMAvvKB4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190813061604epcas1p43d325761010aa4fdd5e36a6dac72ea4f~6ZuderG-x0120401204epcas1p4V;
        Tue, 13 Aug 2019 06:16:04 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4672XJ5vH5zMqYlv; Tue, 13 Aug
        2019 06:16:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.24.04066.0A5525D5; Tue, 13 Aug 2019 15:16:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190813061600epcas1p33ce1749e852497ea8d2093f978bb16f8~6ZuZxca7q0318403184epcas1p3I;
        Tue, 13 Aug 2019 06:16:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813061600epsmtrp26ed9a09a69ca14b0dbc75289b4cb9ad4~6ZuZwe2k82316323163epsmtrp2r;
        Tue, 13 Aug 2019 06:16:00 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-e2-5d5255a015ec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.93.03706.0A5525D5; Tue, 13 Aug 2019 15:16:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190813061559epsmtip1b78be1b5e0d8cf3a5a94bc24d44a8371~6ZuZX6mMb2327223272epsmtip1P;
        Tue, 13 Aug 2019 06:15:59 +0000 (GMT)
Subject: Re: [RFC PATCH 00/11] Simple QoS for exynos-bus driver using
 interconnect
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        m.szyprowski@samsung.com
Organization: Samsung Electronics
Message-ID: <08be4ed8-5a6c-e0da-61a3-ca7b9fa61aab@samsung.com>
Date:   Tue, 13 Aug 2019 15:19:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6be31199-a93d-c440-e0cd-7453e3ac1648@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmvu6C0KBYg5utBhaHjm1lt5h/5Byr
        xZWv79kspu/dxGYx6f4EFovz5zewW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7BZ
        zJj8ks2B12PTqk42jzvX9rB53O8+zuSxeUm9x8F3e5g8+rasYvT4vEkugD0q2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG9o5O1oLpihXt
        Z7azNzC2SncxcnJICJhIzDx/lLGLkYtDSGAHo8Tly9fYIJxPjBKTv22DynxjlPjSu5oFpqXl
        3G+oqr2MEt/OnmcDSQgJvAdyjleB2MICIRLHN39lBLHZBLQk9r+4AVYjItDOJNG80QGkmVlg
        IqPE8+P/mUAS/AKKEld/PAZr4BWwk/izZBtQnIODRUBV4u1CEZCwqECExKcHh1khSgQlTs58
        AnYQp4C9xKW768BamQXEJW49mc8EYctLNG+dzQyyS0JgHbvElWNLmSE+cJHoPHuBCcIWlnh1
        fAs7hC0l8fndXjYIu1pi5ckjbBDNHYwSW/ZfYIVIGEvsXzoZ7DhmAU2J9bv0IcKKEjt/z4U6
        gk/i3dceVpASCQFeiY42IYgSZYnLD+5CrZWUWNzeyTaBUWkWkndmIXlhFpIXZiEsW8DIsopR
        LLWgODc9tdiwwBg5tjcxglOylvkOxg3nfA4xCnAwKvHwViQExgqxJpYVV+YeYpTgYFYS4b1k
        EhQrxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OB+SKvJN7Q1MjY2NjCxNDM1NBQSZx34Q+L
        WCGB9MSS1OzU1ILUIpg+Jg5OqQbG/r9bl8ZKzfs/+/O3zMVyZ4XsZDUXXZobbVN8YGtUfN9H
        G/tz/3MDT/9c+mbSzVDeiUrOXql3Ij5E7dBZtC5p6+K78yc4Wz/Z9KkjLslL/WAk+82p4m5/
        dl5dwFhs6S5WNdt76pJdF8R7/kyapWfCz9JsJR/3S1va+mFZRPLmKWzWuutvrOReoMRSnJFo
        qMVcVJwIAPbeD6ffAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO6C0KBYgxetAhaHjm1lt5h/5Byr
        xZWv79kspu/dxGYx6f4EFovz5zewW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7BZ
        zJj8ks2B12PTqk42jzvX9rB53O8+zuSxeUm9x8F3e5g8+rasYvT4vEkugD2KyyYlNSezLLVI
        3y6BK2N7RydrwXTFivYz29kbGFuluxg5OSQETCRazv1m62Lk4hAS2M0ocf/2AkaIhKTEtItH
        mbsYOYBsYYnDh4shat4ySjy7NJ8NpEZYIETi+OavYPVsAloS+1/cABskItDOJNHdupURxGEW
        mMgo8fjwWmaI9lOMEv+P9oG18AsoSlz98RjM5hWwk/izZBsTyDoWAVWJtwtFQMKiAhESh3fM
        gioRlDg58wkLiM0pYC9x6e46sDizgLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR9FpKW
        WUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzg+tTR3MF5eEn+IUYCD
        UYmHtyIhMFaINbGsuDL3EKMEB7OSCO8lk6BYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845F
        CgmkJ5akZqemFqQWwWSZODilGhjD1tVfl+cyvViyNtHtyYYNdzZ7KFdMcBVmz3r4rGv+QTk7
        hjkqCrNOtE49EZfy5saDFM1b0icvK1+NjtvFGy/z//T6tXNvXXG/87ApPCfW8674hCPnp0V3
        Tzg0i/E098LXMW+qhD51aymX7o3pOMdltKYg2Eb4dISZDN+MJx1u6+95F5+O4/ynxFKckWio
        xVxUnAgAVept3MsCAAA=
X-CMS-MailID: 20190813061600epcas1p33ce1749e852497ea8d2093f978bb16f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5
References: <CGME20190723122022eucas1p2f568f74f981f9de9012eb693c3b446d5@eucas1p2.samsung.com>
        <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <6be31199-a93d-c440-e0cd-7453e3ac1648@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On 19. 8. 13. 오후 3:17, Chanwoo Choi wrote:
> Hi Artur.
> 
> The patch1-4 in this series depend on other patches[1] on mainline.
> On next v2 version, please make some patches based on patches[1]
> in order to prevent the merge conflict. 
> 
> [1] [RESEND PATCH v5 0/4] add coupled regulators for Exynos5422/5800
> - https://protect2.fireeye.com/url?k=4f35944fb07b6ba2.4f341f00-9498e831e3c86bfb&u=https://lkml.org/lkml/2019/8/8/217

Add correct reference url as following:
- https://lkml.org/lkml/2019/8/8/217

> 
> Also, as I commented, we better to discuss it before sending the v2.
> 
> On 19. 7. 23. 오후 9:20, Artur Świgoń wrote:
>> The following patchset adds interconnect[1][2] framework support to the
>> exynos-bus devfreq driver. Extending the devfreq driver with interconnect
>> capabilities started as a response to the issue referenced in [3]. The
>> patches can be subdivided into four logical groups:
>>
>> (a) Refactoring the existing devfreq driver in order to improve readability
>> and accommodate for adding new code (patches 01--04/11).
>>
>> (b) Tweaking the interconnect framework to support the exynos-bus use case
>> (patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
>> avoid hardcoding every single graph edge in the DT or driver source, and
>> relaxing the requirement contained in that function removes the need to
>> provide dummy node IDs in the DT. Adjusting the logic in
>> apply_constraints() (drivers/interconnect/core.c) accounts for the fact
>> that every bus is a separate entity and therefore a separate interconnect
>> provider, albeit constituting a part of a larger hierarchy.
>>
>> (c) Implementing interconnect providers in the exynos-bus devfreq driver
>> and adding required DT properties for one selected platform, namely
>> Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
>> generic driver for various Exynos SoCs, node IDs are generated dynamically
>> rather than hardcoded. This has been determined to be a simpler approach,
>> but depends on changes described in (b).
>>
>> (d) Implementing a sample interconnect consumer for exynos-mixer targeted
>> at the issue referenced in [3], again with DT info only for Exynos4412
>> (patches 10--11/11).
>>
>> Integration of devfreq and interconnect functionalities comes down to one
>> extra line in the devfreq target() callback, which selects either the
>> frequency calculated by the devfreq governor, or the one requested with the
>> interconnect API, whichever is higher. All new code works equally well when
>> CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
>> interconnect API functions are no-ops.
>>
>> ---
>> Artur Świgoń
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>> ---
>> References:
>> [1] Documentation/interconnect/interconnect.rst
>> [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
>> [3] https://patchwork.kernel.org/patch/10861757
>>
>> Artur Świgoń (10):
>>   devfreq: exynos-bus: Extract exynos_bus_profile_init()
>>   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
>>   devfreq: exynos-bus: Change goto-based logic to if-else logic
>>   devfreq: exynos-bus: Clean up code
>>   icc: Export of_icc_get_from_provider()
>>   icc: Relax requirement in of_icc_get_from_provider()
>>   icc: Relax condition in apply_constraints()
>>   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
>>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
>>
>> Marek Szyprowski (1):
>>   drm: exynos: mixer: Add interconnect support
>>
>>  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>>  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
>>  drivers/devfreq/exynos-bus.c                  | 296 ++++++++++++++----
>>  drivers/gpu/drm/exynos/exynos_mixer.c         |  68 +++-
>>  drivers/interconnect/core.c                   |  12 +-
>>  include/linux/interconnect-provider.h         |   6 +
>>  6 files changed, 314 insertions(+), 79 deletions(-)
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
