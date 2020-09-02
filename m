Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDFD25AB86
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBM4i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIBM4b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 08:56:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE13C061244;
        Wed,  2 Sep 2020 05:56:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so2768213lfn.2;
        Wed, 02 Sep 2020 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZT5x+31ffQ1fSGTC6fc7HGVTmxRKwze1JkUzuev76fo=;
        b=MVYKoUM3Qi3G4CUp4xP5XqgQvWvDo6PsrlPp55IW6273Lw81QISusbtPEsERRcR/3B
         6Q9V3XlFUJX+GYIBnGeYqwwR874ISHS4jNWHMhiw3Xd9Cbj+/LCRCeKnA3PoLxkiV7/7
         5Mv8uiLha6QtMHB1bcvZCBV/dmLOudMDK5KPo4gr3+uw85cQhRqjrrrRXXs3v5vfarZi
         M3XO57ETyI3ba5lFOH2B1nqQ8sa5cAotWHZ3E4SjTQugzfR2BZbwQJXdi7G32HSxhpWZ
         mxSgzvdo1Bwy2Jq/MPnxHYcDW70oYBulKZ2KTwNLhjhGYttHxAJ7+h9Y2O0+j8aOxN0r
         EipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZT5x+31ffQ1fSGTC6fc7HGVTmxRKwze1JkUzuev76fo=;
        b=R+s2Ri2as/Tiz9gkSkzG/ygagfWJLu549zSORD09nwtEFbcdoEGuJoYWnE6AyKvT2O
         FBXhkZk/KIH9aBtM96ykXypZxra548xW9IthsxlzomOfQlYnjPdqsf2ftRMXqRY4vbp9
         BIizcQa0Q5neNAgVRv8qtAY7PkZBbgtt99Kq0JMJPdn8cbPprgh0jiMVMC9W5Q+c1OZR
         cURczM74HWOsAHX5HTOTwOJqc2QbdAPS9gaHs9WjLsytPwUKdzsRQZVaRH14P4onEwfO
         o/5KCONHK/YR3ISUBNVZRJzgMMb8B34qRUqTrmrAmAQtjmnEWQ9ryPe8jhsmnI0hH+lc
         xpSQ==
X-Gm-Message-State: AOAM533DGlnTdOBo1B1QkBYwRsBPgSsTLoCNBlNQ3tWkmCfbZsVRXqah
        vE7Aov1p15i1F+JEBYgN7VE=
X-Google-Smtp-Source: ABdhPJxTy7FYR0Pg0Sm71v/FU6NwzEy2QsoacvE/ywzrQ6k+5uGvuu7pKbD5nySOHsJOa5oGFo3R7A==
X-Received: by 2002:ac2:44b7:: with SMTP id c23mr3315115lfm.128.1599051388556;
        Wed, 02 Sep 2020 05:56:28 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id b13sm1064037lfa.92.2020.09.02.05.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 05:56:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] regmap: Use flexible sleep
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20200830185356.5365-1-digetx@gmail.com>
 <20200830185356.5365-3-digetx@gmail.com>
 <CGME20200902124731eucas1p13716070977dbef39d09147bb71e050f6@eucas1p1.samsung.com>
 <d936a2fc-8890-eec1-015c-d919e10d1dc5@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b580524a-d476-adbe-59b9-4ae7d62626b1@gmail.com>
Date:   Wed, 2 Sep 2020 15:56:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d936a2fc-8890-eec1-015c-d919e10d1dc5@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.09.2020 15:47, Marek Szyprowski пишет:
> Hi Dmitry,
> 
> On 30.08.2020 20:53, Dmitry Osipenko wrote:
>> The multi-reg write function uses udelay(), which is a busy-loop based
>> delaying function that is not suitable for a long delays. Hence let's
>> replace the udelay() with fsleep(), which is flexible sleep function that
>> selects best delay function based on the delay-time.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> This patch landed in today's linux-next (20200902) as commit 
> 2b32d2f7ce0a. Sadly it breaks booting of ARM 64bit Amlogic S922X based 
> Odroid N2 board. Here is the log:

Hello, Marek! Thank you for the feedback! I missed that remap supports
different types of locking, I'll make a another patch to fix this problem.
