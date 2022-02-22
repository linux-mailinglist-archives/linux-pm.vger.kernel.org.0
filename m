Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662E4BF587
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 11:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiBVKNN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Feb 2022 05:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiBVKNM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 05:13:12 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633B13A1CC
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 02:12:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so3236902pll.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJOc4s/JmrXgMJQfNvQ3zYpIHSf0zbHb+cTgCBKjP8I=;
        b=YtKoFtPDq9w4pOD4tUF/xaR3cgs6ntps/TGd9w4bavkd2Z9rgvvmXJiLHFCSXE7SQr
         57+itX+45l3RNsA6+gOR56Km9guMlYU+mF2/L1gANc3sb1nqwU4uw+KqcCebql1xZqna
         jJ3XQtWc6gfqiKKZ1GwYWFEq25BAY7Zsp6tQZBycsv1doi/G0HmvnXu+lhJ7LS0uN+WQ
         quZenR9rc5X8GHcdcUUFo0SBqyEV0ipED5XTc+2DXVbmfQ1XNDBIuGdLph4xU4VGNuYw
         kp4J14p9at86TscDjxH4a6W+tVwY6WTE7HuNBgocof1NTwm8WuLsWLQrwGD5tqpv5PQE
         NeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJOc4s/JmrXgMJQfNvQ3zYpIHSf0zbHb+cTgCBKjP8I=;
        b=qE/Zm2ZgBZfMKkRct95xu+A0VomTmwNiZO1EVNmPfS2LEYtrk9NhPiUO/KUfAV8R4B
         F4tKIdRbRAXWKl4a/MHAlZI6STLkY7AUAgPl+9LI/MObhRAQ7emqtIGSWhlHlSMZkM9b
         qUFzwbHzk7PwKKNfEyYrHqWtUoWJBZF70St3BFRHfBBLt5kbyRGQungCTDZ5udGoAf7x
         L18U19lFJP7mkkCz4GKhlwr5UrycA5svQyqq5dFj0rTxuywsOIilwyMsN3CDoE5cM42V
         uSHnWGWPPoyeiwAE7wqhg9XO6OLCsNlcnA+U6H8c/ICzCjL4UsStplbU/ZHucIOGTDwN
         cFRg==
X-Gm-Message-State: AOAM532rb4MBU9fIHmV3UjDionkbtlV9CSiMqO6F7BIiCjNCJSRx9T0R
        aT/zpHBh86BAkE8HnKq33IgFZQ==
X-Google-Smtp-Source: ABdhPJy5BfU61CZQ975wpep6TOhShZvNAo+rQcyErW2vgrzEuMCagPqMLcjIdyjTEPqR2cs+BqAW5g==
X-Received: by 2002:a17:902:7407:b0:14f:b5f4:6537 with SMTP id g7-20020a170902740700b0014fb5f46537mr8873407pll.32.1645524764110;
        Tue, 22 Feb 2022 02:12:44 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id h26sm20821773pgm.72.2022.02.22.02.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:12:43 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:42:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Message-ID: <20220222101242.chwcxan2nyhczqth@vireshk-i7>
References: <20220221225131.15836-1-lukasz.luba@arm.com>
 <20220221225131.15836-2-lukasz.luba@arm.com>
 <20220222030337.ijnfrh367illmidr@vireshk-i7>
 <147e48e5-e310-cd8f-ba8c-ff32e3094be3@arm.com>
 <20220222094547.tgj4bciq6rez62nk@vireshk-i7>
 <c83ae91b-6901-de2b-913e-b28af73c52fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83ae91b-6901-de2b-913e-b28af73c52fa@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-02-22, 10:03, Lukasz Luba wrote:
> 
> 
> On 2/22/22 09:45, Viresh Kumar wrote:
> > On 22-02-22, 08:06, Lukasz Luba wrote:
> > > I'm not sure if that would be flexible enough to meet the requirement:
> > > power for each OPP might be different in one board vs. other board.
> > 
> > Don't DT files overload values from board files all the time ? Why wouldn't the
> > same apply for OPP table as well ?
> 
> In that SoC and family of the boards, there are no such examples.

Here is one I think.

arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts

> It used to be popular in arm32 boards, but I'm not sure nowadays.

I think it is still common, not with OPPs though.

> > > AFAIK the OPP definition is more SoC specific.
> > 
> > This isn't about OPP definition as well, but just that if DT allows you to
> > override or not. I think it will.
> > 
> 
> Redefining the whole OPP table, when the freq, voltage, interconnect,
> and other old entries don't change isn't too messy?

I think you misunderstood what I said. The common part of the OPP table should
stay in the central .dtsi file. The dts files though, should just add the power
specific values to the existing OPP table.

> As I said, I would prefer something lightweight, not redefining all
> stuff from OPP in every board file.

-- 
viresh
