Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34217561
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEHJpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 05:45:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47612 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfEHJpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 05:45:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190508094520euoutp0229c6b9ee3832640c3a8920cabd344a23~crAe3iIoy1745517455euoutp02M
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 09:45:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190508094520euoutp0229c6b9ee3832640c3a8920cabd344a23~crAe3iIoy1745517455euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557308720;
        bh=MuOs/E311PhekgRKOAjqsoOM7+A3YKyosF5AEe5N4s4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=g+oJJAlRKq0kzE5WpoGqeUzQLxEWMjMxtwj6p6FTXyH3OlZe1tmQGxq9MULwZamoa
         F1ow9VENuuZ9nNPTkLnAjhLBcObtu44YxCr44Kwv9YA0MQYAVzjb30aNLmmGl7FQkA
         aijO1gJgj+1I57OQgAauzDrK2wtQNUkSrB9DjCZg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508094519eucas1p240af845e3456e87dcdb7fbe8906af8a2~crAd9UfRW1448714487eucas1p23;
        Wed,  8 May 2019 09:45:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.3A.04298.E25A2DC5; Wed,  8
        May 2019 10:45:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190508094518eucas1p29c68c439a387132f9de555f39540851a~crAdKS6S11451814518eucas1p28;
        Wed,  8 May 2019 09:45:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190508094518eusmtrp1b01d2e17125f5bb912ae7518937ef45a~crAc786DA1256112561eusmtrp1c;
        Wed,  8 May 2019 09:45:18 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-1f-5cd2a52e2865
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.99.04146.E25A2DC5; Wed,  8
        May 2019 10:45:18 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190508094517eusmtip247caadf547383ab469f9c86a4ba1487c~crAb-PHi42390423904eusmtip21;
        Wed,  8 May 2019 09:45:17 +0000 (GMT)
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
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
Message-ID: <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
Date:   Wed, 8 May 2019 11:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3eu11H135OzYNJwQh7oTMr+kUPCiMuRVEQFCbU0ptZzmw3
        K7NgPX3k0hIqpzJ7Kqt8LCvTHrBES5dLk0orekyozBWls6LQut5J/vc5v+/3/L7nwGEpTS8T
        yial7BKMKfpkrVJN32z81Rqhu9QeF3XfpCDVZysZ8rz/A0OsDa0MufLNjUhBc4mCOI8bSJ77
        M0VcrioVeXyoV0We1hUrSZ+5AZGzrnsKcq3htYq8PFiuJEN3alXkQW8mQ+53LCcvf/uTgYfv
        0eJAfsB7iuaLTG00f9vyWsXbbdlK3nz4i5I/UWND/PWWDL7PPnE1G6tekCAkJ+0WjLpFm9Rb
        8zqrUWqZeu+zz7NNyMrmID8W8GywejtQDlKzGlyOwHv5j6/oR/DGXugr+hDkmZ8xIy3Oo1+R
        xBpchsBRekA2eRCc6LZRkhCIt4DjYpdK4iDMg7O0k5JMFK6m4VZt3T+BZZU4EmptOyXk8DK4
        O8BJSOPJ4P25TuoMxuvhTWPVcCyHA+BRYTctsR9eA66a78NJFA6Brm6rQuZJcMtTPJwEuISF
        jw/dSJ55KWRlZvo4EHqaalQyh0FLQS4tswgm8zmfZz+480p8nvnwoKmNkWaj8DSorNNJCHgJ
        VLauldEfXngC5An84dTNM5T8zEHWMY38x1SoyX2ikHk8lF09rcpHWsuovSyjdrGM2sXyP7YU
        0TYUIqSJhkRBnJki7IkU9QYxLSUxMn6HwY7+3WDLYNP3WuRt3+xAmEXasdzH1LY4DaPfLaYb
        HAhYShvEPT/ZHqfhEvTp+wTjjo3GtGRBdKAJLK0N4TLGvN2gwYn6XcJ2QUgVjCOqgvULNaGC
        xKhj6STt3q/SnZ1zZkVHvXs/kO83JX6QSY1pjl/o+dbyqvWS81O5VRH+NeL8hKyY3IoM3YGe
        H+nBT5rDPFOyOlZU7InNXekJi7C/G5qRXH8ke968xjXTo/u6LoTvNxTV93C/PeE687h8k9N1
        44U+xjC352KOt2TVZs22xo5Cd3Gvlha36mdOp4yi/i9JJHR/fwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4PV29pZdiDDq3c1hsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxf89O9gtDr9pZ7XYf8XL4vZvPotvJx4xOgh7fPs6icVjdsNFFo+ds+6ye2xa
        1cnm0dv8js2jb8sqRo/Np6s9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mvov7mRsWA5V8W11yYNjPM5uhg5OSQETCTOtL5n7GLk4hAS
        WMooMbnzJhNEQkxi0r7t7BC2sMSfa11sEEWvGSVWrdkHViQskCZxY8lUNhBbRMBD4syCm8wg
        RcwCG1kkLr7qZYLoOM4kceTya9YuRg4ONgE9iR2rCkFMXgE3ib3feEFMFgEVia8/wkHGiApE
        SJx5v4IFxOYVEJQ4OfMJmM0pEChxfssnZhCbWcBMYt7mh1C2uMStJ/OZIGx5ie1v5zBPYBSa
        haR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw/rcd+7l5B+OljcGH
        GAU4GJV4eCfMuhQjxJpYVlyZe4hRgoNZSYT3+kSgEG9KYmVValF+fFFpTmrxIUZToN8mMkuJ
        JucDU1NeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGwfxtO7t/
        f7s73ezXidQaXu/DahOcMqIV1X/bTds2n+Pukv52D11xuZATpzdOum13d1Xg6deLjvZyp+9x
        VUrsdOrZs1qX90Xx0vB/kzSjbnMsfvhZw77ma4cg27SiNeHP3xf+ThI5Mfcjl7RJ4pzDGnsF
        kudzn1/+4N3JFcYH1R+s0zwjXrfujRJLcUaioRZzUXEiAIRUUrEVAwAA
X-CMS-MailID: 20190508094518eucas1p29c68c439a387132f9de555f39540851a
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/8/19 9:19 AM, Krzysztof Kozlowski wrote:
> On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
>>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
>>
>> Looks like a hack. Can't you get this from the clocks property? What is
>> this for?
> 
> Hi Rob,
> 
> Lukasz uses these two syscon regmaps to read certain registers. For
> chipid he reads it to check the size of attached memory (only 2 GB
> version is supported). This indeed looks like a hack. However the
> second regmap (clk) is needed to get the timing data from registers
> from DMC clock driver address space. These are registers with memory
> timing so their data is not exposed anyway in common clk framework.
> 
> Best regards,
> Krzysztof

Thank you Krzysztof for a fast response. I have also responded to Rob.
I wouldn't call accessing chipid registers as a hack, though. The DMC
registers do not contain information about the memory chip since it is
in phase of production the board not the chip. Thus, chipid regs (which
loads from e-fuses) are best place to put information about memory
type/size.

Regards,
Lukasz
