Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3095E45D7B5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 10:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353943AbhKYJ5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbhKYJzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 04:55:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF807C061746;
        Thu, 25 Nov 2021 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q9W6nbk9qafMhLY0YqRYIwMk+JEbPSTqLUIMJBGlKXM=; b=Vhewe5zs4XI7v1oVNyYbif7pEw
        2t4Pi0udOsuQt9qOg2C+Gs3R9B+ydbSzH1omWkU7bQn4/svrrVjabA9t0Xw7424n5NYfRiHiJy1so
        4NUqjiZOTLLtSv5mB6w3m2C0BWhGSpB+XeSIL5gkyK5V3J5d2hnVF4vxOOtpfZYkc7q6BGVewUBFB
        urbbXDaCb0oIqrDr1bOmAEuPcdUaLZiZCF5DIu4vItLA14h8/9LdUjuy/MxNlSel0tD6IavmFSWwJ
        khr5Hm5XP5a9cYdwR33784oE2PSgyRBYKcvJjNcqST1JxT+wrpt6e9nYFmG12qTiNvA4+BbHCVvxh
        uPHxiDwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqBPy-005mvF-Hb; Thu, 25 Nov 2021 09:51:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3097300093;
        Thu, 25 Nov 2021 10:51:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8C6A2027B00C; Thu, 25 Nov 2021 10:51:50 +0100 (CET)
Date:   Thu, 25 Nov 2021 10:51:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, quic_lsrao@quicinc.com,
        rnayak@codeaurora.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
Message-ID: <YZ9ctgCBYJEEjuwt@hirez.programming.kicks-ass.net>
References: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 02:44:36PM +0530, Maulik Shah wrote:
> Export cpu_idle_poll_ctrl() so that module drivers can use same.

This does not seem like a really safe interface to expose to the
world.

Surely the better solution is to rework things to not rely on this. I'm
fairly sure it's not hard to write a cpuidle driver that does much the
same.
