Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F638F928
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 06:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhEYECA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 00:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhEYEBx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 00:01:53 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AE2C061574
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 21:00:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z3so29057520oib.5
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oh710QQejYAa/mMoSLfvFL7EfG7/Je5p6f7tFmEhnw4=;
        b=Lj/p6gTvFjWagEJ3E2jFBMnF33As6gsxt+ZZqvFVYAm906xXsobeCfECstnZNQWfBv
         I92wK2Ih3cCKZQa5cLrZT1qA7oYlxOZrSBXPCoEimWSuan4v72vGo7f0hVFfC1Hn8eVh
         pzfqJvybomagpib2pVXJzfNGpBwpnuIg2MO97Clg5PTFZSOpGpHjCo4vnx1o2MqqHpyc
         vHFqtG8sfNL3SqprePO0YeQOJOokXUiSCF/8Xnlih0kcW9K3UIBgFOCZk+DEArHlpKhY
         QI2xUPNdLlZfTL2cK80k6zrYKEnV6ZWy+w38TNWauON2WOKa8x+bh+W2QBgF8oKzB1X5
         1wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oh710QQejYAa/mMoSLfvFL7EfG7/Je5p6f7tFmEhnw4=;
        b=jxctQHKxUnrPnHmz7GAgHuxxZnKlMX+LCmDqaueXmc2OwpTRWW+AztIuNFYfoRkIPS
         F7UPPg+DSOqrEsyQBrhdMshbcrvpn2CR76QjLjMaSN562rjUm4y3LYGgwi9i2Fubom6H
         nFq29Ywv7duohUvX5S2TuUtjXvHNaFvOj0tt9LH9/PThhVcIbsQzhQw6jWVVceYW1Sjp
         v99JfgqbNWdEsR/nlSnyS9+Hbhfig+GtZ6y/TLE8WlQ8OyYsBBmiy2nmu/tMdZNYi1bc
         OcHOhb0cIad/NQFf91E2dy4MSTKbLuTvWl5UZlDzBHcIkmnVQI/1/uGrdA2PQ1ECdp8v
         VBWA==
X-Gm-Message-State: AOAM530PHwkbACqcER5KKFMdq8Rl+Ewwl1gBHznyTxBHIaQvLWbaMY+/
        3KQuWqTQqBr21kYkjWzk2TzIsw==
X-Google-Smtp-Source: ABdhPJzI7cE9gO2RAm4cn+ip07Ogo8f5FMCJmRBeiwUM2vJFPJiH3r3h8BzxlP/VGkMzSJypkkVgWw==
X-Received: by 2002:aca:f207:: with SMTP id q7mr1526806oih.24.1621915224285;
        Mon, 24 May 2021 21:00:24 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e83sm2967141oia.40.2021.05.24.21.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 21:00:23 -0700 (PDT)
Date:   Mon, 24 May 2021 23:00:20 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <nks@flawful.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: AVS: qcom-cpr: Use
 nvmem_cell_read_variable_le_u32()
Message-ID: <YKx2VGxuPg3EPSMA@yoga>
References: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 21 May 15:44 CDT 2021, Douglas Anderson wrote:

> Let's delete the private function cpr_read_efuse() since it does the
> basically the same thing as the new API call
> nvmem_cell_read_variable_le_u32().
> 
> Differences between the new API call and the old private function:
> * less error printing (I assume this is OK).
> * will give an error if the value doesn't fit in 32-bits (the old code
>   would have truncated silently).
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I haven't done any more than compile-test this. Mostly I'm just
> writing this patch because it helped provide inspiration for the
> general API function.
> 
> Changes in v2:
> - Resending v1 as a singleton patch; dependency is merged in mainline.
> 
>  drivers/soc/qcom/cpr.c | 43 +++++-------------------------------------
>  1 file changed, 5 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
> index b24cc77d1889..4ce8e816154f 100644
> --- a/drivers/soc/qcom/cpr.c
> +++ b/drivers/soc/qcom/cpr.c
> @@ -801,38 +801,6 @@ static int cpr_set_performance_state(struct generic_pm_domain *domain,
>  	return ret;
>  }
>  
> -static int cpr_read_efuse(struct device *dev, const char *cname, u32 *data)
> -{
> -	struct nvmem_cell *cell;
> -	ssize_t len;
> -	char *ret;
> -	int i;
> -
> -	*data = 0;
> -
> -	cell = nvmem_cell_get(dev, cname);
> -	if (IS_ERR(cell)) {
> -		if (PTR_ERR(cell) != -EPROBE_DEFER)
> -			dev_err(dev, "undefined cell %s\n", cname);
> -		return PTR_ERR(cell);
> -	}
> -
> -	ret = nvmem_cell_read(cell, &len);
> -	nvmem_cell_put(cell);
> -	if (IS_ERR(ret)) {
> -		dev_err(dev, "can't read cell %s\n", cname);
> -		return PTR_ERR(ret);
> -	}
> -
> -	for (i = 0; i < len; i++)
> -		*data |= ret[i] << (8 * i);
> -
> -	kfree(ret);
> -	dev_dbg(dev, "efuse read(%s) = %x, bytes %zd\n", cname, *data, len);
> -
> -	return 0;
> -}
> -
>  static int
>  cpr_populate_ring_osc_idx(struct cpr_drv *drv)
>  {
> @@ -843,8 +811,7 @@ cpr_populate_ring_osc_idx(struct cpr_drv *drv)
>  	int ret;
>  
>  	for (; fuse < end; fuse++, fuses++) {
> -		ret = cpr_read_efuse(drv->dev, fuses->ring_osc,
> -				     &data);
> +		ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->ring_osc, &data);
>  		if (ret)
>  			return ret;
>  		fuse->ring_osc_idx = data;
> @@ -863,7 +830,7 @@ static int cpr_read_fuse_uV(const struct cpr_desc *desc,
>  	u32 bits = 0;
>  	int ret;
>  
> -	ret = cpr_read_efuse(drv->dev, init_v_efuse, &bits);
> +	ret = nvmem_cell_read_variable_le_u32(drv->dev, init_v_efuse, &bits);
>  	if (ret)
>  		return ret;
>  
> @@ -932,7 +899,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
>  		}
>  
>  		/* Populate target quotient by scaling */
> -		ret = cpr_read_efuse(drv->dev, fuses->quotient, &fuse->quot);
> +		ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->quotient, &fuse->quot);
>  		if (ret)
>  			return ret;
>  
> @@ -1001,7 +968,7 @@ static int cpr_calculate_scaling(const char *quot_offset,
>  	prev_fuse = fuse - 1;
>  
>  	if (quot_offset) {
> -		ret = cpr_read_efuse(drv->dev, quot_offset, &quot_diff);
> +		ret = nvmem_cell_read_variable_le_u32(drv->dev, quot_offset, &quot_diff);
>  		if (ret)
>  			return ret;
>  
> @@ -1701,7 +1668,7 @@ static int cpr_probe(struct platform_device *pdev)
>  	 * initialized after attaching to the power domain,
>  	 * since it depends on the CPU's OPP table.
>  	 */
> -	ret = cpr_read_efuse(dev, "cpr_fuse_revision", &cpr_rev);
> +	ret = nvmem_cell_read_variable_le_u32(dev, "cpr_fuse_revision", &cpr_rev);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.31.1.818.g46aad6cb9e-goog
> 
