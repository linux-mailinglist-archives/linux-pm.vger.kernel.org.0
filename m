Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D7500CCB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Apr 2022 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiDNMLH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 08:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbiDNMLF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 08:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D7061DA7A
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649938120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWdoIzKa55+GJDLFWdqzW9nhtvvqYhC7BmkK6QUgeQ8=;
        b=Q5nIxo0BDNlYChLv4rPenYN7Pag75htNEqOxOW/l1xmihOcSdrWKmG+X5dCpTd9OIzgsdi
        hlmW7yWyX53NGp5cVJMp2ukd4KLZM9hw3qLtHZhEXMSzBB/OMQM8H5iNImmX5A07ty95Fy
        8bBN0Ykv8OEF8GG6rwFxPuk9HEaUhd8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-Ju0YXrAyOISCLufSTPlYvQ-1; Thu, 14 Apr 2022 08:08:37 -0400
X-MC-Unique: Ju0YXrAyOISCLufSTPlYvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5CCF811E78;
        Thu, 14 Apr 2022 12:08:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 90CFC1454556;
        Thu, 14 Apr 2022 12:08:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 14 Apr 2022 14:08:36 +0200 (CEST)
Date:   Thu, 14 Apr 2022 14:08:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220414120831.GB32752@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414115410.GA32752@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

this doesn't really matter, just for completeness:

On 04/14, Oleg Nesterov wrote:
>
> 	if (wait_on_bit(&task->jobctl, JOBCTL_TRACED_XXX_BIT, TASK_KILLABLE))
> 		return -EINTR;
>
> this is fine,

No, this is wrong too. wake_up_bit() does exclusive wakeup.

Oleg.

