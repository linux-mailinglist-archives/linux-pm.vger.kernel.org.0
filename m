Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9852CFB03C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 13:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKMMQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 07:16:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42067 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKMMQ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 07:16:27 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2dfb042a85f5e128; Wed, 13 Nov 2019 13:16:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: SmartReflex: add omap_sr_pdata definition
Date:   Wed, 13 Nov 2019 13:16:24 +0100
Message-ID: <4614865.hGV6RNsBzR@kreacher>
In-Reply-To: <20191015131238.25781-1-ben.dooks@codethink.co.uk>
References: <20191015131238.25781-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, October 15, 2019 3:12:38 PM CET Ben Dooks wrote:
> The omap_sr_pdata is not declared but is exported, so add a
> define for it to fix the following warning:
> 
> arch/arm/mach-omap2/pdata-quirks.c:609:36: warning: symbol 'omap_sr_pdata' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/power/smartreflex.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
> index d0b37e937037..971c9264179e 100644
> --- a/include/linux/power/smartreflex.h
> +++ b/include/linux/power/smartreflex.h
> @@ -293,6 +293,9 @@ struct omap_sr_data {
>  	struct voltagedomain		*voltdm;
>  };
>  
> +
> +extern struct omap_sr_data omap_sr_pdata[OMAP_SR_NR];
> +
>  #ifdef CONFIG_POWER_AVS_OMAP
>  
>  /* Smartreflex module enable/disable interface */
> 

Applied as 5.5 material, thanks!




