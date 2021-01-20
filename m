Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2022FD8AF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbhATSpl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 13:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbhATSkf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 13:40:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66749C061575;
        Wed, 20 Jan 2021 10:39:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id dj23so24403701edb.13;
        Wed, 20 Jan 2021 10:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DbjCwstmUaHfU0p6M3ixslMg4pkSwHqVC4Cq5uKXI7Q=;
        b=NTIzj6S5KVkB1RWWZJup/A7oB/bzRIPDxOb3bA1giOos4rsgzam9AoBMnee3z0VDgJ
         bWb+UMfXyYMsan8UqylWp4FjW/HAKA/xSE1RWfQayFLhoSIrPlAQ/2MBlw/CTAOYpQKf
         vRV/PHq0zBbVwAe551yjmdykkovpUVMfokeypkQlPYEFiwPzdrZw5YZZZKoqanFfuiKZ
         iGyIc9LKgnc+ih/4WGlfx7tMdFcdjDdvRxd4ogOk2Jz4qnL2cmoCIqEhppTLatc4Gby0
         TmyE8n6BsPdyGKGsWSArT0hb1NhmEr+Si3u5bgyj6qf4ykp3R8w9m/TZh326odbnQBjT
         2FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DbjCwstmUaHfU0p6M3ixslMg4pkSwHqVC4Cq5uKXI7Q=;
        b=NkHOczF3LXlxqy2TRCJPn+6o+C/3LL1Ecgha+8jA3Cq/g+K0DRlB1Sd/FNKODogt5i
         GbevRIXKyf0yZOXUxXPJnLvQqRvy63JLj1gc2UndWABMk9Sjk6CITGqpE54O4aa1WyIf
         tNdnlwLgElnNkj0fvxkCseOZLttwcEv5h/L4BhiJnhGZkG9ySn7gmawUngTCYfWB0G1h
         0azU0adN1L+Zx+f+erB1mGktQ8MdwAo+BPNQ9UEkI3UJ2DIMqfP1WmkQtIkDLUT9uOzv
         tghJDoCfViqMCe2EktC3Dr4h2ZTtNdbs8e6qglCP1ZqWevmxoMeWHhwifR6ONY5bgSH8
         wFAg==
X-Gm-Message-State: AOAM530u2Y4dfnPQdYmQo0plW5dtgDgJUKTZcdoxI71fDYHinbYtEsa8
        i70PimUCjNlMODW9IIhAU9k=
X-Google-Smtp-Source: ABdhPJzlUYWv2sBk1/0YdutiTnWJQFLZg8VOE7RFtYkYU8w6PhVO38kxTOanSQzfVpX5iOtF1h1m0A==
X-Received: by 2002:aa7:cdcb:: with SMTP id h11mr8371260edw.237.1611167993530;
        Wed, 20 Jan 2021 10:39:53 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g25sm1488542edw.92.2021.01.20.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:39:52 -0800 (PST)
Date:   Wed, 20 Jan 2021 20:39:50 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/7] mfd: Add MFD driver for ATC260x PMICs
Message-ID: <20210120183950.GA867982@BV030612LT>
References: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
 <81546cf3265f51374a1b38b9e801003fd6c3e298.1610534765.git.cristian.ciocaltea@gmail.com>
 <20210120083348.GM4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120083348.GM4903@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 20, 2021 at 08:33:48AM +0000, Lee Jones wrote:
> On Wed, 13 Jan 2021, Cristian Ciocaltea wrote:
> 
> > Add initial support for the Actions Semi ATC260x PMICs which integrates
> > Audio Codec, Power management, Clock generation and GPIO controller
> > blocks.
> > 

[...]

> > +	/* Initialize the hardware */
> > +	atc260x->dev_init(atc260x);
> > +
> > +	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to get chip revision\n");
> > +		return ret;
> > +	}
> > +
> > +	if (chip_rev > 31) {
> 
> Nit: If you have to respin this, please define this magic number.
> 

[...]

> > +static struct i2c_driver atc260x_i2c_driver = {
> > +	.driver = {
> > +		.name	= "atc260x",
> > +		.of_match_table	= of_match_ptr(atc260x_i2c_of_match),
> > +	},
> > +	.probe		= atc260x_i2c_probe,
> > +};
> 
> Nit: These spacings/line-ups just look odd.
> 
> Please stick to one ' ' after the '='.

[...]

> > +	const char *type_name;
> > +	unsigned int rev_reg;
> > +
> > +	int (*dev_init)(struct atc260x *atc260x);
> 
> Ah, I didn't see this before.
> 
> Call-backs of this nature are the devil.  Please populate a struct
> with the differentiating register addresses/values instead and always
> call a generic deivce_init().

I have implemented this, including the other 2 suggestions above, in
the already submitted revision v6.

Thanks,
Cristi

> > +};
> > +
> > +struct regmap_config;
> > +
> > +int atc260x_match_device(struct atc260x *atc260x, struct regmap_config *regmap_cfg);
> > +int atc260x_device_probe(struct atc260x *atc260x);
> > +
> > +#endif /* __LINUX_MFD_ATC260X_CORE_H */
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
