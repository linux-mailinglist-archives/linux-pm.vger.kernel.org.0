Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC2D10767D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVRfx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 12:35:53 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:62865 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRfx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 12:35:53 -0500
Received: from hp-x360n.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47KNr6333Vz1G1Z;
        Fri, 22 Nov 2019 12:35:50 -0500 (EST)
Date:   Fri, 22 Nov 2019 09:35:49 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911220929540.24730@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com> <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 22 Nov 2019, Rafael J. Wysocki wrote:

> > > > - Randomly, if left suspended, nothing other than a hard power off will get
> > > >   it back  ...  It appears "ec_no_wakeup=1" doesn't have this issue

> BTW, is the ec_no_wakeup=1 workaround still effective?

I'm pretty sure that's always effective, but:

> If so, does the lid and/or power button wake up the system from
> suspend with ec_no_wakeup=1?

No, hitting a key on the keyboard is the only thing that wakes it up. This
actually isn't a bad thing for me at all- but as per my previous E-mail I'm
trying to determine the cause for the occasional much higher suspended idle
draw and I was thinking using these workarounds means I'm not taking advantage
of all the suspend optimisations you've added.

That being said, I do have "XHC" disabled as a wakeup source (written to
/proc/acpi/wakeup) else BT mouse movement would wake this thing up.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
