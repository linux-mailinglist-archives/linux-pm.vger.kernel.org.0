Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3432587B6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 08:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIAGAW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 02:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAGAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 02:00:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDFC0612A4
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 23:00:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v16so17696plo.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 23:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfNNJUqlo12EqEl+OZqmK3D7Dp4+eSw5NmHR85YZ3AE=;
        b=f9oKyBNl4lW+ONVYjUpKz1+clo6GSvJYPMw9ycWx5m89ci5i//YkPO1O+mHulx4/qm
         1BahhljIYUhGcNHEO7BGViJ/xOu+rCVudyAn/jYOdAnKcDa2mC9Clgq4BeJVZmoS/G0L
         OM35AFprOpZmMdAkhfZsM0umC+GFXroOHL9qznGkahrORRfBLG/LZIhcqFxE+jdWRfta
         KPh0b0DDDUDyZOM+4BK2TGGMAYOqfLUIsKjFb0KTg8jrZP6qbo94+0q+bUTVk4qQQnty
         7R66JOZ+/04wH2EZlIsljMENGy3OfT5STvUrIWzAuOIwY2OmgrlsdJuF8KJmqJIRa5J3
         8zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfNNJUqlo12EqEl+OZqmK3D7Dp4+eSw5NmHR85YZ3AE=;
        b=pGhBhMUVhux8znn2pbfeOStQ/IMNPFRY+zFdeD1Tnn8hIWbblnxxBp4vt7pT7iansZ
         zrmpAlqEbcxuvKHQQ8T5/X/8BB0WuUBiN6Nkuk6sK/7SsDw8pH80d+yiAgGusFstP404
         qwhXiwJgEqaL5sgX/Z9j6VW82sGTAjcQ24k/P0hprKSWfkVdo+S1iCeMMF3y1n5z2RmH
         6TIAxvNzqknyk1/A+495FoFHFcZV7JUGKMf27QkdkQJBYycnShugf4Uv3puXd5scS3YT
         w5RjdzYzshlU0qt+pib6Gm1E6RjlP9TGFIHZNOEO0tN3ZqX5pnzWvreAQ6QShzDBb9xK
         wo9g==
X-Gm-Message-State: AOAM5335tXNCVg7ZUPmUGd1PUGP5YMfdcCOZrXo85jKt6PqhkzOVLEvM
        JU995cQNxN/PF18neMYkOzQuGg==
X-Google-Smtp-Source: ABdhPJxML0AqWpoEUuGVmEbnBXr5j52FVANb+S4GiK9TUWQGhDXyWpp8+Ctn6UVM/8757wrBPlfcVA==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr67195pjo.74.1598940019489;
        Mon, 31 Aug 2020 23:00:19 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id u191sm553190pgu.56.2020.08.31.23.00.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 23:00:18 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:30:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200901060009.w6pkmbnxmjarvqcc@vireshk-i7>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200831121457.2v6avendroclvrn5@vireshk-i7>
 <20200831154938.GA33622@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831154938.GA33622@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-20, 17:49, Stephan Gerhold wrote:
> I appreciate it, thank you! But actually after our discussion regarding
> the "manage multiple power domains which might not always need to be on"
> use case I would like to explore that a bit further before we decide on
> a final solution that complicates changes later.
> 
> The reason I mention this is that after our discussion I have been
> (again) staring at the vendor implementation of CPU frequency scaling of
> the platform I'm working on (qcom msm8916). Actually there seems to be yet
> another power domain that is scaled only for some CPU frequencies within
> the clock driver. (The vendor driver implies this is a requirement of
> the PLL clock that is used for higher CPU frequencies, but not sure...)
> 
> I don't fully understand how to implement this in mainline yet. I have
> started some research on these "voltage requirements" for clocks, and
> based on previous discussions [1] and patches [2] it seems like I'm
> *not* supposed to add this to the clock driver, but rather as another
> required-opp to the CPU OPP table.
> 
> If that is the case, we would pretty much have a situation like you
> described, a power domain that should only be scaled for some of the
> OPPs (the higher CPU frequencies).
> 
> But first I need to do some more research, and probably discuss how to
> handle that power domain separately first. I think it would be easier if
> we postpone this patch till then. I don't think anyone else needs this
> patch at the moment.

Heh, okay, I can keep it out of my tree then :)

> [1]: https://lore.kernel.org/linux-clk/9439bd29e3ccd5424a8e9b464c8c7bd9@codeaurora.org/
> [2]: https://lore.kernel.org/linux-pm/20190320094918.20234-1-rnayak@codeaurora.org/
> 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > [ Viresh: Rearranged the code to remove extra loop and minor cleanup ]
> 
> FWIW, the reason I put this into an extra loop is that the
> dev_pm_domain_attach_by_name() might return -EPROBE_DEFER (or some other
> error) for some of the power domains. If you create the device links
> before attaching all domains you might unnecessarily turn on+off some of
> them.

Hmm, but that shouldn't have any significant side affects, right ? And
shouldn't result in some other sort of error. It makes the code look
more sensible/readable and so I would prefer to keep a single loop if
it doesn't make something not-work.

> Having it in a separate loop avoids that, because we only start powering
> on the power domains when we know that all the power domains are
> available.

-- 
viresh
