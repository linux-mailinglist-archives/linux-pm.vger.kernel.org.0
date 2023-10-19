Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7847CFD73
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbjJSO7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbjJSO7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 10:59:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159C11D;
        Thu, 19 Oct 2023 07:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697727581; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g8FQDeKxNT0R1opad9aOo0xT9p+jar6GD871gC+T6jwpu8mT8eiiInG7qkt6660mSA
    XaBtyNHULC+14F7cRkEJqzjWkUHuKM8d+drhUEoeEzwUh8mLzLdM9FtOHpkbWUO17Owb
    2h7tYrZ8Zjd7afQn9yy9j6SIyJfiMp9kNYGT/ijY3g74IBPdnd6YlFKKknutYOlnVi3A
    7qGEgLxycdsXRaCjPqSTAZvpLBUPkdz8qTxWilWYbenNFjpUW3wXd/Mzur5dIkVZx65c
    vHlXlfkY75yqBSSIYZxfPi8uH9NVvUGVSbVw69wTUD0PwsPgk20bOvFbC2QMwhmHlpzu
    kuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697727581;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=N1CnME7wJhS0V+YQFSeOe9bAMJremm9d8zG1ZuZQ814=;
    b=glaybUzoHuQDaNEkgZakeCQNeAbHAsXcOiUY1to/vmTxL7mdTLeTPE2I+xmWsIhUeP
    zbUNtGJOo1t3Wws1BoLSz7jhso9oxKmKnaL92YV+yRJ/RuzbVT06mCayAJKepzl/+LLS
    TRa/wmvqy3rSDMjqRqba34XCUvm6VGgYpQi12dT58BdJj6PQkLQl+Ema0AYArua1R4fl
    lA/UQ5l2YDfAf+xXW9qun1NdboRuhkSvzT6dWUj8RqQu8WqXDGETvlJyeLazwE5vFWCB
    TYEjqRY3lKWfn2yi3Hd+ITSFpQAGIf4DNZ0LeEGxBRKJ6F7NnafXieENOaf7eeuxlHNy
    t0gQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697727581;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=N1CnME7wJhS0V+YQFSeOe9bAMJremm9d8zG1ZuZQ814=;
    b=YQxwJI2PmKBXOrQIsWPip1tfmty83ALFXZkb8JeORK/WIyAwh/cONp47MlNXgFNXGX
    q+V8xhkIab/jdORO90emXs0nxer+mWHNpD40A22AQYLBWcUk1BHBIFW+43404fNL4qk1
    zF4bH2od+aZFNdudHG23wkYrvTrM6TIy/cDa/0xOm7aSXv9FLuSP3sE24g2nkdzRzaiO
    gdjxzsDXS5Ui1RmzTaeL8QQ4a4TYMT1uRkKewt8jwLWtLRJqIe8SP4RFQoGC9sgda+o0
    iZy/t/j5utBAvZE+74T/66lOJIyUO3TwnL5ExpJAGGvzFhX4NnN4OfFvdyYjaoC4Xa1r
    r+kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697727581;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=N1CnME7wJhS0V+YQFSeOe9bAMJremm9d8zG1ZuZQ814=;
    b=j9r9Ja0RAsnhmiY91hr4hwd85pX5T5srPsikk5XMv7dP9Qi3dhOgSNOdu6BaObufOb
    58xRnKvDXFqER2BkRKBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9JExeE7I
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 Oct 2023 16:59:40 +0200 (CEST)
Date:   Thu, 19 Oct 2023 16:59:34 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal/qcom/tsens: drop ops_v0_1
Message-ID: <ZTFEVpNOkGedJGoj@gerhold.net>
References: <20231019144311.1035181-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019144311.1035181-1-dmitry.baryshkov@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 19, 2023 at 05:43:11PM +0300, Dmitry Baryshkov wrote:
> Since the commit 6812d1dfbca9 ("thermal/drivers/qcom/tsens-v0_1: Fix
> mdm9607 slope values") the default v0.1 implementation of tsens options
> is unused by the driver. Drop it now to stop compiler complaining about
> the unused static const. If the need for the default v0.1 ops struct
> arives, this commit can be easily reverted without further
> considerations.
> 
> Fixes: 6812d1dfbca9 ("thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Seems like I remember correctly that there was a patch for this already
that wasn't picked up yet(?):
https://lore.kernel.org/linux-arm-msm/20230617113837.3224912-1-trix@redhat.com/

It doesn't have the Fixes tag though. I think both patches are fine.
Thanks for fixing this. :-)

Stephan

> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 87c09f62ee81..32d2d3e33287 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -325,12 +325,6 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> -static const struct tsens_ops ops_v0_1 = {
> -	.init		= init_common,
> -	.calibrate	= tsens_calibrate_common,
> -	.get_temp	= get_temp_common,
> -};
> -
>  static const struct tsens_ops ops_8226 = {
>  	.init		= init_8226,
>  	.calibrate	= tsens_calibrate_common,
> -- 
> 2.39.2
> 
