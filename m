Return-Path: <linux-pm+bounces-12112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6794F8A6
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 22:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55AE1C223DA
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33F194152;
	Mon, 12 Aug 2024 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bexHOjeV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C1152199;
	Mon, 12 Aug 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496233; cv=none; b=lK9rTqAe+e9WrKsQlcFbKCQ22bNRNOtdENvL8DRoTHi+lCrDjIwpY46+oz+f5AbNW+YAmHAp75nXZXhOQQQC5VALBFA2kv+uf3sNbbzpg0NeT4DkUHyuhAmRrzG06c316zpmu6vZmBf70fdN+imWYz+shgonDvk7hLrVFEjC2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496233; c=relaxed/simple;
	bh=+994dHVi38zDGUIX85zgqPH6FQWvqDWvbO+kwvAmptE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvtZRZUP8zQSpOwOHfxVvd/62sjtPIPwprE0c/wB+wF7cLNrXVvcEdHzIokiVcfKbX/K0xTeQIa6OSuJpJD2b3ehB0FuUzxDmdKflPbjXHEesZUTQ/h7jdQHEbPooZU+e3q82eAUQcKtrd+7TeySJ2RorS7nRUN+rPHEKfr9/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bexHOjeV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723496196; x=1724100996; i=wahrenst@gmx.net;
	bh=fuJJ3A7XoHTKAqBJStT2uaxEbxrnfTvokB7CgbsFoOc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bexHOjeVuxPjTFM5KHu3j0zwTfQBbsQSgZ46ifFIFvfBUcXfPJcDwzzZQEA/wiVl
	 OEW+IHrFkKmOGqtMcRRGe1RDVC3XA+I3fShQOjibc2l/h17gMwZtXJNFqJRSonRla
	 JTSby/jXNtPgV+2SZ4uQesGupoRjvm/ZnFlp8ot8iBVhDfD5eMCwU9bqg/ogolFxm
	 xb8/VKMOtWoIlz2HT+6BetF7+1a2CIs5v7XmAhqc1NWaU5Bfwg/D4SlWG+sLw3lUc
	 TxtkMhhZWp3O37O8lq2H/29UkRN/rp5eZrtqif4Pv8/+OsdGQpMr2FsDGZULrmFTh
	 ggmPz7ykbUbLpiSGng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1shLDK145q-00WB3x; Mon, 12
 Aug 2024 22:56:36 +0200
Message-ID: <cd49eb42-e0a5-4f6c-bea4-c557e799ec87@gmx.net>
Date: Mon, 12 Aug 2024 22:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/16] mailbox: bcm2835: Fix timeout during suspend
 mode
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Jiri Slaby <jirislaby@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Ray Jui <rjui@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Minas Harutyunyan <hminas@synopsys.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
 Maxime Ripard <mripard@kernel.org>, Scott Branden <sbranden@broadcom.com>
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728114200.75559-3-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240728114200.75559-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TJZZZCAa9g5+T7jw2HbLKKSDbJAVRrbpd95u6xpgZOpZOTxN8E+
 mTJPQTjhMP1GaUzlNIkeOFoxbvyxBPyMgt5gMNgsvESAqrvz4pxuUJgclIir+8Q01CjRrtk
 BT+R4t6J2C1vbkzz7u+VzZmfCtszaDAqx05hagSOZiqJpoiWX5gbyRvT6WO8h3MdD+Fg91j
 iruQveYhjuguUTs7IwnNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F/VcrYBQa84=;tV6VvFU2SKDqQ8r2rrGhBG3mHgW
 GOJGC1/2/X8HPJbqk4Hl+S1yNBFM43p7285rUs00zLi7A3CGZJTGT/DYM4IQ74BylB2p8GDBi
 BMFdAQlOAxlaPgJMIXurmUA9Cg6zrJobMLe4wf8NWHhdJxYT/C504EsLhDY1kkswpGY+XUk5f
 eJZR8Aji7vTAlVQWQxf8BZqK3h+CazLVYe/WkGSRgkBoFl3v32ueaeWpOJZkJadSkVwx4ER7Q
 bagMEs/Z22ABeYr0PXN++bTCQ8bZrhKv59PlrEwnKlUcH0zQ7VPUe0gJkx2xq5BVT0toKzdAu
 tV5Qzoz7dDRjj3kqqBeVre7bGDq+lx8YMbmKxOc3wkDtNs4oMrjb/YbgHLjfZwdfTE3HEvL/f
 lplMHEUUeAh0NMyu85PBeO8RdZs6FjdnepTkX4qvSIJRGQRD1wfN+KIFJoLmYBvbhZp43OkNn
 VMCD2yr4/2WCMmtshyVdFNZgpnw66cEOaf+IOdhqhjyqwFxXwNlEkX12epJ+u8XWGOSuPkSvn
 dkmrTo6J795oUQKhiYEXMahQTSzc1CPMvb09vXTpj5GgSby9I+1OHEywbDkzgikSvwpiU69pU
 nnq7E1kelKOeKJLlzafFMlsAGEJ3PFXz1AVl0XKQHqi9gfGqrbkf0uWOQDKpUTIiFTI+23on8
 KEyrq+0elG8e1yLdqWToqfdDQkDhlBCPfxswZH2Rvoiu6Qk77qb64D5B3ICqH03TpKPbVIDH7
 bQlDMGc5BNbooAsjL2PGId0eaD3yVkXl5V7Kq4wI7m++IQ6zMN0tGBRFK/DL3iRUHwh5yw/5f
 4dGc+fPkyLztaJRvxQatVpsQ==

Hi Jassi,

Am 28.07.24 um 13:41 schrieb Stefan Wahren:
> During noirq suspend phase the Raspberry Pi power driver suffer of
> firmware property timeouts. The reason is that the IRQ of the underlying
> BCM2835 mailbox is disabled and rpi_firmware_property_list() will always
> run into a timeout [1].
>
> Since the VideoCore side isn't consider as a wakeup source, set the
> IRQF_NO_SUSPEND flag for the mailbox IRQ in order to keep it enabled
> during suspend-resume cycle.
>
> [1]
> PM: late suspend of devices complete after 1.754 msecs
> WARNING: CPU: 0 PID: 438 at drivers/firmware/raspberrypi.c:128
>   rpi_firmware_property_list+0x204/0x22c
> Firmware transaction 0x00028001 timeout
> Modules linked in:
> CPU: 0 PID: 438 Comm: bash Tainted: G         C         6.9.3-dirty #17
> Hardware name: BCM2835
> Call trace:
> unwind_backtrace from show_stack+0x18/0x1c
> show_stack from dump_stack_lvl+0x34/0x44
> dump_stack_lvl from __warn+0x88/0xec
> __warn from warn_slowpath_fmt+0x7c/0xb0
> warn_slowpath_fmt from rpi_firmware_property_list+0x204/0x22c
> rpi_firmware_property_list from rpi_firmware_property+0x68/0x8c
> rpi_firmware_property from rpi_firmware_set_power+0x54/0xc0
> rpi_firmware_set_power from _genpd_power_off+0xe4/0x148
> _genpd_power_off from genpd_sync_power_off+0x7c/0x11c
> genpd_sync_power_off from genpd_finish_suspend+0xcc/0xe0
> genpd_finish_suspend from dpm_run_callback+0x78/0xd0
> dpm_run_callback from device_suspend_noirq+0xc0/0x238
> device_suspend_noirq from dpm_suspend_noirq+0xb0/0x168
> dpm_suspend_noirq from suspend_devices_and_enter+0x1b8/0x5ac
> suspend_devices_and_enter from pm_suspend+0x254/0x2e4
> pm_suspend from state_store+0xa8/0xd4
> state_store from kernfs_fop_write_iter+0x154/0x1a0
> kernfs_fop_write_iter from vfs_write+0x12c/0x184
> vfs_write from ksys_write+0x78/0xc0
> ksys_write from ret_fast_syscall+0x0/0x54
> Exception stack(0xcc93dfa8 to 0xcc93dff0)
> [...]
> PM: noirq suspend of devices complete after 3095.584 msecs
>
> Link: https://github.com/raspberrypi/firmware/issues/1894
> Fixes: 0bae6af6d704 ("mailbox: Enable BCM2835 mailbox support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Are there any objections with this patch?

I consider this solution as settled.

Best regards
> ---
>   drivers/mailbox/bcm2835-mailbox.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
> index fbfd0202047c..ea12fb8d2401 100644
> --- a/drivers/mailbox/bcm2835-mailbox.c
> +++ b/drivers/mailbox/bcm2835-mailbox.c
> @@ -145,7 +145,8 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
>   	spin_lock_init(&mbox->lock);
>
>   	ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
> -			       bcm2835_mbox_irq, 0, dev_name(dev), mbox);
> +			       bcm2835_mbox_irq, IRQF_NO_SUSPEND, dev_name(dev),
> +			       mbox);
>   	if (ret) {
>   		dev_err(dev, "Failed to register a mailbox IRQ handler: %d\n",
>   			ret);
> --
> 2.34.1
>


