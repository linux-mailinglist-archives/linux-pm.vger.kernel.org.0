Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BD380A3D
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhENNOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhENNOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 09:14:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E44C061574;
        Fri, 14 May 2021 06:13:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i22so56693lfl.10;
        Fri, 14 May 2021 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i2YVeoDkMZvOvbeeQWtb2yx5+1XeddYfBmoh/c43NIM=;
        b=E51atqUQhUeGIEH376LMu/E0anBqmi7sBhTYhXBgj5e2+3Tqy6VM/ZLrmeLogGFJho
         z0paUrTmKHy6sR/FmZ7Ef0SBhjFZY0eXgi0AU4NFxzli/Qk74kwP1BTyepmopS2iMX1g
         F6xHeMXTAm/6Wg7QSLHsnW1pEmYCxMleMD9xFjb4VaYxaecCKrpGL6BARF3EL6Hpm4e8
         OSB/C4ElPf4A4tuWQrBzOV1qcWZq5vtd/TWozWVJGelkTdMffHeMHK7INPvkurWnzAyG
         dDUzeHNyxjewyQHirK719f5s7YKH2UMl/HHiB2FVL5Zq0Q/JgkbDINTyOdesDdMVl5i4
         mk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2YVeoDkMZvOvbeeQWtb2yx5+1XeddYfBmoh/c43NIM=;
        b=XZh2jFAy8T0x8gg04cdQ2i462fO1go5M7l0icZpzC5jEbRXij1RpWVKYVsQnWy32B1
         NCKEns7X9Un7puDdCUp2Kccsoz52UUdiL2wE5na7w0BVupZMz6JFV57FsvtJnnPidlcu
         4RTkh9WvWIySGFzc/eW0I/mQEJZvniJx5eu5ZRe1FRQtLxdLk9ZjVCzsutLax1OxhrmB
         cXXNekR3Fs7UK5MDmOnMOrVGUqKRW2Ou1LPnXq6wZNULqp2fg6rRHEs424IxewhBLsy0
         LauAU7MUM855I4QWFHmZaObY93S6pnTDhgPdJ5bGWmmpX4mAHy6O9EzxyJOMbJIlnder
         i4wg==
X-Gm-Message-State: AOAM532k6bd4GtU79x7rNmu3mtTMTI1UW9vFfd6ktPHL9bad+ahNhUf4
        v+fiBweiYAQKMLjYFFraH8TOMdiLICE=
X-Google-Smtp-Source: ABdhPJwdd9oCmjpI+7GNkkfiOImBIIM3ZKAuOC/jodf+KwLmVX2WGnUHexCYeqthbBJQjX0sUxjcrg==
X-Received: by 2002:a19:dc0c:: with SMTP id t12mr32894282lfg.279.1620998020615;
        Fri, 14 May 2021 06:13:40 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.googlemail.com with ESMTPSA id q5sm711164lfu.109.2021.05.14.06.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 06:13:40 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] power: supply: sbs-battery: Silence warning about
 unknown chemistry
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210510220827.11595-1-digetx@gmail.com>
 <20210513151103.hihvxg7kvych4nwr@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <76b598cc-570e-96ac-8456-0ce481aedaeb@gmail.com>
Date:   Fri, 14 May 2021 16:13:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513151103.hihvxg7kvych4nwr@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.05.2021 18:11, Sebastian Reichel пишет:
> Hi,
> 
> On Tue, May 11, 2021 at 01:08:26AM +0300, Dmitry Osipenko wrote:
>> Older variants of controller don't support reporting type of the battery.
>> Make warning message about unknown chemistry to be printed only once in
>> order to stop flooding kernel log with the message on each request of the
>> property. This patch fixes the noisy messages on Asus Transformer TF101.
>>
>> Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # TF101
>> Tested-by: Nikola Milosavljević <mnidza@outlook.com> # TF101
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> I believe the problem should be fixed as side-effect of the
> following patch:
> 
> https://lore.kernel.org/linux-pm/20210513020308.4011440-1-ikjn@chromium.org/
> 
> With my suggested change the message is printed once for each
> battery plug, so probably only once per boot for most users.

Looks like that patch indeed should work too, thank you.
