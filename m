Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2773FE562
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbhIAWUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 18:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbhIAWUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 18:20:10 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD68C061757
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 15:19:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D5DED1F614;
        Thu,  2 Sep 2021 00:19:08 +0200 (CEST)
Subject: Re: [PATCH v4 1/5] interconnect: qcom: sdm660: Commonize RPM-QoS
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20210901121518.152481-1-y.oudjana@protonmail.com>
 <20210901121518.152481-2-y.oudjana@protonmail.com>
 <9af0f031-101e-53b4-514e-9ead44320f4e@somainline.org>
 <efafd058-ad68-eb0a-af42-40d879ef63d9@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <9f902b08-bdf2-13b5-acbe-215173e7929a@somainline.org>
Date:   Thu, 2 Sep 2021 00:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <efafd058-ad68-eb0a-af42-40d879ef63d9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 02/09/21 00:01, Dmitry Baryshkov ha scritto:
> On 01/09/2021 21:48, AngeloGioacchino Del Regno wrote:
>> Il 01/09/21 14:15, Yassine Oudjana ha scritto:
>>> SoCs such as MSM8996 also control bus QoS in a similar fashion to SDM660,
>>> with some paths being controlled by RPM and others directly by the AP.
>>> Move relevant functions and defines to a new object so that they can be used
>>> in multiple drivers.
>>>
>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Hey guys!
>>
>> I'm waiting for the interconnect RPM-QoS commonization to be merged as I have fresh
>> interconnect drivers for MSM8998 and MSM8976, ready to send, that are also using
>> the very same QoS mechanism as SDM660.
> 
> We were also looking onto this. I'd propose to merge sdm660 code into main 
> icc-rpm.c instead of splitting it into separate file. We have enabled QoS for 
> apq8096 (msm8916) and msm8939. See 
> https://lore.kernel.org/linux-arm-msm/20210818015732.1717810-1-dmitry.baryshkov@linaro.org/ 
> for the reference. I'm waiting for Shawn to publish v2 of his fix, then I can post 
> v2 of my patchset.
> 

Merging it into icc-rpm would actually make sense, since the QoS mechanism won't
ever be used by the RPM-Hardened icc... so yeah, on that I agree.

Whenever you guys send the new patchsets, if you can please make sure to Cc me
and/or the other SoMainline guys, we will make sure to review and test the sets
as soon as possible, as a way to speed up the merge process, if that helps!

Thank you,
- Angelo

>>
>> Yassine, please check Shawn's recent patches for SDM660 interconnect, which are
>> fixing some bits for the QoS implementation and adding some required clocks to the
>> SDM660 interconnect driver.
>>
>> Adding Shawn to the Ccs as to make him aware of this patch;
>> also adding Marijn and Konrad from SoMainline as probably interested parties.
>>
>> Cheers!
>> - Angelo
> 
> 

