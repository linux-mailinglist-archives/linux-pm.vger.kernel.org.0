Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44435621F6
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiF3SZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiF3SZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 14:25:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BC74198C;
        Thu, 30 Jun 2022 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1656613546;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=jKpOLZ3nRpaJl5v9mgTzY+PZcO79LGbwo/W586DmY7M=;
    b=IG6VnZfMcAzGCLHT/8Lw8hWqsQVzZMl5dngJsG1ipVSpGtGnJbZUg1VgYU6mScmb1v
    mnhDLKFMTUaJ9Kj89dkGBSljHrKIbO99//7WxcWnw9Zv/+feEvqX6x73oFqU6PPpAaQr
    gbN6agnWUkFu6aClF7dx7vEQIl4JMBofnwuJLVO6k53mXe14najEr/IUThLWypCyIhEu
    gNrC/fk3B2aonUUaoeCHiYIU1qOsktH96kISNPMMD9X6o6HxO5+Ik4YpYmy4elyD0RRl
    8M1+Uv62Mm5nKAakxRUXzk/yHH+kWScup+ylPB9gRwciriafvMPv0xMOtTYEG5ChSxyS
    fmpQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK8+86Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id yfdd30y5UIPj4eF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 30 Jun 2022 20:25:45 +0200 (CEST)
Date:   Thu, 30 Jun 2022 20:25:38 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] cpufreq: qcom-cpufreq-nvmem: Rename qcs404
 data to cpr_genpd
Message-ID: <Yr3qogxjA9WGJlDX@gerhold.net>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-5-bryan.odonoghue@linaro.org>
 <Yryj1Nv/Yu8wShzo@gerhold.net>
 <024088fd-1511-7423-55fb-ebcd47a5a6c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024088fd-1511-7423-55fb-ebcd47a5a6c2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 30, 2022 at 05:05:59AM +0100, Bryan O'Donoghue wrote:
> On 29/06/2022 20:11, Stephan Gerhold wrote:
> > On Wed, Jun 29, 2022 at 02:03:02PM +0100, Bryan O'Donoghue wrote:
> > > At the moment the CPR genpd based code is named after the qcs404 however
> > > msm8936, msm8939 and other antecedent processors of the qcs404 can also
> > > make use of this data.
> > > 
> > > Rename it to reflect a more generic use.
> > > 
> > > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > 
> > There is another power domain that needs to be scaled together with the
> > CPU frequency on MSM8916 and MSM8939: (VDD)MX. How do you handle that?
> > 
> 
> Short answer, in another series to enable CPR on 5.x
> 
> We have code for CPR in a 4.19 tree that works but, it needs more work to be
> upstream-fit on 5.x.
> 
> CPR is deliberately omitted here to be submitted later.
> 

I agree with this decision (doing CPR properly is way too complicated to
block the entire msm8939.dtsi with this).

> In this series I'm just switching away from the default cpufreq-dt-platdev
> which breaks booting to qcom-cpufreq-nvmem.
> 
> Fair enough ?

... but then I don't understand: Why do you need this patch set? You
only need to attach the "cpr" power domain in qcom-cpufreq-nvmem if
you're actually using CPR.

I would recommend adding MSM8939 in a similar way to MSM8916, so without
using qcom-cpufreq-nvmem for now. Then we can add CPR on both platforms
in a similar way later.

Thanks,
Stephan
