Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A742049BD76
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jan 2022 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiAYUv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 15:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiAYUvc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 15:51:32 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E06C06173B
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 12:51:32 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c188so3019409iof.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8xWDu4VUa1KMmhWTT9ApCS91QssIS1sg0FGU1r8EdQ=;
        b=fPq3W1qMhDmrc3O/H8jdKQejjyFMQcM1Nf2I2cWXLB9x+cYe7GtZ0SOc+D8gTv3JC9
         px3drDlrNv8oN6Vd4UkFmJDaixRaMa1Z/7xVc3/TNd1u7J0OmTKAhVvt2X3h8qtXvhvg
         LM9w+SFq8dO7kFkvlcUUZV3xdeaARAZFjuobc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8xWDu4VUa1KMmhWTT9ApCS91QssIS1sg0FGU1r8EdQ=;
        b=TZPAzjdHW+m7yGEjWeUI68c6JCg6AmTXIQ5xOX4UOekL/gYdbWuO7EBsgNCmqtWeSo
         gHwRo7BPv/poNxqd+09pgAb5Q+DhFP2r0D3d35dskQp3Fshr1KJaMuOitunuycLJzp9M
         bZi8Jy8nft81jshsk6ub5mA2NkrLiZZhNf0SyIMLr+F6aOgnLaqClbp4gpV6dKjd9OBC
         roaXJvozT0yi4QgijWoK2Y9rJnPv0jNcSfeuqPbB+rb1s0Blb5H8Q2xUhRz2v0bB5R1/
         llDaak+xqJUn9PSKNRzsWLb0R0ILoA5XNdW20u/xrnHthF9SW89+MOjfQtiFB4Xpz8FN
         DoPw==
X-Gm-Message-State: AOAM532xI89CDSlmRweuAPEppyzh7zPIw9UrmH7Nu+UjBZ8OTWihVVj6
        IkVvY0hm6N2TWpQB2v28ao917w==
X-Google-Smtp-Source: ABdhPJx/5kXDAPM3pl1xICZm6MAV5zSuAmwkrZES9NWzUNvjzNE6hLuNOCqo1WYWsXaDO98YHEW5og==
X-Received: by 2002:a05:6638:31e:: with SMTP id w30mr5046563jap.57.1643143891513;
        Tue, 25 Jan 2022 12:51:31 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id e5sm9374160ilq.9.2022.01.25.12.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:51:31 -0800 (PST)
Subject: Re: [PATCH] selftests: cpufreq: Write test output to stdout as well
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220114232126.92043-1-nfraprado@collabora.com>
 <20220117064144.bovae2r4wnln7g7k@vireshk-i7>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <31ebfa0a-5e2d-332c-cbe1-22bdfeee8cd9@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:51:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220117064144.bovae2r4wnln7g7k@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/16/22 11:41 PM, Viresh Kumar wrote:
> On 14-01-22, 18:21, Nícolas F. R. A. Prado wrote:
>> Use 'tee' to send the test output to stdout in addition to the current
>> output file. This makes the output easier to handle in automated test
>> systems and is superior to only later dumping the output file contents
>> to stdout, since this way the test output can be interleaved with other
>> log messages, like from the kernel, so that chronology is preserved,
>> making it easier to detect issues.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   tools/testing/selftests/cpufreq/main.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
>> index 31f8c9a76c5f..60ce18ed0666 100755
>> --- a/tools/testing/selftests/cpufreq/main.sh
>> +++ b/tools/testing/selftests/cpufreq/main.sh
>> @@ -194,5 +194,5 @@ prerequisite
>>   
>>   # Run requested functions
>>   clear_dumps $OUTFILE
>> -do_test >> $OUTFILE.txt
>> +do_test | tee -a $OUTFILE.txt
>>   dmesg_dumps $OUTFILE
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thank you. Applied to linux-kselftest fixes for rc2/3

thanks,
-- Shuah
