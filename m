Return-Path: <linux-pm+bounces-738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF67806DBA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01111F214F9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A463172E;
	Wed,  6 Dec 2023 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ku54GT58"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D85B9
	for <linux-pm@vger.kernel.org>; Wed,  6 Dec 2023 03:18:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so2850775e9.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2023 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861483; x=1702466283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fitmpEZwSZub2h62MYKxk2Z8LqF4qUvTr5Zsg6iTjCA=;
        b=ku54GT588gim2IyRpYp0zuH442p9yc6S04oMqS67bjBczFj+3vqk8u/+s4xOtfwzWl
         yv6c4pxYZwDorl+DMgYeI3PhaCCwHUJeajVxtceL1RH3iZCukLjF8vBEEcds4kLdTSlb
         WZ9TPkeerVrLP++i4zU5J311x15QtT8tpq3dwZgjWyw7eg1E4V/DzkjC1r38g0xZIXgp
         rAn8yZqSybhERgYFHDMe5HqZDJdNwRHvbJfVyzPmdi2QefeqUg2Fa+C0BKEZBwWYhijc
         4fl+4kkZvinmpNucLVHs2JqRFkS0Rvec8yxc9gySFQaod4H1CvvvY/3LmnoO/uc77Xcy
         rVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861483; x=1702466283;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fitmpEZwSZub2h62MYKxk2Z8LqF4qUvTr5Zsg6iTjCA=;
        b=w9TzIscmRldVOYo7+4acxxft8QPKcZiwY9YH8ChoUWQp4179qXHr2GrGa2+0FBbDzJ
         znDyev+xMleVjVk68CMHi3JdSJYdahhWboPm7/5oLaizWTwRI5BSXItD6CEs90M6tv8V
         6kYv2t9LjTHFbjzsiyyqeNDRAO1wNwzzXWBWzhlx2bbfeHVXrmH3ZfhrjmZ+UEz0nXp0
         q136MymjbcC62tCjyvR/ZM8sRQGZLNcILZcriDYlWCAkmOiplEmKa0DDYqkaRsd4HXlK
         MG41eOJlx1++nH3xKbi4tzZ3yU4uhx2mBumaPUa+DOWFN30/5OeXqXI4JfxpOKjIDygH
         311g==
X-Gm-Message-State: AOJu0Yzfucqz5vmaQOEQa66RVfNpccinSeOMQYbz1xkJF5uRtg7HiRqp
	nW4PBUFZ1dWdcw0+6pQ4kGEwmA==
X-Google-Smtp-Source: AGHT+IHyGCTmsht55B2iMsFWxhj7qQUbFcSFVHVmnaUex8ik/mCAKTUrgLMtlABlwyyf7x8npeDpsw==
X-Received: by 2002:a05:600c:4d8f:b0:40b:5e56:7b42 with SMTP id v15-20020a05600c4d8f00b0040b5e567b42mr1514484wmp.139.1701861483325;
        Wed, 06 Dec 2023 03:18:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id az39-20020a05600c602700b0040c1c269264sm1706232wmb.40.2023.12.06.03.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:18:02 -0800 (PST)
Message-ID: <33b097c7-0c7f-457c-b597-19c504df5a36@linaro.org>
Date: Wed, 6 Dec 2023 12:18:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Steve Twiss <stwiss.opensource@diasemi.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
 <332dfce5-f2a8-421a-878e-85f95aa64d10@linaro.org>
 <TYVPR01MB112796A859B42CC4AC6F6EC838684A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYVPR01MB112796A859B42CC4AC6F6EC838684A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/12/2023 12:16, Biju Das wrote:
> Hi Krzysztof Kozlowski,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, December 6, 2023 11:06 AM
>> Subject: Re: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
>>
>> On 04/12/2023 18:25, Biju Das wrote:
>>> Convert the below bindings to json-schema
>>> 1) DA906{1,2} mfd bindings
>>> 2) DA906{1,2,3} onkey bindings
>>> 3) DA906{1,2,3} thermal bindings
>>>
>>> Also add fallback for DA9061 watchdog device and document
>>> DA9063 watchdog device.
>>>
>>> v3->v3.1:
>>>  * Patch#1 is merge of patch#1 from v2 + patch#8 from v2.
>>>  * Dropped comment for d9061 watchdog fallback
>>>  * Replaced enum->const for dlg,da9061-watchdog and its fallback.
>>>  * Restored patch#4 in series 1 and dropped the thermal example
>>>  * Added Ack from Conor Dooley for da9063 watchdog binding support.
>>>  * Updated title DA9062/61->DA906{1,2,3} as it supports DA9063.
>>>  * Retained Rb tag since the changes are trivial.
>>>  * Added Ack from Conor for updating watchdog property
>>>  * Dropped link to product information.
>>>  * Patch#5(onkey) is squashed with patch#6 and patch#9 from v2.
>>>  * Replaced enum->const for dlg,da9061-onkey and its fallback.
>>>  * Dropped example
>>>  * Restored the thermal binding patch from v2.
>>>  * Dropped example
>>>  * Replaced enum->const for compatible property.
>>>  * Added Rb tag from Rob and retained Rb tag as changes are trivial.
>>>  * Added Ack from Conor Dooley for patch#7.
>>>  * Split the thermal binding patch separate
>>>  * Updated the description
>>
>>
>> Hundreds of changes and just "3 -> 3.1"? This does not make sense.
> 
> Bot reported some issues with v2. So immediately I send v3 which clashed
> with review comments from Conor and Rob.
> 
> No one has reviewed V3.
> 
> V3.1 = basically Review comments from v2 + Fix for Bot errors.

v4, don't introduce some minor numbering to create impression of no
changes, especially if you have multiple changes.

> 
> 
>>
>> Also, use normal versioning:
>>
>> b4 diff '<20231204172510.35041-9-biju.das.jz@bp.renesas.com>'
>> Grabbing thread from
>> lore.kernel.org/all/20231204172510.35041-9-
>> biju.das.jz@bp.renesas.com/t.mbox.gz
>> ---
>> Analyzing 21 messages in the thread
>> ERROR: Could not auto-find previous revision
>>        Run "b4 am -T" manually, then "b4 diff -m mbx1 mbx2"
> 
> 
> Can you please clarify more? I may be missing something here?
> 
> I just rebase to linux-next and send patches using the command
> 
> git send-email --dry-run --annotate *.patch
> 
> All patches Updated with TO and CC recipients.
> 
> Am I missing anything here w.r.to versioning?

v3 -> v4.

Best regards,
Krzysztof


