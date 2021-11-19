Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAC456B61
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 09:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhKSIOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 03:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhKSIOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 03:14:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45289C061574;
        Fri, 19 Nov 2021 00:11:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n12so39792301lfe.1;
        Fri, 19 Nov 2021 00:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i+tQP67QHbnYyqRfbDrJGUw19haC23HyGpmX+/dL3F4=;
        b=jqXkZiVRwaYxS+G/YNYYvqmUoYvwqSBiEwzPx5XhrCQn+Etsyg60o6KheSa0lgzvdm
         GNSGCKGLOd3Bpqb9t5S/+UyFTs0C0sHrv0AIRkOvfGaqXFOLUlDOwboBruiDgxRlZvKN
         QmTWeQxmYhy9YvS+tJXzFkHTjICl4C3cqgfniVYZBZSH/xK4tfVZwWix6BcA7b1H8hc7
         PoaKmsr5gmtOiqgcarb/8hZwEy+X86rmrx90UdeetUn8fbDiONgbFxASWtJhk7suaw9V
         tpzZI4zCNUCSkEk9IuyZ1R+q6jVRw9vAkqd8wb/CphCUVUe91alt0xr0Wf/9ay9r2XqI
         YNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i+tQP67QHbnYyqRfbDrJGUw19haC23HyGpmX+/dL3F4=;
        b=mtYRaiibdXFYaYAMt7H4C8RONDEuzxKyfq1CXKdXulGYR/+Jals6BvCaG3QerAY371
         v32Ry5DjL7fWyBsiLsVtf6njS5LPplEbkn3fRw9Z3ED1ETtRXFkdJePPE17WNZo9kP8f
         mIBJEa/0D7r4FWnpnnvI/qv6+74b4aulwbuhBqsUtYDx4kZS8mGDLT4xzn3SMAaLpute
         uKx7exiX0sgsrA39Lkf9GaZd8ZvH5VkOyYliKA/mdltHRLVuJECZZzfmHaft5MRRLmRh
         CUtABOKuH0dV2TIUe6/l2vzThYn6RKibOI3oVdoy5ggnNoUAGumdyAM43DuX0QPDWcit
         FOvw==
X-Gm-Message-State: AOAM531VeERwnrW1vlwW3hPXr2PmRtPGnaNh4rF8kIWK9aZ85C4Sa/Wl
        xg/UuQws3rliil9rz6NEknU=
X-Google-Smtp-Source: ABdhPJyox2qQXR88gaSy/6i+i3tXgLPxE4m5O/w+a2seMOL1Td9/H3gqqkoUV/gALhvJ8bP8bfiKMg==
X-Received: by 2002:a19:4f42:: with SMTP id a2mr30418772lfk.47.1637309481597;
        Fri, 19 Nov 2021 00:11:21 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id h20sm231682lfg.14.2021.11.19.00.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:11:21 -0800 (PST)
Message-ID: <ef036c92-ced4-cc36-08df-c0dd49e00249@gmail.com>
Date:   Fri, 19 Nov 2021 10:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH v3 6/9] power: supply: Add batinfo functions for OCV
 to SOC with 0.1% accuracy
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <392c7aa891d466bc4df06a076090150319e0e7dc.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdZ4HvgYyssNw_bfWR-7YQXEe_nPOtZChY_ZPUpz_Ga7jA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdZ4HvgYyssNw_bfWR-7YQXEe_nPOtZChY_ZPUpz_Ga7jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/19/21 03:49, Linus Walleij wrote:
> On Tue, Nov 16, 2021 at 1:27 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
>> The battery info functions computing the state-of-charge (SOC) based
>> on open-circuit-voltage (OCV) are returning SOC using units of 1%.
>>
>> Some capacity estimation computations require higher accuracy. Add
>> functions that return SOC using units of 0.1% to reduce rounding error.
>>
>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> That sounds useful.
> 
>> +int power_supply_ocv2dcap_simple(struct power_supply_battery_ocv_table *table,
>> +                               int table_len, int ocv)
>> +{
>> +       int i, cap, tmp;
> 
> Why a whole new function? Just rename the original power_supply_ocv2cap_simple()
> to power_supply_ocv2dcap_simple and patch it to return the finegrained value,
> then add a wrapper that use that function but drops it down by one order
> of magnitude.

/me feels slightly stupid.
I wonder ehy you had to explain this to me :) Well, thanks and agreed!

> 
>> +int power_supply_batinfo_ocv2dcap(struct power_supply_battery_info *info,
>> +                                 int ocv, int temp)
> 
> Same with this, saves a lot of code!
> 
> (Also will use my new interpolation routines since you refactor
> on top of that.)

yup. I think this will be _much_ cleaner. I need to revise also the IC 
driver patches because I think I implemented something like your 
interpolation routines there too. So - thanks.

Best Regards
	Matti

