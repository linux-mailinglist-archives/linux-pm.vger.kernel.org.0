Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9869D575276
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jul 2022 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiGNQKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiGNQKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 12:10:05 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD0564ED
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 09:10:03 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a20so1192526ilk.9
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B6NA8h2DonOUO6fnDM68r1V74HnZ6s+FTs9FLHKHw4o=;
        b=RpfFw4NTfzFqSvPC5OdRWkldQIboEMKZ0ZZ0zxzisTqiwlwlGgxdEhCbMeQ8JzEi9Q
         7zToQQRCmQ8WiMnh+Q02do8OyspfkCQXWOQ/Zj1cFSL3cdncIyFwOAYmvtbsL1yfjT4v
         s7nTgYv6sohAO66s1cDHdVGmEuPFI6PGA9nq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B6NA8h2DonOUO6fnDM68r1V74HnZ6s+FTs9FLHKHw4o=;
        b=p63d4sdlTy1cwIv7qkEga/UdoPTA9QUYJJoFKTWaNAL9eULbOrUVgDK76lymHRSrjH
         60PpJFjM6L276l7ZbCAYeqvkg4gSR6ex1T68M6PinGYpoUD/3VJDFiNMdOLHJjbFTG28
         RcV9fPF1mx4Kb7F/Om2FHsVzZaVrbyfnvcOFooLNk7PxbsZ7rvhpB6idygjkrgJb1PDw
         f3M257tidpLxfBOzCR/6TW4BN9drjM/u+8tYtulMdkA2LputYaup7uSR8o9heukZQzfs
         3ZwTQXUKyJT+KuR4iqXASevJBqo9n9im6f1b2gSSnFKv+rKhERSzPU6Qt3WOwztJprMO
         2Qng==
X-Gm-Message-State: AJIora8w9l9qzYX1M3qFJ9V9PTIm04EmzgZsKx5YSUcLeBj1lv8RgHnp
        bqmiXvNWFd3Pr7dmp4nULt75MOK9k4JG6A==
X-Google-Smtp-Source: AGRyM1swpAvrZBo4ORjAoAC59MUp9mKTUr96xy6mqpfm51QwGhLPJ4g8wIdhEneoiJuXPOZVJCCiAQ==
X-Received: by 2002:a92:cdae:0:b0:2dc:6d7e:b0f6 with SMTP id g14-20020a92cdae000000b002dc6d7eb0f6mr5026908ild.12.1657815002854;
        Thu, 14 Jul 2022 09:10:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y20-20020a056602165400b0067bda2519afsm157232iow.47.2022.07.14.09.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:10:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: Introduce powercap intel-rapl library
 helpers and powercap-info command
To:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
References: <2991706.CnP8uJEn3U@c100>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6a2b06f6-05cc-0dc6-eacd-ae99f290b4a1@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 10:09:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2991706.CnP8uJEn3U@c100>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

On 7/9/22 2:13 AM, Thomas Renninger wrote:
> Read out powercap zone information via:
> cpupower powercap-info
> and show the zone hierarchy to the user:
> 
> ./cpupower powercap-info
> Driver: intel-rapl
> Powercap domain hierarchy:
> 
> Zone: package-0 (enabled)
> Power consumption can be monitored in micro Watts
> 
>          Zone: core (disabled)
>          Power consumption can be monitored in micro Watts
> 
>          Zone: uncore (disabled)
>          Power consumption can be monitored in micro Watts
> 
>          Zone: dram (disabled)
>          Power consumption can be monitored in micro Watts
> 
> There is a dummy -a option for powercap-info which can/should be used to show
> more detailed info later. Like that other args can be added easily later as
> well.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.com>
> CC: Shuah Khan <skhan@linuxfoundation.org>
> 

There are no problems adding this support. Can you please a bit more
information on how this feature would be helpful?

Also this patch seems to maformed - here is the git am output:

Applying: cpupower: Introduce powercap intel-rapl library helpers and powercap-info command
error: corrupt patch at line 7
Patch failed at 0001 cpupower: Introduce powercap intel-rapl library helpers and powercap-info command

In the email it wasn't clear to me, however the corruption was
very clear in patchwork view:

https://patchwork.kernel.org/project/linux-pm/patch/2991706.CnP8uJEn3U@c100/

thanks,
-- Shuah
