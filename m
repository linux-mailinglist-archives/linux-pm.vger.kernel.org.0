Return-Path: <linux-pm+bounces-52-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A57F3513
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 18:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FE11F227A7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FCA5B21B;
	Tue, 21 Nov 2023 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 04E5EF4
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:40:32 -0800 (PST)
Received: (qmail 1496106 invoked by uid 1000); 21 Nov 2023 12:40:32 -0500
Date: Tue, 21 Nov 2023 12:40:32 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
  Johan Hedberg <johan.hedberg@gmail.com>,
  Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
  linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
  Hans de Goede <hdegoede@redhat.com>, Mike Jones <mike@mjones.io>,
  Rocky Liao <quic_rjliao@quicinc.com>
Subject: Re: Qualcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
Message-ID: <b6c77dc7-04e6-424c-b3b6-f51f437a1671@rowland.harvard.edu>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
 <22494842-a785-4151-915d-6f3a677d96cb@molgen.mpg.de>
 <1f3cb0cc-4bb0-471f-a785-a5d237cd46a3@rowland.harvard.edu>
 <d63ebc5f-9b72-4457-949b-3e90883bd3c0@molgen.mpg.de>
 <d61ae9a8-2228-4af1-a5f0-912e7763fbd1@rowland.harvard.edu>
 <de236c7d-e265-452a-a60e-b10293a5b944@molgen.mpg.de>
 <41253614-764e-4e95-b052-a46bf5587c29@rowland.harvard.edu>
 <3489df64-0f8f-43e1-a05f-ccb145ff6d59@molgen.mpg.de>
 <fd84c14a-1866-4643-8ce9-0d6da5c4b82e@rowland.harvard.edu>
 <d8fba4f9-f868-4ef3-938b-f202e5bcc4ad@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8fba4f9-f868-4ef3-938b-f202e5bcc4ad@molgen.mpg.de>

On Tue, Nov 21, 2023 at 06:12:30PM +0100, Paul Menzel wrote:
> Dear Alan,
> 
> 
> Thank you for your reply.
> 
> Am 21.11.23 um 17:23 schrieb Alan Stern:
> > > [340560.441957] usb 1-3: finish reset-resume
> > > [340560.570940] usb 1-3: reset full-speed USB device number 2 using xhci_hcd
> > 
> > Those two lines are unexpected.  Why does the device need to be reset?
> > While the btusb module is loaded, does anything show up in
> > /sys/bus/usb/devices/1-3/quirks?
> 
>     $ more /sys/bus/usb/devices/1-3/quirks
>     0x2

Ah.  0x2 is the RESET_RESUME quirk bit.  The fact that it is on explains 
why the device gets reset when it is resumed.

It also explains why the device isn't getting suspended.  The USB core 
will not autosuspend a device that has the RESET_RESUME quirk if its 
driver wants remote-wakeup or does not support reset-resume.  The btusb 
driver is like that.

Apparently the RESET_RESUME quirk bit is set by the btusb driver itself 
(see the btusb_check_needs_reset_resume() routine in btusb.c), based on 
the computing platform rather than on the Bluetooth device.  The 
btusb_needs_reset_resume_table[] contains three entries: Dell OptiPlex 
3060, Dell XPS 9360, and Dell Inspiron 5565.

Since your system is an XPS 9360, it has this problem with suspending 
the onboard Bluetooth device.  The only way the kernel can deal with it 
is to avoid putting the device into runtime suspend while the driver 
module is loaded.

So there's your answer.  If you rebuild the btusb driver after removing 
the XPS 9360 entry from btusb_needs_reset_resume_table[], you should 
find that the device does get runtime suspended.  (But then it might not 
operate properly if you try to turn it on again after it has been 
suspended.)

> > >      bmAttributes         0xe0
> > >        Self Powered
> > >        Remote Wakeup
> >
> > That's what I was interested in.  The device does support remote wakeup.
>
> That would make sense so it can be resumed? (It does not necessarily mean
> something like Wake-On-LAN, right?

It _does_ mean something like Wake-On-LAN: The device is capable of 
asking the system to wake it up under some conditions while it or the 
system is suspended.

> Also, for this device it’s disabled?
> 
>     $ grep . /sys/bus/usb/devices/1-3/power/wakeup
>     disabled

Yes.  You can change that setting by writing "enabled" to the sysfs 
file.  But I don't think this will make any difference to your runtime 
suspend problem; the power/wakeup setting affects only system suspend, 
not runtime suspend.

Alan Stern

