Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08572265ED8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIKLgJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgIKLf5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 07:35:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDCC061796
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 04:35:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so6438116pgm.11
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KycsOi7S4N/nBLooPbnXXSV4SR9wjUe6iCxexLVUCD0=;
        b=k2uKWpn7H//jNXvjMwXc7Bg+qjc/gvdqG5U6MePPIbX38khfArh8ol3jLT/BX51pKG
         1v3YBzNb6OY1HA4cCTarS0p2U+55oNdx8wHzNQNTdywjvXUqeX/T4Qq+Oo0nJdqLEXXv
         NLFLJmbh7joqZC21BYFlrWwOj8MNI6mtyde2GPs21/0qXrWNq4j5+y0EZV30oAhGjQR8
         HWyipnRynroPOf5h4JwI4Z1gvd3kOMjgdK7af+zgdR2RTV0cgrTXPRuV3X6PgZDGhgKX
         qqw3ySvUcUtBVOcxCTYsHvaNH0OODb0Y491W60rm+Pt+6mqkz64QwIHWHFJPou1RbwiX
         jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KycsOi7S4N/nBLooPbnXXSV4SR9wjUe6iCxexLVUCD0=;
        b=YDiC57fnJcNCTfMbOmFzya+XtyKqhEBbodRC2kDDG6ylBKtaMLir78og8LzHX/lGik
         qgvfC4iHe5ytT3QZaFRG7ErsqOy5fZRhgnDKdcLsZhL0oiXZs0eCs8EWQ9h4fio8tZf2
         48LgdvSCVBNnDwSyOm7K7K70+WLtUIy4JlRUGg40ii30PAEpql1mevYhNdJfNjahAeSO
         1xfTpU3djYmuI0/LTYeiaoRZE+7P+sKb694b7CMCXrZxkZuil0FNYrKuQgCsMgjhu1vI
         pHdgPrYI45nfKHfuaC7KmrfBx+Kw/efZkxLHrGILfRmDZ2B9OHyF4cGtIJ/sUXNay0zf
         fkzA==
X-Gm-Message-State: AOAM5326Ne73NHWiKs86jiiEUB9cU8w243HToN17Kp/Itg6CM0t7TRoO
        m3O7lEGQonu9dd461b+vO7cW2w==
X-Google-Smtp-Source: ABdhPJyyXvGwFaQdsNQbM6++Ut33lLn/dd07b1UkP/3vxznU7kfEoDReiBe9Y7J9oQkDfJu82o1sSw==
X-Received: by 2002:a17:902:c151:: with SMTP id 17mr1638319plj.49.1599824136816;
        Fri, 11 Sep 2020 04:35:36 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z4sm2109200pfr.197.2020.09.11.04.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 04:35:35 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:05:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peterz@infradead.org
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200911113532.zq2bou4swixb2ymk@vireshk-i7>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
 <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
 <20200911101132.GC165568@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911101132.GC165568@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-09-20, 12:11, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 12:54:41PM +0530, Viresh Kumar wrote:
> > +	atomic_t reset_pending;
> 
> > +	atomic_set(&stats->reset_pending, 0);
> > +	if (atomic_read(&stats->reset_pending))
> > +	bool pending = atomic_read(&stats->reset_pending);
> > +	atomic_set(&stats->reset_pending, 1);
> > +	bool pending = atomic_read(&stats->reset_pending);
> > +	if (atomic_read(&stats->reset_pending))
> 
> What do you think atomic_t is doing for you?

I was trying to avoid races while two writes are going in parallel,
but obviously as this isn't a RMW operation, it won't result in
anything for me.

Maybe what I should be doing is just READ_ONCE()/WRITE_ONCE()? So the
other side doesn't see any intermediate value that was never meant to
be set/read ?

-- 
viresh
