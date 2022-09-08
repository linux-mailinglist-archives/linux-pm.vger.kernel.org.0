Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D835B277B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIHUOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIHUOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 16:14:53 -0400
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 13:14:49 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5122B21;
        Thu,  8 Sep 2022 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1662667724;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aflwltrHiiEDzBeUTvc0FxN/oaTl0V0stM/8PvRhg4E=;
    b=tYabJ7TJLNKDx+27AYXlC9Qn+KUnKzPN1vNRJmxLT0Ga+9fDFvPfpv/+brzP+ypnJv
    b/ep1afC2iajP134JfAqL6HwuYnfM1GRtQIudtxxaDeo5jVy9VbB0PhPGX1kEg9LQWG+
    /xHsivlbLD30t6Y7Kzml+tYWGWAA+/P/o4QJUvDQy2Er7wdkaq8T8Z6hzJXdSFOYr8tX
    lSNmyi7mKaH2FqaQc1xlMm/cKzhv48uizQr5u7krSG/djzZWVZ1/t/PPkx+osd2oZQwg
    LQgMIB+42qbTZjYn+ajaGoE8KO+SRiQbBgqVdj+jedwLe2Va3nZZ3pQSEmwmbkMf0REm
    LJmg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrKw8+6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.0.2 SBL|AUTH)
    with ESMTPSA id I8c97dy88K8h9pz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Sep 2022 22:08:43 +0200 (CEST)
Date:   Thu, 8 Sep 2022 22:08:35 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: Re: [PATCH 0/3] thermal: qcom: tsens: Add data for MSM8909
Message-ID: <YxpLw2HzKGXF70ml@gerhold.net>
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Mon, Jun 27, 2022 at 03:14:12PM +0200, Stephan Gerhold wrote:
> The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block similar to
> MSM8916. Add the data for MSM8909 to the existing tsens-v0_1.c driver
> to make the thermal sensors work on MSM8909.

Can you take a look at this series when you get a chance? It should be
mostly straightforward since it's just another platform with code
similar to the existing ones.

The series still applies cleanly on latest thermal/linux-next. But
just let me know if I should resend it anyway. :)

Thanks!
Stephan

> 
> Stephan Gerhold (3):
>   dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
>   dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
>   thermal: qcom: tsens: Add data for MSM8909
> 
>  .../bindings/thermal/qcom-tsens.yaml          |   6 +-
>  drivers/thermal/qcom/tsens-v0_1.c             | 119 +++++++++++++++++-
>  drivers/thermal/qcom/tsens.c                  |   3 +
>  drivers/thermal/qcom/tsens.h                  |   2 +-
>  4 files changed, 123 insertions(+), 7 deletions(-)
> 
> -- 
> 2.30.2
> 
