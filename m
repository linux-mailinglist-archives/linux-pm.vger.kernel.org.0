Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5842B1CA99D
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 13:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHLc0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 07:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHLcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 07:32:25 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81001C05BD43;
        Fri,  8 May 2020 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NWlroRPhjKXWBXk+E3h0bugl1afjnkqbnRZaxRthnJY=; b=djTopVknrfMScTGAEreoTA7YRZ
        oVxe/HCGGD8pXVy77wrHCrzjMNhEpHJ+Uu0Koet8yKnyHMTysGpWyls3CM5HDO+hviqfsUM53Q2lJ
        O2C550g2AAOVcuDETBXlbuu5gWfCxm2Y6ro9uA5UtjpR/S1ak4/GSCefURk4HMcrF8USwjR/9/Fmy
        UKYLe5Nx1pRBhj/SjdCmQDwTrUDpNiioc1yq9tH4s3S7C2X58DGtKnGZvJkbs76AabQFdP11IctOd
        M52V2sDLzMwQ965nKGlufMhZaFy0pZuSN+3HmcIeLYV1nu8z/6M3P4JkgYIzNpj2r6vGypoe+VB1Y
        S/H/Oc8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX1EG-0008Dt-28; Fri, 08 May 2020 11:31:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 305CB301DFC;
        Fri,  8 May 2020 13:31:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14DE82B8CAD85; Fri,  8 May 2020 13:31:41 +0200 (CEST)
Date:   Fri, 8 May 2020 13:31:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508113141.GB5298@hirez.programming.kicks-ass.net>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508111612.GA252673@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 12:16:12PM +0100, Quentin Perret wrote:
> However, the point I tried to make here is orthogonal to that. As of
> today using another governor than schedutil is fully supported upstream,
> and in fact it isn't even enabled by default for most archs. If vendors
> feel like using something else makes their product better, then I don't
> see why I need to argue with them about that. And frankly I don't see
> that support being removed from upstream any time soon.

Right, it'll take a while to get there. But that doesn't mean we
shouldn't encourage schedutil usage wherever and whenever possible. That
includes not making it easier to not use it.

In that respect making it modular goes against our ultimate goal (world
domination, <mad giggles here>).
