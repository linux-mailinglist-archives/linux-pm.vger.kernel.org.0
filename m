Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3C265D72
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgIKKLm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgIKKLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 06:11:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA6FC061573;
        Fri, 11 Sep 2020 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umcv72hVeqRy+ZfPMQNst+rARjCfIv3n0RiQnMC5nD0=; b=YDbZsh5FiUvnSSjaDUcu6mZili
        UCeD1nwSyzW1KmXsmXKAFxoSoS59iXWZCgqZq1pYgW9eiDZ02vIba1e+8bfMz8Fn68TpziORngXTl
        2KTTmUNrleZSmXhq1K+hXJhEbtw+oTwh7bo/CD+Jxy8sNX0Fw1Z7phN9AcLoaEASC/xeIRIuJsDzF
        xBgF+7E3Es5YszzwePO/CMI4lpQEg+j2DZcVvj6Vj3aK35Ab6+PHksBnZ+jQZcEYWzRixUzcsGOBb
        z0zxOgrCqMerNo4n6bj2xY7Tnqmg/4k2SMSp95ZFMvwEsAcLlO0YseeRSIeVymXgt66a8qOoTLo1M
        1zWTIbYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGg1m-00024J-5E; Fri, 11 Sep 2020 10:11:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E05D03050F0;
        Fri, 11 Sep 2020 12:11:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C54972B06B004; Fri, 11 Sep 2020 12:11:32 +0200 (CEST)
Date:   Fri, 11 Sep 2020 12:11:32 +0200
From:   peterz@infradead.org
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200911101132.GC165568@hirez.programming.kicks-ass.net>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
 <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 02, 2020 at 12:54:41PM +0530, Viresh Kumar wrote:
> +	atomic_t reset_pending;

> +	atomic_set(&stats->reset_pending, 0);
> +	if (atomic_read(&stats->reset_pending))
> +	bool pending = atomic_read(&stats->reset_pending);
> +	atomic_set(&stats->reset_pending, 1);
> +	bool pending = atomic_read(&stats->reset_pending);
> +	if (atomic_read(&stats->reset_pending))

What do you think atomic_t is doing for you?
