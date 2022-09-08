Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291DC5B20C1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiIHOh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 10:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiIHOh5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 10:37:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79225113C71
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 07:37:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p7so28068613lfu.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2022 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nAbCObJGrW4tJgQzyhQTlgOAwdzjZ+UNcsNgAoaR8Mk=;
        b=g63v4eTyzIPon5vz7ssslEDOVqngrF1XXUYAMBuLQzC7aWavm7OMEAcvXbBOxFbx3G
         +YYy3S6xhPgy5CfIaCCR91YnGqVpKG4eAF9l2rEo91prydynP+x2EY0Atbwbbj7zx1a7
         ImE2VDwP8ZWLnWMcyIwSj+HS526Phj3mU4vwaiodAHaL0YwxlWoA3bzKJH7myD4ZO3ux
         hbIc/NHaq0qvp3/Cgl6eDEOb0196sCnqMaD5Tm30OgrgjklS7Bb3PVJsAvAXVQPSGg26
         ZmafFE4MPyp+h1h7SXmmYslYgcj+XrXXirwU15/F+bRZPailjIfXdxjzy95pglD0gUzi
         5+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nAbCObJGrW4tJgQzyhQTlgOAwdzjZ+UNcsNgAoaR8Mk=;
        b=Dv0S0iTialytGqlnfPW+Cvb3qr238kfDqwE0NneXz34D/z9kEGjNEjP37hnryiNou9
         +NOjbDCZ85ItLjy0M7xm9hEcOwgw7p9zfKROBh6C1YOj6Xsf14NczojZ+tPA3k8Q1/uX
         bhCoI/nuafBmddrCBt7M/pi1VvN4hF1v9wlaqASl8faTRGzmXpUXcIX0c2mLTLJj5KTU
         UAjTbw5SdJppgaxs/6mRisa5NksfE7nL4TXZ5/yTg0OaJQniu3BGtF8E5f6lTL64T9wr
         dWoJhi99IJ0OHy/nkqrlX2cGOWFm30xNuM90p9OIg1pPIs5Y+5mOXgS2ugtoL69s9PJC
         3FYQ==
X-Gm-Message-State: ACgBeo0c7OnH3Sbrg0C7VTjny5ykfZo8jxQcEL5zDMMMqkL5qnm6mNE/
        2ru7m0uvwWZY9QJv8a3aLmFUDWn1AXK1rV2o9YZ9lQ==
X-Google-Smtp-Source: AA6agR6/y3Npe2+IxNZ93VvMBJGja+V5/n48i3/Flbp8FIOt2Cmq+yQr/9bO+47f0G9udbSPyVvOZHuGD5/BOOLbmCE=
X-Received: by 2002:a05:6512:2629:b0:492:b1e7:bf26 with SMTP id
 bt41-20020a056512262900b00492b1e7bf26mr2654688lfb.254.1662647870144; Thu, 08
 Sep 2022 07:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Sep 2022 16:37:13 +0200
Message-ID: <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi All,
>
> We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> arm_scmi: Add clock management to the SCMI power domain") ,

Hmm, I wonder about the main reason behind that commit. Can we revert
it or is there some platform/driver that is really relying on it?

>
> we use scmi power domain, but not use scmi clk, but with upper commit, the clk is prepared
> when pm_clk_acquire.
>
> However the clk has flag CLK_SET_RATE_GATE, clk_set_rate will fail in driver, because
> clk is prepared in pm_clk_acquire.
>
> Looking into drivers/base/power/clock_ops.c, I see pm_clk_suspend/pm_clk_resume
> will handle clk prepare/unprepared, so why pm_clk_acquire will also prepare the clk?

I agree, the behaviour is certainly questionable to me too. However,
it may be tricky to change by now, due to the deployment that has
happened over the years.

In principle we would need to make the part where pm_clk_acquire
prepares the clock to become optional, in some clever way.

>
>
> Thanks,
> Peng.

Kind regards
Uffe
