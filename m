Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D268D443
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 11:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjBGKbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 05:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjBGKbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 05:31:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32737F3B
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 02:30:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so11457673pjw.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 02:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzHx/EVNNfxiZwjE1z86qLF1SOQQivE7PR9SXta9kr0=;
        b=ANMMbWkQyx9Gf9OpODb/BFj2fKoVDES8+fEH1icYGm+NyzdQ5RBTZ9tMgBWJ06ZlRW
         UyMY4fSGfEqM7t667xOLFodiQSdk6ydlyRyF3cWo7aRUpgWfc3UZu4JTQOn88RZLwcUd
         cigpKS8TGsG4IH5FU2HXRaQSyeDPGbcU5afr/r8y55I8KDl99RW1IH1t6TE5+XdLKn7A
         gllosdZSkmtdLIg469LVEfEkFsdbWe8o07bhSY75x5mdzdtBM0tBSZttjj+sUq7t3TPy
         3gxfZZE5gUDz8EH4hz2hIhvPiqXTohCIj+7ohzXKAHZ4EVdEQ2S95u1OnVY52zDNPkKF
         0QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzHx/EVNNfxiZwjE1z86qLF1SOQQivE7PR9SXta9kr0=;
        b=jLeuUWuFIYq6JgfMRAczTSfBlhvfHgkdQlrF+PPZlifMDDc/9NKhi5c3XCH/PQmzjS
         0NAstKjwNA8vs7jf0bIHABM4Q1Im7+r2wQRlpggVA+kkXkSYTqNn7jMGQdaSbklyF4Co
         bOpVCQIqVAG4N+q23qmGfTHsuPmzKhCBsNvVtCKC4qF08kU7z2okZ1KsBmWoF1IUT23W
         Ei0RSAIfV5+oUV/oUq9sXRtkL1vnErU1ca0sdONcG+5NX/g9jJOCEv5kiEs1b5yk9Qq5
         dSjkOxkGQamp8Eh2wwI7DGNT4YbF5N3Shba2K3GLHfm10qqf5O9nKyMMKgeevWE72+eC
         XWXw==
X-Gm-Message-State: AO0yUKVc1X+CpeXPuPRYGSayQc3dblaI8VjpKl6NVxpgDPJ6Z7WB/VSt
        N0B1VZHL2hRzYkIi66MwXRI0Zg==
X-Google-Smtp-Source: AK7set/N60throOQx1Uwr0cfZqVgk5GxiYBwfolcBcUYkqbDeyd4MCzoL6mOC8COo51U1qfl7pu75Q==
X-Received: by 2002:a05:6a20:7f8e:b0:bb:c590:8db1 with SMTP id d14-20020a056a207f8e00b000bbc5908db1mr3028829pzj.0.1675765848286;
        Tue, 07 Feb 2023 02:30:48 -0800 (PST)
Received: from [10.200.8.117] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a0002d300b00593c679d405sm8815602pft.78.2023.02.07.02.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:30:47 -0800 (PST)
Message-ID: <aeae8fb8-b052-0d4a-5d3e-8de81e1b5092@bytedance.com>
Date:   Tue, 7 Feb 2023 18:30:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] some minor fixes of error checking about
 debugfs_rename()
Content-Language: en-US
To:     patchwork-bot+netdevbpf@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
References: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
 <167548141786.31101.12461204128706467220.git-patchwork-notify@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <167548141786.31101.12461204128706467220.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2023/2/4 11:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net.git (master)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu,  2 Feb 2023 17:32:53 +0800 you wrote:
>> Since commit ff9fb72bc077 ("debugfs: return error values, not NULL") changed
>> return value of debugfs_rename() in error cases from %NULL to %ERR_PTR(-ERROR).
>> The comments and checks corresponding to debugfs_rename() should also be updated
>> and fixed.
>>
>> Qi Zheng (3):
>>    debugfs: update comment of debugfs_rename()
>>    bonding: fix error checking in bond_debug_reregister()
>>    PM/OPP: fix error checking in opp_migrate_dentry()
>>
>> [...]
> 
> Here is the summary with links:
>    - [1/3] debugfs: update comment of debugfs_rename()
>      (no matching commit)
>    - [2/3] bonding: fix error checking in bond_debug_reregister()
>      https://git.kernel.org/netdev/net/c/cbe83191d40d
>    - [3/3] PM/OPP: fix error checking in opp_migrate_dentry()
>      (no matching commit)

Hi all,

Does "no matching commit" means that these two patches have not been
applied? And I did not see them in the linux-next branch.

If so, hi Greg, Can you help to review and apply these two patches
([1/3] and [3/3])?

Thanks,
Qi

> 
> You are awesome, thank you!

-- 
Thanks,
Qi
