Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04AE77C261
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHNV2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjHNV2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 17:28:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B60E10CE
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 14:28:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34a91a25db9so1519895ab.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692048497; x=1692653297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BR+JPGscnhVrEQwfTBpqpRvh0fXBlGtikJiTfcgyxCo=;
        b=d/ywBwrd9M+sJ2oLD7lb5RO45Wn3GHcJFxuEAgzXWyM2OyF+cAh9MS495TBGtyEyx1
         xKK8FnnecwdPy1xPtgyjkgnXJBdOowmQb5Ty1hmFcCTSqdRVwkGPVQvBs5ByQyB/2r/v
         VPS0ZDhVhZKTaqi9fdJGdge+cefEDDssk/BZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692048497; x=1692653297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BR+JPGscnhVrEQwfTBpqpRvh0fXBlGtikJiTfcgyxCo=;
        b=QQ+63yPYer6c/KdmbVRTzDDdjIr6lPNQuUDfwN0BJZ+4uOTw9+13WIDsofbfX+G3Mr
         cz8fK9KtoWa4qnkwiHpXMDHI1e6e8Q5R5GHohPIZ+iFx36bzhrfLMlBlyRoxV6Egx+xg
         +xdOrV+hqcxrQ4jwyrSHSIptE2SDRH/zjC8Sh2LPYndeAbJnMnvxat9Wh6I+SKb+1ffV
         xSzeZxUwUtJC365yUD3bFBCPI1zRE/qxejWxm7puSd88zcDGo743RnSuShjXlaIh3aVu
         tZqn3W+ktpDlNrjzBigjtxqO94FzrVEvViZnIE387Zfhd0LWfarsnyb5MkfdieEqd0NT
         o+tA==
X-Gm-Message-State: AOJu0YztW23A8VGPa+3PgbokeqIj/gm/GwF1ChHPDx48HsRUZBrigxnK
        TwoVykfTPBsdd6jOyG8yrysjQA==
X-Google-Smtp-Source: AGHT+IH8EVgnmRaisZltngF35iIiJkH0e7AIZDFQ1T/J2Wk/+Drqq2c8Fae/qJUTgBCf+akPS2exhg==
X-Received: by 2002:a05:6602:3890:b0:790:f2c3:2fd with SMTP id br16-20020a056602389000b00790f2c302fdmr14455621iob.0.1692048497468;
        Mon, 14 Aug 2023 14:28:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o3-20020a5e8a43000000b0078714764ca0sm3439153iom.40.2023.08.14.14.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 14:28:16 -0700 (PDT)
Message-ID: <dcb720bc-113f-e467-01bd-3d19869e13ac@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 15:28:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp
 mode
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenhq2005@gmail.com" <chenhq2005@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230811213501.17293-1-mario.limonciello@amd.com>
 <ZNmqQkOK7CLa7TNl@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZNmqQkOK7CLa7TNl@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/13/23 22:14, Huang Rui wrote:
> On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
>> When running in active mode the driver for amd-pstate has -epp appended.
>> This throws off amd-pstate detection.
>>
>> To detect amd-pstate look for the prefix instead.
>>
>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
>> Reported-by: chenhq2005@gmail.com
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> 

This patch doesn't apply on top of cpupower latest:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git coupower

Please rebase and send it.

thanks,
-- Shuah

