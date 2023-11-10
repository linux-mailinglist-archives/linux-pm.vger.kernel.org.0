Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E867E8153
	for <lists+linux-pm@lfdr.de>; Fri, 10 Nov 2023 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbjKJS1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Nov 2023 13:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346142AbjKJS0Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2023 13:26:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034D3820F
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 05:51:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so2287266276.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699624274; x=1700229074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Sk9UUjjg34h39eQ4zVaKNEs6QzNIxEllsc7xjrQnfM=;
        b=I7QB9Fjpta4OlXyl1y0s/wJlMUmUqZHQ9/QTdTScI0qcUJLvIbdzJXag73T+If0LeC
         Pqe/jMKDZZFJ1k+WThWeHk8TSpTGriFRO+VWwLWeY2Dm48QWHMqwtF5AP1s999Dgjn+u
         IpiYWvMk+SmGKLF5UmCOabP+QQFgfbrLeF6yroXVzh0exefD1/OA1RK3ns6ugyBmwRDH
         2vcgSCP8ix5/nkrQDnqH0MokuM5E5wEqgq7ZjH7vuWsOBKjwbjQbx2ip39F1YFvsfQed
         MY1XUE2ynXPWshj2C9OxUxEWyamFnGCXieb+Vz+DgnEe/qaxw8IZs6OISm8kFJIbyWLB
         fZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624274; x=1700229074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Sk9UUjjg34h39eQ4zVaKNEs6QzNIxEllsc7xjrQnfM=;
        b=IFgn/Oj7ij5PMsH+AAXcYG/gi0El9TuMfuJEpX3+hyXEnERtMHfWdfGxapQJRer+NH
         FB0q8F+h8d7eOIyfsaywrBvOd6ebrL8lIDVx9mL9reUK/Mw55NXHnFDzg0dRczumhfFj
         juQcU1FCsSBRJJ2qXHL9uRlrTz2dqIq+uUceV/lB1k+NC1WQHuZfMGxz0LuceJkZZBRA
         NrDhrpUUlkw3ZG9yjCDGw1Hr+Z2Y4JRIaMsOZkE1YsR+k8V7s93zW2tH/8n5MgIE2fLd
         ZhUole5SMRqxM3bZvuj8uK/TMJpKihsay13qqY1Z/QH6+GCxgYptcN5P8tsStQHlJvV8
         hwyQ==
X-Gm-Message-State: AOJu0YwlKZe3Kf5N9vjzelPIHy4i/MVvzaQlMVpPrKg8PReobCUkCbuR
        JaVGCQGqHiruBEQYMD8Zsa+XqYepoLw8Cc2yYqUvqw==
X-Google-Smtp-Source: AGHT+IEWZHhChgfNjY/nKQjGumztD6lLqf6WSfNXBmWSZuDPOl/2KyTQ/CHRkjwkIvoK/be6Vzq42O0dyo101NJ4Kd4=
X-Received: by 2002:a25:42d3:0:b0:da0:3684:cad9 with SMTP id
 p202-20020a2542d3000000b00da03684cad9mr7850554yba.59.1699624273920; Fri, 10
 Nov 2023 05:51:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7> <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net> <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
 <20231030102944.nrw4bta467zxes5c@vireshk-i7> <CAPDyKFrn97POKuNc3cMM9TOaw-f-ufLwYtUY8_L2w8+hzECWOA@mail.gmail.com>
 <20231106070830.7sd3ux3nvywpb54z@vireshk-i7>
In-Reply-To: <20231106070830.7sd3ux3nvywpb54z@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Nov 2023 14:50:37 +0100
Message-ID: <CAPDyKFpgPdMLR12ajYFasCjm-Y-ZyVVtQz3j1CZVWfN9T3Gg0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 6 Nov 2023 at 08:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-11-23, 12:58, Ulf Hansson wrote:
> > Are you saying that the OPP library should be capable of managing the
> > parent-clock-rates too, when there is a new rate being requested for a
> > clock that belongs to an OPP? To me, that sounds like replicating
> > framework specific knowledge into the OPP library, no? Why do we want
> > this?
>
> I am surely not touching clocks or any other framework :)
>
> > Unless I totally misunderstood your suggestion, I think it would be
> > better if the OPP library remained simple and didn't run recursive
> > calls, but instead relied on each framework to manage the aggregation
> > and propagation to parents.
>
> I see your point and agree with it.

Okay!

>
> Here is the problem and I am not very sure what's the way forward for this then:
>
> - Devices can have other devices (like caches) or genpds mentioned via
>   required-opps.
>
> - Same is true for genpds, they can also have required-opps, which may or may not
>   be other genpds.
>
> - When OPP core is asked to set a device's OPP, it isn't only about performance
>   level, but clk, level, regulator, bw, etc. And so a full call to
>   dev_pm_opp_set_opp() is required.
>
> - The OPP core is going to run the helper recursively only for required-opps and
>   hence it won't affect clock or regulators.

What if a required-opps has a clock or regulator? Doesn't that mean
that clocks/regulators could be called too?

>
> - But it currently affects genpds as they are mentioned in required-opps.
>
> - Skipping the recursive call to a parent genpd will require a special hack,
>   maybe we should add it, I am just discussing it if we should or if there is
>   another way around this.

Right, I see.

If this is only for required-opps and devices being hooked up to a PM
domain (genpd), my suggestion would be to keep avoiding doing the
propagation to required-opps-parents. For the similar reasons to why
we don't do it for clock/regulators, the propagation and aggregation,
seems to me, to belong better in genpd.

Did that make sense?

Kind regards
Uffe
