Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8E1FAD32
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFPJ4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPJ4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 05:56:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7EC08C5C2
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:56:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so20065879wrv.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s+6tHvkpbMkOKCKAPCqQd0J6Ws3tiYCoTHS327bpUj0=;
        b=MXJamBMdHLtKkvZ1tesqApy0O8/Vj8QXsYt3avAmdmVJ5Ft2SASQEgbNWG3SdYYtdE
         +Ch8m2P48jOuSbe0ixEyumpyKsHKISYBwVMK4W64o8qjCzehFcaXk877uUtMjg6SZHId
         fs64b3Vpv4DcToMy3qpjHzpnChwCU5VdMcbl4NaTPq9++KmQDVtVZcOv3moUKizNQqM1
         S1/OlFY5IbI4oDqjMBrzF6xsMAU0o/pRw+pjq7iEu+Y7a1pD1WX43JOlc6wzD1s+if7G
         QDFuexgobbViQrxQ06pMwumO6fI2NiMJqiSZdkeQQxKpqY1X38hbNAvRJJYycugw1jJh
         qYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+6tHvkpbMkOKCKAPCqQd0J6Ws3tiYCoTHS327bpUj0=;
        b=nDgInCdWwFnFiUw5sJ4YVb+R7EPm48ty59/fDF5bzIp5QOo41kdXSaBRSG+21+wNbx
         LZUXX4Z4P5Ff4ChpyjP86IUSwe8F4GPGFzf7tgKTcH/h4aVVCZI1LFsjYW0ggPE+pOeb
         391sbM6f5IG3zu9tDiM1b7rJJTy8HVAcWPQB2Ga2MunJXwAb6NpKML6bJQWM7zCIN8EP
         WEhcFjPiGYHvXg2RPS9PtXKKKkeHdDec7SGrX+fmUK27okwy/5JCMLdiGFmbgfxzXSOw
         BBcGam8Gb/v2dZdCXp+MAkMuv4HPPYyQhPnql5V8qH/eDAbAaY0uxqVRgYAgVEn3JOfR
         Sk5Q==
X-Gm-Message-State: AOAM5336XSwCXe7sLPpi+uh+EMEDyycGpz9wwldpWUbfoKDaY5Gmnwrg
        DCPraNEFAyVYn3vStgpKWXNddQ==
X-Google-Smtp-Source: ABdhPJxqQsR3S5oPKf/oMoJLYKGnFwkzbNCBIFyx1JnikthcMcO/VLtWqWYDBGtu4xDItX3y6livhQ==
X-Received: by 2002:adf:b697:: with SMTP id j23mr2331934wre.201.1592301408232;
        Tue, 16 Jun 2020 02:56:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id c16sm3150742wml.45.2020.06.16.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:56:47 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:56:44 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616095644.GA150003@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
 <20200616092759.rjnk3lef4tedfust@vireshk-i7>
 <20200616094802.GA139416@google.com>
 <20200616095438.v7wywhfq5ealvyih@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616095438.v7wywhfq5ealvyih@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 16 Jun 2020 at 15:24:38 (+0530), Viresh Kumar wrote:
> On 16-06-20, 10:48, Quentin Perret wrote:
> > ---8<---
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0f05caedc320..a9219404e07f 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2340,6 +2340,11 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
> >  		list_add(&governor->governor_list, &cpufreq_governor_list);
> >  	}
> >  
> > +	if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
> > +		default_governor = governor;
> > +	else if (!default_governor && cpufreq_default_governor() == governor)
> > +		default_governor = cpufreq_default_governor();
> 
> Instead of the else part here, maybe just do this from
> cpufreq_core_init() only once, and so we will always have
> default_governor set.

Sounds good.

Thanks!
Quentin
