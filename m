Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982C6AC410
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCFO4A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 09:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCFO4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 09:56:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33B21965
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c3VNR6ZfSMfA14ckjjdzDL5bA2rbE0rXpjU1FXjDebg=; b=q+l4RDJ0mFD2Kr/y630/uDpYay
        WIIrfbUY98iSzjrRTW5eK6HoSSUZC08Wq9pEfCCA/sxVQ1vP5+Rh678rW05YsVfaG6jxeasJgrbhW
        llUTCXvqd9pxRoK6iufMSXDTjSh9OXjyfBKOa2bRT8gMy+fzCU+GDqnWHA3v1Ti2m9+9tiLSkjL3I
        NURaThogBC46CLGJcidlWytTitoRxOWB4qtJ8c5MElY1S90AKWOOe2FWYhrrwSl6hGt9tv0z3WLfJ
        +gwNgOR0mS4ysYlO14NEj9Vb0VCQnPI/FfK+GYd2WrNZVApWHFdRU8maOG126XmTQ91AAZ+iZ9n5W
        fdpfcZxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZCFJ-005QVZ-36; Mon, 06 Mar 2023 14:55:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EF7A30002F;
        Mon,  6 Mar 2023 15:55:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36A662121152C; Mon,  6 Mar 2023 15:55:24 +0100 (CET)
Date:   Mon, 6 Mar 2023 15:55:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/mwait: Add support for idle via umwait
Message-ID: <20230306145524.GF1267364@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
 <20230306123418.720679-2-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306123418.720679-2-dedekind1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 06, 2023 at 02:34:16PM +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> On Intel platforms, C-states are requested using the 'monitor/mwait'
> instructions pair, as implemented in 'mwait_idle_with_hints()'. This
> mechanism allows for entering C1 and deeper C-states.
> 
> Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later C0.x).
> These idle states have lower latency comparing to C1, and can be requested
> with either 'tpause' and 'umwait' instructions.
> 
> Linux already uses the 'tpause' instruction in delay functions like
> 'udelay()'. This patch adds 'umwait' and 'umonitor' instructions support.
> 
> 'umwait' and 'tpause' instructions are very similar - both send the CPU to
> C0.x and have the same break out rules. But unlike 'tpause', 'umwait' works
> together with 'umonitor' and exits the C0.x when the monitored memory
> address is modified (similar idea as with 'monitor/mwait').
> 
> This patch implements the 'umwait_idle()' function, which works very
> similarly to existing 'mwait_idle_with_hints()', but requests C0.x. The
> intention is to use it from the 'intel_idle' driver.

Still wondering wth regular mwait can't access these new idle states.
