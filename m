Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84A3A8448
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhFOPry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 11:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhFOPry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 11:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623771949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwmXEsTbN240xGcOS39WntWwEOMy1r0XQYbSoFpZcHw=;
        b=B5oX3RZj0P5N15UZjt7DdEXDtu6jGfurzY5xAHjdWSVRmdGeQjn+GoQf5OaUHebGvWUaN3
        PzMbdIv+/N22eVUcggWVjqjWPoxHZSM9tr5MQKMnBIUBxFpREF9rKzh7R4US9UHBJsNDWo
        dpEermf8JT0zhjPsGEeS+QnsG5pxezs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-tQAQoeIWMwisaHstoUOl7w-1; Tue, 15 Jun 2021 11:45:45 -0400
X-MC-Unique: tQAQoeIWMwisaHstoUOl7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B0D18015DB;
        Tue, 15 Jun 2021 15:45:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.212])
        by smtp.corp.redhat.com (Postfix) with SMTP id E6FFA1007606;
        Tue, 15 Jun 2021 15:45:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Jun 2021 17:45:43 +0200 (CEST)
Date:   Tue, 15 Jun 2021 17:45:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210615154539.GA30333@redhat.com>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
 <20210614154246.GB13677@redhat.com>
 <20210614161221.GC68749@worktop.programming.kicks-ass.net>
 <20210614165422.GC13677@redhat.com>
 <20210614183801.GE68749@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614183801.GE68749@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/14, Peter Zijlstra wrote:
>
> One more thing; if I add additional state bits to preserve
> __TASK_{TRACED,STOPPED}, then I need to figure out at thaw time if we've
> missed a wakeup or not.
>
> Do we have sufficient state for that? If so, don't we then also not have
> sufficient state to tell if a task should've been TRACED/STOPPED in the
> first place?

Not sure I understand you, probably not, but I think the answer is "no" ;)

But this reminds me... can't we implement selective wakeups? So that if a
task T sleeps in state = STOPPED | FROZEN, then ttwu(T, FROZEN) won't wake
it up, it will only clear FROZEN from T->state. Similarly, ttwu(T, STOPPED)
will leave this task with state == FROZEN.

See also

	https://lore.kernel.org/lkml/20131112162136.GA29065@redhat.com/
	https://lore.kernel.org/lkml/20131113170724.GA17739@redhat.com/

just to remind you that we already discussed TASK_FROZEN a little bit almost
10 years ago ;)

What has been shall be, and what has been done is what will be done, and
there is nothing new under the sun.

Oleg.

