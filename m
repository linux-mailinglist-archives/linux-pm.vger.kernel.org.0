Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB9B1D29AD
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgENIIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgENIIN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 04:08:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB419C061A0F
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 01:08:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d207so10752245wmd.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dBTttPdObnoAHm8o3XOpB6wiom9rFH5IVHvtwcE0HI=;
        b=p6ePzTd27zTHt8YXadOh+yoHGm+Jq5Ilo3RFJ0ldQcG6r0KUmypuXk5qeszLRta7cQ
         y8Mk/1VZCW+nO+tGbNExaZIOLHdDrvGHs5SuUwYqtIFvLaJzyIWWxVfLJUEu0iduxz0v
         mDl2sk29sX7F8ZHh/tR9P7FwKia5yfSQyzT2g5ExKjASfyYsNho75mLvE60R39UKSgSO
         Lu6eTJNxpQOQ+9+BaCWnmo6uKWNLDmBWIGP7hWAxe/jlo+ZiIH03E/m99g1EM/2Nh0bB
         Mt61DMfCMIYUXvLKb/muchhMzPavtv8rY52o0c5ykqUWGZUvJn7fwDsSB6oLa29h2yDX
         dbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dBTttPdObnoAHm8o3XOpB6wiom9rFH5IVHvtwcE0HI=;
        b=WCFSsXfbPgQZHS7BKC4wFU7hCxd2pidL7MEySGxuKPqJjoLL4prIv26K3vn4JNVivP
         TklBnOQ4D0yAZzecwBsrhYbbpMq2PpYZGDCdA3muVBCrlztF3pO4Yrxsatt22ENm/cyI
         pq/634NaoYFG5luUeJ3LEBvcilk5qfowEJ7XmbCZ6VlXmt4Z/ccfJ4BzWC9BA0GKkjwd
         PY5hLKD53Gg/bbICMAVLKR29h6yjjCDUDjXGt3xLApVcfUCV5feXLU1VqkE+2R+tz8xr
         W/wuw21qHBgi4bHPTcstt+mP5xN9yCdpTqfnaJldBFc4omR6Hqo9Pd2YcUF1Wa8wXpIt
         +ugw==
X-Gm-Message-State: AOAM5328mr84pFoyGQ2LgTEWCIZKdfb2++zU5JFNVrDKiQQo7cx8H5IK
        a3LtnfPELCqNuJxG1IBZWDelwh8HOsE=
X-Google-Smtp-Source: ABdhPJxp4IlgGcuqBONSjUjvyjF5xuOobYyR62/UafK9OpqwbPrMPajEW49YlhsRquv+6SOQWVf3iA==
X-Received: by 2002:a1c:4806:: with SMTP id v6mr1080870wma.20.1589443691089;
        Thu, 14 May 2020 01:08:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ddb0:8d90:9d95:ff51? ([2a01:e34:ed2f:f020:ddb0:8d90:9d95:ff51])
        by smtp.googlemail.com with ESMTPSA id g187sm10106409wmf.30.2020.05.14.01.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 01:08:10 -0700 (PDT)
Subject: Re: [v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL
To:     Michael Kao <michael.kao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200323121537.22697-1-michael.kao@mediatek.com>
 <20200323121537.22697-8-michael.kao@mediatek.com>
 <1589439322.11120.2.camel@mtksdccf07>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <09278638-aa39-c130-95ff-7e9de34cc4eb@linaro.org>
Date:   Thu, 14 May 2020 10:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589439322.11120.2.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/05/2020 08:55, Michael Kao wrote:
> On Mon, 2020-03-23 at 20:15 +0800, Michael Kao wrote:
>> From: "michael.kao" <michael.kao@mediatek.com>
>>
>> The driver of thermal and svs will use the
>> same register for the project which should select
>> bank before reading sensor value.
>>
>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>> ---
>>  drivers/thermal/mtk_thermal.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>

[ ... ]

> Hi Matthias,

Those patches fall under the thermal framework umbrella.

Thanks
  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
