Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F061A5FB8
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 20:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgDLSPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgDLSPH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2020 14:15:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028EC0A3BF0
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2020 11:08:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so7962620wma.4
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2020 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G7A0r4JUqARkX7IMofNwZ/y7BM8uD5N9xl0sjaTO+x0=;
        b=oFtAxf5znxgMMF5tE9ElyDpRsBD1PKKsrBEr2EHxMRHROtoDRoVrk/ry3nlcb/0gkZ
         Gpcn1e5K87YWpebCzcHUbAw/tsCIodFRF2JjZxerAtkLRljbE68u3DD4GxajSLx2/+nd
         Vs7i0U7yCxXPKXF0Hy3M1lTjHPa91aMYnILn+tNpF0J/H46p6qj2MVZe+3lH32KWjFhS
         VpId7an3Q7d1bYIoOhqqSjWPXiw7oCe1G3SGGjEspApu1SaWdaV/25C7ne0evA8IWlKW
         v9IXrlBr8rnP4qdrxCSZhE3+3ttDYP/IfMMPj3DcwsT6bcZzTGjD2wbGjh3poIsUi2cH
         DsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7A0r4JUqARkX7IMofNwZ/y7BM8uD5N9xl0sjaTO+x0=;
        b=LyLjgnXWkBnKeejVgl/MMxgSx99UkslLo9tnt7C53R5itr50L7seJcL6I/P8Q9v5Lr
         jTkghFgWXcZRgTWuh+D2LqmhP5gbTh8+rzj48Lan+WLCrcoIMnLmccRDQUDw3crKEX1+
         kNmXEeeLgMSUpRUf/aKHYVD/vv0aCvt3f0s+DbuzTFZrfumy2sOoCanorvcGCwFExcgx
         SB5lNjdHisZrALCk7TNgF4ieIHUIDaraEVC4xZ2BFLxge7kvV8mYXym2pCEx1y7Mq2pF
         VMp9rL/7WSx/b7ypgmSUgxfVGZsT56b+dEwnlvHU3M84YWVHI+o1ascNAwycwXQQAsg0
         2oMQ==
X-Gm-Message-State: AGi0PuYUO46qgE4YXF9SMCqwx5wsh3g5Mv/wI2fzVM4Vums95pjUqDSt
        ckjT3hh0VKio5+XlPjwWmNF2zw==
X-Google-Smtp-Source: APiQypKwHr3lRwcD+BBa7YFbVWW5NXzsQ9QvJh3397D/+e7rwwlz8dnW3xv5Lz9TfQ3dm5zbLeR5Kg==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr12221022wme.0.1586714897600;
        Sun, 12 Apr 2020 11:08:17 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id n131sm11216077wmf.35.2020.04.12.11.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 11:08:17 -0700 (PDT)
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add the idle cooling device
To:     Rob Herring <robh@kernel.org>
Cc:     rafael@kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
 <20200329220324.8785-2-daniel.lezcano@linaro.org>
 <20200410165915.GA12708@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4ca7b16f-c0b0-23c3-08a3-8731c2bf5f35@linaro.org>
Date:   Sun, 12 Apr 2020 20:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410165915.GA12708@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rob,

thanks for the review.

On 10/04/2020 18:59, Rob Herring wrote:
> On Mon, Mar 30, 2020 at 12:03:18AM +0200, Daniel Lezcano wrote:

[ ... ]

>> +   '#cooling-cells':
>> +      const: 2
>> +      description: |
>> +         Must be 2, in order to specify minimum and maximum cooling state used in
>> +         the cooling-maps reference. The first cell is the minimum cooling state
>> +         and the second cell is the maximum cooling state requested.
>> +
>> +   duration:
>> +      $ref: /schemas/types.yaml#/definitions/uint32
>> +      description: |
>> +         The idle duration in microsecond the device begins to cool down.
>> +
>> +   latency:
>> +      $ref: /schemas/types.yaml#/definitions/uint32
>> +      description: |
>> +         The exit latency constraint in microsecond for the injected
>> +         idle state for the device.
> 
> Both of these should have unit suffix. And then they don't need a type 
> def.

Do you mean I should remove the $ref:
/schemas/types.yaml#/definitions/uint32 and change the name to
duration_us and latency_us ?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
