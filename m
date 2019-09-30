Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7825BC28BC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfI3VXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 17:23:34 -0400
Received: from marmot.wormnet.eu ([188.246.204.87]:42046 "EHLO
        marmot.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3VXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 17:23:33 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 17:23:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lentin.co.uk; s=budgerigar; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wwO3LKMH46pvv0bC8x8eV217XsJBNp2LC9T/6N0lajk=; b=SPTGolhEBz8cT6g6z06+BIWKo
        s5GIK38N9GfBmNBfGFXPuuHBKRonTencUPiNWCQeZXIQtNcFcnQwPpoGcxa2ByNfUzSCO0jPnilmj
        2xoeIKa0bg5jEuljsq/C7QOLv2x9y7fcdLcopucWoexdaLaAT7ZeO0AwLTCu4hqjgaDLs=;
Received: from [31.146.104.22] (helo=[192.168.0.100])
        by marmot.wormnet.eu with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <jm@lentin.co.uk>)
        id 1iF1ZW-0006jM-GN; Mon, 30 Sep 2019 20:43:02 +0100
Date:   Mon, 30 Sep 2019 20:42:53 +0100 (BST)
From:   Jamie Lentin <jm@lentin.co.uk>
X-X-Sender: lentinj@clifford.vandergast.wormnet.eu
To:     Andrew Lunn <andrew@lunn.ch>
cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] This patch introduces a feature to force gpio-poweroff
 module
In-Reply-To: <20190930163203.GC15343@lunn.ch>
Message-ID: <alpine.DEB.2.21.1909301909360.6576@clifford.vandergast.wormnet.eu>
References: <20190930103531.13764-1-oleksandr.suvorov@toradex.com> <20190930121440.GC13301@lunn.ch> <CAGgjyvEx_F0C2XHDGxf3F0Z8iHF1vQZkoPft3_ZbTswVFv=SJA@mail.gmail.com> <20190930163203.GC15343@lunn.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Sep 2019, Andrew Lunn wrote:

> On Mon, Sep 30, 2019 at 02:11:59PM +0000, Oleksandr Suvorov wrote:
>> Hi Andrew,
>>
>> On Mon, Sep 30, 2019 at 3:16 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>
>>> On Mon, Sep 30, 2019 at 10:35:36AM +0000, Oleksandr Suvorov wrote:
>>>> to register its own pm_power_off handler even if someone has registered
>>>> this handler earlier.
>>>> Useful to change a way to power off the system using DT files.
>>>
>>> Hi Oleksandr
>>>
>>> I'm not sure this is a good idea. What happens when there are two
>>> drivers using forced mode? You then get which ever is register last.
>>> Non deterministic behaviour.
>>
>> You're right, we have to handle a case when gpio-poweroff fails to
>> power the system off. Please look at the
>> 2nd version of the patchset.
>>
>> There are 3 only drivers that forcibly register its own pm_power_off
>> handler even if it has been registered before.
>>
>> drivers/firmware/efi/reboot.c - supports chained call of next
>> pm_power_off handler if its own handler fails.
>>
>> arch/x86/platform/iris/iris.c, drivers/char/ipmi/ipmi_poweroff.c -
>> don't support calling of next pm_power_off handler.
>> Looks like these drivers should be fixed too.
>>
>> All other drivers don't change already initialized pm_power_off handler.
>>
>>> What is the other driver which is causing you problems? How is it
>>> getting probed? DT?
>>
>> There are several PMUs, RTCs, watchdogs that register their own pm_power_off.
>> Most of them, probably not all, are probed from DT.
>
> And which specific one is causing you problems.
>
> I don't like this forced parameter. No other driver is using it.
>
> Maybe we should change this driver to support chained pm_power_off
> handlers?

There's still scope for non-deterministic behaviour though, as the 
chaining would take place depending on the probe ordering. Admittedly if 
the gpio-poweroff works it's unlikely to be a problem, but still seems 
messy.

Without knowing specifics, disabling the devices that can't turn the 
device off seems like a better bet. If they'd be otherwise useful, I see 
there's a of_device_is_system_power_controller(), see:

/Documentation/devicetree/bindings/power/power-controller.txt
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/max77620.c#L566

...maybe that can be added to the devices getting in the way?

Cheers,

[0] https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/bcm2835_wdt.c#L152
(chosen at random)


>
>   Andrew
>

-- 
Jamie Lentin
