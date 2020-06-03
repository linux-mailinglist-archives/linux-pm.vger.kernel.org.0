Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662B1ECFC8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgFCMb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgFCMb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 08:31:28 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62077C08C5C0;
        Wed,  3 Jun 2020 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1R/2YdAZSvt3VyvYBxysqrGCsIyLuWCrDG39UYVf7Wo=; b=B5HfY2k7oWgDgwYI4Ho2MRl72v
        qRcxT5aVUTiZPip/orNqNpF2m5BQLkMvGTG/FQRd5dR00vVEVUv+s+GOWOrVY855oa3PQTYNmiDAt
        Rwbv3/Kw7Ne/csOfPykzVrbSrLpQ7KLWd6ShCnyfDYwKjXkGPV2DzfKs9UW+jC6NyEzb0R1o3Qfps
        /QSf2uDzRTGeaBa5itJc6lBDDJ/LjgaFzGLfHnj4V2Kfw0mRDNDVYH7ptFqDv/ZMUOlg+UQCyiC8h
        26OdfkOmk6iopJPpDhdl/qI+e029JYR0Vxomnpz64CpaX5WFJB+RAcatXi2HfLZ9cxj7AL94feeO0
        Yz5hLKtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgSXx-0006oY-9w; Wed, 03 Jun 2020 12:31:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 277C4301ABC;
        Wed,  3 Jun 2020 14:31:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11B2B20BDBF72; Wed,  3 Jun 2020 14:31:03 +0200 (CEST)
Date:   Wed, 3 Jun 2020 14:31:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v2 0/3] More frequency invariance fixes for x86
Message-ID: <20200603123103.GI2604@hirez.programming.kicks-ass.net>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531182453.15254-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 08:24:50PM +0200, Giovanni Gherdovich wrote:
> changes wrt v1:
> 
> - add Peter Zijlstra's code to check for multiplication overflow, see
>   https://lore.kernel.org/lkml/20200501133042.GE3762@hirez.programming.kicks-ass.net/
> - put all frequence invariant code behind CONFIG_X86_64, as the overflow
>   checks need 64 bits operations, see the build error at
>   https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/7GDIBOMNVDG5W2XZD4EICE2TUZR3THBN/
> - add additional patch to check for when base_freq > turbo_freq,
>   suggested by Peter Zijlstra at
>   https://lore.kernel.org/lkml/20200501130427.GD3762@hirez.programming.kicks-ass.net/

Thanks!
