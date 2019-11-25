Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01810949B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 21:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKYUT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 15:19:28 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:38339 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYUT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 15:19:28 -0500
Received: from hp-x360n (50-76-61-131-ip-static.hfc.comcastbusiness.net [50.76.61.131])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MJKT2dtlz1npW;
        Mon, 25 Nov 2019 15:19:24 -0500 (EST)
Date:   Mon, 25 Nov 2019 12:19:23 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <alpine.DEB.2.21.1911251155440.2817@hp-x360n>
Message-ID: <alpine.DEB.2.21.1911251213200.2817@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
 <alpine.DEB.2.21.1911251155440.2817@hp-x360n>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 25 Nov 2019, Kenneth R. Crudup wrote:

> Had to do a long- power-button reset to get it back up again.

Datapoint that may be useful- when I have to do the hard power cycle after
a failed suspend, the ports on this laptop (2x USB-C/Thunderbolt 3) get
totally wedged up- the charging light stays on even if there's nothing
plugged into either port, and USB/TB operation is almost always wedged
up (devices not recognized). I have to use a special key sequence (hold
down F6 and power at the same time for several seconds) to get it unwedged.

The system seems to also think the laptop is charging as well, even with
nothing plugged into either port. It's like something in the ACPI/BIOS
doesn't get "unsuspended" either.

I used to have TB and USB as modules that would get unloaded at suspend to
see if those were related to this issue, but that only seemed to make idle
power draw even higher for some reason.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
