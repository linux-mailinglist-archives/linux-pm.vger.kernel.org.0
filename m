Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB697385A1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFUNs3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 09:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFUNs2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 09:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E8ED
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687355261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PkoLL41VxIS/hc3oQfn0XVIx6fl5rPDyyXHPv30+EI=;
        b=Yznb4P2PIg919AufQ8BNlUYzX/9xFsk9vvmMdMzitwBok6KMSY3/jbQyDkefAZfWKsQwBD
        eFY7yNxCoN8oshsQkiP7kmuqCUZN7oXQPr7BxjwmrspLy1hKXNJt6XXZu3Y6Dw6Ny5mFg7
        ZIYQxbPKvXbib4m/hSj8Yt/x+JSc+h8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-PddCcBXiNvusOilEfY5gPQ-1; Wed, 21 Jun 2023 09:47:39 -0400
X-MC-Unique: PddCcBXiNvusOilEfY5gPQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6A3C8910E9;
        Wed, 21 Jun 2023 13:47:38 +0000 (UTC)
Received: from [10.22.17.140] (unknown [10.22.17.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E6C492C13;
        Wed, 21 Jun 2023 13:47:38 +0000 (UTC)
Message-ID: <4996d41d-3199-c4f4-ffb0-25f09709fd6c@redhat.com>
Date:   Wed, 21 Jun 2023 09:47:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/5] x86/speculation: Provide a debugfs file to dump
 SPEC_CTRL MSRs
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-2-longman@redhat.com>
 <20230621074105.GE2046280@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230621074105.GE2046280@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/21/23 03:41, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 10:06:21AM -0400, Waiman Long wrote:
>> Sometimes it is useful to know the states the SPEC_CTRL MSRs to see what
>> mitigations are enabled at run time. Provide a new x86/spec_ctrl_msrs
>> debugfs file to dump the cached versions of the current SPEC_CTRL MSRs.
>>
> Pff, clearly I can't even read email anymore..
>
> We don't do this for any of the other MSRs, so why start now?

That is true since most of the MSRs are static. IOW, they don't change 
once they are set. The current way to read the content of the MSRs is 
via the /dev/cpu/<n>/msr files. There are user space tools to do that.

SPEC_CTRL, however, can be subjected to frequent changes especially when 
X86_FEATURE_KERNEL_IBRS is set. As a result, the current way of reading 
MSRs from /dev/cpu/<n>/msr doesn't quite work for SPEC_CTRL as the IBRS 
bit is always set due to the fact that the reading is done internally 
via an IPI in kernel space. That is the main reason that I add this 
debugfs file to get a good snapshot of the current set of cached 
SPEC_CTRL MSR values without the need to disturb what the CPUs are 
currently doing at that point in time.

This patch is not central to the main purpose of this patch series, but 
it does enable me to quickly verify the other patches are working 
correctly. I can take it out if people don't think it is a good idea.

Cheers,
Longman

