Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03942447C71
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 10:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhKHJD6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhKHJD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 04:03:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F355C061570;
        Mon,  8 Nov 2021 01:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FzM8qSFY0zQQQfksibg27pvdfAM5iEzRGUbH+QhUlQE=; b=jGIFB3r4hyLCG8fJt6TPktHCpM
        GhX88zXQeOPiLn01k4xFVaP6ysm93Y2lR+7wkUXr9W1qcGJswrsJ+RMFJF6lZ1ssaWB9oRU1SkAmZ
        +uqXUKs9EtBvjh0gfOXYPG0DEgc8FHsNA40a4T/yBLRUvFOHMCTcKHmlCj71V7PDg+bMwnOuMhJ/L
        sjol8WEB5wvPW2rKOisBvK01kgFHRXe7dB/GlNPvvNWU6cXP2LhpUdDiVHagKG1Cn7hEw+W4SEYbd
        +nyHQ+TqPZb8s073nBb4LaQn4mGuIH54DiJCyARFqZrv/GqlrTugfvPsROi6OxU4qlwFHg097OZMv
        8S1/V6rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk0WX-00ErA1-5s; Mon, 08 Nov 2021 09:01:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA8E23000A3;
        Mon,  8 Nov 2021 10:01:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73107200C6B85; Mon,  8 Nov 2021 10:01:04 +0100 (CET)
Date:   Mon, 8 Nov 2021 10:01:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] thermal: intel: hfi: Enable notification interrupt
Message-ID: <YYjnUM/v8LmtnBq3@hirez.programming.kicks-ass.net>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 05, 2021 at 06:33:10PM -0700, Ricardo Neri wrote:
> +	/*
> +	 * On most systems, all CPUs in the package receive a package-level
> +	 * thermal interrupt when there is an HFI update. Since they all are
> +	 * dealing with the same update (as indicated by the update timestamp),
> +	 * it is sufficient to let a single CPU to acknowledge the update and
> +	 * schedule work to process it.
> +	 */

That's pretty crap hardware behaviour. Is there really no way to steer
these interrupts?
