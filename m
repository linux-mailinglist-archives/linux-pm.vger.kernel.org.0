Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A462B6EAB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgKQTb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 14:31:59 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:59010 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKQTb7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 14:31:59 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 14:31:58 EST
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 0766FC426B; Tue, 17 Nov 2020 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1605640941; bh=fNVLaeLK89HxXWT1t4MQYc0C+RfxRj4ffhGGgo+FdT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xPgauBoUP0hJZrqL1JzyyOOM3kwzCyBxckF/XM4xHw0QCjCiX19KeLqDmRrKuJ4Cu
         /R5Hatof4U+2LjQ5rtWjdZDX5mIZu9M89EwyawR1ab3yLoxiSumNuqzNtowuD3Y/Sb
         r8gwoy4KtastSHVkUht6x9m1/WAWegw+/3cwObjY=
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on arch-vps
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from g550jk.localnet (80-110-101-0.cgn.dynamic.surfer.at [80.110.101.0])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D4D12C41C4;
        Tue, 17 Nov 2020 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1605640939; bh=fNVLaeLK89HxXWT1t4MQYc0C+RfxRj4ffhGGgo+FdT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Uayn81f9Tl+iUcaN02xegWm30zMMzQ0onSzs5MMwnYc1+chO0ibSljQOYJg2psSN6
         XW1DYIpZ3S6FpIOAofLOcbSZ/Ef8yZH7rNFAVndi05fdVeONqu0oEs717Tt/39VDEN
         9StYAjC1baOyqclWUvyajPxCTQtmaGgy4vKEJZtw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-pm@vger.kernel.org, masneyb@onstation.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, saravanak@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] interconnect: qcom: msm8974: Don't boost the NoC rate during boot
Date:   Tue, 17 Nov 2020 20:22:18 +0100
Message-ID: <12664003.xQlZNtUij4@g550jk>
In-Reply-To: <20201109124512.10776-1-georgi.djakov@linaro.org>
References: <20201109124512.10776-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi

On Montag, 9. November 2020 13:45:12 CET Georgi Djakov wrote:
> It has been reported that on Fairphone 2 (msm8974-based), increasing
> the clock rate for some of the NoCs during boot may lead to hangs.
> Let's restore the original behavior and not touch the clock rate of
> any of the NoCs to fix the regression.
> 
> Reported-by: Luca Weiss <luca@z3ntu.xyz>
> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Tested-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  drivers/interconnect/qcom/msm8974.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8974.c
> b/drivers/interconnect/qcom/msm8974.c index b6b639dad691..da68ce375a89
> 100644
> --- a/drivers/interconnect/qcom/msm8974.c
> +++ b/drivers/interconnect/qcom/msm8974.c
> @@ -637,6 +637,14 @@ static int msm8974_icc_set(struct icc_node *src, struct
> icc_node *dst) return 0;
>  }
> 
> +static int msm8974_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}
> +
>  static int msm8974_icc_probe(struct platform_device *pdev)
>  {
>  	const struct msm8974_icc_desc *desc;
> @@ -690,6 +698,7 @@ static int msm8974_icc_probe(struct platform_device
> *pdev) provider->aggregate = icc_std_aggregate;
>  	provider->xlate = of_icc_xlate_onecell;
>  	provider->data = data;
> +	provider->get_bw = msm8974_get_bw;
> 
>  	ret = icc_provider_add(provider);
>  	if (ret) {

Regards
Luca


