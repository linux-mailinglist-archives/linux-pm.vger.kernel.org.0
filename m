Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7687230CA
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 22:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFEUNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjFEUNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 16:13:48 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA58E9
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 13:13:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7757912a0d7so37950739f.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2023 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685996025; x=1688588025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9en0Tozdbk72AnPoPie2Ch00y3V4ugu060VNZjQOB8=;
        b=Xe8MgjHwYg6dMHpx07OUa9lUiu1jHBnQhYU0sbx5RRK/+hYsEHXBWV6sC5zAGht2RG
         /YQgwKMVUWKbHwtKY85kk2QXo0eaW0WcJGRjKcZKzRVtWLX8c//7fdVN6G4otw9KSQhY
         lxb1TtF93/mNzGaPMb6L0KMRr7acvACPpiDnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996025; x=1688588025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9en0Tozdbk72AnPoPie2Ch00y3V4ugu060VNZjQOB8=;
        b=QpFHhLXVRKXqlErgk3aAzvB0INCWDiZBjS6U5/73gR/hbymTiOGjb7WwCN6KX8x8sg
         CD4q7wO+P6zG4KFFyDe5GE6BYhz/x0OPQXMVJEoVRo3Ql3m+yhHuL7JdYHVtoLaYBQGo
         QZ3I6ykOziY3WYDOJ3lhT/INRUun+q7zyt3p1Ax4Oj/+a4ikMFM+LD838E9KFJdg5rGn
         VmQjyFNJ8WAi0Sr7ryCkDYr6VzFB+GIC/S7zP6QiylEIYoy5env0TdlQ01LGuUIGsMHg
         p3+Hn8TlM03KHIiOtcHLs/V5dWe71pqL8d7vkAPmAm75pmjaFbh+1FbumPeDWqn1RF5i
         pBEg==
X-Gm-Message-State: AC+VfDzSoVm2O3waZvFw4pxcdoc8uEXNS0Xc4pcS96OLZ2y2eddWHNin
        Jpa4xQR1EXIPYye6QLBacQQy8UE9bhsawVX+ZA8=
X-Google-Smtp-Source: ACHHUZ5sJYjehqQ6joncVt5+XzW5YynqU2/cth2QnLtLHGFAAg88DwEfECiQ0sIDngUQAccLKnBqVg==
X-Received: by 2002:a6b:6904:0:b0:777:b6fb:be8f with SMTP id e4-20020a6b6904000000b00777b6fbbe8fmr162957ioc.1.1685996025609;
        Mon, 05 Jun 2023 13:13:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y14-20020a5ec80e000000b0076c878f9cedsm2663817iol.5.2023.06.05.13.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 13:13:45 -0700 (PDT)
Message-ID: <7a368be9-4346-29e4-e21c-f4db03eb4603@linuxfoundation.org>
Date:   Mon, 5 Jun 2023 14:13:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND] cpupower: Bump soname version
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230517191019.643031-1-carnil@debian.org>
 <7e063b75-b115-eace-5ba9-a21c183eccf3@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7e063b75-b115-eace-5ba9-a21c183eccf3@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/17/23 16:55, Shuah Khan wrote:
> On 5/17/23 13:10, Salvatore Bonaccorso wrote:
>> From: Ben Hutchings <ben@decadent.org.uk>
>>
>> Several functions in the libcpupower API are renamed or removed in
>> Linux 4.7.  This is an backward-incompatible ABI change, so the
>> library soname should change from libcpupower.so.0 to
>> libcpupower.so.1.
>>
>> Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
>> ---
> 
> Thank you Salvatore. I will apply this for the next 6.4-rc
> 

I was just about to send this in pull request and did a final
test. I am not really seeing any change in library name.

Does LIB_MAJ need bumping up instead of LIB_MIN?

Can you send me before and after build results?

thanks,
-- Shuah

