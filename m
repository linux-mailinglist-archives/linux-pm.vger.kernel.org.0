Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED37075A7
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 00:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjEQWzW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjEQWzV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 18:55:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634A5B99
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 15:55:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76efb0f6f60so5218239f.1
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684364120; x=1686956120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGSN1Nd+0m+Dx+iSvAkTHo7MgydGEDZL7k++jM6pMD0=;
        b=Aa0HqIG02gvWwhO3RkgkR35ePKeBJb7egh0JjxDJrw2hFxEGnHoLPabLH3kI8uIaK3
         qfPIu9gAoaEv6j9YyP0I8IXjYj7YjPjYio01PZ2irwM+MYYEHxHtu6cJcEavK1wweAjp
         DT2QbOrY4+TTTehiKpQeF6erOfslIIE/oGk/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364120; x=1686956120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGSN1Nd+0m+Dx+iSvAkTHo7MgydGEDZL7k++jM6pMD0=;
        b=hjQaJitNyv/Zy+6R73cN1OT+w31Wn5NsFR5+y8pBPr0DpLCkEkTEeWvhFSDsfyAHsl
         BxZcxsb3BjUQdM+C8zOYf7y7gfZcDssfh3jb6pSFcYT3bnZbZctjE22bQqf1f4rx3yh+
         nyCar1qpL+4WS//bpAjL7MAuZXq94ptAZKdd9M0gr8DtIHT3Z1cGQH01jsdie2sR41j4
         47kDPntQ2xwQKg/887q5FIEhAQ6U2qQ7ErOT+Ja7MqPTf23ZZgpvlmF8rkbBaQoR5JvV
         Jcg0AHwZGG4Hh15j+Ovb3I4crMxDh2wFBhtDnmeI2SnurKKACuqS0vTSnVaPkas475kR
         FYsw==
X-Gm-Message-State: AC+VfDzg46TOqjLEf3KQoqDckj4OP0hcADrkaNRVmVdFiwpu1Dg3KYk+
        zxYPBIT7ID6CSHsaRHiSH/XI1Ib8WUkyT3NxSNk=
X-Google-Smtp-Source: ACHHUZ45L3HPp5+wDoeOZPJvg6W6nA0bt2NRmRvRyB3OQS8hnC5o2tWW7Ur046bbpRBIu0EeQjY30g==
X-Received: by 2002:a6b:3bce:0:b0:76c:67bb:11d1 with SMTP id i197-20020a6b3bce000000b0076c67bb11d1mr2208369ioa.1.1684364119737;
        Wed, 17 May 2023 15:55:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c8-20020a5ea808000000b0075c37601b5csm27686ioa.4.2023.05.17.15.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 15:55:19 -0700 (PDT)
Message-ID: <7e063b75-b115-eace-5ba9-a21c183eccf3@linuxfoundation.org>
Date:   Wed, 17 May 2023 16:55:18 -0600
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
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230517191019.643031-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/17/23 13:10, Salvatore Bonaccorso wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> 
> Several functions in the libcpupower API are renamed or removed in
> Linux 4.7.  This is an backward-incompatible ABI change, so the
> library soname should change from libcpupower.so.0 to
> libcpupower.so.1.
> 
> Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---

Thank you Salvatore. I will apply this for the next 6.4-rc

thanks,
-- Shuah

