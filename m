Return-Path: <linux-pm+bounces-16894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E4F9B9B1C
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 00:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F2C282AA5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468701E883C;
	Fri,  1 Nov 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6GKL8yJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353E1607B4
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502522; cv=none; b=Ih2UD7fmxvhfRJbhkZHTE8fi/RF8UyQkMf2IBeu3icrEY1T1pZwVfktWWv2BTXn6lcslKPYkflN96kzBYFvVQT21ygN+8nImqna5EC7ZscRivisOPWgyqVOM8heaZCOz7ujHOtjnqYrNHW0H2RrO7h9KkL2D8nl7ZSkusaxb/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502522; c=relaxed/simple;
	bh=8HtLBGMrxbf3R+JEfh2c7UtM0kENC5qMxOs5dYms2kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+8ENLDh86WJa3CkQkpHag/aRxAmFp3q4jHdqfjDv/kknVroVlMQzajlAWGuR2iG44Or6AtIQJsNdJXbHhbGlh0ZaxjbOxIt05jupyxA4VklYIZGye0iVOkGC28ciaHuWjXxYfMfVW6qBs8ERydBGQxTh3ghd8UCJNllMfNG62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6GKL8yJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c693b68f5so26954025ad.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730502519; x=1731107319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2VK9rpRjUDVc3dgLj7IbRkd7AQMzzJw9gi42KAkjK4=;
        b=p6GKL8yJFQ/43J5w2ewoAXa8LGv+uF1YAaqAh30M9W/tXqZOqJMtwypqAPiYy66EsA
         zH/lmpQXsnpxGRJzAWfjf2In/BIHLnCx9yp3FDH94WyJF2GKPinhHHrUsYfI13dl4NkR
         1Z5xMovP4L9JHp8Kx6Y9RalSWALjs3+rD0LrkJYobcj5dkIv17UOMnog1MT1frK1uA61
         KkWCTyfQxhD8GL8yaMAQ+Lm1OfpsHpPV14zdKjzd0uUEf/l0Bn0iYTifA45uQ+KNxbYB
         3vCSeeJs4xwLYdaHMzm2PkH9Cmjs/Bu+30RRCELmLqvJt5HIDz+2QQJDe9Hbw82j0E4b
         SfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730502519; x=1731107319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2VK9rpRjUDVc3dgLj7IbRkd7AQMzzJw9gi42KAkjK4=;
        b=prx8ypDl08f62wOXuzo3I2tFPTCv7BYF9ziZz1AoWUeUnWdJbOh3Xy7K87PvRXGSxP
         evmSxoALD195qxgN8iJdk3YJr7aj0wrtkFCqAtRL7Bwt2fdiEbyiY5NswGwWkuC20qWe
         6NG4ehc4xy37GXw795JGgu4D3/ip9v+P0ctshvUGVAtYm6aVKF+dGg2SQpuejZgA3Pmu
         UuM9V58ieXPcyw3vXK2ivtQ8m27JuNESxfifCDLkbEN/41KuZGnYwFxTUrb9qXWNvqSK
         ZDjwxd13eu6t05I7UoRsmIiTOijfwNE6zJPAkR/ASYtqp0Wgnpt3z/D0kcPjafRbC9F4
         ad+A==
X-Forwarded-Encrypted: i=1; AJvYcCWvdQBF1Xv6za1qPs0LJ4GoDb6k/v5LWzM6yZWjSou90riWiDXQuejph1JWIEAqKvYV8hA7ZBMqSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYGgMBMoQL8v/YEjnR2cxAwi6gUrfJjykKx5gcXhKNk/xMyzr
	K9wnyUEAadSNilsuwKy3qUR+eN/RTqJOmwrihoVsP+kQy4lOw/3x0uNw5/By/A==
X-Google-Smtp-Source: AGHT+IHiSicuaWzRWdSxo5vFaFwO2XoBvjBBetkGaD/hMpauOfZ0WW9/tvooXwQneA/KyP9k1QkUHQ==
X-Received: by 2002:a17:902:ec8e:b0:20c:bff7:2e5f with SMTP id d9443c01a7336-21103acc174mr117490335ad.13.1730502518543;
        Fri, 01 Nov 2024 16:08:38 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a6592sm26350655ad.166.2024.11.01.16.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 16:08:38 -0700 (PDT)
Date: Fri, 1 Nov 2024 16:08:33 -0700
From: William McVicker <willmcvicker@google.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
	msp@baylibre.com, srk@ti.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Message-ID: <ZyVfcUuPq56R2m1Y@google.com>
References: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>

+linux-arm-msm@vger.kernel.org

Hi Roger,

On 10/11/2024, Roger Quadros wrote:
> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
> system suspend is broken on AM62 TI platforms.
> 
> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
> bits (hence forth called 2 SUSPHY bits) were being set during core
> initialization and even during core re-initialization after a system
> suspend/resume.
> 
> These bits are required to be set for system suspend/resume to work correctly
> on AM62 platforms.
> 
> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
> driver is not loaded and started.
> For Host mode, the 2 SUSPHY bits are set before the first system suspend but
> get cleared at system resume during core re-init and are never set again.
> 
> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
> before system suspend and restored to the original state during system resume.
> 
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
> Changes in v3:
> - Fix single line comment style
> - add DWC3_GUSB3PIPECTL_SUSPHY to documentation of susphy_state
> - Added Acked-by tag
> - Link to v2: https://lore.kernel.org/r/20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org
> 
> Changes in v2:
> - Fix comment style
> - Use both USB3 and USB2 SUSPHY bits to determine susphy_state during system suspend/resume.
> - Restore SUSPHY bits at system resume regardless if it was set or cleared before system suspend.
> - Link to v1: https://lore.kernel.org/r/20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org
> ---
>  drivers/usb/dwc3/core.c | 19 +++++++++++++++++++
>  drivers/usb/dwc3/core.h |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 9eb085f359ce..ca77f0b186c4 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2336,6 +2336,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  	u32 reg;
>  	int i;
>  
> +	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> +			    DWC3_GUSB2PHYCFG_SUSPHY) ||
> +			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
> +			    DWC3_GUSB3PIPECTL_SUSPHY);
> +

I'm running into an issue on my Pixel 6 device with this change when the
dwc3-exynos device has runtime PM enabled. Basically, after the device boots up
and I disconnect USB, the dwc3-exynos device enters runtime suspend followed by
system suspend 15 seconds later. On system suspend, the clocks powering these
dwc3 registers are off which results in an SError. I have verified that
reverting this change fixes the issue.

I noticed that dwc3-qcom.c also supports runtime PM for their dwc3 device and
most likely is affected by this as well. It would be great if someone with a
Qualcomm device could test out dwc3 suspend as well.

Here is the crash stack:

  SError Interrupt on CPU7, code 0x00000000be000011 -- SError
  CPU: 7 UID: 1000 PID: 5661 Comm: binder:477_1 Tainted: G        W  OE      6.12.0-rc3-android16-0-maybe-dirty-4k #1 0439eacb3cff642033630df7ee2e250e0625f2f0
  96 irq, BUS_DATA0 group, 0x0
  Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: Raven DVT (DT)
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : readl+0x40/0x80
  lr : readl+0x38/0x80
  sp : ffffffc08baa39a0
  x29: ffffffc08baa39a0 x28: ffffffd4dd140000 x27: ffffffd4dd140d70
  x26: ffffffd4dd2b2000 x25: ffffff800cef2410 x24: ffffff800cef24c0
  x23: ffffffd4dd24e000 x22: ffffff887df59440 x21: ffffffc085298100
  x20: ffffffd4db8acf60 x19: ffffffc085298200 x18: ffffffc091b730b0
  x17: 000000002a703c0b x16: 000000002a703c0b x15: 0000000000953000
  x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
  x11: 7f7f7f7f7f7fffff x10: 0000000000000000 x9 : ffffffd4dc0d7d48
  x8 : 0000000000000000 x7 : 0000000000008000 x6 : 0000000000000000
  x5 : 500020737562ffff x4 : 500020737562ffff x3 : ffffffd4db8acf60
  x2 : ffffffd4db8a7bac x1 : ffffffc085298200 x0 : 0000000000000020
  Kernel panic - not syncing: Asynchronous SError Interrupt
  CPU: 7 UID: 1000 PID: 5661 Comm: binder:477_1 Tainted: G        W  OE      6.12.0-rc3-android16-0-maybe-dirty-4k #1 0439eacb3cff642033630df7ee2e250e0625f2f0
  Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: Raven DVT (DT)
  Call trace:
   dump_backtrace+0xec/0x128
   show_stack+0x18/0x28
   dump_stack_lvl+0x40/0x88
   dump_stack+0x18/0x24
   panic+0x134/0x45c
   nmi_panic+0x3c/0x88
   arm64_serror_panic+0x64/0x8c
   do_serror+0xc4/0xc8
   el1h_64_error_handler+0x34/0x48
   el1h_64_error+0x68/0x6c
   readl+0x40/0x80
   dwc3_suspend_common+0x34/0x454
   dwc3_suspend+0x20/0x40
   platform_pm_suspend+0x40/0x90
   dpm_run_callback+0x60/0x250
   device_suspend+0x334/0x614
   dpm_suspend+0xc4/0x368
   dpm_suspend_start+0x90/0x100
   suspend_devices_and_enter+0x128/0xad0
   pm_suspend+0x354/0x650
   state_store+0x104/0x144
   kobj_attr_store+0x30/0x48
   sysfs_kf_write+0x54/0x6c
   kernfs_fop_write_iter+0x104/0x1e4
   vfs_write+0x3bc/0x50c
   ksys_write+0x78/0xe8
   __arm64_sys_write+0x1c/0x2c
   invoke_syscall+0x58/0x10c
   el0_svc_common+0xa8/0xdc
   do_el0_svc+0x1c/0x28
   el0_svc+0x38/0x6c
   el0t_64_sync_handler+0x70/0xbc
   el0t_64_sync+0x1a8/0x1ac

Thanks,
Will

<snip>

