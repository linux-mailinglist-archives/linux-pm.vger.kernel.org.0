Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DB2DB6BB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 23:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgLOW7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 17:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgLOW7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 17:59:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31571C0617B0
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 14:58:37 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so21430871wrt.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 14:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S4/ArqoyhM6R2IAWg2ouJlOV41Dq/1z4QTe3XTdQngE=;
        b=XgUtemt7u7kpgcD8bks8ksl/53beQQmR3zAfJWl1PB+4OuvLHyBXcROwXia6ohjhJk
         OrqiJGR25c9nL0FlW8UOLqn/wpYdHH2rcQ2QdbWXeiYmOYYRtgiyHtqPisQl5hxyd3Rc
         n0ZzptJbGWYLgbFGuNcTlgxoVqLExFn0TQAu26J48CVg8LDRUAgtaTp5No0k6Kp9sjl4
         OKNaTCO1aZICVLEd3pWsGCjXJC4vXKffZQVSHdTwRRrVLe9TH9dbZuJADiSt5DRb4pII
         zXpIaREccXPg3RONSCzCjGXZH+3A8YQlfQiNBFuQcSqopRwT8FYdwUcLQAyXCEHOmc5E
         myqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S4/ArqoyhM6R2IAWg2ouJlOV41Dq/1z4QTe3XTdQngE=;
        b=Y1lEf4jif613/cNOeYDkUZE1shZd10wbgnMy64Z9azVqI4Erw8/deppNDJ+4XproQ3
         gxJ3b5yIMWfsQSdZBN7NBp0miKt3HwSbx21wVSQYydZBMNNiTAF0uess/4gOOrd82Zlr
         sRVcS0jiHXqNvF5FfSj6HZCiRBgZN/sryjdR+0jsUb79y1y9XA/TfctyTO9EL+Gce6+V
         f//W5Ql9L6tsGTRoqd5fmw65PpAFIqxkvhy9iIr1H8aXvt2I50HPA+wsCGtVHUP/zMlc
         dRShuE+AFfEPsoatdh9NwChECO8l0HtT8iHJ6WmkZv9QiKwop280XoXGkrdjGUcXIlSe
         uEvg==
X-Gm-Message-State: AOAM532nGh8MVfgE9lnROTlwCHGPS1LzpS+rJ9QvZN28Y9ze3EqxnFTT
        1l+40yv1/zmDwqerMIVbgKqQQQ==
X-Google-Smtp-Source: ABdhPJzN+VdxNoGz5CCRLdungxTDGe3IPh+5/50yEjoJhTIvajc8CLWn1+HPO2cFAFPRxOGqY6emOQ==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr36427160wrx.53.1608073115832;
        Tue, 15 Dec 2020 14:58:35 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:1dbc:8063:5912:c6b3])
        by smtp.gmail.com with ESMTPSA id t1sm83494wro.27.2020.12.15.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 14:58:35 -0800 (PST)
Date:   Tue, 15 Dec 2020 23:58:32 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] thermal/core: Precompute the jiffies
Message-ID: <20201215225832.GB3581@linaro.org>
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
 <20201202120657.1969-2-daniel.lezcano@linaro.org>
 <1c909a38-1777-556d-fe87-29394a1b1d56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c909a38-1777-556d-fe87-29394a1b1d56@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 15, 2020 at 09:38:06AM -0500, Thara Gopinath wrote:
> Hi Daniel,
> 
> On 12/2/20 7:06 AM, Daniel Lezcano wrote:
> > The delays are stored in ms units and when the polling function is
> > called this delay is converted into jiffies at each call.
> > 
> > Instead of doing the conversion again and again, compute the jiffies
> > at init time and use the value directly when setting the polling.
> 
> A generic comment. You can avoid patch 1 of this series and directly
> have patch 2 , right? There is no need to rename polling_delay/passive_delay
> to *_delay_ms and then remove it again?

Yes, I can simplify that.

> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---

[ ... ]

> > +static inline void thermal_zone_set_polling_delay(
> > +	struct thermal_zone_device *tz, int delay_ms)
> > +{
> > +	tz->polling_delay_ms = delay_ms;
> > +	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
> > +	if (delay_ms > 1000)
> > +		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
> > +}
> 
> How about one function instead?
> static inline void thermal_zone_set_delay_jiffies(int *delay_jiffes, int
> delay_ms)
> {
> 	*delay_jiffies = msecs_to_jiffies(delay_ms);
> 	if (delay_ms > 1000)
> 		*delay_jiffies = round_jiffies(*delay_jiffies);
> }
> 
> And then calling thermal_zone_set_delay_jiffies(&tz->passive_delay_jiffies,
> passive_delay)..
 
Yes, agree. I'll do this change.

Thanks for the review

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
