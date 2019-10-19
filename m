Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E707DD5E0
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 03:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJSBDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 21:03:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44573 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfJSBDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 21:03:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so4236408pgd.11;
        Fri, 18 Oct 2019 18:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O2vDP5dhX90+NEeZF4xwy/6nZiyy5Chs2FfT8NPVR7E=;
        b=ZFvZMeNde3XSQbCX5z+A8LC9qIkMj77Zzi+EgKADvigb12CI/Atx5eiO423UuVNTZ4
         FMRj0TTh5vYpzBJFf3onEv/NHctJbLDMvw72Wm/UAs/vKZecv2U7aiKsK5O98DMCY3LN
         6P8SWWQFoi0WW7dNj9CrT+uf0KK0LjF+3+/cSfQNkEYtvDykIjEQuh6qD2TVjSbIXoLH
         0NoyZAo/m7sgpGHXCa5h6dWvnJlDsRbI4TfaO4uSF0QgVAzYFE5KMcLQFbvw7OGqrAEI
         4v0uNLLBBCk7L6lzLHiVmoKSbmmeLfyP8LnUo6lczAWEEIGT7byS+WfZ7fYM1pCa1V6t
         b94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O2vDP5dhX90+NEeZF4xwy/6nZiyy5Chs2FfT8NPVR7E=;
        b=Cs6svu5TBVneapfDeF1cl88fLEO4eJMVjiW0eRMaVqngna/yQfIeyXNksrhczPppab
         F9DZFufQuoMgQVF4AqjK1BB3/Pijc1wl2THZzorzyf5HS0LJC4vKw+JkCjKmF5YB6YTa
         HH3dpKVCjMepemN8nl7VMuFmukJfZ7Ym3dsCGY+1v0YM97fb0niWl+nJaX1//pwcpeim
         hC60cnZJPN8ST8ZrqWO6oA/aB00BmQGj4Ox7MALU1LQFzC7j3PkouKievz5lHO/6Cap9
         uyrWE9s23t2gFWYpHLtTjSXmsoZmNKfATgBiJ4OkoFtRO/QhffUzValM1xCtjF0s8EKC
         1VPw==
X-Gm-Message-State: APjAAAVgsokVXL/etNlbNK/7y3eQxkJvFNsnT7BEvWNrAdzDaHrp2Paj
        50g0IEeTefgzQ7e1OFoc9qexMMNU
X-Google-Smtp-Source: APXvYqyfRaTHhsimbDLjYp5YZtM7EeE6UsAbtJraEIbyzdK0a87RqNrOa51iK+zxPIPUiG8is3MEFw==
X-Received: by 2002:a63:f5a:: with SMTP id 26mr13333625pgp.63.1571446981132;
        Fri, 18 Oct 2019 18:03:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h14sm7304535pfo.15.2019.10.18.18.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 18:03:00 -0700 (PDT)
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20191018154052.1276506-1-arnd@arndb.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <803f6fa5-b929-007c-5302-4a2d5042241c@roeck-us.net>
Date:   Fri, 18 Oct 2019 18:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/18/19 8:40 AM, Arnd Bergmann wrote:
> 
> Hi PXA maintainers,
> 
> I'm in the process of getting the old ARM platforms to all build
> in a single kernel. The largest part of that work is changing all
> the device drivers to no longer require mach/*.h header files.
> 
> This series does it for arch/pxa/.
> 
> As with the omap1 and s3c24xx series I sent before, I don't
> expect this all to be correct in the first version, though
> a lot of the patches are fairly simple and I did exhaustive
> compile-time testing on them.
> 
> Please test if you have the hardware, or review!
> 

I don't get very far.

$ make-arm pxa_defconfig
arch/arm/Kconfig:677: can't open file "arch/arm/plat-pxa/Kconfig"
scripts/kconfig/Makefile:90: recipe for target 'pxa_defconfig' failed
make[1]: *** [pxa_defconfig] Error 1
Makefile:567: recipe for target 'pxa_defconfig' failed
make: *** [pxa_defconfig] Error 2
$ git describe
v5.4-rc3-52-gfcc4181cd625

Also:

$ git grep plat-pxa
Documentation/arm/marvel.rst:   arch/arm/plat-pxa
Documentation/arm/marvel.rst:   arch/arm/plat-pxa
Documentation/arm/marvel.rst:   directory. The plat-pxa/ would therefore disappear.
arch/arm/Kconfig:source "arch/arm/plat-pxa/Kconfig"
arch/arm/mach-mmp/Makefile:ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-pxa/include
drivers/gpio/gpio-pxa.c: *  linux/arch/arm/plat-pxa/gpio.c
drivers/soc/pxa/mfp.c: * linux/arch/arm/plat-pxa/mfp.c

Did I pick the wrong tree ?

Guenter
