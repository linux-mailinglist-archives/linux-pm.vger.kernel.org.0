Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1C398060
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 06:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhFBEiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 00:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFBEiL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 00:38:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C914C061574;
        Tue,  1 Jun 2021 21:36:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s14so330315pfd.9;
        Tue, 01 Jun 2021 21:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCliPGLx6FVNnQ6sgaobA51qmzo7sZrH3tFGSfSKils=;
        b=c0iUg/IDskzwFQ/JReV42re1915rl03KYKmqdM+qyaxNeIxVMhz1R7ttPYJuYABUzU
         4AgbRD51XC9rGDLNZG89ZzFHnhj6nad36c8do6zmzGG3kV/qK54jtTWf0lH2zmUOh/vN
         ENAF3MnZvWy1IDeS1WCcIlsm6WAqYiupPQI/xip/U4agHUYhrk8QMUBa5k0Eh3e8YS5N
         LvQy8BGSrMF+h3hkLcCcXtay4YQTrlKp8jOSwEZ/ZemnjQevrajrcMw10tDGysJ90IQv
         bnBik+uQ2MDNNx6AlhHAtXRfO9aOjLCe24mPFepBlzTQJzEyJJ3OKKRpLq2rTMWDchhg
         PHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCliPGLx6FVNnQ6sgaobA51qmzo7sZrH3tFGSfSKils=;
        b=eogsB7hNEZTEIlPsmiyzWRaj/tKe71dQ44vVa8RU8FttOrnj8iWwX2CAi3p8vPLBTz
         6lPFC61EY07ba4I8Igmq25wipJYsnigDmE5q2DHvkHwCLZz1sxoalnVuCxzx2spKd9hD
         yHGqM99OxGgN/n9q8UqalD9Bgalr2JLW4DaU3ppANm+mFSyNL3tk/FlEgY5rjWnTpdWL
         48/rs5HdZG9Fv+QpCEA7nBd5oNR0tclo91PNF20S14tcu4wogYJHXOcVaFX70rwcuMYj
         M04jh4MlC+Yb8+dpjB9cwGVbJbovhWvGXpcrYjHlz3xreRYjvl9iFM7jkymNk/djEdys
         wEjg==
X-Gm-Message-State: AOAM531DFWcMCR9ZgTgMKQb1Ni6gRVRkMSX/3Hek5MsnfQSDb5hYtog0
        YsrIPglbRr6WWOmcFuVKu8M=
X-Google-Smtp-Source: ABdhPJyUx3UOpF2e1qPYGhhakRHaKxG12A0Z8FuXc15itUMxsrpFkrtGZCV4Tk2emQ68W65Jm57R8w==
X-Received: by 2002:a65:464b:: with SMTP id k11mr32140520pgr.407.1622608587719;
        Tue, 01 Jun 2021 21:36:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a596:b3cb:1a6:1ee4])
        by smtp.gmail.com with ESMTPSA id i16sm14850421pji.30.2021.06.01.21.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:36:26 -0700 (PDT)
Date:   Tue, 1 Jun 2021 21:36:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V3 1/5] input: pm8941-pwrkey: add support for PMK8350
 PON_HLOS PMIC peripheral
Message-ID: <YLcKx+0/zih3iDFk@google.com>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620630064-16354-2-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 10, 2021 at 12:31:00PM +0530, satya priya wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> On Qualcomm Technologies, Inc. PMIC PMK8350, the PON peripheral
> is split into two peripherals: PON_HLOS and PON_PBS.  The
> application processor only has write access to PON_HLOS which
> limits it to only receiving PON interrupts.
> 
> Add support for the PMK8350 PON_HLOS peripheral so that its
> KPDPWR_N and RESIN_N interrupts can be used to detect key
> presses.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied, thank you.

-- 
Dmitry
