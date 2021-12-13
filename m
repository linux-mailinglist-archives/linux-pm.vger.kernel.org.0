Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D331B4723AA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Dec 2021 10:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhLMJXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Dec 2021 04:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhLMJXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Dec 2021 04:23:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D0C061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 01:23:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d10so29595918lfg.6
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 01:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :references:subject:in-reply-to:content-transfer-encoding;
        bh=iqm6xEHR24DEGP71Dw334SXtVnwmbVG6/wYj4wQS+wE=;
        b=AeZAqxLdDTlTNEkoMHgl9Bs90sMDvs+wcGUnOtweBW0Uj0KNikARKCMyGRad3rtkus
         XfRwuH6Nir5cGLvC9BLzy/GA4flYdV+CASqUrIsQ2NKrDBlqlIJMjtsLeQI3ExFc2UPT
         eSRhGcIE54/GKhWfCgWnhKVWu45s37gUjoUwTM4rWhel4fK91bF+E8GSzfPSFzeuSVmK
         /e5ADB7bbqxWd0IWDeDvaf95iyre/99aqSRe1BDW1pHz1orAftCu5xpe98EAea/5f3Fp
         34Fjc1hnlixHubvB5jXp0P8zsVWHQz/t5oKXafK2SsEnKWQvURCYKGZw0oVaV2Iyejgg
         yBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=iqm6xEHR24DEGP71Dw334SXtVnwmbVG6/wYj4wQS+wE=;
        b=Lwb17fSmX/PPW0rrDhp+/rC+i/zYU40EsvvrLnHuB/wJ5NXO2UcC0hrtk1POHr69pO
         nu6yl50m2xtFG0/htniWKtd4NqWNN5tFKPlqHKlXchCQfCh9tuiusnTLm4kOcCkDM2mD
         O/oxzsW/j9twTLpBXA0ZkFs8mqgNf3Cikds8DJmeD+Jn+a5Gk9nP3hz/d4z0tWqfISvB
         abABHPPyf6NAOGxcN73YY4ghb5jiaig+xssprHhJiUyv6QmjkvK2wKmU/4rxpCGBC3sU
         7A3FznisLrPbsNQCi6L0ZCddWyz24xyXRrwG2Pp0k1RLrQCpMstmZwKgm6jGLYqUHJS5
         yqeg==
X-Gm-Message-State: AOAM5324aYcQOkA+Gfsf6FoYZIffpxnVZE5459O9NeY3U00JjFnAmBTF
        MTLlcbAhZ7KgAaN8Kgof2Es=
X-Google-Smtp-Source: ABdhPJxldbZ5cIUlTnkjszQZmbp7FIFxxOdp1TKY5MtYo4lObdF9CAJ0LWRe92FpGO7acS+HzNJNNQ==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr28008802lff.261.1639387413449;
        Mon, 13 Dec 2021 01:23:33 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id p3sm1349039lfg.205.2021.12.13.01.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 01:23:32 -0800 (PST)
Message-ID: <881a158e-4d2d-b09b-621f-12bfbaf671cd@gmail.com>
Date:   Mon, 13 Dec 2021 11:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20211206000651.4168035-1-linus.walleij@linaro.org>
 <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com>
 <CACRpkdaKmZp62DSB7oMbESRjXAH8ncfLyc3KioSDx2z-_JOK8A@mail.gmail.com>
 <CANhJrGMHr=VLAwe-Tvyg70nN4ArjHa8UHKZODwrufK1r+rRNcA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
In-Reply-To: <CANhJrGMHr=VLAwe-Tvyg70nN4ArjHa8UHKZODwrufK1r+rRNcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/21 07:57, Matti Vaittinen wrote:
> On Thu, Dec 9, 2021 at 2:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:

>> Also I would love if you could test v2 on hardware!
> 
> I don't have a real device with battery connected - but I thinkI do
> have a break-out board with BD99954 lying around somewhere. I'll see
> if I remember how to wire it to a beagle-bone - and if I do, then I
> can try some very limited testing. Adding automated tests for the
> BD99954 is still on my TODO-list, somewhere at the bottom of it... :(

I have good and not-so-good news. Good news is that I did indeed find a 
BD99954 evaluation board from my collection PCBs I have "temporarily" 
stored in a box under my bed XD

The not-so-good news is that I thought I do remember how to connect the 
board - but it seems I did not. As a result my beaglebone said "Zzzzap!" 
- and lost the magic smoke which kept it operational. I have only one 
spare board left - and I do noeed it for bunch of tasks - so I am afraid 
I can't re-try testing untill I have ordered and received few 
replacement boards... So sorry - no testing to be done in the next few 
days - potentially no testing until year 2022 :(

Best Regards
	--Matti Vaittinen
