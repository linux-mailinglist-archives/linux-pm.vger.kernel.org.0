Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E73DBDD0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhG3Rh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhG3Rh1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 13:37:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7376CC061765;
        Fri, 30 Jul 2021 10:37:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g13so19322801lfj.12;
        Fri, 30 Jul 2021 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YdD/cQbxE12roUQGUPlpfAtfifyzljBPvXuX8vTuNeQ=;
        b=OHLEomAUDEdDieEdq+73CDWNR3GZ9sjoIWNZUB6G0iOgneOiKlsjmU2LKmepB4/7K4
         K4LPYZOpdzackoANKPBCKPSia9gb8vn4s300ngs0LMWAIfTRrTDVJJhtJiOWg0nBfUPb
         eKLSZuhYp9ZDHfBe3p6i88WWMPgoOuIJ0nMBpExQ3EdpgKYwqhFqIRaXm+fIkApaofk5
         UzbdScesIb9d1IxiVfstMurv4iaCf4t2R3A/8tHkwUaUWhnfSdGRUu7RauPljNiFgCI5
         5W2IGaPuJFZqxABEB8Yd0P8suhrCr+LhA5Hg6h+wlJ5AKv5ao5Dt7S/d0gSZUt95NG2P
         mcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YdD/cQbxE12roUQGUPlpfAtfifyzljBPvXuX8vTuNeQ=;
        b=TqWcts8+gxe9LRLh0RZW55s+NhxHXh8x8KNw6cHnKiLIQxZVWekzB+oF1WppBXeK+J
         j7I4tAOgm7pxG8DxP0Hz+b95Ps19yPaM8uSJgmocF1kdo3h4UjKpKHhAh/gUGXLyU32z
         Rdu4huvU28YLVQ2wfYHZFkFmZyjdbJ5JE6o+Z5vQ/bnVdoQQDqXuYq8Rh1b5KnMuc2lf
         Lunk9gwqUGoJhC8gmwU8fg5rAq+OakctwjqStFxJUtfjP7XxvjvuuCbhj92I3NVb9ab6
         uC/t+HcIl0pa+GBiXMx/sLk29Mpz+0sO3SpOEcpS5RyVNGasNkHfVALrVHffFb7yuChb
         B7Mg==
X-Gm-Message-State: AOAM5316h3VV0WN1kVWRFhMFnuIk+fys0Eb8bkIAN3Xlm39jRsTp0vKa
        8gpp50Sa+cRrgOSijMZQn9c=
X-Google-Smtp-Source: ABdhPJwy8rI9+LJQTi6lVK2rpSiGY4hRkUnXqyk7UBMJ1mSAW7CPTJaIXxKYe3Umh7FA/tCTkTv6FA==
X-Received: by 2002:a05:6512:3e0b:: with SMTP id i11mr2517488lfv.221.1627666640891;
        Fri, 30 Jul 2021 10:37:20 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-114.dynamic.spd-mgts.ru. [94.29.39.114])
        by smtp.googlemail.com with ESMTPSA id h34sm201080lfv.231.2021.07.30.10.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 10:37:20 -0700 (PDT)
Subject: Re: [PATCH v5 00/12] Add OTG mode support to Tegra USB PHY, SMB347
 and Nexus 7
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20210717182134.30262-1-digetx@gmail.com>
Message-ID: <ed3c2a5c-a916-2215-a767-5546fa8cd352@gmail.com>
Date:   Fri, 30 Jul 2021 20:37:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.07.2021 21:21, Dmitry Osipenko пишет:
...
>   power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
>   power: supply: smb347-charger: Utilize generic regmap caching
>   power: supply: smb347-charger: Implement USB VBUS regulator

I noticed that charging doesn't work properly now, will fix it in v6.
