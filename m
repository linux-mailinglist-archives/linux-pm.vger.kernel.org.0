Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF01D2745
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgENGLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 02:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgENGLY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 02:11:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C19206D4;
        Thu, 14 May 2020 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589436683;
        bh=lgAfsk3eTdBS1nBtTAp6vjs9oy84Hv0KqdYyYePcZLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZXzY7gyv5zKYElVKKiYQlhweKPTH1RYphccgVbIGHryFOgSy66qS4qWZYxYEeVgN
         nfCrcU1YKIIy8ya3PoKBNLNvC9DlyNYhJNYoOjPeKLE/9H66SGH6SHGb6A+5+bV5x7
         2Idtx63UnEOY/hU98tBIMugsUfoiygwZFlFrDQys=
Date:   Thu, 14 May 2020 08:11:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 01/19] kobject: increase allowed number of uevent
 variables
Message-ID: <20200514061121.GA1457703@kroah.com>
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

On Wed, May 13, 2020 at 08:55:57PM +0200, Sebastian Reichel wrote:
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
>  #define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
>  
>  #ifdef CONFIG_UEVENT_HELPER

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
