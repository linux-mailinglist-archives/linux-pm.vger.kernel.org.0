Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DA29F6F0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 22:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJ2Vd7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ2Vd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 17:33:58 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42625C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 14:33:58 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k1so4573078ilc.10
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HBW/y2hcG3tVUMNsYdQ7G3FZLWAgav2W/hDMrrmqMV4=;
        b=C9wMCxF/YMjZlGOVB+2eKfXEJR92p9m4yP6IxXhK5vhdsXo+p654QnmvgqtQjmvKIC
         N/O9P5d7uy+RDFfIQuyEavN4FfcpZrYkVXygitutifdRdCWzu8+3G0FjM1vKtQ7PHYKK
         9VzbQsSQqpYgOQs1b9DKxZHrBHTy6glApl2AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HBW/y2hcG3tVUMNsYdQ7G3FZLWAgav2W/hDMrrmqMV4=;
        b=tzIjI4Z6nwo/oid05XZ3y7k0YntbaN2icx3MhRNXRTbT/uEljBUvBYRh8dDyh7TuFD
         En4DjHyxgeuVWdZwHGz7wtA1ijjyk+xjJPiwrWkEzXz68f9gzdT8M+Y+x8qLghNXqKnW
         lMnhURPwi4Pu+A9xpYSTdPCc7wdQM8ZkuGARycYG7iGbX6MMJ8PFAlAfNBqajA7rDksI
         gvVRbgmORg9IKI6ieikw04KCB1qtX5eNUuGMgS7ppKIwgrjrzcKuQsnFgvoaV/sVwhNq
         ntIK3oPf0mKIi73FWlQrgMCZw3Y2K4F0r6mLr4+BnbUesrg+/nezWT5eiWiK+8uS157u
         G4JA==
X-Gm-Message-State: AOAM533MjIuLrlpVu+GEud4B64riMe3Gc+DMHz9fjXrW4MSz8KPH4oLn
        xQicB74jVh4oP15PU9Llx5o08jkWqtPigQ==
X-Google-Smtp-Source: ABdhPJzjjq7wQ7GrmP2vMxl7uTfJhlv8ruaD8BA9kXgZ+jONnT6TAdwrOl602ZGmTwFaprEnbt3cow==
X-Received: by 2002:a92:cb4e:: with SMTP id f14mr4494426ilq.122.1604007237554;
        Thu, 29 Oct 2020 14:33:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n84sm3955870ild.16.2020.10.29.14.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 14:33:56 -0700 (PDT)
Subject: Re: [PATCH v4] cpupower: Provide online and offline CPU information
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pavithra R . Prakash" <pavrampu@in.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201023152527.15884-1-latha@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <66932174-384a-5da4-4786-955f1e6233f6@linuxfoundation.org>
Date:   Thu, 29 Oct 2020 15:33:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023152527.15884-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/23/20 9:25 AM, Brahadambal Srinivasan wrote:
> When a user tries to modify cpuidle or cpufreq properties on offline
> CPUs, the tool returns success (exit status 0) but also does not provide
> any warning message regarding offline cpus that may have been specified
> but left unchanged. In case of all or a few CPUs being offline, it can be
> difficult to keep track of which CPUs didn't get the new frequency or idle
> state set. Silent failures are difficult to keep track of when there are a
> huge number of CPUs on which the action is performed.
> 
> This patch adds helper functions to find both online and offline CPUs and
> print them out accordingly.
> 
> We use these helper functions in cpuidle-set and cpufreq-set to print an
> additional message if the user attempts to modify offline cpus.
> 
> Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpufreq-set.c     |  3 +
>   tools/power/cpupower/utils/cpuidle-set.c     |  4 ++
>   tools/power/cpupower/utils/cpupower.c        |  8 +++
>   tools/power/cpupower/utils/helpers/helpers.h | 12 ++++
>   tools/power/cpupower/utils/helpers/misc.c    | 66 +++++++++++++++++++-
>   5 files changed, 92 insertions(+), 1 deletion(-)
> 
> v1-->v2: Added helper functions to find online and offline CPUs and print them.
> v2-->v3: Fixed some build issues
> v3-->v4: Fixed the commit log and moved the version summary to the correct place.
> 

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

Will be included in my next pull request to PM maintainer.

thanks,
-- Shuah
