Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606B741063
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjF1Luk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF1Lui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 07:50:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7E2D73
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 04:50:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e34ab99fso4821542f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687953034; x=1690545034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmI//46qVgwWaxyrm4e1NNaPRXGQ1onr4x9kkX9CbHc=;
        b=Kv4DaSxKEuJneE0L6S7fY5QoTV3kl3Kn5jlQsSLp4t9tlBgnFMcSYefu3BotPkK8is
         d33RIGgo128fM+7Zb0lOSA+jj31xzEIBdXuBpkyfwqT4Ffu35sy4VILhBvu1sVlY5Zcd
         2gdIpS9oSgMa3i/K2ncU2/uK91lOrX415/JtcDKURT9dgREPLAuHxELVxWemgNOin+1k
         lT2OUEfSIiTvf/Z1HtaLpbtgF3i30iITfEUQg2TwIYLbPFaZXv5e4ewxeiIWcqdq7MTd
         FdlPQauXg9g7uHjTrJh/7zdPSh6c3SvT9JMLT39ezEg8+a5aDTZEbSqLYFdik7fsicvY
         DoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953034; x=1690545034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmI//46qVgwWaxyrm4e1NNaPRXGQ1onr4x9kkX9CbHc=;
        b=WaUCUcxcAUUr6MToQtZ91iv8iEseZ6iImUxDhMR8ewfhQ3BfJ8Q1RJkHyrdU/xXb8c
         Q6LQ4bn3rfn2i1IOYo7DyPn2cPEz2HXy0nHXu5RKWSAJu8dIOejpVdjVxehL4mbp2jSD
         t2NsqUQCtQpl3xRCYfulC51GItVoXMM58SHbb7qNkBqx2vb/AtGqozsVuMSZoBAX3XAC
         r2nHbGMfcZaD4j0zdSJJRzgc6q+3DNBTxVgCrXLAsJEf6vNA36vPfQAKpI/2UjeRzhJ+
         pa2RhLNCesTMU848ZbvJSAWo7sEl5N/Jsp3BXc+FCHhcLhS+GDPUtLEPbc4hEdj7FgPr
         b7gw==
X-Gm-Message-State: AC+VfDyao3xXdlgntmE7WC65aYQ3BVBaF+oe0czWCljooOhPyq5EATBU
        1KWTCBvNCosyMyL0GacGW6E+CQ==
X-Google-Smtp-Source: ACHHUZ6etkknx/dNH1vqjcH8bRcYPnCPvwMhc97C9X8JRhQQGGPu8ODcyBoYEWU2yajNLMzayh8h0A==
X-Received: by 2002:a5d:6a4d:0:b0:313:f1a4:4112 with SMTP id t13-20020a5d6a4d000000b00313f1a44112mr6740967wrw.33.1687953034057;
        Wed, 28 Jun 2023 04:50:34 -0700 (PDT)
Received: from linaro.org ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4c83000000b0030497b3224bsm13075296wrs.64.2023.06.28.04.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:50:33 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:50:31 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [RFC PATCH v5 2/4] driver core: Add dev_is_drv_state_synced()
Message-ID: <ZJweh0MTuSY9jtW9@linaro.org>
References: <20230621144019.3219858-1-abel.vesa@linaro.org>
 <20230621144019.3219858-3-abel.vesa@linaro.org>
 <2023062103-chevron-sabotage-bf26@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062103-chevron-sabotage-bf26@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21 17:22:54, Greg Kroah-Hartman wrote:
> On Wed, Jun 21, 2023 at 05:40:17PM +0300, Abel Vesa wrote:
> > This can be used by drivers to figure out if a different device
> > driver has state synced or not for a specific device.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  include/linux/device.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index bae11928ef7e..8f042f04b5d9 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -1007,6 +1007,20 @@ static inline int dev_set_drv_sync_state(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static inline bool dev_is_drv_state_synced(struct device *dev)
> > +{
> > +	bool ret = false;
> > +
> > +	if (!dev)
> > +		return ret;
> > +
> > +	device_lock(dev);
> > +	ret = dev->state_synced;
> > +	device_unlock(dev);
> 
> This lock is "protecting" nothing, given that the value can instantly
> change after it is read.

Hmm, for some reason I thought it needs to be synchronized with the
sync state callback being called already. But I just noticed that call
to the sync state callback is independently locked after state_synced is
set. So I guess the lock can go away here.

> 
> Because it can change, how will this function actually show anything
> relevant?

The only usecase I can think of for this new API is for some driver
to delay an action until ultimately the driver for a specific device
gets state synced. So even if the value can change after it has
been checked, such consumer driver will most likely retry later on.

Hope that makes sense.

> 
> thanks,
> 
> greg k-h
