Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE33AAD8B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhFQH35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 03:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQH34 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Jun 2021 03:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 487CB6135C;
        Thu, 17 Jun 2021 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623914869;
        bh=LxxznnyPEEYU2PLFNABNQbXR+6nQy9EzVumeO20nZqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qgi70FZhlbxWa+a5K9kY6HLxKL6Tr+uFWVDpAE9PNUHqVy2oMaxbPq1oS0NHrfmV2
         FbyQCYgfmOz5Q53bUgnq/Khex3oEmqcRsZXxIEh/dQyfg99JiKVTvQd4FUtIWhAbb2
         eATzGOTCXYSDtsQpsw+Xac3GDnd5LW+DTo9pR+lVZBHqCQ8OA4g5gC9Eb5TL+pB1fg
         MxINeeVw6elc29+6CqYVQz2c2hUM4mKOtjCB7eqjPqS+XBVTw9oYIie+SNgPg2sJFe
         Q9wcI3YZp3PJcZ30o+8itBhjC3yhr2XRSrI87z9HAqqjgyhGWHX656a+MoEwAd8bQ8
         kJL9fqn5UDHxQ==
Received: by pali.im (Postfix)
        id B09AF52D; Thu, 17 Jun 2021 09:27:46 +0200 (CEST)
Date:   Thu, 17 Jun 2021 09:27:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     dmurphy@ti.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanjanasrinidhi1810@gmail.com
Subject: Re: [PATCH] drivers: power: supply: bq27xxx_battery.c: Remove spaces
 before tabs
Message-ID: <20210617072746.rvot5wmbzmk4j6ro@pali>
References: <20210617071732.vbsn2okr2ed3l4dk@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617071732.vbsn2okr2ed3l4dk@kewl-virtual-machine>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 17 June 2021 12:47:32 Shubhankar Kuranagatti wrote:
> Removed extra spaces before ','
...
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 4c4a7b1c64c5..bf090b7ebcec 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -938,26 +938,26 @@ static struct {
>  	enum power_supply_property *props;
>  	size_t props_size;
>  } bq27xxx_chip_data[] = {
> -	[BQ27000]   = BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
> -	[BQ27010]   = BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
> -	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0         , BQ27XXX_O_OTDC),
> -	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0         , BQ27XXX_O_OTDC),
> -	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0         , BQ27XXX_O_OTDC),
> +	[BQ27000]   = BQ27XXX_DATA(bq27000,   0, BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
> +	[BQ27010]   = BQ27XXX_DATA(bq27010,   0, BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
> +	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0, BQ27XXX_O_OTDC),
> +	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0, BQ27XXX_O_OTDC),
> +	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0, BQ27XXX_O_OTDC),
>  	[BQ27500]   = BQ27XXX_DATA(bq27500,   0x04143672, BQ27XXX_O_OTDC),
> -	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0         , BQ27XXX_O_OTDC),
> -	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0         , BQ27XXX_O_OTDC),
> -	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
> -	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
> -	[BQ27521]   = BQ27XXX_DATA(bq27521,   0         , 0),
> -	[BQ27530]   = BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
> -	[BQ27531]   = BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
> -	[BQ27541]   = BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
> -	[BQ27542]   = BQ27XXX_DATA(bq27542,   0         , BQ27XXX_O_OTDC),
> -	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
> -	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
> +	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0, BQ27XXX_O_OTDC),
> +	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0, BQ27XXX_O_OTDC),
> +	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0, BQ27XXX_O_OTDC),
> +	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0, BQ27XXX_O_OTDC),
> +	[BQ27521]   = BQ27XXX_DATA(bq27521,   0, 0),
> +	[BQ27530]   = BQ27XXX_DATA(bq27530,   0, BQ27XXX_O_UTOT),
> +	[BQ27531]   = BQ27XXX_DATA(bq27531,   0, BQ27XXX_O_UTOT),
> +	[BQ27541]   = BQ27XXX_DATA(bq27541,   0, BQ27XXX_O_OTDC),
> +	[BQ27542]   = BQ27XXX_DATA(bq27542,   0, BQ27XXX_O_OTDC),
> +	[BQ27546]   = BQ27XXX_DATA(bq27546,   0, BQ27XXX_O_OTDC),
> +	[BQ27742]   = BQ27XXX_DATA(bq27742,   0, BQ27XXX_O_OTDC),
>  	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
>  	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> @@ -965,9 +965,9 @@ static struct {
>  	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> -	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
> -	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
> -	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
> +	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0, BQ27Z561_O_BITS),
> +	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0, BQ27Z561_O_BITS),
> +	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0, BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
>  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),

Why to do this change? Spaces are there to visually align columns with
values. With this proposed change, whole bq27xxx_chip_data[] table is
less readable.
