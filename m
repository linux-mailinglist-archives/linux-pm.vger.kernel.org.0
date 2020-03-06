Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7724417BF8F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFNv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 08:51:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37139 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFNv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 08:51:26 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200306135124euoutp01e58b6b00b99c3648cdbfbcdfaacc17ba~5u01NT2W21464714647euoutp01q
        for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2020 13:51:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200306135124euoutp01e58b6b00b99c3648cdbfbcdfaacc17ba~5u01NT2W21464714647euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583502684;
        bh=nrqom+K6Q0KUKXgUtsNrPT2r6G0nWyy+0+y3HChij9k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WXgjHR4cwUTpJ7UIniDKb2STsQ+j16yAmYsWjEwbo4dBKA1r/70jSO9y678HvwkH/
         RJqan0eBRin+ty8jBqD215x/K6MjsfPQrXUrZqi2kV5TVDN7yEOmjtmI5kbR3e8WFk
         OJMo33NEPQUo+iZwX3IZopMoel2PO6oiIZhFUA/Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200306135124eucas1p189d876fbe5cb51e20ed284e54a58d601~5u007ZzC22344623446eucas1p16;
        Fri,  6 Mar 2020 13:51:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.F5.61286.C55526E5; Fri,  6
        Mar 2020 13:51:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200306135124eucas1p13d4cf3a4097a64faf2f812853ff180cb~5u00meDRd2344123441eucas1p1D;
        Fri,  6 Mar 2020 13:51:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200306135124eusmtrp20a70703e847e5f10382afb96ba8d7bb0~5u00lzp3M1277512775eusmtrp2a;
        Fri,  6 Mar 2020 13:51:24 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-21-5e62555c9351
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.B4.07950.B55526E5; Fri,  6
        Mar 2020 13:51:23 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200306135123eusmtip18184cf5d15c931d835e967d2daa894a5~5u00GsqFL1674616746eusmtip1E;
        Fri,  6 Mar 2020 13:51:23 +0000 (GMT)
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible
 strings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <791edb65-4471-3e54-6806-4af2876fea19@samsung.com>
Date:   Fri, 6 Mar 2020 14:51:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224201256.GA8060@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87oxoUlxBtfmiVpsnLGe1WLqwyds
        Fte/PGe1OH9+A7vF5V1z2Cw+9x5htLjduILNonXvEXaL07tLHDg9Nq3qZPPo27KK0ePzJrkA
        5igum5TUnMyy1CJ9uwSujFO/r7IVnBKrOPJ5HlMD4yKhLkZODgkBE4lV00+ydTFycQgJrGCU
        mLd5JStIQkjgC6PEtqucEInPjBKfdh1hh+m486GFCaJoOaPEw8dCEEVvGSUmLH7KApIQFgiQ
        WHDtFiOILSKgKXH973dWkCJmgXVMEr/6J4EVsQkYSnS97WIDsXkF7CR2zV8P1sAioCKx58FE
        sG2iArESs1ceZoGoEZQ4OfMJmM0poCexu20CM4jNLCAvsf3tHChbXOLWk/lMIMskBLaxS7T2
        /mCDONtFonfRQhYIW1ji1fEtUO/ISPzfCdPQDPTOubXsEE4Po8TlphmMEFXWEnfO/QKaxAG0
        QlNi/S59iLCjxIUp55hAwhICfBI33gpCHMEnMWnbdGaIMK9ERxs0rNUkZh1fB7f24IVLzBMY
        lWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQJT0Ol/xz/t
        YPx6KekQowAHoxIP7wzbpDgh1sSy4srcQ4wSHMxKIrzCpvFxQrwpiZVVqUX58UWlOanFhxil
        OViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTDWVxaV/+iuaNpr2XnwuPQZhyC7+DgPdcZJ
        XzW6qu0Uuz6ccT7kssTDJo77pKmDyYSQH2alDzeeMLxvP7me+/T155Nqb+3ffu1JAHcFU1lD
        0eZpOavP3taadNFG/dkENreova2fS8p/dhrduBacukwn+Ujkbwuent4/E459vPpJdXbKr85V
        e2YosRRnJBpqMRcVJwIAOFRnOz0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7rRoUlxBntaLS02zljPajH14RM2
        i+tfnrNanD+/gd3i8q45bBafe48wWtxuXMFm0br3CLvF6d0lDpwem1Z1snn0bVnF6PF5k1wA
        c5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqnf
        V9kKTolVHPk8j6mBcZFQFyMnh4SAicSdDy1MXYxcHEICSxklph/tZYNIyEicnNbACmELS/y5
        1sUGUfSaUeLDwj3sXYwcHMICfhJrZxmA1IgIaEpc//udFaSGWWADk8SO3xfZIRrOMEsc/bcM
        bBKbgKFE19susA28AnYSu+avZwSxWQRUJPY8mMgOYosKxErcmNnBBFEjKHFy5hMWEJtTQE9i
        d9sEZhCbWcBMYt7mh1C2vMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4
        Nz232EivODG3uDQvXS85P3cTIzDqth37uWUHY9e74EOMAhyMSjy8M2yT4oRYE8uKK3MPMUpw
        MCuJ8AqbxscJ8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wIeSVxBuaGppbWBqaG5sbm1ko
        ifN2CByMERJITyxJzU5NLUgtgulj4uCUamBssv1+Z926VU3912S2VsZZ9k77u7pGYfnroBV1
        z1euuLencuPy9YLfJRVrF2w44DLnXuKlt1KveF4z2/jF/TFNu/bvzeWr/llPO7qV5r2dXvxs
        EWetLv8B3ukXIstEn2x95/U18vclLdOLz5ZwF/RukYrdteXGnxsCHxdo54tVyDy90bfvTIZu
        rRJLcUaioRZzUXEiAI8DRVjQAgAA
X-CMS-MailID: 20200306135124eucas1p13d4cf3a4097a64faf2f812853ff180cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
        <20200220145127.21273-1-m.szyprowski@samsung.com>
        <20200220165614.GD3926@sirena.org.uk>
        <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
        <20200221123813.GB5546@sirena.org.uk>
        <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
        <20200221171342.GI5546@sirena.org.uk>
        <61dc8192-e313-021f-9e23-928257a66984@samsung.com>
        <20200224201256.GA8060@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 24.02.2020 21:12, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2020 at 03:08:05PM +0100, Marek Szyprowski wrote:
>> On 21.02.2020 18:13, Mark Brown wrote:
>>> On Fri, Feb 21, 2020 at 02:23:57PM +0100, Marek Szyprowski wrote:
>>>> On 21.02.2020 13:38, Mark Brown wrote:
>>>>> We could just remove the compatible strings from the binding
>>>>> documentation, they won't do any harm if we don't use them.
>>>> Frankly I have no strong opinion on this. I've just wanted to fix the
>>>> broken autoloading of the drivers compiled as modules.
>>> Shouldn't adding the relevant module table for the platform devices work
>>> just as well for that?  Possibly also deleting the of_compatible bits in
>>> the MFD as well, ISTR that's needed to make the platform device work.
>> Right. This will work too. MFD cells will match to their drivers by the
>> name and modalias strings will be correct. The question is which
>> approach is preffered? Krzysztof? I've checked other mfd drivers, but I
>> cannot find any pattern in this area.
> I would guess that adding MODULE_DEVICE_TABLE() for OF-matches in main
> MFD driver would fix the issue... otherwise the same problem we have
> with max77693 (also MUIC/extcon/regulator/charger).

Indeed, there is a same problem with max77963:

max77963-muic driver lacks compatible and has wrong platform modalias 
("extcon-max77963"),

max77963-charger driver lacks compatible,

max77963-haptic driver lacks compatible.

> Some of these drivers (I guess only charger) bind to a OF node so they
> need a compatible. I think we added this to regulators and extcon for
> symmetry.
> Without this binding, the charger would need to read a specific child
> node from parent. This make them tightly coupled. It seems to me more
> robust for each component to bind to his own node, when needed.

Extcon would also need its node when support for it will be added to 
dwc2 driver. Having compatible strings in the nodes simplifies matching 
and makes it almost automatic.

> Another reason of adding compatibles was an idea of reusability of
> MFD children (between different MFD drivers or even standalone) but it
> never got implemented (children still depend on parent significantly).

So far, there is no such case.

> In general, I like the approach of children with compatibles but I will
> not argue against changing the drivers. They could really use some
> cleanup :)
> Long time I tried to remove the support for platform_data [1] - maybe
> let's continue?
>
> [1] https://lore.kernel.org/lkml/20170217200200.4521-1-krzk@kernel.org/

Cleanup of the driver is another story, completely independent of fixing 
this issue imho.

krzk: could you then specify if you are against or after the proposed 
changes?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

