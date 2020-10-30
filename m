Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D832A01D8
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 10:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3Jwx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 05:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgJ3Jww (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 05:52:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F97C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 02:52:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o3so4732310pgr.11
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LouD1D0I3seOHVdhKfAMAsty+PIB9yldQNSOZd2AunQ=;
        b=aJO1l8mh4uw/GnTl5HY0NA+dwk++sWXQuGfLTVtl533+jm1Ua8w+Wey6I5HA7kFbT7
         /OrX0mM9SkI3hgIomS6aGj1VoU84VFIs/KngRRZZlv0eqFfA7QHc/dPusglaVUaZEHeS
         bCc9UMq+1p3c5eBbePMJ1pnm9gmaKjIDe4AC9KLBvDw5vX1+/4iEjastJbhBYdAuq8NU
         d07nCQ+GQrNbl7sOdhngJ4LJvFcudsJLAECxVwtud5DIg1uzO4jtHeIZh9B9LwUghSZU
         FLeKjsbeoTK+tXDKFmhuXDgzbY/mAj5g/zqtQEJDat2mO1fqz9eBhdPk7zGyQs1YRdhL
         4Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LouD1D0I3seOHVdhKfAMAsty+PIB9yldQNSOZd2AunQ=;
        b=PlKrTWNSTTqulaITB5vtCbtY32CvZIEGs8QuOauLH2gU6qSlaUk8QFWcM51VTvBnXd
         MYwFhg9i6STV0+/sNgt8DPFtPxmUR9qFMCeJ7hj/ifFOxPTKlCRb7R0AdSmHYWq3pp5m
         Do0pJ+AlwJAfqvqabdbohLtmk2N2qqBw3gSkOFab2ojfJ9fiptAhb04DyP+W+kwMkR3e
         3IVrlB8zSEpRTxjXhbpZEihRSaSngastjDiQBbNBwZXhlL02gc/UcCCX6D/a3sl9Z3HW
         Ml3RKRdL3aUjuFiWHOlbBXeOzgI04GYmxpEcSGdUoOUAf6tAVEj4OLJhzltjvzxaHaNC
         Pv2A==
X-Gm-Message-State: AOAM5331RwuKuwO/EDxpaBpw1gQs0217DurITK7IwFFQeM/y9bRlSaTN
        +dpw73ZSAAn889qB06Ygenosbw==
X-Google-Smtp-Source: ABdhPJwg8INqFRnK0JxdmUemZAqhRWMZQOBYvn0HloepQQgK4PC8ob7yeNm/niQ1Z7nrQd17NwIeSg==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr1894047pjs.51.1604051571650;
        Fri, 30 Oct 2020 02:52:51 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z10sm5422539pff.218.2020.10.30.02.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 02:52:50 -0700 (PDT)
Date:   Fri, 30 Oct 2020 15:22:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
Message-ID: <20201030095248.abej6h5wphud2ihb@vireshk-i7>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
 <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
 <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
 <20201030082937.xgjmko2ohwhkt6f5@vireshk-i7>
 <a0a6db69-fc3e-c39f-7586-5ac3227b746e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a6db69-fc3e-c39f-7586-5ac3227b746e@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-20, 09:19, Lukasz Luba wrote:
> How about dropping the DT binding, but just adding this new field into
> dev_pm_opp? There will be no DT parsing code, just the get/set
> functions, which will be used in SCMI patch 4/4 and in IPA?
> That would not require to change any DT bindings.
 
> I see. Just for your information SCMI supports 'Sustained Performance'
>  expressed in kHz.

Even that doesn't sound great (but then I don't have any background of
why that was added there). The problem is not about how do we get this
data into the kernel (from DT or firmware), but why is it even
required. I really feel that software can find the sustainable OPP by
itself (which can keep changing).

About moving it into the OPP core, I am open to getting something
added there if it is really useful and if the OPP core is the best
suited place to keep such data. Though I am not sure of that for this
field right now.

Is it ever going to be used by anyone else apart from IPA ? If not,
what about adding a helper in IPA to set sustainable-freq for a device
?

So only SCMI based platforms will be able to use this stuff ? That's
very limited, isn't it ? I think we should still try to make it better
for everyone by making the software smarter. It has so much data, the
OPPs, the power it will consume (based on microvolt property?), the
heat we produce from that (from thermal framework), etc. Perhaps
building this information continuously at runtime based on when and
how we hit the trip points ? So we know which is the right frequency
where we can refrain from hitting the trip points.

But may be I am asking too much :(

-- 
viresh
