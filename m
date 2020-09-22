Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ECE27456D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVPhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 11:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIVPhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 11:37:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B3C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 08:37:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so17624009wrn.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CzM3hFSlc57LMy+lcYYDd7pZclBDYKae5+bKuzU8WwI=;
        b=dIh0nroF3/wRP2TWUI6qr37XfuYtLLMxJTV8/ey1zo22LmN95NpDG3t8muTbymw0o4
         5TAg5GV+FhzG1mWw+vuU9SAgJZZGIK28M7l6NJCxCKfOLyiPr7kI8L++S9otLy5D+Zcl
         16A3yYIFXPQDCgyQlSQPHv6DwvJXYZY01ErvmAPHwUPRfmXJBbC0S2DDTS+YylhtJEBH
         eL+NhKheN99NSrXKHHX6QciHttKskLk71jC/Q5VfO2ALDe3zV5AWecFYpt/jJN6ol1n1
         YNzB96bh1vEaQpkUfasPb4MCCPtP0lMjbZhE0iDOFzbOyzHM/WEXBd0WVNkJ0CrJMovH
         w6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CzM3hFSlc57LMy+lcYYDd7pZclBDYKae5+bKuzU8WwI=;
        b=K0j3uvSotqUraVWblnByY4z6kbKZr8fK/53NreQpTSekYrjqMn8tN/wyPnmgqaQ7ZT
         yFaKP7okwGukdpsgiQ7G+dzD/j9HF7HRYSsF1HXHBze15cAmKvFFgo4+qr+c3M28vWaW
         ZmRcQ5c5ALcsKaZ4e0PRqwFMhhTW14/45BTyeXFWFL+LtdMgLWKxm5Knn8DQD/lTCW9L
         Z5h/SsMbBYTQgoJeX7DDUtbeeLqbllY0HYV20S0yC9ca+t+7xBa4M8HDjgs6LrBKHfVo
         Dpo9bEnnlLOAnKJMZJLULbUZscz9ALBSSuk3C7DrZCjQxnNiJPjUF4dUah1GDIr+9Wsp
         1ohw==
X-Gm-Message-State: AOAM5337FgPA9d2JCqRvRoHCa5PVftCcAcSKXWsBL2wA8fs2osZgHbK7
        a7a+SjQidJHDmEozxwV+mWzumaOqJW9ixQ==
X-Google-Smtp-Source: ABdhPJxOFIFOpCipAn7oozquEWbZ4cj81W8Al9SKzvnUmPXQIryHsDCpaWD45WZg/FyuDx7DMQuL/g==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr6254184wrp.338.1600789035640;
        Tue, 22 Sep 2020 08:37:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f? ([2a01:e34:ed2f:f020:2047:2ab9:c10c:f4f])
        by smtp.googlemail.com with ESMTPSA id 70sm5628198wme.15.2020.09.22.08.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:37:14 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] Allwinner A100 Initial support
To:     Frank Lee <frank@allwinnertech.com>, robh+dt@kernel.org,
        mripard@kernel.org, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, gregory.clement@bootlin.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, lee.jones@linaro.org,
        p.zabel@pengutronix.de, icenowy@aosc.io, megous@megous.com,
        clabbe@baylibre.com, bage@linutronix.de, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1595572867.git.frank@allwinnertech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3c8f14f8-893b-cc81-be72-741df772d730@linaro.org>
Date:   Tue, 22 Sep 2020 17:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/07/2020 08:52, Frank Lee wrote:
> This patch set adds initial support for allwinner a100 soc,
> which is a 64-bit tablet chip.

Applied patches 7,8,9

Thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
