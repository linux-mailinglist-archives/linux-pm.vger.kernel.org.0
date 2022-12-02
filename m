Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CA6402C4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 09:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiLBI7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 03:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiLBI72 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 03:59:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983DBBF652
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 00:57:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35D3D6602BB8;
        Fri,  2 Dec 2022 08:57:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669971449;
        bh=OrDMOSV8uH0KduyAMN/BeF+KC/jxUhgHd2Ke2DRSG1U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dZEsN+VBDv2402MqbMKURyMx4YPV5scscHhWtEiCIsLUi+ht9xiULoOvnhy5UnljJ
         lIcMX7iKT3oybil8AZOZkEPne55FOuvQsHPvlZrOqiRuzMpZ9pGSepsiSGDIQ71qXv
         M1aA/bSbPCN7Kniqg6QhTn7RfjN3sVRzR0eOicsdj5rbgm1rbnkUUHutvajFQ3lb7o
         X3xnxbkH7/IWMoqDqs9vSQUJckdfYuZRmmd2d/Nd/3ThNXsY8kKzdZPcyo372N2vmy
         qReSfEKeUG4ItnjOu+an0J70FRJgZFKAaBwqIzzj6t7z0U68gwBCvoyCf6J0LcXpWu
         Jb84WVyc7Ku7Q==
Message-ID: <0ebef1a2-6b5a-04b9-a79b-79eb3349c32b@collabora.com>
Date:   Fri, 2 Dec 2022 09:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jia-wei.chang@mediatek.com, Nick <vincent@systemli.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        rex-bc.chen@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        =?UTF-8?Q?H=c3=bchn=2c_Thomas?= <thomas.huehn@hs-nordhausen.de>,
        Daniel Golle <daniel@makrotopia.org>
References: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
 <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
 <bf8d2a8f-7654-29be-1104-a842c6657b5e@systemli.org>
 <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
 <Y4jHvomTrU8guBox@makrotopia.org>
 <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
 <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 02/12/22 06:27, Viresh Kumar ha scritto:
> On 01-12-22, 16:39, Thorsten Leemhuis wrote:
>> Thx for clarifying. And I noticed I made a mistake: I should have
>> directed my earlier question wrt to any progress here more into the
>> direction of Jia-Wei Chang (who authored 6a17b3876b) and Viresh Kumar
>> (who committed it).
> 
> I was waiting for the platform maintainers to come up with a fix. I
> have sent a patch now to revert this, in-reply-to this thread.
> 
> Please confirm this is working fine. Thanks.
> 

Can you guys try this patch that I've sent a while ago?

https://lore.kernel.org/lkml/20220909093724.40078-1-angelogioacchino.delregno@collabora.com/T/#u

There were comments on it, but if that solves your issue I can push a v2
to solve what was reported.

Regards,
Angelo
