Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921A625BDFA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgICI7M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgICI7L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 04:59:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA05C061244
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 01:59:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b79so2055013wmb.4
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mcuO/YRTkHMtsRTTDq5UBJwMUZ7koaTnJHXnA+FiBmU=;
        b=WfRaPugmqj1X57/YKAr3RlaDPEx9TMmvr5cSnhcEmibTe7+c59hhv149PN/V9gGs81
         feRxwbtK8AcBl2+EX8h7i/p2YcV45UzT37c51Qjnj17bd6o5KlI4VA7IQ646Df4/qy31
         uYM7vDY0lhr+mWxOeWr2KS3TjcEFPIUfB137hM08X2itLOioNinnrVnLu5kx/PgcvJtw
         SQdeRrJwpEfuDsVvJcUMJwJw8nZFO+23IDvt9xKzTLaaRu60zmrvX8oglC/Ahl+rCQQt
         //kPLzg4VRvrckm109E1C5REo9jSGTK4+/k20MzNyA0vFiIqOZSMB45tdqwz1ShG8Jig
         VQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mcuO/YRTkHMtsRTTDq5UBJwMUZ7koaTnJHXnA+FiBmU=;
        b=i4sdGbErZIEFsVOZEvdbrYVkwAfg/qQHK4jATg4XkM6X9X/LLD/9AlovF87t91P+RM
         y5beuOCIcvfGcFdahBss8/UknP20cgddO3fTc2peIWseKkndvG6VfFuVPujhWyOouOWt
         eRxktLzjcAQ1RpEZ89+fu+dP2DPJAaAf3TYxcyRSF9FkbkcfyyD+jdb4u974bcy5pR10
         R3ftDnDxTUvPIax0lhZD6xUO7/qU39igDrKQo73TsEC4u5H5uzvoTe4Vz72B42GOT0R1
         l/PN018wyrSZv+N4OzW4jF9zkHSq5k8dKSjCbdWJO0mmnUCUlEmxUEY20f77bzzqRxCM
         oN7g==
X-Gm-Message-State: AOAM533c5Wf4nLPCS+BLT1kE7uGmPUkbGVBaxV2S4NEMb9dKzi3JklZr
        C2yEzcxBl5lfB1CVYBZOKQc7GG4vsPnkVA==
X-Google-Smtp-Source: ABdhPJxA6mQMSjqHWEt2VqGhOmiHHX9y+dvcyCUr02EContrJoPKTbw97sOV7edz+qSvi77dsXYtpA==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr1390175wmg.88.1599123547268;
        Thu, 03 Sep 2020 01:59:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3cd8:a0e1:de28:dec8? ([2a01:e34:ed2f:f020:3cd8:a0e1:de28:dec8])
        by smtp.googlemail.com with ESMTPSA id s124sm3349555wme.29.2020.09.03.01.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 01:59:06 -0700 (PDT)
Subject: Re: TMU driver query
To:     Andy Tang <andy.tang@nxp.com>,
        "amitk@kernel.org" <amitk@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <DBBPR04MB609057FF54F6A1D868438373F32C0@DBBPR04MB6090.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c9c64a1a-2837-3fd1-9e28-fed7fdad1cd8@linaro.org>
Date:   Thu, 3 Sep 2020 10:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DBBPR04MB609057FF54F6A1D868438373F32C0@DBBPR04MB6090.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Andy,

On 03/09/2020 05:06, Andy Tang wrote:
> Hi,
> 
>  
> 
> I have a query about the TMU driver.
> 
> Currently our driver qoriq_thermal.c is using polling instead of
> interrupt method to report the temperature.
> 
> Are there any limitations in the TMU framework if I convert it to use
> interrupt way? At least our soc supports Interrupt.

I'm not sure to understand the 'TMU framework'. I assume you meant the
qoriq sensor, right ?

> That is to say when temperature reaches to critical temperature,
> interrupt handler will take care of the situation.

Are we talking about critical or passive trip point ?

> Also if I enabled the Interrupt, what about the thermal zone? If thermal
> zone exists, both thermal zone and interrupt
> 
> handler would deal with critical warning.

I'm not sure to understand your question.

The thermal zone is the software component. It does the association
between the sensor, the trip point and the cooling device.

The polling values are there to give the sampling rate.

If the sensor supports the interrupt mode, then set the polling rate to
zero, enable the interrupt for the first passive trip point temperature
and in the handler do a thermal zone update.

So when the interrupt fires, the thermal zone is updated, the
temperature is read and if it is greater than the passive trip point
then the passive polling will takeover and the mitigation will happen.

Does it answer your question ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
