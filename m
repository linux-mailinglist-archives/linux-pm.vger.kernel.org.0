Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8783AAA90
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbfIESHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 14:07:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfIESHZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 14:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/YHGZhNkmcsx1NPPoqx+Bbf6Jpti46dNPrsa5dPeUfg=; b=TyPaxgvWyB/uMSa7rfCkZh00Q
        AhIbiI8qWlStN/k3aMCgeSU3ById4HB0ZLI8w4vxKDx0L0y3ZAqTxxXDYDReIXwZ/xn5Goh435288
        guhQkpZU3+OGMRDzXNBi3XtA9cZLn/QN+egWnIH0LpGSxqHXD8nbrIdCTQbsSXm1L220xSvcSe2wr
        0ttmcoODPS/Gj3zKEQ1APyy6xPH7SUzAKkYdKiyCsJOgVYMHFrTSxCxkKgYAl+1ygkJmqiexFB3GX
        NUjGa+/UWAoEg9Vq5G8cAK22oV3nI8caBM89qTx1rkdFIbm/psWW2w3sRZ95hukacAKlS7FhP7lpu
        W9QDxpBSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5wAC-0002bi-Io; Thu, 05 Sep 2019 18:07:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE725306044;
        Thu,  5 Sep 2019 20:06:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E27C429D3538E; Thu,  5 Sep 2019 20:07:16 +0200 (CEST)
Date:   Thu, 5 Sep 2019 20:07:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH] cpuidle: Use nanoseconds as the unit of time
Message-ID: <20190905180716.GQ2349@hirez.programming.kicks-ass.net>
References: <4106941.QTENAb3AiO@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4106941.QTENAb3AiO@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 05, 2019 at 06:34:49PM +0200, Rafael J. Wysocki wrote:
> The patch is rather large, but mostly straightforward.  There is a rather ugly piece
> in the menu governor that first computes the expected idle duration in ns and
> then converts it to us just in order to compute the typical interval value, and in
> case that is less than the original expected idle duration value, converts it to ns
> again.  However, if there is a nicer way to do it, I haven't found it so far.

	predicted_ns = div64_u64(data->next_timer_ns *
					data->correction_factor[data->bucket],
				 RESOLUTION * DECAY);
	predicted_us = ktime_to_us(predicted_ns);
	/*
	 * Use the lowest expected idle interval to pick the idle state.
	 */
	typical_us = get_typical_interval(data, predicted_us);
	if (typical_us < predicted_us) {
		predicted_us = typical_us;
		predicted_ns = (u64)typical_us * NSEC_PER_USEC;
	}

Yeah, that is a bit yuck.

The first part:

	predicted_ns = div64_u64(data->next_timer_ns *
					data->correction_factor[data->bucket],
				 RESOLUTION * DECAY);
	predicted_us = ktime_to_us(predicted_ns);

can of course be written like:

	predicted_us = div_u64(data->next_timer_ns * data->correction_factor[data->bucket],
			       RESOLUTION * DECAY * NSEC_PER_USEC);

Since RESOLUTION * DECAY * NSEC_PER_USEC is only 8e6, that doesn't need
to be a u64, so u64 / u32 is sufficient and cheaper.

(looking at the original, you did loose the ROUND_CLOSEST bit, which can
trivially be restored like:

	predicted_us = div_u64(data->next_timer_ns * data->correction_factor[data->bucket] +
			(RESOLUTION * DECAY * NSEC_PER_USEC) / 2, RESOLUTION * DECAY * NSEC_PER_USEC);

So that reduces from: u64/u64 + u64/32 to u64/32, which should be lots
on 32bit.

After that it then becomes:

	predicted_ns = (u64)min(predicted_us, get_typical_interval(data, predicted_us)) * NSEC_PER_USEC;

Which is an unconditional multiplication with a constant, which is loads
better than divisions.


Granted, it's still not pretty, but it should be faster than it was.

(this all assumes the initial multiplication doesn't overflow due to now
using ->next_timer_ns of course)
