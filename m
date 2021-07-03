Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE15B3BA858
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jul 2021 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGCLK4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Jul 2021 07:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhGCLK4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Jul 2021 07:10:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E0FD6162A;
        Sat,  3 Jul 2021 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625310503;
        bh=la7QnelDNFLhNjusTN/qGJQp8b6+XlbmXDa/JaB3FIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMxLJ7Zrihaykg0n7Ky0Nq83U57Z8EB+sMgZlxbrK1YyM/yWDYFnMDzDAkufeXH1O
         YxWu0HoVP4OEQcF6W/IBJ4LEneFyzcogTfKsc+Hxtl8jheMyQPA9n+G+6goD9CwmPg
         iKJ5GPsI3HoVC3tawow3mWuCiWdtRUHiuwohfv9lin3Zta91D5Bv97MrLqv5B0vrSx
         FQJs1v5AMozJmClSLUxySDlmlVju39IAl17/35nfoNyGLwSFm1NibqVM8FFjeX4K1w
         ffEM0x6TVDHUdIfnbc5pnlqFUqoZusMbQdiFpDl7Num0Tth9M36lEGO6072q2ouMcX
         4lWRor0gpCSOQ==
Date:   Sat, 3 Jul 2021 19:08:09 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 05/12] usb: otg-fsm: Fix hrtimer list corruption
Message-ID: <20210703110809.GA4289@Peter>
References: <20210701234317.26393-1-digetx@gmail.com>
 <20210701234317.26393-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701234317.26393-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-07-02 02:43:10, Dmitry Osipenko wrote:
> The HNP work can be re-scheduled while it's still in-fly. This results in
> re-initialization of the busy work, resetting the hrtimer's list node of
> the work and crashing kernel with null dereference within kernel/timer
> once work's timer is expired. It's very easy to trigger this problem by
> re-plugging USB cable quickly. Initialize HNP work only once to fix this
> trouble.

Fully OTG compliance support has not maintained for years, what's the use case you
still want to use?

Peter
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/common/usb-otg-fsm.c | 6 +++++-
>  include/linux/usb/otg-fsm.h      | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index 3740cf95560e..0697fde51d00 100644
> --- a/drivers/usb/common/usb-otg-fsm.c
> +++ b/drivers/usb/common/usb-otg-fsm.c
> @@ -193,7 +193,11 @@ static void otg_start_hnp_polling(struct otg_fsm *fsm)
>  	if (!fsm->host_req_flag)
>  		return;
>  
> -	INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
> +	if (!fsm->hnp_work_inited) {
> +		INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
> +		fsm->hnp_work_inited = true;
> +	}
> +
>  	schedule_delayed_work(&fsm->hnp_polling_work,
>  					msecs_to_jiffies(T_HOST_REQ_POLL));
>  }
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index 3aee78dda16d..784659d4dc99 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -196,6 +196,7 @@ struct otg_fsm {
>  	struct mutex lock;
>  	u8 *host_req_flag;
>  	struct delayed_work hnp_polling_work;
> +	bool hnp_work_inited;
>  	bool state_changed;
>  };
>  
> -- 
> 2.30.2
> 

-- 

Thanks,
Peter Chen

