Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0191825B6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 00:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgCKXQx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 19:16:53 -0400
Received: from mail.manjaro.org ([176.9.38.148]:58946 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731338AbgCKXQx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 19:16:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 0C1C937024CE;
        Thu, 12 Mar 2020 00:16:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rHUPSS9K2eTQ; Thu, 12 Mar 2020 00:16:48 +0100 (CET)
Subject: Re: [PATCH v3 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311093043.3636807-1-t.schramm@manjaro.org>
 <20200311093043.3636807-3-t.schramm@manjaro.org>
 <20200311172056.wjn3574zrfqxipw6@holly.lan>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <bd1bea1c-e42b-8ccc-7fbb-2ed268f1b1a5@manjaro.org>
Date:   Thu, 12 Mar 2020 00:17:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200311172056.wjn3574zrfqxipw6@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

thanks for reviewing. The typo will be fixed for v4.

>> +  power-supplies:
>> +    description:
>> +      Specifies supplies used for charging the battery connected to this gauge
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
>> +      - minItems: 1
>> +        maxItems: 8 # Should be enough
> 
> Is it necessary to set a maximum? power_supply.txt is still a text file
> but there is no mention of a maximum there.
> 
I think so? Removing maxItems and running dtbs_check on a dts with more
than one supply phandle in the power-supplies property results in an error:
linux/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dt.yaml:
cw2015@62: power-supplies: [[142], [50]] is too long

Best Regards,

Tobias
