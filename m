Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24754C2836
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiBXJhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiBXJhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:37:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AC226F4FA
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:37:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1584965pjb.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpeZOLAjOWDOxOLAZwon9tgkbygh+pggRkOmi8tbYh0=;
        b=FaH9oQe2rreTUm+yh+gI6rkYx41p6V2vC0iPwLCgRW0y/ZsVOh4eYNXoZS1rDNTdLH
         AR0jjoIIwOARJDAftFsI9hYdyuP5zBqED/jw2Enbpo6YOYkWeDWH56pq1dQVbUWvyBoq
         rBXmMoYnC/nk53wQGU4FPq+jkB5HBsIRucV58qecRaBggrfrQg5bWUeQc+qwdghAGI0r
         XASWvcfosoFnIhFa3wqGmL6G6+QgpAZYAZXxL1+RPHi92JnqhbW4CvXNs/trHLbTSdaN
         lvsnij7+ibJFnKLbHhxGsgwtc37YB+R98f7q2p9lS6afgtW05veB+TNjltQLmuNNUmHD
         RBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpeZOLAjOWDOxOLAZwon9tgkbygh+pggRkOmi8tbYh0=;
        b=fQPLyhkdpd9ut1cpziTcLfwSjAI97QtZGFOEVINfX2Ojx+HrFTkIhZv1daNpw6io6O
         xY4cTh/HWl1/9RaYfTSntWkA8iucPkTI8Ao83CZA7rS3p+mM2+6PyQxpD12D86MVXevT
         nCJxLwrvOpKN0wV4V17WZOL8ENw4Z4TKi2F2ciJDbx4WsRSVds+qmA9A4HrkXaV6Lac9
         b7tH0XZuXq39JtcvaJ78LW3EC0NiMzih0v0mtp9wzM4a2P3AbUwpdG+Ip0zugkrgyddE
         mwpMr2ZruqIFiIGomwkWRdkWX0gybog1agAL+CFu+oJD3tB07o3VHTYwdygY7zUwteJE
         QRtw==
X-Gm-Message-State: AOAM5329fS8Fk1hXwRU/JFCtjCwcPaJINR/WKJTVHW7JH5U6SLk1hw/W
        Au6XDqCsLPHcWJdFVdTh2ziLdQ==
X-Google-Smtp-Source: ABdhPJxYEII6V06Qiwb+BO1vJb+P3fpGlniJnjfLQ6HQyvs5rXL6g7TcfjHGKlq8NIm19mfn1Q2rrA==
X-Received: by 2002:a17:90b:1193:b0:1bc:1b5a:84e4 with SMTP id gk19-20020a17090b119300b001bc1b5a84e4mr13794880pjb.113.1645695440264;
        Thu, 24 Feb 2022 01:37:20 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm2233192pjq.17.2022.02.24.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:37:19 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:07:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: EM: Describe new registration
 method using DT
Message-ID: <20220224093717.3vsi4t26zcmoh2ra@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-5-lukasz.luba@arm.com>
 <20220224091508.fp7emu2zyhavkfkt@vireshk-i7>
 <02d16fbe-d4d6-a7f1-d81f-39f05dff76fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d16fbe-d4d6-a7f1-d81f-39f05dff76fc@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-22, 09:25, Lukasz Luba wrote:
> Our partners had a lot of issues with EM+EAS, because they were not
> aware of the internals of EM and limitations.
> 
> We've started to name two types of EM: 'advanced' and 'simple'.
> The 'simple' is the one which causes issues. Now when we contact with
> partners we ask if they use 'simple' EM and see some issues in EAS.
> This is a needed clarification and naming convention that we use.
> 
> Here the paragraph name is stressing the fact explicitly that
> from today we have the option to provide real power measurements using
> DT and it will be the 'advanced' EM.

I understand the background now, and since I am part of the same
community I can appreciate that. But being a maintainer, I have to say
that when we look at something from Upstream's point of view, we may
have to neglect/ignore the terminology used in downstream.

From what I can see, there is no advancement here, as of now. This is
a very small change where we are getting pre-evaluated power values
from DT, instead of calculating them at runtime. The data may be more
correct, but the EM doesn't get advanced because of that. And so using
such terminology is only going to harm further. If EM gets a
"advanced" algorithm later on, which can improve things, then yes we
can call it advanced, but for now there is nothing.

-- 
viresh
