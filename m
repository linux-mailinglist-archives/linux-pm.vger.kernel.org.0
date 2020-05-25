Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556DD1E0C68
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbgEYLEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 07:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389918AbgEYLEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 07:04:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEFC061A0E
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 04:04:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so16674837wrt.9
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mdW5TPC5pBwP0jwDwntViUNqGTKeQcBSi1CWOKkv90w=;
        b=xC4PyPOpMkD3gjHORr1MlsIaPoaoO3wxo7sLYizRTeva0cpblXPG3DxEkmPibw0pwZ
         RYhWtDKVifwl9eqTL0qayhhWFNcOarYklj0GaInqJob9rDfi8aJDVhT2fa9yWDFeKZry
         zrUXCOFEBzZTCx6Yd5R9FmkNzuyw2JWyK5SNiXb0MagQ8+MhTrKDX/k/u2XH2a8W3kaP
         ceIc1BJZoD0IjpJaf5YB7JQtzm7SY+30PEocdbxSSrIyV7F9/hweqITPLFBFbVubAqp5
         nn0cGCvZWmXdGWKuNT5KfZXJvIc3m0f488iAUVxhuTctIKgGerteTRLuPw69doFs3rW0
         XB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mdW5TPC5pBwP0jwDwntViUNqGTKeQcBSi1CWOKkv90w=;
        b=nDjJ2PP3cVdC5qBtbksPMStNPRG1wEoJDE6NbT+IQTgt1IAm4XwUepNlgIy2wTyCXK
         YfpCRzzQkMWTd1V7uOF/2RS/g+F0V6jo+QFL3Xqwg8SD0fkedqQBCVkmkWdiCE1ID2zv
         8i0mwBEhZfMTYnTdhPYSK9tcCYxXlOnRMDXSKrpgShTbpsHf+WF/otPSafOQ35C74ccW
         INS6nFpbOT2Fv92T3qm7GkabCl0+IdKQeHh9gAlBa4o1HtASBFXI5z5nUC8lLfmDbix0
         ZFjiyFJA0QlwH4XE/oZIWFU7jaCJe8AIP8wxHnYXxEv0leRsykhWNQ5lNoNMA4U79N7X
         gOZg==
X-Gm-Message-State: AOAM5319qXDqD/SWXD/UetRaRVr9XD2jQqo18gTOAfBtELHNEKVQa4hk
        hEVNsnGkVdcenqDceMTQsAsPymsM5KI=
X-Google-Smtp-Source: ABdhPJyfOYYJksdGU00xJHoz0dGb6Rf2rEJX7JV0GT0hLF7DPKsW04VY3gPpZ4LP6LDZUIHOVMIqwg==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr15497931wrs.358.1590404690512;
        Mon, 25 May 2020 04:04:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f5b2:610d:e426:c0dd? ([2a01:e34:ed2f:f020:f5b2:610d:e426:c0dd])
        by smtp.googlemail.com with ESMTPSA id b185sm437997wmd.3.2020.05.25.04.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 04:04:49 -0700 (PDT)
Subject: Re: [PATCH] thermal: imx8mm: Add get_trend ops
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
 <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
 <DB3PR0402MB39167D71ED6979FC33D3747DF5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39162E6A876BA54A80B0DCE2F5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dadf94db-8aa5-d1a7-5818-c56032a44ea4@linaro.org>
Date:   Mon, 25 May 2020 13:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39162E6A876BA54A80B0DCE2F5B30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/05/2020 04:46, Anson Huang wrote:
> Hi, Daniel

[ ... ]

> I tried modifying the min/max to '2' in cooling map, it works that
> whenever cooling action is needed, the max cooling action will be
> applied. But I also noticed some behaviors which NOT as expected:
> 
> 1. to easy the test, I enable the " CONFIG_THERMAL_WRITABLE_TRIPS",
> and just modify the passive trip threshold to trigger the cooling
> action, this is much more easy then putting the board into an oven to
> increase the SoC temperature or running many high loading test to
> increase the temperature, but when I modify the passive trip
> threshold to be lower than current temperature, the cooling action is
> NOT triggered immediately, it is because the default step_wise
> governor will NOT trigger the cooling action when the trend is
> THERMAL_TREND_STABLE. But what expected is, when the temperature is
> exceed the passive trip threshold, the cooling action can be 
> triggered immediately no matter the trend is stable or raising.

You are right, what is expected is, when the temperature exceeds the
passive trip threshold, a cooling action happens, the trend is raising
in this case.

But in your test, it is not what is happening: the trip point is
changing, not the temperature.

Probably, the cpufreq driver is at its lowest OPP, so there is no room
for more cooling effect when changing the trip point.

IMO, the test is not right as the trip point is decreased to a
temperature where actually the SoC is not hot.

If you want to test it easily, I recommend to use dhrystone, something like:

 dhrystone -t 6 -l 10000

That will make your board to heat immediately.

> That
> means we have to implement our own .get_trend callback?

From my POV it must disappear, because it has little meaning. The
governor is the one which should be dealing with that and call the
corresponding cooling index.

> 2. No margin for releasing the cooling action, for example, if
> cooling action is triggered, when the temperature drops below the
> passive trip threshold, the cooling action will be cancelled
> immediately, if SoC keeps running at full performance, the
> temperature will increase very soon, which may cause the SoC keep
> triggering/cancelling the cooling action around the passive trip
> threshold. If there is a margin, the situation will be much better.
> 
> Do you have any idea/comment about them?

Yes, that is a good point. The hysteresis is supposed to do that. There
is a work done by Andrzej Pietrasiewicz to disable / enable the thermal
zones [1]. I think we should be able to fix that after the changes are done.

  -- Daniel

[1] https://www.spinics.net/lists/netdev/msg644762.html


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
