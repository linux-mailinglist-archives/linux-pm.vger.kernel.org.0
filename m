Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA7F769C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKOkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 09:40:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKOkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 09:40:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so9569605pga.12
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HSZMQWzyEHnnHHGSgljiQy/rMe2MxTJvgjXJLTPB8Uw=;
        b=LAzanCohnqFWoF8gGT+BAns/rhQOt9zScUEdL2og/ftcWJRRiv37aXkm3RKjkwf2p+
         ALvBnZ0EdR41oJ1oipALK9HTNW3YLU06bdHqI2mCfXrRsOaH72lpnrDVj5qht22plo/I
         raY9u3gdnGyg9LrKuqIgdSuLbCkvJfvay3T8/j8RznOfP86n5uNku2uD8mRBWIFfzE+x
         G/+VqYJp/K+k64wGPG8tHH6inJ6Hd1ahzyAjEVin93HD7RgfQgN1EWHr0ZnCvNPTcbvR
         jqMd59qSv/jCqsbpiUag62bFCGY4vM8w9wV78ceO1YpZDuIddkh2Vm/IcPfH6F2kTCrD
         7hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HSZMQWzyEHnnHHGSgljiQy/rMe2MxTJvgjXJLTPB8Uw=;
        b=P/GgoL0V5wwGj6/l0z3mSW9dOvehsBUoXS4heYi9FCJJqd3wRbf28h0cL471RVcY+U
         5V42WX0LS20k+xewuQ1JDzHycQyGOwi1GxOey5G6zFsy2YffDzMoJ1OgqP6jKCn87uF9
         sAk7MRT6AiaT2c07BQNIk1SINwuXwzp4xJ3veWOD/sZUmM81rPy56AS1tIYFjc0oOIkU
         rC5JmN+Vaj4baV5BZHglxMfOmrUc3ALR5fVcY7Jt/BpajKRgfEQR3by6RhP5fgsMrsDH
         yUPK9VxEI/xIun0uIzUQ6oTtz+BCFAYYsci3SDCzI9A4BUFZYOZAjiztqTOgKxmqq/J2
         s+jw==
X-Gm-Message-State: APjAAAUtglk3V28kbhptI0y4cNfT5ZmK9UlEqU2Dqsbgfh49hEHe5S7S
        0J8oAHO92e1HPNthV70uAe4RUA==
X-Google-Smtp-Source: APXvYqzRF26meFYV5Haf+VOng2ZQhf2ivGmMtkGpcH5rhUWnKoKrEYEEDzl/1JLe7l1dj9g5OfIKpg==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr35797335pjb.128.1573483220407;
        Mon, 11 Nov 2019 06:40:20 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:dd5e:2cce:fe26:7bc6])
        by smtp.gmail.com with ESMTPSA id fz12sm13611195pjb.15.2019.11.11.06.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 06:40:19 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v4 2/4] firmware: meson_sm: Add secure power domain support
In-Reply-To: <420073b1-0a3f-1bfd-4422-34f8cd7e0d2d@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com> <1572868028-73076-3-git-send-email-jianxin.pan@amlogic.com> <7hk188stcy.fsf@baylibre.com> <420073b1-0a3f-1bfd-4422-34f8cd7e0d2d@amlogic.com>
Date:   Mon, 11 Nov 2019 06:40:18 -0800
Message-ID: <7heeyecw8d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Hi Kevin,
>
> Please see my comments below:
>
> On 2019/11/10 4:11, Kevin Hilman wrote:
>> Jianxin Pan <jianxin.pan@amlogic.com> writes:
>> 
>>> The Amlogic Meson A1/C1 Secure Monitor implements calls to control power
>>> domain.
>>>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>  drivers/firmware/meson/meson_sm.c       | 2 ++
>>>  include/linux/firmware/meson/meson_sm.h | 2 ++
>>>  2 files changed, 4 insertions(+)
>>>
> [...]
>>> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
>>> index 6669e2a..4ed3989 100644
>>> --- a/include/linux/firmware/meson/meson_sm.h
>>> +++ b/include/linux/firmware/meson/meson_sm.h
>>> @@ -12,6 +12,8 @@ enum {
>>>  	SM_EFUSE_WRITE,
>>>  	SM_EFUSE_USER_MAX,
>>>  	SM_GET_CHIP_ID,
>>> +	SM_PWRC_SET,
>>> +	SM_PWRC_GET,
>> 
>> These new IDs are unique to the A1/C1 family.  Maybe we should add a
>> prefix to better indicate that.  Maybe:
>> 
>>        SM_A1_PWRC_SET,
>>        SM_A1_PWRC_GET,
>> 
>> Thoughts?
>
> I consulted with the internal VLSI team, and it's likely that the latter new SOC will follow A1/C1.
> And then it may become common function in the future.

OK, but it's not a common function for the past, so it's useful to mark
that distinction.

Just like in device-tree, we often have compatibles named for previous
SoC families (e.g. "gxbb") used on newer SoCs, but we use that to mean
"GXBB or newer".

Similarily here, we can use SM_A1_ prefix to mean "A1 or newer.

Kevin

