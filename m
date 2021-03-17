Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1856D33F750
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 18:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhCQRoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 13:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhCQRoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 13:44:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDEC06174A;
        Wed, 17 Mar 2021 10:44:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 16so4204093ljc.11;
        Wed, 17 Mar 2021 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSBxrt8q9DwvAyZBfywSCWXzmfoomEQKl5omuxCNzII=;
        b=Idr/9rQLPqul7i01/KOaoymxiOPXrsLsOEqDPuJlyYc69QQ0ilUZ/lTwIRF2RruyW7
         cjzQMlgAlGYFMbj+Ph1Miujbudm8NavramFluaxtMEeGhXhRLaHlcyfHKkwv4SYsJJtI
         rF460YQL76wItNdfmvRSQRNdaFQNlOfea0HS3OvY3SWyDSM9R6pfZk1JRGFn3CODDelv
         D4t/Zm3j77R/3T9x9aQyBrH4ojRtrEHYGknz4xxPBmwlRBXIR3q+MdokSnhqmJ7DetOX
         ytHJAav4qxCbQaOQynFcx0BHD/7Jhl+U1XAhKuKt9olpFKCGkFf23Y//hSJGI1LciqB5
         Dpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSBxrt8q9DwvAyZBfywSCWXzmfoomEQKl5omuxCNzII=;
        b=c8lR1o1MZ2j2GOeXbNeIsOJ5kmX3sv7z6WnhppGCJ7sxXdDWhH7Z8AblobbZ7A6ax7
         YfpmT3JHi3remCiVBaWZllKowmPq2hYXMd752E37gkyMPSvWMECGLDo+sx3WprK0URyn
         Z17QS5SYw5Za2tuKJJJPDlwIPpujAbCYYAb4QfB0gk5r/nChS+MSihcQy00dohWzwRfA
         ojba+/KOPlVZ8VTDFkxf2uA2W1S/9PV6aPeAu87cRWeUl7FpMlg5euZTjlPbnjDJiPx1
         Rv5BCwIEoRoEAmYTvmc+Wil4OMj3ncPKj4XhB6Fe8SW8vAZpQvs5cNUQVdOmvRRm0wuR
         hPJg==
X-Gm-Message-State: AOAM530VuKFLkoNJMkmGMdVFWFHQMUbA7Qm/wPBBaZltsNcQGwaV2mXX
        YbkuWpzkK2mLhcweUB8zRiI=
X-Google-Smtp-Source: ABdhPJyFL0v6HaUzAfe1jE2ZqT9UQc02bio2NiVOkXwzCpQ/IQUCZdf2mELXuzdVML9HSEFCkVdvJg==
X-Received: by 2002:a2e:557:: with SMTP id 84mr3075252ljf.480.1616003056785;
        Wed, 17 Mar 2021 10:44:16 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id f25sm3448156lfh.226.2021.03.17.10.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:44:16 -0700 (PDT)
Subject: Re: [PATCH v15 2/2] drm/tegra: dc: Extend debug stats with total
 number of events
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210311172255.25213-1-digetx@gmail.com>
 <20210311172255.25213-3-digetx@gmail.com>
 <20210314221130.GB2733@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c68ea34c-6b9f-61ce-a58a-8def27a1127a@gmail.com>
Date:   Wed, 17 Mar 2021 20:44:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210314221130.GB2733@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.03.2021 01:11, Michał Mirosław пишет:
> On Thu, Mar 11, 2021 at 08:22:55PM +0300, Dmitry Osipenko wrote:
>> It's useful to know the total number of underflow events and currently
>> the debug stats are getting reset each time CRTC is being disabled. Let's
>> account the overall number of events that doesn't get a reset.
> [...]
> 
> Looks good. It seems independent from the other patch.
> 
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 

This patch was created in order to help with debugging of the bandwidth
management, but technically it's independent. Thank you for the review.
