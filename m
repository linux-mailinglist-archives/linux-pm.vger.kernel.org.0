Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE82426A3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHLIUT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgHLIUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 04:20:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D44DC061787
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 01:20:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so755409plr.7
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igrwOs5BXdzFng9lpBaC8fjOPPwu57+v42SpgMKbqgU=;
        b=ekQqof34/jYII1w6eBa5yIVw96SVBqqiPBeqi1r8kNGotFvG8q3FaMHTpLsluhhoq/
         ApxVRamFwOA/nterYJKvHNHF1SJQaIZc5AAJSgEXuPxNUbYw9x8Ig5LYe5k+A6iRXC5d
         Y+L1ZRGSoRqHakcIZeh/nyGzfuZvlM2g/3g2jM73/1LwYrPpgWSIEYYO1aBDohQ1wBMl
         5KyQux2z4InuWHfQJlZOdbFcuTTgJdoHl2VGxjf+aaH+WOnpAdTJ3QdrTW9MAQZCdR1E
         f8snFe8Jn4hcZcWz56vApw3ValbNLHpqDan9voCXY3MrKmi5baBv8X1azIUcX1/4EaIH
         JU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igrwOs5BXdzFng9lpBaC8fjOPPwu57+v42SpgMKbqgU=;
        b=SMpXKxMU0zyND8CflL1flbxJTu/ZFiZfTHIrdcyMqBgQyopvKoXtQUelmMiFV6PSDg
         TuJ5BgZvHJAzgdH+eVnjJCr2oTcmyxDgMFUOVm4WhbMCqh0vNawTBvsfgMWTCEsOfItc
         yqLvcWAgi3JjH62aNepPcaoxa7/XxyjYPbCYh6YHxYLMJBAxvmDzJQw/RGfetJscfJBc
         49Nwl1kmygv6nfyl31LIa6AYX/v//DkxzEsX+sJVT601DNbQdaKCFDgDtZxgUUiwmiTD
         acFOegRiFjYwvB+yjrWlvkcAu1Sbb8WHA6VJynxPTHa69fVof+/H06tlhucJYPr9z6fm
         PxEg==
X-Gm-Message-State: AOAM533bzu3VYR7R0UCQcvmSQ0DyANo1l4BdZu89DHb2iy6Cn2menIYi
        6gI7JLRQ9SWMECkHB8lDR5enRg==
X-Google-Smtp-Source: ABdhPJxPwOmfgTz1iL8sWxWSIdNppBzTK3OVbY8JYR/pC5JUmKvQqsmT/mvySzfjGAVPo8AAxC5GVw==
X-Received: by 2002:a17:90a:4e42:: with SMTP id t2mr4927711pjl.121.1597220416855;
        Wed, 12 Aug 2020 01:20:16 -0700 (PDT)
Received: from localhost ([122.161.126.124])
        by smtp.gmail.com with ESMTPSA id o17sm1429142pgn.73.2020.08.12.01.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 01:20:16 -0700 (PDT)
Date:   Wed, 12 Aug 2020 13:50:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] OPP: Put opp table in dev_pm_opp_set_rate() all the time
Message-ID: <20200812082013.64xc6hmt4nchcmab@vireshk-mac-ubuntu>
References: <20200811212836.2531613-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811212836.2531613-1-swboyd@chromium.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-08-20, 14:28, Stephen Boyd wrote:
> @@ -905,7 +907,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  		ret = _set_opp_bw(opp_table, NULL, dev, true);
>  		if (ret)
> -			return ret;
> +			goto put_opp_table;

This was broken by a different patch.

Fixes: b00e667a6d8b ("opp: Remove bandwidth votes when target_freq is zero")

I did split the patch into two and applied the correct tags (not yet
pushed though).

-- 
viresh
