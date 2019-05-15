Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CC1F8DE
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEOQoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 12:44:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfEOQoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 12:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ezG1QqiXOsGRIp+0lQFxeCPHGaBgx8UHJEuCr5YONE=; b=klUG8QeFGmsCRjeSJK/tDVlTy
        tdK1XAdGw7GzfngQy2PAeSbPud32JoJrsqrb6OxUAzgnTVOTk9XWdXB3jg0kXcG9QBwxxeiRZOyBP
        sH9afp9Ry4qtgzgHVgawvA3OzeZekW+/t8pwgbm8/68eQADOWqIQaD2kSrtzy80mJtw6IUzZzEC/2
        YjIowxQ9cYpgIAFOTXpo+cFxOrxzDLUKJUnXmn5MlHF4Y8Aon4c6iVjsqPXCxI3DsW7ousEEJLYEC
        Zsu4XJKw2tiMsWLI6bH63HdsKUH0kxBLcB5E68MpnvVpnqJ89CDLsX/YgJxuba5vN/Edzvr4JIgxu
        P9zslws4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQx0p-0007zE-MC; Wed, 15 May 2019 16:44:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 302932029906B; Wed, 15 May 2019 18:44:14 +0200 (CEST)
Date:   Wed, 15 May 2019 18:44:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 6/6] sched/fair: Bound non idle core search by DIE domain
Message-ID: <20190515164414.GY2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-7-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-7-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:22PM +0530, Parth Shah wrote:
> This patch specifies the sched domain to search for a non idle core.
> 
> The select_non_idle_core searches for the non idle cores across whole
> system. But in the systems with multiple NUMA domains, the Turbo frequency
> can be sustained within the NUMA domain without being affected from other
> NUMA.
> 
> This patch provides an architecture specific implementation for defining
> the turbo domain to make searching of the core to be bound within the NUMA.

NAK, this is insane. You don't need arch hooks to find the numa domain.
