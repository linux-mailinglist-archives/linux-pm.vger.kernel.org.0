Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7766045EA51
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhKZJ2B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 04:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhKZJ0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 04:26:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB9C061378;
        Fri, 26 Nov 2021 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CpX1HvR4mU1+Me5MeYYrd3vK1aWxISgGwlfvudo0zdQ=; b=rG7vZ09xWvNKg+PtGBFFp3B8O7
        KrmlTMdCDm472xeSxdhmhNlMfotkSPepmb4JGKIuh1FKle60MS/rmEIIDX00osGsL7d+5tU7YMWcG
        eBGyCU+mAtVrExabx/Hf1F9YPB4o0nnBAeAWuso6kgVUWdz2CfFxULg3JbZDnAdEd4DNSqp/bzN1h
        Xw906PBPnJCwS6eLKtrRso4iXbRvfPYzBAPhwPq0LyBtQv7Y8zrMGKdTAjzZhQqL3pKLh24ZhOXpY
        N+vCrM7fXM1E/MDLOxlJIHEervinQf3+ZwaGK9V0W+uLbP2iA4DPqXFriEPEgc1vWWy2lLtels8eJ
        U2/8Bo/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqXKE-009hsf-8X; Fri, 26 Nov 2021 09:15:22 +0000
Date:   Fri, 26 Nov 2021 01:15:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, quic_lsrao@quicinc.com,
        rnayak@codeaurora.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
Message-ID: <YaClqrvUDLzGV3Jn@infradead.org>
References: <1637831933-7449-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637831933-7449-1-git-send-email-quic_mkshah@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 02:48:53PM +0530, Maulik Shah wrote:
> Export cpu_idle_poll_ctrl() so that module drivers can use same.

Independ of the fact that this looks like a module that should not be
exported at all:  please always post exports with the actual module
using them, otherwise they are unreviewable and unacceptable.
