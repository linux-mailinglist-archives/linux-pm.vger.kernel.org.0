Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843AB3A15A0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhFINdJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 09:33:09 -0400
Received: from m-r1.th.seeweb.it ([5.144.164.170]:59609 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhFINdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 09:33:09 -0400
Received: from [192.168.1.101] (83.6.168.161.neoplus.adsl.tpnet.pl [83.6.168.161])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CD186200EB;
        Wed,  9 Jun 2021 15:31:11 +0200 (CEST)
Subject: Re: [PATCH RFC 1/2] thermal: qcom: tsens-v1: Add support for MSM8994
 TSENS
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209195346.457803-1-konrad.dybcio@somainline.org>
 <a4b76d12-a659-da87-7d97-9b34e3cf7edf@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <ce5cac52-473c-a30a-104d-0a175e8848db@somainline.org>
Date:   Wed, 9 Jun 2021 15:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a4b76d12-a659-da87-7d97-9b34e3cf7edf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,


> Please split binding and code into two separate patches.

It's a oneliner, but I might as well.

 

> That deserves a cartdrige with a good explanation of why this function
> is doing all this. Without enough details, it is hard to review the code.

I don't really know *why* it's doing all of this. Qualcomm doesn't share any documentation.

It' just based on the freely-available msm-3.10 kernel driver. Probably just a HW specific.



>> +static void compute_intercept_slope_8994(struct tsens_priv *priv,
>> +			      u32 *base0, u32 *base1, u32 *p, u32 mode)
>> +{
>> +	int adc_code_of_tempx, i, num, den;
>> +
>> +	for (i = 0; i < priv->num_sensors; i++) {
>> +		dev_dbg(priv->dev,
>> +			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
>> +			__func__, i, base0[i], base1[i]);
>> +
>> +		priv->sensor[i].slope = SLOPE_DEFAULT;
>> +		if (mode == TWO_PT_CALIB) {
>> +			/*
>> +			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
>> +			 *	temp_120_degc - temp_30_degc (x2 - x1)
>> +			 */
>> +			num = base1[i] - base0[i];
> As the caller of the function is copying the value of base[0] to the
> entire array, whatever 'i', base[i] == base[0], so the parameters can be
> replaced by a single int.
>
> Then the code becomes:
>
> 	num = base1 - base0;
> 	num *= SLOPE_FACTOR;
> 	den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
> 	slope = num / den;
>
> There is no change in the values, so 'slope' can be precomputed before
> the loop. We end up with:
>
> 	int adc_code_of_tempx, i, num, den;
> 	int slope;
>
> 	/*
> 	 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
> 	 *	temp_120_degc - temp_30_degc (x2 - x1)
> 	 */
> 	num = base1 - base0;
> 	num *= SLOPE_FACTOR;
> 	den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
> 	slope = num / den;
>
> 	for (i = 0; i < priv->num_sensors; i++) {
>
> 		priv->sensor[i].slope = mode == TWO_PT_CALIB ? slope :
> 			SLOPE_DEFAULT;

That's sounds very good. I did not think of this approach, but I will incorporate it

into the next revision.



>> +		adc_code_of_tempx = base0[i] + p[i];
>> +
>> +		priv->sensor[i].offset = (adc_code_of_tempx * SLOPE_FACTOR) -
>> +				(CAL_DEGC_PT1 *	priv->sensor[i].slope);
>> +		dev_dbg(priv->dev, "%s: offset:%d\n", __func__,
>> +			priv->sensor[i].offset);
>> +	}
>> +}
>> +
>>  static int calibrate_v1(struct tsens_priv *priv)
>>  {
>>  	u32 base0 = 0, base1 = 0;
>> @@ -297,14 +421,143 @@ static int calibrate_8976(struct tsens_priv *priv)
>>  	return 0;
>>  }
> Same comment as above. The more the details, the easier for the people
> to review the code.

Sorry, I am not sure what you're referring to, the calibrate_8976 function?



>> -/* v1.x: msm8956,8976,qcs404,405 */
>> +static int calibrate_8994(struct tsens_priv *priv)
>> +{
>> +	int base0[16] = { 0 }, base1[16] = { 0 }, i;
>> +	u32 p[16];
> p stands for ?

No idea, but judging by the line:

" adc_code_of_tempx = base0[i] + p[i]; "

it's probably some hw-specific offset value.



>> +	int mode = 0;
>> +	u32 *calib0, *calib1, *calib2, *calib_mode, *calib_rsel;
>> +	u32 calib_redun_sel;
>> +
>> +	/* 0x40d0-0x40dc */
>> +	calib0 = (u32 *)qfprom_read(priv->dev, "calib");
> Fix qfprom_read, by returning an int and using nvmem_cell_read_u32
> (separate series).
>
> It seems like all call sites are expecting an int.

Weird. I did not get slope calculation issues even with this, but perhaps

I was just lucky.



>> +			p[9] = (calib2[0] & MSM8994_S9_REDUN_MASK) >> MSM8994_S9_REDUN_SHIFT;
>> +			p[10] = (calib2[0] & MSM8994_S10_REDUN_MASK) >> MSM8994_S10_REDUN_SHIFT;
>> +			p[11] = (calib2[0] & MSM8994_S11_REDUN_MASK) >> MSM8994_S11_REDUN_SHIFT;
>> +			p[12] = (calib2[0] & MSM8994_S12_REDUN_MASK) >> MSM8994_S12_REDUN_SHIFT;
>> +			p[13] = (calib2[0] & MSM8994_S13_REDUN_MASK) >> MSM8994_S13_REDUN_SHIFT;
>> +			p[14] = (calib2[0] & MSM8994_S14_REDUN_MASK) >> MSM8994_S14_REDUN_SHIFT;
>> +			p[15] = (calib2[0] & MSM8994_S15_REDUN_MASK) >> MSM8994_S15_REDUN_SHIFT;
> IMO, it is possible to do something simpler (probably bits.h could have
> interesting helpers).

All TSENS consumers had this style, probably to make it easier to compare with the

downstream driver should there arise any human errors.



>> +		} else {
>> +			dev_dbg(priv->dev, "%s: REDUN NON-TWO_PT mode, mode = %i",
>> +			__func__, mode);
>> +			for (i = 0; i < 16; i++)
>> +				p[i] = 532;
> No litterals, macros please

Does MSM8994_NON_TWOPT_DEFAULT_VALUE sound good? It doesn't exactly

roll of the tongue but I don't have many better ideas..



> And it would be simpler to iniatialize the array with the value.
>
> u32 p[16] = { [ 0 ... 15 ] = MY_532_MACRO };

> So no need to use this loop and the other one beliw.

Thanks, didn't know about this.



> What about replacing 16 by TSENS_SENSOR_MAX ?

If you mean this 8994-specific function exactly, then it'd probably cause

more confusion than help as we might find out that some SoC using TSENSv1

has even more sensors.



>>  static struct tsens_features tsens_v1_feat = {
>>  	.ver_major	= VER_1_X,
>>  	.crit_int	= 0,
>>  	.adc		= 1,
>>  	.srot_split	= 1,
>> -	.max_sensors	= 11,
>> +	.max_sensors	= 16,

Here TSENS_SENSOR_MAX does make sense.



>> +
>> +struct tsens_plat_data data_8994 = {
>> +	.num_sensors	= 16,
>> +	.ops		= &ops_8994,
>> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
> If you have time, in another series, replace this by a single int used
> as a bitmask and fix the hw_id loop in tsens.c.

I will add this to my to-do list, but no promises on this landing anytime soon :/



Thanks for the thorough review,

Konrad
