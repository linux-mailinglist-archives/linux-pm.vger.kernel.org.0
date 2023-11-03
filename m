Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9747E0693
	for <lists+linux-pm@lfdr.de>; Fri,  3 Nov 2023 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjKCQag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Nov 2023 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjKCQaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 12:30:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D7DC
        for <linux-pm@vger.kernel.org>; Fri,  3 Nov 2023 09:30:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso16822295e9.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Nov 2023 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699029028; x=1699633828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIkzMbx9D/76gKi93VnRryrPgyBjD5wxQisCsbr7Cg8=;
        b=Ortm+lvKn+zEQR8KE8FnEhPGcp2+sFQr377n4QRhMt8q8y3lJMxuoB0E/R8D0wcDZW
         CkOH1frrJGmwUVFK4w/QGmXvf+TWTdKg95y6GC7g1+f/z2aE85zMzur38lm1Q4haEeO2
         gKtmWnrYmD5nmCVMZyZATJu1zT3ibnkKq3pAHNtIX0VGKZoZiDTffTHHzXDmTfK8qsfw
         hgnm+vF1DLPKsfER5s2ajmZ+4RTktnLVb5UrpwtMIG3ljGdYjSJ1ujbo0a9U/+f5lKYc
         27x9IDy+Cbe+YhvTXhgLBhD3HUMKPGaNTblx/IqWvHS2/q5qmdpAiB2CUl39zAGsFEIA
         PH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699029028; x=1699633828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIkzMbx9D/76gKi93VnRryrPgyBjD5wxQisCsbr7Cg8=;
        b=xRfcfUSarftTJoPfznTBiMxNc2YrKL9ExNDtkyyAOzivSHfblplNyoSPrp0DRyq/3h
         MTj3bpN+A9FqKCUoXK5GW0/A+hq9Reot2/2bi7q1yBO4bzKrPlZwO1Sz6luUmL29KnfC
         gf7hvrmo8A5pP56rUkH2YGZzh3FTBBeaqGBeRP6TZlWPA7emVnE+bpa0QsbCQ/p4o0JI
         gII1lfu2TVmnrJClaJbaEP98pHiKck6q5fqcwRuhxu0aIaZI6uC5eAIhe182XjBVgIss
         4qrYNwCEp43mw9H3pddQ/kBc6zX0BmEeFI4hn5CwGZgfSdnVKKrCsCQRyXDeqAlRwHCL
         ijDg==
X-Gm-Message-State: AOJu0Yzhc9roxPk6TkzWEyVkKTT7Z3uZ7WMtqdPo+B1VJvyOD1moA08h
        a5XNibRtHNT3M1rRu3avrB5RcA==
X-Google-Smtp-Source: AGHT+IHTu1tR0p32Loha6gIBv3u6cccdwtqrVuQM2e78wXiyYxzOhNg6m4CurIuBKv0iKA4ermztHw==
X-Received: by 2002:a05:600c:4897:b0:401:38dc:8916 with SMTP id j23-20020a05600c489700b0040138dc8916mr17906557wmp.10.1699029028073;
        Fri, 03 Nov 2023 09:30:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7a26:df60:2875:9dfb? ([2a05:6e02:1041:c10:7a26:df60:2875:9dfb])
        by smtp.googlemail.com with ESMTPSA id bh5-20020a05600c3d0500b004094e565e71sm3121394wmb.23.2023.11.03.09.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 09:30:27 -0700 (PDT)
Message-ID: <3fe787bc-f85c-4268-833f-86922415c4d3@linaro.org>
Date:   Fri, 3 Nov 2023 17:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Add trip thresholds for trip crossing
 detection
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <12317335.O9o76ZdvQC@kreacher>
 <6b22f4715641bc4ffc76eea8a4e6358bcbea9e1c.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6b22f4715641bc4ffc76eea8a4e6358bcbea9e1c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/11/2023 16:42, srinivas pandruvada wrote:
> On Fri, 2023-11-03 at 15:56 +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The trip crossing detection in handle_thermal_trip() does not work
>> correctly in the cases when a trip point is crossed on the way up and
>> then the zone temperature stays above its low temperature (that is,
>> its
>> temperature decreased by its hysteresis).  The trip temperature may
>> be passed by the zone temperature subsequently in that case, even
>> multiple times, but that does not count as the trip crossing as long
>> as
>> the zone temperature does not fall below the trip's low temperature
>> or,
>> in other words, until the trip is crossed on the way down.
> 
> In other words you want to avoid multiple trip UP notifications without
> a corresponding DOWN notification.
> 
> This will reduce unnecessary noise to user space. Is this the
> intention?

Not only reduce noise but give a correct information. Otherwise the 
userspace will have to figure out if there are duplicate events after 
the first event happened. The same happen (less often) when crossing the 
trip point the way down.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

