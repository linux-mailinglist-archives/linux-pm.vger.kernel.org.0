Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D277D9F0E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Oct 2023 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJ0Ry7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Oct 2023 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0Ry6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 13:54:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E396F3
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 10:54:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d9d8284abso1508582f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698429294; x=1699034094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/G0/hXTO/wVO1WKjXijEm0YjJ2pMeeOLr8e9nDbTNc=;
        b=dUQS9sQP1QR+D1B4Sdv5Sc4jwvHCgK+6k3UW2MkZAhk48nesC4UbtOnIB0uetJtWEm
         pSzY1kpxnKJGsHDA5wJI5GVl8STtfyE8pQ+j/mSKPGtbN4woRgiwi+u384Z4KmQ8Bc6t
         fVsis8/Dhk//8HEEht9bU4JF4iHVVP9DuyGE+GRyj1VPzun81td02fnb60NNB/cOltfW
         VTnCOQWBcU0F7TVmmfSXiH3z2IKr56vdup+k/b2zrqbRV3wSHKKEAaaVPMVZRNHADid/
         lqo2YookVSL2QGucQdaLw2NRPXXvfXxNzsCHgB1jCSUC6YFKeTwn7BFj3EO/qLtkyfRz
         puiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698429294; x=1699034094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/G0/hXTO/wVO1WKjXijEm0YjJ2pMeeOLr8e9nDbTNc=;
        b=gQ0wkrlUVX2Zde8BGc1z16CXcsUcknij2PDPPkRKXPfCF9xMExzt+rm3GSKZ7UB2jR
         BsmhTXIN3W2uvojROlkVseGPn1iPRjdFcew9E1A9t9vXGlHp+LiTB8VkRphEX2pha4uS
         fzjZeWRbc0utXYft1O4IfypsgjSr025fw6Jf8ZMklpuIN37f18/Kuf2APfzjTlGSRVcU
         qenmhsvl+txK5NcZEBw9inEtOy2uEEX1Z7X9yuLZ4Yb4xTf4jq8La+rX97qq4eM8d85O
         peVNz6o3vx05WLbKHjMbb2hE1I2J4rH5w4BhjVCOgcWKe4HrVqvquUOcFGecLHcwf7xC
         7fFw==
X-Gm-Message-State: AOJu0YzUBZ9KYVkAqiZodzDJIPJhwcOW7kCUkTUWwL+6Vivr412qwqby
        YbM+77W0sC7QbAWePyLHFrPITQ==
X-Google-Smtp-Source: AGHT+IGBd4JF6iFQocFnF6AKP8wEFDW+L/050slnQZIOgn5MjnycELrA8f5CeAZc/hTNU6rpZWNR6Q==
X-Received: by 2002:a5d:550c:0:b0:32d:9fd1:91f9 with SMTP id b12-20020a5d550c000000b0032d9fd191f9mr2266418wrv.60.1698429294553;
        Fri, 27 Oct 2023 10:54:54 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6ac9000000b0032d687fd9d0sm2207853wrw.19.2023.10.27.10.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 10:54:53 -0700 (PDT)
Message-ID: <a5268c46-11c7-49bd-8ad2-17e06adb3d7f@linaro.org>
Date:   Fri, 27 Oct 2023 18:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PM QoS performance aggregator
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <734738ec-b72f-49b4-9a4e-6aaf2a44c9f3@linaro.org>
 <CAJZ5v0j4ceLwx3sh-AOPwtPk6_mya0TvtMRC+d_v0r_hk8jnsQ@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAJZ5v0j4ceLwx3sh-AOPwtPk6_mya0TvtMRC+d_v0r_hk8jnsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 16/10/2023 18:46, Rafael J. Wysocki wrote:
> On Mon, Oct 16, 2023 at 3:03 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> the kernel provides an API to specify latency timings for devices and
>> CPUs. In addition, it allows to deal with the frequencies.
>>
>> However, the unit is Hz and that may not fit very well with some devices
>> where the performance is an index. The devices can have different
>> performance capping mechanisms under the hood (IOW the firmware).
>>
>> The pm QoS seems to not have an interface to describe constraints based
>> on performance index.
>>
>> In the same page, the devices can also be requesting power values
>> instead of performance indexes or frequencies. So having a power based
>> pm QoS would make also sense IMO.
>>
>> Actually, performance indexes, power values, frequencies are just all
>> values but in different units.
>>
>> Would it make sense to create a generic PM QoS constraint with values
>> and units ?
> 
> All of the existing QoS types are frontends to the same underlying
> mechanism and each of them is about using a specific unit, so it's a
> matter of creating a new one for each new unit.
> 
> That said, using performance indices as QoS values directly is
> fundamentally problematic IMV, because they are device-specific and
> not portable in any way and letting user space operate them would be a
> mistake.

In some cases it isn't possible to have a nice unit, the Qualcomm modem
and DSPs expose a service for activating certain thermal mitigations
such as limiting the baseband power. This firmware interface was
designed *for* the cooling_device framework, as such the controls all
have arbitrary maximum states (1, 3, 5, 50, etc) that don't relate
directly to any unit.

Other cases like restricting the charging speed to improve thermal
headroom would actually fit into a generic framework quite well. You
just need to know the current "performance state", maximum state, and
some normalised cost/benefit of moving to a lower/higher state.

The power supply framework would then be able to say "hey you can limit
charging by this much without much impact, but going further will be
quite bad (as the device will start discharging)".

This also neatly describes the camera ISP and video transcoding
co-processors, they might be able to estimate their current performance
state so that userspace could then handle restricting them, and the
values could be used to inform the system at least.

Having the scheduler, userspace, and/or firmware be able to express
priorities for specific devices would then allow us to dynamically
adjust device performance based on the current usecase.

The classic example is limiting charging current when gaming, this is an
obvious choice over limiting CPU/GPU frequencies, a performance QoS
framework should allow us to make these choices with little/no input
from userspace.

In another case, we might be trying to maximise battery life, this could
impose some hard limits on the max performance of certain devices, and
when we are on charge maybe we want to give as much thermal headroom as
possible to the charger instead of other components.


Apologies if the signal/noise ratio is pretty rough here, I think in
general it would be nicer to try and have some fairly generic framework
rather than having a bunch of different ones with different units and
trying to tie them all together somehow.

Thanks and regards,

-- 
// Caleb (they/them)
