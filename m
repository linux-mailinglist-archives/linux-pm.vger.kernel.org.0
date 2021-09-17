Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FDF40F67D
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbhIQLIK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbhIQLIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 07:08:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599AC061574;
        Fri, 17 Sep 2021 04:06:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg28so5572030edb.1;
        Fri, 17 Sep 2021 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FEIuoSgNcte8p2NJYC8yZXiAswFHmgWs9QpJbtKT01o=;
        b=SHHqpqlJKVEaAHO1wZamR/xrgz7o7F36L2gGzOvWQ00oC5p9Aunr1rwMy2T70pz9Mb
         NHp0SYb9+Cr1mS1EI3IN39AZs2um62Z9RY+stzUt9hOUTRoPmLDmxpp5GBan08phlBCU
         M4JszHrR8d7jFCM5QwOXz0zE+E8ltqbN/h+fTM2nbSncKxUWNjn1Erm1zKbm+k8oC7D/
         pVp0U9TL0Pi6pVde/cd7+t4FY8t5IH1W692D9BrH0IfXOen3OxUyUsLQPNkVSdkywSlp
         Fw+gPQS3CEiDP4ZKEQUxAM/CxVdkt8YL1nhEERqsXxhapwVj836KEgNDIii6TXM8FhZ3
         oVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FEIuoSgNcte8p2NJYC8yZXiAswFHmgWs9QpJbtKT01o=;
        b=yzJxcCDSFD9boRL8ARfBh5BVxyehFfINd48z+US+Ae1ZvLejfSCMl2KpyNBMP/uDHl
         JjED571OEiiQgofLj8J3UC3tZbP1KQ6xZsIvPFpqIqjEKgHZTBXjm2i7QJxQTP7wUPvt
         SQtnUH8xfgfTZ7DsIrnoWNPtbacjSm0trOF+i4WZZFB+HUk/w687qIk3sFYRSla+zDFk
         LA7x9tiFuGJ06Mqjv18x0QY1q1UGLb06OnfG2X+efyZAcgcw0R0jWdUU3Kw2xVMSMIFg
         DoLUmlg6N2rJJt8R2wQnFXoqNSsjcF69iwoU1HYW06Ly+Inar3i3ZZncqE8zTM4OIoAN
         wFFg==
X-Gm-Message-State: AOAM533rYdEth5C/xmt0GDB4AFB6wOTN6jM2pwHkUploLlBuTdJ9SFBM
        dBcqxEV3NS791NpvBbYsvoOxvfI7s0c=
X-Google-Smtp-Source: ABdhPJxiu6F+EV0iBSURU8CilU5CnzX6FbVy7CohQtrTm5nP9tmF0nOOetPNso4tVfuQb5iJEoyTiQ==
X-Received: by 2002:a17:906:2a0d:: with SMTP id j13mr11145527eje.545.1631876806599;
        Fri, 17 Sep 2021 04:06:46 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-67-254.ip85.fastwebnet.it. [93.42.67.254])
        by smtp.gmail.com with ESMTPSA id cb10sm2502711edb.18.2021.09.17.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 04:06:45 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:06:42 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drivers: thermal: tsens: add timeout to
 get_tem_tsens_valid
Message-ID: <YUR2wmcMMWtoLDGB@Ansuel-xps.localdomain>
References: <20210907212543.20220-1-ansuelsmth@gmail.com>
 <20210907212543.20220-2-ansuelsmth@gmail.com>
 <f06f6d13-e659-16e9-5900-2d82596f139c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f06f6d13-e659-16e9-5900-2d82596f139c@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 17, 2021 at 11:08:15AM +0200, Daniel Lezcano wrote:
> On 07/09/2021 23:25, Ansuel Smith wrote:
> > The function can loop and lock the system if for whatever reason the bit
> > for the target sensor is NEVER valid. This is the case if a sensor is
> > disabled by the factory and the valid bit is never reported as actually
> > valid. Add a timeout check and exit if a timeout occurs. As this is
> > a very rare condition, handle the timeout only if the first read fails.
> > While at it also rework the function to improve readability.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/thermal/qcom/tsens.c | 40 +++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index b1162e566a70..1ff244176beb 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -599,26 +599,38 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
> >  	int hw_id = s->hw_id;
> >  	u32 temp_idx = LAST_TEMP_0 + hw_id;
> >  	u32 valid_idx = VALID_0 + hw_id;
> > +	unsigned long timeout;
> >  	u32 valid;
> >  	int ret;
> >  
> >  	/* VER_0 doesn't have VALID bit */
> > -	if (tsens_version(priv) >= VER_0_1) {
> > +	if (tsens_version(priv) == VER_0)
> > +		goto get_temp;
> > +
> > +	ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > +	if (ret || valid)
> > +		goto check_valid;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(20);
> 
> Why not use regmap_field_read_poll_timeout() ?
>

Ok will convert this to pool_timeout and send v3.
Thx for the review.

> > +	do {
> > +		/* Valid bit is 0 for 6 AHB clock cycles.
> > +		 * At 19.2MHz, 1 AHB clock is ~60ns.
> > +		 * We should enter this loop very, very rarely.
> > +		 */
> > +		ndelay(400);
> >  		ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > -		if (ret)
> > -			return ret;
> > -		while (!valid) {
> > -			/* Valid bit is 0 for 6 AHB clock cycles.
> > -			 * At 19.2MHz, 1 AHB clock is ~60ns.
> > -			 * We should enter this loop very, very rarely.
> > -			 */
> > -			ndelay(400);
> > -			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > -			if (ret)
> > -				return ret;
> > -		}
> > -	}
> > +		if (ret || valid)
> > +			goto check_valid;
> > +	} while (time_before(jiffies, timeout));
> > +
> > +	return -ETIMEDOUT;
> > +
> > +check_valid:
> > +	/* Check ret of valid bit read */
> > +	if (ret)
> > +		return ret;
> >  
> > +get_temp:
> >  	/* Valid bit is set, OK to read the temperature */
> >  	*temp = tsens_hw_to_mC(s, temp_idx);
> >  
> > 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
