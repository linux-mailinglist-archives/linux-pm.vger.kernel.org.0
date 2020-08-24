Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6C1250C49
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 01:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgHXXXQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 19:23:15 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA8C061574;
        Mon, 24 Aug 2020 16:23:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l63so6548263edl.9;
        Mon, 24 Aug 2020 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IMKGdqUT+Wm0EM2slFZGgokEf7SVcwurGsjspfBC4Vw=;
        b=rD8Vonqj5fif4pBYbR9r7Vi70mcoVG/5u1oM018c4xJ2uhNW3MvdLEerdf0N/naDEZ
         E1j/y+v02nbdqyN2pY5wd1o6wcGWzIeH7pgJ70Rbdc6P4LBXrzv5iT00Pf7bBkmTN4RC
         qe/bZzHGf/UATzFlwIpqJpcKCHUKKobTQoLT5s4jWqw4I5S4s51HXn0EY/oBaMsVjl5n
         VgBKf9y1b86K4TlY/K3cGAqsEy+Yx1ZETfLYtASnEEqMf9xmm9hR0cHIqi5tHlbujfll
         ISZicku4izGO/b/Sii+ttgpCCXKkj7wQ9uDQ/QydAk8qPN9dMcVcFMqTY5Ql8zrMsxlX
         LGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMKGdqUT+Wm0EM2slFZGgokEf7SVcwurGsjspfBC4Vw=;
        b=pH71E5I4OtGVRSAR3dmRnsT4T2s5l9UAvL7KCVbG+ENInnxhoXS2kjXcC7B6XdnxGM
         zcdkEGwoc7nZzItqgOjZhIP5PSn0HujvPZPtgm0lYhSnIkZMOJ1ndBYOHdUbumihCSe3
         PMYabwK8rruLE/jH8ZC2xzR/0qYAb/RDIcmdyZggdptyWqqCB7s2oJb37K4wexeyNs8u
         xYUhOOpTuGsEEfQtD8amHXiNXfDTffJkW7Oyyb57qoGfPQKXVSz7oN+CAZXtgVf3MqB4
         +w0HYDSGGT9RvxjPDpKMKBpq7P4CA/Tfc1M3+OpBBPvbhOcijvBjNYY1MgEEOt2A5GYz
         EuiQ==
X-Gm-Message-State: AOAM530bdXoswRb8/oa87pHcKWKxxiory/1fyb1vmmzWGim0fyLD7WVi
        H0EittbjEeFZg3uMvHtxDMw=
X-Google-Smtp-Source: ABdhPJwZKBlW9Oh2kcLlQDcMGwt1oIpnizxaEklu1dZLnaBBinI4xPTlwpC98tK8BDEzK9upr3L73A==
X-Received: by 2002:a50:c38b:: with SMTP id h11mr7783148edf.308.1598311393688;
        Mon, 24 Aug 2020 16:23:13 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id j3sm11691701eje.75.2020.08.24.16.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:23:13 -0700 (PDT)
Date:   Tue, 25 Aug 2020 02:23:10 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20200824232310.GA2301286@BV030612LT>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <8da70f0b19de17fb8edead7ff06461ae2451b0e9.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200824110045.GA4676@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824110045.GA4676@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

Thanks for reviewing!

On Mon, Aug 24, 2020 at 12:00:45PM +0100, Mark Brown wrote:
> On Sat, Aug 22, 2020 at 01:19:49AM +0300, Cristian Ciocaltea wrote:
> 
> > +static int atc260x_set_voltage_time_sel(struct regulator_dev *rdev,
> > +					unsigned int old_selector,
> > +					unsigned int new_selector)
> > +{
> > +	struct atc260x_regulator_data *data = rdev_get_drvdata(rdev);
> > +	int id = rdev_get_id(rdev);
> > +
> > +	if (new_selector > old_selector)
> > +		return id > data->last_dcdc_reg_id ? data->voltage_time_ldo
> > +						   : data->voltage_time_dcdc;
> 
> Please write normal conditional statements to make things easier to
> read.  It also looks like this would be more robustly written by just
> having separate ops for DCDCs and LDOs, this could easily break if
> another device is supported in the driver.

Sure, I can provide separate ops, but in this case we duplicate almost
all of them. If this is not acceptable, then I will just rewrite the
conditional statement.

> > +static const struct of_device_id atc260x_regulator_of_match[] = {
> > +	{ .compatible = "actions,atc2603c-regulator" },
> > +	{ .compatible = "actions,atc2609a-regulator" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, atc260x_regulator_of_match);
> 
> We don't need compatibles here, this is just reflecting the current
> Linux device model into the OS neutral DT bindings.  Another OS may
> choose to split regulators up differently.  We should just instantiate
> the regulator device from the MFD based on identifying the chip overall.

I have actually seen this in some MFD drivers I had been studying before
starting this work. I wasn't sure what is the rationale behind, I
assumed they have just an informative purpose.

So, if I understand correctly, this approach is deprecated now and I
should remove the compatibles from both the function driver and the
corresponding mfd_cell in the core implementation. And not only for
regulators, but for all the other functions of the MFD device.

Regards,
Cristi
