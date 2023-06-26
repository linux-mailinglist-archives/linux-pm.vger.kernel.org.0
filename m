Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD673E15B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFZOAj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFZOAj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 10:00:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8779E113
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 07:00:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso779057e87.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687788033; x=1690380033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KchPEymag+zQQoNX8Puvzp/mkvTbaR1RkHibEj1adEI=;
        b=XQScpTGqpqAlBjUzgnZGzJotmUZt85T2Rs24PJ/Q2wPfOmJHNxTa2nXdXrxadoxgae
         ySvxNAfKiGeHJgC+GITD8/u1JceW3gfae5uw0kUIqXar/zv41VFfXToyROMXh52CMQv8
         wwn+oaz4hnsZyqEUBRHX5lFAQLeLgL7DRbHEfge7K+fYML/tKgcUY9U3piANu6bqBU3B
         MFGhFPNwh2o5hMqtgFg5W4zpA9BAF3MkuPDrfwAjT2StRHEnXefB/fXOd65bcrtv9axL
         vTXbjlX+E/tQNIV5eLc+mrCs2kidKq5hCs4G6EBwFhpE/8vb8Nc468pBn6k3GaiXPgDZ
         ULZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788033; x=1690380033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KchPEymag+zQQoNX8Puvzp/mkvTbaR1RkHibEj1adEI=;
        b=VSLVxnhLeUjSsZ02cawFG9ym+McWEiQprmL7YXom/RekKrkNx0UEBm5LXU2dN/Uu2j
         F45FmObWYGiajfNmJRwRQSgpIRErFDwcuXH5gYhfMs1Y61ZHLg49u43qevATI9NOnQxC
         ovJ2HNn00acxs8x9RPBeCZunxybnjuN1ZzGDWlJjKaH1XeoI5AdrAdJgMF2SQrzN17yM
         chr6KqGaBjuzcvZU5q+s1If5uPkOUgaMBaT0XjrQrNbW0DeYDfDh7xqac2T7YUOAE+Xi
         Ln+6ci1jo3o63BUOsQTDCGUZCR5JHRN0WvqgWglLyuk8KNkXFT6XcZBSOV6xGgfkuokP
         JI0w==
X-Gm-Message-State: AC+VfDyEJnvuObw8y0xxXll3NpFijpBbYh4CGGGD3TgXqJ3pXc5KRRWZ
        E53hN5gReauLQz8ti6/4dnPUkQ==
X-Google-Smtp-Source: ACHHUZ4MoDAkmC67kSVrBt6n33xB2dEeYeNO9mB9A61tBD1kz6EGN3KSXEoOS3iQU4Uo4lblpUNOzA==
X-Received: by 2002:a05:6512:3ca6:b0:4f9:69e9:4fa6 with SMTP id h38-20020a0565123ca600b004f969e94fa6mr8382236lfv.23.1687788032401;
        Mon, 26 Jun 2023 07:00:32 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id t3-20020a19ad03000000b004fa52552c82sm975548lfc.155.2023.06.26.07.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:00:32 -0700 (PDT)
Message-ID: <44cbfe3f-9ef8-13ae-93a0-5b4f6a553679@linaro.org>
Date:   Mon, 26 Jun 2023 16:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/26] soc: qcom: spm: add support for voltage
 regulator
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-9-dmitry.baryshkov@linaro.org>
 <22be223e-053b-44fb-ca01-0a4c88f02e8b@linaro.org>
 <87410e1b-24dc-c02b-e31c-99976d46b672@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <87410e1b-24dc-c02b-e31c-99976d46b672@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26.06.2023 15:53, Dmitry Baryshkov wrote:
> On 26/06/2023 14:47, Konrad Dybcio wrote:
>> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>>> The SPM / SAW2 device also provides a voltage regulator functionality
>>> with optional AVS (Adaptive Voltage Scaling) support. The exact register
>>> sequence and voltage ranges differs from device to device.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   drivers/soc/qcom/spm.c | 205 ++++++++++++++++++++++++++++++++++++++++-
>>>   include/soc/qcom/spm.h |   9 ++
>>>   2 files changed, 212 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>>> index a6cbeb40831b..3c16a7e1710c 100644
>>> --- a/drivers/soc/qcom/spm.c
>>> +++ b/drivers/soc/qcom/spm.c
>>> @@ -9,19 +9,31 @@
>>>   #include <linux/kernel.h>
>>>   #include <linux/init.h>
>>>   #include <linux/io.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/linear_range.h>
>>>   #include <linux/module.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/of.h>
>>>   #include <linux/of_address.h>
>>>   #include <linux/of_device.h>
>>> +#include <linux/bitfield.h>
>> This addition is very out-of-order
> 
> The whole list is out of order. Proably I should sort it first
> 
>>
>>>   #include <linux/err.h>
>>>   #include <linux/platform_device.h>
>>> +#include <linux/regulator/driver.h>
>>> +#include <linux/smp.h>
>>>   #include <soc/qcom/spm.h>
>>>   +#define FIELD_SET(current, mask, val)    \
>>> +    (((current) & ~(mask)) | FIELD_PREP((mask), (val)))
>>> +
>>>   #define SPM_CTL_INDEX        0x7f
>>>   #define SPM_CTL_INDEX_SHIFT    4
>>>   #define SPM_CTL_EN        BIT(0)
>>>   +#define SPM_1_1_AVS_CTL_AVS_ENABLED BIT(27)
>>> +#define SPM_AVS_CTL_MIN_VLVL    (0x3f << 10)
>>> +#define SPM_AVS_CTL_MAX_VLVL    (0x3f << 17)
>> GENMASK
> 
> ack
> 
>>
>>> +
>>>   enum spm_reg {
>>>       SPM_REG_CFG,
>>>       SPM_REG_SPM_CTL,
>>> @@ -31,10 +43,12 @@ enum spm_reg {
>>>       SPM_REG_PMIC_DATA_1,
>>>       SPM_REG_VCTL,
>>>       SPM_REG_SEQ_ENTRY,
>>> -    SPM_REG_SPM_STS,
>>> +    SPM_REG_STS0,
>>> +    SPM_REG_STS1,
>>>       SPM_REG_PMIC_STS,
>>>       SPM_REG_AVS_CTL,
>>>       SPM_REG_AVS_LIMIT,
>>> +    SPM_REG_RST,
>>>       SPM_REG_NR,
>>>   };
>>>   @@ -171,6 +185,10 @@ static const struct spm_reg_data spm_reg_8226_cpu  = {
>>>     static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
>>>       [SPM_REG_CFG]        = 0x08,
>>> +    [SPM_REG_STS0]        = 0x0c,
>>> +    [SPM_REG_STS1]        = 0x10,
>>> +    [SPM_REG_VCTL]        = 0x14,
>>> +    [SPM_REG_AVS_CTL]    = 0x18,
>>>       [SPM_REG_SPM_CTL]    = 0x20,
>>>       [SPM_REG_PMIC_DLY]    = 0x24,
>>>       [SPM_REG_PMIC_DATA_0]    = 0x28,
>>> @@ -178,7 +196,12 @@ static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
>>>       [SPM_REG_SEQ_ENTRY]    = 0x80,
>>>   };
>>>   +static void smp_set_vdd_v1_1(void *data);
>>> +
>>>   /* SPM register data for 8064 */
>>> +static struct linear_range spm_v1_1_regulator_range =
>>> +    REGULATOR_LINEAR_RANGE(700000, 0, 56, 12500);
>>> +
>>>   static const struct spm_reg_data spm_reg_8064_cpu = {
>>>       .reg_offset = spm_reg_offset_v1_1,
>>>       .spm_cfg = 0x1F,
>>> @@ -189,6 +212,10 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
>>>           0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
>>>       .start_index[PM_SLEEP_MODE_STBY] = 0,
>>>       .start_index[PM_SLEEP_MODE_SPC] = 2,
>>> +    .set_vdd = smp_set_vdd_v1_1,
>>> +    .range = &spm_v1_1_regulator_range,
>>> +    .init_uV = 1300000,
>>> +    .ramp_delay = 1250,
>>>   };
>>>     static inline void spm_register_write(struct spm_driver_data *drv,
>>> @@ -240,6 +267,179 @@ void spm_set_low_power_mode(struct spm_driver_data *drv,
>>>       spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
>>>   }
>>>   +static int spm_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
>>> +{
>>> +    struct spm_driver_data *drv = rdev_get_drvdata(rdev);
>>> +
>>> +    drv->volt_sel = selector;
>>> +
>>> +    /* Always do the SAW register writes on the corresponding CPU */
>>> +    return smp_call_function_single(drv->reg_cpu, drv->reg_data->set_vdd, drv, true);
>>> +}
>>> +
>>> +static int spm_get_voltage_sel(struct regulator_dev *rdev)
>>> +{
>>> +    struct spm_driver_data *drv = rdev_get_drvdata(rdev);
>>> +
>>> +    return drv->volt_sel;
>>> +}
>>> +
>>> +static const struct regulator_ops spm_reg_ops = {
>>> +    .set_voltage_sel    = spm_set_voltage_sel,
>>> +    .get_voltage_sel    = spm_get_voltage_sel,
>>> +    .list_voltage        = regulator_list_voltage_linear_range,
>>> +    .set_voltage_time_sel    = regulator_set_voltage_time_sel,
>>> +};
>>> +
>>> +static void smp_set_vdd_v1_1(void *data)
>>> +{
>>> +    struct spm_driver_data *drv = data;
>>> +    unsigned int vlevel = drv->volt_sel;
>>> +    unsigned int vctl, data0, data1, avs_ctl, sts;
>>> +    bool avs_enabled;
>> Reverse-Christmas-tree?
>>
>>> +
>>> +    vlevel |= 0x80; /* band */
>> That's conveniently 1<<7.. do we know if it's a significant number
>> or just a bit that does something within that field?
> 
> More like 2 << 6. A bit of the issue is that PMIC_DATA_n format is PMIC-specific. I'll see what I can do here.
> 
>>
>>> +
>>> +    avs_ctl = spm_register_read(drv, SPM_REG_AVS_CTL);
>>> +    vctl = spm_register_read(drv, SPM_REG_VCTL);
>>> +    data0 = spm_register_read(drv, SPM_REG_PMIC_DATA_0);
>>> +    data1 = spm_register_read(drv, SPM_REG_PMIC_DATA_1);
>>> +
>>> +    avs_enabled = avs_ctl & SPM_1_1_AVS_CTL_AVS_ENABLED;
>>> +
>>> +    /* If AVS is enabled, switch it off during the voltage change */
>>> +    if (avs_enabled) {
>>> +        avs_ctl &= ~SPM_1_1_AVS_CTL_AVS_ENABLED;
>>> +        spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
>>> +    }
>>> +
>>> +    /* Kick the state machine back to idle */
>>> +    spm_register_write(drv, SPM_REG_RST, 1);
>>> +
>>> +    vctl = FIELD_SET(vctl, 0xff, vlevel);
>>> +    data0 = FIELD_SET(data0, 0xff, vlevel);
>>> +    data1 = FIELD_SET(data1, 0x3f, vlevel);
>>> +    data1 = FIELD_SET(data1, 0x3f << 16, vlevel);
>> GENMASK
>>
>>> +
>>> +    spm_register_write(drv, SPM_REG_VCTL, vctl);
>>> +    spm_register_write(drv, SPM_REG_PMIC_DATA_0, data0);
>>> +    spm_register_write(drv, SPM_REG_PMIC_DATA_1, data1);
>>> +
>>> +    if (read_poll_timeout_atomic(spm_register_read,
>>> +                      sts, sts == vlevel,
>>> +                      1, 200, false,
>>> +                      drv, SPM_REG_STS1)) {
>> Not sure if misaligned or thunderfox is acting up again
> 
> off-by-one, I'll fix it.
> 
>>
>>> +        dev_err_ratelimited(drv->dev, "timeout setting the voltage (%x %x)!\n", sts, vlevel);
>>> +        goto enable_avs;
>>> +    }
>>> +
>>> +    if (avs_enabled) {
>>> +        unsigned int max_avs = vlevel & 0x3f;
>> GENMASK
>>
>>> +        unsigned int min_avs = max(max_avs, 4U) - 4;
>> So it's 0 or >= (1<<31 - 4)?
>>
>>> +        avs_ctl = FIELD_SET(avs_ctl, SPM_AVS_CTL_MIN_VLVL, min_avs);
>>> +        avs_ctl = FIELD_SET(avs_ctl, SPM_AVS_CTL_MAX_VLVL, max_avs);
>>> +        spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
>>> +    }
>>> +
>>> +enable_avs:
>>> +    if (avs_enabled) {
>>> +        avs_ctl |= SPM_1_1_AVS_CTL_AVS_ENABLED;
>>> +        spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
>>> +    }
>>> +}
>>> +
>>> +static int spm_get_cpu(struct device *dev)
>>> +{
>>> +    int cpu;
>>> +    bool found;
>> Reverse-Christmas-tree?
>>
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        struct device_node *cpu_node, *saw_node;
>> As long as Linux is running, there should be at least one CPU up,
>> so this always gets entered, perhaps the definitions could be moved
>> to the main function body
> 
> Huh, I'm not sure that I got you correct here. Do you mean movign cpu_node and saw_node to the top of spm_get_cpu()?
Yes

> 
>>
>>> +
>>> +        cpu_node = of_cpu_device_node_get(cpu);
>>> +        if (!cpu_node)
>>> +            continue;
>>> +
>>> +        saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
>>> +        found = (saw_node == dev->of_node);
>> The error checking here works out, but it's a bit cryptic.. Though
>> I'm not opposed to saving 3 cycles on slow and old CPUs :D
> 
> It's not the error checking per se. We have to put both nodes before returning.
> 
> So an alternative might me:
> 
> saw_node = ...
> if (saw_node == cpu_node) {
>     of_node_put(saw_node);
>     of_node_put(cpu_node);
>     return cpu;
> }
> 
> of_node_put(saw_node);
> of_node_put(cpu_node);
> 
> But it looks worse to me. Did you mean this kind of code or was something else on your mind?
I was basically thinking that there's no explicit if (ret < 0) or whatever
but the code from this patch also works, so let's keep it as-is

Konrad
> 
>>
>>> +        of_node_put(saw_node);
>>> +        of_node_put(cpu_node);
>>> +
>>> +        if (found)
>>> +            return cpu;
>>> +    }
>>> +
>>> +    /* L2 SPM is not bound to any CPU, tie it to CPU0 */
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_REGULATOR
>>> +static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
>>> +{
>>> +    struct regulator_config config = {
>>> +        .dev = dev,
>>> +        .driver_data = drv,
>>> +    };
>>> +    struct regulator_desc *rdesc;
>>> +    struct regulator_dev *rdev;
>>> +    int ret;
>>> +    bool found;
>> Reverse-Christmas-tree?
>>
>> Konrad
>>> +
>>> +    if (!drv->reg_data->set_vdd)
>>> +        return 0;
>>> +
>>> +    rdesc = devm_kzalloc(dev, sizeof(*rdesc), GFP_KERNEL);
>>> +    if (!rdesc)
>>> +        return -ENOMEM;
>>> +
>>> +    rdesc->name = "spm";
>>> +    rdesc->of_match = of_match_ptr("regulator");
>>> +    rdesc->type = REGULATOR_VOLTAGE;
>>> +    rdesc->owner = THIS_MODULE;
>>> +    rdesc->ops = &spm_reg_ops;
>>> +
>>> +    rdesc->linear_ranges = drv->reg_data->range;
>>> +    rdesc->n_linear_ranges = 1;
>>> +    rdesc->n_voltages = rdesc->linear_ranges[rdesc->n_linear_ranges - 1].max_sel + 1;
>>> +    rdesc->ramp_delay = drv->reg_data->ramp_delay;
>>> +
>>> +    drv->reg_cpu = spm_get_cpu(dev);
>>> +    dev_dbg(dev, "SAW2 bound to CPU %d\n", drv->reg_cpu);
>>> +
>>> +    /*
>>> +     * Program initial voltage, otherwise registration will also try
>>> +     * setting the voltage, which might result in undervolting the CPU.
>>> +     */
>>> +    drv->volt_sel = DIV_ROUND_UP(drv->reg_data->init_uV - rdesc->min_uV,
>>> +                     rdesc->uV_step);
>>> +    ret = linear_range_get_selector_high(drv->reg_data->range,
>>> +                         drv->reg_data->init_uV,
>>> +                         &drv->volt_sel,
>>> +                         &found);
>>> +    if (ret) {
>>> +        dev_err(dev, "Initial uV value out of bounds\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* Always do the SAW register writes on the corresponding CPU */
>>> +    smp_call_function_single(drv->reg_cpu, drv->reg_data->set_vdd, drv, true);
>>> +
>>> +    rdev = devm_regulator_register(dev, rdesc, &config);
>>> +    if (IS_ERR(rdev)) {
>>> +        dev_err(dev, "failed to register regulator\n");
>>> +        return PTR_ERR(rdev);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +#else
>>> +static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
>>> +{
>>> +    return 0;
>>> +}
>>> +#endif
>>> +
>>>   static const struct of_device_id spm_match_table[] = {
>>>       { .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
>>>         .data = &spm_reg_660_gold_l2 },
>>> @@ -292,6 +492,7 @@ static int spm_dev_probe(struct platform_device *pdev)
>>>           return -ENODEV;
>>>         drv->reg_data = match_id->data;
>>> +    drv->dev = &pdev->dev;
>>>       platform_set_drvdata(pdev, drv);
>>>         /* Write the SPM sequences first.. */
>>> @@ -319,7 +520,7 @@ static int spm_dev_probe(struct platform_device *pdev)
>>>       if (drv->reg_data->reg_offset[SPM_REG_SPM_CTL])
>>>           spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
>>>   -    return 0;
>>> +    return spm_register_regulator(&pdev->dev, drv);
>>>   }
>>>     static struct platform_driver spm_driver = {
>>> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
>>> index 4951f9d8b0bd..9859ebe42003 100644
>>> --- a/include/soc/qcom/spm.h
>>> +++ b/include/soc/qcom/spm.h
>>> @@ -30,11 +30,20 @@ struct spm_reg_data {
>>>       u32 avs_limit;
>>>       u8 seq[MAX_SEQ_DATA];
>>>       u8 start_index[PM_SLEEP_MODE_NR];
>>> +
>>> +    smp_call_func_t set_vdd;
>>> +    /* for now we support only a single range */
>>> +    struct linear_range *range;
>>> +    unsigned int ramp_delay;
>>> +    unsigned int init_uV;
>>>   };
>>>     struct spm_driver_data {
>>>       void __iomem *reg_base;
>>>       const struct spm_reg_data *reg_data;
>>> +    struct device *dev;
>>> +    unsigned int volt_sel;
>>> +    int reg_cpu;
>>>   };
>>>     void spm_set_low_power_mode(struct spm_driver_data *drv,
> 
