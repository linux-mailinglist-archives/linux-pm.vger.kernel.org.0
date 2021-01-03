Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123D92E8DA1
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 18:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbhACRVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jan 2021 12:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhACRVQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jan 2021 12:21:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA8C061573;
        Sun,  3 Jan 2021 09:20:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cm17so24839702edb.4;
        Sun, 03 Jan 2021 09:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPZpW7pct701YIH5FuP3dTS3Jfc1HQ3AViBuw4vIpVw=;
        b=KpDIKzd0QNs+tFLglFXhTlNhH87RN1WHs0GMssPqxlowtK2vIRfH+9XlGjXvzeNPI1
         S29QNdVLrH0Aeapxug7YZKljkgbP7IUfLYmkoJFmCIhsc9B6+93zj5+rd1ZZkkCLjBii
         ktdP2+vfQaIdTHsyn+SqLCqIuV6bf9oN4+hcxGsXxCw7f3dMSV0vzqqumc4jQMNLBrXr
         A6iNenfKNWMx3g/lwuYhv0co8zsTctF6DdrZEYUIE0Clrnx8GVZyC9Z8mG4xIWM9z1Iv
         LGqZutqzHh2HiFtyN0RucV8p0u6gbc1eK/I41LmKxEW3EB8CQaH9CUQmQmX5o703B+Yv
         Z+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TPZpW7pct701YIH5FuP3dTS3Jfc1HQ3AViBuw4vIpVw=;
        b=nJZExDhPq+NocFJGXIDRBM7qamqDzTIp1sWKVfFo7ThqSATeCUBoMY3hHkOasNGmke
         Bjwyd0GdhjGX6FKxPyNwWV/LPKXqwdQp6z0o/YGQGUgh2PC0eEg+GyliJa+mVplFw6dW
         aQUR9xla5uw5ocOhhhfZ0KS2K6PUyVNAsT3obrJKoElTfOnLzQCy40FmWN4cz5MWhcZ5
         jtO/fhaDABzZ61bTl89angSzzIcpUrd46eBx+eKBKVetCbLN7dHOm0kQ+q6TUHXAIZPt
         aXSWuSLqwSbmIvf27GT7eJT4jHHtkRFX6sTmqkVzcBrbsc2PuKtx/6R8uklgiVS8W8GX
         mp4Q==
X-Gm-Message-State: AOAM5317s7G0jajBL0AawKqteRxjfT84/sz18wb0q7b+o3Tz+zc8bxN6
        GulUt5LFjz0xMwQ0yQ+tBTo=
X-Google-Smtp-Source: ABdhPJyva/cWisJ5YFH14niBryPIxYZJ37WhmcWvlWK2gcYUJWtQ8rn5AaeDvhYBERw0R2aeEJ6CaA==
X-Received: by 2002:a50:d888:: with SMTP id p8mr15608690edj.147.1609694434829;
        Sun, 03 Jan 2021 09:20:34 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id l14sm42732692edq.35.2021.01.03.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:20:34 -0800 (PST)
Date:   Sun, 3 Jan 2021 19:20:31 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/7] power: reset: Add poweroff driver for ATC260x
 PMICs
Message-ID: <20210103172031.GA268987@BV030612LT>
References: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
 <eef6e5a4e0fc5f20da235a3a4124ba81eebfe2ca.1609258905.git.cristian.ciocaltea@gmail.com>
 <20210103032631.k6ls5k2bnxmlhlhv@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103032631.k6ls5k2bnxmlhlhv@earth.universe>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On Sun, Jan 03, 2021 at 04:26:31AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Dec 29, 2020 at 07:31:20PM +0200, Cristian Ciocaltea wrote:
> > This driver provides poweroff and reboot support for a system through
> > the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
> > family of PMICs.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> > Changes in v4:
> >  - None
> > 
> > Changes in v3:
> >  - Removed the unnecessary driver compatibles
> > 
> > [...]
> > +#include <linux/delay.h>
> > +#include <linux/mfd/atc260x/core.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> 
> There is no DT code in this driver?

Right, this line is not needed anymore, I will drop it and submit a new
patch revision.

> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> 
> power_supply.h? That's for chargers and battery fuel gauges.

That is only used for checking if the S4 mode is available - which
involves calling 'power_supply_is_system_supplied()'.

> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> 
> > [...]
> 
> Otherwise LGTM. I suppose I can cherry-pick this patch into
> my tree, or did I miss some dependencies?

I'm not really sure what is the recommended approach (if any) for
merging MFD drivers.

The only dependency is the PMIC core driver in patch 3/7, which is
handled in Kconfig through 'depends on MFD_ATC260X'.

So far, Mark applied the regulator driver patch to his tree, while
Dmitry suggested to merge the onkey driver through MFD. So I think both
approaches are fine.

@Lee: Do you have any preference or recommendation for handling this?

> -- Sebastian

Thanks for the review,
Cristi

