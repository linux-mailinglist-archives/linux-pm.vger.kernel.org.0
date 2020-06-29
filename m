Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7046820E1D3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgF2VAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbgF2TM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F622C0086F1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 02:48:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so15872679wrn.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53lrQUK5V0R5X9ZjWHVM8fR4aDPLU332zBTO52qfJo0=;
        b=JnRx9Y+zwfxpRk+lCViV8yNn8Lh5fwC569wzdoeWEClhDQHG6m2Xay+NUT45SdKC2v
         6hi5IJIynqYjnQvHsQBtTrrygjqCGOek/nk93m4sMaI7kc5Nr9pcFvZJXijPJXZBd4kF
         gJv0ygLdaVBMVYDiqaK+nWSnjud8vJk5sooXIw6dKkIZA+lVblCYW+pvNIDdWQKREshm
         ahg757SV624NnHdvdQxUQsT7kIB10OdIpcaHHe7S5hbCnU88BnbStBr5ImBJCIqffXWW
         xYtHwZn5O+iajGMvqzC0uLVU4500akD33etgK5BU6EP5TSi3Y4WVjt8WRgZ2wkgKW7ww
         VZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53lrQUK5V0R5X9ZjWHVM8fR4aDPLU332zBTO52qfJo0=;
        b=kzhpGi5R4XS+qA3pYg3n5bgAhm4D+mAn+nOfy+OP9aQO1q5NfbU+aR4Wh6ydDBno8Z
         inY8h5W4yZY4w+RZIXVW3WeuQyjbrZ6VxQTTB9DZDl4jHTyFFuOxvQzavRafA1CVD6yo
         WxDFIUnNypOEPpiH+kwhSBILv8YZBZT9wgLn5kFXzi7hBJfyZ4C2BT+F3Yl5RdeDO77u
         jq+ftokRTgy+V4rkvK9DgF24fUP0p4KqzGkxkNHwIwbDPXmY1zC3BvbXG/CEsmwlyCI8
         cvgdv6ITonLeGCCtRxEIfWdAcjYOIIVn3FDoICo4hYkPKNTUL1DqDxgFRm6onQDF42w5
         pLCg==
X-Gm-Message-State: AOAM531gLJhp/Nlc+Ky2W5k8YYBERmrxg12FK/EwXk5ZWdAY6WfswWEp
        kMF4ywQoS6fJKjxm3Uv0aggUrw==
X-Google-Smtp-Source: ABdhPJx0Ku5T89UPaWu567plluHv+iRyJfjLQ0ckyz7mLSL3YaFEfuG+0mg7IOEgARLWdiyfZ1xzJw==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr15736698wrm.282.1593424109700;
        Mon, 29 Jun 2020 02:48:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u10sm27556177wml.29.2020.06.29.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:48:29 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:48:25 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200629094825.GA1231692@google.com>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
 <96b6e6ca02b664194ff3e57e1ec768fbc597bf38.1593418662.git.viresh.kumar@linaro.org>
 <20200629094452.GB1228312@google.com>
 <20200629094627.jh7pwhftcdqj6nhm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629094627.jh7pwhftcdqj6nhm@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 29 Jun 2020 at 15:16:27 (+0530), Viresh Kumar wrote:
> On 29-06-20, 10:44, Quentin Perret wrote:
> > On Monday 29 Jun 2020 at 13:55:00 (+0530), Viresh Kumar wrote:
> > >  static int __init cpufreq_core_init(void)
> > >  {
> > > +	struct cpufreq_governor *gov = cpufreq_default_governor();
> > > +
> > >  	if (cpufreq_disabled())
> > >  		return -ENODEV;
> > >  
> > >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> > >  	BUG_ON(!cpufreq_global_kobject);
> > >  
> > > +	if (!strlen(default_governor))
> > 
> > Should we test '!strlen(default_governor) && gov' here actually?
> > We check the return value of cpufreq_default_governor() in
> > cpufreq_init_policy(), so I'm guessing we should do the same here to be
> > on the safe side.
> 
> With the current setup (the Kconfig option being a choice which
> selects one governor at least), it is not possible for gov to be NULL
> here. And so I didn't worry about it :)

Right, so should we remove the check in cpufreq_init_policy() then?
I don't mind either way as long as we are consitent :)

Thanks,
Quentin
