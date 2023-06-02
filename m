Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2F71FB8A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jun 2023 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjFBIHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jun 2023 04:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjFBIHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jun 2023 04:07:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F141D3
        for <linux-pm@vger.kernel.org>; Fri,  2 Jun 2023 01:07:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ad752f433so1580699f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Jun 2023 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685693251; x=1688285251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mO/RY3F3B8GPgwLB+7S4hwzVRXzzO6lIPxIO1gccjeg=;
        b=A598VmaeQlIXU5K1gtsDSH/qH+2fNkD6meglLxmoet8DKTfui5H2P1hC+6+8TtYUOW
         MnB9VrNtFdGkSFg/mEQ9TN1U2/FtVCU7hqcQ74JZWpxANY+fABdbkCnz68Zv0kuFqkO1
         A1XgwUfJXRaIcHo73epEQZGz8+43hPhrR37OP4u1kG5lPH2M7bk6mQB7bADLWEt6GoUz
         VD7/LilwTL4qKynoEcDLjk9Nwb+fRuhjY2W59L6SaO8K8ZSU8vT5BZ4908x4/t8tT1nu
         1cvIHtGamhZCJp4HSp6kFt0K9ubiiiwsG8u8oRn8DiY/E1uiOdqr05TTbzeBb0zX7kTO
         1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685693251; x=1688285251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mO/RY3F3B8GPgwLB+7S4hwzVRXzzO6lIPxIO1gccjeg=;
        b=lRW4XPva1Djbs05/woElvuq4Wc53eyqSwGyOqo6PZxonT0WS5KrS8z2XfXMS4qbXsC
         CypsD8uBMFNdz3B5Sn7njvdKGJpC8Lzfwhq2hen3E1IyjOQJRTwtD7JC2Rkzh6ordZNO
         XXT+ht7K1fo3zcuhgZOWGY0+cf85f13CbbpxTj09QIZHNisUaGNBTFvs0KNMI4z8M8o/
         cR1uAJzMR5TkgQ+VHXcD+vf6YZv2Nt8ay3qGCPHS+qEmMr+MI49Ruy/uIq1cZeWszLBM
         hSdGFZLDGwxPHyUoddMcDVElL5oZBTgOlEKhWSHMcTBDGQ2s0OL1Ho0zuI0/uAi+m3cS
         Vu2w==
X-Gm-Message-State: AC+VfDw14Hsgne3jDTqGjJBotXapW+GaGaKXsAOazL/1G7NwnOaquBL+
        vjE9eu8NA6n5Wg5eQxoU68pmrw==
X-Google-Smtp-Source: ACHHUZ4iJjab6zb7VKTRm84jdXYQvx32T3lqpuKG6BtYc68C7Lg6oyRp4fV/jUzSTe+AMMJXE2XPLw==
X-Received: by 2002:adf:cd8b:0:b0:307:83a4:5860 with SMTP id q11-20020adfcd8b000000b0030783a45860mr3794370wrj.68.1685693250955;
        Fri, 02 Jun 2023 01:07:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:548f:8f7e:a3c2:888a? ([2a05:6e02:1041:c10:548f:8f7e:a3c2:888a])
        by smtp.googlemail.com with ESMTPSA id d8-20020adff848000000b0030ae849c70csm929300wrq.37.2023.06.02.01.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:07:30 -0700 (PDT)
Message-ID: <68393044-9d28-8402-e190-7cbb28442f6d@linaro.org>
Date:   Fri, 2 Jun 2023 10:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: Fixes to the
 interrupt handling
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230428195347.3832687-1-nfraprado@collabora.com>
 <20230502103344.GA3388518@google.com>
 <87b0f5cd-67a8-fbd5-5ca7-a286b543d796@linaro.org>
 <8a38a0da-3a4f-4e39-9f9e-42682edfd9bf@notapiano>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8a38a0da-3a4f-4e39-9f9e-42682edfd9bf@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 21:46, Nícolas F. R. A. Prado wrote:
> On Tue, May 30, 2023 at 02:27:36PM +0200, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> On 02/05/2023 12:33, Chen-Yu Tsai wrote:
>>> On Fri, Apr 28, 2023 at 03:53:44PM -0400, Nícolas F. R. A. Prado wrote:
>>>>
>>>> Fixes in the interrupt handling of the LVTS thermal driver noticed while
>>>> testing it on the Spherion Chromebook (mt8192-asurada-spherion) with the
>>>> MT8192 support series [1].
>>>>
>>>> These are standalone fixes and don't depend on anything else.
>>>>
>>>> [1] https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/
>>>>
>>>> Thanks,
>>>> Nícolas
>>>>
>>>>
>>>> Nícolas F. R. A. Prado (3):
>>>>     thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
>>>>     thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
>>>>     thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
>>>
>>> This series seems to have solved all interrupt storm issue I ran into, so
>>>
>>> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> I gave a try on a mt8195 board and I don't see any interrupt firing when
>> crossing the temperature thresholds.
>>
>> Did I miss something ?
> 
> No, indeed interrupts seem to be completely disabled on mt8195, even after
> setting the controllers to filtered mode (a requirement to get interrupts).

Really? interrupts work only on filtered mode? That sounds strange

What board are you using for testing?

> I
> haven't investigated that further yet. This series was validated on mt8192,
> which did have working interrupts, but they were being triggered too often.

Ok.

> Also note that I've sent a v2 with even more fixes:
> https://lore.kernel.org/all/20230504004852.627049-1-nfraprado@collabora.com/

Yes, I'm reviewing it closely

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

