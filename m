Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5D17A1B
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEHNNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 09:13:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60904 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfEHNNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 09:13:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190508131305euoutp0210fc1c2ee4b1af3dd048abba10371e3f~ct137VvsT3233832338euoutp02g
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 13:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190508131305euoutp0210fc1c2ee4b1af3dd048abba10371e3f~ct137VvsT3233832338euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557321185;
        bh=eXhCUDgM0oIHnRivX2ZhfLzQLHq/huckSvDHj9jbwrY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NQNam05B7uPudHnTdG5BxMpqH5SkCKOLcazEjlvqq0r3z8WZxBlt4g0QvcKWjeuO4
         EbuIVTROArxPAR7E1mvf/WFA6dpvZzP8UhXFVoXAODMcZsCoM1nMe+cY3mtTWTozUU
         qYOtuVBlkq4/+yIEC5rdKVwJ7g7CU8MTNS+ztZOA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190508131304eucas1p1c5466948d6a2dad412a52db9e4ef6d6c~ct13DMXrs2066020660eucas1p1O;
        Wed,  8 May 2019 13:13:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 87.25.04298.0E5D2DC5; Wed,  8
        May 2019 14:13:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190508131303eucas1p15db96735e01d8bd535861b91aa7298b8~ct12NBAx-0289202892eucas1p1R;
        Wed,  8 May 2019 13:13:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190508131303eusmtrp24dd788c179063640d11b24074a8c30ad~ct11_14KZ0688306883eusmtrp2K;
        Wed,  8 May 2019 13:13:03 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-85-5cd2d5e065ed
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.C0.04140.FD5D2DC5; Wed,  8
        May 2019 14:13:03 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190508131302eusmtip2160fd4fca1c240b849c598e039e50fbd~ct11KeAkx0788807888eusmtip2z;
        Wed,  8 May 2019 13:13:02 +0000 (GMT)
Subject: Re: [PATCH v7 11/13] ARM: dts: exynos: add syscon to clock
 compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f60314f9-61bc-a9e1-7ddd-f068c241e860@partner.samsung.com>
Date:   Wed, 8 May 2019 15:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPf3tZGp-UQagGKNs0xFBGz2NwBdA2R=Y25C5jTK_ZcMXg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURjFuzszO+PibuNq+WVStBVUlCYEXirCoGQoCIMCM6O2nDR1zHZ8
        m7RWWq2ZpVS6alZQmibqJmoWBj7zlWmJoliigpFamo8o0XKcjfzv3PP9Lt85l8sQ2q+UE3Mu
        JIw3hOiDdUoVWVb/q21bf2eH73ZLmQaXpBdRuGtqmMI5te8oXDAxiHBaU7YCtyQJOGVwhMBt
        bcU0br08SuMPlVlKPJlci3B6W5UCF9b20bg3Pk+Ja0avUfjNxwO4d1aDZ94OIA8tNzOdSnKZ
        xnaSe2nuozlL/g0ll3zlm5K7VZqPuBfNsdykZY0X46Pa7ccHn4vgDa57TqkC7iYkk6HjK6Ky
        ujMJI5pnTYhhgN0BuaZDJmTDaNk8BPXl+0xItaCnEDzOalHIh0kED2qGFRIlXSice0XIg1wE
        VR1JVmoMwUDBtUXKnvWC8t9ppKQd2M3QNfeTkiCCLSGhvKKSlnYrWReoyL8gMWrWE8bSTIs8
        yW6A7JIiWtIrWG/4XF9MyYwdNGYMLTI27GG48m1cKWmCdYSeoRyFrNdC+VjWYjpgMxiYzUtA
        cux9MPFpzqrt4WtDKS1rZ/jzMsdaTQRj8iMrcxEGU7KtzC6oaWinpMzEQpmiSlfZ3guvc4sp
        +Rk10D1mJ0fQQGrZfUK21XA9USvTm6D05nvropWQ+/wefRvpzEuKmZeUMS8pY/6/9yEi85Ej
        Hy4K/rzoFsJHuoh6QQwP8Xc5c16woIUf2Dzf8KMCTXecrkYsg3S26oDqDl8tpY8Qo4VqBAyh
        c1B33Vmw1H766BjecP6kITyYF6vRaobUOapjl/Uf17L++jA+iOdDecO/qYKxcTIijd8TLlqY
        D/L1znzscWTYFlLNV50SY7SJG9LfC6FB7qODnhvPCpeSwm+3Buytuzo0crTEUXPQeaST/KBa
        f9k93rndZ2Kmafn17zF469qnRQNDqjOBPTfvx8Q1r1vlGmmMsnuWJLR4Irqx8YCDJfBE3fjU
        /sMpx77E3Wj32umqetOjI8UAvdsWwiDq/wJGjqJpfQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd37Vy/FGNz8LWCxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlTG3tZSn4IFox58Zs5gbGfwJdjJwcEgImEmv/7mbuYuTiEBJYyihx
        7sRrJoiEmMSkfdvZIWxhiT/Xutggil4zSmw7uAOsSFjAT+LU7M2sILaIgKbE9b/fWUGKmAU2
        skhcfNXLBNGxmlli9fPvQKM4ONgE9CR2rCoEaeAVcJN4O7mLBcRmEVCRmLtxPdg2UYEIiTPv
        V7BA1AhKnJz5BMzmFAiUaH73gQ3EZhYwk5i3+SEzhC0ucevJfCYIW15i+9s5zBMYhWYhaZ+F
        pGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIz9bcd+btnB2PUu+BCjAAej
        Eg9vxqFLMUKsiWXFlbmHGCU4mJVEeK9PBArxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAt
        5ZXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYOwqX7rz1hmnMxe/
        W81/lpnv7ZrrWl05WX9X10HuPi0lg733Dy8RTv33ce1X5X015W81Z/yffuf+n+vc+b9/M5/b
        lLCqjLP5WcgFnl67ORPf3I7WS5/4vca9Is9TwXHq3AO7J5xUOZJiUyfK+aWF6Y/H10Tnx9ou
        Z3Vq92eFKzmmd95meG3zuUCJpTgj0VCLuag4EQCliK9xEwMAAA==
X-CMS-MailID: 20190508131303eucas1p15db96735e01d8bd535861b91aa7298b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
References: <CGME20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2@eucas1p2.samsung.com>
        <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
        <8d02ef2c-c5dd-6a72-9638-d858df3ea16d@partner.samsung.com>
        <CAJKOXPf3tZGp-UQagGKNs0xFBGz2NwBdA2R=Y25C5jTK_ZcMXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/8/19 12:17 PM, Krzysztof Kozlowski wrote:
> On Wed, 8 May 2019 at 11:50, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>> On 5/8/19 9:22 AM, Krzysztof Kozlowski wrote:
>>> On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>
>>>> In order get the clock by phandle and use it with regmap it needs to be
>>>> compatible with syscon. The DMC driver uses two registers from clock
>>>> register set and needs the regmap of them.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    arch/arm/boot/dts/exynos5800.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
>>>> index 57d3b31..0a2b328 100644
>>>> --- a/arch/arm/boot/dts/exynos5800.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5800.dtsi
>>>> @@ -17,7 +17,7 @@
>>>>    };
>>>>
>>>>    &clock {
>>>> -       compatible = "samsung,exynos5800-clock";
>>>> +       compatible = "samsung,exynos5800-clock", "syscon";
>>>
>>> What about Exynos5420 DTSI?
>> OK, I will also add it to 5420 dtsi.
>> --------------------------8<------------------------------------------
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>> b/arch/arm/boot/dts/exynos5420.dtsi
>> index aaff158..d9203f0 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -173,7 +173,7 @@
>>                   };
>>
>>                   clock: clock-controller@10010000 {
>> -                       compatible = "samsung,exynos5420-clock";
>> +                       compatible = "samsung,exynos5420-clock", "syscon";
>>                           reg = <0x10010000 0x30000>;
>>                           #clock-cells = <1>;
>>                   };
>> diff --git a/arch/arm/boot/dts/exynos5800.dtsi
>> b/arch/arm/boot/dts/exynos5800.dtsi
>> index 57d3b31..0a2b328 100644
>> --- a/arch/arm/boot/dts/exynos5800.dtsi
>> +++ b/arch/arm/boot/dts/exynos5800.dtsi
>> @@ -17,7 +17,7 @@
>>    };
>>
>>    &clock {
>> -       compatible = "samsung,exynos5800-clock";
>> +       compatible = "samsung,exynos5800-clock", "syscon";
>>    };
>> ----------------------------->8-----------------------------------
>>
>> Can I add your ack after that?
> 
> No need for ack. The DTS have to go through arm-soc so I will pick it
> up when dependencies get in and bindings are accepted (acked or
> applied). We have now merge window so I guess this will go to v5.4-rc1
> at earliest.
> 
> If you want to speed up things in future, be sure that dependencies
> (headers) are applied as early as possible.
Thank you Krzysztof for the explanation, good to know that.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
