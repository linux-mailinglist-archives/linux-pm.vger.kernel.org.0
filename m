Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DA7AF805
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjI0CMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 22:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjI0CKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 22:10:17 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D11F21
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 18:31:21 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2176224E26F;
        Wed, 27 Sep 2023 09:31:20 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 09:31:20 +0800
Received: from [192.168.125.107] (113.72.144.128) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 09:31:19 +0800
Message-ID: <88457ee3-b97a-b350-7f87-20cdc18cb4e9@starfivetech.com>
Date:   Wed, 27 Sep 2023 09:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [GIT PULL 2/5] dt-bindings: power: Add power-domain header for
 JH7110
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <ulf.hansson@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, <arnd@arndb.de>,
        <jiajie.ho@starfivetech.com>, <linux-pm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <robh@kernel.org>,
        <walker.chen@starfivetech.com>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
 <20230913-grumbly-rewrite-34c85539f2ed@spud>
 <CAMuHMdXmNCXvFj8gF0COQrvhbRuugrJN0sM_DL1vDE=4EU0bEA@mail.gmail.com>
 <20230926-trio-sweat-9b878df53209@spud>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230926-trio-sweat-9b878df53209@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.128]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



>>>  #ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
>>> @@ -14,4 +14,7 @@
>>>  #define JH7110_PD_ISP          5
>>>  #define JH7110_PD_VENC         6
>>>
>>> +#define JH7110_PD_DPHY_TX      0
>>> +#define JH7110_PD_DPHY_RX      1
>>
>> These values are conflicting with similarly-named values above:
>>
>>     #define JH7110_PD_SYSTOP        0
>>     #define JH7110_PD_CPU           1
>>
>> Upon closer look, and diving into the driver, this header file contains
>> definitions for two separate number spaces: the first set is meant
>> to be used in PM Domain specifiers referring to a node compatible
>> with "starfive,jh7110-pmu", while the second set is meant to be
>> used in PM Domain specifiers referring to a node compatible with
>> "starfive,jh7110-aon-syscon".
> 
> Yeah, apologies for the confusion there. I maybe should have
> requested an additional file, since the relevant compatibles
> are different.
> 
>> I think it would be nice to have this reflected in the names of
>> the defines (e.g. JH7110_PD_AON_DPHY_TX), and/or to add comments
>> clearly delimiting the two separate number spaces, and explaining
>> where they apply to.
> 
> Since this is 6.7 material, there's still plenty of time remaining to
> make either of these changes. Changhuang Liang, do you think you would
> be able to send a patch implementing either of the suggestions made by
> Geert?
> 

Hi Conor,

I will send a patch to fix this confusion.

Thanks,
Changhuang
