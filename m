Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993E5A003A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiHXRTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbiHXRTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 13:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C76E7C32E
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661361552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fR3F9GSGdIyjl4KjQVv2PTUvzcBxFqMQTexQHu1cYQ=;
        b=IXIqFOeGBGrbRH8Vf4lPvfhRcJ0hhIXVZAPMM5H/Hun7OFC3omKXuFGoMQI/YlwF0X2ACU
        j7+OAKZgf6NcDrv1uy3U+Bniq9a/EN/Y65ilCmC5osEB0GibAY0fM1Ki2V0WLkQi5E1M9J
        Z7plCyzfaO3GIai5qDwMdQDW7Nh1Du0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-Q8JeuvBYNk2tXbECtyfEZg-1; Wed, 24 Aug 2022 13:19:11 -0400
X-MC-Unique: Q8JeuvBYNk2tXbECtyfEZg-1
Received: by mail-wm1-f70.google.com with SMTP id c66-20020a1c3545000000b003a5f6dd6a25so1102175wma.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 10:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5fR3F9GSGdIyjl4KjQVv2PTUvzcBxFqMQTexQHu1cYQ=;
        b=d3umdwv6vp22caoL7SwnO2hi9aR3aDg5m+G5qI4Il3GN+lXG5i0yAism4XfOT/um4V
         k+Wm7J0pEud2i887APPIIjq19OmKiVKWLVp7BD/A6gKsM+I3pD9ouYd1XGikJLYgY5u6
         13w+UpxGo7WzC4YDUq2Lix9rO+8cnnjySh4RlMkUDgzPw5NmZf69JHc7zy3DH0Y+vqcJ
         UDW5pdEJvnHfMJE1Ko5Is5rKHtA38ISbXgs7ZNEEDit6rCxNRppjeD5guvAfd4tRtjGK
         Q9tbwRBrroHokUGn5e3IR/PWe/TAMhXZDlRueBxGkCA1ofVdrcQxhVx3EhMJzWSAyRXE
         eOgw==
X-Gm-Message-State: ACgBeo2DfiwEyfuLq0RH2Wo25hdz9sksYjLxhd8hldTlF6nbd/+ffLy9
        BS8QyoKQJsX7U68ErI3Y7cLk/+O+XXARZxk1Mk+IiXtSG7YS71wOMQauV5ZkgWbDBPCM5a46UyT
        Lqz96z2357O0USAW6WD4=
X-Received: by 2002:a5d:64c3:0:b0:225:4f81:d060 with SMTP id f3-20020a5d64c3000000b002254f81d060mr132899wri.536.1661361550179;
        Wed, 24 Aug 2022 10:19:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ttdjMug0iYpQ5JQgsxkf6+CYDrKkbKyoW3tlDFCWtG6u7rvpOI69IoXi/6KTMQNrqkEgTuA==
X-Received: by 2002:a5d:64c3:0:b0:225:4f81:d060 with SMTP id f3-20020a5d64c3000000b002254f81d060mr132886wri.536.1661361549968;
        Wed, 24 Aug 2022 10:19:09 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id o8-20020a05600c4fc800b003a603fbad5bsm2635447wmq.45.2022.08.24.10.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:19:09 -0700 (PDT)
Message-ID: <f1598980-92a8-267c-cade-8f62d7653017@redhat.com>
Date:   Wed, 24 Aug 2022 19:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] KVM: x86: use TPAUSE to replace PAUSE in halt polling
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dapeng Mi <dapeng1.mi@intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, zhenyuw@linux.intel.com
References: <20220824091117.767363-1-dapeng1.mi@intel.com>
 <YwZDL4yv7F2Y4JBP@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YwZDL4yv7F2Y4JBP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/24/22 17:26, Sean Christopherson wrote:
> I say "if", because I think this needs to come with performance numbers to show
> the impact on guest latency so that KVM and its users can make an informed decision.
> And if it's unlikely that anyone will ever want to enable TPAUSE for halt polling,
> then it's not worth the extra complexity in KVM.

Yeah, halt polling works around perhaps the biggest performance issue 
with VMs compared to bare metal (so much that it's even possible to move 
halt polling _inside_ the guest for extra performance).

I am ready to be proven wrong but I doubt TPAUSE will have a small 
effect, and if one wants the most power saving they should disable halt 
polling.  Perhaps KVM could do it automatically if the powersaving 
governor is in effect?

Paolo

