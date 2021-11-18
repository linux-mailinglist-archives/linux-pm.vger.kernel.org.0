Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C074945622F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhKRSTr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 13:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKRSTq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 13:19:46 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD78C061574;
        Thu, 18 Nov 2021 10:16:46 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t23so16111020oiw.3;
        Thu, 18 Nov 2021 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X8UnDQOpdeoBIJYA5H/uzZ/Savdkcg/csk1G/KUgy84=;
        b=VjRxZdo4+nULl3q2nzT6EjGdIPZICO9L/YRnStHr6TgTBhJEq59epE/C577qznLwYP
         Jjl0RG811YeRXGftKAJWZP40VSyQhM6kN5BxDnstg0NbdgQ3SBpuF0P55lT03aK6eVyc
         remOhvHkq4rU9H40/LRv1JZOsYNHrNZ9FyxYpe4aKJDB9x0wTnH/JTT9JOUjG7TJ5Ic7
         zzB7+tikSFSlNVRDjFbmK6Z7bpHqv8ptwQDIDFxOlDHyamnKtRm8vmFddC87/U/SzsZm
         0+BTzcy+FaWI+Bv6IpAd1eNxj/+mHE/+XNsuaFpqsSWUhnj3tv6V4nxymkMCqlZ9pcvf
         ezjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X8UnDQOpdeoBIJYA5H/uzZ/Savdkcg/csk1G/KUgy84=;
        b=fuoyc3kN7kkakMyTxDv55qYz2wElohAeuwua3ZiXN30gTVgPkh/AomOrlWCVxqHq39
         jwsLZKNZNd+QumSE+8rzEUVHTS63JYuSrjaTN+DK/eGQXJ/seD2vi+Hvm0dAGBCKag1g
         Tq2hf9Gire8K8DcrAoRi95l6DxDHGRFlfjyxBvQycwhFYxHHEof+LEKUjriNVuOvmOwk
         EG4Qm4AOBm1fTMRPYnqpa6OA8aG0LzS/ybFS0+9lK26F2bdvT29i9yRW+f7WNcxD1DhB
         K0KODt4fp53Ay5Bl/VaJVBqjXggPkRnIOBMLs/9L3WHZzQikXBg17tEKuCZZ+EUvF9sj
         SA6g==
X-Gm-Message-State: AOAM532H0aFK83wYuC8yCgdVGT7UYPHdlSDsaHPeCqhaBhoN4GIAvENt
        b7VqQ/P50wxkwc0XCngTfbA=
X-Google-Smtp-Source: ABdhPJwq9dbpTZrRvunI22VBRv8g2MvkV6R+lh9BcnQWlE17ZBbJyVzfxPIxI7lQi5IB4667s36OcQ==
X-Received: by 2002:a05:6808:b08:: with SMTP id s8mr9603710oij.126.1637259405525;
        Thu, 18 Nov 2021 10:16:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3sm102940otk.71.2021.11.18.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:16:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Nov 2021 10:16:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211118181643.GB3320814@roeck-us.net>
References: <20211118113026.GG1147@kili>
 <a33fc3d7-a389-a805-0ef9-4b90de1d3d89@roeck-us.net>
 <20211118145135.GO27562@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118145135.GO27562@kadam>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 18, 2021 at 05:51:35PM +0300, Dan Carpenter wrote:
> On Thu, Nov 18, 2021 at 06:22:58AM -0800, Guenter Roeck wrote:
> > On 11/18/21 3:32 AM, Dan Carpenter wrote:
> > > The extcon_get_extcon_dev() function returns error pointers on error
> > > and NULL when it's a -EPROBE_DEFER defer situation.  There are eight
> > > callers and only two of them handled this correctly.  In the other
> > > callers an error pointer return would lead to a crash.
> > > 
> > > What prevents crashes is that errors can only happen in the case of
> > > a bug in the caller or if CONFIG_EXTCON is disabled.  Six out of
> > > eight callers use the Kconfig to either depend on or select
> > > CONFIG_EXTCON.  Thus the real life impact of these bugs is tiny.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > The two callers where the drivers can be built without CONFIG_EXTCON
> > > are TYPEC_FUSB302 and CHARGER_MAX8997.
> > > 
> > [ ... ]
> > > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > > index 7a2a17866a82..8594b59bd527 100644
> > > --- a/drivers/usb/typec/tcpm/fusb302.c
> > > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > > @@ -1706,8 +1706,8 @@ static int fusb302_probe(struct i2c_client *client,
> > >   	 */
> > >   	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > >   		chip->extcon = extcon_get_extcon_dev(name);
> > > -		if (!chip->extcon)
> > > -			return -EPROBE_DEFER;
> > > +		if (IS_ERR(chip->extcon))
> > > +			return PTR_ERR(chip->extcon);
> > 
> > Why does the code not need to return -EPROBE_DEFER ? The description states
> > that NULL is returned in that situation. Doesn't that mean that defer situations
> > are no longer handled with this patch in place ?
> 
> I'm not sure I understand what you are saying here.  In the original
> code, extcon_get_extcon_dev() would return NULL and relied on the
> callers to change NULL into a -EPROBE_DEFER.  If extcon_get_extcon_dev()
> returned ERR_PTR(-EINVAL) (which is impossible as mentioned) the it
> would lead to a crash.
> 
> In the new code, the extcon_get_extcon_dev() function returns
> -EPROBE_DEFER directly so the caller code is much simpler.
> 
Misunderstanding on my side. I didn't get that extcon_get_extcon_dev()
now returns -EPROBE_DEFER.

> > 
> > Also, with this patch in place, the code will no longer work if extcon is disabled,
> > because extcon_get_extcon_dev() will return -ENODEV and the above code will bail out.
> > The behavior of the code wasn't optimal in that case (it would wait until timeout
> > in tcpm_get_current_limit() before returning), but at least it didn't fail.
> 
> Huh.  You are right.  Initialy I thought that tcpm_get_current_limit()
> would crash.  This is one of the two drivers which I mentioned that can
> be built without CONFIG_EXTCON.
> 
> I will modify the version of extcon_get_extcon_dev() where CONFIG_EXTCON
> is disabled to return NULL.  That is the standard/correct way to write
> these.  That will turn tcpm_get_current_limit() into a no-op.
> 
> A belt and suspenders approach might be to modify the Kconfig so this
> driver selects CONFIG_EXTCON.
> 

That would pull in unnecessary extra code, though, if the driver is supposed
to be able to work without it.

Thanks,
Guenter

> regards,
> dan carpenter
> 
