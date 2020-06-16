Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC81FBCC2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgFPRYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgFPRYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 13:24:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446CCC06174E
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 10:24:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so19923566qkn.8
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wLz7l5oBTTWRrPJZo/ObezKhptZZKpKERaSHZ1hXdEw=;
        b=oyEHBZBt8MKmPuGWBNEF4brHRUaiRePPVL0QfAls08WgpIjuFIYa6kB864rT/Vbf25
         48gUSVw6ATmzjhX/wyCSwzwHozlA+TPfnPj3bX8nuKKD84+OKWm4OT3vkyVwwBCfT9yD
         vFBrcemSctjrRxOQi1neixJQ+KgBmUa8HopxjjLxRYCMxK1ESVcFwS1yvIHfDWQPsIig
         GQpwfaY4ccw8T202rJcnVgi244sbCojoHfqbouXxl2peytOjyoaR2dVMbOtZHkNDSNAB
         QrXlr8NXaPf7w0CNnMASPVEyAIEZBbQGmFzXqpdg8HadXxQuBWloIvDAi6HPapw/bGcy
         w5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wLz7l5oBTTWRrPJZo/ObezKhptZZKpKERaSHZ1hXdEw=;
        b=OemwFzeJjJOnwOAge9dOUVuHZ5382EGvbH6vJ5BpIWRDIw3jXCfXAKnfQWwa3EZQe0
         BAEEnzkcE0fiBIEJXp5MGtIdFHlFYrdQapVuRfqSsnT7Dm0+yYeM7W/xv0yxm0gXjvvM
         dUDj7xVdhGvRsZ6z/E9jBf5DWnSYOWVdZQ5COWxRwmBSiWnTtc2TLDe69WuEv3IvxSE8
         2idIgGQhyxQcXNYkfyclliReawH7ED73N7ZF7NkLuQrWw9UUFFrGoGuF36AzyxGFeRS6
         qCE+IiASH79iMvYW78aPTiMWvRbZGdS9XlN75an7UGfWwydTvQmILTZBFeSQINlDoEr4
         oFQQ==
X-Gm-Message-State: AOAM531Fm67hjQr+MQAy2D7tkW2yBslmnikfwD8LzbN6i77sNYJQ1nLb
        TMXCYFR1yS/fljr1GVGa6BHgqg==
X-Google-Smtp-Source: ABdhPJwoXL0o8krQI9ycOghoOHGeNjAjXqPQZniw43Gw2Bb7ZaVEABjgZ/Mvt3KgOHJnO522R60wWg==
X-Received: by 2002:a37:9586:: with SMTP id x128mr21268593qkd.312.1592328263452;
        Tue, 16 Jun 2020 10:24:23 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id n25sm14066118qkk.76.2020.06.16.10.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:24:23 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] Introduce Power domain based warming device driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
 <20200616105325.GH1718@bug>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <0eb2e140-9c9c-4777-9916-d81eddc793ca@linaro.org>
Date:   Tue, 16 Jun 2020 13:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200616105325.GH1718@bug>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/20 6:53 AM, Pavel Machek wrote:
> Hi!
> 
>> Certain resources modeled as a generic power domain in linux kernel can be
>> used to warm up the SoC (mx power domain on sdm845) if the temperature
>> falls below certain threshold. These power domains can be considered as
>> thermal warming devices.  (opposite of thermal cooling devices).
> 
> Would you explain when this is needed?
> 
> I'd normally expect "too low" temperature to be a problem during power-on, but at
> that time Linux is not running so it can not provide the heating...
Hi Pavel,

This is more in the scenario if the system in on and temperature is 
dipping (I have been told in colder climates). Idea is to turn on 
resources so as to prevent further dipping of temperature if possible.

> 
> Best regards,
> 
> 									Pavel
> 

-- 
Warm Regards
Thara
