Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF626BEAE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 10:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIPIA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 04:00:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:27517 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIPIA4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 04:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600243255; x=1631779255;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=ZpeyqbXZZZChQLRdtPf3cky/jQApLEzjYIn40OLlPdY=;
  b=jw0nOBmuJTc3Pn0VA0oA86RSCBfuBekE5dkhObvHLaPOMVFZNyjUWEz2
   JRc620gvTi37ns+FYT87Hluom5uONZMv9/ko9FPiVPc8uh2SxUOfAK/wo
   eX9k/9rlJSRr7sDHr8Gw30l37Z8xTaSkjfnasWDGqBht/JuiCn2KDQmEC
   OnFrQouJgxdi6wX5QfPsLsARIL+dd65YVC4Q8OOtn2hKawKje50ME83Lr
   sEYLQH7vUsQ6J1N//4WuNBFd2KysykirquTKRhJnmOjr75lIRBPXBKhV9
   O55cWQhL7hAbJgQQG5pyseUwrQf24MUSyD8UsbvlEPDmG/gjy3xkP5DyN
   g==;
IronPort-SDR: xg6eAnAVn1jTFp4ys2AO0SVY/sOeqImazYtKMGt10eI/QOQ1ZppPaZ9dYoYGrP2GtzHvyA/GqG
 4gU7FX/87avYrXsXk1QTH2X+wYI42Nq75a27jSMS1a0Mlp4WVjoRncVBm/EnUJcXYHZhk23r+E
 5Gmc3sa7Lgt6lk9Hd8Sn7kI8uU4BtMGZiQYsmIPKAqEyvDV7+TJcCUI5C3vpKclg86GwdZ9cjJ
 VySKltueviMAapWm9cQoy2BNzwRtpKSSlg7J615hPNa/ivY4Jztre35h3XVS46KX7hB6RKvmxK
 LwY=
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="87046701"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 01:00:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 01:00:38 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 16 Sep 2020 01:00:36 -0700
References: <20200513130842.24847-1-lars.povlsen@microchip.com> <20200513130842.24847-4-lars.povlsen@microchip.com> <20200528022502.GA3234572@bogus> <87wo4piyqz.fsf@soft-dev15.microsemi.net> <20200828163916.g6vbk3anfyijl7sx@earth.universe> <871rjnxm5h.fsf@soft-dev15.microsemi.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>,
        "Lars Povlsen" <lars.povlsen@microchip.com>
Subject: Re: [PATCH 3/5] dt-bindings: reset: ocelot: Add documentation for 'microchip,reset-switch-core' property
In-Reply-To: <871rjnxm5h.fsf@soft-dev15.microsemi.net>
Date:   Wed, 16 Sep 2020 10:00:51 +0200
Message-ID: <875z8ei218.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Lars Povlsen writes:

> Sebastian Reichel writes:
>
>> Hi,
>> 
>> On Tue, Jun 02, 2020 at 11:49:08AM +0200, Lars Povlsen wrote:
>> > Rob Herring writes:
>> > > On Wed, May 13, 2020 at 03:08:40PM +0200, Lars Povlsen wrote:
>> > >> This documents the 'microchip,reset-switch-core' property in the
>> > >> ocelot-reset driver.
>> > >>
>> > >> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> > >> ---
>> > >>  .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
>> > >>  1 file changed, 6 insertions(+)
>> > >>
>> > >> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-rese=
>> t.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> > >> index 4d530d8154848..20fff03753ad2 100644
>> > >> --- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> > >> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> > >> @@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
>> > >>  Required Properties:
>> > >>   - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-res=
>> et"
>> > >>
>> > >> +Optional properties:
>> > >> +- microchip,reset-switch-core : Perform a switch core reset at the
>> > >> +  time of driver load. This is may be used to initialize the switch
>> > >> +  core to a known state (before other drivers are loaded).
>> > >
>> > > How do you know when other drivers are loaded? This could be a module
>> > > perhaps. Doesn't seem like something that belongs in DT.
>> > >
>> > 
>> > The reset driver is loaded at postcore_initcall() time, which ensures it
>> > is loaded before other drivers using the switch core. I noticed other
>> > drivers do the same to do low-level system reset and initialization at
>> > early boot time.
>> > 
>> > > Can this behavior be implied with "microchip,sparx5-chip-reset"?
>> > 
>> > Since we need to cater for both modus operandi, I would need two driver
>> > compatible strings per platform, which scales worse than a single
>> > property.
>> > 
>> > The "microchip,reset-switch-core" is a device configuration property
>> > which tells the system (driver) how the hw should be handled. Since you
>> > do not *always* want to reset the switch core (f.ex. when implementing
>> > systems with warm reboot), I think it makes perfect sense - but I may be
>> > biased off course :-)
>> > 
>> > Thank you for (all) of your comments, by the way!
>> > 
>> > ---Lars
>> > > Rob
>> 
>> Is this series still needed? Did I miss a follow-up?
>
> Hi Sebastian!
>
> Yes, the series is still needed, but the conversation died after my
> last message.
>
> If the DT-controlled reset property is too controversial, I am willing
> to drop that part. (Rob just reviewed the bindings).
>
> MCHP reference designs have GPIO resets, so we *could* get by without,
> but new designs may this feature.
>
>> -- Sebastian
>

Sebastian,

Any update on the patches? They're the last part of the original Sparx5
series, so I would love to get them done.

As previously stated, I could remove the "microchip,reset-switch-core"
parts if that's whats what holding it stuck.

---Lars

-- 
Lars Povlsen,
Microchip
