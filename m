Return-Path: <linux-pm+bounces-736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D9806D58
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E019DB20C8B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EFC22069;
	Wed,  6 Dec 2023 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wrs6mYs9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA63181
	for <linux-pm@vger.kernel.org>; Wed,  6 Dec 2023 03:06:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso38696285e9.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2023 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701860778; x=1702465578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jClcqTKkEdlh/0n7GUFJamNERw69d7IUU8YIMDhi+mA=;
        b=Wrs6mYs9AEL6tIA5ntG7olO4OAA+eBadszsc7d5gZeNW+0+X6R8Wt1s4Eja2DY6Ym+
         6YJyGClcon6llEifVlGeBdq7p3U477c2tf0aDpJvzYuMwx1hkjkCaLUsSzf5cIMWTUgs
         Lxr0E0CEp6tdYyUxkJ5e+F2Ffiyy9cGEbxeyYRrWVPH6+cLzXU9YUonRTO8TWqNriDpV
         nGXvSvUh/kgqAnD7nO2dxVPTw9B9c4U8pwsLDAN/ghegY5n6g8NLphmclHt2ZCN+SlTi
         BPQLB3d65E1jWJ9RwDvk39+qVixHH25DgBsvarheXLsyzPG3p2nb9nnqDLJRF0jnVLIJ
         fIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860778; x=1702465578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jClcqTKkEdlh/0n7GUFJamNERw69d7IUU8YIMDhi+mA=;
        b=DEFxDxYwXQpnOWCmKcZJFl/6MirfDNo+AhydAHN+sgGe4tzk3aQXQLZ8IXZjPweP42
         134X138T+fLlS0eBNz9T2Qs48MZoOcmF63GuV1X35oSENF6T8HHKStPQYT88IvDq0V+X
         imsWwy8L4CJSQ9jIq1OPOVDYDobLJGfPz5d4jnV9xngEAnrDL1RQv4dlVvtORL6RJQVF
         jw5EVrjnVLb+x2HOCazvxayM1cYlLt6woRDY93g5fr3ADEC1S4sNyfcrJjg271aIEQWq
         WN7qphPBI9i8/qKJabFXzDEkn4fiGA1qd101S5IzqrHYSnSSiYwA3BdkbHB9hyiQ9eNT
         EcWA==
X-Gm-Message-State: AOJu0YwaZJgsE1Rr8OqprXGDKRyOKqDbYKyV4Arxk0j6SNbEdbvG/ECO
	rW+In42EVJZFVV+EMS8paTrHHw==
X-Google-Smtp-Source: AGHT+IH0VuWe5InqREqifmqooyinWBx+yfuLzH9q5QbfammxeOLg8AeNYOhYqj0HtNtgF1CVmZH67A==
X-Received: by 2002:a7b:c447:0:b0:40b:5e59:e9df with SMTP id l7-20020a7bc447000000b0040b5e59e9dfmr489123wmi.126.1701860778670;
        Wed, 06 Dec 2023 03:06:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id je18-20020a05600c1f9200b003feea62440bsm21897673wmb.43.2023.12.06.03.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:06:18 -0800 (PST)
Message-ID: <332dfce5-f2a8-421a-878e-85f95aa64d10@linaro.org>
Date: Wed, 6 Dec 2023 12:06:16 +0100
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
 Steve Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2023 18:25, Biju Das wrote:
> Convert the below bindings to json-schema
> 1) DA906{1,2} mfd bindings
> 2) DA906{1,2,3} onkey bindings
> 3) DA906{1,2,3} thermal bindings
> 
> Also add fallback for DA9061 watchdog device and document
> DA9063 watchdog device.
> 
> v3->v3.1:
>  * Patch#1 is merge of patch#1 from v2 + patch#8 from v2.
>  * Dropped comment for d9061 watchdog fallback
>  * Replaced enum->const for dlg,da9061-watchdog and its fallback.
>  * Restored patch#4 in series 1 and dropped the thermal example
>  * Added Ack from Conor Dooley for da9063 watchdog binding support.
>  * Updated title DA9062/61->DA906{1,2,3} as it supports DA9063.
>  * Retained Rb tag since the changes are trivial.
>  * Added Ack from Conor for updating watchdog property
>  * Dropped link to product information.
>  * Patch#5(onkey) is squashed with patch#6 and patch#9 from v2.
>  * Replaced enum->const for dlg,da9061-onkey and its fallback.
>  * Dropped example
>  * Restored the thermal binding patch from v2.
>  * Dropped example
>  * Replaced enum->const for compatible property.
>  * Added Rb tag from Rob and retained Rb tag as changes are trivial.
>  * Added Ack from Conor Dooley for patch#7.
>  * Split the thermal binding patch separate
>  * Updated the description


Hundreds of changes and just "3 -> 3.1"? This does not make sense.

Also, use normal versioning:

b4 diff '<20231204172510.35041-9-biju.das.jz@bp.renesas.com>'
Grabbing thread from
lore.kernel.org/all/20231204172510.35041-9-biju.das.jz@bp.renesas.com/t.mbox.gz
---
Analyzing 21 messages in the thread
ERROR: Could not auto-find previous revision
       Run "b4 am -T" manually, then "b4 diff -m mbx1 mbx2"


Best regards,
Krzysztof


