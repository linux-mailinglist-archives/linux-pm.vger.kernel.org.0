Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E256D40C156
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 10:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhIOILo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 04:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236965AbhIOILG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Sep 2021 04:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD332611AF;
        Wed, 15 Sep 2021 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631693387;
        bh=u25hOeQbvYR4QZ2+ydh3BaVFfAgOWaJC7fn8kmf4Am4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S4lAJzytvs7OVbXEWu23VNSM+MDzyUc9GiwKq017B0jFyXvUTDsQsRmRxpUq7DxN9
         M9bDebwWaYCoN9W8/jip/U7Rl9fU5f5oFTtaAVs5W1bM8M/3GIa+7SncQgPbwuFezX
         zRcJPVb6HYO+ScE1knq6j9Xo3lCeZgbD/W7Gfrd54Dq6zwk8Dw/nv5M8UrMaCoDYt9
         s9ACdP11+wYtt2X4pWLvwJZcNHfkGsF8XQP70CnlmafkBflL54olTf3vWh6R/LvN2P
         h39B4mJ1p4fpNzXuZNqTQLAFlOwoCTytAhT6E2FUzXqUVatVjZ/kRN/PDKApthecMa
         Uk/okuAUJbV1w==
Subject: Re: [RFC 01/19] dt-bindings: interconnect: imx8mq: Add missing pl301
 and SAI ids
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <1631554694-9599-2-git-send-email-abel.vesa@nxp.com>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <096f0e8a-2215-6506-330f-a9cbfc8ddfe6@kernel.org>
Date:   Wed, 15 Sep 2021 11:09:40 +0300
MIME-Version: 1.0
In-Reply-To: <1631554694-9599-2-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abel,

On 13.09.21 20:37, Abel Vesa wrote:
> According to the bus diagram, there are two more pl301s that need to
> be added here. The pl301_per_m which is an intermediary node between
> pl301_main and its masters: usdhc1, usdhc2 and sdma. The pl301_wakeup
> is an intermediary node between pl301_main and its masters, in this case
> all the SAIs.

Thanks for working on this!

> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   include/dt-bindings/interconnect/imx8mq.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/interconnect/imx8mq.h b/include/dt-bindings/interconnect/imx8mq.h
> index 1a4cae7f8be2..1953de8af5cb 100644
> --- a/include/dt-bindings/interconnect/imx8mq.h
> +++ b/include/dt-bindings/interconnect/imx8mq.h
> @@ -44,5 +44,14 @@
>   #define IMX8MQ_ICM_PCIE1	26
>   #define IMX8MQ_ICM_PCIE2	27
>   #define IMX8MQ_ICN_MAIN		28
> +#define IMX8MQ_ICN_PER_M	30

Is there any reason to jump from 28 to 30?

Thanks,
Georgi

> +
> +#define IMX8MQ_ICN_WAKEUP	31
> +#define IMX8MQ_ICM_SAI1		32
> +#define IMX8MQ_ICM_SAI2		33
> +#define IMX8MQ_ICM_SAI3		34
> +#define IMX8MQ_ICM_SAI4		35
> +#define IMX8MQ_ICM_SAI5		36
> +#define IMX8MQ_ICM_SAI6		37
>   
>   #endif /* __DT_BINDINGS_INTERCONNECT_IMX8MQ_H */
>
