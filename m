Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5531019DE8
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEJNM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 09:12:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44262 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfEJNM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 09:12:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190510131256euoutp0211c635a644186872ebfbf1cd961a7ec6~dVIUHagxr1349213492euoutp02j
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 13:12:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190510131256euoutp0211c635a644186872ebfbf1cd961a7ec6~dVIUHagxr1349213492euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557493976;
        bh=j5HYaAoYE8H3ysc4iIL7WLxLaS/SspmuDmBrz/8NW1o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OIZo/VXwF121fsfuAWfDygFwj/mr9SkTn30FQH+oYy/sPESqQ3g5z/zCulxeIRPBQ
         EuB03HmxYY/hYFR8KRSApF+H86l1ysmk01cwNeUbl0xkp1ot5rb7uahloYgObjrR45
         c3UO7YimfqbCsf1RsAVk3EF9JtYTnWSLHZGUS16Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190510131255eucas1p1b1e2d76f60bc4dbde6a9b6f495e37cfe~dVITWlwPZ3127531275eucas1p1m;
        Fri, 10 May 2019 13:12:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 94.8B.04377.7D875DC5; Fri, 10
        May 2019 14:12:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190510131254eucas1p1fcf8dbeffa10d59a44108c3820efb01a~dVISjTEZP0116601166eucas1p1j;
        Fri, 10 May 2019 13:12:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190510131254eusmtrp113c2899e2188b15d97970140148781ed~dVISVEKyk1895118951eusmtrp1H;
        Fri, 10 May 2019 13:12:54 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-0b-5cd578d74831
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.47.04140.6D875DC5; Fri, 10
        May 2019 14:12:54 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190510131253eusmtip25866cbb1e621a84176e0e205134e59ea~dVIReyyHG3162231622eusmtip2v;
        Fri, 10 May 2019 13:12:53 +0000 (GMT)
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <c9b4759e-e15b-9c5d-63d0-9db06a4c361a@partner.samsung.com>
Date:   Fri, 10 May 2019 15:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJSbi5jNZSRhiE-h74DdbsgM7O+tqP9HOf037pyN7TbFA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMURzHO3vv3XtrbE4b+k0axmK88xyd8X5bjfEYj/FosHT10G7ZK0rN
        WPQSiRCt3oyaPKJCmoZRS/TYakiNrBpbI7QNSoY8r1uj/z7n/L7f8/t+Zw5HKTsYV85Pt4/X
        6zQBKrkDfefxN/Ok+pA6rymZDc7k1oVchtR3vWVImsnMkKufrIicKU+RkcrjWhJv/UCR6uqb
        LKk60s6SZ0XJctIZZ0LkQvV9GblusrCk8XC2nPwuLmRJaXs0Qx489ySNPY6k+8kbtMBZ3f0l
        gVZfNNTS6ntGC6vOyzkmV8cd7ZCrTxbkIHV+RZi6M2/YGm6LwxxvPsBvP6+fPG+Hg68lNQYF
        vRgYcv/sJdaAigbEInsO8Ax4WPlULrISZyP4aZoaixz+cheCms9mJB06ESS3NFN9jk9Neaw0
        yEJgaYxEkt2GwPxxvsjOeDeUXH7JijwIj4CeqERGNFA4Uw6thnxZLOI4OXaHwpy9okaBl8EV
        q40Rmcaj4bXFJBN5MN4ETY9vMpLGCZ4mtdAi2+O18DUh9Z+Gwi7wsiWtl4fDXVsyJe4CnMHB
        6fpTjJR6CbwuvNTbwBnelxWwErtBxZkTtMQCGOIykMThYI1P6dXMhtKyWkbMTOFxkFs0WUTA
        CyHXvF5CR2iwOUkJHCHhznlKulZATJRSemMsFJyokUk8BLKuJbKnkMrYr5exXxdjvy7G/2vT
        EZ2DXPhgQevDC9N0/AF3QaMVgnU+7rsCtXno7y+s+FXWVYiKfuwsQZhDqgEKvKvOS8lo9guh
        2hIEHKUapNBPfO6lVHhrQg/y+sDt+uAAXihBQzla5aIIs2veqsQ+mn38Hp4P4vV9Uxln72pA
        o7q/Ky+Hq26Xr5ob066aELkzfSlvazD6D1y3yKP4qktbboTv8oji2ujW2c0b7HxnbZqVHZm6
        +NXIpStqNmy78dHjblNAfkOHdXVQ2O7UIc18nVv4ykeHNg+98uhQe1LPBNe2tvdupZrppoet
        Vefi/D5kPjif5DRzTLR//ned1XPYxndZ3ipa8NVMHU/pBc0fTHEJ74EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4Pd1rFVdjDM5Ml7XYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i/97drBbHH7Tzmqx/4qXxe3ffBbfTjxidBD2+PZ1EovH7IaLLB47Z91l99i0
        qpPNo7f5HZtH35ZVjB6bT1d7fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJdxd14HY8E1/op9UxazNzDu4uli5OSQEDCR+Hh/E3sXIxeH
        kMBSRomfSzexQCTEJCbt284OYQtL/LnWxQZR9JpRonHZe0aQhLBAmsSNJVPZQGwRAUWJ323T
        WEFsZoFlbBJzb+eA2EICp5klLk3x7WLk4GAT0JPYsaoQJMwr4Cax7PFbsHIWAVWJe3ePMIHY
        ogIREmfer2CBqBGUODnzCZjNKRAo8X3SPCaI8WYS8zY/ZIawxSVuPZkPFZeX2P52DvMERqFZ
        SNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQITwLZjP7fsYOx6F3yI
        UYCDUYmHVyD5aowQa2JZcWXuIUYJDmYlEd4inSsxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwl
        mpwPTE55JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY1XR1Fh10
        fHj2UJeTJet79sInxZPk/XXWfZRn0bFZ8H/yBacP33j8eTevjQp4fKjl7nXvD0sOvxe4f/f6
        U75zAp/mpV2+bRRblGHw0qn9jrPE0mshm0/b3At5JrZ+2S73czP63L0i/m/tfasZtFAt9uLb
        ZzUPDzelq0pv/nP+oOyTeefuPZvj7KTEUpyRaKjFXFScCAAe9Pq2FgMAAA==
X-CMS-MailID: 20190510131254eucas1p1fcf8dbeffa10d59a44108c3820efb01a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
        <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
        <20190507170422.GA25179@bogus>
        <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
        <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
        <CAL_JsqJSbi5jNZSRhiE-h74DdbsgM7O+tqP9HOf037pyN7TbFA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 5/8/19 10:35 PM, Rob Herring wrote:
> On Wed, May 8, 2019 at 4:45 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>> On 5/8/19 9:19 AM, Krzysztof Kozlowski wrote:
>>> On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
>>>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>>>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
>>>>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
>>>>
>>>> Looks like a hack. Can't you get this from the clocks property? What is
>>>> this for?
>>>
>>> Hi Rob,
>>>
>>> Lukasz uses these two syscon regmaps to read certain registers. For
>>> chipid he reads it to check the size of attached memory (only 2 GB
>>> version is supported). This indeed looks like a hack. However the
>>> second regmap (clk) is needed to get the timing data from registers
>>> from DMC clock driver address space. These are registers with memory
>>> timing so their data is not exposed anyway in common clk framework.
> 
> Okay, please just explain what your accessing. Consider adding the
> offset as a cell in case stuff moves around on another chip.
Good point. I will also have to regmap the registers and not take from
'clock' device.
> 
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Thank you Krzysztof for a fast response. I have also responded to Rob.
>> I wouldn't call accessing chipid registers as a hack, though. The DMC
>> registers do not contain information about the memory chip since it is
>> in phase of production the board not the chip. Thus, chipid regs (which
>> loads from e-fuses) are best place to put information about memory
>> type/size.
> 
> For efuses, we have a binding (nvmem). Maybe you should use it.
I don't know about the design of a planned 'chipid' driver, which going
to be sent to LKML in near future. Thank you for this information,
I will talk with Bartek.

Regards,
Lukasz
> 
> Rob
> 
> 
