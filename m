Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75F333A9C0
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 04:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCODIc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhCODH7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 23:07:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68BC06175F
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:07:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o10so2380470plg.11
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E+C021S+MuuSehTRLZXDd2gMGgIwxJN7I46PHjbYIPA=;
        b=qt+FGTFJTPJ2JZunn0BlihnzQxcyX9KbvW6foXCHaqjGRikyCE4uq8/JjJ7NJqkNH/
         5BaxBNNwRRDglJz9aEfY7cyz8ogJU8SzsaHg4i2YruvJ1t6BAkTGvvT6Zi0EKm5NxedC
         Xjm8l82WC1grrZDwaf00ov+Ngll7W8OR4u2lCrWiFvdmQv1mUgVvqccUAeiROBdjol/Y
         u8nPi8URiiCdsV4AhYBDczpAvJR3D8b9Q/qgM3GB+TpgsD1ISHyZome0Uzj+YlD/lG/3
         MtLeGytU3uUKr6q9Ai14P7RjwOWfdVQ5fhgXw845Da3PioZfH4hsw157vqSdISU7fBtJ
         CC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E+C021S+MuuSehTRLZXDd2gMGgIwxJN7I46PHjbYIPA=;
        b=shCjWQeG/2lgeTbnNDPzI6/fwVAQXGxWDDeacWKlxjxvJSxVbeuXhNIwQtQOCrbA0v
         rahmvSXth7ENI0IJ2FqvE6U4FYkKCme4iPFCq68MqKSZ0qI/wmrDX9zu9UBNXGaQjTkm
         E3fn/HgLzztUbFjPdLQlJUvYCWZd0DQzPX+HZ6FQ3Zqkxv63skKz4BCZrA4+ZnT0S2gK
         EPwOIqEetzZInPBAzrQbzh8XZVv8GW4FZDdVKa3uwbPWsc1olDpTZ8rgp0cnHN3tg/oL
         kaLrsaYL2WMaaBuo5rLF6l///IWAG3CWF2IqtRdqXVDqLzyvFaNvAZcIltlHUJTXiJKH
         FtCA==
X-Gm-Message-State: AOAM533MLM6rVnMWAFkKcbBlI8JFRMc9ABuhIdDPBErnTz3UEuiOl/go
        68dUo/N5mjda56nMC8b5ACakoQ==
X-Google-Smtp-Source: ABdhPJxL8lzjTY6PKezQCujtpxCj27hHlpUJ7MN8QLCdwRQ0Yyk8U87S9VWEB2aHazmsfSHDzfJosg==
X-Received: by 2002:a17:902:ba94:b029:e6:5cd1:a4a2 with SMTP id k20-20020a170902ba94b02900e65cd1a4a2mr9363284pls.69.1615777678267;
        Sun, 14 Mar 2021 20:07:58 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id k3sm11076919pgq.21.2021.03.14.20.07.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 20:07:57 -0700 (PDT)
Date:   Mon, 15 Mar 2021 08:37:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v2 4/5] thermal/drivers/cpuidle_cooling: Use device name
 instead of auto-numbering
Message-ID: <20210315030755.kl7gt66f45o254u3@vireshk-i7>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
 <20210312170316.3138-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312170316.3138-4-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-03-21, 18:03, Daniel Lezcano wrote:
> Currently the naming of a cooling device is just a cooling technique
> followed by a number. When there are multiple cooling devices using
> the same technique, it is impossible to clearly identify the related
> device as this one is just a number.
> 
> For instance:
> 
>  thermal-idle-0
>  thermal-idle-1
>  thermal-idle-2
>  thermal-idle-3
>  etc ...
> 
> The 'thermal' prefix is redundant with the subsystem namespace. This
> patch removes the 'thermal prefix and changes the number by the device
> name. So the naming above becomes:
> 
>  idle-cpu0
>  idle-cpu1
>  idle-cpu2
>  idle-cpu3
>  etc ...
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

I acked for both the patches :(

-- 
viresh
