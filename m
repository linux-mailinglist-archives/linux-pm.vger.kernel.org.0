Return-Path: <linux-pm+bounces-16343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38C19ADD0C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 09:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1B1F22446
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A984189B86;
	Thu, 24 Oct 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCEsXGD9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B86F305;
	Thu, 24 Oct 2024 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753568; cv=none; b=WJXWAGASguWghFkCdGndqbcQsCRS7CwdCIv29vPPQ8xm81cJAsF418AAbk5f60B2IOvNLQcD68TR7Gc95/5+cUq4aCBgCg052zAvY8ivnmpNzTeAz0wNMvyOwh7+5gcAxCuoKa9AL6rzqh69eYwltBSIb62QMS24F0Ari/X09Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753568; c=relaxed/simple;
	bh=+E37BslfPvS9MXGl9D+lxosyZFP7Cshyw4UOpiDHsGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu6mIUEfnKinw0Xjfa/vfhPnl71KkTl39LoUnX/C7leqzwLInNixj3IKuEKGo953Uyno6SxFGeU0K+gjD2MXqJ+ZWxOmckiDgxpKZlpy+c7Zy0K70HYJejWQgaBpmMBvi2q91F22ayGDoJZfCN0k6p5sOWtkYHEweL/UgAao39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCEsXGD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629BEC4CEC7;
	Thu, 24 Oct 2024 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729753567;
	bh=+E37BslfPvS9MXGl9D+lxosyZFP7Cshyw4UOpiDHsGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCEsXGD9tqnMJhkIMi3z7ymyo08jfzPxM1pM4+Fo//h08tOxbisKZV29PWeQSbiOh
	 wCNgaXmMcQ0/GWLyE9taajPn3wxcGnjj2+XzoEty+mrR20gFJ7HTt752h0ytUKpdYp
	 mGTmYCEaIjc6G2LsLQEBjRT1EpSLvZCudYaoCqYs=
Date: Thu, 24 Oct 2024 09:05:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Duan Chenghao <duanchenghao@kylinos.cn>
Cc: stern@rowland.harvard.edu, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	rafael@kernel.org, stanley_chang@realtek.com, tj@kernel.org,
	xiehongyu1@kylinos.cn, xy521521@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <2024102432-conjoined-skylight-33f1@gregkh>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
 <20241024024038.26157-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024024038.26157-1-duanchenghao@kylinos.cn>

On Thu, Oct 24, 2024 at 10:40:38AM +0800, Duan Chenghao wrote:
> When a device is inserted into the USB port and an S4 wakeup is initiated,
> after the USB-hub initialization is completed, it will automatically enter
> suspend mode. Upon detecting a device on the USB port, it will proceed with
> resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state. During the S4
> wakeup process, peripherals are put into suspend mode, followed by task
> recovery. However, upon detecting that the hcd is in the
> HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status, causing the
> S4 suspend to fail and subsequent task recovery to not proceed.
> -
> [   27.594598][ 1]  PM: pci_pm_freeze(): hcd_pci_suspend+0x0/0x28 returns -16
> [   27.594601][ 1]  PM: dpm_run_callback(): pci_pm_freeze+0x0/0x100 returns -16
> [   27.603420][ 1]  ehci-pci 0000:00:04.1: pci_pm_freeze+0x0/0x100 returned 0 after 3 usecs
> [   27.612233][ 1]  ehci-pci 0000:00:05.1: pci_pm_freeze+0x0/0x100 returned -16 after 17223 usecs
> [   27.810067][ 1]  PM: Device 0000:00:05.1 failed to quiesce async: error -16
> [   27.816988][ 1]  PM: quiesce of devices aborted after 1833.282 msecs
> [   27.823302][ 1]  PM: start quiesce of devices aborted after 1839.975 msecs
> ......
> [   31.303172][ 1]  PM: recover of devices complete after 3473.039 msecs
> [   31.309818][ 1]  PM: Failed to load hibernation image, recovering.
> [   31.348188][ 1]  PM: Basic memory bitmaps freed
> [   31.352686][ 1]  OOM killer enabled.
> [   31.356232][ 1]  Restarting tasks ... done.
> [   31.360609][ 1]  PM: resume from hibernation failed (0)
> [   31.365800][ 1]  PM: Hibernation image not present or could not be loaded.
> 
> The "do_wakeup" is determined based on whether the controller's
> power/wakeup attribute is set. The current issue necessitates considering
> the type of suspend that is occurring. If the suspend type is either
> PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be set to
> false.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@intel.com/
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>

What commit id does this fix?

And I missed where Alan provided a signed-off-by, where was that?

thanks,

greg k-h

