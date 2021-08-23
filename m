Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBF3F4FA3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhHWRis (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 13:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhHWRip (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 13:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0ADB6136F;
        Mon, 23 Aug 2021 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629740282;
        bh=x4MlFpqxl6ajTVhBSqLNVs0i4vGMFw/x3MAuCoHtdGA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TWZifOzwoPm4sKr/O/Rr1wNUiKwCWwM8SjKBqUtiqkovCJIRksvN9Hi4x+L5NGUl7
         EcIca5KPfgSXZrk/TzL+ERAyC8iM/27BOLJL4nQCXUPCGqZ6qK0joUq8/1by4ptmEV
         6OizLwvoy7S6Vp69jkGpz4wqECWc3iP0umIkNIEdPx20UKloV+uyRXWPE/tRG8OnUM
         YEFZtejAP44c1Xqd/xsMwgBvK0Sy9O/Ot4dqvQxpBPgaRcKn34RBD17UN1jJn98AqU
         pt2s+6kdZbncrnljuappCDAbG2SPYNjcD5xprnYqYn8lBkQczD9dwpWnIS/UT8sKqx
         4V+cN/I/3GwDQ==
Subject: Re: [PATCH 1/5] interconnect: icc-rpm: move bus clocks handling into
 qnoc_probe
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
 <20210818015732.1717810-2-dmitry.baryshkov@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <502a616d-a8aa-528e-d60f-85b05317b410@kernel.org>
Date:   Mon, 23 Aug 2021 20:37:58 +0300
MIME-Version: 1.0
In-Reply-To: <20210818015732.1717810-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Thank you for working on this!

On 18.08.21 4:57, Dmitry Baryshkov wrote:
> All icc-rpm drivers use the same set of bus clocks. Move handling of bus
> clocks to qnoc_probe. This both simplifies the code and allows using
> qnoc_probe as device's probe funcion.
> 

s/funcion/function/

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

Please use: const char * const *cds;

Thanks,
Georgi
