Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF23B9287
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhGAN5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 09:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhGAN5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 09:57:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B3C061762;
        Thu,  1 Jul 2021 06:55:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k10so11912899lfv.13;
        Thu, 01 Jul 2021 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0VL4IXxd5AnZL1Kenx9fq6N8MYqIdB30L/yz2TQItQ8=;
        b=Af5CwAOdB2vCyDpMdR43RknHlmbUBESopoD3qTgU3+XlT9dKUMkFNNi9z21EVTCFh0
         kQcvi+i0NbDIRMdStKIft9x6Zl7VepkmE9uMZhqDLChO11ADD1AN564LS3pO3TtNkQJc
         BiCUq6xfuafu9rZDWbVl4wxdvfAlLVW2z4eZm2teDxQcG1tHRmbbtIV61PItPRK1K5eV
         gsHrpyJcRTIKD4ZC11IQoMfgFA2MN/AeMieluJ3M202LIoLtTCN1LIpKYkQmEovnU/p4
         MEqgqpkHvLnawqp531g3/x27DCq63gOLVJd/LBtwJOb/WgHduApC40iJotBVh2c//yJo
         95xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0VL4IXxd5AnZL1Kenx9fq6N8MYqIdB30L/yz2TQItQ8=;
        b=g5vEZBHk3mjlE2FTpxeS5q1ekObZwOJhL0RdTfB1d7KP70y35Axj43ZTQ1vt6mkUYl
         RM5W59EdTkP0nDQPxVjnuFrei672TCjepUN4NMKdmAV1+qFb7Cb3CSAGb6yyjcFxDq0S
         oUXqEHLHhD1KZbr1Avj+J00NwTmgswI25Xm1mC45xdTYTfr0CelSTPUpw0usEbg1lTmY
         h5C/T3pn3NInjND0X9TBz8DnAF5PqD56OeTKZP2mSoXmb6F20BY6/wyIoYUcc5OnTpsU
         mCYJH5bhZbQ6h3N0jWAMi0T55brRhj87ZJTaYzu/iMuI5JCy513VGQMrBRUq4fZR1Sqs
         5e/Q==
X-Gm-Message-State: AOAM530zsx8F2zuvv1kXw9dyHAfg38y39v70auQFEFnfzlkMla+lXJLZ
        HPXFaqzCJzDCSHXPI1+GBVGzrze2t90=
X-Google-Smtp-Source: ABdhPJzJ7Tg9H51VzbUqiuSbZJdvpdDBjZQ84opVMhpLNLjdh1cOuj+PWDDACLDZVp+3+gc/Gr+e1A==
X-Received: by 2002:a05:6512:1683:: with SMTP id bu3mr33422652lfb.520.1625147704518;
        Thu, 01 Jul 2021 06:55:04 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id k11sm9694ljj.132.2021.07.01.06.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 06:55:03 -0700 (PDT)
Subject: Re: [PATCH v1 04/12] usb: phy: tegra: Support OTG mode programming
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210701022405.10817-1-digetx@gmail.com>
 <20210701022405.10817-5-digetx@gmail.com>
Message-ID: <12f5b8cc-982e-f112-e0a4-21afdf3bce06@gmail.com>
Date:   Thu, 1 Jul 2021 16:55:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210701022405.10817-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.07.2021 05:23, Dmitry Osipenko пишет:
>  static int tegra_usb_phy_init(struct usb_phy *u_phy)
> @@ -967,12 +1057,26 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
>  			goto disable_vbus;
>  	}
>  
> +	err = tegra_usb_phy_configure_pmc(phy);
> +	if (err)
> +		goto close_phy;
> +
>  	err = tegra_usb_phy_power_on(phy);
>  	if (err)
>  		goto close_phy;
>  
> +	if (phy->irq > 0) {
> +		err = request_irq(phy->irq, tegra_usb_phy_isr, IRQF_SHARED,
> +				  dev_name(phy->u_phy.dev), phy);
> +		if (err)
> +			goto pwr_off_phy;
> +	}

There were reports that this patch was casing an unhandled USB interrupt
event on some devices. I thought this problem was fixed already, but
looking again at the offending kernel log again, it still should be a
problem.

The interrupt fires from the usb_add_hcd() of the CI driver before CI
driver have requested interrupt in ci_hdrc_probe(). So either CI driver
should request interrupt earlier or Tegra PHY driver should keep shared
interrupt disabled after requesting it, the latter variant should be
more robust. I'll improve it in v2.
