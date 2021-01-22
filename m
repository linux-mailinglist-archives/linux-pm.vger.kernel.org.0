Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287D2FFBED
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 05:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAVEqS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 23:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbhAVEqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 23:46:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B832DC061756
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 20:45:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so2551707plp.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 20:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bbM2dKaYpv41IbTKFCnMXIDb9vPr8F5wpZdCakgIuw0=;
        b=uHQ/LNKv9Ii50fZb5s/RYG98hKXnhSwPVs+L5cPkfIj6K5CZebreMfP5nc4Gb/6QJ5
         en/0A+D/wVkrU/v1I1mZ4ey4n9lTklU45zI9HBM+ZIxlO0gsG7kePmQj5M4dQt2+8mcS
         tdi5E804YOrjQzv9HV5b1auk/Vnnp4oxbpk5DFl1MEHdy0OGHxTArUDvzPPcMDID5Wql
         JDs6C5dsNRPyxQobVu8AspBDMQYCFaaMEIug/AVM2NjHzwlhxuX2RThA5DN5fB7Z56Hy
         hqdulwE2KMuLCX8fb9+42VUWneZI4v8PzuMnwbIsOjA5OMtxuZL29KrqU5stPKnzJNvq
         ustA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bbM2dKaYpv41IbTKFCnMXIDb9vPr8F5wpZdCakgIuw0=;
        b=D6mjnOaS8aqptVOHnPHPqTldSYnmTpVtZkQxgoTbQ5k90BGrAupLwjjom92paLLikU
         ZIF+5Cgs5VeyOrMI35XT06zDfoodaZmezGcZCNGNy6e3Se5lzW7f8NWMmd4HGgFuW1o0
         rC3LKVXKlQP8gvO07A5Lh/2AWJ++wWQUlzBjXm0lq7SpEgq202xmYaAQG8IiCDEWuYKM
         rJNij7A/SyU/78SmrDVZNF242krrEZLwyO47BOoAy67vRoOQ+qOGeZkPbglbk9mFVjX9
         8N8tU8G/hg15fG3V/1aYfbOgmLt2zFq++pfF0aHjeCIw3toPYeTS2/S1NzJWFKYgQMR0
         0pqQ==
X-Gm-Message-State: AOAM530phzKkWD8vraQgb/VikpP/9cSL9jqVoJW8LcZbL/tSAgsFnlUG
        WexWO3/E8aqGG+6yRPhSDMOqxw==
X-Google-Smtp-Source: ABdhPJykjY//oEpUUCa97mb5wm8LARwb1qXlD4yQTn+cDtixVvBIM0+Lr3O+f+FTqokTzkG4IHsSZg==
X-Received: by 2002:a17:90a:4598:: with SMTP id v24mr3128802pjg.135.1611290735797;
        Thu, 21 Jan 2021 20:45:35 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id n128sm7428126pga.55.2021.01.21.20.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 20:45:34 -0800 (PST)
Date:   Fri, 22 Jan 2021 10:15:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
Message-ID: <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-01-21, 00:41, Dmitry Osipenko wrote:
> 21.01.2021 14:17, Viresh Kumar пишет:
> > @@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
> >  
> >  	if (!ret) {
> >  		ret = _set_opp_bw(opp_table, opp, dev, false);
> > -		if (!ret)
> > +		if (!ret) {
> >  			opp_table->enabled = true;
> > +			dev_pm_opp_put(old_opp);
> > +
> > +			/* Make sure current_opp doesn't get freed */
> > +			dev_pm_opp_get(opp);
> > +			opp_table->current_opp = opp;
> > +		}
> >  	}
> 
> I'm a bit surprised that _set_opp_bw() isn't used similarly to
> _set_opp_voltage() in _generic_set_opp_regulator().
> 
> I'd expect the BW requirement to be raised before the clock rate goes UP.

I remember discussing that earlier when this stuff came in, and this I
believe is the reason for that.

We need to scale regulators before/after frequency because when we
increase the frequency a regulator may _not_ be providing enough power
to sustain that (even for a short while) and this may have undesired
effects on the hardware and so it is important to prevent that
malfunction.

In case of bandwidth such issues will not happen (AFAIK) and doing it
just once is normally enough. It is just about allowing more data to
be transmitted, and won't make the hardware behave badly.

-- 
viresh
