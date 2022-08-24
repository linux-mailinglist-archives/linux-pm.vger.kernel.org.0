Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A25A01C8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Aug 2022 21:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiHXTHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiHXTHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 15:07:15 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AE48C95
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 12:07:11 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a9so9306211ilr.12
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=/0z86Y1Ax3THDI2n37xfCLeqcjNOe/tbgac1pPiMxAA=;
        b=gwdHIYr3S0ZyGWyNV+pn9DrDu8z9hUsb5+TkrabU12fIVqPgQPoB/CgvwbzTqjuU5B
         VSMzgBj1B7MRbbxPnBY2JGO4wgr0Q+q6lILKpanCDYsUmk40BlP0zIiaodse6xFSNLhk
         SgtEINCm3vwoYan4NLuZg9kUM0n1+8LCARuY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=/0z86Y1Ax3THDI2n37xfCLeqcjNOe/tbgac1pPiMxAA=;
        b=lsdcnYBLQ8KbMXwWUpYoUDRCEgzA3ZUoRhMuG3arN5ptGcg5AiD0jTZlr93m1/85X0
         OCg9ikuvYamkxKC5jNIu4P/mZW57da/vX5HxR6HJmUJTogIQDzcz1gBBhVuWT+mlkcm0
         Lme4uibJmlXcIn7dEZpeEottuT4r/yX/Y9SaOxDlhWfsM+uzeK6AeqhJmq826x7uNv5C
         P36XHruxUDJqGFTmVo/l2rDvxiyr6aPdZJ/CnET/t2UksC7dNdSydcnJ1Nj1lK00i6gl
         jhE4wvl+AjJ7w/7Ud5c/hsxg3BjAhqndCeOPPT9O8b8/cQ/yLAVD+GrDSwi+YCWmvR3S
         W1eQ==
X-Gm-Message-State: ACgBeo2URmP56zusbil0ScLOBeG80qL2OFaFt++SOkZIPf0LopJBjq2+
        X7Pzykw2nTS+49TIdfd7VEOkOFm9H8TAPg==
X-Google-Smtp-Source: AA6agR5QNbLkv8efd9OL2qGCGpwbf8PakwKXqb+zg7HsQsNZYFeY9GuN1L/O8JOq1d+kLvit5stWpQ==
X-Received: by 2002:a05:6e02:164f:b0:2df:b190:6dd9 with SMTP id v15-20020a056e02164f00b002dfb1906dd9mr235486ilu.94.1661368030628;
        Wed, 24 Aug 2022 12:07:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h27-20020a022b1b000000b00346c6e75dffsm111593jaa.161.2022.08.24.12.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 12:07:10 -0700 (PDT)
Subject: Re: [PATCH] cpupowerutils: Delete repeated word in comments
To:     shaomin Deng <dengshaomin@cdjrlc.com>, trenn@suse.com,
        shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220802154530.18521-1-dengshaomin@cdjrlc.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8eec893c-822f-ed8b-fb14-f9ea8ad1fd7f@linuxfoundation.org>
Date:   Wed, 24 Aug 2022 13:07:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220802154530.18521-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/2/22 9:45 AM, shaomin Deng wrote:
> From: Shaomin Deng <dengshaomin@cdjrlc.com>
> 
> Delete the repeated word "cpu" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>   tools/power/cpupower/bench/system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
> index 40f3679e70b5..eb79dd9ac670 100644
> --- a/tools/power/cpupower/bench/system.c
> +++ b/tools/power/cpupower/bench/system.c
> @@ -37,7 +37,7 @@ long long int get_time()
>    * sets the cpufreq governor
>    *
>    * @param governor cpufreq governor name
> - * @param cpu cpu for which the governor should be set
> + * @param cpu for which the governor should be set

This is good as is. The first cpu is associated with param.

thanks,
-- Shuah

