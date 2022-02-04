Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80ED4A9E7E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 19:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377223AbiBDSAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 13:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbiBDSAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 13:00:33 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7BC06173D
        for <linux-pm@vger.kernel.org>; Fri,  4 Feb 2022 10:00:33 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id m185so62241iof.10
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQ3iVUBPEiq3dEjoofm8ahlbYpZKeb/5UkEVsQyFaMA=;
        b=XAjC8Ar6cP/RehWU5blcKBOztQqKC0OTfm8hMXcFgRp1xeC1pRgkI6xqB0d0+aaDmD
         dxBtBhTpCwTmRaiOzHQdK915f2zHVY/uyqKdzq9fEh06br6fIoSOkXiMFpwy0w69SE53
         V+vzr7V1CQFFy4n5v5Mc9IlU7DS4pluPRIPWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQ3iVUBPEiq3dEjoofm8ahlbYpZKeb/5UkEVsQyFaMA=;
        b=w++gb33Hs9EaPH8rFrBR67HZZkqbVbXSYn3Xo+iLekyDwZQ6t4mP/vOlSef91eSSc0
         4CTZNMads3qiXdksRM+YzIAML4z+QGo8ouJYBDrwilP3aQq0fT9R9INPa7jLDVlmI5fi
         +llKrAcNR1lx5POhophoV+cOXY5uXHS9YCSqfPO+EPsfAKYJeBvpURLG6EPdHujyZnfn
         zHVRi2EIjH33c667CkMoteDfm/DuxQvbFAjB7J1eL5uWyUuyxs9o325uhHmcQ8smF+yD
         eqRPYRiMin61BNeGjly3QwDxyGTBiM3StI8vUPyuIbHbAmEGuhdutRx6PnQkcmV4m4N3
         D/uw==
X-Gm-Message-State: AOAM532ElQn6UCjuwNZObeS8+uxEyvlRaa5Qs4THYN7+GC2IhUUBW25d
        eC6WK2JG4xBp4FVszbPBfPGlLw==
X-Google-Smtp-Source: ABdhPJyMO28cCglSDCVL0Gik32FW0XJvfm40Vv+l/zs4EOgoAJNXW0hJSUfmz03tLYlCoHDzR1yTNA==
X-Received: by 2002:a5d:89c9:: with SMTP id a9mr131990iot.210.1643997633168;
        Fri, 04 Feb 2022 10:00:33 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id h3sm1302097ilj.81.2022.02.04.10.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 10:00:32 -0800 (PST)
Subject: Re: [GIT PULL] cpupower update for Linux 5.17-rc4
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1fbd35ba-4921-9dcc-959d-ff8f7270d3a7@linuxfoundation.org>
 <CAJZ5v0jUEQdETrx5G_PGzGc_rs48bozCXm1sNpio5fpDq6sBeQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <defca3e7-2315-7515-8a0c-3c1393aa09c6@linuxfoundation.org>
Date:   Fri, 4 Feb 2022 11:00:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jUEQdETrx5G_PGzGc_rs48bozCXm1sNpio5fpDq6sBeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/4/22 10:06 AM, Rafael J. Wysocki wrote:
> On Tue, Feb 1, 2022 at 10:22 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Hi Rafael,
>>
>> Please pull the following cpupower update for Linux 5.17-rc4 or to be
>> included in your next pull request to Linus.
>>
>> This cpupower update for Linux 5.17-rc4 consists of minor typo fix
>> and renaming of file TODO to match the kernel naming convention.
>>
>> diff is attached.
> 
> Thanks, pulled, but is there any particular reason why this needs to
> go into 5.17-rc?  It looks like it can wait for the 5.18 merge window
> just fine.
> 

They can wait. Nothing urgent. That's what I meant to say - "to be included
in your next pull request to Linus."

It wasn't very clear as I read it now :)

thanks,
-- Shuah

