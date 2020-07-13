Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB44A21D3D8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGMKhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMKhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 06:37:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA8C061755;
        Mon, 13 Jul 2020 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W82iJGMfO440pPPQnVGiMPzx7rObJf7Be92yRAqb7gM=; b=iHQtSLsNkz+WKtG7bjX3F/XQT9
        O5AFbOlwliF7ClCowPR2VdXSV0k95XHSq0y1nIiuGO84mdOCwmXjbfXoQZnHMsWoyagDukSbx6/nP
        FD1hzBeJvr5PprGmpWREFAl1tt/toNCPJdvwRzzy26VqJtYejJXlrn9QNHKsi3yI76m09r5/srIj0
        b34fHhwswHURHtSXZaCUkCt4ZICnso+Ko5kef9ajS7mjpo1JfFZcQeAka8NbNJFACZvR4+4HxLH2u
        xAGPzE7yhfCZ8AxG1QmLipxFkVi/L7pzuXXzpNYdWLLpu9T/pZ0l40f61z1d22WLJw+NKcfGaBEfG
        +/gTWG/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juvpY-0000zi-F7; Mon, 13 Jul 2020 10:37:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2756B300DB4;
        Mon, 13 Jul 2020 12:37:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D92420D28B49; Mon, 13 Jul 2020 12:37:02 +0200 (CEST)
Date:   Mon, 13 Jul 2020 12:37:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 0/3] sched, arch_topology: Thermal pressure
 configuration cleanup
Message-ID: <20200713103702.GF10769@hirez.programming.kicks-ass.net>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712165917.9168-1-valentin.schneider@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 12, 2020 at 05:59:14PM +0100, Valentin Schneider wrote:
> Valentin Schneider (3):
>   arch_topology, sched/core: Cleanup thermal pressure definition
>   sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry
>   arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE

Thanks!
