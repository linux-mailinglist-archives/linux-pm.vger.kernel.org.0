Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6F242BCE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLPBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHLPB1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 11:01:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BFC061383
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 08:01:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so1233963plt.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pn8XGjtoHNsfz8N95/akuzEI/iE/lyOm3UJwEkNX7sk=;
        b=cRhNL8hA3p/JUNHEus1P07KCkGKROzMAENFTyHVRjDRa7NFNYaX6gO35DBHDLm4UjP
         9HPf0zGMWfGvMtCS5X1Fs14S5Xm8DlO3vDpI1fLds3fIf9CLHUnQuCd7IRro0XIuLZ64
         VD6WZttGj9wnnXIrBjUaMApKIGTNXBh3SbljJjZi394OLAnk10iY1H6P0halcUhrfibW
         0rFbcLCFtEI267l4HZrSNTLMi9HRrZWhcCBVwu/pm64SUVztozXl5XTHW0C4tA4E/Etn
         uNMYyyswL1pyn7pIJ8hLwDAOkioWxhr32B/1LdDGbunBZ4GgdWvtDonSi8QI3bqZ+9pm
         qRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pn8XGjtoHNsfz8N95/akuzEI/iE/lyOm3UJwEkNX7sk=;
        b=GmeJw+rwtQJjbVE2UIOx+XFfo1b2PsHUYenh4+ncifvHlUA0wcd9r9MwFttjWs4Cmr
         KyXyLsOl0lYy8yP5y2p+fQKxPwTFqKfO04iqbZW4nubfqLGiS4JGwicg+ZrI0cSsCwv0
         2xpT+EbWMSIzhiY9mwHNskml8s4ocdb09Z99YlF/2Sii3uYiVwDneJoAWSPenuI1pANb
         b+x22BQw07yOx81afSPHWXyoPeoBFInzY+4hJv1575zvJ07SPjpJTeCKHJwFKFCcchkU
         5pf/ubPyOgaoyqhpaE/x7Ur8gn3fh2aQekT73QZ7VcJb16GHEqRX16jBQvyiQI9Lqd8+
         dN0Q==
X-Gm-Message-State: AOAM530j8WiGCmho1OxUmHfwUWE8obZzf8xJqRa4mjTWhjm+50ZZvGAz
        /Q2w9rvw6C+mhqRQFZq6LfRyKw==
X-Google-Smtp-Source: ABdhPJy1vATXhNuwkrOrmHQ14GFECX0NGcPnsRyZbrGNofbP7l18Jrk9xvZ7OAjGIRX+7Y5fc07MXw==
X-Received: by 2002:a17:90a:ca94:: with SMTP id y20mr405589pjt.137.1597244486995;
        Wed, 12 Aug 2020 08:01:26 -0700 (PDT)
Received: from localhost ([182.68.204.118])
        by smtp.gmail.com with ESMTPSA id z26sm2697640pgc.44.2020.08.12.08.01.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 08:01:25 -0700 (PDT)
Date:   Wed, 12 Aug 2020 20:31:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20200812150122.dennzvxfzk4fyxm2@vireshk-mac-ubuntu>
References: <20200727093047.8274-1-stephan@gerhold.net>
 <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
 <20200812105333.GA913@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812105333.GA913@gerhold.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-08-20, 12:53, Stephan Gerhold wrote:
> On Wed, Aug 12, 2020 at 11:10:38AM +0200, Ulf Hansson wrote:
> > > I wasn't sure if the changes in drivers/base/power/domain.c
> > > should be made in a separate commit, but they need to be made together
> > > with the other changes.
> > 
> > I would suggest to move the changes in drivers/base/power/domain.c
> > into a separate patch, still part of the series, but let it preceed
> > $subject patch.
> > 
> 
> OK, will do that in v2 - thank you!
> 
> I have another small build fix reported by the kernel test robot,
> but will wait with sending that out until Viresh had a chance to give
> some feedback on the basic idea. :)

What was the issue that was reported ? I may end up applying V1 only
with some of my changes.

-- 
viresh
