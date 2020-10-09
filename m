Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA76D2898CC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 22:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbgJIUIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389072AbgJIUGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 16:06:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F472C0613D6;
        Fri,  9 Oct 2020 13:06:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j30so9560204lfp.4;
        Fri, 09 Oct 2020 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ZK8UsrFVqX81y+hI5p39GDyrhSmvCaWHxPB2+b1688=;
        b=U/y5ZpohCmv/ti9knT0oocZYLOwRbCJEEFFOqyKLDYW80386EBywSSgcDGhnIT1Ccc
         H7M1vRmBvJbXQXmST9EgrJs0zlU8htyj6kSPsJ7D0bR0C5WlWhcHMQdLqU4LfocChVaE
         GoQbcby4SCO97HhQHEFYI+w8vUAmxjpqVhfHZXoL8zepCYkyTPCYInZxeD9ySSVl+pFj
         cgsT74h8Aoqx+tkVkBbw+ks1wP+KC00Pkuq2WvJoFzmhx+qqDz3qClvO9VZnL6JdIK8+
         oBmqXSjHEuTrVI3dyrZ7uWbfw3EunuedVYKRH17ohUt09x/95zBlkJlg4C6YUasJQkOu
         scNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ZK8UsrFVqX81y+hI5p39GDyrhSmvCaWHxPB2+b1688=;
        b=n8GVCSK9vzQbNdIQhquHKokunkBGwp/FfKqZpRLN8v1j9YtsLUocFgZ3Q9YNVk/Ox8
         iPE08k3eagARcO7E155SVyxO1vAsj8fnBaJt+NkfLqbydjnFT3hiw8VYsnAu7PAveCdu
         4gLTqWxfwZz924yqb1loKHw6L1o551956UBE2EfEzKrUWVLwBTYlOBPrHmCwViunz05b
         I5QGqsPXQKTVmyd4UDNaXVNwUAIQxL1DDE+M74w8EATYaz74qZxaOMp++e6P1JZxXMrC
         1VYFjbu8KXFeWahi8YJetVNuWnfqGyNAZmK8AGpntw0Fo98awW6yqHsL/eIp6ii47fOU
         frvQ==
X-Gm-Message-State: AOAM530h8sOkVXJtqKDV7mIJ9f40A2C7RIcvAeMcJeoA/HKKu2j4jICj
        h1aOl0ZgZOkKmnYcaTDpWs+5D22+TEM=
X-Google-Smtp-Source: ABdhPJwSC+c115moWCXPrNR4bzBFEDnP6BoD9NZ+Xj0Jai+vyFJhaH3LCzHFI33GWcYyr90/aF9O9w==
X-Received: by 2002:ac2:47fc:: with SMTP id b28mr4576329lfp.454.1602273974509;
        Fri, 09 Oct 2020 13:06:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru. [109.252.91.252])
        by smtp.googlemail.com with ESMTPSA id e17sm1870925ljn.18.2020.10.09.13.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 13:06:13 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-2-digetx@gmail.com>
 <20201008230032.a2mgd3yymxbbreqo@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2027587e-084d-8125-9830-6ff07bbe7f2d@gmail.com>
Date:   Fri, 9 Oct 2020 23:06:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008230032.a2mgd3yymxbbreqo@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.10.2020 02:00, Sebastian Reichel пишет:
> Hi,
> 
> On Sun, Sep 06, 2020 at 10:50:59PM +0300, Dmitry Osipenko wrote:
>> Add binding document for the ENE KB930 Embedded Controller.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
>> new file mode 100644
>> index 000000000000..635c8966ca22
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/ene-kb930.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ENE KB930 Embedded Controller bindings
>> +
>> +description: |
>> +  This binding describes the ENE KB930 Embedded Controller attached to an
>> +  I2C bus.
>> +
>> +maintainers:
>> +  - Dmitry Osipenko <digetx@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +        - acer,a500-iconia-ec # Acer A500 Iconia tablet device
>> +      - enum:
>> +        - ene,kb930
>> +  reg:
>> +    maxItems: 1
>> +
>> +  monitored-battery: true
> 
> ^^^ this is not being used by your battery driver. Do you plan
> to use it in the future or is it a copy&paste mistake? :)

Hello, this is correct that driver doesn't use monitored-battery info,
but I was thinking that it's good to have anyways in the device-tree
because this completes hardware description + the gauge driver isn't
aware about maximal battery temperature. Hence it may become useful and
it doesn't hurt to have that additional information about battery cell.
