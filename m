Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02E1C703B
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEFMZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:25:22 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:44373 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgEFMZV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 08:25:21 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49HG5C5WSxz5r;
        Wed,  6 May 2020 14:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588767919; bh=ulBQT93zf7Ov5OEDseQIkp8BSyW4/om/63to7Jh6LL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEw6Fez6K/0sVPRLpz2we3+c9KD9d37RQ324ftoHoEA9cSnBt2Ipqj+JZYqzsLpa7
         9HNIS2j+XsEsCQc928kUr3zo5J33Vw9AGfxV2kno6WqHJjUCs34p7r+flvaDStPR5g
         Wi0iR6Bgy0CoFuhyUhpXPnJw1qiWbWIdyBrPRjijXApTv7Bgd2TpKpAM0P0WBgyhmf
         UmMFdR04TLZrPUqRPvQm1NJCjtEnFMmee46mV22NBj8Yz5MNfQgpQr070TrLs1M/3O
         7uIyjTXt+IZQGI8s/w0kWD4bFRyqcDfpC4jCZpc2PPJky3tqX+COCLnP1a77lDjE39
         CvNMDxqR3wJjQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 6 May 2020 14:25:18 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] power: supply: bq25890_charger: fix missing unlock
 on error in bq25890_resume()
Message-ID: <20200506122516.GC18376@qmqm.qmqm.pl>
References: <20200506014008.59755-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506014008.59755-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 06, 2020 at 01:40:08AM +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function bq25890_resume()
> in the error handling case.
> 
> Fixes: 72d9cd9cdc18 ("power: bq25890: protect view of the chip's state")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

A similar fix was sent by Dan Carpenter [1]. I'd prefer his version due
to less lines introduced.

[1] https://lore.kernel.org/linux-pm/20200506101116.GA77004@mwanda/

Best Regards,
Micha³ Miros³aw

> ---
>  drivers/power/supply/bq25890_charger.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 9339e216651f..cd9c5ed9bc0c 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -977,14 +977,18 @@ static int bq25890_resume(struct device *dev)
>  	mutex_lock(&bq->lock);
>  
>  	ret = bq25890_get_chip_state(bq, &bq->state);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		mutex_unlock(&bq->lock);
>  		return ret;
> +	}
>  
>  	/* Re-enable ADC only if charger is plugged in. */
>  	if (bq->state.online) {
>  		ret = bq25890_field_write(bq, F_CONV_START, 1);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&bq->lock);
>  			return ret;
> +		}
>  	}
>  
>  	/* signal userspace, maybe state changed while suspended */
> 
> 
> 
