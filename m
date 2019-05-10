Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7B198D4
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfEJHQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 03:16:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36937 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfEJHQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 03:16:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so162979wmo.2
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvTnepYea0EBsHjZpph8FxtYlM4OPmMVBMIjktcmeVM=;
        b=cTVa3xp4hXBoZyNXrz0uNxHmzZiNUJbTL+zYRUNb5Kp7iDXGPDo/Qwf/AIQNvql+z1
         TNjnQyNXYNfOcVp1naNqLyp7JnkYXPiGmm7uW0pXrOuuy3ErZ+IOtyd7T9NGKUWs15+z
         QY8WPl1qTvbOjwGdfYngu0PbbEwqcfiCeU+VGc9xKWI4luR6PWMvrmPJCAlBXymKuDTa
         8nT/9wThav6hqA2g8NyuKGMbwFsewaoYYbw3aIQewGFEg/x6nXkpL2jcSY76SjEaa4tm
         skaXfrXagfMko40tR+Mbk3toK0awX0PY9AO9usxErzdPoBI3/b/yOLZBFOG4BL03vBy4
         TGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvTnepYea0EBsHjZpph8FxtYlM4OPmMVBMIjktcmeVM=;
        b=Ouz40rP3WWrO/sdmwAhzeB40M4CVPPMM4vfmE9Vm0DqiVE+u9ERB4chDuQDfbtFIAl
         dGOf+PJVO+7HyBEsbqbZNezb3th+ZjaVjBWWd79gKTaFqLH4Zm5/AfuyvXnF5T9lFuPc
         DEjaQPUbeuSe2yIjIrKy6P745/XbN98yR4c6gGO4NMPxXB2EpkRWHD76FshG97xh4/re
         U+cc/hRATWELCXVxv0QgBJfeYvR4h/Nv6SnCLQcraLqSPGcbcrAfg8E23limsCt1VBKD
         sBTvg+mh3hDRn2HjR2Dtx785ETKGtW1mIulQUFVnQFJoQavS/YOMWUZvgxF7qswnDvV7
         QoSQ==
X-Gm-Message-State: APjAAAXrEvhS5JJbrqzImR1x/CoKPX7zlDE7jm3Wk7J53NmW5oE78OXZ
        psH+g3R2eF1izC5I6qF/OPRhDQ==
X-Google-Smtp-Source: APXvYqz67ixtb5Kj+lW57C/bg64GF8kDMDU5xV9ktI11Srq5D7jgxo/wcrgpIrmML8Jc5rcrWgf1PA==
X-Received: by 2002:a1c:80d7:: with SMTP id b206mr5606595wmd.48.1557472594154;
        Fri, 10 May 2019 00:16:34 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id i18sm6521170wro.36.2019.05.10.00.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 00:16:33 -0700 (PDT)
Subject: Re: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
To:     Andy Tang <andy.tang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
References: <20190423022507.34969-1-andy.tang@nxp.com>
 <20190510031335.GD15856@dragon>
 <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9fb2e306-38c7-2af7-5470-ff5bc4e23370@linaro.org>
Date:   Fri, 10 May 2019 09:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/05/2019 05:40, Andy Tang wrote:
>> -----Original Message-----
>> From: Shawn Guo <shawnguo@kernel.org>
>> Sent: 2019Äê5ÔÂ10ÈÕ 11:14
>> To: Andy Tang <andy.tang@nxp.com>
>> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
>> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-pm@vger.kernel.org; daniel.lezcano@linaro.org; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Subject: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
>> zone node
>>
>> Caution: EXT Email
>>
>> On Tue, Apr 23, 2019 at 10:25:07AM +0800, Yuantian Tang wrote:
>>> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
>>> cluster sensor is used to monitor the temperature of core and SoC
>>> platform is for platform. The current dts only support the first sensor.
>>> This patch adds the second sensor node to dts to enable it.
>>>
>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>> ---
>>> v6:
>>>         - add cooling device map to cpu0-7 in platform node.
> I like to explain a little. I think it makes sense that multiple thermal zone map to same cooling device. 
> In this way, no matter which thermal zone raises a temp alarm, it can call cooling device to chill out.
> I also asked cpufreq maintainer about the cooling map issue, he think it would be fine.
> I have tested and no issue found. 
> 
> Daniel, what's your thought?

If there are multiple thermal zones, they will be managed by different
instances of a thermal governor. Each instances will act on the shared
cooling device and will collide in their decisions:

 - If the sensors are closed, their behavior will be similar regarding
the temperature. The governors may take the same decision for the
cooling device. But in such case having just one thermal zone managed is
enough.

 - If the sensors are not closed, their behavior will be different
regarding the temperature. The governors will take different decision
regarding the cooling device (one will decrease the freq, other will
increase the freq).

As the thermal governors are not able to manage several thermal zones
and there is one cooling device (the cpu cooling device), this setup
won't work as expected IMO.

The setup making sense is having a thermal zone per 'cluster' and a
cooling device per 'cluster'. That means the platform has one clock line
per 'cluster'. The thermal management happens in a self-contained
thermal zone (one cooling device - one governor - one thermal zone).

In the case of HMP, other combinations are possible to be optimal.



-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

