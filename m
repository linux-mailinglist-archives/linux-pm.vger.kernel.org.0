Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B02380A41
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhENNRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhENNRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 09:17:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9802C061574;
        Fri, 14 May 2021 06:16:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a2so22025698lfc.9;
        Fri, 14 May 2021 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4TXN1aP2OtPYFWNRZZgEicguo9V9B76iGcfEYyYScQk=;
        b=vScf2eNYTfRrw0u2cylCVtUG8GoW+pklgsevEe1IVg4Ac5Wtf9/2wbbgWphSfzznBo
         oiFDiH4VW6cbnt4CmVk+ygZAskCfGrvwVTa9YQpMYDif61fo1fecNDei5GP7H4mTBT3r
         gNbYA2DAiZ/JMfwz19jSxDEexKZY4VMXXv67jRBwTcgZTuQRRJ/HvBNUsP507QRqWI/0
         cGy/HdiMerUqCEY7rV9dbVZxXv7Be0GLPGk0wDl3CpUGqCQLOuRXZS1sqsFwFxrJ9g4b
         YFxwJfv0Lf85ylHkWCYA/FaXvvdB/wvEoJ1EZ7dYSSMDjeb7Q61CJZCYVHeWoPZo+zZo
         Us2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4TXN1aP2OtPYFWNRZZgEicguo9V9B76iGcfEYyYScQk=;
        b=JIL/602nuN1vZrJG9pwU2IU8jHtQ1saGii1OU9xYVpWYfJe/4nE3buGTdhRbewpaX9
         sm57nMMxK4KG8L97FNiaA93Sep/x/yLJX8nixOFcaGWiZsjSYxEoVrOktTUFKfxbI8ri
         ze1RUhc8/XOD0tTg7v3g6LQ6Qb+d9GLk2+ADUnWOq5w2bZyT8dTMWk98V9eYnPsiSC0Y
         8i6aabkHu48Sb37++k1jwUmGVJTqLnlMgo7AjqflykL9xbQcj3l4zuKbF0GzNg2JnyrC
         YIRAlamj7fovbuufX/4pxehihud7F0Bh8777NCbDD2fWBjtVN4ITYzgTaumb3iYYo25Y
         386A==
X-Gm-Message-State: AOAM530iAhMYXUrh+r+djiRncZjCGyNU7hBF5av1BizK2J1J/tz9H2mq
        W9IDhALpVI39PcMC96XJxPcnASgx7iY=
X-Google-Smtp-Source: ABdhPJx6/NsKPPbhS5G3Qsi20vEoqvEUN3Qei6rmWYoxj6g9tTS4jF8tNCzPblvUeRhMFN1kHXZqKw==
X-Received: by 2002:a19:6d1b:: with SMTP id i27mr380374lfc.596.1620998192232;
        Fri, 14 May 2021 06:16:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.googlemail.com with ESMTPSA id f4sm1100897ljn.38.2021.05.14.06.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 06:16:31 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] power: supply: sbs-battery: Fall back to Li-ion
 battery type for bq20z75
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210510220827.11595-1-digetx@gmail.com>
 <20210510220827.11595-2-digetx@gmail.com>
 <20210513153136.76rr3ngjhuqy7b7q@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aebfc4c1-1b4e-c34f-62d9-e8c53e825834@gmail.com>
Date:   Fri, 14 May 2021 16:16:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513153136.76rr3ngjhuqy7b7q@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.05.2021 18:31, Sebastian Reichel пишет:
> Hi,
> 
> On Tue, May 11, 2021 at 01:08:27AM +0300, Dmitry Osipenko wrote:
>> The older bq20z75 controller doesn't support reporting the battery type
>> and the type is Li-ion in this case.
>>
>> Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # TF101
>> Tested-by: Nikola Milosavljević <mnidza@outlook.com> # TF101
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> If it does not support reporting the battery type you should get an
> error from sbs_get_battery_string_property. Obviously a string has
> been returned, or you would not end up that far in the code. What
> string do you see?

There is no visible error. Where the error condition should be set?

The returned string is:

sbs-battery 5-000b: Unknown chemistry: OAI0

> Considering BQ20Z65 and BQ20Z75 also support Li-Po I don't think
> it's a good idea to fall back to Li-Ion. Kernel should never lie
> about this, since I know some people use userspace based charging
> setup and the charge limits are different for Li-Ion and Li-Po. When
> reaching this place we do not know 100%, that it is a Li-ion, so
> returning UNKNOWN is the safe option.
> 
> If you know, that your device (TF101) only supports Li-Ion
> batteries, we can add a device specific override. But is this worth
> the added maintenance burden? What is your plan for using this
> information?

There is no plan of using that information. Previously battery type was
reported properly by userspace, then it regressed. There are other older
device-trees in upstream which should have seen the same regression,
apparently nobody noticed or cared about it. Yours variant of solution
will take more effort, in this case it should be better to leave the
regression as-is for now.
