Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0B2A634E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 12:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgKDLaY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Nov 2020 06:30:24 -0500
Received: from aposti.net ([89.234.176.197]:51794 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDLaY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Nov 2020 06:30:24 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 06:30:23 EST
Date:   Wed, 04 Nov 2020 11:23:14 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] power: supply: ingenic: remove unneeded semicolon
To:     trix@redhat.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <QMR9JQ.OROHJH58MSYF3@crapouillou.net>
In-Reply-To: <20201101140910.2280370-1-trix@redhat.com>
References: <20201101140910.2280370-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Le dim. 1 nov. 2020 à 6:09, trix@redhat.com a écrit :
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/power/supply/ingenic-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/ingenic-battery.c 
> b/drivers/power/supply/ingenic-battery.c
> index 32dc77fd9a95..8b18219ebe90 100644
> --- a/drivers/power/supply/ingenic-battery.c
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -52,7 +52,7 @@ static int ingenic_battery_get_property(struct 
> power_supply *psy,
>  		return 0;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
>  }
> 
>  /* Set the most appropriate IIO channel voltage reference scale
> --
> 2.18.1
> 


