Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9031F764
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBSKgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 05:36:50 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38274 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSKgl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 05:36:41 -0500
Received: by mail-lj1-f181.google.com with SMTP id j6so17651396ljo.5;
        Fri, 19 Feb 2021 02:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=nTn6ZavwiX+iUA/fKHbxz6oGLOlCA6cVyQWgY9ZgZLg=;
        b=QOxCjO3HH+ADPyELPS+QSf9+cI77RXwHBMsIBsKkHVDB365VpD5Uuok1Qfiv4bMpwB
         HEe3djJNrFMYB9dTScQbG4C5Ct+SpT0YxxK3lPo+C3VXugWnqh5ygmnEcmbSFYKDH/rH
         HXhXKtbxq9j7LE+8EdpvO/rP4w4747SdT/D80t1AzypXTSz16XrSwIiHWtyjmBd0QNHn
         lh4bsc2viQa1MGo6BOLSo2BpkkdrFvBC+rexNHGLgJP5mz/U+xwhZCKvDKhwvOmk9pJh
         VNfFCMsp6nk3vdxWbOL8E65r5WWIxjH5AQvQn5S5ckOQ7te3fGn0nW1IuaGfIt6X+I9y
         8KDw==
X-Gm-Message-State: AOAM531kmq5iyUW/yLN/BbtHuU4uNSrs3eNHj2sJt2saEZpouWt9w7/N
        9fzjFuShVF/0R4gaHhVcqSw=
X-Google-Smtp-Source: ABdhPJzG0M58qPNdOEK8XmQmqu0DNkflmATorE93w4HYy6twMvFdiFngo70LAkHDlEnw10M77EQnCA==
X-Received: by 2002:a2e:7c02:: with SMTP id x2mr5110440ljc.247.1613730958187;
        Fri, 19 Feb 2021 02:35:58 -0800 (PST)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id q3sm882433ljb.64.2021.02.19.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 02:35:57 -0800 (PST)
Message-ID: <468a5c7820a510b8a12c10b1b8a107fb41e9d26c.camel@fi.rohmeurope.com>
Subject: Re: [RFC PATCH 0/7] Add managed version of delayed work init
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     mgross@linux.intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
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
In-Reply-To: <20210218162821.GP154917@linux.intel.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <20210218162821.GP154917@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 19 Feb 2021 12:35:51 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Mark,

Thanks for taking a look at the series! This is the first time anyone
has been commenting on a cover-letter which is likely to fade away and
never be looked at again. Guess you are a thorough person :)

On Thu, 2021-02-18 at 08:28 -0800, mark gross wrote:
> On Sat, Feb 13, 2021 at 01:58:17PM +0200, Matti Vaittinen wrote:
> > It's not rare that device drivers need delayed work.
> > It's not rare that this work needs driver's data.
> > 
> > Often this means that driver must ensure the work is not queued
> > when
> > driver exits. Usually this is done by ensuring new work is not
> > added and
> > then calling cancel_delayed_work_sync() at remove(). In many cases
> > this
> > may also require cleanup at probe error path - which is easy to
> > forget.
> > 
> > It might be helpful for (a) few drivers if there was a work init
>  why the (a) and not just a?

I am not sure how many drivers are needed to change it from 'few' to 'a
few'. Additionally, this series converted only the drivers which I
found could easily get rid of the .remove() - I did not analyze how
many drivers would benefit from this by getting rid of mixed
devm/manual resource management.

So to sum up - I don't know how many drivers will benefit and what
people think makes 'few' to turn to 'a few'. '(a) few' leaves this
decision to readers - and (a) few of them know the drivers better than
I do.

> > Main reson why this is RFC is that I had hard time deciding where
> > this
> > function should be introduced. It's not nice to include all device
> > stuff
> > in workqueue - because many workqueue users are not interested in
> > devices. In same way, not all of the devices are interested in WQs.
> > OTOH, adding own file just for this sounds like an overkill.
> s/own/one

Hm. The 'own file for XXX' does not make sense for native English
speakers? Didn't now that. Thanks for pointing it out.

I will edit the cover letter when I respin this rebased on v5.12-rc1 -
and it is likely the series v2 will add this function inlined in a new
header dedicated for devm-helpers (as was suggested by Hans de Goede).

Best Regards
--Matti

