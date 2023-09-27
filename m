Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473B37AF7FA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 04:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjI0CIB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 26 Sep 2023 22:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjI0CGA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 22:06:00 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896230DA
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 18:24:55 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9AB9924E268;
        Wed, 27 Sep 2023 09:24:53 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 09:24:53 +0800
Received: from [192.168.125.107] (113.72.144.128) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 09:24:52 +0800
Message-ID: <ada7a449-cc23-84e2-0d7f-5b90c4f07ded@starfivetech.com>
Date:   Wed, 27 Sep 2023 09:24:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
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
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Hi Geert,

Where is the website link for the pmdomain/next?

Thanks,
Changhuang


