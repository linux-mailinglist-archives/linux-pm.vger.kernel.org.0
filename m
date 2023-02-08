Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8959A68EE71
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 13:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBHMFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 07:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBHMFx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 07:05:53 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039A4902E
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 04:05:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b1so2312611pft.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 04:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xE/iVna0NUDeMVAd6frJE7osxL750+P+qkRI2EdGXcM=;
        b=ofxrCgK+qbR1bgiX4SvlRNrHV24DX8fS5edHt9cJybAuozS740H5wLDzV8hY5iHgWQ
         oPfu/krrmtB2pV0LaQuNdauCnLTj5/cr50eLR0Vm9KZGF9nE96I+mHnPDxUMYc0O00U4
         SpyNbioHLfZR/ke7shsWpl9m2pGb19r1RsxzQ4iEXS4+5+1r/3YtUPNM5P9oXAL8Cgjk
         fIXdIBw/Cj/+y0zfFN8X5GY/xJW84wMvkrrhbZFQ86OusRSuX/WMlDI2/D4ZjEbnMEhv
         PMW0okYq8XN1CbqXNcQDbDT0k7mQoiQ45pHVnbvYzbcUYacjOmrjiLouUjFICn+OBNtV
         IFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xE/iVna0NUDeMVAd6frJE7osxL750+P+qkRI2EdGXcM=;
        b=OoQJkKrCQw652Ub9FHnHtsJDaMGohiD+XzPC0Y+EPsRXdsa9oJZxmxiiCLwuAu3h5p
         +F2+s7Xal+1U8+U6yHXdAnhW6tcPDygWepCLh++1H++EX2n8KY/bloviTVVxnKu/ajoP
         oVjAU5JlpPYwQdhHIOKWhWXAk4HU9kTPdvyT1JLXkZ85NKQVOSBGkDgSqOFZvoWm7ZtC
         im0+EZ0phFRGsA4Sg/y0V/u5KrkgfHdVmnwa0yydel8duyYAQdARfydx2M0XFh844I7f
         sicFgfxoKIybhlS9q4pJs8dOo38XeNGdonLjzdmBOpyuRQERpFwXooWP7Lv0S4UaTXXU
         SqMQ==
X-Gm-Message-State: AO0yUKU9tUV5RW4xUHlbT6GRRunPT2+rOWmIobv7B3KY5Utbp8XYf1wr
        Fq8H1FkavWbrkCYr7JfZGhqI6A==
X-Google-Smtp-Source: AK7set/ETOXK0L5Bs8VSLfrV9CT0APKzq3mcb705nfuPf1lNFrjrNNGNeloSMXQ3aWpM5LV9kwKcLQ==
X-Received: by 2002:a62:a118:0:b0:592:5e1d:8d03 with SMTP id b24-20020a62a118000000b005925e1d8d03mr5963066pff.2.1675857951080;
        Wed, 08 Feb 2023 04:05:51 -0800 (PST)
Received: from [10.200.9.31] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a001c8400b0058bcb42dd1asm10934301pfw.111.2023.02.08.04.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 04:05:50 -0800 (PST)
Message-ID: <420f2b78-2292-be4a-2e3f-cf0ed28f40d5@bytedance.com>
Date:   Wed, 8 Feb 2023 20:05:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] some minor fixes of error checking about
 debugfs_rename()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     patchwork-bot+netdevbpf@kernel.org, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
 <167548141786.31101.12461204128706467220.git-patchwork-notify@kernel.org>
 <aeae8fb8-b052-0d4a-5d3e-8de81e1b5092@bytedance.com>
 <20230207103124.052b5ce1@kernel.org> <Y+ONeIN0p25fwjEu@kroah.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+ONeIN0p25fwjEu@kroah.com>
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



On 2023/2/8 19:54, Greg Kroah-Hartman wrote:
> On Tue, Feb 07, 2023 at 10:31:24AM -0800, Jakub Kicinski wrote:
>> On Tue, 7 Feb 2023 18:30:40 +0800 Qi Zheng wrote:
>>>> Here is the summary with links:
>>>>     - [1/3] debugfs: update comment of debugfs_rename()
>>>>       (no matching commit)
>>>>     - [2/3] bonding: fix error checking in bond_debug_reregister()
>>>>       https://git.kernel.org/netdev/net/c/cbe83191d40d
>>>>     - [3/3] PM/OPP: fix error checking in opp_migrate_dentry()
>>>>       (no matching commit)
>>>
>>> Does "no matching commit" means that these two patches have not been
>>> applied? And I did not see them in the linux-next branch.
>>
>> Correct, we took the networking patch to the networking tree.
>> You'd be better off not grouping patches from different subsystems
>> if there are no dependencies. Maintainers may get confused about
>> who's supposed to apply them, err on the side of caution and
>> not apply anything.
>>
>>> If so, hi Greg, Can you help to review and apply these two patches
>>> ([1/3] and [3/3])?
> 
> If someone sends me patch 1, I can and will review it then.  Otherwise,
> digging it out of a random patch series is pretty impossible with my
> patch load, sorry.

Hi Greg,

Sorry about this. My bad. And I have sent the [1/3] separately, please 
review it if you have time. :)

Thanks,
Qi

> 
> thanks,
> 
> greg k-h

-- 
Thanks,
Qi
