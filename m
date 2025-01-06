Return-Path: <linux-pm+bounces-19988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F54A02697
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022691885552
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5541DA631;
	Mon,  6 Jan 2025 13:32:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6232B9CD
	for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170359; cv=none; b=gOozGY5UOFV4NwwjPh4DtPeaC9k5AckM7f3/3N/SPP0rNNirLukedoeDFggNMXEcekv4M/DbgYytIYnFZQZQv6/cZER4+BpuriMf64Lf7Ms8F/jYKFcZstzw92UOK2rcbRdK6RH3zGVfAoUo17KdIY3ch33o625Nb7koiSKBsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170359; c=relaxed/simple;
	bh=uJXhTysw7aPAFizE9GDolxWlKW3OFYpdebjwy/OOKcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q42mU4FENAafvqzAyFKmYX1ZQuwd3bW2Pfl50Jovg/QfU9365V2cWU2AhIXHr54tQHk8R3CzX5hdVwxYTmpU9YmDywT/ILohI4cjfrjDTDQ57uuFPUVtSJqlPEiwV6pClqO9oFLB/16YPp60I5AOosza9lThrLi2zBG8tJpaoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tUnDa-00032F-D6; Mon, 06 Jan 2025 14:32:30 +0100
Message-ID: <86f3159b-2ef0-4c1c-97f5-a03b552b6738@pengutronix.de>
Date: Mon, 6 Jan 2025 14:32:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] docs: ABI: replace mcroce@microsoft.com with new Meta
 address
To: Matteo Croce <teknoraver@meta.com>, Matteo Croce <technoboy85@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-block@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi,

On 19.12.24 08:51, Ahmad Fatoum wrote:
> The Microsoft email address is bouncing:
> 
>     550 5.4.1 Recipient address rejected: Access denied.
> 
> So let's replace it with the address Matteo last used to sign off
> patches two months ago.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> @Matteo, is this ok for you or would you prefer another address (whether
> your own or someone else's?)
> 
> I ran into this while submitting a series[1] touching sysfs-kernel-reboot
> and b4/get_maintainers.pl picked off the stale address from the file.

Given that Matteo is fine with the change, can this be applied?

Thanks,
Ahmad

> 
> [1]: https://lore.kernel.org/all/20241219-hw_protection-reboot-v1-6-263a0c1df802@pengutronix.de/
> ---
>  Documentation/ABI/stable/sysfs-block          |  2 +-
>  Documentation/ABI/testing/sysfs-kernel-reboot | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 0cceb2badc836b8cbdade543deff71edef0e3da1..ee1bbb4dfd4ea65fc0aa13c03a5205b8d5816ecf 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -77,7 +77,7 @@ Description:
>  
>  What:		/sys/block/<disk>/diskseq
>  Date:		February 2021
> -Contact:	Matteo Croce <mcroce@microsoft.com>
> +Contact:	Matteo Croce <teknoraver@meta.com>
>  Description:
>  		The /sys/block/<disk>/diskseq files reports the disk
>  		sequence number, which is a monotonically increasing
> diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
> index 837330fb251134ffdf29cd68f0b2a845b088e5a0..fb2d21acc6627ee340a3c8327261d5727ad63e15 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-reboot
> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot
> @@ -1,7 +1,7 @@
>  What:		/sys/kernel/reboot
>  Date:		November 2020
>  KernelVersion:	5.11
> -Contact:	Matteo Croce <mcroce@microsoft.com>
> +Contact:	Matteo Croce <teknoraver@meta.com>
>  Description:	Interface to set the kernel reboot behavior, similarly to
>  		what can be done via the reboot= cmdline option.
>  		(see Documentation/admin-guide/kernel-parameters.txt)
> @@ -9,24 +9,24 @@ Description:	Interface to set the kernel reboot behavior, similarly to
>  What:		/sys/kernel/reboot/mode
>  Date:		November 2020
>  KernelVersion:	5.11
> -Contact:	Matteo Croce <mcroce@microsoft.com>
> +Contact:	Matteo Croce <teknoraver@meta.com>
>  Description:	Reboot mode. Valid values are: cold warm hard soft gpio
>  
>  What:		/sys/kernel/reboot/type
>  Date:		November 2020
>  KernelVersion:	5.11
> -Contact:	Matteo Croce <mcroce@microsoft.com>
> +Contact:	Matteo Croce <teknoraver@meta.com>
>  Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci
>  
>  What:		/sys/kernel/reboot/cpu
>  Date:		November 2020
>  KernelVersion:	5.11
> -Contact:	Matteo Croce <mcroce@microsoft.com>
> +Contact:	Matteo Croce <teknoraver@meta.com>
>  Description:	CPU number to use to reboot.
>  
>  What:		/sys/kernel/reboot/force
>  Date:		November 2020
>  KernelVersion:	5.11
> -Contact:	Matteo Croce <mcroce@microsoft.com>
> +Contact:	Matteo Croce <teknoraver@meta.com>
>  Description:	Don't wait for any other CPUs on reboot and
>  		avoid anything that could hang.
> 
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241219-fix-mcroce-mail-bounce-328900169405
> 
> Best regards,


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

