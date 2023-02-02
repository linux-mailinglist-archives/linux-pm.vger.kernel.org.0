Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8531F6878D4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 10:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBBJ3l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 04:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBBJ3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 04:29:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120097640D
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 01:29:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u12so2148500lfq.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hF1FP9uSu/iok1i0gg8stAHISdJKJxpXWFpnnPM01bY=;
        b=TCYiT2ou6sYOivmaPUJ1gwQvaOAlwLO6UihiPY8n6SiszSxUadNii1IqN5eHEVSIMn
         CACMWWQwcavwuA7eMAclq3FouMwHIjqba6ZlbATn0C8XUEIz1O18hnoRxUHyMYIXGtmw
         MXZy2H3VhdMTjzWNx/VMMGhqx0dTT4i3d2/GR0knAd2LD67dTTdncA0RoaMuG3FFBgJ4
         tQKjVHu6xeOwjwET0BDoygvMuGPAGxExN4A+s7j2lR89zV+lhQ/r5NQJOqVO5s3yOCSW
         U2or+M1xhhY6WL95dvIrzdwj27KTaurc3Lts7Xsrrh5eNAHUB1Q1eMPrCvEkXNaauBmb
         oOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hF1FP9uSu/iok1i0gg8stAHISdJKJxpXWFpnnPM01bY=;
        b=eu+45NBybemRrP7ZJaDkOlM9lOnofEpVL0QJfIFPtYMfHq/F18emOTgt47gf25ryc2
         HHj65/xFjSwaBY+8f5d9CWT4bytU3aw5fWBCwi2/v+hvRCXdFswh3V/XbDVVo9xPSXXN
         2WbIjfyZK1H2riUkhrbMJSpLZqdHtxr/MVmtkNz6sV7LMo8Z1uW730eKu5QTk29IjueE
         DOJdUeHfbGpO5W0B2XguADnc7bF0Yr+3x7FZA9L9c6zubWm34EzgxxqLbhilZrUXS7jZ
         z6B6u5GtXLLq2FHMkixX11vdf7D7oV6Gth4boRTn1kdWzmYlyKizpLP1pBfJ7li9xC+N
         pZ+Q==
X-Gm-Message-State: AO0yUKULyN6DmjGO2IFvjg42vDBCwJl1su4fNty3ND9R0C0yKSiNNQtx
        RGMozLY6KeHcnd9DaPfqnJF8dJs3f3XxYS5p8V59Mw==
X-Google-Smtp-Source: AK7set/U6c2t7aCZeIxVjttv08cAYzl5rIui1u4wZg2P32IfHGX10jGlEQUkCyHyHL5hE/viRgutm4dUbeSvVaUzK+Q=
X-Received: by 2002:a05:6512:12c9:b0:4d4:fcdb:6376 with SMTP id
 p9-20020a05651212c900b004d4fcdb6376mr1412014lfg.218.1675330157397; Thu, 02
 Feb 2023 01:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20230201080227.473547-1-jun.nie@linaro.org> <9ab7383b-f3ed-3e48-d275-3c8933be5f2f@kernel.org>
In-Reply-To: <9ab7383b-f3ed-3e48-d275-3c8933be5f2f@kernel.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Thu, 2 Feb 2023 17:29:13 +0800
Message-ID: <CABymUCNKvm9+_ascdcWAgA1xGYKPhyO5C97-+rTTK739v+UEew@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm CCI dt-bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,msm8939-cci
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  operating-points-v2: true
> > +  opp-table:
> > +    type: object
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - operating-points-v2
> > +  - nvmem-cells
>
> ?? You cannot require properties which are not present.
>
> > +  - power-domains
>
> Same here.
>

So the properties should be added later, after cpr and fuse nodes are
available in mainline, right?

- Jun
