Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3907E227A83
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgGUITw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 04:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgGUITw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 04:19:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603242068F;
        Tue, 21 Jul 2020 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319591;
        bh=G1ZJ6z2nGN2ypA8j/rBMCiv4O5LEWR6lDslIJVYhYWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+hWS8vl0/WJjxnt0isHR923FpV6OUrI0ho4z6Nb3XRVPPqcUKDjSjFooek4rHmK5
         R7Td12WPySgXr5gQaBRZgEa22cTriuWcVngV/eEP7E+7wOHKLgsxylF0/bMk0seB0G
         djr8tESJw3LiehUeyGJpEaBlJwxcSTy4X7AXuBJU=
Date:   Tue, 21 Jul 2020 10:20:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 3/4] power: supply: core: add wireless signal strength
 property
Message-ID: <20200721082000.GD1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <b383d79629d0afca00838fcbaad4458e383d7262.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b383d79629d0afca00838fcbaad4458e383d7262.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:36PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> reports wireless signal strength.
> The value show degree of coupling between tx and rx.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 03ab449fae8a..75ec7de2fe78 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -757,3 +757,13 @@ Description:
>  			13: ADAPTER_VOICE_BOX,
>  			14: ADAPTER_PRIVATE_PD_50W.
>  
> +What:		/sys/class/power_supply/<supply_name>/signal_strength
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		In PING phase, RX transmits a signal strength packet as the first

What does "PING phase" mean?

Other than that, seems sane to me, thanks for the changes.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
