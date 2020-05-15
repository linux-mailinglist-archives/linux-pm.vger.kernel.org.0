Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799101D525B
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOOrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 10:47:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44728 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgEOOrw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:47:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: evelikov)
        with ESMTPSA id 329E22A238D
Date:   Fri, 15 May 2020 15:45:12 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 01/19] kobject: increase allowed number of uevent
 variables
Message-ID: <20200515144512.GB2836808@arch-x1c3>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-2-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/05/13, Sebastian Reichel wrote:
> SBS battery driver exposes 32 power supply properties now,
> which will result in uevent failure on (un)plugging the
> battery. Other drivers (e.g. bq27xxx) are also coming close
> to this limit, so increase it.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  include/linux/kobject.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index e2ca0a292e21..75e822569e39 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -29,7 +29,7 @@
>  #include <linux/uidgid.h>
>  
>  #define UEVENT_HELPER_PATH_LEN		256
> -#define UEVENT_NUM_ENVP			32	/* number of env pointers */
> +#define UEVENT_NUM_ENVP			64	/* number of env pointers */

To be on the safe side I've checked systemd/udev. It's using ordered hashmap,
so it's perfectly capable of handling the extra entries.

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
