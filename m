Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6DC2985D2
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421747AbgJZDHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 23:07:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15101 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421746AbgJZDHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 23:07:15 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201026030713epoutp025d1d87f35cc9f2afef23d207e33af10d~Ba-Ly-pqD2946329463epoutp02v
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 03:07:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201026030713epoutp025d1d87f35cc9f2afef23d207e33af10d~Ba-Ly-pqD2946329463epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603681633;
        bh=w0+opSElltRGksOeh+gd0FGjG9tPnd9xue83aNK3/9Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kEjY0xSU8PdQwT/aLepCKM4EP80XJe0mDPCwHwu3MFmlIrzXTf/weYWcqXiaLdCG7
         /VGcpVMWxtpsCDPTUmSHbj90m/bQLBfBfJRSVmjRo0/VrvEyTXSnmJIZV06AhyDJiL
         iYlaV0IcvUx8J7W893jcPt94jIWI/FF7IPWVyT/8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201026030712epcas1p4f8dde9c87d8eac2d981cb072cd6021ee~Ba-LRLo3U1620516205epcas1p4f;
        Mon, 26 Oct 2020 03:07:12 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CKKWL5kMQzMqYkb; Mon, 26 Oct
        2020 03:07:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.D0.09543.E5D369F5; Mon, 26 Oct 2020 12:07:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201026030710epcas1p4ba47eb39f41e4ed2398e2a9cab4720e2~Ba-ItyIsZ1634116341epcas1p4W;
        Mon, 26 Oct 2020 03:07:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201026030710epsmtrp1ab0ca966ffd00ad7f30bc54099d3d083~Ba-Is71xF0205502055epsmtrp1C;
        Mon, 26 Oct 2020 03:07:10 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-72-5f963d5e97c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.17.08745.D5D369F5; Mon, 26 Oct 2020 12:07:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026030709epsmtip25b44b1e4261ff29db9ecab6dac05b119~Ba-IYRlfd2418124181epsmtip22;
        Mon, 26 Oct 2020 03:07:09 +0000 (GMT)
Subject: Re: [PATCH v6 0/2] PM / devfreq: Add governor feature and attribute
 flag
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <56da5f5c-faab-3d81-c438-e17301a41bb6@samsung.com>
Date:   Mon, 26 Oct 2020 12:20:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201026025038.1480-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmvm6c7bR4g4ZdWhbLLh1ltNg4Yz2r
        xcQbV1gsVn98zGix5vYhRosfG04xW7TMWsRiseDTDFaLs01v2C0u75rDZvG59wijReeXWWwW
        C5ta2C1uN65gs/i5ax6LA7/HmnlrGD123F3C6LFz1l12j02rOtk8epvfsXlsfLeDyePvrP0s
        Hn1bVjF6fN4kF8AZlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA/SCkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85
        P9fK0MDAyBSoMCE741/zCvaCNUoVk869Zm9gnC7RxcjJISFgInFgTRt7FyMXh5DADkaJfV/v
        soIkhAQ+MUr0rwqFSHxmlJj8egNLFyMHWMe9c54Q8V2MEtM+bWeDaHjPKHFoWSqILSwQLHFp
        zT42kHoRgUiJ5pOCIPXMAvOZJG5fXwJWzyagJbH/xQ0wm19AUeLqj8eMIDavgJ1Ey8sXTCA2
        i4CqxJNl58AOEhUIkzi5rQWqRlDi5MwnLCA2p4CVxP4PP5hBbGYBcYlbT+YzQdjyEtvfzmEG
        WSwh8IVDYs3vT+wQL7tITFr3gBHCFpZ4dXwLVFxK4mV/G5RdLbHy5BE2iOYORokt+y+wQiSM
        JfYvncwE8hmzgKbE+l36EGFFiZ2/5zJCLOaTePe1hxUSWLwSHW1CECXKEpcf3GWCsCUlFrd3
        sk1gVJqF5J1ZSF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMESO602M4MStZbqDceLbD3qHGJk4
        GA8xSnAwK4nwzpGZGi/Em5JYWZValB9fVJqTWnyI0RQYwBOZpUST84G5I68k3tDUyNjY2MLE
        0MzU0FBJnPePdke8kEB6YklqdmpqQWoRTB8TB6dUA5M2z55HuhYr09+7/I3miPUXaY2esO29
        8JrJrUWJs8Kk7K/35gWfE7atZI1kMgt6JOayfyG76oKDZsLtwU1zAxJWqD7a0VskeE9+Te+r
        5Djbut79TyaoxD28oL256drZyuunM7jDhdyydI8efpSR480TM6da6VB784kjoQI3p5vmuQq5
        L/uvJ/3ThKnqJvebjpbVnl/2brCQu7z67flNx0IMfIPue+oXbHZjrbaXuK1h/f2jX/hb/Unl
        h6YJLKlTyHQM89mdwsD/4lWf58yf25gfmEczKaQ4tB59I951RZ95qmqr+OJFVpX733WL1OfE
        SXxY3J1V5p8dV7a+7a+Raq3/GaeDq0uFL0g83G+vxFKckWioxVxUnAgAYjlh0WUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvG6c7bR4gzdPGS2WXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFtc3jWHzeJz7xFGi84vs9gs
        Fja1sFvcblzBZvFz1zwWB36PNfPWMHrsuLuE0WPnrLvsHptWdbJ59Da/Y/PY+G4Hk8ffWftZ
        PPq2rGL0+LxJLoAzissmJTUnsyy1SN8ugSvjX/MK9oI1ShWTzr1mb2CcLtHFyMEhIWAice+c
        ZxcjF4eQwA5GiYbmPsYuRk6guKTEtItHmSFqhCUOHy6GqHnLKLF63iZmkBphgWCJS2v2sYHY
        IgKREo/uP2IFKWIWmM8k8e3/LmaIjl5GifWd28GmsgloSex/cQOsg19AUeLqj8dgcV4BO4mW
        ly+YQGwWAVWJJ8vOsYLYogJhEjuXPGaCqBGUODnzCQuIzSlgJbH/ww+wK5gF1CX+zLsEZYtL
        3HoynwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
        89L1kvNzNzGC41hLawfjnlUf9A4xMnEwHmKU4GBWEuGdIzM1Xog3JbGyKrUoP76oNCe1+BCj
        NAeLkjjv11kL44QE0hNLUrNTUwtSi2CyTBycUg1MaQXRwn1eE0/PjTVIZA/NXqXsZh+ZutXX
        NSdKc0GRsCvT34op/apKBXfEI6fVHNvu9+jT3b6J821rdHPuO1368Sco/X1Qdpt+iKL1Dpmo
        giMixp8uap5fmrDO82Dz2qrPExsiPz5lu2+R4TLb9+AsnctptrYW/3kmLtQLPq97K+/z+Vsf
        P1xsvZy1xl7hbaLfx/2LE9x/fcu02txSl8d/8YtAz3Gxfd4Hj51pDtK4G3b9hU/7k9Wulobm
        flVSeaGWkQyRTwP5JspMcrHoOGr4xODHSvHwI0/CHra8uFp5eYv7kv2f96TbyYU3/H43u+nW
        rP66G9azlq/kCdhxZE1d3MMFfj/5fjoIX71vH8ilxFKckWioxVxUnAgA6bi9elIDAAA=
X-CMS-MailID: 20201026030710epcas1p4ba47eb39f41e4ed2398e2a9cab4720e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201026023654epcas1p4866b7bbcb7276996500ee5c05d2c37f0
References: <CGME20201026023654epcas1p4866b7bbcb7276996500ee5c05d2c37f0@epcas1p4.samsung.com>
        <20201026025038.1480-1-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/26/20 11:50 AM, Chanwoo Choi wrote:
> Each devfreq governor can have the different sysfs attributes and features.
> In order to provide the only available sysfs attribute to user-space,
> add governor attribute flag with DEVFREQ_GOV_ATTR_[attribute name] defintion.
> 
> Also, each governor is able to have the specific flag in order to
> support specific feature with DEVFREQ_GOV_FLAG_[feature name] defintion
> like immutable governor.
> 
> According to each governor, can initiate the governor feature and attribute
> flags.
> 
> [Common sysfs attributes for devfreq class]
> And all devfreq governors have to support the following common attributes.
> The common attributes are added to devfreq class by default.
> - governor
> - available_governors
> - available_frequencies
> - cur_freq
> - target_freq
> - min_freq
> - max_freq
> - trans_stat
> 
> [Definition for governor attribute flag]
> - DEVFREQ_GOV_ATTR_POLLING_INTERVAL to update polling interval for timer.
>   : /sys/class/devfreq/[devfreq dev name]/polling_interval
> - DEVFREQ_GOV_ATTR_TIMER to change the type of timer on either deferrable
>   or dealyed timer.
>   : /sys/class/devfreq/[devfreq dev name]/timer
> 
> [Definition for governor feature flag]
> - DEVFREQ_GOV_FLAG_IMMUTABLE
>   : If immutable flag is set, governor is never changeable to other governors.
> - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
>   : Devfreq core won't schedule polling work for this governor if value is set.
> 
> [Table of governor attribute flags for evfreq governors]
> -----------------------------------------------------------------------------
>                       | simple    | perfor | power | user | passive | tegra30
> 		      | ondemand  | mance  | save  | space|         |
> ------------------------------------------------------------------------------
> governor              | O         | O      | O     | O    | O       | O
> available_governors   | O         | O      | O     | O    | O       | O
> available_frequencies | O         | O      | O     | O    | O       | O
> cur_freq              | O         | O      | O     | O    | O       | O
> target_freq           | O         | O      | O     | O    | O       | O
> min_freq              | O         | O      | O     | O    | O       | O
> max_freq              | O         | O      | O     | O    | O       | O
> trans_stat            | O         | O      | O     | O    | O       | O
> ------------------------------------------------------------------------------
> polling_interval      | O         | X      | X     | X    | X       | O
> timer                 | O         | X      | X     | X    | X       | X
> ------------------------------------------------------------------------------
> immutable             | X         | X      | X     | X    | O       | O
> interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
> ------------------------------------------------------------------------------
> 
> Changes from v5:
> - Remove redundant code for creating syfs files.
> - Move create_sysfs_files() position after completed governor start on
> devfreq_add_device()
> - Add reviewd-by/tested-by tag of Dmitry Osipenko
> 
> Changes from v4:
> - Rename from 'attr' to 'attrs'
> - Restore the variable name in governor_store because it is enought to explain
> the previous or new governor with detailed comments instead of variable name
> changes.
> 
> Changes from v3:
> - Fix typo
> - Rename from 'flag' to 'flags'
> - Add more exception handling code and add comments on governor_store()
> 
> Changes from v2:
> - Hide unsupported sysfs node to user-space instead of checking the permission
> of sysfs node.
> 
> Chanwoo Choi (2):
>   PM / devfreq: Add governor feature flag
>   PM / devfreq: Add governor attribute flag for specifc sysfs nodes
> 
>  Documentation/ABI/testing/sysfs-class-devfreq |  54 ++---
>  drivers/devfreq/devfreq.c                     | 187 ++++++++++++------
>  drivers/devfreq/governor.h                    |  30 ++-
>  drivers/devfreq/governor_passive.c            |   2 +-
>  drivers/devfreq/governor_simpleondemand.c     |   2 +
>  drivers/devfreq/tegra30-devfreq.c             |   5 +-
>  6 files changed, 188 insertions(+), 92 deletions(-)
> 

Applied them.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
