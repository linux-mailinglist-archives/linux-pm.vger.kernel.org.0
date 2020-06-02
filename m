Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8401EB8CB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFBJtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 05:49:13 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:39654 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBJtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 05:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591091352; x=1622627352;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=XYWvcTMnu5gYjXeMs5ChljnhBkkNboMpnYYArlKHA2Y=;
  b=WoDUn//rTpWgTuD+HxRRkDzKDOV3Xp69/yl+MDI9lQFz2tvBYpthWNMT
   9WEddTAzz5Grr4DZDqaJPTa6zvwG/uqqI1QMjKMw54oSdehVunlUhrBW9
   XREu++t50pZBVWl2MgMjr9hncSaaCXYEYr8jqMFp3qqZz59nXifN3+k32
   lvCrE1WObAca/SPQHnAHS4vZlAM6TP7TEUzSpisnegZy0hfSJOvxC+EqO
   ghtoAFBG+vFtr2y5CtV7zL82Jfmg0apLEG1LLLKVmsdt7OvTlQVzDMSey
   uICZr+ubPEMUJk06YN5bgBmKSKIuNx9Kj1DSsqgLoRt/VN+UmaJGlhifu
   g==;
IronPort-SDR: vkMrKR4DTnFoAhQgn4Xj1OqpqZBjuz9tFOz8GKffkGjDmng3TRtTay4RgFkq7ULrjECwGmLp2m
 MdaD91OpomcTxZoazsPtP8rBvk1J/QPwvHPriOj4gjHo6X3yW+V7odKuskYGG/vk5coh3y+k4v
 5vkWGsKDTL2niv/nkykeYnFTG4jIV0YXk4WAsd2uVrVbQ89uuxfPhB3A8oxGLQzsiG5teIAGDZ
 GxjzyHPPXkMhugow9mwMqubhKeLm9tfEeYLqLs8YPwhZ3VbI/aLrVZOqNwif5U3PoYtoSP0QBS
 LIk=
X-IronPort-AV: E=Sophos;i="5.73,463,1583218800"; 
   d="scan'208";a="78594449"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2020 02:49:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 02:49:12 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jun 2020 02:49:09 -0700
References: <20200513130842.24847-1-lars.povlsen@microchip.com> <20200513130842.24847-4-lars.povlsen@microchip.com> <20200528022502.GA3234572@bogus>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] dt-bindings: reset: ocelot: Add documentation for 'microchip,reset-switch-core' property
In-Reply-To: <20200528022502.GA3234572@bogus>
Date:   Tue, 2 Jun 2020 11:49:08 +0200
Message-ID: <87wo4piyqz.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Rob Herring writes:

> On Wed, May 13, 2020 at 03:08:40PM +0200, Lars Povlsen wrote:
>> This documents the 'microchip,reset-switch-core' property in the
>> ocelot-reset driver.
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> index 4d530d8154848..20fff03753ad2 100644
>> --- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> @@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
>>  Required Properties:
>>   - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"
>>
>> +Optional properties:
>> +- microchip,reset-switch-core : Perform a switch core reset at the
>> +  time of driver load. This is may be used to initialize the switch
>> +  core to a known state (before other drivers are loaded).
>
> How do you know when other drivers are loaded? This could be a module
> perhaps. Doesn't seem like something that belongs in DT.
>

The reset driver is loaded at postcore_initcall() time, which ensures it
is loaded before other drivers using the switch core. I noticed other
drivers do the same to do low-level system reset and initialization at
early boot time.

> Can this behavior be implied with "microchip,sparx5-chip-reset"?

Since we need to cater for both modus operandi, I would need two driver
compatible strings per platform, which scales worse than a single
property.

The "microchip,reset-switch-core" is a device configuration property
which tells the system (driver) how the hw should be handled. Since you
do not *always* want to reset the switch core (f.ex. when implementing
systems with warm reboot), I think it makes perfect sense - but I may be
biased off course :-)

Thank you for (all) of your comments, by the way!

---Lars

>
> Rob

-- 
Lars Povlsen,
Microchip
