Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE47B0557
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjI0N0r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 27 Sep 2023 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjI0N0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 09:26:47 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEC10A
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 06:26:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6F2D724DF1F;
        Wed, 27 Sep 2023 21:26:43 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 21:26:43 +0800
Received: from [192.168.125.107] (113.72.144.128) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 21:26:42 +0800
Message-ID: <5d942896-df35-f4a8-53ed-045023e579c9@starfivetech.com>
Date:   Wed, 27 Sep 2023 21:26:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [GIT PULL 2/5] dt-bindings: power: Add power-domain header for
 JH7110
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor@kernel.org>
CC:     <ulf.hansson@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, <arnd@arndb.de>,
        <jiajie.ho@starfivetech.com>, <linux-pm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <robh@kernel.org>,
        <walker.chen@starfivetech.com>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
 <20230913-grumbly-rewrite-34c85539f2ed@spud>
 <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.144.128]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2023/9/26 18:55, Geert Uytterhoeven wrote:
> Hi Conor, Changhuang,
> 
> On Wed, Sep 13, 2023 at 3:58 PM Conor Dooley <conor@kernel.org> wrote:
>> From: Changhuang Liang <changhuang.liang@starfivetech.com>
>>
>> Add power-domain header for JH7110 SoC, it can use to operate dphy
>> power.
>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks for your patch, which is now commit 41b66b54a72bd796
> ("dt-bindings: power: Add power-domain header for JH7110")
> in pmdomain/next.
> 
> Conor: looks like you forgot to update the patch description, as promised in
> https://lore.kernel.org/all/20230519-irk-dwelled-6a499c482e62@spud?
> 
>> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
>> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
>> @@ -1,6 +1,6 @@
>>  /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>  /*
>> - * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
>>   * Author: Walker Chen <walker.chen@starfivetech.com>
>>   */
>>  #ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
>> @@ -14,4 +14,7 @@
>>  #define JH7110_PD_ISP          5
>>  #define JH7110_PD_VENC         6
>>
>> +#define JH7110_PD_DPHY_TX      0
>> +#define JH7110_PD_DPHY_RX      1
> 
> These values are conflicting with similarly-named values above:
> 
>     #define JH7110_PD_SYSTOP        0
>     #define JH7110_PD_CPU           1
> 
> Upon closer look, and diving into the driver, this header file contains
> definitions for two separate number spaces: the first set is meant
> to be used in PM Domain specifiers referring to a node compatible
> with "starfive,jh7110-pmu", while the second set is meant to be
> used in PM Domain specifiers referring to a node compatible with
> "starfive,jh7110-aon-syscon".
> I think it would be nice to have this reflected in the names of
> the defines (e.g. JH7110_PD_AON_DPHY_TX), and/or to add comments
> clearly delimiting the two separate number spaces, and explaining
> where they apply to.
> 

Hi Geert,

I have sent a series to fix this, but I forget to send it to you.
https://patchwork.kernel.org/project/linux-pm/patch/20230927130734.9921-2-changhuang.liang@starfivetech.com/

Thanks,
Changhuang
