Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1D56B5D6
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiGHJoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiGHJoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 05:44:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEF276EB7;
        Fri,  8 Jul 2022 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657273441;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=D2FVSvuS6dyJ9GV0Ydxqjb+gSLYsXaIVuegs6SgQcDQ=;
    b=YanyJmF5pSsskp4apspShVQXE4v0aHKTBIYaCARPwpTUlCiTIRCPBkX4CWUByvtIHt
    2RNMhCF9Ofs4831ZE78Ya1lXZb/9JXsSSnn2ZPLU+4L95+RWDnhUxLdqmhviMnsS6SgH
    Zra58x876ZcBX+TqkChFKBa/pxHCDbPgF8hIYjrg5eKb0HP5bieCThIUfCuBWk4km/+j
    MvtCpRqOQBnmwuP37WwENp7B1roS5rgaf8r/DhILCguWMpqxdHjqJzQ9a1m8uXLZZ+51
    WH78rnw+51szchM6ukcgVr6c79KtGkuEUMsytGR+bOMBRowJ48dftx0yAgdTE0bEfvuJ
    1ekA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw8+6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id yfdd30y689i1S9R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Jul 2022 11:44:01 +0200 (CEST)
Date:   Fri, 8 Jul 2022 11:43:49 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] cpufreq: blocklist Qualcomm msm8939 in
 cpufreq-dt-platdev
Message-ID: <Ysf8VRaXdGg+8Ev3@gerhold.net>
References: <20220708014419.2009018-1-bryan.odonoghue@linaro.org>
 <20220708014419.2009018-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708014419.2009018-5-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 08, 2022 at 02:44:19AM +0100, Bryan O'Donoghue wrote:
> msm8939 will use qcom-cpufreq-nvmem. Block it on the generic cpufreq-dt
> list.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Personally I would defer this patch as well until cpufreq is properly
enabled on msm8939 together with the qcom-cpufreq-nvmem changes and CPR.

I'm not strictly opposed to get this in now, but it also does not really
make any functional difference, or does it?

> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 2c96de3f2d83c..26c97ab778974 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -137,6 +137,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "nvidia,tegra210", },
>  
>  	{ .compatible = "qcom,apq8096", },
> +	{ .compatible = "qcom,msm8939", },
>  	{ .compatible = "qcom,msm8996", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,sa8155p" },
> -- 
> 2.36.1
> 
