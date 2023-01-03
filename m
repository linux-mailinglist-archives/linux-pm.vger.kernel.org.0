Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A265B9B6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 04:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjACDd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 22:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjACDd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 22:33:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63953C749;
        Mon,  2 Jan 2023 19:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C510861196;
        Tue,  3 Jan 2023 03:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1824C433EF;
        Tue,  3 Jan 2023 03:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672716836;
        bh=xgXMydclE92yA0ZH1ozMDhpXFcx/ctZ7pT0bp0bI+Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7w2SuL/WtP5G2fwqg77r/UYRf0vfcySmICCRycBfOEKBfKQ+fLVd3qPZv7wIb6jG
         iJFqeT5XBN9Zj06siA2wLfCiMJvqKeqsW9sa2zouF4jcpM7j/OWH9h9vEPc6OrTkQe
         BnrRLnbWIiZbpHP0jbsS6bYjBT/FOMhpuIJoCuOH+sK/V+2sk3nBcOpumIZJvO9vzl
         wPsVEP8q1Jo/kgRe04wq+kI/FPVJ+mWCcQneiTrWR3jsFv2y1D/PuBD85l6PkdETwl
         NiMOSXX9HQ7F3gbNCK8D6TysVI+SxY9zXItPiXWV7Ra4wMsof6vfvunl+kqC/rdI53
         /mSZ4tkyGglQg==
Date:   Mon, 2 Jan 2023 21:33:53 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: osm-l3: drop unuserd header inclusion
Message-ID: <20230103033353.u3gzssofbmxlmn7o@builder.lan>
References: <20230103031159.1060075-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103031159.1060075-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 03, 2023 at 05:11:59AM +0200, Dmitry Baryshkov wrote:
> The commit 4529992c9474 ("interconnect: qcom: osm-l3: Use
> platform-independent node ids") made osm-l3 driver use
> platform-independent IDs, removing the need to include platform headers.
> 
> Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 5fa171087425..0c907765783e 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -14,13 +14,6 @@
>  
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  
> -#include "sc7180.h"
> -#include "sc7280.h"
> -#include "sc8180x.h"
> -#include "sdm845.h"
> -#include "sm8150.h"
> -#include "sm8250.h"
> -

Thanks for cleaning this up Dmitry. The <platform>_MASTER_OSM_L3_APPS
and <platform>_SLAVE_OSM_L3 in these header files could also be removed,
if you would like.

Either way, you have my:

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

>  #define LUT_MAX_ENTRIES			40U
>  #define LUT_SRC				GENMASK(31, 30)
>  #define LUT_L_VAL			GENMASK(7, 0)
> -- 
> 2.39.0
> 
