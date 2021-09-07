Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B89403035
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347966AbhIGVZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347918AbhIGVZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 17:25:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38326C061575;
        Tue,  7 Sep 2021 14:24:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me10so893578ejb.11;
        Tue, 07 Sep 2021 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m9grPVDNks9vhUxecATuV9kmCiAGakNtiwaKcKOkfzo=;
        b=CtD7SBETGs5VqXio82rju28CMglPWd2si4jnfVVTCoBnRXtRZprX3dZcQkrmwzXR8L
         b+sIK3J8aBxsYbMZCP9xWeAmWZ0aUFUh/jzELMOo/nIa5a5QUItzLPGOytilLyTVHma9
         8BOdn16IaIgJ5JyAKHDYIB4uHUFRqSvAfg5xHFPz63kUxd2Ug6Vgr2Id54TgcwEc74RS
         3CUAvTa5oCVwzHfkTKONiC14cbao7HRR9NVl1GR9mcRCNv2FuY1ed3WsHITkzivBDFl1
         c2Vm+UGDpcgt++/4lna2U1g8RLiQQatAQXoxzjzjHNveMn3oApW9GGPG2+xzkttPwwnO
         wrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m9grPVDNks9vhUxecATuV9kmCiAGakNtiwaKcKOkfzo=;
        b=Xg67cHIWcljtVYjir721s2Wxliz0WJOC8+z/J1TrcaQx5SNGMDijtun+WtqWeYjZqj
         2QIepSrCZlw3GGl19xA9Nh7nR1ZJ1cZhIzO6e6bQjSOaWSrzMb89dWMTvluwkAsfbJ/H
         G6QDThvQ7kaKpICGJ5Mf35CNX5RnRff0f1oQWROTP20Pr/WHGrug6VfWrH4Z/LDswJNa
         ick0nvK/7GcbyWH2gX/vr8qxLHP+zrGtKXE6XUKkEo47klBmpiqehLtXU2U6oIJcbc1V
         T77JfsWMlNLgkhuMJ/S4/p3cwEv/q0AXy+lOwHB+LXrnjiUbO4oNptERRnjF3cPMEghD
         h4jg==
X-Gm-Message-State: AOAM532XpO+gwJQ2P81JMinIoDFOKpG70JaxycE4gOwPam6bbxFw6asF
        vQFjRKL2VMCHYPRsEcxBChhFfFiFQYo=
X-Google-Smtp-Source: ABdhPJwlzi7lKUkqRyfgyDdLumt5Db7dOHQm1pzJIZUgIrINdsusL3sUYhRl1AkvfswY8XKhSdhAEQ==
X-Received: by 2002:a17:906:1e97:: with SMTP id e23mr381185ejj.336.1631049865565;
        Tue, 07 Sep 2021 14:24:25 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-87-0-193-30.retail.telecomitalia.it. [87.0.193.30])
        by smtp.gmail.com with ESMTPSA id a11sm28982ejy.87.2021.09.07.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:24:25 -0700 (PDT)
Date:   Tue, 7 Sep 2021 23:24:22 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: thermal: tsens: add timeout to
 get_tem_tsens_valid
Message-ID: <YTfYhtDdW1iZauSk@Ansuel-xps.localdomain>
References: <20210905174708.4605-1-ansuelsmth@gmail.com>
 <20210905174708.4605-2-ansuelsmth@gmail.com>
 <YTfRp1pOoQYFRGX+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTfRp1pOoQYFRGX+@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 07, 2021 at 01:55:03PM -0700, Matthias Kaehlcke wrote:
> On Sun, Sep 05, 2021 at 07:47:08PM +0200, Ansuel Smith wrote:
> > The function can loop and lock the system if for whatever reason the bit
> > for the target sensor is NEVER valid. This is the case if a sensor is
> > disabled by the factory and the valid bit is never reported as actually
> > valid. Add a timeout check and exit if a timeout occurs. As this is
> > a very rare condition, handle the timeout only if the first read fails.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/thermal/qcom/tsens.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index b1162e566a70..38afde1a599f 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -599,6 +599,7 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
> >  	int hw_id = s->hw_id;
> >  	u32 temp_idx = LAST_TEMP_0 + hw_id;
> >  	u32 valid_idx = VALID_0 + hw_id;
> > +	unsigned long timeout;
> >  	u32 valid;
> >  	int ret;
> >  
> > @@ -607,13 +608,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
> >  		ret = regmap_field_read(priv->rf[valid_idx], &valid);
> >  		if (ret)
> >  			return ret;
> > -		while (!valid) {
> > -			/* Valid bit is 0 for 6 AHB clock cycles.
> > -			 * At 19.2MHz, 1 AHB clock is ~60ns.
> > -			 * We should enter this loop very, very rarely.
> > -			 */
> > -			ndelay(400);
> > -			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > +
> > +		if (!valid) {
> > +			timeout = jiffies + msecs_to_jiffies(20);
> > +
> > +			do {
> > +				/* Valid bit is 0 for 6 AHB clock cycles.
> > +				 * At 19.2MHz, 1 AHB clock is ~60ns.
> > +				 * We should enter this loop very, very rarely.
> > +				 */
> > +				ndelay(400);
> > +				ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > +				if (valid || ret)
> > +					break;
> > +			} while (!(ret = time_after_eq(jiffies, timeout)));
> > +
> >  			if (ret)
> >  				return ret;
> 
> With the overloading of 'ret' the return logic is getting a bit more
> convoluted. Also the function should probably return -ETIMEDOUT or
> some other meaningful error if the bit is never valid.
> 
> How about keeping the 'while (!valid)' condition, and adding
> 
> 	if (time_after_eq(jiffies, timeout))
> 		return -ETIMEDOUT;
> 
> inside the loop?
>

I tried to refactor the code using some tag. Hope it's better that way
and thanks for the review. Sending v2.

