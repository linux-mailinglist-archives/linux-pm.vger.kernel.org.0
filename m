Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5524FB2E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHXKRL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXKRE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:17:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D3C061573;
        Mon, 24 Aug 2020 03:17:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y2so8986403ljc.1;
        Mon, 24 Aug 2020 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EO6NpAg0w4GDPViUfV2sBM0Yy3icsdCv6CnK4KTImqc=;
        b=NVxFQX8hvxJpgbMYgWDP8ljVHy+fJWPMXrej1XIN0mQJrxqZqZ7rZ7q5Jr3ijgyGlf
         T3OdrM5cuz0hbZsZDGoiDq6Qac6igGMQUNV8ExM7LTC0YIBGX9lNSqiEeB8rxnqeUu2W
         /m2pfPwGkZ/XhhspBiEDuDE82+a5usjw734uegAh6VfTqoirraDGyDeuPQRyHEI8vdqs
         Gq/wyUmgCK6/o0p8Z+REYA4rkSupFZ8tMdvOe5iyVLRkONnmKN11ajMV3MQLSiewiWwt
         7Rx4vkTe3vIO/BL5NR7FylxG9n/shFmmXbMS19pVax/PyPZHWUY5v1v57bfQIZBn2+M5
         EjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EO6NpAg0w4GDPViUfV2sBM0Yy3icsdCv6CnK4KTImqc=;
        b=Ptnh0JCIMkprXszF2tofnoE7WrYg//iRatLCSPwaMgPHv9nAftKbcKjAn5MGwGggxc
         J1BIKzXOGBHT1/EEjqE2sOPwTLu0reEjZNTzHHR0HAcwscEikmtvDMfLEmlYFhGtUZWt
         m2dGHxYvbJUVQ1aMOYO3p4LEYYYeA6N2u+NJsyn6M/D+JKD12QRIpj7KsaoHMzSPbhCr
         cRd3IJsMsbNpgmGaVLLQQfOCCFHXNUIuS5f/76XPh29bL5ZlHz25s3NdDUvMMyAlXR9s
         37ug/CZYQEerG7u09gGM+q085p2e8Wy86NwL4sPBFAq+ZJs3w3lw+bMxRZ7NF+xQQMQq
         w9BQ==
X-Gm-Message-State: AOAM533RpymZKFV7KXN2SF17hMf8AI23Noqj7+GDiqUcxnvONOaf3goI
        a65dU8vxx0BpphHL2ak6NX7BrNcpAjA=
X-Google-Smtp-Source: ABdhPJy/u/4LLu9r4mhcxwDPpCC7JjeLfk00HvQSpyKtVoG0ldd1sVtB6GCZfVC6S4L1b5e/fmkjSg==
X-Received: by 2002:a2e:b708:: with SMTP id j8mr2411912ljo.375.1598264217513;
        Mon, 24 Aug 2020 03:16:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t18sm2111855ljc.126.2020.08.24.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:16:56 -0700 (PDT)
Subject: Re: [PATCH v1 3/6] leds: Add driver for Acer Iconia Tab A500
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-4-digetx@gmail.com>
 <20200823223434.cjxo762ehxgo4caz@duo.ucw.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c7d37174-1dcd-206d-01ac-eb95aa0b5dc8@gmail.com>
Date:   Mon, 24 Aug 2020 13:16:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823223434.cjxo762ehxgo4caz@duo.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.08.2020 01:34, Pavel Machek пишет:
> On Sun 2020-08-23 17:08:43, Dmitry Osipenko wrote:
>> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
>> embedded into the Power Button. Orange LED indicates "battery charging"
>> status and white LED indicates "wake-up/charge-done" status. The new LED
>> driver provides control over both LEDs to userspace.
> 
> Hmm. If the ENE controller is similar to other devices, should it also
> share LED driver?
> 
> And I guess the cdev names should be different based on info above (I
> gave you wrong suggestions before)... and they probably should be
> parsed from the device tree.

The ENE controller hardware is the same on all devices that use it, but
firmware isn't the same and apparently every vendor invents its own
thing in regards to the firmware because firmware features and interface
varies vastly from device to device. Hence, unfortunately, usually there
is very little compatibility even if devices come form the same vendor

AFAIK, the ENE controller provides some compatibility on x86 machines
via ACPI EC standard, but this doesn't apply to the ARM devices.

I know that Acer A200 should be able to re-use the A500 EC driver as-is,
but A200 is pretty much the same device as A500, so it's not surprising.
IIRC, A200 model only misses back camera in comparison to A500. Hence
there shouldn't be a need to parse the names from a device-tree, but
I'll try to double-check it to be sure.

Thanks!
