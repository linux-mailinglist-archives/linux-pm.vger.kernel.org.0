Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E63048CCB5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jan 2022 21:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiALUAs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jan 2022 15:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbiALUAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jan 2022 15:00:35 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D99C034004
        for <linux-pm@vger.kernel.org>; Wed, 12 Jan 2022 12:00:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id s6so5373632ioj.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jan 2022 12:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cl1FUyfdprGONZXPglxSDKBSmEWDkw6VkfF16x5mxXo=;
        b=QVJEehF7WPyvGeEiM5KzQqPIBMMXGEV3R+wLe8PkJGDeACISPmV4QHm+bqRf3ctMii
         e9A7XOez7BgUJWpIS85K3eqDw9O/LP5gRWCD7MDNpgnuqpnoM7y4SqV96P1MzAz4QbkZ
         6dTMEEMsxLx1RvNmJhKDjS7fzc3PdRvc8pQIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cl1FUyfdprGONZXPglxSDKBSmEWDkw6VkfF16x5mxXo=;
        b=QLqT+JhLh417ddPfnoeLo22lJC+n2jNHUPdhDe8lcEtd3X58Xrph1w8b68WgdqBhQU
         jZQdwUMR70jaLxRpSAcxey1pX/r1HPd0YMOwFNPCIW2PX/vbfGAoAR4aCwGn5F0idMxg
         wcN1sdXPDyfZwb3Z9ddpj+gb3QPLRuudiYt7QPi475t60h2/6DzOgzsd1KFPCKwOuf3r
         NK/t1ZVF2NUhLm0VS+OsO2cAVFmltblsTy1Knrgk5vfmaUN8Yfo/HaSoGVEm3aaDmJRz
         aNXXfU0Le0Q2VCgBULHOTTRrJc+/m/S8M02iwa+pKPJ/eHbTGdkKVYv+EHj6shjcM1iv
         hZFw==
X-Gm-Message-State: AOAM531PW2r46QYn/64zFk8wBqm1zN3DmsbifAnC9bIIEmdnb5mScocr
        K4Gdtk3FGXLzvpm74AAnALi8WQ==
X-Google-Smtp-Source: ABdhPJyqfTMBuJuxUvt68Bs1IVabNVrDXN9rilZ2BQG+2TZJXMJyou7YfZBE20+jh9R7SNMFYnATlw==
X-Received: by 2002:a5d:8a0a:: with SMTP id w10mr692518iod.90.1642017634562;
        Wed, 12 Jan 2022 12:00:34 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h4sm412552ilh.1.2022.01.12.12.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 12:00:34 -0800 (PST)
Subject: Re: [PATCH v3] tools/power/cpupower/{ToDo => TODO}: Rename the todo
 file
To:     Onur Ozkan <onurozkan.dev@gmail.com>, trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Onur Ozkan <work@onurozkan.dev>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211224104343.33331-1-work@onurozkan.dev>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9fdc2f8e-8c76-ad3b-1ca5-39fae07d37de@linuxfoundation.org>
Date:   Wed, 12 Jan 2022 13:00:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211224104343.33331-1-work@onurozkan.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/24/21 3:43 AM, Onur Ozkan wrote:
> Renamed the to-do file to 'TODO' instead of 'ToDo' to
> comply with the naming standard.
> 

I get it now. I didn't pick up on the "ToDo" vs. "TODO"
difference. No need to add the list.

> Signed-off-by: Onur Ozkan <work@onurozkan.dev>

Your from doesn't match the Signed-off-by - please match them
and send v4 - no need to add the TODO file list this time.

> ---
>   tools/power/cpupower/{ToDo => TODO} | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tools/power/cpupower/{ToDo => TODO} (100%)
> 
> diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
> similarity index 100%
> rename from tools/power/cpupower/ToDo
> rename to tools/power/cpupower/TODO
> 

thanks,
-- Shuah
