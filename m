Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32634BC1C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhC1LLm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1LLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 07:11:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798E8C061762
        for <linux-pm@vger.kernel.org>; Sun, 28 Mar 2021 04:11:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo5207513wmq.4
        for <linux-pm@vger.kernel.org>; Sun, 28 Mar 2021 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=03U8ZMcgkCMSWbeLEL3An/d37+jEYP73/KLFh0oPZkk=;
        b=dSHU3AkY20kHSycyny0dJXlEcmUIE/a4hb26zil3sNljjaXhXGl/feAyLZsHwBbiO/
         /1D35gNUay9qNctUYaxMb1+klydlmlDAlmcx6zCXThSi4ydunwKtB7o+ZmSqutDPiO/x
         yihvI2T6Bsgb/ztwJcWEI4Kk34YuqstE/QExX5VMswWyTmTXpH+rSJ4zDQQYKVPPYfHd
         eE+RaSY61hxEXDFHVcFVJ687anq23Vatqezzkz1RqyJ791ddIauHQOOxmrzMGOyBPAik
         vMdvYca5FINBW97aKto8OS9z2pkmCtc9gR9ob2sceZ5KRJPXhc/SFj5e7q0UQr9lwkFa
         2hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=03U8ZMcgkCMSWbeLEL3An/d37+jEYP73/KLFh0oPZkk=;
        b=Y2kdP1c0vlgSSUBRShcEK/H/0lhV7ox7UeontXWvupBvdSSFXr+r9k+Mk4/fPs+L+t
         Ah8AfpiUJZAH7vvTunFimJL3d7ylzZ6lqDQ/ztS0hlq4aHQ5bwU6cpAX2gZen2iZ97g+
         XoIcKQcuQKD71817EqMxNRV4f5DuRIm0jAdk7dHUZY/OGNbZZ/0Xc75o+GV/yhl99gkM
         2cwXIghfepTLPpvdsqkZtTrk9iyGV4uGDlo8ZDNnNDwOVmlF4dhHk4fJu1jTuaOYNEbV
         zV9Y0eIbCZbz+btCZiGIrZl8m0Cdw3ha/q5SFNnwGqRimu5uqMnT6GN2pvdCJbxgafTp
         YExg==
X-Gm-Message-State: AOAM532ln1u7mE2LTuZ/KSBmkC/T/8mrpCuCIeZHV+krvrWppEG5s8/t
        FKDSaFlrCW3keYdAGW/fb/ip/Rq9Wy8zog==
X-Google-Smtp-Source: ABdhPJw5Ey5kw3tDAPC4O1P6YYfhEgqqOwo1zCJo692Orwzm8Id8fgGseOsIDV3Bsl/mwSzQRZ5tMw==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr20937198wmf.148.1616929891924;
        Sun, 28 Mar 2021 04:11:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562? ([2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562])
        by smtp.googlemail.com with ESMTPSA id 135sm20185846wma.44.2021.03.28.04.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 04:11:31 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
 <YGAnRx8SiZHFPpY6@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
Date:   Sun, 28 Mar 2021 13:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGAnRx8SiZHFPpY6@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Greg,

On 28/03/2021 08:50, Greg KH wrote:

[ ... ]

>>> And any reason why you are not using "real" struct devices in this
>>> subsystem?  You seem to be rolling your own infrastructure for no good
>>> reason.  I imagine you want sysfs support next, right?
>>
>> Actually, the framework is on top of powercap, so it has de facto the
>> sysfs support. On the other side, the dtpm backends are tied with the
>> device they manage.
> 
> So why are they not a "real" device in the driver model?  It looks like
> you almost are wanting all of that functionality and are having to
> implement it "by hand" instead.

I'm sorry I misunderstanding your point. dtpm is the backend for the
powercap subsystem which is the generic subsystem to do power limitation.

We have:

struct dtpm_cpu {
	struct dtpm dtmp;
	...
}

struct dtpm {
	struct powercap powecap;
};

struct powercap {
	struct device dev;
};



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
