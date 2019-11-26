Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5710A70F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 00:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKZXTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 18:19:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:43191 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfKZXTt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 18:19:49 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191126231947epoutp013bc28c10a715b041ca28dd769a5fda68~a2bQkfrL31428714287epoutp01X
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 23:19:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191126231947epoutp013bc28c10a715b041ca28dd769a5fda68~a2bQkfrL31428714287epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574810387;
        bh=Ji4cnZm4BXhP+LF1Lgk0+EgkkAxbfAnhq9Me2pJPuIw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lvyssS/ydklsihuu6EgNNvWvVtkjYhRpIgp3aqoOU4FLa+vPLktXqfOApLy4RGj90
         c7PPhjbjT5tr2UzLbHnt9etPTQ57d2V5taPf4qks1g9LYfUTf0y0z+4/11kVgyk1XZ
         ewIEpzE0GSPcUOy3kl0QBh7aW/ajHcgfYdP4M9MM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191126231946epcas1p2ea532486ea80695eb2f1bd9d660f2ee3~a2bPcW6Gf1616816168epcas1p2E;
        Tue, 26 Nov 2019 23:19:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47N0H265kKzMqYkY; Tue, 26 Nov
        2019 23:19:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.04.48019.E03BDDD5; Wed, 27 Nov 2019 08:19:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191126231942epcas1p2017370a78a1fbab9bd1b6dc00b60d4ef~a2bLgAOo81986019860epcas1p2M;
        Tue, 26 Nov 2019 23:19:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191126231941epsmtrp10625413b49f837a71ea879d20efd2daf~a2bLe3MOA1689216892epsmtrp1F;
        Tue, 26 Nov 2019 23:19:41 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-8e-5dddb30eae2f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.E9.10238.D03BDDD5; Wed, 27 Nov 2019 08:19:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191126231941epsmtip2f89c28cf9f0b573a471d1d834a269a92~a2bK_A5_Z0204302043epsmtip2y;
        Tue, 26 Nov 2019 23:19:41 +0000 (GMT)
Subject: Re: [PATCH v7 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7224948f-8489-ffcd-9a51-bb7da7ee5e0a@samsung.com>
Date:   Wed, 27 Nov 2019 08:25:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJmZUVmM9BqQuD1npJ7Nqsh07CSEA5nB9-pt0v_X6HQCA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxje6f3orVnlrsA41kTw6mbAIK1QPC5glkz0JuMHZsuykRB2Q++A
        0K/1tsaPxOEShBaG4kSk4iA6tFaztQUHKoxRujFkomDsRMSZ1Im4AUHGJjBlbS9m/HvyvM/z
        vu/znhwKU3RLlVSxwcKbDZyOIVfg3/UkqpJXtozmqXrH1cj30yUpmu2/BtDZoR8B+qv2CoaC
        v40A1FZfgBr9AwTytIzgqK7TSyJX7WUc3bjhlqLrn/8pRc7RaQJ5gwECTVfdJ5B9/jyGZr7w
        A9T866AEBZw1BJpxBwEavJaFRg46SXRhoJtEv/QPEais0y9Fdt9zEr0IeHD0uDUONZ8JYMgz
        y769hq21OwF78auLgJ26UyZlT5YO4myT18p6XTaSvRfoINmWrz9jPZPtErZ7skPCHn6uYud7
        YtnW2+U4W93qAuyMd01OVG5JRhHPaXlzAm8oMGqLDYWZzLvv5b+Tr0lXqZPVW9EWJsHA6flM
        Znt2TvKOYl3oRkzCbk5nDVE5nCAwKdsyzEarhU8oMgqWTIY3aXWmraZNAqcXrIbCTQVG/Vtq
        lWqzJiT8uKTo1M0TmOnF6j3eiSZQCsZi7EBGQToNehZdEjtYQSnodgAnpn4H4YKCfgrg4lCG
        WPgbwCd1o/hLx0jjEC4WOgEMnlhYsk8BePyHW1hYFU1/CJ1Xv484Yuj10D12N8Jj9HUZ7BtK
        CWOSToJdj++QYRxFr4W3nwUjo+X0Nlj76GyEx+k3YFtlUwhTVGyoZ/8sJ0peg331DyPtZfQu
        6PimCxfbx8G7DxslIo6HbRMNWHg3SP9MwSPjDYSYYDusrHeRIo6GT3pbpSJWwvHDh5bwfni+
        z0+K5goAW7tuLplTYVfzl5LwQhidCL+9kiLSa+HlhVNAHLwSTs5WEWEJpOWw4pBClKyDtx6M
        SkS8Cp4pt5FHAONYFsexLIJjWQTH/8OaAO4Cr/MmQV/IC2pT2vLH9oLI90lC7aBjINsHaAow
        r8rpqNE8BcHtFvbqfQBSGBMj39hzL08h13J79/FmY77ZquMFH9CEjl2DKWMLjKHPaLDkqzWb
        U1NTUZo6XaNWM3Fy6tlgnoIu5Cx8Cc+bePNLn4SSKUvB+9V/uLI+eDBw+lLD/KqD0dlal3+f
        pqxZZt5vsxVVIfPqY7vclqNumWas5v788CfHcq8eqFC62te5Y6kdc3O5H0VXLlgmXOVZw/jJ
        PQQxWc89ffNAXfrOT0/3z9VWZ5yb/nfLhepHi6rhKFQ1c/Qf24ZXmN66DfEbd2LR1cfjE8fr
        GFwo4tRJmFng/gN1YZmyVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURiAObt3d3fS2HWaHpWUVmEZlYN+nKDsC+H0p4wgyjAbenGSm7Lr
        R1aQBhYuy4qWuUqt1JYNcfM7v3BTKc2PzZzimhGak1JLTAhTS7cC/z2c93ne8+elCUklP5BO
        VKWyapU8SUp5kXUWacguUbUzJnyxRYbMXbUCtNDTDVC5rROgn9o3BBr/5ACovjAOFXf08ZGx
        2kGighYThSq0jSTq768SoN7r0wKkd87xkWnczkdzeWN8pFl8RaD52x0AlQ1beciuv8dH81Xj
        AFm7I5EjW0+h133tFHrfY+OjnJYOAdKYlym0YjeSaKrGH5W9sBPIuIAPBWOtRg+wocgA8PeR
        HAF+nGUlcYkpDZsqcin80d5M4erSa9g428DD7bPNPJy/HI4XLRtxzdBNEt+pqQB43hQcJY72
        2h/PJiWms+o9ERe8FE8HHhEpK0GXTDMlIAu4fDVASENmL3QU20gN8KIlTBOAzvwVwjMIgA+t
        natMr7IPtFg4jzMDoL1PA9YcH+YM1De1kmvsy2yFVa5RYk0imCEh7B5oEHiKMR4caHC5LYoJ
        g21TI9Qai5nNcOjXuHuTiImA2sly9zvJbIP1t0rcvHH1B1f9yD/HG74rnHDvETInoa6yzc0E
        EwqXimyEh/3h6EQxz8MhsH7mCXEX+OjW5bp1iW5doluXlACyAgSwKZwyQcnJUmQqNmM3J1dy
        aaqE3XHJShNwX1HYjgYwWBprBgwNpBtECm9njIQvT+cylWYAaULqK9pp+RgjEcXLMy+z6uRY
        dVoSy5lBEE1K/UVfVF1nJUyCPJW9yLIprPr/lEcLA7MAd7WTDI1s7JV9cICj943nlOalxIzP
        iUcOlEY3FxpP1f5YyN0k3tJrKxrOzhWnCyeXe51f68q2PxCEVH7bp/pjKLihtCWFB58/+HYw
        3nxl2i8w7/fxuuXDNt+QrkGtXEHH6LMUL6ljUddaThjqrM+gad4w5ieO7FFhV6s04vlpKckp
        5LIwQs3J/wKp7t2aQQMAAA==
X-CMS-MailID: 20191126231942epcas1p2017370a78a1fbab9bd1b6dc00b60d4ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191122214539epcas1p34d4ca24634642e8a79c33d7a7c9291ba
References: <cover.1574458460.git.leonard.crestez@nxp.com>
        <CGME20191122214539epcas1p34d4ca24634642e8a79c33d7a7c9291ba@epcas1p3.samsung.com>
        <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
        <f8838bc8-44db-551f-3199-eeea91e493f7@samsung.com>
        <CAL_JsqJmZUVmM9BqQuD1npJ7Nqsh07CSEA5nB9-pt0v_X6HQCA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/27/19 4:44 AM, Rob Herring wrote:
> On Sun, Nov 24, 2019 at 4:53 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> Hi Leonard,
>>
>> On 11/23/19 6:45 AM, Leonard Crestez wrote:
>>> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
>>> frequency switching is implemented inside TF-A, this driver wraps the
>>> SMC calls and synchronizes the clk tree.
>>>
>>> The DRAM clocks on imx8m have the following structure (abridged):
>>>
>>>  +----------+       |\            +------+
>>>  | dram_pll |-------|M| dram_core |      |
>>>  +----------+       |U|---------->| D    |
>>>                  /--|X|           |  D   |
>>>    dram_alt_root |  |/            |   R  |
>>>                  |                |    C |
>>>             +---------+           |      |
>>>             |FIX DIV/4|           |      |
>>>             +---------+           |      |
>>>   composite:     |                |      |
>>>  +----------+    |                |      |
>>>  | dram_alt |----/                |      |
>>>  +----------+                     |      |
>>>  | dram_apb |-------------------->|      |
>>>  +----------+                     +------+
>>>
>>> The dram_pll is used for higher rates and dram_alt is used for lower
>>> rates. The dram_alt and dram_apb clocks are "imx composite" and their
>>> parent can also be modified.
>>>
>>> This driver will prepare/enable the new parents ahead of switching (so
>>> that the expected roots are enabled) and afterwards it will call
>>> clk_set_parent to ensure the parents in clock framework are up-to-date.
>>>
>>> The driver relies on dram_pll dram_alt and dram_apb being marked with
>>> CLK_GET_RATE_NOCACHE for rate updates.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/devfreq/Kconfig      |   9 +
>>>  drivers/devfreq/Makefile     |   1 +
>>>  drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++
>>>  3 files changed, 475 insertions(+)
>>>  create mode 100644 drivers/devfreq/imx8m-ddrc.c
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 59027d7ddf2a..5eac479dd05f 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>         Each memory bus group could contain many memoby bus block. It reads
>>>         PPMU counters of memory controllers by using DEVFREQ-event device
>>>         and adjusts the operating frequencies and voltages with OPP support.
>>>         This does not yet operate with optimal voltages.
>>>
>>> +config ARM_IMX8M_DDRC_DEVFREQ
>>> +     tristate "i.MX8M DDRC DEVFREQ Driver"
>>> +     depends on ARCH_MXC && HAVE_ARM_SMCCC
>>
>> I'll edit it as following and applied it.
> 
> You corrupted the URLs in the binding patch when applying the series:
> 
> Traceback (most recent call last):
>  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py",
> line 774, in resolve_from_url
>  document = self.store[url]
>  File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py",
> line 22, in __getitem__
>  return self.store[self.normalize(uri)]
> KeyError: 'https://protect2.fireeye.com/url?k=b51ff83f-e8cff0d7-b51e7370-000babff32e3-c25c03b8af1b12ee&u=http://devicetree.org/meta-schemas/core.yaml'
> 

I'm sorry the url was changed when I applied them
because of the internal security system..
I fixed and updated it to devfreq next branch.

Thanks,
Chanwoo Choi
