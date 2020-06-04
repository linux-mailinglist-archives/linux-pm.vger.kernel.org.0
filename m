Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5540E1EE54E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 15:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgFDN23 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jun 2020 09:28:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54052 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgFDN22 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2020 09:28:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200604132826euoutp02a930d75568021445686abbd5d75345d1~VWkeROnkL1768417684euoutp025
        for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2020 13:28:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200604132826euoutp02a930d75568021445686abbd5d75345d1~VWkeROnkL1768417684euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591277306;
        bh=rQhEujvdCub17kDRdV7XcRmQnjRGEuw4sAkltLJjWEw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HTk9blknIgpL+VgH1uxuvXmD2ue/AE+3wN1onWhwLukvAUTT89h7+ZO5QXCFgxykv
         ueCAxBUg5XBupZYD3mMITxZ8M5U99O8VdGnH9REfKPEUwfu87Vb/qLDFxJBir+tMZA
         RZQ9+lqGzp1eXlOfVgffi2pTiLhr4TPakdiGYTWQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200604132826eucas1p10ef27317919d02b41863129351f4f23f~VWkd5s9Da1331913319eucas1p14;
        Thu,  4 Jun 2020 13:28:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.06.60698.AF6F8DE5; Thu,  4
        Jun 2020 14:28:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200604132826eucas1p22f1d6e0121994e4579fca30f6b53e03b~VWkdo1G8U0300503005eucas1p2s;
        Thu,  4 Jun 2020 13:28:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200604132826eusmtrp2aa584879f4bccf6009be867d2c23f547~VWkdn9nCt0897308973eusmtrp2C;
        Thu,  4 Jun 2020 13:28:26 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-95-5ed8f6fa8a71
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.75.08375.9F6F8DE5; Thu,  4
        Jun 2020 14:28:26 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200604132825eusmtip203543a6a26b8a72a3973ba67c34eef2a~VWkcy6kGH1944419444eusmtip2L;
        Thu,  4 Jun 2020 13:28:25 +0000 (GMT)
Subject: Re: [PATCH v2] soc: samsung: Add simple voltage coupler for
 Exynos5800
To:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3fffeb5b-85d5-7528-9edf-2a047d57e9a1@samsung.com>
Date:   Thu, 4 Jun 2020 15:28:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <4a5874c1-6b4e-2da5-4dd1-dd5537fe6de7@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzo7DyXEqvmgZLcmyUodFh0orCTv1ITLtS6C18jAtb+yo
        ZVCYls3hyoSVLksRK++35hWVadIILyuvywvmBUTRrKZmYppnp4vffs/z/J/L/+XFEfEE3wkP
        j4qlFVGyCAkmRGve/ezav7JkCvGqUDuQlZnlfFIzNomRAwtTfLL42wQgjcYKAfn5+SceudSr
        5JE9DdkYaVa3ATLT2MwjZ5c7eeTQix6U7Gjv5pNr/ZUoqWxbQsjKReo4QdVrRwRUVVEqRg33
        N2LUo19elK7vAUo91BUBymCq5VHmKpdz+EXh0VA6IjyeVnj6XhaGGZPH+TFLjjc16y/RRFBi
        pwJWOCQOQKVaz1cBIS4mCgCc1g1iXLAA4ELTMp9ViQkzgE1Zx1QAt3SoSiku/RrAxdlATj8P
        YLI6B2MLdkQAbMmttUy1J+4CqEudQtgCQnQgsGzGiWWMkELVnMrSICJ84ePBfAHLKOEKR8x1
        FnYggmHa6AzCaWzh+6xJlGUrwge++joPuJnbYXL1sz/zHeHgZA6Ps6bGYXGNC8cnoX4oBePY
        Ds4YdAKOt8L1elYv3OBkAMe6SgVckAZgT1Im4FRH4HDXCsbaR4g9sLzBk0ufgJmF2Rj3KjbQ
        NGfL3WADM2qeIlxaBJUpYk69C2oNZf/WtnzoRtKBRLvJmXaTG+0mN9r/e3MBWgQc6TgmUk4z
        3lH0DQ9GFsnERck9rkZHVoGNr9e+ZlisA82rV1oBgQOJtcj00RQi5svimYTIVgBxRGIv8uts
        DxGLQmUJt2hF9CVFXATNtAJnHJU4irzzpoPFhFwWS1+n6Rha8bfKw62cEkHYQGHzNX2Zh82+
        C9WjmvNDhSqfgJ5JvyC3bUVBU6290reHdxCufaXS/BLG81TfPd7E3vtuX/zlgelJB33U3tbS
        6CDnndqGupaz82diy11UT1YP/UD0uxMWHdxHTvv2Ao+5Jr0iK+NJo21wxYhmiyQ8LzVmCrO5
        c9tz9fvgm3H/AgnKhMmk7oiCkf0GHlMq83YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xe7q/vt2IM/jexGSxccZ6VoupD5+w
        WVz/8pzVYvXHx4wW589vYLd4MPcmk8W3Kx1MFpd3zWGz+Nx7hNFixvl9TBZvfpxlsrg97zKL
        xZnTl1gt/l3byGLRceQbs8XGrx4OAh47Z91l99i0qpPN4861PWwe/X8NPLZcbWfx6NuyitHj
        +I3tTB6fN8kFcETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZZxvfsRa8E28Yur/pSwNjGuEuxg5OCQETCS61np0MXJxCAksZZRYsWQpYxcjJ1Bc
        RuLktAZWCFtY4s+1LjaIoreMEj37NzODJIQFAiUOLtjOCpIQEWhklJi1YRc7iMMscI5Z4viH
        V1AtPxglLh59wwbSwiZgKNH1tgvM5hWwk5h4awk7iM0ioCJx9/MOMFtUIFaie/EPdogaQYmT
        M5+wgNicArYSyz68B7uPWcBMYt7mh8wQtrxE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0
        LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREY7duO/dy8g/HSxuBDjAIcjEo8vDcu3ogT
        Yk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnAxNRXkm8oamh
        uYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxphsOSuTZ1/a18999IzTpkIo
        4PAcgYKpZZtEbF/UZWRpbSq5wl9dWbdu15kVC2aWaX56G80R8t/ZOnWj05mS2ylWa1ZPTNbV
        Zpafu6jf56rstij7Z9IM4c07T6Tefn7I9My1Q8WcHQ8CVAR0+me21Mj9k9ih/IUj3SeMUSla
        t6VMxelI0kt+JZbijERDLeai4kQAvii5hQwDAAA=
X-CMS-MailID: 20200604132826eucas1p22f1d6e0121994e4579fca30f6b53e03b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602130931eucas1p1cd784c8f692fa91dc566504543a927de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602130931eucas1p1cd784c8f692fa91dc566504543a927de
References: <57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com>
        <CGME20200602130931eucas1p1cd784c8f692fa91dc566504543a927de@eucas1p1.samsung.com>
        <20200602130211.2727-1-m.szyprowski@samsung.com>
        <4a5874c1-6b4e-2da5-4dd1-dd5537fe6de7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 02.06.2020 17:15, Dmitry Osipenko wrote:
> 02.06.2020 16:02, Marek Szyprowski пишет:
>> Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
>> require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
>> ensures that the voltage balancing for the coupled regulators is done
>> only when clients for the each regulator apply their constraints, so the
>> voltage values don't go beyond the bootloader-selected operation point
>> during the boot process. This also ensures proper voltage balancing if
>> any of the client driver is missing.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   (...)
> Hello Marek,
>
> Does this mean that you're going to allow to violate the coupling
> constraints while coupled regulator has no consumers?
>
> I don't think that you may want to skip the coupled balancing ever.
> Instead you may want to assume that the min-voltage constraint equals to
> the current regulator's voltage while the coupled regulator has no
> consumers.
>
> Yours variant of the balancer doesn't prevent the voltage dropping on
> regulator's enabling while coupled regulator doesn't have active
> consumers. This is the problem which we previously had once OPP code was
> changed to enable regulator.
>
> Secondly, yours variant of the balancer also doesn't handle the case
> where set_voltage() is invoked while one of the couples doesn't have
> active consumers because voltage of this couple may drop more than
> allowed on the voltage re-balancing.
Indeed. I've focused on disabling balancing when there are no consumers 
and I didn't notice that the max_spread might be violated in such case.
> I'd suggest to simply change the regulator_get_optimal_voltage() to
> limit the desired_min_uV to the current voltage if coupled regulator has
> no consumers.

Right, this sounds like a best solution. I have an idea to try to add it 
again to the core as a simple check: if regultor is boot_on, use current 
voltage as min_uV until a consumer is registered. I've checked and this 
approach fixes the issue. I will submit a patch in a few minutes.

> I don't think that any of the today's upstream kernel coupled-regulator
> users really need to support the case where a regulator couple is
> allowed *not* to have active consumers, so for now it should be fine to
> change the core code to accommodate the needs of the Exynos regulators
> (IMO). We may get back to this later on once there will be a real need
> support that case.
>
> Please also note that I'm assuming that each of the coupled regulators
> doesn't have more than one consumer at a time in yours case (correct?),
> because yours solution won't work well in a case of multiple consumers.
> There is no universal solution for this bootstrapping problem yet.

There are only a single consumers for each coupled regulator (cpufreq 
for vdd_arm and devfreq for vdd_int).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

