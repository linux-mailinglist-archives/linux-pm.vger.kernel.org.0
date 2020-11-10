Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409E72AD447
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJLB0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 06:01:26 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:46164 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgKJLB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 06:01:26 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0EFFE3B63DD;
        Tue, 10 Nov 2020 10:57:32 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6DCC2C0004;
        Tue, 10 Nov 2020 10:57:08 +0000 (UTC)
Message-ID: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
Subject: How to enable auto-suspend by default
From:   Bastien Nocera <hadess@hadess.net>
To:     Linux PM <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Date:   Tue, 10 Nov 2020 11:57:07 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

systemd has been shipping this script to enable auto-suspend on a
number of USB and PCI devices:
https://github.com/systemd/systemd/blob/master/tools/chromiumos/gen_autosuspend_rules.py

The problem here is twofold. First, the list of devices is updated from
ChromeOS, and the original list obviously won't be updated by ChromeOS
developers unless a device listed exists in a ChromeBook computer,
which means a number of devices that do support autosuspend aren't
listed.

The other problem is that this list needs to exist at all, and that it
doesn't seem possible for device driver developers (at various levels
of the stack) to opt-in to auto-suspend when all the variants of the
device (or at least detectable ones) support auto-suspend.

So the question is: how can we make it easier for device drivers to
implicitly allow autosuspend *unless they opt-out*, especially for
frameworks where the device's transport layer isn't directly available
(eg. HID devices)?

If that can't be done in the kernel drivers directly, would it be
possible for the kernel to ship with a somewhat canonical list that
systemd (or its replacement on other "Linuxes") could use to generate
those user-space quirks?

Ideally, for example, all new "iwlwifi" or all tested "iwlwifi" devices
should have autosuspend enabled by the developers adding support for
them, as in the script above, rather than downstreams (systemd upstream
included) having to chase new PCI IDs.

Cheers

