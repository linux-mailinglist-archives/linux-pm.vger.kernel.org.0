Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE525752B
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgHaITp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 04:19:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:40732 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaITo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 04:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598861982; x=1630397982;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=/OVoMxK7QR8HMDkkjaY5EKtHvjhOjzN5H7hhNs/BFQE=;
  b=GIz/1vnUEp6LljLl/kb5LRe9/XMxr+K3c5zPsz8g1c6C3gxYixSR2wMB
   Ln41ZwaixhHIsIVUCNQrLOqJIlrKwpuPMQP6BTTgkb+nIidhwt16bYDWG
   qd6t6W/PsGrfGgyzI0b6aIk8likETE7iMhcHOB6k3u81fLEArAeo7KJy4
   moGhyIAHlRdcq6p4fpwNzy0nD8HQLMb+SXb/2d+Gfvgshc7TVeZo+vzeI
   N6HjCoqzC8XONSZacYvZf1LoEsxEmclAc4MqQsYv1pjpmqj22GwbCeyJI
   fhSIbw0BtIPnOGLZZo4b7czvYP1KaxR1BbXvzHgGNByz9nZjPuOAXlJ3U
   A==;
IronPort-SDR: d1h+Beaw30NanlIjjvjgxr1QKYq+SI4swHZsYINTj/zflUsOTmbbZlXjdMCqlvcjI6eplY6JNI
 0AXkI7I4GAHcQFuvYgWD84Kt9o0sI18hPkqjuCVTIbmUSYB9MRUM4NBqVRapR2InjXwXRRRAq+
 Kap57G/NT0nsIcTRMi+J07r44oGIhJaYeIl7RtGjl8r16mbVOYyOIWKfZHqeIV2LXq/hpZUQH0
 PtzbImtIkHJU2fh1c4gxkl62mgpNdJ8yldiSSdIFvRBldtM451WvKqZqXpUAcBDlnEIeZUoPWx
 8bQ=
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="93715065"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2020 01:19:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 31 Aug 2020 01:19:40 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 01:19:23 -0700
References: <20200513130842.24847-1-lars.povlsen@microchip.com> <20200513130842.24847-4-lars.povlsen@microchip.com> <20200528022502.GA3234572@bogus> <87wo4piyqz.fsf@soft-dev15.microsemi.net> <20200828163916.g6vbk3anfyijl7sx@earth.universe>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] dt-bindings: reset: ocelot: Add documentation for 'microchip,reset-switch-core' property
In-Reply-To: <20200828163916.g6vbk3anfyijl7sx@earth.universe>
Date:   Mon, 31 Aug 2020 10:19:38 +0200
Message-ID: <871rjnxm5h.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Sebastian Reichel writes:

> Hi,
> 
> On Tue, Jun 02, 2020 at 11:49:08AM +0200, Lars Povlsen wrote:
> > Rob Herring writes:
> > > On Wed, May 13, 2020 at 03:08:40PM +0200, Lars Povlsen wrote:
> > >> This documents the 'microchip,reset-switch-core' property in the
> > >> ocelot-reset driver.
> > >>
> > >> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> > >> ---
> > >>  .../devicetree/bindings/power/reset/ocelot-reset.txt        | 6 ++++++
> > >>  1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-rese=
> t.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> > >> index 4d530d8154848..20fff03753ad2 100644
> > >> --- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> > >> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> > >> @@ -9,9 +9,15 @@ microchip Sparx5 armv8 SoC's.
> > >>  Required Properties:
> > >>   - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-res=
> et"
> > >>
> > >> +Optional properties:
> > >> +- microchip,reset-switch-core : Perform a switch core reset at the
> > >> +  time of driver load. This is may be used to initialize the switch
> > >> +  core to a known state (before other drivers are loaded).
> > >
> > > How do you know when other drivers are loaded? This could be a module
> > > perhaps. Doesn't seem like something that belongs in DT.
> > >
> > 
> > The reset driver is loaded at postcore_initcall() time, which ensures it
> > is loaded before other drivers using the switch core. I noticed other
> > drivers do the same to do low-level system reset and initialization at
> > early boot time.
> > 
> > > Can this behavior be implied with "microchip,sparx5-chip-reset"?
> > 
> > Since we need to cater for both modus operandi, I would need two driver
> > compatible strings per platform, which scales worse than a single
> > property.
> > 
> > The "microchip,reset-switch-core" is a device configuration property
> > which tells the system (driver) how the hw should be handled. Since you
> > do not *always* want to reset the switch core (f.ex. when implementing
> > systems with warm reboot), I think it makes perfect sense - but I may be
> > biased off course :-)
> > 
> > Thank you for (all) of your comments, by the way!
> > 
> > ---Lars
> > > Rob
> 
> Is this series still needed? Did I miss a follow-up?

Hi Sebastian!

Yes, the series is still needed, but the conversation died after my
last message.

If the DT-controlled reset property is too controversial, I am willing
to drop that part. (Rob just reviewed the bindings).

MCHP reference designs have GPIO resets, so we *could* get by without,
but new designs may this feature.

> -- Sebastian

---Lars

-- 
Lars Povlsen,
Microchip
