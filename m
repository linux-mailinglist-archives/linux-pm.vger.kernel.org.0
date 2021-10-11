Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44C42862A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 07:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhJKFT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 01:19:28 -0400
Received: from marcansoft.com ([212.63.210.85]:56662 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231966AbhJKFT1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Oct 2021 01:19:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 215C3425D6;
        Mon, 11 Oct 2021 05:17:21 +0000 (UTC)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
 <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
 <f95f6d61-8809-e668-0458-453a8dfbe641@marcan.st>
 <b5b25e17-d98b-d447-f917-4d728f52a6ff@marcan.st>
 <CAJKOXPfp7oMJ+moizqgXyS7LbPajY-_vbXFX6+5PFrcpUFy2nA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
Message-ID: <2a1aaec7-25e6-f779-fd18-23378537bbd2@marcan.st>
Date:   Mon, 11 Oct 2021 14:17:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfp7oMJ+moizqgXyS7LbPajY-_vbXFX6+5PFrcpUFy2nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/10/2021 16.50, Krzysztof Kozlowski wrote:
> On Wed, 6 Oct 2021 at 17:56, Hector Martin <marcan@marcan.st> wrote:
>> Addendum: just found some prior art for this. See power/pd-samsung.yaml,
>> which is another single-PD binding (though in that case they put them in
>> the SoC node directly, not under a syscon).
> 
> Maybe the design is actually similar. In the Exynos there is a entire
> subblock managing power - called Power Management Unit (PMU). It
> controls most of power-related parts, except clock gating. For example
> it covers registers related to entering deep-sleep modes or power
> domains. However we split this into two:
> 1. Actual PMU driver which controls system-level power (and provides
> syscon for other drivers needing to poke its registers... eh, life).
> 2. Power domain driver which binds multiple devices to a small address
> spaces (three registers) inside PMU address space.
> 
> The address spaces above overlap, so the (1) PMU driver takes for
> example 1004_0000 - 1004_5000 and power domain devices bind to e.g.
> 1004_4000, 1004_4020, 1004_4040.

It's similar, except Apple tends to group registers into uniform arrays, 
sometimes with gaps. They definitely do some ugly overlap stuff in their 
devicetree/OS which we'll try to avoid (e.g. the audio driver directly 
poking clock select registers...).

Here's an incomplete memory map of the PMGR-related stuff in this SoC:

2_3b00_0000:  Clocking
      0_0000:   PLLs
      4_0000:   Clock selects / dividers
         000:    86 selects x 32bit (device clocks)
         200:    8 selects x 32bit (aux clocks)
         280:    2 selects x 32bit
      4_4000:   NCOs (used for audio) (5 x one 16KiB page each)
2_3b70_0000:  PMGR
      0_0000:   Pwr-state registers
        0000:    10 controls x 64bit  (CPUs)
        0100:    143 controls x 64bit (general devices)
        0c00:    2 controls x 64bit   (SEP)
        4000:    13 controls x 64bit  (ISP)
        8000:    5 controls x 64bit   (VENC)
        c000:    7 controls x 64bit   (ANE)
      1_0000:    10 controls x 64bit  (DISP0)
      1_c000:   Power gates
          10:    74 power gates (24 bytes each?)
      3_4100:   Performance counters? (16 bytes each, big array)
      5_4000:   Secondary CPU spin-up controls

I believe the weird groupings into page-sized areas have to do with 
security, so they can map only those ranges to certain coprocessors and 
the like via the IOMMUs.

There is also a MiniPMGR that uses the same register formats, but 
different counts/offsets, at 2_3d28_0000 (this one stays up in sleep 
mode, AIUI)

So I think we won't need any overlaps, since e.g. the whole 00000-14000 
subrange is all power state controls, so a driver doing system-level 
stuff wouldn't have to care about those. Those would just be bound by 
the syscon in this patchset. I chose to use a syscon to avoid having raw 
ioremaps for each domain instance, since each one of those eats up a 
whole page of mapping AIUI (and shows up in /proc/iomem individually).

One question is whether if we need to poke at power gates directly 
(which isn't clear right now), we should have a separate top-level 
pmgr-pwrgate syscon as a parent, or just instantiate power gate subnodes 
under the same pmgr syscon at 1c000.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
