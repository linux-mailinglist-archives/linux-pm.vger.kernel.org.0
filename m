Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE362C2C03
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbgKXPxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 10:53:06 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38315 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389842AbgKXPxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 10:53:04 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E0D1760003;
        Tue, 24 Nov 2020 15:53:00 +0000 (UTC)
Message-ID: <56726c3591feb0a61dd2bf8ffa5dc218af46cbab.camel@hadess.net>
Subject: Re: How to enable auto-suspend by default
From:   Bastien Nocera <hadess@hadess.net>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Date:   Tue, 24 Nov 2020 16:53:00 +0100
In-Reply-To: <ecd964af-efdb-99c6-45cb-4979397fb324@linux.intel.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
         <X6p6ubTOoMPUPPXi@kroah.com>
         <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
         <20201110172517.GC2495@lahna.fi.intel.com>
         <30957f1a-1fe5-5d9a-101b-25f12fb93907@redhat.com>
         <20201111143143.GV2495@lahna.fi.intel.com>
         <30aa8c96-1809-8c5f-2305-5e39fbeba434@redhat.com>
         <ecd964af-efdb-99c6-45cb-4979397fb324@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-11-24 at 14:37 +0200, Mathias Nyman wrote:
> <snip>
> I don't think we are ready to enable runtime pm as default for all
> Intel xHCI controllers.
> The risk of xHCI not waking up when user plugs a mouse/keyboard,
> making the system unusable
> just seems too high compared to the powersaving benefit.
> 
> The powersaving benefit from autosuspending the TCSS xHCI is a lot
> better, and we, (Mika mostly)
> has been able to verify they work.
> 
> So I propose we for now continue adding TCSS xHCI controllers to the
> allowlist in kernel.
> For others I think a userspace allow/denylist makes sense.
> 
> Long term goal would be default allow for all, with short denylist in
> kernel.

Is there any way to preemptively enable autosuspend for all the _TCSS_
xHCI controllers?

This was the problem the original post tried to tease out, whether it
would be easier/better to enable autosuspend by default, and not enable
it on systems where it breaks something, rather than default to sucking
battery until somebody notices that a device ID got missed.

