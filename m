Return-Path: <linux-pm+bounces-16633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440E9B4103
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 04:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59713283886
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 03:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E91F429A;
	Tue, 29 Oct 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBJVzjSo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DCFC0B;
	Tue, 29 Oct 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172465; cv=none; b=Gi/bRYCuGs3DBxB7YFrg7IE0JFKxhz8tgs8TcqZiNU/tx2d6vLhuDp3UIoP6wxssItP8pPAF9ieqyOOyMDaGeo+HJ3oNPU1G+XrWGCf/ScRYtlObNTU+qNiGgtu5Uj6t366w+GBJZAmBmPjjhFDcKkI/5uA19cyag+obWS5HvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172465; c=relaxed/simple;
	bh=eF9uLPwqEjNwuB2LYFt7rEZ3ziirYlp/Vyr8oHH03Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6FA+A27eM4yVP3MnUrIIpDJeGNnSXjPXY553y4NZRyiaJKdSKSBZomJ0saAQXdF/5FZRCXPHxZwN4Nw3aPd1OpBGT+YHZ/B9cVd6/5rgEcUrvjL5c/flt4iP5DKIpKcAvLZ09AJPPV7Xyj1uIIT2hXU0zKpEGDiRy9LkR54f4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBJVzjSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DFFC4CECD;
	Tue, 29 Oct 2024 03:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730172464;
	bh=eF9uLPwqEjNwuB2LYFt7rEZ3ziirYlp/Vyr8oHH03Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBJVzjSomlGJpePlj/JARrbAKpNp0bfYEZbE70m4JIgYtVdlxQhbq91fIiQ/uIcZu
	 wVE0fZDRCLua+G0cwgWxfpOo6PAhJ3JVRpz1TGztsMi6fo5GYE7NyPzEM4Z9ALCfZm
	 /0p0LylG+NMahc+W219MlhChNj/zHyG4vTf4mN/E=
Date: Tue, 29 Oct 2024 04:27:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: stern@rowland.harvard.edu, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	rafael@kernel.org, stanley_chang@realtek.com, tj@kernel.org,
	xiehongyu1@kylinos.cn, xy521521@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <2024102911-mooned-precise-f526@gregkh>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
 <20241024024038.26157-1-duanchenghao@kylinos.cn>
 <2024102432-conjoined-skylight-33f1@gregkh>
 <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>

On Thu, Oct 24, 2024 at 04:46:48PM +0800, duanchenghao wrote:
> hi greg k-h,
> 
> 在 2024-10-24星期四的 09:05 +0200，Greg KH写道：
> > On Thu, Oct 24, 2024 at 10:40:38AM +0800, Duan Chenghao wrote:
> > > When a device is inserted into the USB port and an S4 wakeup is
> > > initiated,
> > > after the USB-hub initialization is completed, it will
> > > automatically enter
> > > suspend mode. Upon detecting a device on the USB port, it will
> > > proceed with
> > > resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state. During
> > > the S4
> > > wakeup process, peripherals are put into suspend mode, followed by
> > > task
> > > recovery. However, upon detecting that the hcd is in the
> > > HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status,
> > > causing the
> > > S4 suspend to fail and subsequent task recovery to not proceed.
> > > -
> > > [   27.594598][ 1]  PM: pci_pm_freeze(): hcd_pci_suspend+0x0/0x28
> > > returns -16
> > > [   27.594601][ 1]  PM: dpm_run_callback(): pci_pm_freeze+0x0/0x100
> > > returns -16
> > > [   27.603420][ 1]  ehci-pci 0000:00:04.1: pci_pm_freeze+0x0/0x100
> > > returned 0 after 3 usecs
> > > [   27.612233][ 1]  ehci-pci 0000:00:05.1: pci_pm_freeze+0x0/0x100
> > > returned -16 after 17223 usecs
> > > [   27.810067][ 1]  PM: Device 0000:00:05.1 failed to quiesce
> > > async: error -16
> > > [   27.816988][ 1]  PM: quiesce of devices aborted after 1833.282
> > > msecs
> > > [   27.823302][ 1]  PM: start quiesce of devices aborted after
> > > 1839.975 msecs
> > > ......
> > > [   31.303172][ 1]  PM: recover of devices complete after 3473.039
> > > msecs
> > > [   31.309818][ 1]  PM: Failed to load hibernation image,
> > > recovering.
> > > [   31.348188][ 1]  PM: Basic memory bitmaps freed
> > > [   31.352686][ 1]  OOM killer enabled.
> > > [   31.356232][ 1]  Restarting tasks ... done.
> > > [   31.360609][ 1]  PM: resume from hibernation failed (0)
> > > [   31.365800][ 1]  PM: Hibernation image not present or could not
> > > be loaded.
> > > 
> > > The "do_wakeup" is determined based on whether the controller's
> > > power/wakeup attribute is set. The current issue necessitates
> > > considering
> > > the type of suspend that is occurring. If the suspend type is
> > > either
> > > PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be set
> > > to
> > > false.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@intel.com/
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> > 
> > What commit id does this fix?
> 
> The current patch is not intended to fix an issue with a specific
> commit, but rather to address a long-standing problem in the USB core.

So should it be backported to older stable kernels?  If so, how far
back?

> > And I missed where Alan provided a signed-off-by, where was that?
> 
> In the following email, Alan proposed using "Signed-off-by" for
> signing.
> https://lore.kernel.org/all/489805e7-c19c-4b57-9cd7-713e075261cd@rowland.harvard.edu/

Ah, missed that, sorry.

thanks,

greg k-h

