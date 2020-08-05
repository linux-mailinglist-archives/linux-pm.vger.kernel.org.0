Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAED23C799
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHEIPy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEIPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 04:15:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED478C06174A;
        Wed,  5 Aug 2020 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O9maNZgxo9jG14qKmejuN27LhV8t5XITkhKE0XSd29E=; b=jFS7DMDh25OL9yC/twevC8JZBM
        ceBuRQ2PJnyXbv98USNDdcIfSF91o2AdMye0v3SbkljZF1DbjEXBSrV+hOqKiP0ddDHiNynFY0cHw
        viv7hgykkDIA1XEFjmaFABC+Yk+zQ0Wdx65zLDIaCiU2wG6pthEqj+NytzrffvrnceAs9R94xv8EM
        HPqT6PrZ/OHdUNFvVH2GD2dMTuIANBTevZQhGIQ4uV8Sl8qzpbo7IbFchKrmglloSXsW8WDM71Npy
        N8FP3PkXwr1/Jl8Ig1Uc6jhJ/PnCcJFnt8+8XCAKLp9AlPTsLp8+3o8otfz+Nkob62iTQn7PsOSY6
        LNilp1Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Ea9-00061h-Ha; Wed, 05 Aug 2020 08:15:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B958301EE3;
        Wed,  5 Aug 2020 10:15:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F7A42C3020ED; Wed,  5 Aug 2020 10:15:23 +0200 (CEST)
Date:   Wed, 5 Aug 2020 10:15:23 +0200
From:   peterz@infradead.org
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: Re: [PATCH v5] sched: Provide USF for the portable equipment.
Message-ID: <20200805081523.GN2674@hirez.programming.kicks-ass.net>
References: <cover.1596612536.git.yangdongdong@xiaomi.com>
 <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbd9a487176a05588e33ff660d4e58efa1fdb10.1596612536.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 05, 2020 at 03:36:21PM +0800, Dongdong Yang wrote:
> +config SCHED_USF
> +	bool "User Sensitive Factors for Scheduler"
> +	depends on CPU_FREQ_GOV_SCHEDUTIL && FB
> +	help
> +	  Select this option to enable the adjustment on the cpufreq with
> +	  the user sensitive factors on schedule. It is special for mobile
> +	  devices which more power care and quick response requirement on
> +	  screen on.
> +
> +	  If unsure, say N.

You're still suffering all the same problems, still NAK.

Read carefully: "we do *NOT* do special case hacks"

If you keep sending the same stuff over and over, you'll be elegible for
an entry in my mailfilter.
