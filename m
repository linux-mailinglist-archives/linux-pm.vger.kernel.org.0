Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A721D1EE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgGMIlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 04:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMIlQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 04:41:16 -0400
Received: from localhost (unknown [84.241.194.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6692065D;
        Mon, 13 Jul 2020 08:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629676;
        bh=MsAb3MjB616bGxcV0JPjDtRGwlS8I2nFDbRd+BfX26c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXm0KiOxO2k0zw4i2ze76Wz8PqM4Kkrf6Uog/SNndD8gcGntR7kRRQVZgZlQFIOZG
         za2aAZ1FPtawtQLofe5zuUB+WQ0mxquf+CseShjLkc7AiZyGjCC8zK8C0diQs949aJ
         6UhMmliBHcdc6eyWokws5haM/VBd5pjlxDLeVkGg=
Date:   Mon, 13 Jul 2020 10:41:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v2 1/5] power: supply: core: add quick charge type
 property
Message-ID: <20200713084113.GC215949@kroah.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
 <38b7b1dc10cf608faceae923374791a52a450919.1594612572.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b7b1dc10cf608faceae923374791a52a450919.1594612572.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 12:03:36PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power. UI will show different
> animation effect for different quick charge type.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 12 insertions(+)

What changed from v1 of this patch?  SHouldn't that always be below the
--- line?


> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 216d61a22f1e..d3169d47e359 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -708,3 +708,13 @@ Description:
>  
>  		Access: Read
>  		Valid values: 1-31
> +
> +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +		Description:
> +		Reports the kind of quick charge type based on different adapter power.

What are the allowed types here?  Shouldn't that also be an enumerated
type with a predefined string?

thanks,

greg k-h
