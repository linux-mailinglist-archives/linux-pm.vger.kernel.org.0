Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A904658C5E
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiL2Lrq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 06:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiL2Lrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 06:47:45 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04438EE27
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:47:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so27204953lfv.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3wSyovYfn6TpG1xrshvuxNUxztQjBBvVH6jbB0QLB0=;
        b=HAMygTq9ZvSXYh7vCypDbq25GbR14JlpusiWEacfzIpEvNU7MEjOLFCTmU2//lESF0
         +O3VUhAk+a8cyBIbnfUlDunq96a3Nl6vrHVMWJkf87VEaBBpF00J6LpLgZoxr7YRky+/
         k2tRZafTdm2QaEw/FA4mnnLjWkgALgKAFB48wItd71yyzxZpedq5Ywzu2cfdDRZL39Da
         8NKhwj6CBJN2RR5Q5eZ/1kpDnupgHgaKEyHTr0w2Rq4D2ArloeOKbdo9V6BUCIWblbCZ
         vQ7O/JGIYagrhdIIt2ADt6bdME+Q8pVfWlktuph2xppnWbKB0S7dMFNzIFsvWAe2UitV
         UR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3wSyovYfn6TpG1xrshvuxNUxztQjBBvVH6jbB0QLB0=;
        b=xyYigd3n+dClbbCnj1JvbgoNsOOcBjFq44/h4qZ4rDrP8TG38+t/kTwfm9S1MlvTVi
         VBrraLvPpdoKfO6EWe+CNGTysdr2TX0xoKQw4Cv4f9Yr4PjFEdlDrbONbDI+WBNOOgl6
         uGUvGmN4rPuDLrWO+K9Q9DeLrsbp6nAZT14/qXnSfREydV1JTWkhFbsAhETotMwnc8ZY
         +ITccM6MC7Gz2ZVfNJt6cVj0ndMBD7Wph+EV7FvZJsxmq8VvnNmcRAiPH3N0bAXoeeXF
         k/56mqbCBf6VAiL9MRjk7qAvtHlE0cJ237DpSuIhx8m4BYbEgqWmmUuMsQTcaPQdL1wM
         JDJg==
X-Gm-Message-State: AFqh2koBEHWbFxGvGwmjPtF1avdrD8yCIBy063VJQbJmNAH7gfD8Vvst
        mQe+vQKmwvQShokWGmI3oQgXlA==
X-Google-Smtp-Source: AMrXdXs8QZ+HjHmt7zIn4tn56ja/TXCftgt2Zor1UOVxXwx9hh5vKI4F5oNE49FfxhzT0RWfO1xAVA==
X-Received: by 2002:a19:c20d:0:b0:4b5:b18b:8966 with SMTP id l13-20020a19c20d000000b004b5b18b8966mr7029036lfc.49.1672314462296;
        Thu, 29 Dec 2022 03:47:42 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id d12-20020ac25ecc000000b004b561202ea2sm3022894lfq.182.2022.12.29.03.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 03:47:41 -0800 (PST)
Message-ID: <c55a3c92-ae94-56b7-2c2a-a6c7ee72f5c1@linaro.org>
Date:   Thu, 29 Dec 2022 12:47:40 +0100
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprbCi18JG61sw+Ayc14fbHYUVkEHms0vUyVE8QzsH8zJA@mail.gmail.com>
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



On 29.12.2022 12:42, Dmitry Baryshkov wrote:
> On Thu, 29 Dec 2022 at 12:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 29.12.2022 04:00, Dmitry Baryshkov wrote:
>>> Add a unified function using nvmem cells for parsing the calibration
>>> data rather than parsing the calibration blob manually.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  drivers/thermal/qcom/tsens-v0_1.c | 15 ++++++
>>>  drivers/thermal/qcom/tsens-v1.c   | 11 ++++-
>>>  drivers/thermal/qcom/tsens.c      | 76 +++++++++++++++++++++++++++++++
>>>  drivers/thermal/qcom/tsens.h      |  5 ++
>>>  4 files changed, 106 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
>>> index 579028ea48f4..6c9e491f9559 100644
>>> --- a/drivers/thermal/qcom/tsens-v0_1.c
>>> +++ b/drivers/thermal/qcom/tsens-v0_1.c
>>> @@ -229,6 +229,11 @@ static int calibrate_8916(struct tsens_priv *priv)
>>>       u32 p1[5], p2[5];
>>>       int mode = 0;
>>>       u32 *qfprom_cdata, *qfprom_csel;
>>> +     int ret;
>>> +
>>> +     ret = tsens_calibrate_nvmem(priv, 3);
>>> +     if (!ret)
>>> +             return 0;
>>>
>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>       if (IS_ERR(qfprom_cdata))
>>> @@ -286,6 +291,11 @@ static int calibrate_8939(struct tsens_priv *priv)
>>>       int mode = 0;
>>>       u32 *qfprom_cdata;
>>>       u32 cdata[4];
>>> +     int ret;
>>> +
>>> +     ret = tsens_calibrate_common(priv);
>>> +     if (!ret)
>>> +             return 0;
>>>
>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>       if (IS_ERR(qfprom_cdata))
>>> @@ -486,6 +496,11 @@ static int calibrate_9607(struct tsens_priv *priv)
>>>       u32 p1[5], p2[5];
>>>       int mode = 0;
>>>       u32 *qfprom_cdata;
>>> +     int ret;
>>> +
>>> +     ret = tsens_calibrate_common(priv);
>>> +     if (!ret)
>>> +             return 0;
>>>
>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>       if (IS_ERR(qfprom_cdata))
>>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>>> index 83c2853546d0..5bba75a845c5 100644
>>> --- a/drivers/thermal/qcom/tsens-v1.c
>>> +++ b/drivers/thermal/qcom/tsens-v1.c
>>> @@ -143,7 +143,11 @@ static int calibrate_v1(struct tsens_priv *priv)
>>>       u32 p1[10], p2[10];
>>>       u32 mode = 0, lsb = 0, msb = 0;
>>>       u32 *qfprom_cdata;
>>> -     int i;
>>> +     int i, ret;
>>> +
>>> +     ret = tsens_calibrate_common(priv);
>>> +     if (!ret)
>>> +             return 0;
>>>
>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>       if (IS_ERR(qfprom_cdata))
>>> @@ -209,6 +213,11 @@ static int calibrate_8976(struct tsens_priv *priv)
>>>       u32 p1[11], p2[11];
>>>       int mode = 0, tmp = 0;
>>>       u32 *qfprom_cdata;
>>> +     int ret;
>>> +
>>> +     ret = tsens_calibrate_common(priv);
>>> +     if (!ret)
>>> +             return 0;
>>>
>>>       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>>>       if (IS_ERR(qfprom_cdata))
>>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>>> index b191e19df93d..ce568a68de4a 100644
>>> --- a/drivers/thermal/qcom/tsens.c
>>> +++ b/drivers/thermal/qcom/tsens.c
>>> @@ -70,6 +70,82 @@ char *qfprom_read(struct device *dev, const char *cname)
>>>       return ret;
>>>  }
>>>
>>> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
>>> +{
>>> +     u32 mode;
>>> +     u32 base1, base2;
>>> +     u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
>>> +     char name[] = "sXX_pY"; /* s10_p1 */
>>> +     int i, ret;
>>> +
>>> +     if (priv->num_sensors > MAX_SENSORS)
>>> +             return -EINVAL;
>>> +
>>> +     ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
>>> +     if (ret == -ENOENT)
>>> +             dev_warn(priv->dev, "Please migrate to separate nvmem cells for calibration data\n");
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>>> +
>>> +     ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     ret = nvmem_cell_read_variable_le_u32(priv->dev, "base2", &base2);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     for (i = 0; i < priv->num_sensors; i++) {
>>> +             ret = snprintf(name, sizeof(name), "s%d_p1", priv->sensor[i].hw_id);
>> I think you forgot to update the underscore to a hyphen here
>> (unless the nvmem api does some magic internally).
> 
> No. Please see the nvmem-cell-names property of the tsens nodes. It
> uses underscores. Then OF code translates this sX_pY string into an
> index in the nvmem-cells array or phandles. The sX-pY@ZZ node name is
> not used during lookups at all.
Right, I overlooked that!

> 
>>
>> Konrad
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +
>>> +             ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p1[i]);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             ret = snprintf(name, sizeof(name), "s%d_p2", priv->sensor[i].hw_id);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +
>>> +             ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p2[i]);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     switch (mode) {
>>> +     case ONE_PT_CALIB:
>>> +             for (i = 0; i < priv->num_sensors; i++)
>>> +                     p1[i] = p1[i] + (base1 << shift);
>>> +             break;
>>> +     case TWO_PT_CALIB:
>>> +             for (i = 0; i < priv->num_sensors; i++)
>>> +                     p2[i] = (p2[i] + base2) << shift;
>>> +             fallthrough;
>>> +     case ONE_PT_CALIB2:
>>> +             for (i = 0; i < priv->num_sensors; i++)
>>> +                     p1[i] = (p1[i] + base1) << shift;
>>> +             break;
>>> +     default:
>>> +             dev_dbg(priv->dev, "calibrationless mode\n");
This could be a dev_warn, as we usually don't expect it to happen.

Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>>> +             for (i = 0; i < priv->num_sensors; i++) {
>>> +                     p1[i] = 500;
>>> +                     p2[i] = 780;
>>> +             }
>>> +     }
>>> +
>>> +     compute_intercept_slope(priv, p1, p2, mode);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +int tsens_calibrate_common(struct tsens_priv *priv)
>>> +{
>>> +     return tsens_calibrate_nvmem(priv, 2);
>>> +}
>>> +
>>>  /*
>>>   * Use this function on devices where slope and offset calculations
>>>   * depend on calibration data read from qfprom. On others the slope
>>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>>> index 7dd5fc246894..645ae02438fa 100644
>>> --- a/drivers/thermal/qcom/tsens.h
>>> +++ b/drivers/thermal/qcom/tsens.h
>>> @@ -6,6 +6,7 @@
>>>  #ifndef __QCOM_TSENS_H__
>>>  #define __QCOM_TSENS_H__
>>>
>>> +#define NO_PT_CALIB          0x0
>>>  #define ONE_PT_CALIB         0x1
>>>  #define ONE_PT_CALIB2                0x2
>>>  #define TWO_PT_CALIB         0x3
>>> @@ -17,6 +18,8 @@
>>>  #define THRESHOLD_MAX_ADC_CODE       0x3ff
>>>  #define THRESHOLD_MIN_ADC_CODE       0x0
>>>
>>> +#define MAX_SENSORS 16
>>> +
>>>  #include <linux/interrupt.h>
>>>  #include <linux/thermal.h>
>>>  #include <linux/regmap.h>
>>> @@ -582,6 +585,8 @@ struct tsens_priv {
>>>  };
>>>
>>>  char *qfprom_read(struct device *dev, const char *cname);
>>> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift);
>>> +int tsens_calibrate_common(struct tsens_priv *priv);
>>>  void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
>>>  int init_common(struct tsens_priv *priv);
>>>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
> 
> 
> 
