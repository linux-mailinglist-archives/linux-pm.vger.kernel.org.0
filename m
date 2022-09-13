Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF05B7C76
	for <lists+linux-pm@lfdr.de>; Tue, 13 Sep 2022 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiIMVHK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Sep 2022 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIMVHJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2022 17:07:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AD96170F
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 14:07:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j13so1142494ljh.4
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=db6jhugLmxE55A+/ymDHt7+Ug/NDn30xnxeXJYgKLnU=;
        b=Cy8jbgkaLCJx75T2VRoT1IbL0o1452xZZ//DICii3BfVkjcA+R6yPYnaN8QQftePNH
         UYlB35mkVQIuqO3jEcfyJw5dbb+SX//WxISRH3jCuPZdqwstj3YQDfPBHRHAt2jYmUJt
         hGdvRgtV3jM2mVc70lQf7Q0ANasEBgqPdQW22fE4Z4LV84UJvKMGngbviVq6mm4WYUzA
         hr6LxG087XugzrOkuv3DuUgi+G37JzHwDDJeI1dPZTXenuKlj0SB4pQblj2OYzpMnqeN
         xspc3FF6ZMxYuSfhksdY7yLBS7oORVBmD+JjZeYtJncfU8+H3SefW9W4L8FIBHBIyHbZ
         hLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=db6jhugLmxE55A+/ymDHt7+Ug/NDn30xnxeXJYgKLnU=;
        b=a6jrBPeiX9O7EtNewD3fhOUdZrs9sHciFuVVivWfzTouwliYyoQSMZJ7M2Cuc00FwM
         Vc2cjj1h5bjRm2ULQKLdmxYNhR3kY7U+pTisRnR4ROnQIQuTz8o/Hx6M3YPQAZWPYXlO
         I8qICWwbXTMWdGf7OO/7IqpvPQV8r04xwTXM3tMQZw19D4z9WJRxoUNdZBPqxSaoATmy
         +vO012uC6i5/Lv5Hy6J/BpSDSQv+yyRvhO+nr+u2c77SaH3wYgogU+YVehPRHkqnWCMA
         Wa/VZlTYD7vUPDkGDJ22h+M0Bu1Tuftizid8FGsTa31O06LJk224MSWxL1yzYzfrOca+
         4itQ==
X-Gm-Message-State: ACgBeo1RAd/fq/OGeSZY1vJM9zLtXNaRbJvTGHEwaH7XYsUbenWJlIYf
        ZYHmapbM548P5uF3C5G5i+c5Vg==
X-Google-Smtp-Source: AA6agR7cYSBsV1KgiAid4kpNw5OD6nXEWqWSpv3RzuJl0MkQJrfqXvgv8QUrdBn1FPsozd+Et2JQIQ==
X-Received: by 2002:a2e:bd12:0:b0:264:7373:3668 with SMTP id n18-20020a2ebd12000000b0026473733668mr9080468ljq.18.1663103224929;
        Tue, 13 Sep 2022 14:07:04 -0700 (PDT)
Received: from [127.0.0.1] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h12-20020a05651c124c00b0026bda31c10fsm1915792ljh.61.2022.09.13.14.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 14:07:04 -0700 (PDT)
Date:   Wed, 14 Sep 2022 00:07:00 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_02/10=5D_thermal/drivers/tsens=3A_?= =?US-ASCII?Q?Support_using_nvmem_cells_for_calibration_data?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHLCerPhxGEUfpabu6dpnrkSL0Aab7qrthaffWn69Wz_z8aFDQ@mail.gmail.com>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org> <20220910124701.4060321-3-dmitry.baryshkov@linaro.org> <CAHLCerPhxGEUfpabu6dpnrkSL0Aab7qrthaffWn69Wz_z8aFDQ@mail.gmail.com>
Message-ID: <26FAA9B7-F4D7-4668-ABD8-A56BCEC817BB@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13 September 2022 22:18:48 GMT+03:00, Amit Kucheria <amitk@kernel=2Eorg=
> wrote:
>Hi Dmitry,
>
>I like this clean up=2E
>
>On Sat, Sep 10, 2022 at 6:17 PM Dmitry Baryshkov
><dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>>
>> Add a unified function using nvmem cells for parsing the calibration
>> data rather than parsing the calibration blob manually=2E
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> ---
>>  drivers/thermal/qcom/tsens-v0_1=2Ec | 15 ++++++++
>>  drivers/thermal/qcom/tsens-v1=2Ec   |  6 ++-
>>  drivers/thermal/qcom/tsens=2Ec      | 62 +++++++++++++++++++++++++++++=
++
>>  drivers/thermal/qcom/tsens=2Eh      |  4 ++
>>  4 files changed, 86 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v0_1=2Ec b/drivers/thermal/qcom=
/tsens-v0_1=2Ec
>> index f136cb350238=2E=2E2974eea578f4 100644
>> --- a/drivers/thermal/qcom/tsens-v0_1=2Ec
>> +++ b/drivers/thermal/qcom/tsens-v0_1=2Ec
>> @@ -229,6 +229,11 @@ static int calibrate_8916(struct tsens_priv *priv)
>>         u32 p1[5], p2[5];
>>         int mode =3D 0;
>>         u32 *qfprom_cdata, *qfprom_csel;
>> +       int ret;
>> +
>> +       ret =3D tsens_calibrate_nvmem(priv, 3);
>> +       if (!ret)
>> +               return 0;
>>
>>         qfprom_cdata =3D (u32 *)qfprom_read(priv->dev, "calib");
>>         if (IS_ERR(qfprom_cdata))
>> @@ -286,6 +291,11 @@ static int calibrate_8939(struct tsens_priv *priv)
>>         int mode =3D 0;
>>         u32 *qfprom_cdata;
>>         u32 cdata[6];
>> +       int ret;
>> +
>> +       ret =3D tsens_calibrate_nvmem(priv, 2);
>> +       if (!ret)
>> +               return 0;
>>
>>         qfprom_cdata =3D (u32 *)qfprom_read(priv->dev, "calib");
>>         if (IS_ERR(qfprom_cdata))
>> @@ -491,6 +501,11 @@ static int calibrate_9607(struct tsens_priv *priv)
>>         u32 p1[5], p2[5];
>>         int mode =3D 0;
>>         u32 *qfprom_cdata;
>> +       int ret;
>> +
>> +       ret =3D tsens_calibrate_nvmem(priv, 2);
>> +       if (!ret)
>> +               return 0;
>>
>>         qfprom_cdata =3D (u32 *)qfprom_read(priv->dev, "calib");
>>         if (IS_ERR(qfprom_cdata))
>> diff --git a/drivers/thermal/qcom/tsens-v1=2Ec b/drivers/thermal/qcom/t=
sens-v1=2Ec
>> index 573e261ccca7=2E=2E868d7b4c9e36 100644
>> --- a/drivers/thermal/qcom/tsens-v1=2Ec
>> +++ b/drivers/thermal/qcom/tsens-v1=2Ec
>> @@ -172,7 +172,11 @@ static int calibrate_v1(struct tsens_priv *priv)
>>         u32 p1[10], p2[10];
>>         u32 mode =3D 0, lsb =3D 0, msb =3D 0;
>>         u32 *qfprom_cdata;
>> -       int i;
>> +       int i, ret;
>> +
>> +       ret =3D tsens_calibrate_nvmem(priv, 2);
>> +       if (!ret)
>> +               return 0;
>>
>>         qfprom_cdata =3D (u32 *)qfprom_read(priv->dev, "calib");
>>         if (IS_ERR(qfprom_cdata))
>> diff --git a/drivers/thermal/qcom/tsens=2Ec b/drivers/thermal/qcom/tsen=
s=2Ec
>> index e49f58e83513=2E=2E8331b924325a 100644
>> --- a/drivers/thermal/qcom/tsens=2Ec
>> +++ b/drivers/thermal/qcom/tsens=2Ec
>> @@ -70,6 +70,68 @@ char *qfprom_read(struct device *dev, const char *cn=
ame)
>>         return ret;
>>  }
>>
>> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
>> +{
>> +       u32 mode;
>> +       u32 base1, base2;
>> +       u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
>> +       char name[] =3D "sX_pY";
>> +       int i, ret;
>> +
>> +       if (priv->num_sensors > MAX_SENSORS)
>> +               return -EINVAL;
>> +
>> +       ret =3D nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mod=
e);
>> +       if (ret =3D=3D -ENOENT)
>> +               dev_warn(priv->dev, "Please migrate to sepate nvmem cel=
ls for calibration data\n");
>
>typo: separate

Ack=2E


>
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>> +
>> +       ret =3D nvmem_cell_read_variable_le_u32(priv->dev, "base1", &ba=
se1);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret =3D nvmem_cell_read_variable_le_u32(priv->dev, "base2", &ba=
se2);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       for (i =3D 0; i < priv->num_sensors; i++) {
>> +               ret =3D snprintf(name, sizeof(name), "s%d_p1", i);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               ret =3D nvmem_cell_read_variable_le_u32(priv->dev, name=
, &p1[i]);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               p1[i] =3D (base1 + p1[i]) << shift;
>> +
>> +               ret =3D snprintf(name, sizeof(name), "s%d_p2", i);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               ret =3D nvmem_cell_read_variable_le_u32(priv->dev, name=
, &p2[i]);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               p2[i] =3D (base2 + p2[i]) << shift;
>
>Have you verified that the p1 and p2 arrays end up with identical
>values before and after this conversion?

Yes=2E I have verified that the calibration values are unchanged on db410c=
(apq8016, v0_1) and qcs404-evb (v1)=2E


>
>
>> +       }
>> +
>> +       if (mode =3D=3D NO_PT_CALIB) {
>> +               dev_dbg(priv->dev, "calibrationless mode\n");
>> +               for (i =3D 0; i < priv->num_sensors; i++) {
>> +                       p1[i] =3D 500;
>> +                       p2[i] =3D 780;
>> +               }
>> +       }
>> +
>> +       compute_intercept_slope(priv, p1, p2, mode);
>> +
>> +       return 0;
>> +}
>> +
>>  /*

--=20
With best wishes
Dmitry
