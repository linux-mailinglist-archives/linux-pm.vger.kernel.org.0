Return-Path: <linux-pm+bounces-14939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E36B98A3F5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D74B21848
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014918E36E;
	Mon, 30 Sep 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyqMIxbo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870517A924;
	Mon, 30 Sep 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701636; cv=none; b=GU5evT4Jfo6TEpCVHLSKhTOA/EGfHh1dn4LtBiB2qgpMkv7vHg0wwwwGcLpSzGmM+/7yZlWzRjgJAxyHF1MFkeyf3sFSePfsL7bS8h7Rcf0Y1Q0GPIa1GQTJB4tYR0juhv3uxWWttUcBdtuo40UuZeDL6EbcTvTWLQja2AIe5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701636; c=relaxed/simple;
	bh=SivhM6ZoLQMeDfLky8KH9aodMb9JJD6XQTJklNmPg30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6VQWNrWvr/4uU4EqeDms6Y5FMNxVTDSJDUW7/6kuDwVoHXCVcUMf3tqTYOFuqzMPf4pOJ4AxCpiWppCKoC1GZv96pA9QOhFJw2mf6javAS9LuXhselUmu8p65GkS2LRlOdsdhEam39E1sOPcVKUWyRmF+zfxrWfKGD8nTmyiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyqMIxbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8577C4CEC7;
	Mon, 30 Sep 2024 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727701635;
	bh=SivhM6ZoLQMeDfLky8KH9aodMb9JJD6XQTJklNmPg30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyqMIxboKpU0SvltvGhCHepFhhSC2PP/tSKD9Wq+vacE+B+DqNRS3jVdafx4STNDr
	 /jAO/SAJrgvOrM+GbWkpXeRjdSfQFKdA0vCcznu1XRUK5qcJt4ooAtRLBeyx1pb/IR
	 DdRDro7Oba9sM9qwaOs545GW7B1y2lLyv0NAhXIsMa690Wvse8du9e9CXHQ386dSCV
	 oP7pjM8sUweeWHInVmUeVXbAmmJr94ZhsECINP31Sm0zv0oOlTs393jSEtd/OLcZLV
	 MJwXByWCE5fjbQk2dAT/+2BYFNdOGOU4UXh6VnIfVus1UsTejjKOErqWFw7WJu5oMs
	 pGzsUmjEUZSyA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1svG7N-0000000046x-2meR;
	Mon, 30 Sep 2024 15:07:14 +0200
Date: Mon, 30 Sep 2024 15:07:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Zijun Hu <zijun_hu@icloud.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] PM: sleep: wakeirq: Fix a serious logical error in
 dev_pm_disarm_wake_irq()
Message-ID: <ZvqigTC7RvngLpme@hovoldconsulting.com>
References: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>

On Sat, Sep 28, 2024 at 02:26:27AM -0700, Zijun Hu wrote:
> IT is a serious logical error for dev_pm_disarm_wake_irq() not to disable
> the wake irq enabled by dev_pm_arm_wake_irq()

You need to explain *why* you believe this is an error.

> fixed by simply correcting
> the wrong if condition.

Your commit message is basically just claims "P is wrong, fix P", which
doesn't really explain anything.

Writing good commit messages explaining what the problem is is not just
required because this is a collaborative project where others need to
understand your reasoning, but it also forces you as the author to think
through your changes, which can often prevent broken patches from being
submitted in the first place.

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> List relevant commits as following:
> 
> johan+linaro@kernel.org  2023-07-13
> Commit: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
> 
> tony@atomide.com  2018-02-09
> Commit: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")
> 
> The former commit fixes the later.

These references are relevant, but you need to include them in your
commit messages (above ---) and explain why.

> ---
>  drivers/base/power/wakeirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 5a5a9e978e85..8b15f9a0e8f9 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -356,7 +356,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
>  		disable_irq_wake(wirq->irq);
>  
>  		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
> -		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
> +		    (wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
>  			disable_irq_nosync(wirq->irq);

I think the current code works as intended.

>  	}
>  }

Johan

