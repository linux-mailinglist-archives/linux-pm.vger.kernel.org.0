Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A538D198767
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgC3W3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 18:29:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35695 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgC3W3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 18:29:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id c12so4493680plz.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8vQmmg7hNSl880dzS5U4D8ylPA2t24t6PDXIkjFhyw=;
        b=enaoigUVvJO5lyNNbZ/eEngJDp3NLSbXaOW8jZMXRUmub8ne5NS0p2geytGwCNQhNo
         XgeGgxBkDSUWgWGKpRxnhHWbYuC+j6er51oCUnB/RC16US6Q+bgZj2EVcsUFu4QdmJKz
         VNedjGXM3sPPcxywmqhCVBX9zf2x5RN+C5cPU59YLceEVi8oVO9idqlgMe8G0fipax4l
         OThjTm38AALbmpbzI/QhQM9SxvoafBFBUMqK0mC4pzNkrxdCOZNZQDs/Y7JhASw8hKIv
         4NB+RAvstoycLWvAu/duRBk1nRUqYutikF6uLdIJ7WqN8UoEs/7TFZkf0Y5vuEOk88NH
         vx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8vQmmg7hNSl880dzS5U4D8ylPA2t24t6PDXIkjFhyw=;
        b=NLCMBodrBToEZ5CQ4tEzjau/0mkRXHdBJrIEko3nlGFRu8YnxFZdn9py0VXsOXD8r4
         NZliUfjOCOGg0nuiBvsOAqBUnoAAv7tunQdUWJMyaNs7aiKk8dzMN1CgWoCyVICn7M3j
         ALum5clMmo9z2k3nFKAe07smYK1QezDKaJBo/bowdaRFKLcb/G3lAyj+EJTmpFNHTBHX
         504yMXiWtu7OsEET6oHzwn+U6hLPRf0t/Av2C54x6M4HgyYLwr9pItG1npDJwc5gcGZL
         fPtABQBfC1oStphob82bBKrdyLpiTxiV4FlfW2RA3ceDotpRsNUzrMOZlthey3g4xny0
         FJ1Q==
X-Gm-Message-State: AGi0PuYdVk+KhL6Qje0A0W6ssT6VOXRBfYIY2jzx8JIYx7seQJTJNcAn
        9MZbEAVvgth6L2lMxYrD7PrgaQ==
X-Google-Smtp-Source: APiQypIuHql86lAYhHEvBXzOmE/e8Yj/bcnvY6jji2FWWAq4h5Q8oF0rrqf1mUeI/PTcQXDLTyv2kA==
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr346640pjn.148.1585607376669;
        Mon, 30 Mar 2020 15:29:36 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v42sm10448437pgn.6.2020.03.30.15.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:29:36 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:29:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, agross@kernel.org, robh@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v5 4/6] soc: qcom: Extend RPMh power controller driver to
 register warming devices.
Message-ID: <20200330222933.GC215915@minitux>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-5-thara.gopinath@linaro.org>
 <20200327225345.GH5063@builder>
 <f20b4940-11ad-82b1-6ece-661a1b033df8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20b4940-11ad-82b1-6ece-661a1b033df8@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 30 Mar 07:53 PDT 2020, Thara Gopinath wrote:
> On 3/27/20 6:53 PM, Bjorn Andersson wrote:
> > On Thu 19 Mar 18:41 PDT 2020, Thara Gopinath wrote:
[..]
> > > +static int __init rpmhpd_init_warming_device(void)
> > > +{
> > > +	size_t num_pds;
> > > +	struct rpmhpd **rpmhpds;
> > > +	int i;
> > > +
> > > +	if (!global_desc)
> > > +		return -EINVAL;
> > > +
> > > +	rpmhpds = global_desc->rpmhpds;
> > > +	num_pds = global_desc->num_pds;
> > > +
> > > +	if (!of_find_property(rpmhpds[0]->dev->of_node, "#cooling-cells", NULL))
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < num_pds; i++)
> > > +		if (rpmhpds[i]->is_warming_dev)
> > > +			of_pd_warming_register(rpmhpds[i]->dev, i);
> > > +
> > > +	return 0;
> > > +}
> > > +late_initcall(rpmhpd_init_warming_device);
> > 
> > ...why can't this be done in rpmhpd_probe()?
> > 
> > In particular with the recent patches from John Stultz to allow rpmhpd
> > to be built as a module I don't think there's any guarantees that
> > rpmh_probe() will have succeeded before rpmhpd_init_warming_device()
> > executes.
> 
> It is to take care of boot order.

Understood.

> So this has to happen after the thermal framework is initialized. Thermal
> framework is initialized with core_initcall. Can I move the rpmhpd init as a
> postcore_initcall ? Then I can get rid of this separate function and keep it
> as part of probe.
> 

So I presume the problem is that if this is called from probe, you might
of_pd_warming_register(), which ends up in
__thermal_cooling_device_register() before thermal_init() has been
invoked? 

Which is bad because e.g. thermal_class is not yet initialized.


I don't want to rely on the order of initcalls for things to work, so
could we make this more robust by having
thermal_of_cooling_device_register() return -EPROBE_DEFER is
thermal_init() isn't done?

Regards,
Bjorn
