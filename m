Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7652E2B5
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfE2RA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 13:00:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2RA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 13:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rql5GG/ybmT6SurmXd44Bjbh2qIVyT0VkM96NAFNiuY=; b=jdAco6Qh4fkIH/71oUSSsoO7u
        lk/BCu4M3STYvMP8qWc8qxfDNG9NRTTOJthuMX6pFjkDv51ePcJUUZhFoyOOUBAcneWneFAPIznKI
        uPXl855Y50siczUlOJg0ioKM4UHriKcxQK1MM2/2yL5RKdv/zePr5OceUBlFl3fnwwDpHMa2PH9pi
        SQ383xI5o8py9HY8VmcxItqK50zXYQOUehWpRfyEfVZAe6bA2Nh4Y/Qy7Va8E4pnJiQ9z8pb8iCs7
        62/VcszK1uGMGe11Xy1e/cqBxPwvdYlJtzbkG6piUKJX6sQ0HEuvkaADhVIhIgQu66bcKacREQJLZ
        X3LzfNL8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW1wX-0001KV-Ov; Wed, 29 May 2019 17:00:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 281D7201B8CFE; Wed, 29 May 2019 19:00:48 +0200 (CEST)
Date:   Wed, 29 May 2019 19:00:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190529170048.GD2623@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
 <20190529161028.a6kpywzpjazgql5u@treble>
 <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 29, 2019 at 06:26:59PM +0200, Jiri Kosina wrote:
> On Wed, 29 May 2019, Josh Poimboeuf wrote:

> > Is there are reason why maxcpus= doesn't do the CR4.MCE booted_once
> > dance?
> 
> I am not sure whether it's really needed. My understanding is that the MCE 
> issue happens only after primary sibling has been brought up; if that 
> never happened, MCE wouldn't be broadcasted to that core at all in the 
> first place.
> 
> But this needs to be confirmed by Intel.

(I'm not confirming anything, as I've no clue), but that code stems from
long before we found out about that brilliant MCE stuff (which was
fairly recent).
