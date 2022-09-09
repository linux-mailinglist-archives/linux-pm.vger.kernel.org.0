Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7725B3B2F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiIIOyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIIOyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 10:54:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027A135D4D
        for <linux-pm@vger.kernel.org>; Fri,  9 Sep 2022 07:54:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq23so3114225lfb.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2022 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GPlNanxZzyuYXr2dtLtbddcEoggsRN1YPrp6j3a0MDo=;
        b=C/DIu35Vp3ob2CKDtOGnRKh9EVot0EOnfj6O/skxYStU6gmntAgL1OT/KU/ePN/n5z
         +0elYmIDvGaXjM+Jx8tDCnQCPQKjuGFhtuFo9rCApafv+yBuez9oNZwtRcKxWjxfhL/e
         4arA9A7k4yUkAkb8V9uXcmyA40lHPkQlU01isnFAQMvKDd8Wx5bqcn6/IGc+eksMeRXW
         mv5GEF9Opi3FtVhYFKQ1x4bVh6MJrxcLdnTxJEGompeShtKuS9bCosTyRSebPmHDK12Y
         vIZVxPniTeZYWba6zUYiSK2ON6Wvkap88VyRKEbFY68/gpWOiluKx3X/l1ieC+j8wlvg
         qJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GPlNanxZzyuYXr2dtLtbddcEoggsRN1YPrp6j3a0MDo=;
        b=iGG7dzzLaFutivQvQ3HCkakYocYvmffxYEQbtsP9o8qtwDPOdA6X8jUNt9FICbQqyE
         lGJBFwvm96cSJKqHAzqSTI5DMCBGxMBu84IbTXs516nU/WWOlVzPBJkUfm2COIn8nHeO
         vx0O75jOEsKQKRcyegoGlyb2ZfcoV2d1TGgZoyALdQ82GzVIl1es5Npl6NOvDm93sg8O
         zZHML7zDNzVbyvc+/bV+BgQQHamUpFQLgPCTLtgiCOZPAw1OsQapUIWLohWstAug0G15
         /2bWT7LOLRQZyYEqAYf/x16dBgKSyQ5wEqs7v1P9jUP6VW8QQLB+tHVwbTtcxR6kSc9/
         yvrQ==
X-Gm-Message-State: ACgBeo3jp1DFz7LoG+KWfCOYDciESHxCOyPZv71z6jSCByEahOan5hp5
        I0MGCB2mWSGNJnEAnm3gsqEEPg==
X-Google-Smtp-Source: AA6agR6w16Dxz7ZrLFTW9h5UOAyWLkUApXlkYVCjtabyy/rkrbseXdXRD9R+4nLXvx1OiGo3/E+q+g==
X-Received: by 2002:a05:6512:31d5:b0:498:f3dc:dd2 with SMTP id j21-20020a05651231d500b00498f3dc0dd2mr1940875lfe.101.1662735245157;
        Fri, 09 Sep 2022 07:54:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id br1-20020a056512400100b00492df78f311sm113814lfb.57.2022.09.09.07.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:54:04 -0700 (PDT)
Message-ID: <e752fd61-2807-381c-78ab-a6af8ad9b8d6@linaro.org>
Date:   Fri, 9 Sep 2022 17:54:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Add data for MSM8909
Content-Language: en-GB
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
 <20220627131415.2868938-4-stephan.gerhold@kernkonzept.com>
 <e5c7b34e-2a1a-840a-7f3f-652d8027fa4d@linaro.org>
 <YxtEtDLVEAGP8sGE@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YxtEtDLVEAGP8sGE@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/09/2022 16:51, Stephan Gerhold wrote:
> On Thu, Sep 08, 2022 at 11:57:41PM +0300, Dmitry Baryshkov wrote:
>> On 27/06/2022 16:14, Stephan Gerhold wrote:
>>> The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block similar to
>>> MSM8916, except that the bit offsets in the qfprom were changed.
>>> Also, some fixed correction factors are needed as workaround because the
>>> factory calibration apparently was not reliable enough.
>>>
>>> Add the defines and calibration function for MSM8909 in the existing
>>> tsens-v0_1.c driver to make the thermal sensors work on MSM8909.
>>> The changes are derived from the original msm-3.18 kernel [1] from
>>> Qualcomm but cleaned up and adapted to the driver in mainline.
>>>
>>> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-08600-8x09.0/drivers/thermal/msm-tsens.c
>>>
>>> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
>>> ---
>>>    drivers/thermal/qcom/tsens-v0_1.c | 119 +++++++++++++++++++++++++++++-
>>>    drivers/thermal/qcom/tsens.c      |   3 +
>>>    drivers/thermal/qcom/tsens.h      |   2 +-
>>>    3 files changed, 122 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
>>> index f136cb350238..e17c4f9d9aa5 100644
>>> --- a/drivers/thermal/qcom/tsens-v0_1.c
>>> +++ b/drivers/thermal/qcom/tsens-v0_1.c
>>> @@ -15,6 +15,48 @@
>>>    #define TM_Sn_STATUS_OFF			0x0030
>>>    #define TM_TRDY_OFF				0x005c
>>> +/* eeprom layout data for 8909 */
>>> +#define MSM8909_CAL_SEL_MASK	0x00070000
>>> +#define MSM8909_CAL_SEL_SHIFT	16
>>> +
>>> +#define MSM8909_BASE0_MASK	0x000000ff
>>> +#define MSM8909_BASE1_MASK	0x0000ff00
>>> +#define MSM8909_BASE0_SHIFT	0
>>> +#define MSM8909_BASE1_SHIFT	8
>>> +
>>> +#define MSM8909_S0_P1_MASK	0x0000003f
>>> +#define MSM8909_S1_P1_MASK	0x0003f000
>>> +#define MSM8909_S2_P1_MASK	0x3f000000
>>> +#define MSM8909_S3_P1_MASK	0x000003f0
>>> +#define MSM8909_S4_P1_MASK	0x003f0000
>>> +
>>> +#define MSM8909_S0_P2_MASK	0x00000fc0
>>> +#define MSM8909_S1_P2_MASK	0x00fc0000
>>> +#define MSM8909_S2_P2_MASK_0_1	0xc0000000
>>> +#define MSM8909_S2_P2_MASK_2_5	0x0000000f
>>> +#define MSM8909_S3_P2_MASK	0x0000fc00
>>> +#define MSM8909_S4_P2_MASK	0x0fc00000
>>> +
>>> +#define MSM8909_S0_P1_SHIFT	0
>>> +#define MSM8909_S1_P1_SHIFT	12
>>> +#define MSM8909_S2_P1_SHIFT	24
>>> +#define MSM8909_S3_P1_SHIFT	4
>>> +#define MSM8909_S4_P1_SHIFT	16
>>> +
>>> +#define MSM8909_S0_P2_SHIFT	6
>>> +#define MSM8909_S1_P2_SHIFT	18
>>> +#define MSM8909_S2_P2_SHIFT_0_1	30
>>> +#define MSM8909_S2_P2_SHIFT_2_5	2
>>> +#define MSM8909_S3_P2_SHIFT	10
>>> +#define MSM8909_S4_P2_SHIFT	22
>>> +
>>> +#define MSM8909_D30_WA_S1	10
>>> +#define MSM8909_D30_WA_S3	9
>>> +#define MSM8909_D30_WA_S4	8
>>> +#define MSM8909_D120_WA_S1	6
>>> +#define MSM8909_D120_WA_S3	9
>>> +#define MSM8909_D120_WA_S4	10
>>> +
>>>    /* eeprom layout data for 8916 */
>>>    #define MSM8916_BASE0_MASK	0x0000007f
>>>    #define MSM8916_BASE1_MASK	0xfe000000
>>> @@ -223,6 +265,68 @@
>>>    #define MDM9607_CAL_SEL_MASK	0x00700000
>>>    #define MDM9607_CAL_SEL_SHIFT	20
>>> +static int calibrate_8909(struct tsens_priv *priv)
>>> +{
>>> +	u32 *qfprom_cdata, *qfprom_csel;
>>> +	int base0, base1, mode, i;
>>> +	u32 p1[5], p2[5];
>>> +
>>> +	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>> +	if (IS_ERR(qfprom_cdata))
>>> +		return PTR_ERR(qfprom_cdata);
>>> +
>>> +	qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
>>> +	if (IS_ERR(qfprom_csel)) {
>>> +		kfree(qfprom_cdata);
>>> +		return PTR_ERR(qfprom_csel);
>>> +	}
>>> +
>>> +	mode = (qfprom_csel[0] & MSM8909_CAL_SEL_MASK) >> MSM8909_CAL_SEL_SHIFT;
>>> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>>> +
>>> +	switch (mode) {
>>> +	case TWO_PT_CALIB:
>>> +		base1 = (qfprom_csel[0] & MSM8909_BASE1_MASK) >> MSM8909_BASE1_SHIFT;
>>> +		p2[0] = (qfprom_cdata[0] & MSM8909_S0_P2_MASK) >> MSM8909_S0_P2_SHIFT;
>>> +		p2[1] = (qfprom_cdata[0] & MSM8909_S1_P2_MASK) >> MSM8909_S1_P2_SHIFT;
>>> +		p2[2] = (qfprom_cdata[0] & MSM8909_S2_P2_MASK_0_1) >> MSM8909_S2_P2_SHIFT_0_1;
>>> +		p2[2] |= (qfprom_cdata[1] & MSM8909_S2_P2_MASK_2_5) << MSM8909_S2_P2_SHIFT_2_5;
>>> +		p2[3] = (qfprom_cdata[1] & MSM8909_S3_P2_MASK) >> MSM8909_S3_P2_SHIFT;
>>> +		p2[4] = (qfprom_cdata[1] & MSM8909_S4_P2_MASK) >> MSM8909_S4_P2_SHIFT;
>>
>> Please use nvmem_cell_read_* to read these values. This would allow you to
>> push all the possible si_pi definitions into the DT and use mode to switch
>> between them. And mode can be read using the nvmem_cell_read_* too.
> 
> Thanks for the suggestion.
> 
> I agree that this would have been nicer if this had been implemented
> that way for all the existing platforms supported by the tsens driver.
> But now we already have 7+ platforms using exactly the approach I'm
> using in this patch, with existing bindings and existing device trees
> that must stay supported.
> 
> My msm8909.dtsi is actually mostly just a simple overlay on top of
> msm8916.dtsi, so I would like to keep these platforms consistent
> wherever possible. We could change all the existing platforms as well
> but in my opinion this would just make the driver and bindings a lot
> more complicated because the old approach still must be supported.
> 
> Also, I think the main benefit of having all the points as separate
> NVMEM cells would be to allow having a generic qcom,tsens-v0.1
> compatible, without SoC-specific code required in the driver. However,
> subtle differences in the way the calibration points are used (e.g. the
> fixed correction offsets in this patch) will likely make SoC-specific
> code necessary anyway. And then it doesn't matter much if the bit masks
> are in the driver like all existing code or end up being put into the DT.
> 
> TL;DR: I would prefer to keep this as-is to keep the driver simple and
> consistent across all the supported platforms.

At least let's change the driver to use FIELD_GET, this will allow us to 
remove SHIFT defines. I will take a look in the next few days if we can 
switch to nvmem_cell in a sensible manner.

-- 
With best wishes
Dmitry

