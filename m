Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36C025A22
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 23:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfEUVoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 17:44:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfEUVoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 17:44:12 -0400
Received: from oxbaltgw36.schlund.de ([172.19.246.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3UhQ-1hTkmN1yTK-000dQZ; Tue, 21 May 2019 23:43:49 +0200
Date:   Tue, 21 May 2019 23:43:46 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-pm@vger.kernel.org, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        ptesarik@suse.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        mbrugger@suse.de, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ssuloev@orpaltech.com
Message-ID: <1599901940.259900.1558475026379@email.ionos.de>
In-Reply-To: <a142b72b828a798610d885d81189dd21b1870d78.camel@suse.de>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-4-nsaenzjulienne@suse.de>
 <ebc78880-418f-f507-021c-41295113e041@i2se.com>
 <6383b357-3f7e-f031-f59f-61c598e44763@i2se.com>
 <a142b72b828a798610d885d81189dd21b1870d78.camel@suse.de>
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update
 pllb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev55
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Isy5OlYsYGu9nrdhnWYleYJBAsXAYF+kjVDhfkkBJjpqzq5ZCJ8
 wBrxVrIo4++MiWGXASEOqxb4cpbPuhfyfcpg6XJSh/BMfGi9o7z1fQ0Khes7Q8QfhAon+iu
 Ph83K39Jzsa5+H1HvaMbZwfikr4aq0l8KiaHIfpCPI89Hw0fan5EAleIIX9/KTIpjv3F0xR
 FCPtxd9TpiKaJ0UONo/RA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nY8tA70RVBM=:mOsfgkfjoAIx80KhU342a4
 yiIrkI7pWZ99A/mCEoZVH+0C1zJXeM6uoYYhGJL/sfzZ7y4GMmdrn4Ziqsp9VnDV9PqPnBK9e
 NCeT5AAIqT/jjszs8m5KyTcEaCw5gsYVlG1g/ghx60arMlkVkvQXFvSk1KW5PIw2OB5ckhfsv
 KMDOIy9RwM5XruZnfBjbWQxqfkRRo1xcsG6+V2rAu1plD+yIXDZnS+eE7qBI7eedU1FR605eZ
 4Zh72Z21kH7qhvv1TDKzV2wdka9dwqZ0OE5ApKjURmgSmLmbpPxBCqSYokQaaW8hZumhdaFro
 jljEXtF9nm/yaRjMTzkBFXceEfpL5hLRD6y+fd8kXRqazon7pQJYtqc/uU/T6z8dV3w8dMk9L
 u577Sz4xJaLpsHKGXktJJluopiUfX7DZAN41+2AvA+381FNI7KBqbU++3cGOnh58rCfiOem4p
 rPwXFPDjxuhRpfVUFt/dWUjfx7Xe4KGXYH8TA8c6HFckaal0uXfX+Let7872KVAyugzccDPcw
 BS/pwCCxGBTsJUVGUoxS55Pp1znnfuNaI6OLCxjThm3sPnt/dgWDRiaLSmKmYBK/66Sc91ecm
 iYdCy+iz+yCETge8pBVxUWrwwC3DJuCegXJSS2Q6tHFLadvSZj9WSxDeOu2vR2Na7yPXO72hI
 QpJL3EsCKUTKtU/FyqNjV5SUtgMw+Imt5JxEDmvRjB3vq4QfiTLnFUjOqFwaa3I+7pm7/p0Sn
 Rvro3OibNuNCeeNH8n65x7Ag+QRfPDGpGbSX/C1+U9r7gDL/IrLNTF+tbj8=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 21. Mai 2019 um 17:47 geschrieben:
> 
> 
> Hi Stefan, thanks for your comments!
> 
> On Tue, 2019-05-21 at 14:40 +0200, Stefan Wahren wrote:
> > Hi Nicolas,
> > 
> > On 20.05.19 14:11, Stefan Wahren wrote:
> > > Hi Nicolas,
> > > 
> > > the following comments applies only in case Eric is fine with the whole
> > > approach.
> > > 
> > > On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> > > > Raspberry Pi's firmware, which runs in a dedicated processor, keeps
> > > maybe we should clarify that the firmware is running in the VPU
> > > > track of the board's temperature and voltage. It's resposible for
> > > > scaling the CPU frequency whenever it deems the device reached an unsafe
> > > > state. On top of that the firmware provides an interface which allows
> > > > Linux to to query the clock's state or change it's frequency.
> > > I think this requires a separate update of the devicetree binding.
> > > > Being the sole user of the bcm2835 clock driver, this integrates the
> > > > firmware interface into the clock driver and adds a first user: the CPU
> > > > pll, also known as 'pllb'.
> > > Please verify that the kernel still works (and this clock driver probe)
> > > under the following conditions:
> > > 
> > > - CONFIG_RASPBERRYPI_FIRMWARE=n
> > > - CONFIG_RASPBERRYPI_FIRMWARE=m
> > > - older DTBs without patch #1
> > i thought about this and the case this driver would return
> > -EPROBE_DEFER. The clock driver is too essential for doing such a thing.
> > So i think the best solution would be to move these changes into a
> > separate driver which should be register by the clock driver (similiar
> > to vchiq). This also avoid the need of a new device tree binding.
> 
> I understand your concerns.
> 
> Wouldn't you prefer registering the device trough the device tree? I'd go with
> the same approach as the firmware touchscreen driver, which is registered after
> the firmware's probe trough dt's 'simple-bus'. That said, it's not a strongly
> held opinion, I'm happy with whatever solution as long as it works.

A devicetree binding always introduce some kind of inflexibility. In case someone finds a better solution later things can get really messy. A recent example is the clock handling for i2c-bcm2835.

> 
> I get from your comments that you'd like the register based version of 'pllb'
> and 'pllb_arm' to be loaded if for some reason the firmware isn't available. Is
> that right? 

This wasn't my intention. I would prefer a simple approch here (no handover). 

> The main problem I see with this is the duplication of 'pllb' and
> 'pllb_arm'. Both drivers will create the same clock device through different
> interfaces. Any suggestions on how to deal with that? If not I can simply
> remove 'pllb' and 'pllb_arm' from clk-bcm2835.c.

Yes. So even if this driver is disabled, there shouldn't be a regression. Or did i miss something?

> 
> Regards,
> Nicolas
>
