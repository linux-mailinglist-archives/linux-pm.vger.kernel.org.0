Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F96D65A1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbfJNOxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 10:53:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733046AbfJNOxX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 10:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aprOO2dgw1K43UzA/6LtwK92aryQcTNoIiM6Tk9Yuj0=; b=GcuQCSLcFZ4lgc/il9+oqzW/f
        4gUDA7S7Z3j1/6y7jQ6vbvJ/yTshB+YvutZLbxbH42VvXA8GhmXqbu24MXfUbEx1gAHSBwk8pNxO0
        QhXBbHHTtG5VRp9B5aDLijCZOmeDl+Q297LtT3NlY4DEvUV2ofghK2Xl/ebBLzJJSoqWyYwlpL5xd
        O2klhThUbQeYjh99M8U2dNfLzg0EzhSHj/4C4croiVT4MCZcBOB7EiRose7VfbheFjKGuu9e8oFrO
        /PtXVv9l9jdhywElSitniWBwbkWbakeT5IGI+MMt6gF2nneH8KPI008DHYaqVjdJslanDH8BHjgXJ
        2dZSJLjZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK1in-0002Bn-Rb; Mon, 14 Oct 2019 14:53:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4EB4305BD3;
        Mon, 14 Oct 2019 16:52:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D959A2023039A; Mon, 14 Oct 2019 16:53:15 +0200 (CEST)
Date:   Mon, 14 Oct 2019 16:53:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011134500.235736-1-douglas.raillard@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 11, 2019 at 02:44:54PM +0100, Douglas RAILLARD wrote:
> This has been ligthly tested with a rtapp task ramping from 10% to 75%
> utilisation on a big core. Results are improved by fast ramp-up
> EWMA [1], since it greatly reduces the oscillation in frequency at first
> idle when ramping up.
> 
> [1] [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
>     Message-ID: <20190620150555.15717-1-patrick.bellasi@arm.com>
>     https://lore.kernel.org/lkml/20190620150555.15717-1-patrick.bellasi@arm.com/


I don't really see anything fundamentally weird here. Any actual numbers
or other means of quantifying the improvement these patches bring?
