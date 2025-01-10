Return-Path: <linux-pm+bounces-20186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C609A08AC0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EE2188B977
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558F209F4A;
	Fri, 10 Jan 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxB5e6On"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC920897C;
	Fri, 10 Jan 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736499278; cv=none; b=ICgTQRuqhopQf80+IFWhSKwMiZHBdHRZS8pd0R/qv5tWzlw9vfFdteoR8waRmH+7P5mVXRCs3gG8f4tq87CsEaxeZB1ma9rAGcpNC2gO5Y7nniUT+nh0kGP5k6GSOZ57j26OnC345xdh8B5xiO4fY7BmsJ7fsvMeA1vgZOlaLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736499278; c=relaxed/simple;
	bh=SDLg4tM4f2N04HgZWn56oDp3iXtly9PTn7IubHDKpe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBuEWz4Ku8hDdSkbMvJhjabYD76gIY9Nbkp+c9t7HmQ/Tpc4/LMwPX/JNMRAwr6bMhnuMn7I1XMNruHQNxxT484Yqb5z/8xKtZGEu8FdtsmH2XpeNOSL2AYqedZRM7EowyT1qHutBTLLL3dbLy8RQg2cVXEjcU48k0G+5zfTEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxB5e6On; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2E9C4CED6;
	Fri, 10 Jan 2025 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736499278;
	bh=SDLg4tM4f2N04HgZWn56oDp3iXtly9PTn7IubHDKpe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxB5e6OnyKTdFynwhcNxz+5st7W65GMGkLvCozmGBHcwxvn+iBTGNx49Uxhc1JDhP
	 GaTaWfztBz3QhmpidKc28Xg2NnHODHXVaVPDmyufW2Qssk6zpv4raerIYdUjq8jHih
	 6t8fdS/ccGRUXa5VUCiEpaMhAMMS5WkUaxmezlb0=
Date: Fri, 10 Jan 2025 09:54:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	stern@rowland.harvard.edu, bhelgaas@google.com,
	duanchenghao@kylinos.cn, dlemoal@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH] USB: Prevent xhci from resuming root hub during suspend
 entrance
Message-ID: <2025011013-primary-femur-4dd6@gregkh>
References: <20250110084413.80981-1-leo.lin@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110084413.80981-1-leo.lin@canonical.com>

On Fri, Jan 10, 2025 at 04:44:10PM +0800, Yo-Jung (Leo) Lin wrote:
> The commit d9b4067aef50 ("USB: Fix the issue of task recovery failure
> caused by USB status when S4 wakes up") fixed an issue where if an USB
> port change happens during the entering steps of hibernation, xhci driver
> would attempt to resume the root hub, making the hibernation fail.
> 
> System-wide suspend may fail due to the same reason, but this hasn't been
> addressed yet. This has been found on HP ProOne 440[1], as well as on
> some newer Dell all-in-one models. When suspend fails due to this reason,
> the kernel would show the following messages:
> 
> [   74.245058] [165] usbcore:hub_suspend:3961: hub 2-0:1.0: hub_suspend
> [   74.245850] [165] usbcore:hcd_bus_suspend:2251: usb usb2: bus suspend, wakeup 0
> [   74.250971] [3508] usbcore:usb_port_suspend:3554: usb 1-2: usb suspend, wakeup 1
> [   74.263025] [11] usbcore:hub_suspend:3961: hub 1-0:1.0: hub_suspend
> [   74.264029] [11] usbcore:hcd_bus_suspend:2251: usb usb1: bus suspend, wakeup 0
> [   74.265061] [11] xhci_hcd:xhci_bus_suspend:1779: xhci_hcd 0000:80:14.0: port 1-14 not suspended
> [   74.266020] [11] xhci_hcd:xhci_bus_suspend:1779: xhci_hcd 0000:80:14.0: port 1-8 not suspended
> [   74.266933] [11] xhci_hcd:xhci_bus_suspend:1779: xhci_hcd 0000:80:14.0: port 1-4 not suspended
> [   74.267758] [11] xhci_hcd:xhci_ring_cmd_db:369: xhci_hcd 0000:80:14.0: // Ding dong!
> [   74.268677] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 6
> [   74.269632] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 5
> [   74.270448] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 3
> [   74.271228] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 5 ep 0
> [   74.271946] [11] xhci_hcd:xhci_ring_cmd_db:369: xhci_hcd 0000:80:14.0: // Ding dong!
> [   74.272802] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 6 ep 8
> [   74.273533] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 6 ep 5
> [   74.274233] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 6 ep 0
> [   74.274982] [11] xhci_hcd:xhci_ring_cmd_db:369: xhci_hcd 0000:80:14.0: // Ding dong!
> [   74.275814] <intr> xhci_hcd:handle_tx_event:2711: xhci_hcd 0000:80:14.0: Stopped on No-op or Link TRB for slot 2 ep 0
> [   74.281739] <intr> xhci_hcd:handle_port_status:1992: xhci_hcd 0000:80:14.0: Port change event, 1-8, id 8, portsc: 0x202a0
> [   74.282453] <intr> xhci_hcd:handle_port_status:1998: xhci_hcd 0000:80:14.0: resume root hub
> [   74.283145] <intr> xhci_hcd:handle_port_status:2109: xhci_hcd 0000:80:14.0: handle_port_status: starting usb1 port polling.
> [   74.385425] e1000e: EEE TX LPI TIMER: 00000011
> [   74.385543] [3508] pci_acpi:acpi_pci_set_power_state:1119: pcieport 0000:80:1c.0: power state changed by ACPI to D0
> [   74.385722] xhci_hcd 0000:80:14.0: PM: pci_pm_suspend(): hcd_pci_suspend returns -16
> [   74.385735] xhci_hcd 0000:80:14.0: PM: dpm_run_callback(): pci_pm_suspend returns -16
> [   74.385743] xhci_hcd 0000:80:14.0: PM: failed to suspend async: error -16
> 
> To address this, extend the fix in that commit also to suspend.
> 
> This patch was tested on top of next-20250109, by suspending every 2
> minutes consecutively for 300 times on the machine where the above error
> messages were found. There's no suspend failure found during the test.
> 
> [1] [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
>     https://lore.kernel.org/all/20240906053047.459036-1-kai.heng.feng@canonical.com/#t
> 
> Signed-off-by: Yo-Jung (Leo) Lin <leo.lin@canonical.com>
> ---
>  include/linux/pm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 08c37b83fea8..d71347357fb1 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -571,7 +571,7 @@ const struct dev_pm_ops name = { \
>  
>  #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
>  #define PMSG_NO_WAKEUP(msg)	(((msg).event & \
> -				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) != 0)
> +				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE | PM_EVENT_SUSPEND)) != 0)

What tree is this against?  It's not my usb trees as this #define is not
present there.

And why are you changing a define that affects multiple devices when
it's only a USB issue you are seeing?

confused,

greg k-h

