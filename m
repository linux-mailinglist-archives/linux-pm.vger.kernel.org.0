Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89E49D71
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfFRJfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 05:35:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfFRJfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 05:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dQlwP6TgFV6Zw9LFlDihP87ElJ/8VMPCPxi7yCL1r8w=; b=pq48uxiMn5mlvKmYy9OauMu6A
        cnGCav0BYetNzSYqRXXzGxeeRhiersbKStR0+QTN1W9zcjg84ZfzbTXEr3O20qjJHj9VGy39ltutB
        D/KdacOHXvzJM+9MInfNw5AYy3ijOFBCA6yfuYThdyoEmUfUcQfUNd6WhMF0F330mqd06UqsS9JGU
        8EVyFN7FDYWKgwAI1mY4wBzTLpWkMsITIPARSmd+Lf437jge4ctk+5FbcfPR4Jj2FyPpvfS3LJ4hU
        f/4FbbP3OGz6g172rV7AW0XkvUY9TJV2aizGSPNEFLaKPykKbsysdag5janafdDCe8B2ByjVasYll
        stMl0nGSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdAVz-0004g7-K0; Tue, 18 Jun 2019 09:34:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B3AE20A410E1; Tue, 18 Jun 2019 11:34:53 +0200 (CEST)
Date:   Tue, 18 Jun 2019 11:34:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, quentin.perret@arm.com
Subject: Re: [PATCH] sched/topology: remove unused sd param from
 arch_scale_cpu_capacity()
Message-ID: <20190618093453.GN3436@hirez.programming.kicks-ass.net>
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
 <c8030f30-0899-070b-df3c-3839ec7e1909@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8030f30-0899-070b-df3c-3839ec7e1909@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 17, 2019 at 06:07:29PM +0100, Valentin Schneider wrote:
> Hi,
> 
> On 17/06/2019 16:00, Vincent Guittot wrote:
> > struct sched_domain *sd parameter is not used anymore in
> > arch_scale_cpu_capacity() so we can remove it.
> > 
> 
> I think it can't hurt to give a bit of background. The *sd parameter used
> to be there for smt_gain, which got snipped out by:
> 
>   765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")
> 
> I'd appreciate having that commit mentioned in the log.
> 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Other than that, the changes look fine to me.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

The commit log now reads:

---
The 'struct sched_domain *sd' argument to arch_scale_cpu_capacity() is
unused since commit:

  765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")

remove it.
---
