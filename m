Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5A725919
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 11:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjFGJBK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbjFGJAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 05:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2BF2D65
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZlBm9K/eDsGZdtktFZEDp+gLxlecPmXApRL0wxE0aA=;
        b=UDuDU6bkzBp9Agzv7beQwWN7nfSf0zcyK0qH15V0wEKd51xRANpJs1KfPO46XgbMM/Kee5
        dXuwlHO+KCjlLmwPF2EhtrtK0ZfXrtuYjHt/J2XY26L2flrJhLJZ3HXMaseQ/nMz/1U/EG
        lDFvzS5R5gKSX5vkZTGSZdMl+4XG0o4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Wt4NsXgSNfWiIJ2aAjYoZA-1; Wed, 07 Jun 2023 04:58:26 -0400
X-MC-Unique: Wt4NsXgSNfWiIJ2aAjYoZA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30ae7bd987dso3031485f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 01:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128305; x=1688720305;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZlBm9K/eDsGZdtktFZEDp+gLxlecPmXApRL0wxE0aA=;
        b=DBXx8j/1BaAHgAaJbk4vw8AqNdQ/jq4teexxrgso+Bavhg21uUvazb/3BuQ7hP2raz
         fzJux8YDpW0eYQ+dlLpFr01zGIL3nb5jVMtH06Zk+uUlUg8aAIKPErq5WLzzC0ffLjCa
         AsLTtABpA1VjpSWREjk0QL1rW7lRnx+Zh9zFXUr0FpoFTV4xU25O0/u7YtfJvxOi2ZsG
         8EOHaLd2D+CbZ+cJgS0s9/sbw9AL5Utu2+dGTJzTsAKF/x8feD1VwhvVkSCtBbc1o6xH
         1z45Yil3wqiwSwLKWbBDVNYPQ2rbL6II3Stbt4YzZB22wX4qAM7KeMgDd0U5xKv9JnS3
         BGCw==
X-Gm-Message-State: AC+VfDyDxaaIpeX09oiN8csv/OZee+Xxv+/9qZvlQkRwnAmhI6pDZJEB
        LDUFLDHLvmDfqjazSCDUtt477TycQw4seV97FUlVhxsjk718H8OXzQYrLwnI++4KxdrQ71kkgSU
        7hmGM7hxjJMJ+f6dvSgMwr7Z2RducXTLHtc90IPsVuOllaxGBvC2uiXLsC+v4Vrk/XgooqTWyQA
        LgQRM=
X-Received: by 2002:a5d:4573:0:b0:30d:efe0:5395 with SMTP id a19-20020a5d4573000000b0030defe05395mr3930914wrc.47.1686128305006;
        Wed, 07 Jun 2023 01:58:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gsMslc9ahJC8zUHAGJ/RP7BQSmGZi72AZv76jXK1i6rRbHtaqjZeOnSvI17kebHXmkLvWiw==
X-Received: by 2002:a5d:4573:0:b0:30d:efe0:5395 with SMTP id a19-20020a5d4573000000b0030defe05395mr3930845wrc.47.1686128304503;
        Wed, 07 Jun 2023 01:58:24 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003f70a7b4537sm1382812wmm.36.2023.06.07.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:58:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bigeasy@linutronix.de, mark.rutland@arm.com, maz@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, pbonzini@redhat.com, wanpengli@tencent.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        daniel.lezcano@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        rafael@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/13] arm64/arch_timer: Provide noinstr
 sched_clock_read() functions
In-Reply-To: <20230602115451.GG620383@hirez.programming.kicks-ass.net>
References: <20230519102058.581557770@infradead.org>
 <20230519102715.435618812@infradead.org>
 <xhsmho7m9ptrk.mognet@vschneid.remote.csb>
 <20230602115451.GG620383@hirez.programming.kicks-ass.net>
Date:   Wed, 07 Jun 2023 09:58:22 +0100
Message-ID: <xhsmhsfb3odht.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/06/23 13:54, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 05:40:47PM +0100, Valentin Schneider wrote:
>>
>> So this bit sent me on a little spelunking session :-)
>>
>> From a control flow perspective the initialization isn't required, but then
>> I looked into the comment and found it comes from the
>> arch_timer_read_counter() definition... Which itself doesn't get used by
>> sched_clock() until the sched_clock_register() below!
>>
>> So AFAICT that comment was true as of
>>
>>   220069945b29 ("clocksource: arch_timer: Add support for memory mapped timers")
>>
>> but not after a commit that came 2 months later:
>>
>>   65cd4f6c99c1 ("arch_timer: Move to generic sched_clock framework")
>>
>> which IIUC made arm/arm64 follow the default approach of using the
>> jiffy-based sched_clock() before probing DT/ACPI and registering a "proper"
>> sched_clock.
>>
>> All of that to say: the comment about arch_timer_read_counter() vs early
>> sched_clock() doesn't apply anymore, but I think we need to keep its
>> initalization around for stuff like get_cycles(). This initialization here
>> should be OK to put to the bin, though.
>
> Something like the below folded in then?
>

Much better, thank you!

