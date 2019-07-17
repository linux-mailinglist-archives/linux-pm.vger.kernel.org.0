Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9E6BF45
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGQPqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 11:46:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33292 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQPqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 11:46:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so24137960ljg.0;
        Wed, 17 Jul 2019 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tco0T6GUzNhrBGd7cFs6bV7dSuixfzg1Q/s9JVtij1Y=;
        b=Uj/Uge9XOmsj8TIDG0mFw0CjPiYNxcycYs/iy1yBZ4ECFDWWnLOW4LI08s6nWPXiOL
         L8NaBJ+7XbFE3B7acyeqinFFfMveOPF0o+O9cux2+yBM4IL76GaZ0IhI+KPpLGAjPWjk
         +mC4FRR82MqYkesg58bAl6iF3P/TziQmtf5e8HR/j6nNclmKU5QQRNhiAsOns8rpl85m
         /HJNCt1tskBg+VP3M8h2+1wNPPlqE69SAvNuSbtqnH6Ls6dI2GS43A+hWg63JLnN59Hp
         FnkG661LEPaskusBaSsugA95bGyl9CUO7gfOcXL1hz2AVDWKamdvPUW3YE+Uc24+EKvT
         g/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tco0T6GUzNhrBGd7cFs6bV7dSuixfzg1Q/s9JVtij1Y=;
        b=pUIbQNPfcSiJitwQIu0vOTivUbClp7uge30VGQW327FPSDDMv61iQpaohrzf/z5xRF
         nT2An5r1u642XeGvER7kyt9fE3BYAXwrnuZKHKfja16fcspR8uoCU111ZuIgwoBQ/RjK
         w3gburoXvFDlrNFY7sMTFUkSNRYxd5PfOfnAkvtMDIxcK6HaAXCrGbuQ0Kh2yG/mfla5
         nQokx3yWF6ALVFYgVp2n9R+6CS+7W9VzLWqgg88u2B+GbHxGlpklnFARHpj+qOfKYr+P
         UpW3okNJYgb4DrkdAFrVvBawd6D+i8nBKYzTrM45fzGNHPiCqOZxWYxSOglHForVdfdt
         3bOw==
X-Gm-Message-State: APjAAAX7kTC8PigsZfpitaEVX5lPFEQrybP/q6eX2m17EUurg5GFRhVZ
        lDC44tWCDDSmRHDQYoSBV1DsajMJ
X-Google-Smtp-Source: APXvYqycQIAZnYbH1HBOTmgtaXaNa57jNzWKUkiRi01uSB4SfwSPysCdsLzy7rBwFoTPiaBr3udSgQ==
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr1651174ljm.180.1563378410353;
        Wed, 17 Jul 2019 08:46:50 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id g5sm4580442ljj.69.2019.07.17.08.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 08:46:49 -0700 (PDT)
Subject: Re: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223640epcas4p15337f40466342832b731ad6a53be946e@epcas4p1.samsung.com>
 <20190707223303.6755-12-digetx@gmail.com>
 <c883bdbe-427f-35a1-9e63-5e4953a84286@samsung.com>
 <53cd0ba5-f814-cd9b-19c5-1d42717ca58c@gmail.com>
 <922c9178-71de-46ad-eafd-805af461bedb@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f819c226-4328-c85d-5da3-932391fa6747@gmail.com>
Date:   Wed, 17 Jul 2019 18:46:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <922c9178-71de-46ad-eafd-805af461bedb@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.07.2019 9:45, Chanwoo Choi пишет:
> On 19. 7. 16. 오후 10:26, Dmitry Osipenko wrote:
>> 16.07.2019 15:23, Chanwoo Choi пишет:
>>> Hi Dmitry,
>>>
>>> Usually, the kernel log print for all users
>>> such as changing the frequency, fail or success.
>>>
>>> But, if the log just show the register dump,
>>> it is not useful for all users. It is just used
>>> for only specific developer.
>>>
>>> I recommend that you better to add more exception handling
>>> code on many points instead of just showing the register dump.
>>
>> The debug messages are not users, but for developers. Yes, I primarily
>> made the debugging to be useful for myself and will be happy to change
>> the way debugging is done if there will be any other active developer
>> for this driver. The registers dump is more than enough in order to
>> understand what's going on, I don't see any real need to change anything
>> here for now.
> 
> Basically, we have to develop code and add the log for anyone.
> As you commented, even if there are no other developer, we never
> guarantee this assumption forever. And also, if added debug message
> for only you, you can add them when testing it temporarily.
> 
> If you want to add the just register dump log for you,
> I can't agree. Once again, I hope that anyone understand
> the meaning of debug message as much possible as.
> 

The registers dump should be good for everyone because it's a
self-explanatory information for anyone who is familiar with the
hardware. I don't think there is a need for anything else than what is
proposed in this patch, at least for now. I also simply don't see any
other better way to debug the state of this particular hardware, again
this logging is for the driver developers and not for users.

Initially, I was temporarily adding the debug messages. Now they are
pretty much mandatory for verifying that driver is working properly. And
of course the debugging messages got into the shape of this patch after
several iterations of refinements. So again, I suppose that this should
be good enough for everyone who is familiar with the hardware. And of
course I'm open to the constructive suggestions, the debugging aid is
not an ABI and could be changed/improved at any time.

You're suggesting to break down the debugging into several smaller
pieces, but I'm finding that as not a constructive suggestion because
the information about the full hardware state is actually necessary for
the productive debugging.
