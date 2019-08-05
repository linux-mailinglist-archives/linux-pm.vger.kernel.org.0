Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435B481B9E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfHENGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 09:06:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49536 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbfHENG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 09:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PnII+YXE7n7J38rlpSa/Fb4dxY+fA4dMk1niF5pnxoU=; b=swAhoi1jdI8iP/Oz0IDvKEhcr
        egaRPzrydwMFU5bxapj3A1IYPnT9RcdZHaHI3eSkyqE4HirxYPoZAMn3JMsITS7HYz/I+00QPf1/O
        P8nfalkAweBEYlGPmKSqHa9G6ttCzWkuzfsc6VPcicG3bSQrmZVPHsGoLttrTM5Rqns8MlKjNxCxr
        5pnmdYSpWW8/zA84zQ8f3kAb9zMA+FahL651cvYIXMp5FAV25MweH6aomduNFQRANnAdJChNQ6YRM
        7QfyuKra1KlH5KLxp34UGPwafyoMCBXvpdy5hV2TlTa9Db4Kt2891TwjyWvKny22yiXDPFArgtkHE
        Q1+JVTlvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hucgw-0008N6-6w; Mon, 05 Aug 2019 13:06:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1E4B202104DA; Mon,  5 Aug 2019 15:06:20 +0200 (CEST)
Date:   Mon, 5 Aug 2019 15:06:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
Message-ID: <20190805130620.GL2349@hirez.programming.kicks-ass.net>
References: <20190802104628.8410-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802104628.8410-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 02, 2019 at 11:46:28AM +0100, Qais Yousef wrote:
> scale_irq_capacity() call in schedutil_cpu_util() does
> 
> 	util *= (max - irq)
> 	util /= max
> 
> But the comment says
> 
> 	util *= (1 - irq)
> 	util /= max
> 
> Fix the comment to match what the scaling function does.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Thanks!
