Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A648BD873
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393557AbfIYGn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 02:43:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27018 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbfIYGn6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 02:43:58 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190925064354epoutp039c08910e7b9d150f93975fcac095314c~Hm2C1G9e90933309333epoutp03Z
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:43:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190925064354epoutp039c08910e7b9d150f93975fcac095314c~Hm2C1G9e90933309333epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569393834;
        bh=+JpzzFEUrnJs0JI9sfHqt4mDY6SihNpazCRDDuuxnqc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mbnzAqDlc1S29P09isyvJxv5jVu8uGyJPaVdeJyE5e3gtNo6tZKmOUzsgdQtfaZKy
         92c0ZD6aFn1Andc3d89LhuxK0dk6PA7zNQD/vaezqlk9jU+MEnxisMIlVE3Sx2saRr
         V1sQw9vshIpKF623n2evQAZqD7XqSZZzDh3ktLX4=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925064354epcas1p15fa7beede2a32f761933630c8bcb760a~Hm2CU5QE71046210462epcas1p1c;
        Wed, 25 Sep 2019 06:43:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46dT6c0V7TzMqYkg; Wed, 25 Sep
        2019 06:43:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.10.04224.7AC0B8D5; Wed, 25 Sep 2019 15:43:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925064351epcas1p2df5dc331f1e34dbfc566a24025b99b71~Hm1-8uJp80166701667epcas1p2F;
        Wed, 25 Sep 2019 06:43:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925064351epsmtrp29cec484d2c24ded04a197cbb7477629c~Hm1-728eC1880118801epsmtrp29;
        Wed, 25 Sep 2019 06:43:51 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-f0-5d8b0ca78022
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.5E.04081.7AC0B8D5; Wed, 25 Sep 2019 15:43:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925064351epsmtip21ca5b376c3e110dda0e2585d909829bf~Hm1-hd9mk2763927639epsmtip2r;
        Wed, 25 Sep 2019 06:43:51 +0000 (GMT)
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
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>,
        k.konieczny@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a5ff844f-12c6-4e82-6364-cad22dc852b0@samsung.com>
Date:   Wed, 25 Sep 2019 15:48:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f7387513d3c11cea7a7d35652457c1e7d7fed009.camel@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmge4Knu5YgwmrmCzuz2tltNg4Yz2r
        xctDmhbzj5xjtbjy9T2bxfS9m9gsJt2fwGKx4NMMVovz5zewW6y4+5HVYtPja6wWl3fNYbP4
        3HuE0WLG+X1MFmuP3GW3uN24gs1ixuSXbA6CHptWdbJ53Lm2h83jfvdxJo/NS+o9Nr7bweTR
        t2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
        AbpumTlADygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNz
        rQwNDIxMgQoTsjM+XDnHWtBnUzF79RzmBsaThl2MnBwSAiYSM/Y0s4DYQgI7GCUOLgvoYuQC
        sj8xSrR9es8E4XxjlDi36w47TMeK4yA2SGIvo8TkJR3MEM57RokDnUtZQaqEBcIl5r5+wAqS
        EBH4zyhxetlKMIdZoJ9JouvZW7CNbAJaEvtf3GADsfkFFCWu/njMCGLzCthJtDR0g01iEVCV
        aHvZwARiiwpESHx6cJgVokZQ4uTMJ2BzOAU8JR5NPwsWZxYQl7j1ZD4ThC0v0bx1Nth5EgKn
        2CUmPbsM9YSLRNvWycwQtrDEq+NboOJSEp/f7WWDsKslVp48wgbR3MEosWX/BVaIhLHE/qWT
        gTZwAG3QlFi/Sx8irCix8/dcRgibV6Jh4292iCP4JN597WEFKQeJd7QJQZQoS1x+cJdpAqPy
        LCTvzELywiwkL8xCWLaAkWUVo1hqQXFuemqxYYEJcnxvYgQnby2LHYx7zvkcYhTgYFTi4XVg
        7YoVYk0sK67MPcQowcGsJMI7SwYoxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBmSWvJN7Q
        1MjY2NjCxNDM1NBQSZzXI70hVkggPbEkNTs1tSC1CKaPiYNTqoFxRrvtGkmPikDdeHGXF18W
        Miislap7yb/CckHCo9+nn3+Wlirdwbdnbvn7Ao6ZLWFbV9dsF2pvteHd6Ptii4qmu9bG+axm
        mkvKgv6zyOwLSZudn9n/xuDjY+ZTfX97zju88Fi20Jzjt8eWIuHqFbyu2XdiUmbHvZTM3aAY
        7c2aGcL5htud76cSS3FGoqEWc1FxIgA4TQHO9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvO5ynu5Yg6kT1Szuz2tltNg4Yz2r
        xctDmhbzj5xjtbjy9T2bxfS9m9gsJt2fwGKx4NMMVovz5zewW6y4+5HVYtPja6wWl3fNYbP4
        3HuE0WLG+X1MFmuP3GW3uN24gs1ixuSXbA6CHptWdbJ53Lm2h83jfvdxJo/NS+o9Nr7bweTR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGR+unGMt6LOpmL16DnMD40nDLkZODgkBE4kVx++w
        dzFycQgJ7GaUuL39FBNEQlJi2sWjzF2MHEC2sMThw8UQNW8ZJVYces4OUiMsEC4x9/UDVpCE
        iMB/RomHbccYQRxmgX4micZn/awQLSuZJdoO7mQGaWET0JLY/+IGG4jNL6AocfXHY0YQm1fA
        TqKloZsVxGYRUJVoe9kAdoaoQITE4R2zoGoEJU7OfMICYnMKeEo8mn4WrJ5ZQF3iz7xLzBC2
        uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhb
        XJqXrpecn7uJERzHWpo7GC8viT/EKMDBqMTD68DaFSvEmlhWXJl7iFGCg1lJhHeWDFCINyWx
        siq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxvr9vTtZ7/iaPzzC
        dYH3vfYxLYE8sQuehuyfHjPHHX7VtJXNyfXleYPEb0/+9e0seJMzqeiShe67pOeKbW4PJ7np
        Mc4pvp28dN+kSUpSTIeK5U/LJ8f5N/V8cI+NVw9fLBs68eubtcc/1s+KjUuIKT/b22WQ/Hut
        qq1I6nGtIz1T1ve7ZVXYK7EUZyQaajEXFScCADENxkDfAgAA
X-CMS-MailID: 20190925064351epcas1p2df5dc331f1e34dbfc566a24025b99b71
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
        <d8550f93-d4cf-f215-c083-8ecad267d430@samsung.com>
        <c06ca89f2b40e0282f19727b95da5e5b0158d7e3.camel@samsung.com>
        <0cceb46a-fca1-62ae-c2cc-fb0f9b9bd132@samsung.com>
        <f7387513d3c11cea7a7d35652457c1e7d7fed009.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 25. 오후 3:37, Artur Świgoń wrote:
> On Wed, 2019-09-25 at 15:12 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 19. 9. 25. 오후 2:47, Artur Świgoń wrote:
>>> Hi,
>>>
>>> On Fri, 2019-09-20 at 11:14 +0900, Chanwoo Choi wrote:
>>>> Hi Artur,
>>>>
>>>> I tried to just build this patch on mainline kernel or linux-next.
>>>> But, when I applied them, merge conflict happens. You didn't develop
>>>> them on latest version. Please rebase them based on latest mainline kernel.
>>>
>>> I developed on top of next-20190918 on which I applied
>>> https://patchwork.kernel.org/cover/11149497/ as I mentioned in the cover
>>> letter. The dev_pm_qos patches and my RFC have just cleanly rebased together on
>>> top of next-20190920. Could you check if you have the dev_pm_qos patches (v5,
>>> the version number is missing in this one; link above) and if so, where does the
>>> conflict appear?
>>
>> I faced on the merge conflict of drivers/devfreq/exynos-bus.c.
>> I think that It is not related to to dev_pm_qos patch.
> 
> I think that it is actually related to the specific version of dev_pm_qos (v5) that
> I used because patch 08/08 of dev_pm_qos series modifies exynos_bus_probe() in
> drivers/devfreq/exynos-bus.c (https://patchwork.kernel.org/patch/11149507/).
> 
> I will rebase the next RFC (v3) on latest dev_pm_qos patches from Leonard and the
> latest Linux-next kernel.

My mistake. I only checked the Leonard's latest patches(v8)
which doesn't contain this patch. OK. I'll try again. Thanks.
[1] https://patchwork.kernel.org/patch/11149507/
- PM / devfreq: Move opp notifier registration to core

> 
>> Maybe, Kamil's patches[1] changed the many things of exynos-bus.c
>> If your test branch doesn't contain following patches, 
>> you need to rebase your patches based on latest mainline kernel 
>> from Linus Torvald.
>> [1] https://patchwork.kernel.org/cover/11083663/
>> - [RESEND PATCH v5 0/4] add coupled regulators for Exynos5422/5800
> 
> Yes, requiring Kamil's patches is one of the changes in this RFC (v2), since they
> are already merged.
> 
>> Today, I tried to apply these patch again based on latest mainline kernel.
>> The merge conflict happen still.
>>
>> - merge conflict log
>> Applying: devfreq: exynos-bus: Extract exynos_bus_profile_init()
>> error: patch failed: drivers/devfreq/exynos-bus.c:334
>> error: drivers/devfreq/exynos-bus.c: patch does not apply
>> Patch failed at 0001 devfreq: exynos-bus: Extract exynos_bus_profile_init()
>>
>>
>>>
>>>> On 19. 9. 20. 오전 10:07, Chanwoo Choi wrote:
>>>>> Hi Artur,
>>>>>
>>>>> On v1, I mentioned that we need to discuss how to change
>>>>> the v2 for this. But, I have not received any reply from you on v1.
>>>>> And, without your reply from v1, you just send v2.
>>>>>
>>>>> I think that it is not proper development sequence.
>>>>> I have spent many times to review your patches
>>>>> and also I'll review your patches. You have to take care
>>>>> the reply of reviewer and and keep the basic rule
>>>>> of mailing contribution for discussion.
>>>>>
>>>>> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
>>>>>> The following patchset adds interconnect[1][2] framework support to the
>>>>>> exynos-bus devfreq driver. Extending the devfreq driver with interconnect
>>>>>> capabilities started as a response to the issue referenced in [3]. The
>>>>>> patches can be subdivided into four logical groups:
>>>>>>
>>>>>> (a) Refactoring the existing devfreq driver in order to improve readability
>>>>>> and accommodate for adding new code (patches 01--04/11).
>>>>>>
>>>>>> (b) Tweaking the interconnect framework to support the exynos-bus use case
>>>>>> (patches 05--07/11). Exporting of_icc_get_from_provider() allows us to
>>>>>> avoid hardcoding every single graph edge in the DT or driver source, and
>>>>>> relaxing the requirement contained in that function removes the need to
>>>>>> provide dummy node IDs in the DT. Adjusting the logic in
>>>>>> apply_constraints() (drivers/interconnect/core.c) accounts for the fact
>>>>>> that every bus is a separate entity and therefore a separate interconnect
>>>>>> provider, albeit constituting a part of a larger hierarchy.
>>>>>>
>>>>>> (c) Implementing interconnect providers in the exynos-bus devfreq driver
>>>>>> and adding required DT properties for one selected platform, namely
>>>>>> Exynos4412 (patches 08--09/11). Due to the fact that this aims to be a
>>>>>> generic driver for various Exynos SoCs, node IDs are generated dynamically
>>>>>> rather than hardcoded. This has been determined to be a simpler approach,
>>>>>> but depends on changes described in (b).
>>>>>>
>>>>>> (d) Implementing a sample interconnect consumer for exynos-mixer targeted
>>>>>> at the issue referenced in [3], again with DT info only for Exynos4412
>>>>>> (patches 10--11/11).
>>>>>>
>>>>>> Integration of devfreq and interconnect functionalities is achieved by
>>>>>> using dev_pm_qos_*() API[5]. All new code works equally well when
>>>>>> CONFIG_INTERCONNECT is 'n' (as in exynos_defconfig) in which case all
>>>>>> interconnect API functions are no-ops.
>>>>>>
>>>>>> This patchset depends on [5].
>>>>>>
>>>>>> --- Changes since v1 [6]:
>>>>>> * Rebase on [4] (coupled regulators).
>>>>>> * Rebase on [5] (dev_pm_qos for devfreq).
>>>>>> * Use dev_pm_qos_*() API[5] instead of overriding frequency in
>>>>>>   exynos_bus_target().
>>>>>> * Use IDR for node ID allocation.
>>>>>> * Avoid goto in functions extracted in patches 01 & 02 (cf. patch 04).
>>>>>> * Reverse order of multiplication and division in
>>>>>>   mixer_set_memory_bandwidth() (patch 11) to avoid integer overflow.
>>>>>>
>>>>>> ---
>>>>>> Artur Świgoń
>>>>>> Samsung R&D Institute Poland
>>>>>> Samsung Electronics
>>>>>>
>>>>>> ---
>>>>>> References:
>>>>>> [1] Documentation/interconnect/interconnect.rst
>>>>>> [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
>>>>>> [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
>>>>>> [4] https://patchwork.kernel.org/cover/11083663/ (coupled regulators; merged)
>>>>>> [5] https://patchwork.kernel.org/cover/11149497/ (dev_pm_qos for devfreq)
>>>>>> [6] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
>>>>>>
>>>>>> Artur Świgoń (10):
>>>>>>   devfreq: exynos-bus: Extract exynos_bus_profile_init()
>>>>>>   devfreq: exynos-bus: Extract exynos_bus_profile_init_passive()
>>>>>>   devfreq: exynos-bus: Change goto-based logic to if-else logic
>>>>>>   devfreq: exynos-bus: Clean up code
>>>>>>   interconnect: Export of_icc_get_from_provider()
>>>>>>   interconnect: Relax requirement in of_icc_get_from_provider()
>>>>>>   interconnect: Relax condition in apply_constraints()
>>>>>>   arm: dts: exynos: Add parents and #interconnect-cells to Exynos4412
>>>>>>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>>>>>>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
>>>>>>
>>>>>> Marek Szyprowski (1):
>>>>>>   drm: exynos: mixer: Add interconnect support
>>>>>>
>>>>>>  .../boot/dts/exynos4412-odroid-common.dtsi    |   1 +
>>>>>>  arch/arm/boot/dts/exynos4412.dtsi             |  10 +
>>>>>>  drivers/devfreq/exynos-bus.c                  | 319 +++++++++++++-----
>>>>>>  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 +++-
>>>>>>  drivers/interconnect/core.c                   |  12 +-
>>>>>>  include/linux/interconnect-provider.h         |   6 +
>>>>>>  6 files changed, 327 insertions(+), 92 deletions(-)
>>>>>>
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
