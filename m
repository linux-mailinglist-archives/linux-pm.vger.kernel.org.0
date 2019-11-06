Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04E4F225C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 00:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKFXKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 18:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfKFXKH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Nov 2019 18:10:07 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CD820869;
        Wed,  6 Nov 2019 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573081806;
        bh=phPqrB8jdcQhMXpI7PNcLtByNjzRwAfdzJcKYVWr13E=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=Ujuxe6X1kCsRkxtdQYgSWiR0mYrSc9nQP1ygJUr45CCctRkVEX2Jf9Wnp4kkOvTVm
         GBOqu/HNFeA6cJMT7QS6PMnl2OKfLo3pUAUZ0MAZ1yEG1+KPhxkjhqPb0cTze2UIjW
         qce2kBf6A/GX0fvsfQmdvN+ylBBREGi5gRasWjRE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
Subject: Re: [PATCH v9 07/22] clk: Add API to get index of the clock parent
From:   Stephen Boyd <sboyd@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, jason@lakedaemon.net,
        jonathanh@nvidia.com, linus.walleij@linaro.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, stefan@agner.ch,
        tglx@linutronix.de, thierry.reding@gmail.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        skomatineni@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, mperttunen@nvidia.com,
        spatra@nvidia.com, robh+dt@kernel.org, digetx@gmail.com,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 15:10:05 -0800
Message-Id: <20191106231005.F2CD820869@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Sowjanya Komatineni (2019-08-16 12:41:52)
> This patch adds an API clk_hw_get_parent_index to get index of the
> clock parent to use during the clock restore operations on system
> resume.

Is there a reason we can't save the clk hw index at suspend time by
reading the hardware to understand the current parent? The parent index
typically doesn't matter unless we're trying to communicate something
from the framework to the provider driver. Put another way, I would
think the provider driver can figure out the index itself without having
to go through the framework to do so.

>=20
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index cbcc333aec84..12ad0e9b8591 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1645,6 +1645,23 @@ static int clk_fetch_parent_index(struct clk_core =
*core,
>         return i;
>  }
> =20
> +/**
> + * clk_hw_get_parent_index - return the index of parent clock
> + * @hw: clk_hw associated with the clk being consumed
> + * @parent_hw: clk_hw associated with the parent of clk
> + *
> + * Fetches and returns the index of parent clock.
> + * If hw or parent_hw is NULL, returns -EINVAL.
> + */
> +int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent_hw)
> +{
> +       if (!hw || !parent_hw)
> +               return -EINVAL;

The caller should be ashamed if they call this with NULL arguments.
I'd prefer we skip this check and we get an oops.

> +
> +       return clk_fetch_parent_index(hw->core, parent_hw->core);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
> +
>  /*
>   * Update the orphan status of @core and all its children.
>   */
