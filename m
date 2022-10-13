Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547BE5FDDCA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJMP6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJMP6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 11:58:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4666E6F47
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 08:58:08 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q196so1691212iod.8
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v79oRHQ8P4UWXgqco62J/VgW844TcdiRLfWhoSyGC2I=;
        b=EfqKQFm8ZqwJM82aId8NlOA+oShapgR0n82u1hbpesOfm1q1uFZ55l+OzyhQUilb9/
         1FfMU3K1f3bjOzR0TU/+IY36400v7dvyB4mJypc0mnHJQpCl4khtV3XYtmEjjvM770qe
         lSq2Z5GIXsG3FOWbWodvAWzL5J9jaZp5UJz0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v79oRHQ8P4UWXgqco62J/VgW844TcdiRLfWhoSyGC2I=;
        b=sDkoaPDy41BOKsB+0tqugNZszT/XGA1yUwmTiKNdsQat+dHcxFnhWGCj8p1bUVGwyG
         /J2NIV7LrLYXO/yYhIRVdwQdWQfzbCLeq1c5L+a58+rWB0wLL2XqHCPNsF42vSc9MMYz
         1ALiIHDUQhEb8PEwR951+9j5Uk2bkpHBTHaIViTBNa1nJUHEhZc/LNerdUMn9eYqY18E
         CIdcthRHR3u88ZsqPgalocgFJAC6SmWcnzF0/t36oIaj8ZWYh6DxR29foRPPzZD0LoG8
         ZihbhiM+FdNcbYcPj/EIW2czegO7CLlhiO54XpOYFeciGnh9TMVpzwFj/E+b22CRKs5i
         6bKg==
X-Gm-Message-State: ACrzQf3coV7tNklUEpZeoBJrgP1pM29RMgxXl6bhPg8GP4XIv9OgSSuI
        LOwuIoc1rW73VDBUsXWAFbx85g==
X-Google-Smtp-Source: AMsMyM7Mpp1byJNsJ9CPaV7eyLQpRs+xbqaiFWa+fQEY6cpN+gPhC7ct/mz/VEIazTXgUOuVAwesGw==
X-Received: by 2002:a05:6602:2d08:b0:6bc:15d8:3445 with SMTP id c8-20020a0566022d0800b006bc15d83445mr271073iow.96.1665676687595;
        Thu, 13 Oct 2022 08:58:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w13-20020a92d2cd000000b002e939413e83sm28113ilg.48.2022.10.13.08.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 08:58:07 -0700 (PDT)
Message-ID: <7e2043b9-c7fa-236e-de19-5e290deebbdf@linuxfoundation.org>
Date:   Thu, 13 Oct 2022 09:58:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] power: cpupower: utils: Optimize print_online_cpus and
 print_offline_cpus function
Content-Language: en-US
To:     kunyu@nfschina.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ray.huang@amd.com, shuah@kernel.org, trenn@suse.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <14d690a4-d2d5-01db-b2a2-e3c87b4a6394@linuxfoundation.org>
 <20221013020121.2874-1-kunyu@nfschina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221013020121.2874-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/22 20:01, Li kunyu wrote:
> 
> I'm glad to get your reply. In previous tests, it was found that variable initialization and assignment use mov related instructions. Therefore, when I analyze the code and find that removing some variable initialization and assignment does not affect the function and security, I will try to remove variable initialization.
> 
> Find the malloc function and find that its return value is void * type, so it does not need to cast.
> 
> thanks,
> kunyu
> 

I am not seeing any reasons for removing the initialization.
There is no need to do that.

Missing error handling after malloc() call is the real problem
that can be fixed in this code path.

If you would like to fix that, send me a patch for that.

Hmm. Your reply to list looks strange - please double check and fix it

"Re:[PATCH]"@lists.nfsmail.com etc...

thanks,
-- Shuah
