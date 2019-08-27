Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3589EA28
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfH0Nyu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 09:54:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40601 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0Nyt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 09:54:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so18896926wrd.7
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wP3O9f9UL7D1VS/Q8lCXAfpcx4GpSEma2VVcpqWHXHU=;
        b=fy+jIshyLKNE4Ry05ulQniPH/cEoDF6yWhVNUxRKDj97xLyyX+5mi3pBUyHnvFjtU4
         VtygxYBS1PKb5Q6RmtQhoDD1+EWrvRi2vOqa5QdqwnPlrUOJNnQjmHJK3RI/5PG+x2z2
         LRYIJt9sVVLLq1pboIqsvry9DCV34qTVE4xSvvvzH1vZ3FFMlN6NH3B33M+XQ0YRjNdD
         nl5XmpDW5vRx+QTF9yqOfDSjvSSn3qWBxY2sSOnkFrKeF4WvtF1CU32E98qQsWLPENly
         6yvZDbA9WNSBJfL9dRl9oFHepOM9e2mZBmOs8nM76hOClFuE4uc+CaSP9CfANj30iU2o
         KhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wP3O9f9UL7D1VS/Q8lCXAfpcx4GpSEma2VVcpqWHXHU=;
        b=GpZ8fI2Vg8CgH3BXxUikIWxQMNzQ1TlzNz+WaAqGDquIRK1Va6S+6rTCmLW/olMRfG
         TZUbmrcJa9OZucyLmitO2bFEtJMMjAKdtPGPUQCOCZo5pP2FJZbLQLu21M85pGwKZhLs
         ot7xESAy/yKocKMMhj6ORts5IzKnfCG0tfXBJq7YfLEUjCbkbagS1+5PA0J1W4AB+Z0f
         xpiLJqs/fmpN5a7FwXA87wHCcRkEfe4gVh7/tB8YLor0iBaww0cFX5Hsm7xcnWpn+u56
         M5vvCLZbXP2aty2eTvv8xdHq1LTMz9jKabqOqDhDqlYym6IgU91/vwUnnfg2mf/jdmDF
         vZEg==
X-Gm-Message-State: APjAAAVqs5g55AqDAaBRaRRRChmtHl8FtMtf9Z1m5ieUmQJ3skQ18r7s
        +usHZRRZHUI8TLTq13MEE1LTvQ==
X-Google-Smtp-Source: APXvYqxSKkbPKNiCkmvxsPQ4MJrlHA++WEPX/d/C5PfLanLCJnd4mWMNzCvFZUlvZeQo1qdORa9lOg==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr29332828wrq.208.1566914086392;
        Tue, 27 Aug 2019 06:54:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab? ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.googlemail.com with ESMTPSA id p10sm3569515wma.8.2019.08.27.06.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:54:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20190717063222.5902-1-linus.walleij@linaro.org>
 <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
 <CACRpkdYO7zzrUg=7=4D7XMUwoa6XQggm0jB1PtPhKK=3EV9AyQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f683466b-a554-87c4-0bfd-4d56bd1142fe@linaro.org>
Date:   Tue, 27 Aug 2019 15:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYO7zzrUg=7=4D7XMUwoa6XQggm0jB1PtPhKK=3EV9AyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/08/2019 15:07, Linus Walleij wrote:
> On Thu, Aug 22, 2019 at 8:16 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
>> Another point is there are too many trip points, two should be enough,
>> one for throttling and one for critical, the governor will handle that
>> properly by stepping the opps.
> 
> I looked a bit into this, and it seems that there are a number of
> trip points simply for inspecting the system (Vincent may know better
> because he worked directly with this): the thermal sensor can only
> set an IRQ for a certain temperature, there is no interface to just
> read the temperature. 

I see, it is a limitation of the sensor.

> By setting a number of trip points and
> first let the IRQ fire at the lowest you see how the system moves
> up in the temperature points and that makes it easier to inspect,
> so this sensor will set 70 degress, wait until the IRQ fires,
> then set 75 degrees, wait until IRQ fires, set 80 degrees...
> etc. It does the same with the IRQ for falling temperature so it
> moves up and down this scale, and interpolates the temperature
> between the trip points.
> 
> It is a bit crude but it gives some kind of granularity and control
> over the reported temperature from the sensor.
> 
> I think this is something that should be done inside the
> driver, not by abusing the trip points, so I try to rewrite the logic
> so that the driver fires these IRQs internally without using any
> trip points from the thermal subsystem.

In the comments, it is mentioned something is missing with the PRCMU but
when the interface will be available, the get_temp won't have to
interpolate. Wouldn't make sense to add the PRCMU interface instead ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

