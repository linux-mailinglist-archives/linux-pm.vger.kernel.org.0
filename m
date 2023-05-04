Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD06F6F97
	for <lists+linux-pm@lfdr.de>; Thu,  4 May 2023 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjEDQKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 May 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDQKB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2023 12:10:01 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954D59F5
        for <linux-pm@vger.kernel.org>; Thu,  4 May 2023 09:10:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-760dff4b701so4483739f.0
        for <linux-pm@vger.kernel.org>; Thu, 04 May 2023 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683216600; x=1685808600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1uT9aPMfbt5S8TjfS2OMEfFbn0uM/p5n+XCA9cHmk=;
        b=Vdpc0IWMfa1eUSWOs8j2JeGzRr3ID9DOuBhgRytriJqsD3eT02KuwfgwA8Wl7B/0Mq
         pzrdX43h2ZKcpts8VNG19znzYbM4h9vGlDtZS5Q3APIUOMFXFcU+9LzusHFR9dP4JmAK
         l1Ni4f2xw+RwmZArNZmMy4bxrD9qM6Xc2QbLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683216600; x=1685808600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1uT9aPMfbt5S8TjfS2OMEfFbn0uM/p5n+XCA9cHmk=;
        b=XdZLusut3Kunxng6y9p6353m/yq1JGty4Dokfl2RtWqVrrZvTKQ7iBxIGKBhGe+s+f
         w/fOWR+e6xzWVRENu3WYgAgF5v5Ky+dh7njMmZ54jpcJcmVoQhxZpDzIlWiQqyzTDvkm
         JStLLXj7fBC5Q6tH6k8Mg+bJdoSHByM63ejSK9O0zZE8hWj35MfvCtqtWl/9VNOL+mWn
         YLTO8tXcZGx7aR+fHfrjSsMhSsvBsv8fHLR0cOA1+8OZPada18n7QDDa/iP+LbaqzOBj
         UcOiMlPuKKblhu6K5wENYhGZQFil3O3sQ1BUi7jMIu3xl4fjEvxZFz8xsFHFieTswAIz
         1WRQ==
X-Gm-Message-State: AC+VfDyTlDsdSqTijaOqi01ySe2aGhmO0gOn1B7NoxCtLRK7Cr4fNFV9
        GbBTAsLOVXRV52QVRn1ZpRoTKw==
X-Google-Smtp-Source: ACHHUZ54nJy38M2vJQfXUwq4b4ACr25rS1LW3vySiieWVzVOIIgAwjN/+Q5/lLexUVUUwM3Nx0yF2Q==
X-Received: by 2002:a05:6e02:1312:b0:32c:a864:6eb3 with SMTP id g18-20020a056e02131200b0032ca8646eb3mr5295378ilr.1.1683216599632;
        Thu, 04 May 2023 09:09:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m16-20020a92c530000000b00331a4945ec1sm229641ili.42.2023.05.04.09.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:09:59 -0700 (PDT)
Message-ID: <f6f55e7e-4fff-7be0-9e88-b9980f20339b@linuxfoundation.org>
Date:   Thu, 4 May 2023 10:09:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpupower: Make TSC read per CPU for Mperf monitor
Content-Language: en-US
To:     Thomas Renninger <trenn@suse.de>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Wyes Karny <wyes.karny@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        gautham.shenoy@amd.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230504062544.601566-1-wyes.karny@amd.com>
 <4480921.LvFx2qVVIh@work.fritz.box>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4480921.LvFx2qVVIh@work.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/4/23 00:47, Thomas Renninger wrote:
> On Donnerstag, 4. Mai 2023 08:25:44 CEST Wyes Karny wrote:
>> This technique improves C0 percentage calculation in Mperf monitor.
> 

Like it. Thanks for finding and fixing it.

> I very much like this patch.
> Would be nice to see it queued up if Shuah is ok with it.
> 
> Thanks for this one!
> 
>       Thomas
> 
> 

Thank Thomas for the review. I will queue this up to send after
the merge window closes.

thanks,
-- Shuah

