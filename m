Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03739B8914
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 04:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391978AbfITCKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 22:10:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18209 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391966AbfITCKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 22:10:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190920021008epoutp02babc79d5806e97f96186bbefd7fb9ffd~GA4lEsEY00545405454epoutp02F
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 02:10:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190920021008epoutp02babc79d5806e97f96186bbefd7fb9ffd~GA4lEsEY00545405454epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568945408;
        bh=etYkGCORstqKXTVIg2t6d3cZ6ZYB6cQh4Ss274VI3xY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EU/lhYdLsq8ld6rVlyXwVHnSKFRtQlV/RqCDUsLMn8q0VOkkHw+WMZay/nhr0ZN/q
         DzFlOzCn2qvIZt4pb4ebwITctdB7xHTWRO+zztuJm4chdFMgi87QBI0fpL6xFfzFQG
         4BHBxXttVLpReEWqQd3nmrAzdgH8dYzTKyg8x1w0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190920021007epcas1p2b6e01836a9200ce64dfc0138fafc6740~GA4j_AGvO2443924439epcas1p2B;
        Fri, 20 Sep 2019 02:10:07 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46ZHH03kBZzMqYlx; Fri, 20 Sep
        2019 02:10:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.D2.04085.1F4348D5; Fri, 20 Sep 2019 11:09:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190920020952epcas1p14d7fc9a76aa1985326da62c465c7da10~GA4WsFw1m1489914899epcas1p1A;
        Fri, 20 Sep 2019 02:09:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190920020952epsmtrp13f7eee748f3f7f5372d5097809c056e4~GA4WrK33T2859428594epsmtrp1O;
        Fri, 20 Sep 2019 02:09:52 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-d5-5d8434f1d46e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.B6.03638.0F4348D5; Fri, 20 Sep 2019 11:09:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190920020952epsmtip25b017a52156e440fd537aa46363e5416~GA4WXn9UN3129031290epsmtip2W;
        Fri, 20 Sep 2019 02:09:52 +0000 (GMT)
Subject: Re: [RFC PATCH v2 00/11] Simple QoS for exynos-bus driver using
 interconnect
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Organization: Samsung Electronics
Message-ID: <d8550f93-d4cf-f215-c083-8ecad267d430@samsung.com>
Date:   Fri, 20 Sep 2019 11:14:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fe6d026d-71b5-438d-6932-6a2234fc72c2@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmvu5Hk5ZYgwV7RC3uz2tltNg4Yz2r
        xctDmhbzj5xjtbjy9T2bxfS9m9gsJt2fwGJx/vwGdosVdz+yWmx6fI3V4vKuOWwWn3uPMFrM
        OL+PyWLtkbvsFrcbV7BZzJj8ks1BwGPTqk42jzvX9rB53O8+zuSxeUm9x8Z3O5g8+rasYvT4
        vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
        6HYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGR
        KVBhQnbG20X/mAq+qFX8vnuasYHxknwXIyeHhICJxL8da5m7GLk4hAR2MEpMnfSOHSQhJPCJ
        UeLkWTkI+xujxNNWBZiGOZ1trBDxvYwSs39lQNjvGSVWXYkHsYUFwiXmvn4AVsMmoCWx/8UN
        NpAFIgL/GSVOL1vJCuIwgwz9Om8DC0gVv4CixNUfjxlBbF4BO4knh7+BXcEioCrR/30bM4gt
        KhAh8enBYVaIGkGJkzOfgPVyCthL/F+6D8xmFhCXuPVkPhOELS/RvHU22GsSAofYJV7evcoI
        8YKLxKxNbUwQtrDEq+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyUDMH0AZN
        ifW79CHCihI7f8+Fms8r0bDxNzvEEXwS7772sIKUg8Q72oQgSpQlLj+4yzSBUXkWkndmIXlh
        FpIXZiEsW8DIsopRLLWgODc9tdiwwBQ5sjcxgpO1luUOxmPnfA4xCnAwKvHwKpQ3xwqxJpYV
        V+YeYpTgYFYS4Z1j2hQrxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBmSSvJN7Q1MjY2NjC
        xNDM1NBQSZzXI70hVkggPbEkNTs1tSC1CKaPiYNTqoGRN+aDyJ01T2I+KCy5x/njGU91Zk7y
        GSf/d8u8uh8+ljskKx/3vVWo+emCr3JiQSLVB77410070CPdaMf5Ney9VZHI5QrXrHNl908I
        ML5vDip+rqHyd2nz61f3Jlc4KW6b+mhl+5ydG8XWrFo29aCn6Zf9fXeuJO5bvnSTX7YM570T
        6xeYzmp2VGIpzkg01GIuKk4EAF8bh2DsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvO4Hk5ZYgztndS3uz2tltNg4Yz2r
        xctDmhbzj5xjtbjy9T2bxfS9m9gsJt2fwGJx/vwGdosVdz+yWmx6fI3V4vKuOWwWn3uPMFrM
        OL+PyWLtkbvsFrcbV7BZzJj8ks1BwGPTqk42jzvX9rB53O8+zuSxeUm9x8Z3O5g8+rasYvT4
        vEkugD2KyyYlNSezLLVI3y6BK+Pton9MBV/UKn7fPc3YwHhJvouRk0NCwERiTmcbaxcjF4eQ
        wG5GiQfbnjNDJCQlpl08CmRzANnCEocPF0PUvGWU2PZ/NRtIjbBAuMTc1w9YQWw2AS2J/S9u
        sIEUiQj8Z5R42HaMEcRhFvjGKNH3eRkbRPtBRon2HxeYQFr4BRQlrv54zAhi8wrYSTw5/I0d
        xGYRUJXo/74N7AxRgQiJwztmQdUISpyc+YQFxOYUsJf4v3QfmM0soC7xZ94lZghbXOLWk/lM
        ELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECI5eLa0djCdOxB9iFOBgVOLhVShvjhViTSwrrsw9xCjBwawkwjvHtClWiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUAyOD2MtPLQd+6fh8K5g5zepO
        4sz/L7c9iAlqnh3Zcnd28/REsYKMV8Kr1epDe3uk+GdvlvJyKxc/91x46Y57T4Ik3O69EvB6
        n9aWxG0YItHmHPskurwsMPvyJdaQ8CchdUzGcdleiYf5My/GmHw57jwxK3T7Y9XPzSyp9m2S
        z21q18wSn6MersRSnJFoqMVcVJwIAOiXQdzaAgAA
X-CMS-MailID: 20190920020952epcas1p14d7fc9a76aa1985326da62c465c7da10
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
        <fe6d026d-71b5-438d-6932-6a2234fc72c2@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

I tried to just build this patch on mainline kernel or linux-next.
But, when I applied them, merge conflict happens. You didn't develop
them on latest version. Please rebase them based on latest mainline kernel.

On 19. 9. 20. 오전 10:07, Chanwoo Choi wrote:
> Hi Artur,
> 
> On v1, I mentioned that we need to discuss how to change
> the v2 for this. But, I have not received any reply from you on v1.
> And, without your reply from v1, you just send v2.
> 
> I think that it is not proper development sequence.
> I have spent many times to review your patches
> and also I'll review your patches. You have to take care
> the reply of reviewer and and keep the basic rule
> of mailing contribution for discussion.
> 
> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
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
>> Integration of devfreq and interconnect functionalities is achieved by
>> using dev_pm_qos_*() API[5]. All new code works equally well when
>> CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
>> interconnect API functions are no-ops.
>>
>> This patchset depends on [5].
>>
>> --- Changes since v1 [6]:
>> * Rebase on [4] (coupled regulators).
>> * Rebase on [5] (dev_pm_qos for devfreq).
>> * Use dev_pm_qos_*() API[5] instead of overriding frequency in
>>   exynos_bus_target().
>> * Use IDR for node ID allocation.
>> * Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
>> * Reverse order of multiplication and division in
>>   mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.
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
>> [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
>> [4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
>> [5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
>> [6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
>>
>> Artur Świgoń (10):
>>   devfreq: exynos-bus: Extract exynos_bus_profile_init()
>>   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
>>   devfreq: exynos-bus: Change goto-based logic to if-else logic
>>   devfreq: exynos-bus: Clean up code
>>   interconnect: Export of_icc_get_from_provider()
>>   interconnect: Relax requirement in of_icc_get_from_provider()
>>   interconnect: Relax condition in apply_constraints()
>>   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
>>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
>>
>> Marek Szyprowski (1):
>>   drm: exynos: mixer: Add interconnect support
>>
>>  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>>  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
>>  drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
>>  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
>>  drivers/interconnect/core.c                   |  12 +-
>>  include/linux/interconnect-provider.h         |   6 +
>>  6 files changed, 327 insertions(+), 92 deletions(-)
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
