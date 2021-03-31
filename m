Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B53501D4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhCaODK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 10:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhCaOCl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 10:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 488A2608FE;
        Wed, 31 Mar 2021 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617199361;
        bh=0SCL4cotKlzm/Rg3qeRdoMYBvamEm9kL9PkMi8TuWYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9JjzFVCzfkjAOL9OTl+PIRCB06OE3pdLPwQIFHujODcVmNEknlCzHKurpxU17VsE
         bHeRQprPRU8TfheSh++N7O9CmElFSwa/PrN8OQeDTRKDGni7J/bkt8UWiX7oXqNT6A
         ILI/tRX89lQz2MZ6MYeEg98DF92fPACivZ5CWOoSGkqFuec8P3c/ESmS1E67K9hRMj
         +W5QaSmcQtx8kDMxxaOFFMYjDN3p6A+UqCLuAFmvNM4r4I2gYd+InyJskcQ2Y7A6VF
         vAiX8cjbOalm+NmPvEDqngg0dBCZjim4veGbeJG17IYK0G2/4giarcXa2UnyUMDPMR
         7UEC9e/D3S7AA==
Received: by pali.im (Postfix)
        id D09D3AF7; Wed, 31 Mar 2021 16:02:38 +0200 (CEST)
Date:   Wed, 31 Mar 2021 16:02:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Hermes Zhang <chenhui.zhang@axis.com>
Cc:     lars@metafoo.de, Sebastian Reichel <sre@kernel.org>,
        kernel@axis.com, Hermes Zhang <chenhuiz@axis.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: Return the value instead of
 -ENODATA
Message-ID: <20210331140238.jl3qprpqhqave4bf@pali>
References: <20210331135141.8063-1-chenhui.zhang@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331135141.8063-1-chenhui.zhang@axis.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 31 March 2021 21:51:41 Hermes Zhang wrote:
> From: Hermes Zhang <chenhuiz@axis.com>
> 
> It might be better to return value (e.g. 65535) instead of an error
> (e.g. No data available) for the time property.
> 
> Normally a common function will handle the read string and parse to
> integer for all the properties, but will have problem when read the
> time property because need to handle the NODATA error as non-error.
> So it will make simple for application which indicate success when
> read a number, otherwise as an error to handle.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 4c4a7b1c64c5..b75e54aa8ada 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1655,9 +1655,6 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
>  		return tval;
>  	}
>  
> -	if (tval == 65535)
> -		return -ENODATA;
> -
>  	return tval * 60;

I'm not sure if this is correct change. If value 65535 is special which
indicates that data are not available then driver should not return
(converted) value 65535*60. If -ENODATA is there to indicate that data
are not available then -ENODATA should not be used.

And if there is application which does not handle -ENODATA for state
when data are not available then it is a bug in application.

>  }
>  
> -- 
> 2.20.1
> 
