Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6633F7CBF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Aug 2021 21:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhHYTcQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Aug 2021 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbhHYTcQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Aug 2021 15:32:16 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F33C0613D9
        for <linux-pm@vger.kernel.org>; Wed, 25 Aug 2021 12:31:30 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so369576otf.6
        for <linux-pm@vger.kernel.org>; Wed, 25 Aug 2021 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J6WVjBvRIT9A+PrV6sxYc5oJqYhffihj3mZfN9H1dBg=;
        b=cRh+wuj9sAm9jNkbwlr/GCHXATQ88pPCKppXfUIy6dkAQwiRWGUxp7B/uI5Qvv6SW9
         udoev0jxKXpaNed5mEERl71dmvdRngbtcrWxZB2DgfJBAojZiX1ktlzaoUMusoW0ZA6K
         Gh/+Hfl1aKsLDeEcA9z8w/swfj7HoWcrixe38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J6WVjBvRIT9A+PrV6sxYc5oJqYhffihj3mZfN9H1dBg=;
        b=KAwJBi+pn2GxQ6EBMA7guxPccUis3rlugRV0wm/eSGS14NsjgtK0o3HdjdYeDdueXF
         GW+mI8mLR3uSBWEPvW85hp87dF1fZY/97GeSfGQXsYBxtatrKRfBlUAQ8cNaALHlCUbs
         8y8ZVOmxYVQ8soxUSQTctr2W5Urc2p9QuTvaE+GG0Rtkk9994oucDOm6ABkSENVEWkSA
         /6PWMxTIsxIupMwRYIxrcPuXcquAtEC4r3x7zYzhJ2IpoALi0WWyGxViB4WpILIaQRwL
         p2NeOUMlDNZK8Sp/KdxdH4P8lLvcV4P1FwtTL3zaeq+hAT3frgfC1cv9EJKpdtY3C+Mw
         b+rg==
X-Gm-Message-State: AOAM5312v5Gauq2/YJIHuM23VmPT0/nLHM9F1byJly0SHtdsb1puiBGc
        M6XhSzofCQCphsV+D0yejdU+cgLG12BOOg==
X-Google-Smtp-Source: ABdhPJzn7PpAMNIwAANraSQTOK7Ycgz1keQAfVRX9TYP4QAz30FZ/pSOKYIUDkIykLmZS5fZSUh6QQ==
X-Received: by 2002:a05:6830:2a06:: with SMTP id y6mr89291otu.134.1629919889711;
        Wed, 25 Aug 2021 12:31:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k19sm156565oiw.49.2021.08.25.12.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 12:31:29 -0700 (PDT)
Subject: Re: [PATCH] selftests: cleanup config
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, shuah@kernel.org, Jason@zx2c4.com,
        masahiroy@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210825050948.10339-1-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6547d239-56b7-71c0-70c9-20a67bdad1dd@linuxfoundation.org>
Date:   Wed, 25 Aug 2021 13:31:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210825050948.10339-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/24/21 11:09 PM, Li Zhijian wrote:
> - DEBUG_PI_LIST was renamed to DEBUG_PLIST since 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")
> - SYNC was removed since aff9da10e21 ("staging/android: make sync_timeline internal to sw_sync")
> 

Please write a complete commit log explaining the change
and tell us what happens if we don't do this.

> $ for k in $(grep ^CONFIG $(find tools/testing/selftests/ -name config) | awk -F'=' '{print$1}' | awk -F':' '{print $2}' | sort | uniq); do  k=${k#CONFIG_}; git grep -qw -e "menuconfig $k" -e "config $k" || echo "$k is missing"; done;
> DEBUG_PI_LIST is missing
> SYNC is missing
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   tools/testing/selftests/cpufreq/config              | 2 +-
>   tools/testing/selftests/sync/config                 | 1 -
>   tools/testing/selftests/wireguard/qemu/debug.config | 2 +-
>   3 files changed, 2 insertions(+), 3 deletions(-)
> 

Please split this into 3 patches

thanks,
-- Shuah

