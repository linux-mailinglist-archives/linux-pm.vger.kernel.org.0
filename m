Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD76A3A18
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 05:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjB0EXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Feb 2023 23:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjB0EXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Feb 2023 23:23:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC91113E2
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 20:23:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p6so4581877plf.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 20:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQlnkGbC1NS46yQPlx3GF1Mmqdcawxkv2CKfR4b4ofU=;
        b=mg1fXSBo+5tXyR+fr5RDmzVtL9b97oxbj5oafuYXmoB2NWHcjfwqPGQnQgJFKLLAFP
         wlNBx5XW1CMVKs2emjPvYnQufP30xPZaai43ebnaI9TFpiXphIfj3a/sWQrEpYM6xSWP
         b5+IZnQtLuWPwAeQiYJTMyROT0oumYVKmuqj0MX6jySWKC/UfMv1nLuDgdnp21VTI4u5
         V1anyd0Fl8iar8KxoNm16mryRmT1juwCcALX7dLRt0uCmzJW/D32wNDyP5p0L7Sax9dn
         PuMah8m9LQDGIgsa2itbGniLQkaLNQx0EAAeTVe2+PFsRlZ5JttAkAsy/2P7sK9s0aHU
         AWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQlnkGbC1NS46yQPlx3GF1Mmqdcawxkv2CKfR4b4ofU=;
        b=u4CGUda6YC8IfntRXFZS8QJMTLBbJoFKDufV/2NpXXzAeaV+z5cqka5cfHU1BmPhro
         JZlXp4IN9SyIHs6OHeOmZ3QRWWaOHVgh1xzj2MqmgyWZE1nMOXDKYByWO+G/7fDMFLAo
         fLJh8fGVRrn8cLm4igXqOmzdrPItAD6lF4dyEAkvychOS3nLorwcH0k+YbYmoWZTjcoa
         ZR6C4rsHIokf3c5H/KBYMSKdvF1T6npPKPyqRKh3x0HhCxNLo63AYx4MBzMAswT0efjs
         zjkbolloutjS5AiitnwyYVUt1O7yDDckDd35k8hiH1HpcTVj79Ta9e0pLsaOZ5NnpQes
         dg1w==
X-Gm-Message-State: AO0yUKV0u+qFJbpgCVmqJ5bfDqIx5oM5v4IXTCK5FZRDBcK0GxOMXQKn
        tzwg+avsYjtyYqHQKg8/wEiLjA==
X-Google-Smtp-Source: AK7set8Ac55n+05ov9iu10t1ydja691duzF5DrkR5xpmWOLtxk+uLB9pJDst3cyTTsYAl2tP393mZA==
X-Received: by 2002:a05:6a20:549a:b0:c7:b65:cb3b with SMTP id i26-20020a056a20549a00b000c70b65cb3bmr7897574pzk.10.1677471832690;
        Sun, 26 Feb 2023 20:23:52 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id q2-20020a656842000000b005026c125d47sm3074844pgt.21.2023.02.26.20.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:23:52 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:53:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
Message-ID: <20230227042349.3p2ijo6s6yyqc267@vireshk-i7>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
 <Y/hyf+/EqEeTu436@niej-dt-7B47>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/hyf+/EqEeTu436@niej-dt-7B47>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-23, 16:17, Jun Nie wrote:
> For the opp lib, this is right direction. We still need to find a method to
> pass devfreq device node to opp lib, just genpd_virt_devs for power domain.

I am not really sure I understood it all. What is "device node" ? DT node or
struct device ? What exactly do you need ?

> But I am not clear below is the right way yet and this also involves wider
> changes. Or the opp's owner, devfreq device can be referred via opp lib?
> If so, we do not need to add devfreq-devs to cpu node at all.
> 
> 		cpu1: cpu@101 {
> 			compatible = "arm,cortex-a53";
> 			device_type = "cpu";
> 			power-domains = <&cpr>;
> 			power-domain-names = "cpr";
> 			devfreq-devs = <&cci>;
> 			devfreq-names = "cci";

Why do you need these ?

> 			operating-points-v2 = <&cluster1_opp_table>;
> 		};
> 
> 		opp-200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 			required-opps = <&cpr_opp3>, <&cci_opp1>;

This looks fine though.

> 		};

-- 
viresh
