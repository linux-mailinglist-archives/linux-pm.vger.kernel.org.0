Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9F23BEC4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgHDRTe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgHDRTc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 13:19:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B3C06174A;
        Tue,  4 Aug 2020 10:19:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so10359264plb.12;
        Tue, 04 Aug 2020 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4w/Ljx5lsCqOPOdBCcxxVX9P69TJXsiTDGuIgF1vcBw=;
        b=NBHUSzIGKhb6NUmUeOIXUxLVmH9RkXdBf4yyBesE29jjXSZC4EoHgbkSfudGxL+wNI
         MRZaF2kq8vT4L2Kmv55+ABK9N+mD2kVf2h/4FnxTwFdbgBkIZeVhmYxSnz5XiVeEoA7p
         y91ohIP+q5denOE2vALGF5Jod/piN+3PbCz5GT9tl+DeoAOxvbTFClCuRXd6l+LQN+Hl
         w7/enjTq4MSYjz4pzYl8tLn/MIcfeBNwt3JwdE8ByERQo6zqaVf0DiwA/UrCGJsTSSZA
         bnqW1wHbTzTFYkZvP2dmA5wClDZObwFcrkOvquM4Sw8TgktR5+5g6WkwL29Xr9FxHMGc
         O4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4w/Ljx5lsCqOPOdBCcxxVX9P69TJXsiTDGuIgF1vcBw=;
        b=DeJViLRQC29+kUQldFbuDj6z4rh5oYjKIf+vtIgadFV70eFStYXZMACbIPJGaAquC7
         UedojPoHGEVHMC6SZ5an+aAJsayfKFfWAuA0aj6QhErRJQkupYtx+WF/f7YdJ9T5YLPZ
         EP/PoKK8+s4qOpul47YAwsKDo2mG4hKE+i90HUS2wGBQw/VXSQ1AXSK8IUQxndqm7bJv
         fUZoyFQONNHZd98jJlsEl9aVW0vcl6YSbUHuEnGhlRgaKGD4otjv1lmxAcUQ756xVO9D
         5NzFRgsu/OW7ANd4aEsjQsOnPtv1zq+vWOnyLv+m89fqwmshAY+PjofDpEAXlmkuSxet
         2SyQ==
X-Gm-Message-State: AOAM5307WN0WPnk58suG6owZd89/IZAh+2VIavviUqNag69NFZ7UA1s8
        dh2SmayINJqBmvcrr8NP8/8LyIdy
X-Google-Smtp-Source: ABdhPJxsvhyOma8LtgCrM0D2bxYl6kyeZUCw326WO0i/Vc+Ad8kORjOw/NSgm/IxSsxY/xCZ221Dyg==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr20346433pls.87.1596561571391;
        Tue, 04 Aug 2020 10:19:31 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id na14sm2843191pjb.6.2020.08.04.10.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 10:19:30 -0700 (PDT)
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus> <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
 <20200731155650.GC14529@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ae352c39-f7c4-c69e-0113-7c810c130ee0@gmail.com>
Date:   Tue, 4 Aug 2020 10:19:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731155650.GC14529@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/31/2020 8:56 AM, Sudeep Holla wrote:
> On Thu, Jul 30, 2020 at 10:36:51AM +0100, Lukasz Luba wrote:
>>
>> In this case I think we would have to create debugfs.
>> Sudeep do you think these debugfs should be exposed from the protocol
>> layer:
>> drivers/firmware/arm_scmi/perf.c
> 
> I prefer above over cpufreq as we can support for all the devices not
> just cpus which avoids adding similar support elsewhere(mostly devfreq)
> 
>> or maybe from the cpufreq scmi driver? I would probably be safer to have
>> it in the cpufreq driver because we have scmi_handle there.
>>
> 
> Cristian was thinking if we can consolidate all such debugfs under one
> device may be and that should eliminate your handle restriction. I would
> like to see how that works out in implementation but I don't have any 
> better suggestion ATM.

debugfs is not enabled in production kernels, and especially not with
Android kernels, so sticking those in sysfs like the existing cpufreq
subsystem statistics may be a better choice.
-- 
Florian
