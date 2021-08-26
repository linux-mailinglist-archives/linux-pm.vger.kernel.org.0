Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0F3F9007
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbhHZVL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 17:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243666AbhHZVL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 17:11:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E7C0613C1
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 14:10:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x10-20020a056830408a00b004f26cead745so5263987ott.10
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmzl073ewZyYsXPdhzIxU+Fe5INAGh33z33qCWb/BBY=;
        b=PwKcXxTQu0PLxuNxvYVR2riKux1AWdbl6f1MFR7suCWaxHWn3k0BV7zo9B+djsReZQ
         Bh4VfvFIn2jRCV52f9eLOSSY1/ttB5sTJ5RAl0d+PNBSYOf9RNAz33NhdIQri9nNtK6Q
         3MZiq2JDxV62ClAaZ+insEe54Fz31HseQ0CJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmzl073ewZyYsXPdhzIxU+Fe5INAGh33z33qCWb/BBY=;
        b=DtwgP1QfGFaDB7RtMSjsV16p6dyuC2oTSWvnf6yBFb4y8dogNo0vWCuL2CCVWIJ7Q6
         Qw3mPIetDT1wyj09ZEzaifGcaPvpuVz36Otipyfnaf9ekqnA9FFpmiW9syPkrKdSLr+I
         HZvOwWJy99gD3edPELgEOXcd4MTXD3ABbm4faKwl+9A2ZPoEDmCDDG3s9cQDZpL/+JiF
         FoO2TuYIkWt93pMpTbZaa6yCVNKjkoF7Iz76MoGOmlCETyPLUW1Xy2NUCOWVdYG2grxU
         hYhRNJF2aiNYrRoYy2IQqCLwiqb0OwQ2YrMZJaQXSdM7VeMKQXr1UzwTTzvw54zaDTt0
         OVlA==
X-Gm-Message-State: AOAM531c6SclJDwYa6Kx8DxPt7lgaApWyaTaTDdNtuhLDTehku0Qmrno
        fforoEncU0bSlFjJDkToCOh6dQ==
X-Google-Smtp-Source: ABdhPJze7E90lW6vo39eeNprTsxNRNJ8Pl5eqsinxpwMIFglpGFTOrJ3iNCxVdwcY8s3LswDGW76iA==
X-Received: by 2002:a9d:74c5:: with SMTP id a5mr5007877otl.205.1630012239095;
        Thu, 26 Aug 2021 14:10:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id bf6sm910332oib.0.2021.08.26.14.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:10:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] selftests/cpufreq: Rename DEBUG_PI_LIST to
 DEBUG_PLIST
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-3-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7b10c3e6-7869-d8dd-b9b8-5e74f874cdfe@linuxfoundation.org>
Date:   Thu, 26 Aug 2021 15:10:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826015847.7416-3-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/25/21 7:58 PM, Li Zhijian wrote:
> DEBUG_PI_LIST was renamed to DEBUG_PLIST since 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")
> 
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

Can you please state what you arr fxing and also keep the sentences
75 chars or less.

Where is LKP warning? Include the warning and explain why this
change is necessary.

thanks,
-- Shuah
