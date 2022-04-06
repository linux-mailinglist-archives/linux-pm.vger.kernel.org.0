Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD84F679A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiDFReq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbiDFReZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 13:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE2712BF8A;
        Wed,  6 Apr 2022 08:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2A261CAC;
        Wed,  6 Apr 2022 15:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC897C385A3;
        Wed,  6 Apr 2022 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649259629;
        bh=AsJzQIyOYpQ2FTcuHuYsP5bu2bnGDIoQFVq00vRBVJo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QiP0NBNsT0e7u8WWWUV58zjTQkFRYNf/eTQT4aDO+469VWIt1teTvGx8H+izvCJ0Y
         x4LSQmUeWml8Wlbq/B1HGs7ONgm4adwUnSqBQg0EJPqGl2cwulD2KDeN7qSIhnsuKl
         Gznh8lYldsP5J1C57UXPiQeY5eG+TTbiOl7VArtF0F12T706+CKXoGFHUnqGoiR1I7
         IWgjG1/EXbDgji9YQEs8zFiJ4zQxMj16XUtutmhYjtqHdlk12ZbFCju//6xVcF5oMX
         hFmOMq9JVwAjtBhpOW81B7XkVY4iPtUANIVZaemS/liTGUsaf8qRL1Bcux2p0cK8Zw
         fbcO+Qpaty35w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 0/4] arm: qcom: qcom-apq8064: add separate device node for tsens
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
To:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Date:   Wed, 06 Apr 2022 08:40:27 -0700
User-Agent: alot/0.10
Message-Id: <20220406154028.EC897C385A3@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Baryshkov (2022-04-05 17:26:44)
> Currently gcc-msm8960 driver manually creates tsens device. Instantiate
> the device using DT node instead. This follow the IPQ8064 device tree
> schema.

Why can't the schema be changed?
