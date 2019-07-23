Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB571DF4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 19:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfGWRsy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 13:48:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732899AbfGWRsy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 13:48:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so44078403wru.13;
        Tue, 23 Jul 2019 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lw64+rRIlfN9llW/JDiD/kh+iAbtqzU9FtUm2AviLUY=;
        b=Ke3RPY0nRkGmJqorFON4W7UvAFnkA1mTmK8gK+LxqpYaD0WyDD4gpEOy9WsiKfyMAF
         ckDHJKdnFRzE9HTqkBBdOaYhlR5E/tb2JQV5L+QmIyzLEeetcUt041iAxRTcIXJSssDL
         xFcEbyhOSfvP6/WUTcANQZ2cxsbzehXZpQnWoAK5tWbQ5+zgaoAXS2v1UG0SPhDIsv2E
         +sCFF9b2EcSE/6YySPLIpwiCJYhxkvkMNdD5uCxyTokdTkPN6kjFKvkoM3dpGNBCMAr9
         88nNP/eTPYMxt28eJph8/yqDKWHTZUuZowGAwm0op/JW6H8FBGEAFbFPC0Hl7SD9Q5vv
         0aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lw64+rRIlfN9llW/JDiD/kh+iAbtqzU9FtUm2AviLUY=;
        b=i0FWOtBMREEDc+9OlgTM4G2FO2IYhOLmP1RswPeEohD4To0NbUnc5RVFmAOQYeJQMT
         NDg6LAi8qmkMvglXtHi7bpdI3dWhGpydV1jZ1QywbgSZ4K4QUsvRjNKSQA70kgB1h9SY
         75x3pHwc+zNA3pg/ntnVjSgSGGcqpUK9u/Yb6dzX8EbLdxWRO0RSzYcS5nxn2xD45uZB
         G21PprFI4UtwYVSCWD4bYoYvGpFO/aV/lJX63f+HPBWGIPn0x8kc49AQhkoBw4KXxmyZ
         q78xsLxGTnSD6EHq5Ggt0hprX7RIumvNh3RpXOao5GsAW0f2GX5BZWVAVWrZpA2FrbaB
         nrsg==
X-Gm-Message-State: APjAAAVxmxzdvZfnmC4TfHzvnrobP8Vwz9bbYgjcu62/udKfYbQC6UzJ
        VK6MuIreW9y62CGztEwcd4o=
X-Google-Smtp-Source: APXvYqxdFMbhlyWIB3rurr1U5IoeuLXQYUOJJbXjUXp92CDnV3P5Zl4OeajfZDbeHqLTFBexZfqAgQ==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr79701010wrq.194.1563904131910;
        Tue, 23 Jul 2019 10:48:51 -0700 (PDT)
Received: from [192.168.8.14] (nat-113.starnet.cz. [178.255.168.113])
        by smtp.gmail.com with ESMTPSA id r123sm39419602wme.7.2019.07.23.10.48.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 10:48:50 -0700 (PDT)
From:   Evgeny Kolesnikov <evgenyz@gmail.com>
Subject: Re: [PATCH 0/5] Add support for WD MyCloud EX2 Ultra (+ versatile
 UART-based restart/poweroff drivers)
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <cover.1563822216.git.evgenyz@gmail.com>
 <20190723015631.GI8972@lunn.ch>
Message-ID: <c2ffe662-6975-351b-87b8-af760984ef4d@gmail.com>
Date:   Tue, 23 Jul 2019 19:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723015631.GI8972@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/07/2019 03:56, Andrew Lunn wrote:
> On Mon, Jul 22, 2019 at 09:53:00PM +0200, Evgeny Kolesnikov wrote:
>>
>> The difference between uart-poweroff and qnap-poweroff is small, but important:
>> uart-poweroff is able to send to an MCU a command of arbitrary length, and the command
>> itself is defined in a DTS file for a specific device/board, thus making this driver
>> applicable to wider range of devices.
> 
> There is a lot of replicated code here, and in the original
> qnap-poweroff.c driver. Please consolidate it by extending the current
> driver. It should be easy to add a new compatible string, and turn
> power_off_cfg.cmd into an array.

Hi, Andrew.

I've considered extending qnap driver, but I have some doubts about this 
approach.

First of all there is only a poweroff counterpart. As there is no
qnap-restart driver, what should I do with uart-restart? Is it OK to 
have xxx-restart-poweroff driver (never saw anything like that)?

While I can add cmd as a parameter to qnap driver (having it converted
into an array) it should be optional as original qnap relies on two 
hardcoded values for its devices. And having a non-qnap device with this 
driver in DT without defined cmd would not make any sense. It feels 
kinda ugly.

Wouldn't it be more fitting to have these two generic drivers and then 
retire old qnap driver while moving everything that uses it to the new one?

Thanks for the review.

EK.
