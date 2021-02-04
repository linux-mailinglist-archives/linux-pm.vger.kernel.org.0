Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08130EC28
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 06:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBDFmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 00:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBDFmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 00:42:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4280EC0613ED
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 21:41:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q131so1390366pfq.10
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 21:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCDGFq4xRBK5mgfCD5DBK7C/OlTDtGq3KySYxLnb6V0=;
        b=e5vgzHEOJTeTAfepoItU4E8Q4+EL3HLGsErqa8A12qTgtKvW2zwh0eW3rz25fl4Yza
         002S2DgGKiJL1Ry7CKyPoEHcNIMKsLz3cJOMPWHjbdr9w6Gq9uAZPMyEHk9g0Ja+hcmX
         6Mlm7Y99JzrU4djv0+xXxc15oZ5GOt2dwb/GDciH+6ATNh2Ep+YWqtrJTsyN7CgN9cgJ
         Uo2ozxZAh1+QpK4Vi4upH9fV/XhmPS2XFACFi1T9gF6sEIs//lDpA+RlqGdDX6uQqQyv
         tD4ioTmbvuCS5p89gJiNlrSj+pDKLHD4lzpCXntEq+E94XJy+hhmEhbRaA2iaq70gfLp
         rj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCDGFq4xRBK5mgfCD5DBK7C/OlTDtGq3KySYxLnb6V0=;
        b=RNVe8WZORAywSuZ3zl8vxFH4yiolTRTZcWhpxOTtwB2M/EhG15L0+9bMOiaoORQXJx
         8S5AGK88PWbnivD+nObwSD2mcb2h7WGyIFKMIEXACimTX77UBBV4+xq5SiV0dZ8T6FP3
         ifFW/jrsFWkcfvG7e2UC9tIFmDS+jBN20jKG9xzHCe7wt0Wzg5VVUZLArzW5FjwU5bfC
         8l5w/mHZL6aANNz86uhDwlsIhxR3OL+3WrHLCrszEZYr6Sagn2aImUHGHyCYKZvHfcKc
         n+77lSa0GxjEH5Il/uEx8lPN919mJQB9gM6xo9PC7t5mAD61D1E6eQxHIXhnm5q9cx+E
         ZhCw==
X-Gm-Message-State: AOAM5337goHoK1L2OuDgQvq3nB1cxVNOyhA1xTCfxDf4ThSTOZ8BxeQa
        pcPtegDYb4muowk4PmSpz/LXNQ==
X-Google-Smtp-Source: ABdhPJz+EIkvKW6QGPS/paYHE/y25MQxjPOSqBSAdpajYneGEMHYsouDucbelHEyI9TG4/cMV0Nx0g==
X-Received: by 2002:aa7:98c8:0:b029:1bc:4f59:4bc1 with SMTP id e8-20020aa798c80000b02901bc4f594bc1mr6439140pfm.72.1612417297692;
        Wed, 03 Feb 2021 21:41:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k10sm4423518pfk.0.2021.02.03.21.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 21:41:36 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:11:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v5 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20210204054133.sb6vymf56u43bpwe@vireshk-i7>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203092400.1791884-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-02-21, 17:23, Hsin-Yi Wang wrote:
> The devfreq passive governor scales the frequency of a "child" device based
> on the current frequency of a "parent" device (not parent/child in the
> sense of device hierarchy). As of today, the passive governor requires one
> of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.
> 
> When (1) is not true, (2) is the only option right now. But often times,
> all that is required is a simple mapping from parent's frequency to child's
> frequency.
> 
> Since OPPs already support pointing to other "required-opps", add support
> for using that to map from parent device frequency to child device
> frequency. That way, every child device driver doesn't have to implement a
> separate mapping function anytime (1) isn't true.

So you guys aren't interested in dev_pm_opp_set_opp() but just the
translation of the required-OPPs ?

I am fine with most of the stuff and I would like to take it via OPP
tree, hope that would be fine ?

-- 
viresh
