Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAF9E939
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH0NYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 09:24:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35571 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0NYy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 09:24:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so3050008wmg.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7li7aDboplh7awoH5Tk6YZHIJ4Bo0fwBoSkaaTv0VuU=;
        b=nR1E6kzTyWGJltUv081MN7wvsoEkymbypU78swlBGKhhxzKej25XSmn2VURlSMcty0
         dW4WmH4jnUQousf2AXN3ZvKdtGwyNzF5da2ZzGCIdeVjJeDVrxps3EPocTgCOeEPVPLr
         HvTi8So9PtVyqi9ApyaNp0+537AhIm21Gqm1q/bQ0EaS0J8QS0nk94n57i1Ckwu8ylHi
         cuq565C0u8/lbPXvxdrEyQj4xcIWihY3d7dij8xbHtyEN8K/NP2ajWQof4765xUOtoXS
         N5dFSmuKyfDhLmbGDcemc2C4CYJ5H/HS2KitjNEhOS8b0uLHj1eiWHHDxHqa9NnvTLkz
         jQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7li7aDboplh7awoH5Tk6YZHIJ4Bo0fwBoSkaaTv0VuU=;
        b=SWOCK5g4kks/m9scVazWyVO3XjlSs15qrT4zCbs6jP1UW0zImgWIEcIC+b0cBZuZgU
         oqYY42SY5x+9AlGdq1hS3ZSKNLexri50ZB68Z8zyA51S28Wb6ORXCndce/6VM/Zr+o+w
         c5ladECkl/S5n8ZZNGVA7Pg5jw2rEuiFdnTJrB/+QP6eA9/vRjGyctjdWMhzs7cwnGQP
         XHkKRNqyNXY08/fRGsi4ICi5Jmqil/E3NviBbUHALQmlJ694Q941ZnCzhIpe0SmNfs3k
         zDPVxkXSIfIOplm4rUMFCG6OiWCtmPRcS0s8RV3zU2wLITZXHswLfVuGLHSGtMy8qXp1
         tVCQ==
X-Gm-Message-State: APjAAAUOB8Pzjb/vYZ3AidcH5IBjaPS29fzo7YrE6TPWdyP+hBvw1ixl
        oYrhOeW1I93PGsdW/IhtBoSENw==
X-Google-Smtp-Source: APXvYqz1fdwcX/h/+HuYhYjP7Dk+W5kgKj80KVV/fq0LVw3+fVIKbmBNFmOAKQaWoF76B4tRqb+4Ug==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr26526392wmd.110.1566912291542;
        Tue, 27 Aug 2019 06:24:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab? ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.googlemail.com with ESMTPSA id e13sm3537668wmh.44.2019.08.27.06.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:24:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20190717063222.5902-1-linus.walleij@linaro.org>
 <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
 <CACRpkdYqjW_SHHLaSqgWO64CsGeyoOVGsOhnav0mwVA5W2fbuw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c4b0e2a8-90b9-2e76-e8ad-7e28fc762389@linaro.org>
Date:   Tue, 27 Aug 2019 15:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYqjW_SHHLaSqgWO64CsGeyoOVGsOhnav0mwVA5W2fbuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

On 27/08/2019 13:21, Linus Walleij wrote:
> On Thu, Aug 22, 2019 at 8:16 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
>> I've been through the DT and I don't understand why there is:
>>
>>         [ ... ]
>>         trip0-temp = <70000>;
>>         trip0-type = "active";
>>         trip0-cdev-num = <1>;
>>         trip0-cdev-name0 = "thermal-cpufreq-0";
>>         [ ... ]
>>
>> Those bindings already exists for the thermal no?
>>
>> Why not create a thermal-zone node and then add the values above?
> 
> I guess you refer to arch/arm/boot/dts/ste-snowball.dts
> where this is in the thermal@801573c0 node.
> (I moved it to the main SoC file for the next kernel.)
> 
> I think the reason is that this was merged in:
> commit dc1956b5f84de7d453ec4d9fe68385fffd689686
> "Thermal: Add ST-Ericsson DB8500 thermal properties and platform data."
> Date:   Thu Nov 15 18:56:43 2012 +0800
> 
> Thermal zones were not added until:
> commit 4e5e4705bf69ea450f58fc709ac5888f321a9299
> "thermal: introduce device tree parser"
> Date:   Wed Jul 3 15:35:39 2013 -0400

Oh, right. Time is running away ... :)

> Which is half a year after this device tree was written.
> 
> Apparently Hongbo stopped working on this driver before
> that and didn't convert the driver or consumers over to the
> new thermal zone APIs with trip points and cooling maps
> defined in the device tree (which by the way is an awesome
> feature).
> 
>> Another point is there are too many trip points, two should be enough,
>> one for throttling and one for critical, the governor will handle that
>> properly by stepping the opps.
>>
>> And one last point is the trip point should be passive, not active.
> 
> OK I get it, can we merge these two patches that just move
> the code to the thermal driver and then I can make
> a new patch or some new patches on top to migrate to
> Eduardo's new framework for device tree defined thermal
> zones?

Sounds good to me



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

