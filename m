Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4716FDD8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 12:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBZLfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 06:35:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36092 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBZLfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:35:51 -0500
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 640D243F;
        Wed, 26 Feb 2020 12:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582716948;
        bh=ay7JOYWD1Vz0y3Z7MViB60RY0BgYPE3y9xb8JrohwxY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BN+9WPc964VxPwZJZ/G0eSn8/6Z0ebSs5i33nu1cL1aJkPBQCY6P4T1BlW0dp+6Yz
         pUCZU2plhupJZQMQhYxwuBgh2ddtQUAlof2t9h/3DQG6zRjyLWbbwKAevOsez0HQkX
         Gvr2z1MHiHGwHCooZ4qM7XR7SV5UmWmyiib/BvZM=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Generate interrupt when
 temperature changes
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se>
 <46d8fe77-57f1-83e3-33ae-5080c6de2424@kernel.org>
 <20200226112433.GD3165317@oden.dyn.berto.se>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kbingham@kernel.org; keydata=
 mQINBFYE/WYBEACs1PwjMD9rgCu1hlIiUA1AXR4rv2v+BCLUq//vrX5S5bjzxKAryRf0uHat
 V/zwz6hiDrZuHUACDB7X8OaQcwhLaVlq6byfoBr25+hbZG7G3+5EUl9cQ7dQEdvNj6V6y/SC
 rRanWfelwQThCHckbobWiQJfK9n7rYNcPMq9B8e9F020LFH7Kj6YmO95ewJGgLm+idg1Kb3C
 potzWkXc1xmPzcQ1fvQMOfMwdS+4SNw4rY9f07Xb2K99rjMwZVDgESKIzhsDB5GY465sCsiQ
 cSAZRxqE49RTBq2+EQsbrQpIc8XiffAB8qexh5/QPzCmR4kJgCGeHIXBtgRj+nIkCJPZvZtf
 Kr2EAbc6tgg6DkAEHJb+1okosV09+0+TXywYvtEop/WUOWQ+zo+Y/OBd+8Ptgt1pDRyOBzL8
 RXa8ZqRf0Mwg75D+dKntZeJHzPRJyrlfQokngAAs4PaFt6UfS+ypMAF37T6CeDArQC41V3ko
 lPn1yMsVD0p+6i3DPvA/GPIksDC4owjnzVX9kM8Zc5Cx+XoAN0w5Eqo4t6qEVbuettxx55gq
 8K8FieAjgjMSxngo/HST8TpFeqI5nVeq0/lqtBRQKumuIqDg+Bkr4L1V/PSB6XgQcOdhtd36
 Oe9X9dXB8YSNt7VjOcO7BTmFn/Z8r92mSAfHXpb07YJWJosQOQARAQABtCRLaWVyYW4gQmlu
 Z2hhbSA8a2JpbmdoYW1Aa2VybmVsLm9yZz6JAlQEEwEKAD4CGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQSQLdeYP70o/eNy1HqhHkZyEKRh/QUCXWTt0QUJCyJXZAAKCRChHkZyEKRh
 /QYVD/95rP50k7PUx8ZzRGlWJtw8pGkWzyohQtkSeDhMYhR5Ud6dVVOjJxdAzSxnzeFDHniW
 plJ4z9hpczgnXpb2WNpccup7YzcpadCHG2M1nVZPqY3Szvfi+vjIm3Aa370FJeuhXgU65aBi
 NQv+lJR5R6qdyEkjT4YLSGf35fdoH4bAGHIKHtZH0iRvGcpt9YrygkGpCREnqHvzjXYBzDm6
 /0/2Qcf0aV0fZMeZ/EhkIL/zy452BRavJ6xJKBbGadm/dIEQsEdzfH4nbcfmsBpL4QdBzwon
 WQesFTVBpGpYIuToX5CB6WyXWnqkfUwcd7riEMciWLxqW82nLpfK96V9Blmumlj5RXjzzsN1
 aYMU8lxyeesEMiUmZDLY34DSP9jTcSZFTQkJ+VkXIgCbM8gXY8hEJ4Y5wYTG5XXDOVmXxO/k
 oR+51rx1gCOdo2jCu2gH84gemZv/Y0MPdL+vOph8AiuEZAUxUglSaLwZoX+5y3tRP9Pwp6Il
 DWlEfDW9s9N7x77Z9UbtgoM7K3BzFv/rhG/PXY+WUjjxQHRQN3GOhVXOtdl+ICijXgmBnOCO
 vB3cPxprqTqOX1mMo/FbckKzLuiNnJX2hPRvGcWgwwhzrTPoVS6DockCI5bketVjEAX4kH3+
 g0C4VZF7UOhTfgKjcUz1FQNsep1UsePjQE81yt6zt7kCDQRWBP1mARAAzijkb+Sau4hAncr1
 JjOY+KyFEdUNxRy+hqTJdJfaYihxyaj0Ee0P0zEi35CbE6lgU0Uztih9fiUbSV3wfsWqg1Ut
 3/5rTKu7kLFp15kF7eqvV4uezXRD3Qu4yjv/rMmEJbbD4cTvGCYId6MDC417f7vK3hCbCVIZ
 Sp3GXxyC1LU+UQr3fFcOyCwmP9vDUR9JV0BSqHHxRDdpUXE26Dk6mhf0V1YkspE5St814ETX
 pEus2urZE5yJIUROlWPIL+hm3NEWfAP06vsQUyLvr/GtbOT79vXlEn1aulcYyu20dRRxhkQ6
 iILaURcxIAVJJKPi8dsoMnS8pB0QW12AHWuirPF0g6DiuUfPmrA5PKe56IGlpkjc8cO51lIx
 HkWTpCMWigRdPDexKX+Sb+W9QWK/0JjIc4t3KBaiG8O4yRX8ml2R+rxfAVKM6V769P/hWoRG
 dgUMgYHFpHGSgEt80OKK5HeUPy2cngDUXzwrqiM5Sz6Od0qw5pCkNlXqI0W/who0iSVM+8+R
 myY0OEkxEcci7rRLsGnM15B5PjLJjh1f2ULYkv8s4SnDwMZ/kE04/UqCMK/KnX8pwXEMCjz0
 h6qWNpGwJ0/tYIgQJZh6bqkvBrDogAvuhf60Sogw+mH8b+PBlx1LoeTK396wc+4c3BfiC6pN
 tUS5GpsPMMjYMk7kVvEAEQEAAYkCPAQYAQoAJgIbDBYhBJAt15g/vSj943LUeqEeRnIQpGH9
 BQJdizzIBQkLSKZiAAoJEKEeRnIQpGH9eYgQAJpjaWNgqNOnMTmDMJggbwjIotypzIXfhHNC
 eTkG7+qCDlSaBPclcPGYrTwCt0YWPU2TgGgJrVhYT20ierN8LUvj6qOPTd+Uk7NFzL65qkh8
 0ZKNBFddx1AabQpSVQKbdcLb8OFs85kuSvFdgqZwgxA1vl4TFhNzPZ79NAmXLackAx3sOVFh
 k4WQaKRshCB7cSl+RIng5S/ThOBlwNlcKG7j7W2MC06BlTbdEkUpECzuuRBv8wX4OQl+hbWb
 B/VKIx5HKlLu1eypen/5lNVzSqMMIYkkZcjV2SWQyUGxSwq0O/sxS0A8/atCHUXOboUsn54q
 dxrVDaK+6jIAuo8JiRWctP16KjzUM7MO0/+4zllM8EY57rXrj48jsbEYX0YQnzaj+jO6kJto
 ZsIaYR7rMMq9aUAjyiaEZpmP1qF/2sYenDx0Fg2BSlLvLvXM0vU8pQk3kgDu7kb/7PRYrZvB
 sr21EIQoIjXbZxDz/o7z95frkP71EaICttZ6k9q5oxxA5WC6sTXcMW8zs8avFNuA9VpXt0Yu
 pJd2ijtZy2mpZNG02fFVXhIn4G807G7+9mhuC4XG5rKlBBUXTvPUAfYnB4JBDLmLzBFavQfv
 onSfbitgXwCG3vS+9HEwAjU30Bar1PEOmIbiAoMzuKeRm2LVpmq4WZw01QYHU/GUV/zHJSFk
Organization: Ideas on Board
Message-ID: <317d0a0d-8046-237b-9c22-7729e6053ab0@ideasonboard.com>
Date:   Wed, 26 Feb 2020 11:35:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200226112433.GD3165317@oden.dyn.berto.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On 26/02/2020 11:24, Niklas Söderlund wrote:
> Hi Kieran,
> 
> Thanks for your feedback.
> 
> On 2020-02-26 09:05:22 +0000, Kieran Bingham wrote:
>> Hi Niklas,
>>
>> On 12/02/2020 22:49, Niklas Söderlund wrote:
>>> The desired behavior of the driver is to generate an interrupt and call
>>
>> s/behavior/behaviour/ but that's me being English, so you can ignore
>> that ... (at your peril ... :-D )
>>
> 
> I have a hard time as it is trying to spell the "other" version of the 
> language I been exposed to since early years, throwing more 'u' at it 
> will only add to my confusion ;-)
> 
>>> thermal_zone_device_update() as soon as the temperature have changed
>>> more then one degree.
>>>
>>> When the set_trips operation was implemented it was believed that the
>>> trip window set by the framework would move around the current
>>> temperature and the hysteresis value described in devicetree. The
>>
>> Should the hysteresis value described in devicetree be a part of the
>> +-MCELCIUS(1) calculations? or is it determined that a one degree window
>> each side is sufficient to contain such hysteresis of the readings?
> 
> The hardware testers wanted a fixed 1 degree window.

But my question is what is the value described in devicetree.
Should it be involved in the calculation somewhere?

I.e. if the devicetree specifies that the hysteresis of the hardware is
(guessing) say "0.2 degree", does that mean that the 'window' must be at
least that value.

And picking on that purely as an example as I don't know the value or
meaning of the one in DT, but therefore - if there was hardware that
then had a 2 degree hysteresis, this fixed-1-degree window would have to
be:

 +	low = temperature - min(MCELSIUS(1), MCELSIUS(hysteresis_val);
 +	high = temperature + min(MCELSIUS(1), MCELSIUS(hysteresis_val));


Or perhaps I'm just mis-understanding the reference of the hysteresis
value anyway.


I see there is still a 'trips' section in the thermal documentation example.

Should that be removed? or is it handled by core?




>>> behavior of the framework is however to set a window based on the trip
>>> points described in devicetree.
>>>
>>> Remove the set_trips operation which was not used correctly and update
>>> the temperatures that triggers interrupts directly from the interrupt
>>> handler.
>>>
>>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>
>> Sounds good to me.
>>
>> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Thanks! Unfortunately the patch is already merged so it will be hard to 
> add your tag.

No problem, I saw it on linux-renesas-soc and was curious ;-)
--
Kieran


> 
>>
>>> ---
>>>  drivers/thermal/rcar_gen3_thermal.c | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
>>> index 72877bdc072daaed..55d1736f532cdb33 100644
>>> --- a/drivers/thermal/rcar_gen3_thermal.c
>>> +++ b/drivers/thermal/rcar_gen3_thermal.c
>>> @@ -81,8 +81,6 @@ struct rcar_gen3_thermal_tsc {
>>>  	void __iomem *base;
>>>  	struct thermal_zone_device *zone;
>>>  	struct equation_coefs coef;
>>> -	int low;
>>> -	int high;
>>>  	int tj_t;
>>>  	int id; /* thermal channel id */
>>>  };
>>> @@ -204,12 +202,14 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
>>>  	return INT_FIXPT(val);
>>>  }
>>>  
>>> -static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
>>> +static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
>>>  {
>>> -	struct rcar_gen3_thermal_tsc *tsc = devdata;
>>> +	int temperature, low, high;
>>>  
>>> -	low = clamp_val(low, -40000, 120000);
>>> -	high = clamp_val(high, -40000, 120000);
>>> +	rcar_gen3_thermal_get_temp(tsc, &temperature);
>>> +
>>> +	low = temperature - MCELSIUS(1);
>>> +	high = temperature + MCELSIUS(1);
>>>  
>>>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
>>>  				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
>>> @@ -217,15 +217,11 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
>>>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
>>>  				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
>>>  
>>> -	tsc->low = low;
>>> -	tsc->high = high;
>>> -
>>>  	return 0;
>>>  }
>>>  
>>>  static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
>>>  	.get_temp	= rcar_gen3_thermal_get_temp,
>>> -	.set_trips	= rcar_gen3_thermal_set_trips,
>>>  };
>>>  
>>>  static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
>>> @@ -246,9 +242,11 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>>>  	for (i = 0; i < priv->num_tscs; i++) {
>>>  		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
>>>  		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
>>> -		if (status)
>>> +		if (status) {
>>> +			rcar_gen3_thermal_update_range(priv->tscs[i]);
>>>  			thermal_zone_device_update(priv->tscs[i]->zone,
>>>  						   THERMAL_EVENT_UNSPECIFIED);
>>> +		}
>>>  	}
>>>  
>>>  	return IRQ_HANDLED;
>>> @@ -454,6 +452,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>>>  		if (ret < 0)
>>>  			goto error_unregister;
>>>  
>>> +		rcar_gen3_thermal_update_range(tsc);
>>> +
>>>  		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
>>>  	}
>>>  
>>> @@ -492,7 +492,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
>>>  		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
>>>  
>>>  		priv->thermal_init(tsc);
>>> -		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
>>> +		rcar_gen3_thermal_update_range(tsc);
>>>  	}
>>>  
>>>  	rcar_thermal_irq_set(priv, true);
>>>
>>
> 

