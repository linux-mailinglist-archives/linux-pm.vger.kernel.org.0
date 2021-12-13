Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5010A4723AB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Dec 2021 10:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhLMJXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Dec 2021 04:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhLMJXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Dec 2021 04:23:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA204C061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 01:23:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u3so29648881lfl.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 01:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :references:subject:in-reply-to:content-transfer-encoding;
        bh=iqm6xEHR24DEGP71Dw334SXtVnwmbVG6/wYj4wQS+wE=;
        b=K6ue4cRbEnf4K5nRsqCgIGj1VWcCXDeTq27Y5sQ5YLxj48mPUpe6Qo0lwzlQPtbMWx
         uAMY8L7KWFrEh/HEB49Teuodid10F9hIbRPcQAwEoDLZdCijlxBLVgxVs/MR+WVw1ljp
         p5qkPFokEk/Z6Oc+3ZUk87bP4hZGeIbQTb/YLgx5l1yj3C5EWbOlldWA2Io9RBwu5P3a
         tUDan4h8JzHfweChDkcvX/Zu4lDAuletFpOyJf/Tdtf0L8pznrxmhnfxJtgZH1BeUrHz
         V2t//XOGwua0P4ICi4MXIqKpB6+2gW/qDeV629ZBpaDm+r+gb4yVKktdilm9Mc55Fppy
         41OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=iqm6xEHR24DEGP71Dw334SXtVnwmbVG6/wYj4wQS+wE=;
        b=gkvc8u6AQwEGshpoGoNg4AyLTo9+BuOJdE2c/36raSQAiM1rNYCgG+vzzcpD83bzNX
         B4v2U7dhmVdqz8FJVDFTqHAe78qwr9tDQjstNf9/ma9x/ACjScwT9cuSu+tjLPH6owlD
         9VNQD7GxyrpbclF5Iot8ZMoIb7ZMlLJAKk5g5UaQP4pyfqwNdlKJ/oDU4fP1mGTqXK3q
         3ubuuw6rC7AqAy2jC6FeuyBsSWwVfctSVGfEMImRTyexeDTbUinxYzMh8rhiUYp1RA17
         qQ9Sw1GMxIVwAyMYhReXV5NNOTQ6Ymx22xucuAeHGN0FSpYSmY0bOa0N0Bj+i2K+Z4VG
         OD7w==
X-Gm-Message-State: AOAM530AqhUaZ3iclusWOzfZQnYZ8E+DzLbaheVl+FZ8zUlgxVz9AAUa
        vvfUX9B9xNQ2K2dm0RCk77N+avKUwMc=
X-Google-Smtp-Source: ABdhPJz3yQb8czWyZbqcq6xsJPWZMRtIJM2+Q7wEuJgnrxpO8Z76YMeIHjh5XDO3CzNKcfUeu8Erow==
X-Received: by 2002:ac2:5df6:: with SMTP id z22mr27151245lfq.230.1639387414146;
        Mon, 13 Dec 2021 01:23:34 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id n7sm1390614ljg.113.2021.12.13.01.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 01:23:33 -0800 (PST)
Message-ID: <d4478fbf-1ec8-5659-c77d-f412c351e497@gmail.com>
Date:   Mon, 13 Dec 2021 11:23:32 +0200
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
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
In-Reply-To: <CANhJrGMHr=VLAwe-Tvyg70nN4ArjHa8UHKZODwrufK1r+rRNcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/21 07:57, Matti Vaittinen wrote:
> On Thu, Dec 9, 2021 at 2:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:

>> Also I would love if you could test v2 on hardware!
> 
> I don't have a real device with battery connected - but I thinkI do
> have a break-out board with BD99954 lying around somewhere. I'll see
> if I remember how to wire it to a beagle-bone - and if I do, then I
> can try some very limited testing. Adding automated tests for the
> BD99954 is still on my TODO-list, somewhere at the bottom of it... :(

I have good and not-so-good news. Good news is that I did indeed find a 
BD99954 evaluation board from my collection PCBs I have "temporarily" 
stored in a box under my bed XD

The not-so-good news is that I thought I do remember how to connect the 
board - but it seems I did not. As a result my beaglebone said "Zzzzap!" 
- and lost the magic smoke which kept it operational. I have only one 
spare board left - and I do noeed it for bunch of tasks - so I am afraid 
I can't re-try testing untill I have ordered and received few 
replacement boards... So sorry - no testing to be done in the next few 
days - potentially no testing until year 2022 :(

Best Regards
	--Matti Vaittinen
