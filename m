Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46633EF64
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 12:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCQLUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhCQLUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 07:20:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF19C06174A;
        Wed, 17 Mar 2021 04:20:44 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n195so40087878ybg.9;
        Wed, 17 Mar 2021 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M7H4Sph9LFk5VipcZaNW89rs5i3oWGx0o0AqhjUtRJo=;
        b=WI/SAvTgqx8/5bnme6xsczMeeqpZ68OgWmln6jSdabfw8lOeRjDQDMTzJWWbm4TwV8
         /3LlOCIQpp35UbAxGryJ1juNOUPoGCmRY+5mv91VloNyfcfxI4B7v10BBukgX3x/OlyN
         CWUzchVM8i+7HLmZJ0p4FeiQb12dqa6KrLjDz1Opw1kUTJUEvw2BoEAHEsnDrIbPa84W
         F6rhKcFIMV02iEqILxbWPmZmyirVvbJonYgGitAGeaZ5ukpOaFAfXX1Lu7sv7p4mGife
         wjZaIsP+A3Jp5OyscuqeulDmH3zNxIiUh5U9zAE/rtehWVaxEIGX1el0XGfksHzdy12w
         fm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M7H4Sph9LFk5VipcZaNW89rs5i3oWGx0o0AqhjUtRJo=;
        b=qTFUi5aqBLY9LEO+rGQEBSST4RJ8+/rnj5t7BFHkhUstE2snsotE4/mgiVeebs4Wfc
         alrminYstPY28TFRPyC1v7MsaPwADZF71cP3DsRqX+zmVZtm3En5Wl6K26HY1LnTHf0T
         EeDmqlQuH9EViosjAYauJ4DDkxWaWWb1r5/VfYOXPmFETdxiKCJCXtj2RhWW0O6FLXEw
         tXttS03Ja+kPIkDGmfc+MlRZN6Ut7h0Nz0xQrPGNIk9V1FyYVdMnfYL9AZbM77jhRCh6
         PO3YmVol9zJMzOhWaFbH0KyRQA8c+kj/M4hlFcTf96ZF+x/EgUjHDspl129pr1+1sAma
         LJtg==
X-Gm-Message-State: AOAM531grB4zhDZvOaACN/7iI6g9PeVpwkA2Ww2e0291bu10X/1gJCeJ
        +ydzfnJsBm6kNFaRnUMvqBRt2+SjMqJ2NUHZo2M=
X-Google-Smtp-Source: ABdhPJwSqLGe3Ot9SlvW9MMrZ/7mqOZYmN5PEE1cNUum/+FzV4PP+VR446B8kFcDKGWx5Kk/snCUajlsIKOwvozOg0U=
X-Received: by 2002:a25:9108:: with SMTP id v8mr3801223ybl.321.1615980044182;
 Wed, 17 Mar 2021 04:20:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:a398:b029:3c:ca2b:6630 with HTTP; Wed, 17 Mar 2021
 04:20:43 -0700 (PDT)
In-Reply-To: <922427b0-4140-6f4a-4bad-9043bdc5ba99@arm.com>
References: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
 <9c14451e-be6f-0713-4c26-8b67e1fa51a5@arm.com> <381a12bf-c917-c2c4-1915-f129221d6475@linaro.org>
 <922427b0-4140-6f4a-4bad-9043bdc5ba99@arm.com>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Wed, 17 Mar 2021 19:20:43 +0800
Message-ID: <CANO_MSJgwOMgBomFVO6VyQpAB6KpnQJdCKYqxrABkJzMqWtMzA@mail.gmail.com>
Subject: Re: [PATCH] thermal: power_allocator: using round the division when
 re-divvying up power
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, "jeson.gao" <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lukasz,Daniel, Thank you for your review!

On 16/03/2021, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
> On 3/16/21 1:15 PM, Daniel Lezcano wrote:
>> On 15/03/2021 10:51, Lukasz Luba wrote:
>>>
>>>
>>> On 3/15/21 8:25 AM, gao.yunxiao6@gmail.com wrote:
>>>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>>>
>>>> The division is used directly in re-divvying up power, the decimal
>>>> part will
>>>> be discarded, devices will get less than the extra_actor_power - 1.
>>>> if using round the division to make the calculation more accurate.
>>>>
>>>> For example:
>>>> actor0 received more than it's max_power, it has the extra_power 759
>>>> actor1 received less than it's max_power, it require extra_actor_power
>>>> 395
>>>> actor2 received less than it's max_power, it require extra_actor_power
>>>> 365
>>>> actor1 and actor2 require the total capped_extra_power 760
>>>>
>>>> using division in re-divvying up power
>>>> actor1 would actually get the extra_actor_power 394
>>>> actor2 would actually get the extra_actor_power 364
>>>>
>>>> if using round the division in re-divvying up power
>>>> actor1 would actually get the extra_actor_power 394
>>>> actor2 would actually get the extra_actor_power 365
>>>>
>>>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
>>>> ---
>>
>> Applied, thanks
>>
>
> thank you Daniel!
>
