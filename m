Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534665219A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiLTNfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 08:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLTNfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 08:35:05 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1418E0C
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 05:35:02 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3e45d25de97so168813847b3.6
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CVRvy3Zwd4BHRC6erjG/yd9oXmYCOUUBiEqJLMzBd4k=;
        b=u+eL2eSz4Bv5CA81UcA9onoJs2UyrheC7TFg/EQMmrB5+GDUgDY6CxuQS25L2RK8M7
         TclTpg4H+piUauq31FzZtF5j02ZjuhzkioEJfOtuvKEWHJW0jvYxBGfNOtasOb9saZsN
         MlekkM0NqdpKtZw+gVEYu6Am858C7cquyJ/bGFDS4TSQHw8qmeFQO9ZfrcvMxYfnLh/y
         soby5bno42RVEzpAd/UlcPGjiw6EpNE3zQYzkjBZJ7RevpGav9fX2rQbZ1TMX2J9q6mY
         5e2spt+3NASccNxl3AaxpmUK73XBls38Tx/gpaOmLn4jha0YeCAMW4s4aWCeGOYh9MMv
         BkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVRvy3Zwd4BHRC6erjG/yd9oXmYCOUUBiEqJLMzBd4k=;
        b=Xsu0CJaL94mDHOhNG5BNBnT5BJ5m084gSzKAP2zG7AP0gZQqEPyqlX4wT5ye8gOeeM
         MzpjLKwJMOP6DMBSb49YdVX1spTWeDPiF2rW0T1pBj5q4GN5ua903ImlE/SefyLTztfm
         AQniNYZjeVJRrKz/Xm/Op/H9jxzVO0J2v2U6vpxiw9G40t2Dqb30Aq3gio63NIkAsTxN
         umgNGpMXgES2s3Cs4CyUHMgmUdaVRnWV03lSfnxXxWZyQ1wMRvGvMwKhvSgrMRIGiD4z
         B9GWI/9+iUA8ZjAu5uAxwOomvXu1GBr9LSiCJPUAAV0cTjn+Dh3ZfEaLRtFU02ty+i9b
         s8nA==
X-Gm-Message-State: AFqh2koLlDr4A3A5xm5lSqvdS3Z65uGG3V0bnc5/PwqwegRswgZUE81P
        VYxL2XzHlqMAXKjQBCAUaNepSgxvcNSCfcTFw77x5kBoYPrj/1FVZVw=
X-Google-Smtp-Source: AMrXdXtbbN+GFvcN2ctLBAsYtbrL/dd2+KyKV9S2iXx4H4AEc1uFmw89+imboCoSKXx57WJj4s8ByfXY3XP4T/8ade0=
X-Received: by 2002:a0d:d643:0:b0:370:4c23:eacc with SMTP id
 y64-20020a0dd643000000b003704c23eaccmr1115777ywd.127.1671543301820; Tue, 20
 Dec 2022 05:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-11-dmitry.baryshkov@linaro.org> <78a29328-a53b-7a09-c228-b7c373683ca4@linaro.org>
In-Reply-To: <78a29328-a53b-7a09-c228-b7c373683ca4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 20 Dec 2022 15:34:50 +0200
Message-ID: <CAA8EJprN-oppse9Ktoxyk6MUhu7vk4pJ84tv5XyviyG+ODa0=A@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Dec 2022 at 12:24, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 20.12.2022 03:47, Dmitry Baryshkov wrote:
> > There is no dtsi file for msm8976 in the kernel sources.
> This is not true :/
>
> But it has just been merged, if we get there fast, we can get
> this patch going *and* convert the node to use fuses..
> Unless breaking a platform that's only in linux-next would be
> an issue.. Maybe we could prettyplease ask Bjorn to send a
> -fixes pull with a "remove tsens node from 8976" commit?
> Not sure if it's too late or not...

Ugh. It's a pity that I missed the dtsi. Bjorn, Angelo, Marijn, any thoughts?

> Konrad
> Drop the
> > compatibility with unofficial dtsi and remove support for handling the
> > single-cell calibration data on msm8976.
> >
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-v1.c | 126 +-------------------------------
> >  1 file changed, 2 insertions(+), 124 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> > index 89955522041d..9151c1043a11 100644
> > --- a/drivers/thermal/qcom/tsens-v1.c
> > +++ b/drivers/thermal/qcom/tsens-v1.c
> > @@ -21,63 +21,6 @@
> >  #define TM_HIGH_LOW_INT_STATUS_OFF           0x0088
> >  #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF     0x0090
> >
> > -/* eeprom layout data for msm8956/76 (v1) */
> > -#define MSM8976_BASE0_MASK   0xff
> > -#define MSM8976_BASE1_MASK   0xff
> > -#define MSM8976_BASE1_SHIFT  8
> > -
> > -#define MSM8976_S0_P1_MASK   0x3f00
> > -#define MSM8976_S1_P1_MASK   0x3f00000
> > -#define MSM8976_S2_P1_MASK   0x3f
> > -#define MSM8976_S3_P1_MASK   0x3f000
> > -#define MSM8976_S4_P1_MASK   0x3f00
> > -#define MSM8976_S5_P1_MASK   0x3f00000
> > -#define MSM8976_S6_P1_MASK   0x3f
> > -#define MSM8976_S7_P1_MASK   0x3f000
> > -#define MSM8976_S8_P1_MASK   0x1f8
> > -#define MSM8976_S9_P1_MASK   0x1f8000
> > -#define MSM8976_S10_P1_MASK  0xf8000000
> > -#define MSM8976_S10_P1_MASK_1        0x1
> > -
> > -#define MSM8976_S0_P2_MASK   0xfc000
> > -#define MSM8976_S1_P2_MASK   0xfc000000
> > -#define MSM8976_S2_P2_MASK   0xfc0
> > -#define MSM8976_S3_P2_MASK   0xfc0000
> > -#define MSM8976_S4_P2_MASK   0xfc000
> > -#define MSM8976_S5_P2_MASK   0xfc000000
> > -#define MSM8976_S6_P2_MASK   0xfc0
> > -#define MSM8976_S7_P2_MASK   0xfc0000
> > -#define MSM8976_S8_P2_MASK   0x7e00
> > -#define MSM8976_S9_P2_MASK   0x7e00000
> > -#define MSM8976_S10_P2_MASK  0x7e
> > -
> > -#define MSM8976_S0_P1_SHIFT  8
> > -#define MSM8976_S1_P1_SHIFT  20
> > -#define MSM8976_S2_P1_SHIFT  0
> > -#define MSM8976_S3_P1_SHIFT  12
> > -#define MSM8976_S4_P1_SHIFT  8
> > -#define MSM8976_S5_P1_SHIFT  20
> > -#define MSM8976_S6_P1_SHIFT  0
> > -#define MSM8976_S7_P1_SHIFT  12
> > -#define MSM8976_S8_P1_SHIFT  3
> > -#define MSM8976_S9_P1_SHIFT  15
> > -#define MSM8976_S10_P1_SHIFT 27
> > -#define MSM8976_S10_P1_SHIFT_1       0
> > -
> > -#define MSM8976_S0_P2_SHIFT  14
> > -#define MSM8976_S1_P2_SHIFT  26
> > -#define MSM8976_S2_P2_SHIFT  6
> > -#define MSM8976_S3_P2_SHIFT  18
> > -#define MSM8976_S4_P2_SHIFT  14
> > -#define MSM8976_S5_P2_SHIFT  26
> > -#define MSM8976_S6_P2_SHIFT  6
> > -#define MSM8976_S7_P2_SHIFT  18
> > -#define MSM8976_S8_P2_SHIFT  9
> > -#define MSM8976_S9_P2_SHIFT  21
> > -#define MSM8976_S10_P2_SHIFT 1
> > -
> > -#define MSM8976_CAL_SEL_MASK 0x3
> > -
> >  /* eeprom layout data for qcs404/405 (v1) */
> >  #define BASE0_MASK   0x000007f8
> >  #define BASE1_MASK   0x0007f800
> > @@ -207,71 +150,6 @@ static int calibrate_v1(struct tsens_priv *priv)
> >       return 0;
> >  }
> >
> > -static int calibrate_8976(struct tsens_priv *priv)
> > -{
> > -     int base0 = 0, base1 = 0, i;
> > -     u32 p1[11], p2[11];
> > -     int mode = 0, tmp = 0;
> > -     u32 *qfprom_cdata;
> > -
> > -     qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> > -     if (IS_ERR(qfprom_cdata))
> > -             return PTR_ERR(qfprom_cdata);
> > -
> > -     mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
> > -     dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> > -
> > -     switch (mode) {
> > -     case TWO_PT_CALIB:
> > -             base1 = (qfprom_cdata[2] & MSM8976_BASE1_MASK) >> MSM8976_BASE1_SHIFT;
> > -             p2[0] = (qfprom_cdata[0] & MSM8976_S0_P2_MASK) >> MSM8976_S0_P2_SHIFT;
> > -             p2[1] = (qfprom_cdata[0] & MSM8976_S1_P2_MASK) >> MSM8976_S1_P2_SHIFT;
> > -             p2[2] = (qfprom_cdata[1] & MSM8976_S2_P2_MASK) >> MSM8976_S2_P2_SHIFT;
> > -             p2[3] = (qfprom_cdata[1] & MSM8976_S3_P2_MASK) >> MSM8976_S3_P2_SHIFT;
> > -             p2[4] = (qfprom_cdata[2] & MSM8976_S4_P2_MASK) >> MSM8976_S4_P2_SHIFT;
> > -             p2[5] = (qfprom_cdata[2] & MSM8976_S5_P2_MASK) >> MSM8976_S5_P2_SHIFT;
> > -             p2[6] = (qfprom_cdata[3] & MSM8976_S6_P2_MASK) >> MSM8976_S6_P2_SHIFT;
> > -             p2[7] = (qfprom_cdata[3] & MSM8976_S7_P2_MASK) >> MSM8976_S7_P2_SHIFT;
> > -             p2[8] = (qfprom_cdata[4] & MSM8976_S8_P2_MASK) >> MSM8976_S8_P2_SHIFT;
> > -             p2[9] = (qfprom_cdata[4] & MSM8976_S9_P2_MASK) >> MSM8976_S9_P2_SHIFT;
> > -             p2[10] = (qfprom_cdata[5] & MSM8976_S10_P2_MASK) >> MSM8976_S10_P2_SHIFT;
> > -
> > -             for (i = 0; i < priv->num_sensors; i++)
> > -                     p2[i] = ((base1 + p2[i]) << 2);
> > -             fallthrough;
> > -     case ONE_PT_CALIB2:
> > -             base0 = qfprom_cdata[0] & MSM8976_BASE0_MASK;
> > -             p1[0] = (qfprom_cdata[0] & MSM8976_S0_P1_MASK) >> MSM8976_S0_P1_SHIFT;
> > -             p1[1] = (qfprom_cdata[0] & MSM8976_S1_P1_MASK) >> MSM8976_S1_P1_SHIFT;
> > -             p1[2] = (qfprom_cdata[1] & MSM8976_S2_P1_MASK) >> MSM8976_S2_P1_SHIFT;
> > -             p1[3] = (qfprom_cdata[1] & MSM8976_S3_P1_MASK) >> MSM8976_S3_P1_SHIFT;
> > -             p1[4] = (qfprom_cdata[2] & MSM8976_S4_P1_MASK) >> MSM8976_S4_P1_SHIFT;
> > -             p1[5] = (qfprom_cdata[2] & MSM8976_S5_P1_MASK) >> MSM8976_S5_P1_SHIFT;
> > -             p1[6] = (qfprom_cdata[3] & MSM8976_S6_P1_MASK) >> MSM8976_S6_P1_SHIFT;
> > -             p1[7] = (qfprom_cdata[3] & MSM8976_S7_P1_MASK) >> MSM8976_S7_P1_SHIFT;
> > -             p1[8] = (qfprom_cdata[4] & MSM8976_S8_P1_MASK) >> MSM8976_S8_P1_SHIFT;
> > -             p1[9] = (qfprom_cdata[4] & MSM8976_S9_P1_MASK) >> MSM8976_S9_P1_SHIFT;
> > -             p1[10] = (qfprom_cdata[4] & MSM8976_S10_P1_MASK) >> MSM8976_S10_P1_SHIFT;
> > -             tmp = (qfprom_cdata[5] & MSM8976_S10_P1_MASK_1) << MSM8976_S10_P1_SHIFT_1;
> > -             p1[10] |= tmp;
> > -
> > -             for (i = 0; i < priv->num_sensors; i++)
> > -                     p1[i] = (((base0) + p1[i]) << 2);
> > -             break;
> > -     default:
> > -             for (i = 0; i < priv->num_sensors; i++) {
> > -                     p1[i] = 500;
> > -                     p2[i] = 780;
> > -             }
> > -             break;
> > -     }
> > -
> > -     compute_intercept_slope(priv, p1, p2, mode);
> > -     kfree(qfprom_cdata);
> > -
> > -     return 0;
> > -}
> > -
> >  /* v1.x: msm8956,8976,qcs404,405 */
> >
> >  static struct tsens_features tsens_v1_feat = {
> > @@ -370,7 +248,7 @@ struct tsens_plat_data data_tsens_v1 = {
> >
> >  static const struct tsens_ops ops_8956 = {
> >       .init           = init_8956,
> > -     .calibrate      = calibrate_8976,
> > +     .calibrate      = tsens_calibrate_common,
> >       .get_temp       = get_temp_tsens_valid,
> >  };
> >
> > @@ -383,7 +261,7 @@ struct tsens_plat_data data_8956 = {
> >
> >  static const struct tsens_ops ops_8976 = {
> >       .init           = init_common,
> > -     .calibrate      = calibrate_8976,
> > +     .calibrate      = tsens_calibrate_common,
> >       .get_temp       = get_temp_tsens_valid,
> >  };
> >



-- 
With best wishes
Dmitry
