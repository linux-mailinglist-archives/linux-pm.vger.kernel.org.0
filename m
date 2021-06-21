Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F453AE226
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 06:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhFUEWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 00:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFUEWO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 00:22:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C15C061574;
        Sun, 20 Jun 2021 21:19:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i1so841163lfe.6;
        Sun, 20 Jun 2021 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wQR1d2nXINli2r0qWQEuIxhuaXFegPwICSdu1LOWBLE=;
        b=uNpS/WQe1u+O6GqY5APACmNIY2oeqiUgN0TFZtOxj3s48jAs5D+LVEFsvt4M9LKA5z
         n47Hjd1t7EA4wVIbqBFEKILxxxASWnEw/9ld9AWhBk27xD0bp+/eErNY12LNukTPiUow
         IP4BBVo/Q4JFxtX4GCFIqsZATynHgYOVnMrFNbN+ml6j9fmZ7YXOVvuhrSjyBmf3wlWN
         S+lP3Tl7ny0OyhEOAi9TtDy8Y9RoV5jB42+Zp/Ij4JdXcEiH3u+Ap4fn2TPSl4+X/ogz
         n49TptyMuLkSW6rBCNf/Q5oSnIDQoS0Nqg+Iuos3Xnk5yvMAKB+rHOHp7B5m46g+/z/w
         2oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQR1d2nXINli2r0qWQEuIxhuaXFegPwICSdu1LOWBLE=;
        b=itCuBISo8bsuOLsSlQW09vwGpxBKSTnzahW+/5JaR/8923N+VoKkjPms+BVCXyBO1K
         MEbd4JI2klfGxMvo82XFeHP4EVbKlP3K5BSnnv9RBezHv/Sk6s8OjHzqyoKry8Diq0Zu
         k3u+C/d+8Wug06cwcpRj/NlAWTdao8u5rWh7rtTH3j9UqCc/VxzxON3mbJOmG84cBkRq
         dPYpatzj95UqGLYvmrJYV4OXXv7xLiN6R5Lt8BXsof1ttTktuymOlkwyl8JATNzqg4zL
         3x28x2YJi8hFjgJmx3QcRsO4xP2ALEoXo7OcEJIC7joNHWSKQ/Bpq3SnIyVWCL2p+UN0
         B8iA==
X-Gm-Message-State: AOAM531TkM6Ep4hZ7QFMJgKctN3EiaX1UjcVB6qCMWQI91G0ZHwQuNf4
        NqvjGUzLkA/bwHo+b96faDQ=
X-Google-Smtp-Source: ABdhPJyc6b/ECLFi440OkwjYkmEOdtosozafVaK6tDf8W90rbWwATVxHsEuxNbPY8Gh39qOuSQaFJg==
X-Received: by 2002:a19:c4b:: with SMTP id 72mr12696790lfm.15.1624249156706;
        Sun, 20 Jun 2021 21:19:16 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id 140sm2014922ljj.124.2021.06.20.21.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 21:19:16 -0700 (PDT)
Subject: Re: [PATCH v18 0/2] Add memory bandwidth management to NVIDIA Tegra
 DRM driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Merhar <mattmerhar@protonmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20210601042108.1942-1-digetx@gmail.com>
 <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
Message-ID: <50912a57-aa43-58b0-02d2-6928578d6286@gmail.com>
Date:   Mon, 21 Jun 2021 07:19:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.06.2021 01:40, Dmitry Osipenko пишет:
> 01.06.2021 07:21, Dmitry Osipenko пишет:
>> This series adds memory bandwidth management to the NVIDIA Tegra DRM driver,
>> which is done using interconnect framework. It fixes display corruption that
>> happens due to insufficient memory bandwidth.
>>
>> Changelog:
>>
>> v18: - Moved total peak bandwidth from CRTC state to plane state and removed
>>        dummy plane bandwidth state initialization from T186+ plane hub. This
>>        was suggested by Thierry Reding to v17.
>>
>>      - I haven't done anything about the cursor's plane bandwidth which
>>        doesn't contribute to overlapping bandwidths for a small sized
>>        window because it works okay as-is.
> 
> Thierry, will you take these patches for 5.14?
> 

The display controller does _NOT_WORK_ properly without bandwidth
management. Can we get this patch into 5.14? What is the problem?
