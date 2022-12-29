Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD478658CAA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiL2MXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 07:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiL2MXX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 07:23:23 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F9E1276D
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 04:23:19 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p2so3649549ljn.7
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 04:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbQ1ricBnYFwGoFMywA4gS09hREPfQefn+d4OWWeK1E=;
        b=PSuMRFzxFpaOCUqGqjb6dn9AlnIPllfAEWEmChSfCHQ+VaHbIpknLz/GdDnRj/L0qF
         3dDocXDrzh6ZhotW+LqhCM/HK7ea2TNGbZY77Ghrg4qZLrq/ISnjKlVHVB2Nq5Aqrp5u
         N3kl8Sm28atUVrEi63xGqlHJ3F37nYWwmjXVGGUwPVgvim1RmE8pbeqBxWqzRAAcJBfh
         cM1iW2OgnFhMRFq+302WN7sp0oxBJmyAzKkBaUhq/+rGJz3jO2zPuyivhCFHpT3UCAiL
         A1WY1sGXSzbaucU/mMmDtErkUUjtCH98yPB1TOirte3q9fLWO82MfvasGP81ICoCn4Xb
         Yefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbQ1ricBnYFwGoFMywA4gS09hREPfQefn+d4OWWeK1E=;
        b=IyL/kxA8HL7XaOUwAJvRKjSEG3EBw92NvPB16Y3vh7BaP/uWrxEec4fgIHO+NCdpz/
         Evqr4j0fTr6bavfs3LZRxD5aEpmYnMIbcCN0T0OqMT87kfzej/RSdFEbLfQCj7zuQZnQ
         MEdAtZ9T0jc43u6zzgCzfQ9fos9/qwlmPYXR6nuQNvPobw3uXXTaKEu5pcrQBr03rAnN
         fAYIM34Osk/y7znqWUhLmxluJQIek988fcBJ2dypiuL937v/JWv4EXbXd9dhf12bCKfv
         n+WHxRSvbtGg/lYCLeiO91QE3j10U14dg9K3Xw+YduwEmaO+HccH40I+q/1uxaBnkkzb
         4tQg==
X-Gm-Message-State: AFqh2kpyFEKEpFZY7NFVEIZCiQVBYJwDg9+FA86SwwGPm7eb2PflX04P
        xFpmWHBvpeo2M3/8/baqqHa04A==
X-Google-Smtp-Source: AMrXdXvbi9yHU7aLrfRDQfQRbe6hOWI6WBgoBE5QK4fHX4JgMU+x103TGF63sZqA8Sc6ct859CptlA==
X-Received: by 2002:a2e:8651:0:b0:27b:4eab:6463 with SMTP id i17-20020a2e8651000000b0027b4eab6463mr7344391ljj.8.1672316598191;
        Thu, 29 Dec 2022 04:23:18 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05651c168900b0027fdb26e4b1sm131015ljb.91.2022.12.29.04.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 04:23:17 -0800 (PST)
Message-ID: <ecd974a7-6e46-b8c4-8c3d-70712a13400c@linaro.org>
Date:   Thu, 29 Dec 2022 13:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 09/20] thermal/drivers/tsens: Support using nvmem cells
 for calibration data
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-10-dmitry.baryshkov@linaro.org>
 <e8faca42-090b-6103-603d-06caa7476787@linaro.org>
 <CAA8EJprbCi18JG61sw+Ayc14fbHYUVkEHms0vUyVE8QzsH8zJA@mail.gmail.com>
 <c55a3c92-ae94-56b7-2c2a-a6c7ee72f5c1@linaro.org>
 <CAA8EJpoCT1fDb-aeeq=V28HWq=wkcTN9tVC98y0iCDvdk8JKkA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpoCT1fDb-aeeq=V28HWq=wkcTN9tVC98y0iCDvdk8JKkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 29.12.2022 12:52, Dmitry Baryshkov wrote:
> On Thu, 29 Dec 2022 at 13:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>> On 29.12.2022 12:42, Dmitry Baryshkov wrote:
>>> On Thu, 29 Dec 2022 at 12:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>> On 29.12.2022 04:00, Dmitry Baryshkov wrote:
>>>>> Add a unified function using nvmem cells for parsing the calibration
>>>>> data rather than parsing the calibration blob manually.
>>>>>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>  drivers/thermal/qcom/tsens-v0_1.c | 15 ++++++
>>>>>  drivers/thermal/qcom/tsens-v1.c   | 11 ++++-
>>>>>  drivers/thermal/qcom/tsens.c      | 76 +++++++++++++++++++++++++++++++
>>>>>  drivers/thermal/qcom/tsens.h      |  5 ++
>>>>>  4 files changed, 106 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
>>>>> index 579028ea48f4..6c9e491f9559 100644
>>>>> --- a/drivers/thermal/qcom/tsens-v0_1.c
>>>>> +++ b/drivers/thermal/qcom/tsens-v0_1.c
>>>>> @@ -229,6 +229,11 @@ static int calibrate_8916(struct tsens_priv *priv)
>>>>>       u32 p1[5], p2[5];
>>>>>       int mode = 0;
>>>>>       u32 *qfprom_cdata, *qfprom_csel;
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = tsens_calibrate_nvmem(priv, 3);
>>>>> +     if (!ret)
>>>>> +             return 0;
>>>>>
>>>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>>>       if (IS_ERR(qfprom_cdata))
>>>>> @@ -286,6 +291,11 @@ static int calibrate_8939(struct tsens_priv *priv)
>>>>>       int mode = 0;
>>>>>       u32 *qfprom_cdata;
>>>>>       u32 cdata[4];
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = tsens_calibrate_common(priv);
>>>>> +     if (!ret)
>>>>> +             return 0;
>>>>>
>>>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>>>       if (IS_ERR(qfprom_cdata))
>>>>> @@ -486,6 +496,11 @@ static int calibrate_9607(struct tsens_priv *priv)
>>>>>       u32 p1[5], p2[5];
>>>>>       int mode = 0;
>>>>>       u32 *qfprom_cdata;
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = tsens_calibrate_common(priv);
>>>>> +     if (!ret)
>>>>> +             return 0;
>>>>>
>>>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>>>       if (IS_ERR(qfprom_cdata))
>>>>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>>>>> index 83c2853546d0..5bba75a845c5 100644
>>>>> --- a/drivers/thermal/qcom/tsens-v1.c
>>>>> +++ b/drivers/thermal/qcom/tsens-v1.c
>>>>> @@ -143,7 +143,11 @@ static int calibrate_v1(struct tsens_priv *priv)
>>>>>       u32 p1[10], p2[10];
>>>>>       u32 mode = 0, lsb = 0, msb = 0;
>>>>>       u32 *qfprom_cdata;
>>>>> -     int i;
>>>>> +     int i, ret;
>>>>> +
>>>>> +     ret = tsens_calibrate_common(priv);
>>>>> +     if (!ret)
>>>>> +             return 0;
>>>>>
>>>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>>>       if (IS_ERR(qfprom_cdata))
>>>>> @@ -209,6 +213,11 @@ static int calibrate_8976(struct tsens_priv *priv)
>>>>>       u32 p1[11], p2[11];
>>>>>       int mode = 0, tmp = 0;
>>>>>       u32 *qfprom_cdata;
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = tsens_calibrate_common(priv);
>>>>> +     if (!ret)
>>>>> +             return 0;
>>>>>
>>>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>>>       if (IS_ERR(qfprom_cdata))
>>>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>>>>> index b191e19df93d..ce568a68de4a 100644
>>>>> --- a/drivers/thermal/qcom/tsens.c
>>>>> +++ b/drivers/thermal/qcom/tsens.c
>>>>> @@ -70,6 +70,82 @@ char *qfprom_read(struct device *dev, const char *cname)
>>>>>       return ret;
>>>>>  }
>>>>>
>>>>> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
>>>>> +{
>>>>> +     u32 mode;
>>>>> +     u32 base1, base2;
>>>>> +     u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
>>>>> +     char name[] = "sXX_pY"; /* s10_p1 */
>>>>> +     int i, ret;
>>>>> +
>>>>> +     if (priv->num_sensors > MAX_SENSORS)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
>>>>> +     if (ret == -ENOENT)
>>>>> +             dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>> +     dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>>>>> +
>>>>> +     ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>> +     ret = nvmem_cell_read_variable_le_u32(priv->dev, "base2", &base2);
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>> +     for (i = 0; i < priv->num_sensors; i++) {
>>>>> +             ret = snprintf(name, sizeof(name), "s%d_p1", priv->sensor[i].hw_id);
>>>> I think you forgot to update the underscore to a hyphen here
>>>> (unless the nvmem api does some magic internally).
>>>
>>> No. Please see the nvmem-cell-names property of the tsens nodes. It
>>> uses underscores. Then OF code translates this sX_pY string into an
>>> index in the nvmem-cells array or phandles. The sX-pY@ZZ node name is
>>> not used during lookups at all.
>> Right, I overlooked that!
>>
>>>
>>>>
>>>> Konrad
>>>>> +             if (ret < 0)
>>>>> +                     return ret;
>>>>> +
>>>>> +             ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p1[i]);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +
>>>>> +             ret = snprintf(name, sizeof(name), "s%d_p2", priv->sensor[i].hw_id);
>>>>> +             if (ret < 0)
>>>>> +                     return ret;
>>>>> +
>>>>> +             ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p2[i]);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +     }
>>>>> +
>>>>> +     switch (mode) {
>>>>> +     case ONE_PT_CALIB:
>>>>> +             for (i = 0; i < priv->num_sensors; i++)
>>>>> +                     p1[i] = p1[i] + (base1 << shift);
>>>>> +             break;
>>>>> +     case TWO_PT_CALIB:
>>>>> +             for (i = 0; i < priv->num_sensors; i++)
>>>>> +                     p2[i] = (p2[i] + base2) << shift;
>>>>> +             fallthrough;
>>>>> +     case ONE_PT_CALIB2:
>>>>> +             for (i = 0; i < priv->num_sensors; i++)
>>>>> +                     p1[i] = (p1[i] + base1) << shift;
>>>>> +             break;
>>>>> +     default:
>>>>> +             dev_dbg(priv->dev, "calibrationless mode\n");
>> This could be a dev_warn, as we usually don't expect it to happen.
> 
> I'm not so sure here. Current code handles this case without any
> warnings, as one of the expected cases So, I don't think the rework
> should start emitting warnings.
Right, perhaps that's something to consider at a different time.

Konrad
> 
>> Other than that:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Konrad
>>>>> +             for (i = 0; i < priv->num_sensors; i++) {
>>>>> +                     p1[i] = 500;
>>>>> +                     p2[i] = 780;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     compute_intercept_slope(priv, p1, p2, mode);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +int tsens_calibrate_common(struct tsens_priv *priv)
>>>>> +{
>>>>> +     return tsens_calibrate_nvmem(priv, 2);
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * Use this function on devices where slope and offset calculations
>>>>>   * depend on calibration data read from qfprom. On others the slope
>>>>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>>>>> index 7dd5fc246894..645ae02438fa 100644
>>>>> --- a/drivers/thermal/qcom/tsens.h
>>>>> +++ b/drivers/thermal/qcom/tsens.h
>>>>> @@ -6,6 +6,7 @@
>>>>>  #ifndef __QCOM_TSENS_H__
>>>>>  #define __QCOM_TSENS_H__
>>>>>
>>>>> +#define NO_PT_CALIB          0x0
>>>>>  #define ONE_PT_CALIB         0x1
>>>>>  #define ONE_PT_CALIB2                0x2
>>>>>  #define TWO_PT_CALIB         0x3
>>>>> @@ -17,6 +18,8 @@
>>>>>  #define THRESHOLD_MAX_ADC_CODE       0x3ff
>>>>>  #define THRESHOLD_MIN_ADC_CODE       0x0
>>>>>
>>>>> +#define MAX_SENSORS 16
>>>>> +
>>>>>  #include <linux/interrupt.h>
>>>>>  #include <linux/thermal.h>
>>>>>  #include <linux/regmap.h>
>>>>> @@ -582,6 +585,8 @@ struct tsens_priv {
>>>>>  };
>>>>>
>>>>>  char *qfprom_read(struct device *dev, const char *cname);
>>>>> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
>>>>> +int tsens_calibrate_common(struct tsens_priv *priv);
>>>>>  void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
>>>>>  int init_common(struct tsens_priv *priv);
>>>>>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>>>
>>>
>>>
> 
> 
> 
