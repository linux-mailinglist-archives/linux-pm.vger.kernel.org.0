Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EAD3BE619
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhGGKFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGKFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 06:05:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18587C061574;
        Wed,  7 Jul 2021 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lcapCN48fsJkIvRKO2zKEWUzLtifLzkbUYXcK15Ll0M=; b=X/TzKhIOPpGn7DHzSiGl+I8O5C
        hxl/Y9N1th1qdP/9wfBI/pElj+XP6RIq+tNliaWhM057QqKxVntqMkWGbBMyl85aN8NUsbxuUNcLd
        QT+ukRXHxsNrTxyQ2+RfiKOhu2ZeFP7GB+zqo3/vCJIFeqZCaVtppfxbK5U1kXH62AbCu7DtZRwYL
        iR7X+1UGo+Z04ILwdvkXyr09dc4mZcvbIqkcLgF3Yz7sO/yt+C1GSAIzEp5cL2ynF5VDuXtrm1j9u
        fwSA/YBLnqpG+HonLWltKfP6cBhF8VyNnCgkxRUFTOoGJDY87eC3UCsmZFtzHirNpZj7qQrutm++Z
        ai0p29Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m14NA-00CHg5-8U; Wed, 07 Jul 2021 10:01:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD73230007E;
        Wed,  7 Jul 2021 12:01:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77E6F2CAC4F58; Wed,  7 Jul 2021 12:01:38 +0200 (CEST)
Date:   Wed, 7 Jul 2021 12:01:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, Chris.Redpath@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        CCj.Yeh@mediatek.com
Subject: Re: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger
 values
Message-ID: <YOV7gt67DyYXtBkF@hirez.programming.kicks-ass.net>
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-3-lukasz.luba@arm.com>
 <YOVSu08LpHX5cx/+@hirez.programming.kicks-ass.net>
 <ca9853d1-5ff2-bdac-7581-61bffa3fdaaa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca9853d1-5ff2-bdac-7581-61bffa3fdaaa@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 07, 2021 at 09:09:08AM +0100, Lukasz Luba wrote:
> For now we would live with this simple code which improves
> all recent 64bit platforms and is easy to take it into Android
> common kernel. The next step would be more scattered across
> other subsystems, so harder to backport to Android 5.4 and others.

Ah, you *do* only care about 64bit :-) So one option is to only increase
precision for 64BIT builds, just like we do for scale_load() and
friends.
