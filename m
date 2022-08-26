Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077175A259F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 12:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiHZKOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245452AbiHZKOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 06:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F05BB6B8
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661508874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLsMpZl6pKYr7WS0pD17GyZwc7LDBjeF1ao0OHp8dGw=;
        b=XvqA6FgdCpNvWQD1/NplosIOD+l7VB8EAj5YpU+IS4pAfiiV6QYBJjYx7A6AmZVfkpKM1U
        U+DLXmd+XhOL60LEVc8b58Jo0JlL4iyYHNwGg4hsMuJbinnd+iHWr1+NeC0mbMdO+F8nx0
        MjBBWGaTLZN2x0/zrcOnrFpfF3gp8v0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-OxGMg4P3OdqRxzy-8Ht8ow-1; Fri, 26 Aug 2022 06:14:32 -0400
X-MC-Unique: OxGMg4P3OdqRxzy-8Ht8ow-1
Received: by mail-ej1-f69.google.com with SMTP id sb14-20020a1709076d8e00b0073d48a10e10so445277ejc.16
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 03:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kLsMpZl6pKYr7WS0pD17GyZwc7LDBjeF1ao0OHp8dGw=;
        b=7cYVyGE/viYFiamjXKXWc+NllqEkXdUr7DOmyyk16MCo8SHxNsT5hmzlt867imfyAG
         pZJvqQdp+TjXx5NJ9604igeVMpz1nB38bHddvQKs8dZ+AjMH3MtQJBc5hJJ5B0skckeL
         cFPQ3AvzQsNn0TwN7LKeYWbMzTkT+KBD0KYqpS8jZ/fSjDw/ga6jQn7NeqBkHawe6oCg
         xQ4Bfospug91YBPc8OiveJQK+oC41UFiL+hmsmnFImQeKJ7oZKX0Domwtryq8ssN6pGa
         9mcUQYYz7UUZTVKrYc+UoPzpRlF6YJ1xYAzQxBeqVbmW2JXLwnwZR00XhCnkGsKhntCu
         pl+Q==
X-Gm-Message-State: ACgBeo1Y09HQehQIuj5ScUsjZkiY/VipWe+D0qJgkVbZoJ4P4wkXnxIP
        gT73tbLF/2IW3z1i8rOT03fiOug26TTkfQBDTXvHtn5SdsAK6hodRVCan4swucH8a9nNXQWgoiJ
        glgGbsxlIk/Yxwz/VwKc=
X-Received: by 2002:a05:6402:3596:b0:447:11ea:362d with SMTP id y22-20020a056402359600b0044711ea362dmr6348251edc.117.1661508871303;
        Fri, 26 Aug 2022 03:14:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR61958O0SP3ojKwfYX23ngd+Dh+aUFS3g76QnzgJsqidkUdenB0JJsJ4POiZUw39HMhYnJNIw==
X-Received: by 2002:a05:6402:3596:b0:447:11ea:362d with SMTP id y22-20020a056402359600b0044711ea362dmr6348242edc.117.1661508871105;
        Fri, 26 Aug 2022 03:14:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id kw2-20020a170907770200b0073872f367cesm716150ejc.112.2022.08.26.03.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:14:30 -0700 (PDT)
Message-ID: <7558c548-7866-9176-34a2-056f4a72a483@redhat.com>
Date:   Fri, 26 Aug 2022 12:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] KVM: x86: use TPAUSE to replace PAUSE in halt polling
Content-Language: en-US
To:     "Mi, Dapeng1" <dapeng1.mi@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>
References: <20220824091117.767363-1-dapeng1.mi@intel.com>
 <YwZDL4yv7F2Y4JBP@google.com>
 <PH0PR11MB4824201DABEFF588B4E0FE34CD729@PH0PR11MB4824.namprd11.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <PH0PR11MB4824201DABEFF588B4E0FE34CD729@PH0PR11MB4824.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/25/22 13:31, Mi, Dapeng1 wrote:
>> I say "if", because I think this needs to come with performance numbers to show
>> the impact on guest latency so that KVM and its users can make an informed
>> decision.
>> And if it's unlikely that anyone will ever want to enable TPAUSE for halt polling,
>> then it's not worth the extra complexity in KVM.
> I ever run two scheduling related benchmarks, hackbench and schbench, I didn't see  there are obvious performance impact.
> 
> Here are the hackbench and schbench data on Intel ADL platform.

Can you confirm (using debugfs for example) that halt polling is used 
while hackbench is running, and not used while it is not running?

In particular, I think you need to run the server and client on 
different VMs, for example using netperf's UDP_RR test.  With hackbench 
the ping-pong is simply between two tasks on the same CPU, and the 
hypervisor is not exercised at all.

Paolo

