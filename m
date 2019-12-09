Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A2116C58
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 12:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLILfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 06:35:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46134 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 06:35:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so15710451wrl.13
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9icDzd2IOCNSPgC6sCTMKrcDBfod4DmTeVlZWitzPBc=;
        b=luHMtXORmB9j4Ry+KD6SfocruF87lLkeelaNaYLpNiIbdYGlP3DVxX1iQB7uHCM4ES
         C8xC09EjsaDkfHpUY1HSjgCjf5oMc1+Rv5a0B6EFhMTufgOzEKB/a4l7dDVDZZb7XEko
         4TIoMegDX5BrxRMYVb0ZcEab8D95qtNTwTIM0OQPNxyJQg76EqpNqV8jo+RUyc5teORn
         CCSu2easfDbmeBhVaS2Gkbr09VSsxbwm4q8nUFkw7Gfx5w1QLRjoKNwMZlUEdIJ5PQUb
         Ur01SSGceDVkFd7VyMXtg26IHAO7mtdVs1KYsdHTtdfxFWGqNpTQPfMwHiKCDNa+tKlo
         vQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9icDzd2IOCNSPgC6sCTMKrcDBfod4DmTeVlZWitzPBc=;
        b=OYlkejqDfsiVQpjnxWT9cYp+cySmtaJntjMxu8CPGNkdPU4vt+Y3kDIX6TIzX9PAFK
         +eunr0wnU8bm4eLF3OyDuHG9fVmfggH7OfLROsl1b8NDWXJXdUSh9+msJY42Qnp+Bp1e
         vLGN/4TOfDxmMdL4lTA4gP2L2U427beBBbiUTcIzaFh5WFQkSDsX8i/836EVjcREJMyM
         7oIsBvhCfFWbG7CYmS9+IZ5KuW8eReVvLkQSFV0/spawDe9YItNTB5gcG4XDWzCVm3zr
         YGXSpWApzN/GN+uPGrgjMvvRgTz834lw/ydilcN6qPbIUXNPjP1IvT5rlAinaJw2fhwo
         Y1hA==
X-Gm-Message-State: APjAAAWtZjCUoUKS7wASHPiYsRg1AG0vmFXWc/d+RMhSHs1ifhCwfsR7
        TtwGon7losuNmBVCJmisg1cqYA==
X-Google-Smtp-Source: APXvYqyl/HgdoxSqNK1CeuX5tcH7MOI/sSa58mx1hX1EYJhZGvKmsZgiKJ4pEihGoyx9hF5izo7VTA==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr1687899wrq.199.1575891320504;
        Mon, 09 Dec 2019 03:35:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe? ([2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe])
        by smtp.googlemail.com with ESMTPSA id l3sm26930120wrt.29.2019.12.09.03.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 03:35:19 -0800 (PST)
Subject: Re: cpuidle regression ?
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
References: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
 <CAJZ5v0iXJz5yAbr_Dhk4k0FqGW6nhn2QF1oGf7Xi4Kfdvc83Wg@mail.gmail.com>
 <62b866a1-739f-8349-81bc-4ccff4ad3a28@linaro.org>
 <CAJZ5v0i44Rb8PeB65sZmnu=8Ctzjw4BeSHqQC2XTG5A7K2pcsw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a2f4c5f4-e416-93dd-24f9-431308a692a0@linaro.org>
Date:   Mon, 9 Dec 2019 12:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i44Rb8PeB65sZmnu=8Ctzjw4BeSHqQC2XTG5A7K2pcsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/12/2019 11:50, Rafael J. Wysocki wrote:
> On Mon, Dec 9, 2019 at 11:32 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 09/12/2019 10:26, Rafael J. Wysocki wrote:
>>> On Sun, Dec 8, 2019 at 11:40 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>>
>>>> Hi Rafael,
>>>>
>>>> the latest linux-next kernelci report indicates a kernel bug for the
>>>> imx6 platform. I don't have this board so it is not possible to
>>>> investigate it.
>>>>
>>>> https://storage.kernelci.org/next/master/next-20191208/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-imx6q-sabrelite.html
>>>>
>>>> [ ... ]
>>>>
>>>> [    3.372501] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000000
>>>>
>>>> [ ... ]
>>>>
>>>> [    3.408898] PC is at _find_first_bit_le+0xc/0x2c
>>>> [    3.413785] LR is at cpuidle_driver_state_disabled+0x40/0xa0
>>>>
>>>>
>>>> Not sure if it is related to the latest changes or not.
>>>
>>> It does seem so, in which case the attached patch should address it.
>>>
>>> Is there a way to test the patch alone or do I need to push it
>>> somewhere to be tested?
>>
>> Is the bleeding-edge branch monitored by kernelci ?
> 
> No, it is not right now, AFAICS.

I have a imx7, I will try to reproduce the issue on it. Otherwise, I can
test on the 'testing' thermal branch temporarily.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

