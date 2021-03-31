Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813FC35087B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 22:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhCaUrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhCaUqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 16:46:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D3EC061574
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 13:46:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3023954wmq.1
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mjHBwLjYUXWuRoBuiTAQj8XDaBfJIXP1bnrnlqYEHew=;
        b=pOB+DHhSxHbiS0m4CcaSCxN8wSxuH/HrMr2Ql40fIUthow77RG+immg0bLof1FxX0C
         cZ+eVTZkLpXDt1ot5SmjWFlqW/ofc/55/6GY0gI/tW2/hhJAQwY4yBmjoBe9RKy8ylNB
         oEkC01G7um/qgN1LA1Euy5Vw+l7cOCBf1EEhNwawhwfk5gWKR7+FjyFCvW+f/ISbef80
         qepb6YLAyI9pbcUCabhwGTooNQFB8Fie8SRGYVAxrpeeiUQRNMVAANh02oryeDQ26jq5
         UpoymJZTm9RrgyVenVVYFFlV+kaVSHcn1rgCDgalNDh791IBunPBTtNFZ8LhLDc5+x3O
         zQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjHBwLjYUXWuRoBuiTAQj8XDaBfJIXP1bnrnlqYEHew=;
        b=DnhT//7BF/5Kp2aZPawoGfPM6rPGuyS0OwPOzXvmkNF1pQSA0x20x8XLftsWIPOf2N
         I5EBMThQZua2kpkoHg3ogWPWk33C7hUIro+jhOM3oH6vjPO4HtDw8hqVo3wz9o6N2ydf
         dpmmC7yzndBSpX5yGljhlKtAKfSPPHCCC14MmliQ4aUDHoquVLK71bV3EeNxOlSBu+It
         xBmf/I68n759EI89hnDFLzAFyz/walCBNIbdCR8Eoq0QNoLMPCRZ47lxiyG3+UZFbA4Q
         6geWoiz/J4VN2YMDTLkaC+NhzMmrIFh427U/3BZ78qPBC38Hb9T2c0VHXRmAf+3EoIHA
         kbzw==
X-Gm-Message-State: AOAM530NMbJaS4WDW7kf8C8zT9put2rz2dS9UFk/VEu3Te1UKj1zzi/A
        77M6XKmDPY3oVrEGDUe+1ZDUPiAGj67M7A==
X-Google-Smtp-Source: ABdhPJy1r1tHWLYtTSnN/+l4Vc0rdLRc8bMHH2qHR5QXXXoxzciM9Lsy6q2E8W/TiNELAhMCfUdb+Q==
X-Received: by 2002:a1c:3d8b:: with SMTP id k133mr4829604wma.6.1617223611420;
        Wed, 31 Mar 2021 13:46:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id a8sm6689496wru.35.2021.03.31.13.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 13:46:50 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
References: <20210331110048.24956-1-daniel.lezcano@linaro.org>
 <20210331110048.24956-2-daniel.lezcano@linaro.org>
 <YGS6NraFr6+qvzda@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <918bc42d-0bd7-753c-1132-fd19617349ed@linaro.org>
Date:   Wed, 31 Mar 2021 22:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGS6NraFr6+qvzda@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Greg,

On 31/03/2021 20:06, Greg KH wrote:
> On Wed, Mar 31, 2021 at 01:00:45PM +0200, Daniel Lezcano wrote:
>> +struct dtpm *dtpm_lookup(const char *name);
>> +
>> +int dtpm_add(const char *name, struct dtpm *dtpm);
>> +
>> +void dtpm_del(const char *name);
> 
> You can not add new kernel apis that have no user.  How do you know if
> they actually work or not?  We have no idea as we do not see anyone
> using them :(
> 
> So no need to add things with no user, feel free to just drop this patch
> until you have one.

I've sent a couple of patches [1] on top of the previous series. I'm
finishing to respin it against this new one.

  -- Daniel

[1] https://lkml.org/lkml/2021/3/12/1514


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
