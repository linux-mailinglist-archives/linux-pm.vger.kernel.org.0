Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCE3C2AD4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 23:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGIVb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 17:31:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B62C0613DD;
        Fri,  9 Jul 2021 14:29:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u25so10181531ljj.11;
        Fri, 09 Jul 2021 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n0pfSYVBqfYvbhafERT7C/3uYLaoAC4+eDT96OIhYTg=;
        b=Myw6i+pThWV7QbfFuFJeUBZKzaOoiw/AVYZOVNSJIptvdX8HGgYwhhD32SLd04xPYH
         +dd1uFoTovo8kAWX6AczxwKEunKaiH/6a7U/ks2rWAiVs2KsU1V5hnh9Vi1/tQeazDO/
         aqYgoCR31S706J17XFvi0sP4AkuaA7H51g02zf0iekw4WG7CEx4mFNBB1susFUj3r5pd
         3RWuyQd4CNN7yIj3lJTA+4AWkckjo2PfA/O30XGjKhVvHg8qVeUNZkmdSDJfSt3kuw3+
         oDhhoAzEF0WZiX5VwNuW1dEvyetWZgwHymIRkSmplONc7NPDtd2t9hYAgLoRklJSHdfb
         3xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0pfSYVBqfYvbhafERT7C/3uYLaoAC4+eDT96OIhYTg=;
        b=UcQQUD7ARXTP9Q2prJFaC6ebR4RM1Ko0154+tVHaBApwnZB+WUOcL8xDnZf95K9uEk
         2UDOpbQ9IQR5Jj1PGeXpOmhuguiZnS+kO0x+IbYeYoXE4zfgFrQBgCi4TagNFs+KdV0a
         b8nfpSdWDlb8F3s1xZ6WSDRbnqDUXqsv+osQd5mziVmRVnsatNmH89qOl8GgjU+Eak5P
         LwKPhIk82p0f5lXmboQydbQc9rCBmI5gC37KAvLxUOD1iBSU5K2lRLCWE9+5b2YfF3zT
         7gfakEjVJvjbBQ7EpFevh8i6Rm70eb4d8q+TI21vLnHDGQ1m/ciEcQIv6g1rlsuswC4v
         E5EQ==
X-Gm-Message-State: AOAM532W+YIArig4NDqD8kggxEJQWsobxnQfFEqS21qe23U8iTovcgCQ
        9B7H3iJ9VpY+u/H54llBwDwy3bXSSDM=
X-Google-Smtp-Source: ABdhPJxj10EO1lGxzlIT3gS6U3RVrU1QxVlIxaqXNWaph5WsP/B+oQU0p2z+yYdDlzmLcMuY2ic3nw==
X-Received: by 2002:a2e:9884:: with SMTP id b4mr31093656ljj.242.1625866152311;
        Fri, 09 Jul 2021 14:29:12 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id v16sm686726ljn.93.2021.07.09.14.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:29:11 -0700 (PDT)
Subject: Re: [PATCH v1 04/12] usb: phy: tegra: Support OTG mode programming
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210701022405.10817-1-digetx@gmail.com>
 <20210701022405.10817-5-digetx@gmail.com>
 <12f5b8cc-982e-f112-e0a4-21afdf3bce06@gmail.com>
 <YOd9GE7xM150i1XT@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2fbfc146-a563-fc58-19d2-fc1f43381fa6@gmail.com>
Date:   Sat, 10 Jul 2021 00:29:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOd9GE7xM150i1XT@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.07.2021 01:32, Michał Mirosław пишет:
> On Thu, Jul 01, 2021 at 04:55:03PM +0300, Dmitry Osipenko wrote:
>> 01.07.2021 05:23, Dmitry Osipenko пишет:
>>>  static int tegra_usb_phy_init(struct usb_phy *u_phy)
>>> @@ -967,12 +1057,26 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
>>>  			goto disable_vbus;
>>>  	}
>>>  
>>> +	err = tegra_usb_phy_configure_pmc(phy);
>>> +	if (err)
>>> +		goto close_phy;
>>> +
>>>  	err = tegra_usb_phy_power_on(phy);
>>>  	if (err)
>>>  		goto close_phy;
>>>  
>>> +	if (phy->irq > 0) {
>>> +		err = request_irq(phy->irq, tegra_usb_phy_isr, IRQF_SHARED,
>>> +				  dev_name(phy->u_phy.dev), phy);
>>> +		if (err)
>>> +			goto pwr_off_phy;
>>> +	}
>>
>> There were reports that this patch was casing an unhandled USB interrupt
>> event on some devices. I thought this problem was fixed already, but
>> looking again at the offending kernel log again, it still should be a
>> problem.
>>
>> The interrupt fires from the usb_add_hcd() of the CI driver before CI
>> driver have requested interrupt in ci_hdrc_probe(). So either CI driver
>> should request interrupt earlier or Tegra PHY driver should keep shared
>> interrupt disabled after requesting it, the latter variant should be
>> more robust. I'll improve it in v2.
> 
> I'd suggest the first solution, as the latter is a workaround for what
> is a normal shared interrupt behaviour. Maybe a controller reset is
> needed in CI driver before going on with PHY init?

I already implemented the second solution. The controller reset should
be okay. We could improve it all later on if will ever be needed, so far
it's unnecessary. I can't really work on improving the CI interrupt
because it requires to have a special testing setup to reproduce the
problem and I don't have that setup.
