Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA7321FDB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 20:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhBVTQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 14:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhBVTNw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 14:13:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB40C0617AB
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 11:12:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a207so286859wmd.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8R2nhedFMBS0Evz/oU72XEbm/1TReocnZGcamPRVP1g=;
        b=PmrT5HrV+fQlRSeimNblYdmPwTIB7+QbCBnQ9PPV26gjLmFV34aw6iLtNoL2AIZE4d
         3mgj74vk+P5CPNXlZZHA5+WSZ8QI2XSIoDp+ev0YlAv0FdmsZv+KJHpDK8lm6jpYMdIr
         BkJThbQT/sNbmugmQHsF0eORG9vTDIcEo4nFT5Aidcw1WdkX7c6bREKXdQZtROIRooMT
         yrKmgxlRxVDlphH2dJVf51W93fDrMhYsznZtTo0Z5MI0Jgkx0SPMrx5+EEIUqlt9fJQq
         nRL5UItgtusjNKgl/lUWtL5WC6lxKEXf2TtxYWpLbWwdrOI42mTd0C9iX54jWCWhzFp6
         8/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8R2nhedFMBS0Evz/oU72XEbm/1TReocnZGcamPRVP1g=;
        b=j0x1WZeCmmvuAl53RxXdqOHbWeX+j6HDgspCpGXhHxHPDlWevhBEQwI/c5U41JDq/3
         pguA+YIo9Gc5gXebDBZgfU2MtzCE3X2XBo6qqpu5H1lOeU1J5tBXUlrgivyntmxKgkhJ
         VwWuup4kNWRSqW0cWoUkRc4bLbJ56ZtBjTq5xdMJWtRPVm34cshGKBUYFuvOD4JrWFY/
         FElIxK2hf5OrBJYmBVmFm7/VgTIajSbvHNLPaPBYcHXkTgY//+qC7mH6uLd/sioZ/Y/p
         ELMTI5s7tAq9VczaugNSvZb7YjrwQ0bplr43oxngkK1yTYbEmwa0Xvxkl9CKENS2Jmyn
         uD3w==
X-Gm-Message-State: AOAM530vlF9skAKcWiGmd34aaJdHauxdsaRMzYtiY5P/fHfHaSbV0xrp
        q9THobtFIv1tPYyv6IarVmrFSPGnNGnvrA==
X-Google-Smtp-Source: ABdhPJySNOsw6p+WnFtTBSJswZjYlpQht23XuomeLaPvabdFFun76t06rZ+ctqF96HKM/J/wzaSwBg==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr4893612wmh.147.1614021169161;
        Mon, 22 Feb 2021 11:12:49 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:246c:9c33:7c45:77cd? ([2a01:e34:ed2f:f020:246c:9c33:7c45:77cd])
        by smtp.googlemail.com with ESMTPSA id m184sm264439wmf.15.2021.02.22.11.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 11:12:48 -0800 (PST)
Subject: Re: [GIT PULL] thermal for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
 <CAHk-=wiaespvE0HmhpJhcNsJXob6WJCH0BdD5XuvBJP7KF_EFg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0e61a669-129e-b223-644a-33da100e6d5e@linaro.org>
Date:   Mon, 22 Feb 2021 20:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiaespvE0HmhpJhcNsJXob6WJCH0BdD5XuvBJP7KF_EFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

On 22/02/2021 18:44, Linus Torvalds wrote:
> On Fri, Feb 19, 2021 at 3:54 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Note a set of changes for the qcom adc driver rely on an immutable
>> branch from the iio tree:
> 
> That part is fine, but what _isn't_ great is the merge commit message.
> 
> This is the message in its entirety:
> 
>    "Merge remote-tracking branch
> 'iio-thermal-5.11-rc1/ib-iio-thermal-5.11-rc1' into testing"
> 
> Notice how it doesn't say _anything_ useful.
> 
> Merges are commits, and they should have commit messages with
> *explanation* the same way all regular commits should. In fact, they
> generally should have *more* explanation, since they are fundamentally
> more interesting and subtle than some one-liner obvious bug-fix.
> 
> So this all looks otherwise fine, and I like how you were clearly
> aware of the whole cross-tree merge, and how you let me kn0ow about
> it. I appreciate that part, and I've pulled your branch.
> 
> But I wanted to really take this moment to point out that merge
> commits really should have messages explaining *why* and *what* got
> merged. Not just the technical "I merged that tree".

Thanks for pointing this out, I will take care in the future to give a
better description.

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
