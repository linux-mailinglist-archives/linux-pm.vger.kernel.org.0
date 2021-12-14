Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED721473D50
	for <lists+linux-pm@lfdr.de>; Tue, 14 Dec 2021 07:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhLNGoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 01:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhLNGoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Dec 2021 01:44:16 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB0AC061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 22:44:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m12so26930372ljj.6
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 22:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :references:subject:in-reply-to:content-transfer-encoding;
        bh=Zk8cJO1kr06PsJ7wD94RWiV/f4yvLXDSXBRWLKlt3Ms=;
        b=TH5GNUIBwg37NYB5E+pylaVRP5zbL5iAuduWJs7v2zgpqG80suUMPWyegIRmIW5fki
         fz0qugz+SwgnBKq5qavvBGvQu06mm39pUjTbbTEhEEjinzI7Si27M6k6YklnQLkZRx43
         XEjphl1D5twXJe/CK7yfm82vySFWgN3ycdYF3510Dajc55M3yUdgz+htqqE6QpBbdjzJ
         eK4sdERm9E8e2OEy2N7wjjbHiEKJrH8vIzi/UJs6vMatz0N3I9qQnI4tsKXpD/WgwuOx
         hkbmdmJToU2Gd+tZtiGUWebLS1D+/23d7ZmQQCzUZIcOS/0BULJMXRIgwbdzRlseBrgZ
         em+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=Zk8cJO1kr06PsJ7wD94RWiV/f4yvLXDSXBRWLKlt3Ms=;
        b=YgJayGIwRj609Kpr1a2aninjNVxQvgbB8xFA6a7Ujf4u2I9QsyxI4p0I4v8+pJO9rf
         v2uJjMKjOpPBLbvXowXprCa8y5n/1KL1VUd/ybg5T2wf9Fp/ko1Sx1+wDIKuXmE/AEEc
         MDActFfJeaAaAzNPD+YvN51GCPYssJ3x2GaREGP3o25haA8/QBWECtSXmEmWshDLKCJR
         jxEVu6mZXG/NbcpTDpozApc0RscY/AtLP65sRgpXZ5VGcB54nveGwbuOq10yScJxzTKR
         by2Tvsx2BeRwsrIPqTBnN97GEpWqp33M+RyR+nOdhgVYt13UM1x3x0RuAEHh7BAw8maj
         wuFw==
X-Gm-Message-State: AOAM532qGWrcmWwt5l9eec4nANTr3TbkarjrSgjG53dli6yQ2ssMHzEz
        8Nmf2/mGOzzgqi5GuYhnNX1YLUSw33c=
X-Google-Smtp-Source: ABdhPJwQ35Gpn/bjNHbYC53sKzsSLrcy2Kk7vYioYnTcKMmqdUcO7LVZlJ9Yt9KmlIiMuzmIsAJ/dQ==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr3019272ljp.204.1639464252679;
        Mon, 13 Dec 2021 22:44:12 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id f14sm1745271lfv.180.2021.12.13.22.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 22:44:12 -0800 (PST)
Message-ID: <04df0bff-87b0-d39a-4f5c-bbeb7f3e0cd1@gmail.com>
Date:   Tue, 14 Dec 2021 08:44:11 +0200
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
 <d4478fbf-1ec8-5659-c77d-f412c351e497@gmail.com>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
In-Reply-To: <d4478fbf-1ec8-5659-c77d-f412c351e497@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi deee Ho peeps,

On 12/13/21 11:23, Matti Vaittinen wrote:
> On 12/10/21 07:57, Matti Vaittinen wrote:
>> On Thu, Dec 9, 2021 at 2:46 AM Linus Walleij 
>> <linus.walleij@linaro.org> wrote:
> 
>>> Also I would love if you could test v2 on hardware!

... snip ...

> spare board left - and I do noeed it for bunch of tasks - so I am afraid 
> I can't re-try testing untill I have ordered and received few 
> replacement boards...

It seems I like to live on the edge. I nevertheless connected my spare 
BBB board to the BD99954 and got it working. (I noticed I had two loose 
wires touching each others during my previous trial. It resulted 
shorting +5V from beagle to GND - which was not a good idea).

It appears the patch worked as expected - but it also appears the 
BD99954 driver does not handle missing info too well... I typoed the 
trickle-charger current property in DT - and as a result the driver 
decided -EINVAL to be valid value (just too large) and set the largest 
current BD99954 supports for trickle-charging... I think this same 
problem is there for all the -EINVAL values. If I am not mistaken this 
is somewhat nasty as it means that if some information is missing the 
driver will change (potentially pre-configured) values to something 
which may fry things...

Linus, want to fix this while at it - or do you prefer me to patch the 
BD99954 with some sanity checks? I think it'd be nice to get the fixes 
in stable so it might be best to add the sanity checks before changing 
the battery-info allocation - that might be nicer for the stable folks. 
(I guess you have plenty of other things to code + some IRL tasks as 
well ...;] So, I can patch this but it means there is likely to be some 
conflicts with your series. Hence I thought I'll ask if you wish to add 
checks for uninitialized battery-info values)

Best Regards
	--Matti Vaittinen
