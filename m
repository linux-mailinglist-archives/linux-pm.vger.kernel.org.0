Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E13798762
	for <lists+linux-pm@lfdr.de>; Fri,  8 Sep 2023 14:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjIHMwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Sep 2023 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbjIHMwt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2023 08:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5D19AB
        for <linux-pm@vger.kernel.org>; Fri,  8 Sep 2023 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694177515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaFUsBFuXIP461bUGm4tFj3D+3rt4HzNmF/m2nVDsSg=;
        b=gOMRGTJswv2S15VGjc+zCqGMC4E5aWUnsJfF5nXLsZEPIDndFvxJLBlS0+dA62bi7iTrRV
        FAKYCJZxG9FmF0ThdHd1za5EcQVHcaUokjhRwEi8esd22mjAdhucdTuAvUl3dfLqhOaWHQ
        yJEkBX82Lwu7DQ7zD4COPeGXjEHB1zU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-fN2A1ZIuPCaza-AQk83YbQ-1; Fri, 08 Sep 2023 08:51:54 -0400
X-MC-Unique: fN2A1ZIuPCaza-AQk83YbQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso133994366b.2
        for <linux-pm@vger.kernel.org>; Fri, 08 Sep 2023 05:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694177513; x=1694782313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaFUsBFuXIP461bUGm4tFj3D+3rt4HzNmF/m2nVDsSg=;
        b=E2AqFq8WWUeFtv0Hg1OV5YtfyHYXN/fLzu21l5KR0IpYSJhHouIMvBeLUkAtIds9WY
         oHdxuERyB18n5k0XO/2pp+4JyPvHFLr1CmV4aIyqIelhCeTw+0DTwEIfhoDn1feInmhj
         47nJkb5PAzlaAFVnjYQQhvYCTE1UwSXGVGoVmeQSq7pWDYYCOVgob23FxNgW2KpEyg2i
         PWe8mkd5qGqWUSWuowzK+tRUHSx+iyjWjMNxno8HH2ttLDTPy918sSW6SSRj9DK+Xej2
         2cBhsT73VQvY39ThtmdKroKGWcDxBZ/ddBoMzfTjzacLIIgamhVj7F30RE3YrvpechHE
         mEBg==
X-Gm-Message-State: AOJu0YwsZ1nuXfUAtx4C/jaBQI08OMDueMpNZxCzBxy0gRUfso45IHB1
        EuN6aO9MOIKvDirlCijnc8xsvUr4b31xh0RBVi9TafLm6fbR/HHS5Fss4rAXRjqu9gnqB05idMd
        OtV+cc1ESh/IMpvBePnk=
X-Received: by 2002:a17:907:7717:b0:9a2:256a:65ca with SMTP id kw23-20020a170907771700b009a2256a65camr1654169ejc.14.1694177513110;
        Fri, 08 Sep 2023 05:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj8Vc2wkQi6zPp4oKe2xKcMpzKqoQvOJFz2/irevT4SAEc42C0CDY8o7MQkamxp88/22TCyg==
X-Received: by 2002:a17:907:7717:b0:9a2:256a:65ca with SMTP id kw23-20020a170907771700b009a2256a65camr1654156ejc.14.1694177512846;
        Fri, 08 Sep 2023 05:51:52 -0700 (PDT)
Received: from [192.168.0.224] (host-82-53-135-115.retail.telecomitalia.it. [82.53.135.115])
        by smtp.gmail.com with ESMTPSA id qp3-20020a170907206300b0098cf565d98asm1001693ejb.22.2023.09.08.05.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:51:52 -0700 (PDT)
Message-ID: <7c1cedb5-6342-1bf9-d1a6-3a87f63801fc@redhat.com>
Date:   Fri, 8 Sep 2023 14:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US, pt-BR, it-IT
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qyousef@layalina.io>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, juri.lelli@redhat.com
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
 <20230907115307.GD10955@noisy.programming.kicks-ass.net>
 <89067f71-9b83-e647-053e-07f7d55b6529@arm.com>
 <20230907132906.GG10955@noisy.programming.kicks-ass.net>
 <5616e50d-b827-4547-5b16-9131ace98419@arm.com>
 <20230907133840.GH10955@noisy.programming.kicks-ass.net>
 <8657cc7c-169b-3479-5919-72bd39335b15@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <8657cc7c-169b-3479-5919-72bd39335b15@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/7/23 15:45, Lukasz Luba wrote:
>>>> RT literatur mostly methinks. Replacing WCET with a statistical model of
>>>> sorts is not uncommon, the argument goes that not everybody will have
>>>> their worst case at the same time and lows and highs can commonly cancel
>>>> out and this way we can cram a little more on the system.
>>>>
>>>> Typically this is proposed in the context of soft-realtime systems.
>>>
>>> Thanks Peter, I will dive into some books...
>>
>> I would look at academic papers, not sure any of that ever made it to
>> books, Daniel would know I suppose.
> 
> Good hint, thanks!

The key-words that came to my mind are:

	- mk-firm, where you accept m tasks will make their deadline
	           every k execution - like, because you run too long.
	- mixed criticality with pWCET (probabilistic execution time) or
		  average execution time + an sporadic tail execution time for
		  the low criticality part.

mk-firm smells like 2005's.. mixed criticality as 2015's..present.

You will probably find more papers than books. Read the papers
as a source for inspiration... not necessarily as a definitive
solution. They generally proposed too restrictive task models.

-- Daniel

