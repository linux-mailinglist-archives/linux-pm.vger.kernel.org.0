Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425F032D508
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhCDOK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 09:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbhCDOKY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 09:10:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59323C061574
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 06:09:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w11so27767459wrr.10
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T17aJm4+8Sxz1ZYRb8YXtJA2sdbNDZdl9amp8QmtAXU=;
        b=M9ZvBUjSwr56E8fbsmopWS581gJBk5Pj9f58AmxBrGkMrsfYABGjNkpsNqRXY/QWuU
         hkE6s3KOY88zA5wmPY332CaEeYB0ODjbDLD30VNkAo91O23uf4VgFkEgRgy1WY4rAn9x
         g10U5EqIe7e4mwaSU3rPWLJMVTbFA1KYPbOpLl/KgO60w2J4yl2ePKawaz7Tqb4xBE6D
         MGCef+VDBFzOTPGEom+/UXfhT8WGMOSQZcTNSCkFLEMCOYJoT+6G44N/wgyhMBHH9D3h
         cRnpCIj6A5kc1Qfn3tt172pPAg1Pf/rv9GfZMGo2x8jDaoL5/y4TSmOk6vxD+bM+AqJa
         qTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T17aJm4+8Sxz1ZYRb8YXtJA2sdbNDZdl9amp8QmtAXU=;
        b=m+XThBhySjRI+SHm1MbxOP1GwqantIpxmFKE2Q1B4ouYz2X6kZzweiR43Fv66YlEis
         HJscIh8onHS6tSp9MpJP+dNJKF91/UWYNr0xpxENkDApWZms4bZlC4Bn/co7b51Pw+8v
         vaZQHe/gN8eNZA+voNvX27rdReqMQyCL0bAlCzoDo6loiPDPEt+yiFCWnLp/+gzTZ2UA
         IzpC85qwAL8Eq6rWD7EHz9Ra4Mm9/XEUMF95EF2EmR1F/wrkHUqK7EDjgfisw/0XiVYK
         zSxqWRzS6AN5n72n+KkMFW/YxFnqcN13olaEgupXEM6MnWpBrjq7kzLjW8iHxAq+pyKO
         q+HA==
X-Gm-Message-State: AOAM5339SW/s4Lf602yO23eDQZBr5CNipjjZu6GcAE7Fxo3atP0NHhaV
        0Q1fCQgsNy3PtOaCIxeBrIYgUg==
X-Google-Smtp-Source: ABdhPJzwKmKg6XDNJ1/+JFJx431IKo8FCZlA/xfbJGrDotazs3fbdPKmXKLML3vqOV6oR2m3H+gV9w==
X-Received: by 2002:adf:a2d3:: with SMTP id t19mr4160289wra.299.1614866981985;
        Thu, 04 Mar 2021 06:09:41 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id a14sm41117613wrg.84.2021.03.04.06.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:09:41 -0800 (PST)
Subject: Re: [PATCH RESEND v2 1/2] cpuidle: tegra: Fix C7 idling state on
 Tegra114
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20210302095405.28453-1-digetx@gmail.com>
 <36f5d767-d021-d1cb-dfc1-7b9dd63d7d9f@linaro.org>
 <CAJZ5v0hZKsTnFSrchxo_=jTv7qzoHgsq6W_5Gj4TWWjU5y71jQ@mail.gmail.com>
 <cd887d44-439c-5a3a-346d-ea88df327782@linaro.org>
 <CAJZ5v0jUqtiv7sXOHnDuPzbjxxsqY63Nr-zo-3FnEJOoC85rAQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4de3e520-0d42-b87c-9cb9-d1bd4c3b7813@linaro.org>
Date:   Thu, 4 Mar 2021 15:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jUqtiv7sXOHnDuPzbjxxsqY63Nr-zo-3FnEJOoC85rAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/03/2021 15:08, Rafael J. Wysocki wrote:
> On Thu, Mar 4, 2021 at 3:05 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/03/2021 14:55, Rafael J. Wysocki wrote:
>>> On Thu, Mar 4, 2021 at 1:30 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 02/03/2021 10:54, Dmitry Osipenko wrote:
>>>>> Trusted Foundation firmware doesn't implement the do_idle call and in
>>>>> this case suspending should fall back to the common suspend path. In order
>>>>> to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
>>>>> firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
>>>>> C7 idling, like it was done by the older Tegra114 cpuidle driver.
>>>>>
>>>>> Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
>>>>> Cc: stable@vger.kernel.org # 5.7+
>>>>> Reported-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
>>>>> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
>>>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>
>>>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> So do I gather correctly that I am expected to pick up this series?
>>
>> I had picked the cpuidle related patches in the past. As the traffic
>> became low, I assumed you directly pick them.
>>
>> But I can take care of them and send a PR at -rc5 like before,
>> especially that we have new driver coming. It is not a problem.
>>
>> Let me know what is you preferred way.
> 
> If you can take care of ARM-specific cpuidle changes, that'll help.

No problem, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
