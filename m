Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2A427901
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbhJIKW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244520AbhJIKWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 06:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5ABC061570;
        Sat,  9 Oct 2021 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NLfvN1DQI9Av+3nRdJw5H607YL9jBHt4yl7J4LBMJq4=; b=UPDxX0ZBftmg20LiWaXYHEuBmO
        sT2FfgLPtj3Js5BUFbANZXsSSrFt+fzO7Ujo+znvZqfb8fhNLDaqSOBny6cx395TZxw95SuoVxWpQ
        aurQg4gVZ982i76MamtAp6g3OaGTyrr+06KGGFf3HP1RbkXNDYjENoVDxp5mB3T3K+K8lNuxs4hIz
        TQgdsHzW39qEJtRxuLCj5ywGjzJ0nGJbNdOlR+ofXOD25R++xMX8LnOB3jelBmgjo50NYQDXRbKfD
        7nMNizhhWLmlqgusY35i+63T5t6htlP5kX2HlB1FHifXnuZGRtgU9oI7qGfbqNDjZ+j6KU87Lz/c8
        GOCh+alA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ9Re-0043WM-C1; Sat, 09 Oct 2021 10:19:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3FC7300212;
        Sat,  9 Oct 2021 12:19:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D23162C6B0483; Sat,  9 Oct 2021 12:19:09 +0200 (CEST)
Message-ID: <20211009100754.690769957@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 09 Oct 2021 12:07:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/6] Freezer rewrite
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is the by now familiar rewrite of the freezer, but with yet another
attempt at getting the special blocked states (STOPPED/TRACED) right.

Currently it is already possible to tell if a task should be STOPPED from
looking at p->jobctl, the same idea is extended to TRACED and p->ptrace.

But treating p->jobctl/p->ptrace as canonical state, the blocked state can be
(hopefully correctly this time) reconstructed from it at all times.
Specifically, if a TRACED task was woken by the tracer, while the tracee was
FROZEN, the p->ptrace state will have been updated, and the thaw operation will
result in the wakeup.

Oleg, if you can please try and shoot holes in it again? :-)


