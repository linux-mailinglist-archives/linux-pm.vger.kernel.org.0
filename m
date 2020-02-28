Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7320B17340A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgB1Jbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 04:31:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54195 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgB1Jbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 04:31:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id f15so2432829wml.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MHeQm6U+o0608Xi2QEDKzTbxNSKLm6MuqMAztV8dmJM=;
        b=jE67j5ccRqZv9eK3iRUZLVykttz9c5sI8MK/YsOKN3jPVJFZJhmO4HrvBYpDo76iM7
         B5NhRsZHEeYebBhF7xDDNPfgZHWdQJFJeZyZlL+CrAtLT35iy5E0m46pahcfydTs03Tc
         fsyLquzsE28rqLEUzgEECrvaySmdEb04RpbPt3DeB3FtQCzTdBS1Ve09Ja7U+XTXmDEl
         3p0THzcCVczmCnPGDFHeqYSQXxkgcYKIDaFJpef3jx9PlM3jZIwXL3fR/uZ3MWisT0pk
         cR9t/lYOussthGdnFjc9OnagjXXsLew9M6zM5HO15RX2Jknpkma5/9RJYyqFSScmftRi
         ty0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MHeQm6U+o0608Xi2QEDKzTbxNSKLm6MuqMAztV8dmJM=;
        b=e3OZC+dDzogDE2VP7hrHDbNkD5N4tIMaTLBvzUM6lLNEUm9Rc8cQXjbmavQC50W+iH
         FxzUwulKg6+EkAtavr9q132GKA43aHlC8gINaTD8AoJFlM6hFrYHOtiCN5IlRsMdDQHB
         TkWgmU2cD2fED8N0fFdQkRZek0yWFcWgYy1/JQWs69CSNMOA7/IKCDFSiNDAMi4xQ0pg
         1s3DZv/idKrQ0fbtLRii/IYpsW0SLo1nUkBWWynjNwCo8HUNC/B6nsAJvOs9CE+JjnU+
         t1hGj6RD209nkD6437WGjdpspiDRtsyYUnzKGhkzZFEkf3WXBRC9WLlRSU9EVmnsKFIy
         XhoQ==
X-Gm-Message-State: APjAAAWLzr4z5k63CQDTYcvD5qeH+q+n/iCPNI4/A3qEtkVSC/prOfwv
        O5FiOrwYyz8KNXx2Gltboxf8zA==
X-Google-Smtp-Source: APXvYqyF4k/gTiOodnjjGmlgUAFqePXdEZSWAR3mecnKr9zQIIfkcdyGRMU46SrUVXmpQYryG154Sw==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3921747wmc.18.1582882288774;
        Fri, 28 Feb 2020 01:31:28 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9002:9a61:c019:3c99? ([2a01:e34:ed2f:f020:9002:9a61:c019:3c99])
        by smtp.googlemail.com with ESMTPSA id q125sm1409867wme.19.2020.02.28.01.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 01:31:28 -0800 (PST)
Subject: Re: [PATCH RESEND 2/4] thermal: imx8mm: Add support for i.MX8MM
 thermal monitoring unit
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1582186646-22096-1-git-send-email-Anson.Huang@nxp.com>
 <1582186646-22096-2-git-send-email-Anson.Huang@nxp.com>
 <f8dfdb39-14e5-4ee2-927a-fecbcd66c71e@linaro.org>
 <DB3PR0402MB39163AE75E59613AB6B21575F5E80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <07994b0e-9735-2f3e-e5c3-a57e2344dbc0@linaro.org>
Date:   Fri, 28 Feb 2020 10:31:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39163AE75E59613AB6B21575F5E80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/02/2020 02:12, Anson Huang wrote:
> Hi, Daniel

[ ... ]

>>> +static int tmu_get_temp(void *data, int *temp) {
>>> +	struct imx8mm_tmu *tmu = data;
>>> +	u32 val;
>>> +
>>> +	/* the temp sensor need about 1ms to finish the measurement */
>>> +	usleep_range(1000, 2000);
>>
>> Why do yo need to force a delay here? If the sensor can not be read more
>> than one time every 1ms, then specify that in the DT switching the polling to
>> the right value, no?
> 
> The polling time(2 seconds) is OK for this case, adding this sleep is to prevent user from reading
> temperature from sysfs interface very frequently like less than 1ms, does it make sense? 

Not really, well except if the user is able to press the keys in less
than 1ms :)

If the userspace writes a polling script reading the temperature in a
busy loop, there is nothing we can do against silly programming :/

However, it could interesting to add a <min polling interval> in the
thermal structure and handle that from the core framework by caching the
last value and return it in case get_temp is called too fast.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

