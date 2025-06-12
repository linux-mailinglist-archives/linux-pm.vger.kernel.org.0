Return-Path: <linux-pm+bounces-28564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130DAD7903
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AFD3A4242
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAF29AB01;
	Thu, 12 Jun 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBVXjfr1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBD19CC39;
	Thu, 12 Jun 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749501; cv=none; b=CS3163v1CG3zzg/AZTqWubZalX9Rg9GOS0Td+pGJ+KaNxViivTQ+qqhmIRHqsC4YR7WyTJiCkJtY33t3OZTYBEpPmnLKZawVcmyPF2kEg9UEKir/O77W/vja0hTdjUpUolagrJKJUOGVoYvsBfsFHsGYAUAvDOCHhujqzD6ymzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749501; c=relaxed/simple;
	bh=otcnDpD+CwvfxCXPQGJv0FOTQyY9TfauzzsfyruyWCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNnYA73w0JVM2DBuQ19yiUFQNDuCAngPzl2yKXBvBB8q8thTNJOaweHbijbyjKZXvkI0enjWDOog463dMg4Xh1mglC/RM/QEQ3ZukX3Xw3NANg/Nw9UwNonMu/1KgnjcYdIhbbmRX7s3LQWHarixRTjGjV1xBnvvvghybjqySAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBVXjfr1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fba9f962so1130635b3a.0;
        Thu, 12 Jun 2025 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749749499; x=1750354299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xv8y1hwAZ1ADO72IiD5Mm9fc1qZ34wninqrfu7oXtRo=;
        b=VBVXjfr1VlxRdxbsC0DrI97o5pJ9NvRFcUGeWn58LeZSf0KgvTRke5VvO1D6D7aATl
         S9FCSC5x5kcRkFjbl/9sln+mVF3wluSw7vqEHpNmWlDcNsVPiNuiE+4osoF15qwC7XhW
         2gUw3Y5kN4HwAP85agdwgMOUXCGNy/aILK/qxTCw7ve7mJc2TMiN3BuZxmgVhkNWlLxK
         Y4H+gv19dgV/HFMG6ORmtwsqZLYKm7lSiHft8l/Af79Ty8XltCErvjxRpLo3T+m8DrKT
         RwdJ+WIgE9grrenkD0Tc3QOlCNYJ/ONi+3VLiPZWgkurbL1kVZyq/AaU1V8fu4sZAWMS
         +uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749749499; x=1750354299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv8y1hwAZ1ADO72IiD5Mm9fc1qZ34wninqrfu7oXtRo=;
        b=pI7X85RD0N9GXaZfvaokBMMbQ0xIpbsCivkeZW1y9eX59DxJAMIgeGISUEvIJ13eOj
         p0+qyu58j2KWe+agbpYaP6+DURP9oTWO66Dwe5WSVoUb3pZ9Hi44JGMZpFggmYvwqiFq
         OzKO55afCVEPvfb4E3bcao2SKuDhBlooLTUi5UvRqsNqVEqnSP1NW9AtVE1EErVMtlRF
         bg5K9qyd0Eua1seh+t2x0Lx9Ac+vVVH1BbhuzgiT5cNHq4VtoRwbVR6IhNsyWz9FwQs2
         3GK8NH658oujG/B/0TzOFo87geIPyXgMHUppJOv2+LFkcjgYDvBOTZdyZK2/iwUo5qS6
         QuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYpHgvVWv9P4YZlLXs3fxQlif7xxE13fAJirJG0C9TZ5hdOxo+fbIY5To9zg0y8ZuvPJSKxThvw7Nl/vNVbCJfKg==@vger.kernel.org, AJvYcCVz5ut4knaJ5Agar1eOh5eIHvrFwLSPMhRfZm4ALqDieOUmKz5JDn/yBt33HTwugbxIrknFGnPaPg4t4Fk=@vger.kernel.org, AJvYcCWC8e5RJRkWpr+gbaQ7HgQ33Gsn/HZua+WibVX7+KcPVUhANLZjeGF7escWdBxDnriBTKpGtWM1vNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2jv3PrbEAy0OF0WxHYcxcDtOEZygzD7B+jPvPrqWMfMedPvy
	FvJt/y9hfGU2k1a0Pby4Uh3Sd3ZOpyiEVb6040kGTjXy0CAAvJpwlU9e
X-Gm-Gg: ASbGncsOjvBQw5WrSWdYS39G60wK/TaqsBuiz36TPqhtgk6YepcF4UpEKUHLuk8zes7
	TyfmqsZJI34CshFbOE7ttL7LMN8PAC/98tsI//oG9TL+g5hLMSJAYKrKhFqIlhutnrM65joh3S8
	ujEVo5+W1DtT+Fh5Av3eqj0ZVoKZr2924pvmDItt641x3HJelAjq0SWJIFcH8noFifXb7l43wee
	bnXC/W2USk2CxNuXFNf6D0vVYs6qfwo8ObY0mG4bb4ZJ0kHACht+krHSyC5sEgVloXONu7UObtW
	KXjrzQ0L9YB91ULAc+r6llelyuFNB6DUBX3vP4gqaHNIZ4jnAgrEmUXbhbo/
X-Google-Smtp-Source: AGHT+IF6JO6zv2ZxYGrMpFyX5qpBH+K4yTR69s1GLbL1n6QCFkSYxYZgE78yuUZ7Dqsii20VloyovQ==
X-Received: by 2002:a05:6a00:cc:b0:742:a24d:aede with SMTP id d2e1a72fcca58-7487ceecdc6mr3909973b3a.8.1749749498580;
        Thu, 12 Jun 2025 10:31:38 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74880a0bcd4sm1800344b3a.149.2025.06.12.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:31:37 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:31:32 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/3] pmdomain: core: introduce dev_pm_genpd_is_on
Message-ID: <20250612173132.ixgctqijtd33vnmb@hiago-nb>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-2-hiagofranco@gmail.com>
 <iuotfsnaft3623lchzop6sbu5ox56scdr57uia56qm6ummcvzt@yisczcdzbc3b>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iuotfsnaft3623lchzop6sbu5ox56scdr57uia56qm6ummcvzt@yisczcdzbc3b>

On Wed, Jun 11, 2025 at 10:32:28AM -0500, Bjorn Andersson wrote:
> On Mon, Jun 02, 2025 at 10:19:03AM -0300, Hiago De Franco wrote:
> > From: Hiago De Franco <hiago.franco@toradex.com>
> > 
> > This helper function returns the current power status of a given generic
> > power domain.
> > 
> 
> Please correct me if I'm wrong, but this returns the momentary status of
> the device's associated genpd, and as genpds can be shared among devices
> wouldn't there be a risk that you think the genpd is on but then that
> other device powers it off?

I am not fully familiar with the genpd's, so my knowledge might be
limited, but I think this is correct, if the genpd is shared.

> 
> > As example, remoteproc/imx_rproc.c can now use this function to check
> > the power status of the remote core to properly set "attached" or
> > "offline" modes.
> 
> I presume this example works because there is a dedicated, single usage,
> genpd for the remoteproc instance?

Peng might correct if I am wrong, but yes, I believe this is correct.

> 
> > 
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > ---
> > v4: New patch.
> > ---
> >  drivers/pmdomain/core.c   | 27 +++++++++++++++++++++++++++
> >  include/linux/pm_domain.h |  6 ++++++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index ff5c7f2b69ce..bcb74d10960c 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -758,6 +758,33 @@ int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
> >  
> > +/**
> > + * dev_pm_genpd_is_on - Get device's power status
> 
> Functions in kernel-doc should have () prefix

Thanks, I will correct this is next patch version.

> 
> > + *
> > + * @dev: Device to get the current power status
> > + *
> > + * This function checks whether the generic power domain is on or not by
> > + * verifying if genpd_status_on equals GENPD_STATE_ON.
> > + *
> 
> If my understanding is correct, I'd like a warning here saying that this
> is dangerous if the underlying genpd is shared.

I believe this is correct, maybe Peng or Ulf can also comment here, but
if that is the case then I can update the comment.

> 
> Regards,
> Bjorn
> 
> > + * Return: 'true' if the device's power domain is on, 'false' otherwise.
> > + */
> > +bool dev_pm_genpd_is_on(struct device *dev)
> > +{
> > +	struct generic_pm_domain *genpd;
> > +	bool is_on;
> > +
> > +	genpd = dev_to_genpd_safe(dev);
> > +	if (!genpd)
> > +		return false;
> > +
> > +	genpd_lock(genpd);
> > +	is_on = genpd_status_on(genpd);
> > +	genpd_unlock(genpd);
> > +
> > +	return is_on;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_genpd_is_on);
> > +
> >  /**
> >   * pm_genpd_inc_rejected() - Adjust the rejected/usage counts for an idle-state.
> >   *
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 0b18160901a2..c12580b6579b 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -301,6 +301,7 @@ void dev_pm_genpd_synced_poweroff(struct device *dev);
> >  int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
> >  bool dev_pm_genpd_get_hwmode(struct device *dev);
> >  int dev_pm_genpd_rpm_always_on(struct device *dev, bool on);
> > +bool dev_pm_genpd_is_on(struct device *dev);
> >  
> >  extern struct dev_power_governor simple_qos_governor;
> >  extern struct dev_power_governor pm_domain_always_on_gov;
> > @@ -393,6 +394,11 @@ static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline bool dev_pm_genpd_is_on(struct device *dev)
> > +{
> > +	return false;
> > +}
> > +
> >  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
> >  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
> >  #endif
> > -- 
> > 2.39.5
> >

Best Regards,
Hiago.

