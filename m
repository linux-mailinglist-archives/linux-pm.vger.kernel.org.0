Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF93253E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 00:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfFBWDP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 18:03:15 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.212]:12133 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbfFBWDP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 18:03:15 -0400
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Jun 2019 18:03:14 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 0E7F5A9830
        for <linux-pm@vger.kernel.org>; Sun,  2 Jun 2019 16:38:37 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id XYBYhEZ752qH7XYBZhRXXR; Sun, 02 Jun 2019 16:38:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3yY6puF5yr6t9ajzI5zXVjuhpN5P/MQwRyHXK2uCu9Y=; b=weVrd+TD99WJUSZK0UrQH42JTt
        qtv4X92WOjdU8XJmSO7aM4e3pRacAVkOnZ/DOlx5uv/KMLXNQq1FsE0KdYN6KRcEiwAYBLbADUwro
        u2k7eCKfqjnboMEtV6c0pcXLLpPieOul+FO9B3yj3WpJF667TwKKdvXpRxORfKrMZcSBjxzHV7q1W
        UCCHDakokr4RyB0GuUVxpojYIvw4mcQcT+I61sG5IkEoCqJBZQe9JgYlmYAUAg40ZLW36MBV+XApH
        Zqx5zW712hoY9kF75XDRyDCz1fpHmcu6GTkEF5Ku71nq9lcNHYi/BEZgI1DM5h3yd7B1L/rWj1w8i
        /F3u0lnw==;
Received: from [177.34.20.96] (port=54464 helo=[192.168.0.28])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hXYBY-003QwH-8q; Sun, 02 Jun 2019 18:38:36 -0300
Subject: Re: [PATCH v3 2/5] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br>
 <20190527022258.32748-3-matheus@castello.eng.br>
 <CAJKOXPdtsyY_GhniBAb0yV=HOhGx+x4xRPqNgdO+d0MDZRZ_7w@mail.gmail.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <71c4f6b6-fbbb-14ba-0cf0-2377498fdfbc@castello.eng.br>
Date:   Sun, 2 Jun 2019 18:38:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdtsyY_GhniBAb0yV=HOhGx+x4xRPqNgdO+d0MDZRZ_7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hXYBY-003QwH-8q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.28]) [177.34.20.96]:54464
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 8
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Mon, 27 May 2019 at 04:45, Matheus Castello <matheus@castello.eng.br> wrote:
>>
>> For configure low level state of charge threshold alert signaled from
>> max17040 we add "maxim,alert-low-soc-level" property.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   .../power/supply/max17040_battery.txt         | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> new file mode 100644
>> index 000000000000..a13e8d50ff7b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> @@ -0,0 +1,28 @@
>> +max17040_battery
>> +~~~~~~~~~~~~~~~~
>> +
>> +Required properties :
>> + - compatible : "maxim,max17040" or "maxim,max77836-battery"
> 
> One more comment. The datasheet for max17040 says that there is on
> ALERT pin and ALERT bits in RCOMP register. Which device are you
> using? If it turns out that max17040 does not support it, then the
> driver and bindings should reflect this - interrupts should not be set
> on max17040.
> 

Yes you are right, max17040 have no ALERT pin. I am using max17043. Let 
me know what you think would be best, put a note about it in the 
description, add a compatibles like "maxim,max17043" and 
"maxim,max17044"? What do you think?

Best Regards,
Matheus Castello

> Best regards,
> Krzysztof
> 
