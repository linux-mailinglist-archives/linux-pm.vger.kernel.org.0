Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9642E2B64
	for <lists+linux-pm@lfdr.de>; Fri, 25 Dec 2020 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgLYLzB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Dec 2020 06:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgLYLzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Dec 2020 06:55:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B451CC061575
        for <linux-pm@vger.kernel.org>; Fri, 25 Dec 2020 03:54:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e25so3590142wme.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Dec 2020 03:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nAyf7TfRvNwQbuiqlvSSln+08RwcFkvsGY9pz4gOhaY=;
        b=dVCcQbr31smEHQ4OsphP9fQNH3+3/3SYWEOiiwEad9cvOIS2J6IEmaXYfIhnG0Ayyb
         0OnLV2z2FFh3HOlv9JIdkoxvK640Ut9nyMnP01T7QsIqsRr7shn0IhjiibTvbdc9fTwA
         DiUNO/+Q4qMAqPXa2HnBMEAYJM3+Y9p7tZHHpFyEud2inWTln7uCNNTnwBLs/TUICWQv
         I/yntL4XuZG3A9D9ppc44Dk1S1EGs8MhauSrNMXG115lRhtk9p7iOdkuPdyVAz84+rlV
         yhpLGNkj4B5W/iQKAKrLAeCS1h6Ww4MryBZydUuWa4qq8yiBFpLsNOXAJFNFaQA7EvHX
         1tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAyf7TfRvNwQbuiqlvSSln+08RwcFkvsGY9pz4gOhaY=;
        b=L8w0ayj9qGN7pW85R5vdBeftstysFsWb0qEbYN4KW7blJka+i+n0CpnGcKl8mmCWmE
         lVSSL/BbQbNulnXWzcGknGNQgwiI0RhTeeBBjP4swh7H1FIQHdmV42btp/7fsqqKCf3P
         faX4JXKK2QrRXz1tSAA/L0/8Y2eLkPZygCeqiTyEEXZv40VmBZUrY8zdpxBBaev3GcuI
         l8Wmb7RVNEKctvtrU0V4OtGPw0147eh/zwtHbKqwGpkxp2NKTL8+vpBWNy8CtkaeNmqO
         2gTPzyjHls5LI5yNZZyLRbf7orlDv8yYs25Op3M+lQGdSKVFfyquSLAUwNGM7TvsNB8q
         8hMw==
X-Gm-Message-State: AOAM533Q9B/yQMMMPGR/jv8swfvMieLk+bI+WQVNRJvRUfQpvEYUfRIU
        hOzjEDiaTHvKQ/UTq7TOcG2T7Ly/cYVwzw==
X-Google-Smtp-Source: ABdhPJwKTd/dIDmvPDUJE37bewbZ82ItifHzbWPOPAyN4fwyZxu4cBZULv/BGOzzyeWjQmOiCvq8HA==
X-Received: by 2002:a1c:b78a:: with SMTP id h132mr8204282wmf.141.1608897258251;
        Fri, 25 Dec 2020 03:54:18 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.googlemail.com with ESMTPSA id h16sm42979627wrq.29.2020.12.25.03.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 03:54:17 -0800 (PST)
Subject: Re: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
To:     Pavel Machek <pavel@ucw.cz>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
 <20201224184610.GA22388@amd>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8b732330-33ea-97fa-a0ce-c5cf9d9ef0c8@linaro.org>
Date:   Fri, 25 Dec 2020 12:54:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201224184610.GA22388@amd>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/12/2020 19:46, Pavel Machek wrote:
> Hi!
> 
>> The density of components greatly increased the last decade bringing a
>> numerous number of heating sources which are monitored by more than 20
>> sensors on recent SoC. The skin temperature, which is the case
>> temperature of the device, must stay below approximately 45°C in order
>> to comply with the legal requirements.
> 
> What kind of device is that?

Any complex embedded devices like a phone, a laptop or a tablet with
components like NPU, CPU, GPU, GPS, DSPs, Camera, ...

> Does that mean that running fsck is now "illegal" because temperature
> will not be managed during that time?

The heating effect of the different devices will be conducted through a
common dissipation device.

The 'skin' temperature or 'case' temperature has a dedicated sensor in
the path of this dissipation device. So the temperature will increase
slower at this sensor level because of a higher thermal capacity.

The 'skin' temperature will be the result of the different components
running at the same time (eg. GPS + CPU + GPU + DSPs).

In the case of fsck, the system is in degraded mode, thus the
application using these components are not supposed to run and the
'skin' temperature should stay below.

If you are interested, here you can find some background to explain the
'skin' temperature [1] and the spreading of the heat [2].

Hope that helps

  -- Daniel

[1] https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4188373/

[2]
https://nanoheat.stanford.edu/sites/default/files/publications/Electronics%20Cooling%20Article.pdf


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
