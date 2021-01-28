Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5694C306C1A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 05:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhA1EQQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 23:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhA1EQA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 23:16:00 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF5C06174A
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 20:14:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id b21so3429683pgk.7
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 20:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lCXx50lgTRJjoLzvkZ4CSd/Xgq+HdduyctrNeK/ybOA=;
        b=L2zVgS72yknF/uJKUQTIxQpzR/YqSxlccL48rWBWjWBOow9nT7HL0FSBy3LN3SjdyK
         P32Nbd86UaYWAhSlCnaM/nfV3+dFAdxO5/7OtpSeir/skN3NAhYBlaTBM09Va7zSX0xI
         Q8L5M11D2DtQsFRf8i2TAQc+5LfhXxxpUvT3lXemfVPdXYFKlqxzbHiJ6BbRYjSJBlsW
         4mGG7fNTjbcHntcuSwsVqsNT7ViisPkmUMiJUL9zQ3n/RGMPK4qP/5WG8DY+olSyVZVh
         M2CjVCaa+oo4GJMMpzn3dyODmpn/JGzl9lsm9Qxfmdie1HnJgZcKP2vT2/rGSsx/GWDz
         Nsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lCXx50lgTRJjoLzvkZ4CSd/Xgq+HdduyctrNeK/ybOA=;
        b=PDKJjGiRD3Na3di101TprvaTedKQtLzHbLzjBOL77enUXh0+IGyuou4tweDnarBRGf
         tSMHcymo2OE/mk29ytf8K7xAaF3RYn+vGOuVLcfa84Fa5tOmA232ufzT11NaWULTDV5y
         HeYcbFLfVXW346Nba/5vhcaNHiwG0P12aO8piD6B2dCcZkx/2caia3Ne2dJ3gC8qflMh
         4OPel7HN7xJT/He+xREYRBc2dquuDtPhk44v8bPCMUPqAMrTxauYoFpuxDpsa81MUqwh
         VNdm9p7X/19zrmH9MowDt3vyc7Q2RYO29ZodYwhMS8xlBlbDPYO7dnqwKixtVAwqqAJC
         1tjA==
X-Gm-Message-State: AOAM533hwA+kCG8m+qYvw1IG8eLuVjBMeCEfHBJuKVK2LagdX+4qMaM9
        isrJYqzmEZmMDJhit5SVqHWz7A==
X-Google-Smtp-Source: ABdhPJywuWr5tT7F1kzEfWsEJJfA+0MY7q2KsZKqDelepQKDtrXtxMVcyU2H9WnPXcXc88aXjcUr0A==
X-Received: by 2002:a65:458d:: with SMTP id o13mr14441303pgq.450.1611807277019;
        Wed, 27 Jan 2021 20:14:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id t25sm3995172pgv.30.2021.01.27.20.14.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 20:14:35 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:44:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
Message-ID: <20210128041431.rnfp3yrh7mp7e2gb@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
 <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
 <d9808e5f-bb8e-0d5c-8432-d695f8049f85@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9808e5f-bb8e-0d5c-8432-d695f8049f85@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-01-21, 22:01, Akhil P Oommen wrote:
> On 1/22/2021 10:15 AM, Viresh Kumar wrote:
> > On 22-01-21, 00:41, Dmitry Osipenko wrote:
> > > 21.01.2021 14:17, Viresh Kumar пишет:
> > > > @@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> > > >   	if (!ret) {
> > > >   		ret = _set_opp_bw(opp_table, opp, dev, false);
> > > > -		if (!ret)
> > > > +		if (!ret) {
> > > >   			opp_table->enabled = true;
> > > > +			dev_pm_opp_put(old_opp);
> > > > +
> > > > +			/* Make sure current_opp doesn't get freed */
> > > > +			dev_pm_opp_get(opp);
> > > > +			opp_table->current_opp = opp;
> > > > +		}
> > > >   	}
> > > 
> > > I'm a bit surprised that _set_opp_bw() isn't used similarly to
> > > _set_opp_voltage() in _generic_set_opp_regulator().
> > > 
> > > I'd expect the BW requirement to be raised before the clock rate goes UP.
> > 
> > I remember discussing that earlier when this stuff came in, and this I
> > believe is the reason for that.
> > 
> > We need to scale regulators before/after frequency because when we
> > increase the frequency a regulator may _not_ be providing enough power
> > to sustain that (even for a short while) and this may have undesired
> > effects on the hardware and so it is important to prevent that
> > malfunction.
> > 
> > In case of bandwidth such issues will not happen (AFAIK) and doing it
> > just once is normally enough. It is just about allowing more data to
> > be transmitted, and won't make the hardware behave badly.
> > 
> I agree with Dmitry. BW is a shared resource in a lot of architectures.
> Raising clk before increasing the bw can lead to a scenario where this
> client saturate the entire BW for whatever small duration it may be. This
> will impact the latency requirements of other clients.

I see. I will make the necessary changes then to fix it. Thanks guys.

-- 
viresh
