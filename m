Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946152CBB88
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLBL2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 06:28:55 -0500
Received: from comms.puri.sm ([159.203.221.185]:54722 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgLBL2z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 06:28:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 96F63E1180;
        Wed,  2 Dec 2020 03:27:44 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8omf0pHFn30F; Wed,  2 Dec 2020 03:27:43 -0800 (PST)
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable interconnect for imx8mq
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-8-martin.kepplinger@puri.sm>
 <cb498c2c-e052-390a-c64a-2be44d1d2b42@linaro.org>
 <a2c0fae4-13c5-9114-876f-bc324138e6cc@puri.sm>
 <20201202080321.GB6087@kozik-lap>
 <CAJKOXPcAbmugB9k-1Ldo=Q1J0CbOcxMtgC005w=DmWukThVcWA@mail.gmail.com>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <226e76a8-011e-ece5-d8fa-b52dbc81787b@puri.sm>
Date:   Wed, 2 Dec 2020 12:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <CAJKOXPcAbmugB9k-1Ldo=Q1J0CbOcxMtgC005w=DmWukThVcWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02.12.20 09:05, Krzysztof Kozlowski wrote:
> On Wed, 2 Dec 2020 at 10:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Tue, Dec 01, 2020 at 02:15:04PM +0100, Martin Kepplinger wrote:
>>> On 01.12.20 14:10, Georgi Djakov wrote:
>>>> On 1.12.20 14:39, Martin Kepplinger wrote:
>>>>> Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
>>>>> available for testing.
>>>>
>>>> I hope that it's not just for testing, but using it.
>>>
>>> sure, I just think that most people will use their own config for production
>>> but that's a different story. I can rephrase.
>>>
>>>>
>>>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>>>>> ---
>>>>>    arch/arm64/configs/defconfig | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index 1fed16950a7c..830c26a95b3d 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -1023,7 +1023,8 @@ CONFIG_OPTEE=y
>>>>>    CONFIG_MUX_MMIO=y
>>>>>    CONFIG_SLIM_QCOM_CTRL=m
>>>>>    CONFIG_SLIM_QCOM_NGD_CTRL=m
>>>>> -CONFIG_INTERCONNECT=y
>>>>
>>>> Why are you removing this line?
>>>
>>> savedefconfig removes it. INTERCONNECT_IMX below depends on it.
>>
>> It's save to remove it as other Interconnect options are directly
>> dependant.
> 
> Ugh, my bad, it is not allowed to remove it. My review was too fast.
> INTERCONNECT_IMX depends on it, so the INTERCONNECT must stay,
> 
> It is selected by TEGRA_MC which is independent here, so you should keep it.
> 

thanks for reviewing! Just to be clear: We're talking about defconfig, 
so if I keep INTERCONNECT that means that I do `make savedefconfig` 
which removes it (it's of course still enabled, just redundant in 
defconfig output), and then *manually* add INTERCONNECT. That would 
indicate that there's a Kconfig bug.

thanks,
                               martin
