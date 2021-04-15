Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B52A3615CD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Apr 2021 01:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhDOXH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhDOXH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 19:07:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B97BC061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 16:07:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a9so15050172ioc.8
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=izaFiMsEt23SotgUQxxfSHOT9lAkqU9T7HKgCzSRLFM=;
        b=VlkwjZzexDUQUjA1V2HmIQKxpiefrUDW9d2ISLtxgb/xS5ZQ4bTBphSsmcr0mZTW7M
         UUsE9V7sNyHt8SduRB23MBBoFrqOH1LbzI0hXeYPmft7SEOvqYSSEEgX3s4R70TUhzHs
         bhuXI25mfaYwKzNgmjfOYSV+tw0N4qkqJRW4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=izaFiMsEt23SotgUQxxfSHOT9lAkqU9T7HKgCzSRLFM=;
        b=VgB5I8M+h191DWjMyd70zqPsZTNOdHXi6OwmNwWZ8aiN8iRCA/tt3ixO6YNbrU+niM
         SY2+qw5uxtAvbKXOsMrVEZT380YcGIomwNqO4ibiJP1Gxa8SvQJOlPvPlIflZyhh6Mqx
         KH2+GRpmC78SkYpJ2XnJ/DLm7+tX62qJ0N2+OGj1MeU426lJpbsEgc+krgutvj+FdfhF
         ePZJOTo8maONva+Yj8OzUz2/LTuf2+y3cldFnSD0bN9QsGchjr1y2eulojhxvhNzp94g
         3lmjcpQ7EcirI2NjiMgRQC71mnZCWFUDeQZ6WzIVDDfNuD0cY/13GiclsoECsmIchp06
         Jn0Q==
X-Gm-Message-State: AOAM530IFRYCNGhM3rphAGYVTv4jn0NLzY/UexHl9ebTm9xsKXmNTyN2
        Uf8kgYCuQrOXNwRImiGI55brRQ==
X-Google-Smtp-Source: ABdhPJzWGhgytT65jEtwqL5Rw1sfjyDOB7LurMk6BvhloiWslAehe8LkiHWT+rhqnkCX7EzKi6ZfTQ==
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr1219276ioh.73.1618528023785;
        Thu, 15 Apr 2021 16:07:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s12sm1813820ild.71.2021.04.15.16.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 16:07:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] cpupower: fix amd cpu (family >= 0x17) active
 state issue
To:     xufuhai <xufuhai1992@gmail.com>, Thomas Renninger <trenn@suse.com>,
        linux@dominikbrodowski.net, sherry.hurwitz@amd.com,
        linux-pm@vger.kernel.org, xufuhai <xufuhai@kuaishou.com>
Cc:     lishujin@kuaishou.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <20210324082838.41462-2-xufuhai1992@gmail.com> <1717786.6COvnHc5Zm@c100>
 <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
 <6de2b9d1-435d-99a2-c733-4f49483f8f57@gmail.com>
 <79f26f6b-f9f8-36ac-6f43-6329935ba9e4@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8e5195be-1ab7-60b7-d7c8-ed1cbc9ad986@linuxfoundation.org>
Date:   Thu, 15 Apr 2021 17:07:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <79f26f6b-f9f8-36ac-6f43-6329935ba9e4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/15/21 1:02 AM, xufuhai wrote:
> From: xufuhai <xufuhai@kuaishou.com>
> 
> If the read_msr function is executed by a non-root user, the function returns
> -1, which means that there is no permission to access /dev/cpu/%d/msr, but
> cpufreq_has_boost_support should also return -1 immediately, and should not
> follow the original logic to return 0, which will cause amd The cpupower tool
> returns the boost active state as 0.
> 
> Reproduce procedure:
>          cpupower frequency-info
> 
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin <lishujin@kuaishou.com>
> Reviewed-by: Thomas Renninger <trenn@suse.com>
> ---

As I mentioned on the previous version of this patch, please run
get_maintainers script and include me in the To: list.

The patch has to land in my Inbox for me to apply it.

thanks,
-- Shuah
