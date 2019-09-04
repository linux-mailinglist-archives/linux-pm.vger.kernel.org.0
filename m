Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15CAA8418
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfIDNDY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 09:03:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34014 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDNDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 09:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2MLof/8M3zdWlEds/ZNBsOc7HjsrBhHVJc1nOPzW3qE=; b=Ndzdqfq1vg+rM4F89ARdzhUIQ
        DAkWDXxYcrsfs7o9P2GYCA3bN8dR/Kjz3MweNZ+z4nT/3ZoGKM4T6meXLU10CSWpkqVR4M+mLMJff
        /vRnAamV24CH+SuvFkWxqgSac8bdA4EwnXlDjCdqNuWGPg95z1Gtu1oa/rT8Pd3GzH2Je2QpyPMdJ
        PvzDs06Wc+HJLV04Jskl4PsKI6vHb2ujtw64A0kTjA+7VNZ4twW1+naP/C2+UPKgi6iuHJAKu5oyp
        HmxeNULb/dz3vvtRXLJfjLO2GMGrMmZAef7yrY9QNYyNKckUbV98qTWMVoxlRi5gFHjusPGOt6oe2
        ADjn14bFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UwP-0005VN-KT; Wed, 04 Sep 2019 13:03:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A44C306027;
        Wed,  4 Sep 2019 15:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B3FD29D9EB6F; Wed,  4 Sep 2019 15:03:16 +0200 (CEST)
Date:   Wed, 4 Sep 2019 15:03:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH] cpuidle: Consolidate disabled state checks
Message-ID: <20190904130316.GR2332@hirez.programming.kicks-ass.net>
References: <2136682.Ujdk25Y4fk@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2136682.Ujdk25Y4fk@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 04, 2019 at 12:41:23PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two reasons why CPU idle states may be disabled: either
> because the driver has disabled them or because they have been
> disabled by user space via sysfs.
> 
> In the former case, the state's "disabled" flag is set once during
> the initialization of the driver and it is never cleared later (it
> is read-only effectively).  In the latter case, the "disable" field
> of the given state's cpuidle_state_usage struct is set and it may be
> changed via sysfs.  Thus checking whether or not an idle state has
> been disabled involves reading these two flags every time.
> 
> In order to avoid the additional check of the state's "disabled" flag
> (which is effectively read-only anyway), use the value of it at the
> init time to set a (new) flag in the "disable" field of that state's
> cpuidle_state_usage structure and use the sysfs interface to
> manipulate another (new) flag in it.  This way the state is disabled
> whenever the "disable" field of its cpuidle_state_usage structure is
> nonzero, whatever the reason, and it is the only place to look into
> to check whether or not the state has been disabled.

Yay! That double disable stuff always confused me mightily. This seems
like a sensible solution for it.
