Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD80133BE3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 07:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAHGtF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 01:49:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35676 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAHGtF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 01:49:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so1127853pfo.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 22:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XfnflGZ6oSzY+MaLoyJpJ8yAdxfSU+oZoFb75ber0eQ=;
        b=oRQZMXS5BPcdeOERB4pNNVbYLVT8+DpXr8U+UcJ8gw8uIslp6j9jSsr429ZOJAxoji
         +pN9S6F601Z1Uf/ZHSEYWRtIWlrqgqOzr/7raG+viem8rqLoQldnlqfii7cCy7BJ8ZCq
         PBw7/QsasSqrNRZtBQdl5xCSy3mOELWFD0GZ+Fg+9wml4PjmonL6bDfrq0BDCA7KDZ91
         YhxAYp+gPmz7GP5dxOMgKS4j6+Fc+HiYliG6oQH4I1Qapr0TVhg+ZUfXGK4RnwDeKBR/
         ETwk/VfGEpW8zJ0Lkj6lZ2sWswLcbkOgb2mQwjKObo195/u6ho3YaEiJa59eQFpldVMG
         tbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XfnflGZ6oSzY+MaLoyJpJ8yAdxfSU+oZoFb75ber0eQ=;
        b=ff4SLMxoDqor56N6qIA58Q5k7mdtg8YEbxQDaSm7+vt0jpp6G4vnjW4i+CSLMj+mdt
         UjWCjCPPgYnP/RmFDpf1NvU9br8pCFpL0T70T+HKQkxh+ga9X41VG2yoi2F23Vk+D4FE
         o5vZqHDyW/hHYChKho0IxXoJN8DutvY4tfMyM5U6iGnuA1Egb73Ke6h/bLDspRllDNVx
         okbX5EFt7xHMxuYZSLjbeIbhVI1evCOE4AIweEA6UOg2UEPx2U4tWBZIXvfHRTEpPxTD
         KjykSbhW2ktL9Ma/kZFjTKjiKcGuYCXMDjOPw12vKc1vTjSJQmj6P1W/jQrKGQ5qqEde
         7lcg==
X-Gm-Message-State: APjAAAWgke/1ZNPEqPuOmLTrphb5TqPkUsPIN9FeFLAUuPDIp7NPZ3Wn
        HCBGSrrMmRGK8d0aySNkB6UP9A==
X-Google-Smtp-Source: APXvYqwihXTTTzoaBd499RsWz0IN7S6x7DMn+MdqYf7L1dPxI2620/DVar1McatTo8xPCGImgowKtA==
X-Received: by 2002:a65:5786:: with SMTP id b6mr3737898pgr.316.1578466144857;
        Tue, 07 Jan 2020 22:49:04 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id s24sm1670546pjp.17.2020.01.07.22.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 22:49:04 -0800 (PST)
Date:   Wed, 8 Jan 2020 12:19:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200108064901.rf6r7buy6tcxsrzc@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
 <20200107095834.GB3515@qmqm.qmqm.pl>
 <20200107113055.d4ebweisve73yf3m@vireshk-i7>
 <20200107135743.GA20159@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107135743.GA20159@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-01-20, 14:57, Michał Mirosław wrote:
> On Tue, Jan 07, 2020 at 05:00:55PM +0530, Viresh Kumar wrote:
> > On 07-01-20, 10:58, Michał Mirosław wrote:
> > > On Tue, Jan 07, 2020 at 12:11:29PM +0530, Viresh Kumar wrote:
> > > > On 03-01-20, 20:36, Michał Mirosław wrote:
> > > > > Per CPU screenful of backtraces is not really that useful. Replace
> > > > > WARN with a diagnostic discriminating common causes of empty OPP table.
> > > > But why should a platform have an OPP table in DT where none of them works for
> > > > it ? I added the warn intentionally here just for that case.
> > > Hmm. I guess we can make it WARN_ON_ONCE instead of removing it
> > I am not sure this will get triggered more than once normally anyway, isn't it ?
> 
> It is triggered once per core.

What platform it is ? Maybe because cpufreq driver failed to initialize the
policy for all CPUs and so this is getting repeated.

> > > , but I
> > > don't think the backtrace is ever useful in this case.
> > Hmm, I am less concerned about backtraces than highlighting problem in a serious
> > way. The simple print messages are missed many times by people and probably
> > that's why I used a WARN instead.
> 
> > 
> > > Empty table can
> > > be because eg. you run old DT on newer hardware version.
> > 
> > Hmm, but then a big warning isn't that bad as we need to highlight the issue to
> > everyone as cpufreq won't be working. isn't it ?
> 
> A user normally can't do much about it. Rather this is a developer targeted
> message. Maybe a rewording of the messages be better? Something to also
> include consequences of the error?

I agree that a WARN may be a bit excessive here.

-- 
viresh
