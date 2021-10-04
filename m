Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2915E420A5D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJDLvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 07:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJDLvq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Oct 2021 07:51:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6530161360;
        Mon,  4 Oct 2021 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633348197;
        bh=KBiqrzcAwRWsrKlw41PUsdMJtRzp3fYXDAwRlSIcKvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PxhY6XiiZI7krFdDxegWBt66P+lkcz4bTdUZ3aCAJgo/eU6QNju3uxRt+edX1PTB+
         OTxbjl/bjE/Ne6z3q3zq7m6MWr3J6sHWfuGWyEVEJMcCYLPrHq5D23sCp9tOYivjT6
         fXV2EkMFG8nLtKRnMEB/N0cm8XY2IR0/1CJBZUPJPE6ffCI84/SW4MSCwGfzL7A+b9
         KoFhtbJaSE2YFaGLv56/ZZzzHS7WFFfjPm96e5yh3x8YIKyvrKNiBMg80i2DeeLmNo
         5d8OYRYzYHElhkfakdVxZJc4AkkRLR62PcIFoI6ltjfwe5dt2fj+Hrs7Raxpssd6hI
         IsJFRm1aZB/9Q==
Message-ID: <325e88cc-300e-1b43-881d-5717f73b337a@kernel.org>
Date:   Mon, 4 Oct 2021 14:49:52 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/11] interconnect: icc-rpm: move bus clocks handling
 into qnoc_probe
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-2-dmitry.baryshkov@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20210903232421.1384199-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Dmitry

Thank you for working on this!

On 4.09.21 2:24, Dmitry Baryshkov wrote:
> All icc-rpm drivers use the same set of bus clocks. Move handling of bus
> clocks to qnoc_probe. This both simplifies the code and allows using
> qnoc_probe as device's probe funcion.

Nit: s/funcion/function/

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 22 ++++++++++++++--------
>   drivers/interconnect/qcom/icc-rpm.h |  5 ++---
>   drivers/interconnect/qcom/msm8916.c | 13 +------------
>   drivers/interconnect/qcom/msm8939.c | 13 +------------
>   drivers/interconnect/qcom/qcs404.c  | 13 +------------
>   5 files changed, 19 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 54de49ca7808..394f515cc88d 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -86,8 +86,11 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   	return 0;
>   }
>   
> -int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
> -	       const struct clk_bulk_data *cd)
> +static const char * const bus_clocks[] = {
> +	"bus", "bus_a",
> +};
> +
> +int qnoc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	const struct qcom_icc_desc *desc;
> @@ -97,6 +100,8 @@ int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
>   	struct qcom_icc_provider *qp;
>   	struct icc_node *node;
>   	size_t num_nodes, i;
> +	const char * const * cds;

Nit: const char * const *cds;

Thanks,
Georgi
