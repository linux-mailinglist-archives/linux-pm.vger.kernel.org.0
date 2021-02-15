Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010D431B57A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 07:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBOG7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 01:59:18 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36292 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhBOG7Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 01:59:16 -0500
Received: by mail-lf1-f49.google.com with SMTP id f1so8635269lfu.3;
        Sun, 14 Feb 2021 22:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=4BH4r71LEBLN/FYC56Md53GFBHnSsqrv3bI2bMVLjMY=;
        b=NWdVM1yfucxAPBxRS7RY/nxtQPhmSEOJplKZCNyY1xSR1uGQssZ+nzutaabPBKdRoG
         1cWU1F48Nveu7EkOjtRp5znhupdKMEZ47r3DotwIG7XOEl6YIvo0+lHvKu6JT0t/2pTd
         XGdhNGJC7ofiFICqIZZRMyEcxBeUmOi3HT/uW6/Hfga1O4R3Rj8dk8Ae5U/cgrSHQFk+
         VemG1dyy3gA4a6/R81uzfirulFiTF6KVoB6TTlrOSpQ5pZQN8ato888yEqf/kybSlSMc
         NDRG1lkB2MJO0JkPPGvnvHndhENQtvbJbX0B8eicyd2zTgeuEB8Z7MkiMXqymmveN493
         JElw==
X-Gm-Message-State: AOAM5334EmO1CLsdt0iczOHQto4TTDahnv2pcekAWQP69nazG9y5z6CH
        OYKjlk/U8wLfph0t/MR0wCBkuMdiCz8kbA==
X-Google-Smtp-Source: ABdhPJxoO4MrtauooOlxH50TwCbt0pujKzTLH9TqAOrNw1CHA0Xl/TC5vi4pS4C/ggVj7vcnRHPNyg==
X-Received: by 2002:a19:10:: with SMTP id 16mr7936722lfa.497.1613372313252;
        Sun, 14 Feb 2021 22:58:33 -0800 (PST)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id d14sm2653860lfg.128.2021.02.14.22.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 22:58:32 -0800 (PST)
Message-ID: <4fb3a4c93d3db8640deeface4478ab057a3e3f78.camel@fi.rohmeurope.com>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <284d4a13-5cc8-e23c-7e99-c03db5415bf1@redhat.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <YCfDAly9b0zHMpJT@kroah.com>
         <284d4a13-5cc8-e23c-7e99-c03db5415bf1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 15 Feb 2021 08:58:24 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sat, 2021-02-13 at 14:18 +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/13/21 1:16 PM, Greg Kroah-Hartman wrote:
> > On Sat, Feb 13, 2021 at 01:58:44PM +0200, Matti Vaittinen wrote:
> > > +/**
> > > + * devm_delayed_work_autocancel - Resource-managed work
> > > allocation
> > > + * @dev: Device which lifetime work is bound to
> > > + * @pdata: work to be cancelled when device exits
> > > + *
> > > + * Initialize work which is automatically cancelled when device
> > > exits.
> > 
> > There is no such thing in the driver model as "when device exits".
> > Please use the proper terminology as I do not understand what you
> > think
> > this is doing here...
> 
> I agree that this needs better wording I always talk about driver-
> unbinding
> because sysfs has /sys/bus/*/drivers/*/bind and
> /sys/bus/*/drivers/*/unbind
> attributes. But I see that the relevant driver-core functions all
> call it
> driver detaching, so lets be consistent and use that here too.

//Snip

> > > @@ -249,6 +250,10 @@ void __iomem *devm_of_iomap(struct device
> > > *dev,
> > >  			    struct device_node *node, int index,
> > >  			    resource_size_t *size);
> > >  
> > > +/* delayed work which is cancelled when driver exits */
> > 
> > Not when the "driver exits".
> 
> Right this should be detached not exits.
> 

Thanks guys.
I am poor with the terminology so I do appreciate your help in getting
this right. I can change this for the v2.


> > There is two different lifespans here (well 3).  Code and
> > data*2.  Don't
> > confuse them as that will just cause lots of problems.
> > 
> > The move toward more and more "devm" functions is not the way to go
> > as
> > they just more and more make things easier to get wrong.
> > 
> > APIs should be impossible to get wrong, this one is going to be
> > almost
> > impossible to get right.
> 
> I have to disagree here devm generally makes it easier to get things
> right,
> it is when some devm functions are missing and devm and non devm
> resources
> are mixed that things get tricky.

Thanks for the discussion. I hope we can come to some conclusion here.
Unsurprisingly I agree with Hans here. I did after all send this patch
series :) I guess I am mostly just repeating what he said.

As Hans pointed out, when all calls are 'undone' by devm the order of
'undoing' is highly likely to be correct as the unwinding is done in
reverse order to initializations. I think it is sane to assume in most
case things are initiated in order where operations which depend on
something are done last - and when 'unwinding' things those are
'undone' first. 

My 'gut feeling' for probe / remove related errors is that the most
usual errors I've seen have been:

a) Tear-down completely forgotten
b) Tear-down forgotten at error path
c) Wrong order of initiating things (IRQ requested prior resource
initialization)
d) Wrong order of cleann-up at remove.

a) and b) class errors have been the most common ones I've seen. They
can be completely avoided when devm is used.
c) is there no matter if we use devm or not.
d) is mostly avoided when only devm is used - mixing devm and manual
operations make this more likely as Hans pointed out. As long as we
have some devm operations we should help avoid mixing devm and manual
clean-up.

Best Regards
	Matti Vaittinen



