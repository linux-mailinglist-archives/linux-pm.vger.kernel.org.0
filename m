Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F11DE2D2
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgEVJUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 05:20:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42444 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgEVJU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 05:20:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200522092028euoutp01981748cb7ddd2e630f6f213064a1cd1b~RTzQAeqcb1065110651euoutp01i
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200522092028euoutp01981748cb7ddd2e630f6f213064a1cd1b~RTzQAeqcb1065110651euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590139228;
        bh=RCHFAQvkY4VQziV9vdbh4p3TEAezsX+N3nHCYcvhwCk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SdBmYwDDDEh3V1Cbbjr5jL6dCC/S0q843kIg7XNyn5VS6tiaVSwxSnmfuKFPG1sRZ
         W7tjxUA8S5lucBCxj9YlAFTf90YnE+SgUCOdHbrgs+qM7GfVchFg2ICpW03+mM4uoL
         Zhtf3Sf7y135Y/eQyyqkeQZoLPiLeuHnIWaVmAIo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200522092027eucas1p2963c309e550357a7809a2109c92d327e~RTzPbstIw1870318703eucas1p2b;
        Fri, 22 May 2020 09:20:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 55.D7.60698.B5997CE5; Fri, 22
        May 2020 10:20:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200522092027eucas1p2376481cd329b8ddbfeb1b03687ed36d3~RTzPDgNQQ0413204132eucas1p20;
        Fri, 22 May 2020 09:20:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522092027eusmtrp177c6c8ad4ba60fa7ec6948f841a48f56~RTzPC5kfB2127821278eusmtrp17;
        Fri, 22 May 2020 09:20:27 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-aa-5ec7995be0e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.08.08375.B5997CE5; Fri, 22
        May 2020 10:20:27 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522092026eusmtip2d63c06f0c0d54658139682b52ab85818~RTzOgvWKT2880328803eusmtip2U;
        Fri, 22 May 2020 09:20:26 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] extcon: max14577: Add proper dt-compatible
 strings
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Message-ID: <e3c55c02-4d9f-f19c-2cd8-42f6a85f348d@samsung.com>
Date:   Fri, 22 May 2020 11:20:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a1f499fa-1907-93f5-6f57-13187ae10d7e@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87rRM4/HGTy7LWexccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0eJ24wo2i9O7Sxw4PDat6mTz6NuyitHj8ya5AOYoLpuU
        1JzMstQifbsErow5a1QKVghW/Hrxgb2BcT9fFyMnh4SAicSbQ11sILaQwApGie/9+hD2F0aJ
        jn72LkYuIPszo8TTrfvZYRo+rpnBCpFYziixdsE8ZgjnPaPEqWsfmUGqhAUCJDqefGACsdkE
        DCW63kKsEBFIkpi9YysTSAOzwEVGiWe9E8ESvAJ2Ege+rWEFsVkEVCV2rmkFi4sKxEqcXryZ
        EaJGUOLkzCcsIDangL3E1seXweqZBeQlmrfOZoawxSVuPZkPtkBCYBW7xJwLp6HudpHY/2Er
        I4QtLPHq+BaouIzE6ck9LBANzYwSD8+tZYdwehglLjfNgOqwlrhz7hfQSRxAKzQl1u/Shwg7
        Smz9s4sJJCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQvLaLCTv
        zELyziyEvQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEpp3T/45/3cG470/SIUYB
        DkYlHl6LtGNxQqyJZcWVuYcYJTiYlUR4F/IfjRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zo
        ZayQQHpiSWp2ampBahFMlomDU6qBMUKoI4+hw1g4THHKDofbV5dqiRYrJl1K9WKa1PFS9rH/
        oRWb7upcWthsUSRRVpax2ktrb98ktyWVL3fXP5DfeV/99x7++VPmF6u/P81h9GRz3hS+adEn
        9DQi34jGTNS5eyf+mfhiJp8VE9jLt8o5zD3c84F9QtLy5E9lymdTb6l3m3Wvnn0sTYmlOCPR
        UIu5qDgRAMtbYzs3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7rRM4/HGdz5yGyxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0eJ24wo2i9O7Sxw4PDat6mTz6NuyitHj8ya5AOYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYw5a1QKVghW
        /Hrxgb2BcT9fFyMnh4SAicTHNTNYuxi5OIQEljJKLG/tZIJIyEicnNbACmELS/y51sUGUfSW
        UWLu7xcsIAlhAT+JPzsOs4HYbAKGEl1vu8BsEYEkiR1TmphBGpgFLjNKbL3ZwwjRvZ5J4tbn
        RrCxvAJ2Ege+rQGzWQRUJXauaQXrFhWIlVh9rZURokZQ4uTMJ2DbOAXsJbY+vgxWzyxgJjFv
        80NmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjLVtx35u3sF4aWPwIUYBDkYlHt4HycfihFgTy4orcw8xSnAwK4nwLuQ/GifE
        m5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cA0kFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgTH7V+VltYuF+1Yf5bJ/9snJgPNsvPiFaUsnRpkcVk/S/WY/V7Un
        P9rxrswHE79P8+ef+ZkldZlXTHueC++BjRYet5fzLpJXLbPaJ3Wa8/r8mObzXZOXPo7QM+Ho
        C0o94LRs1n2Zt5e4lG5Pjp7jmqzdtY/vENPrDduqeT7L9c2PkspfE5d9dJsSS3FGoqEWc1Fx
        IgB04N8fywIAAA==
X-CMS-MailID: 20200522092027eucas1p2376481cd329b8ddbfeb1b03687ed36d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
References: <20200522064801.16822-1-m.szyprowski@samsung.com>
        <CGME20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8@eucas1p2.samsung.com>
        <20200522064801.16822-2-m.szyprowski@samsung.com>
        <8ec0c604-8cdc-04f8-fc5c-fd967f52022b@samsung.com>
        <a1f499fa-1907-93f5-6f57-13187ae10d7e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

On 22.05.2020 10:30, Marek Szyprowski wrote:
> Hi Chanwoo,
>
> On 22.05.2020 09:08, Chanwoo Choi wrote:
>> On 5/22/20 3:48 PM, Marek Szyprowski wrote:
>>> Add device tree compatible strings and create proper modalias 
>>> structures
>>> to let this driver load automatically if compiled as module, because
>>> max14577 MFD driver creates MFD cells with such compatible strings.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>> v2:
>>> - added .of_match_table pointer
>>> ---
>>>   drivers/extcon/extcon-max14577.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/extcon/extcon-max14577.c 
>>> b/drivers/extcon/extcon-max14577.c
>>> index 32f663436e6e..03af678ddeba 100644
>>> --- a/drivers/extcon/extcon-max14577.c
>>> +++ b/drivers/extcon/extcon-max14577.c
>>> @@ -782,9 +782,19 @@ static const struct platform_device_id 
>>> max14577_muic_id[] = {
>>>   };
>>>   MODULE_DEVICE_TABLE(platform, max14577_muic_id);
>>>   +static const struct of_device_id of_max14577_muic_dt_match[] = {
>>> +    { .compatible = "maxim,max77836-muic",
>>> +      .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
>>> +    { .compatible = "maxim,max14577-muic",
>>> +      .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
>>> +    { },
>> How about changing the order between max77836 and max14577 as already 
>> added structure
>> like platform_device_id if there are no specific reason as following:?
>>
>>
>> static const struct of_device_id of_max14577_muic_dt_match[] = {
>>     { .compatible = "maxim,max14577-muic",
>>       .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
>>     { .compatible = "maxim,max77836-muic",
>>       .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
>>     { },
>
> Sure. I will swap them and send updated patch. This order comes from 
> drivers/power/supply/max14577_charger.c, which also lacks 
> .of_match_table, so I will also fix it.
It looks that I've checked a wrong tree. I will send v3 with 
of_match_table sorted. I have no idea why the order is reversed.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

