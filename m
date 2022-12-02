Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352516404E8
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiLBKlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 05:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiLBKl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 05:41:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8697CEF82
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 02:41:25 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p13Tp-0001WJ-76; Fri, 02 Dec 2022 11:41:17 +0100
Message-ID: <c186d104-43e0-ca10-3ce2-c2f922acd8bf@leemhuis.info>
Date:   Fri, 2 Dec 2022 11:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Content-Language: en-US, de-DE
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "vincent@systemli.org" <vincent@systemli.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "thomas.huehn@hs-nordhausen.de" <thomas.huehn@hs-nordhausen.de>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>
References: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
 <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
 <bf8d2a8f-7654-29be-1104-a842c6657b5e@systemli.org>
 <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
 <Y4jHvomTrU8guBox@makrotopia.org>
 <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
 <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
 <0ebef1a2-6b5a-04b9-a79b-79eb3349c32b@collabora.com>
 <c76bd301-0e8d-2d2b-0d3e-a57ece9b496f@collabora.com>
 <b1822bbc3775730c4cedf9652323c7d72e663e4b.camel@mediatek.com>
 <8be3e050-f32a-6761-8ebd-49c38dfcf9eb@collabora.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8be3e050-f32a-6761-8ebd-49c38dfcf9eb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669977685;ef59f28f;
X-HE-SMSGID: 1p13Tp-0001WJ-76
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02.12.22 11:02, AngeloGioacchino Del Regno wrote:
> Il 02/12/22 10:43, Allen-KH Cheng (程冠勳) ha scritto:
>>
>> Jia-wei is working on this issue.
>> We will update progress ASAP.
>>
> 
> I think I've found something: the MT7622/7623 voltage constraints
> set in mediatek-cpufreq's platform data seem to be wrong.

Thx for looking into this.
> I've sent a commit to fix those [1]

Quick question: is that relative to apply at this point of the 6.1 devel
cycle? Or would it be better to revert the culprit (already introduced
in 5.19) for now and reapply it together with that fix for 6.2 (and then
backport to 6.1 stable later)?

> and that should solve the issue
> that was seen on MT7622, but the code in the voltage tracking algorithm
> is unsafe: this crash should be happening because we may be calling
> regulator_set_voltage() with max_uV < min_uV --- and this is not legal.

[...]

> [1]:
> https://lore.kernel.org/lkml/20221202095227.167492-1-angelogioacchino.delregno@collabora.com/

Side note, that patch afaics should have:

Reported-by: Nick <vincent@systemli.org>
Link:
https://lore.kernel.org/r/930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org/

To explain: Linus[1] and others considered proper link tags important in
cases like this, as they allow anyone to look into the backstory of a
commit weeks or years later. That's nothing new, the documentation[2]
for some time says to place tags in cases like this. I care personally
(and made it a bit more explicit in the docs a while ago), because these
tags make my regression tracking efforts a whole lot easier, as they
allow my tracking bot 'regzbot' to automatically connect reports with
patches posted or committed to fix tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)



>> Thanks,
>> Allen
>>
>> On Fri, 2022-12-02 at 10:19 +0100, AngeloGioacchino Del Regno wrote:
>>> Il 02/12/22 09:57, AngeloGioacchino Del Regno ha scritto:
>>>> Il 02/12/22 06:27, Viresh Kumar ha scritto:
>>>>> On 01-12-22, 16:39, Thorsten Leemhuis wrote:
>>>>>> Thx for clarifying. And I noticed I made a mistake: I should
>>>>>> have
>>>>>> directed my earlier question wrt to any progress here more into
>>>>>> the
>>>>>> direction of Jia-Wei Chang (who authored 6a17b3876b) and Viresh
>>>>>> Kumar
>>>>>> (who committed it).
>>>>>
>>>>> I was waiting for the platform maintainers to come up with a fix.
>>>>> I
>>>>> have sent a patch now to revert this, in-reply-to this thread.
>>>>>
>>>>> Please confirm this is working fine. Thanks.
>>>>>
>>>>
>>>> Can you guys try this patch that I've sent a while ago?
>>>>
>>>>
>> https://lore.kernel.org/lkml/20220909093724.40078-1-angelogioacchino.delregno@collabora.com/T/#u
>>>>
>>>> There were comments on it, but if that solves your issue I can push
>>>> a v2
>>>> to solve what was reported.
>>>>
>>>> Regards,
>>>> Angelo
>>>
>>> Wait, sorry, I've re-read the stacktrace and that won't help at all.
>>> MediaTek, can you please look at this issue?
>>>
>>> Reverting the proposed commit will make MT8183 unstable.
>>>
>>>

#regzbot monitor:
https://lore.kernel.org/r/930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org/
