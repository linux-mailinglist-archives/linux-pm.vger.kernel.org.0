Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49933BC475
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 02:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhGFBAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 21:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhGFBAX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jul 2021 21:00:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A021F6195E;
        Tue,  6 Jul 2021 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625533065;
        bh=3sZXtqzPBmQeDtxCNP5rxxVJeRlFAwqPjm3IYlPYZLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dq0wOX39lFI1rViG4OrBnjClqeJW3nZ6ovSvlw0cGfvB/K7EZnA2KWFcshzstdftr
         HBhNWQle5uDA/IYsbJJe66Z3i7Clq7NeQVE0ulqNAg9P0Ffqics1ANoyUh5mfCEMlG
         mit6X+HBvVHHxhehKOAc7ro31jW7FEeOJbLylbc1PUAF3FPnSTYyU//AONbpKd/N+q
         AxGU7cixYxF1iN13OsBzD2PsXkcd9VGZJTikRuI1SglIba7jKpUGU1JGE03XYv1lQr
         PAE1FCLFp/94YhmxXxGjYQKcXvclDu/mA7cPXD1rURIycDkxfFf57vW+gpL/9Ovo2l
         POJBzuN21/m5A==
Date:   Tue, 6 Jul 2021 08:57:39 +0800
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
Subject: Re: [PATCH v3 05/12] usb: otg-fsm: Fix hrtimer list corruption
Message-ID: <20210706005739.GA19143@nchen>
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704225433.32029-6-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-07-05 01:54:26, Dmitry Osipenko wrote:
> The HNP work can be re-scheduled while it's still in-fly. This results in
> re-initialization of the busy work, resetting the hrtimer's list node of
> the work and crashing kernel with null dereference within kernel/timer
> once work's timer is expired. It's very easy to trigger this problem by
> re-plugging USB cable quickly. Initialize HNP work only once to fix this
> trouble.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

It is better to append kernel dump if you have v4 patchset.

Peter

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
> 2.32.0
> 

-- 

Thanks,
Peter Chen

