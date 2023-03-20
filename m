Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F956C159B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 15:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCTOwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCTOw0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 10:52:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCEE25E32
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2cVWReUG5GEkCYzV4yscBCxRCAtz4rEYtmBQFB2xWkg=; b=emYa6+uW0DEbCfW2Rw5lCwiE1y
        ZDDMt4UVCdcTZqWGhvhEhC1T0HAKRnzzhqUUof3nHRbQP5Ev9A7kOc21VD+7MNiD0AIpk8GmIz8rJ
        1Q6qAxZYjJyeyzM9Ctw/TWYmBPNP/XIgaDABthu8oPdBSkRqiYpcsUxVo09qbmyZysYAOUYKqfoT6
        PZ91wPrvEvOUwziPJMLzOruQndIkROewvfEsRkQftCYDvwGwnhst0F/HIICOVk8h8QEiBK846Mn0B
        KhPFxEUxS97JTSVtyKcB+IEosI3BCFCRNa7fIineWIfCT0DfpOecyB26pwCUcQOMAFV47ZIcTjEj+
        9FKvuzwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peGqL-00181m-DJ; Mon, 20 Mar 2023 14:50:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB99B300288;
        Mon, 20 Mar 2023 15:50:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87AE520EEFFC4; Mon, 20 Mar 2023 15:50:34 +0100 (CET)
Date:   Mon, 20 Mar 2023 15:50:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids
 Xeon
Message-ID: <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
References: <20230310122110.895093-1-dedekind1@gmail.com>
 <20230310122110.895093-4-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310122110.895093-4-dedekind1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 10, 2023 at 02:21:10PM +0200, Artem Bityutskiy wrote:
> +/**
> + * umwait_limit_init - initialize time limit value for 'umwait'.
> + *
> + * C0.1 and C0.2 (later C0.x) idle states are requested via the 'umwait'
> + * instruction. The 'umwait' instruction requires the "deadline" - the TSC
> + * counter value to break out of C0.x (unless it broke out because of an
> + * interrupt or some other event).
> + *
> + * The deadline is specified as an absolute TSC value, and it is calculated as
> + * current TSC value + 'umwait_limit'. This function initializes the
> + * 'umwait_limit' variable to count of cycles per tick. The motivation is:
> + *   * the tick is not disabled for shallow states like C0.x so, so idle will
> + *     not last longer than a tick anyway
> + *   * limit idle time to give cpuidle a chance to re-evaluate its C-state
> + *     selection decision and possibly select a deeper C-state.
> + */
> +static void __init umwait_limit_init(void)
> +{
> +	umwait_limit = (u64)TICK_NSEC * tsc_khz;
> +	do_div(umwait_limit, MICRO);
> +}

Would it not make sense to put this limit in the MSR instead? By
randomly increasing the MSR limit you also change userspace behaviour vs
NOHZ_FULL.

That was part of the reason why Andy insisted on having the MSR low.
