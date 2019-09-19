Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272A8B7F3C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbfISQf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 12:35:29 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:61840 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403838AbfISQf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 12:35:29 -0400
Received: from hp-x360n (unknown [12.245.190.214])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46Z2X010BHzpgF;
        Thu, 19 Sep 2019 12:35:27 -0400 (EDT)
Date:   Thu, 19 Sep 2019 09:35:27 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me help you debug what seems to be an EC resume issue
In-Reply-To: <alpine.DEB.2.21.1909190909440.2973@hp-x360n>
Message-ID: <alpine.DEB.2.21.1909190930190.2842@hp-x360n>
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com> <alpine.DEB.2.21.1909190444190.2973@hp-x360n> <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
 <alpine.DEB.2.21.1909190909440.2973@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> BTW, is there any way to determine which devices are still on (out of d3cold)
> at the time the kernel relinquishes control to the BIOS/ACPI as the last thing
> to happen at suspend?

So I turned on "DEBUG" at the top of ".../include/linux/acpi.h"
I have no idea if I'm reading this correctly, but does this mean that there are
devices that will always(?) stay in d3hot during s2idle?

If this is the case, is there anything I can/should do about it?

----
[  +0.000249] ACPI: \_SB_.PEPD: _DSM function mask: 0x7f
[  +0.007429] ACPI: \_SB_.PEPD: _DSM function 1 eval successful
[  +0.000003] ACPI: \_SB_.PEPD: LPI: constraints list begin:
[  +0.000002] ACPI: \_SB_.PEPD: index:0 Name:\_SB.PR00
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:1 Name:\_SB.PR01
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:2 Name:\_SB.PR02
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:3 Name:\_SB.PR03
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:4 Name:\_SB.PR04
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:5 Name:\_SB.PR05
[  +0.000001] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000003] ACPI: \_SB_.PEPD: index:6 Name:\_SB.PR06
[  +0.000001] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:7 Name:\_SB.PR07
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000003] ACPI: \_SB_.PEPD: index:8 Name:\_SB.PCI0.GFX0
[  +0.000001] ACPI: \_SB_.PEPD: uid:255 min_dstate:D3hot
[  +0.000004] ACPI: \_SB_.PEPD: index:12 Name:\_SB.PCI0.I2C0
[  +0.000001] ACPI: \_SB_.PEPD: uid:255 min_dstate:D3hot
[  +0.000003] ACPI: \_SB_.PEPD: index:13 Name:\_SB.PCI0.I2C1
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D3hot
[  +0.000002] ACPI: \_SB_.PEPD: index:14 Name:\_SB.PCI0.XHC
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D3hot
[  +0.000002] ACPI: \_SB_.PEPD: index:15 Name:\_SB.PCI0.HDAS
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000003] ACPI: \_SB_.PEPD: index:37 Name:\_SB.PCI0.RP13.PXSX
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000002] ACPI: \_SB_.PEPD: index:55 Name:\_SB.PCI0.CNVW
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D3hot
[  +0.000003] ACPI: \_SB_.PEPD: index:57 Name:\_SB.PCI0.HECI
[  +0.000002] ACPI: \_SB_.PEPD: uid:255 min_dstate:D0
[  +0.000001] ACPI: \_SB_.PEPD: LPI: constraints list end
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
