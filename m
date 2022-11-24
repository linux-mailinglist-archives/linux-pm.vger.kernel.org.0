Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38526371BA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Nov 2022 06:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKXFYx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Nov 2022 00:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXFYw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2022 00:24:52 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB035BF81D
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 21:24:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so519156plc.9
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2022 21:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUP7Am6dqKQpcjzJq6n2SpwU7duYqMrmSYTw//dN1jE=;
        b=Z0mxaK7mlfH8Yar65Mnq4TMvrw6J4J4efzZFOX/tgsJWxdp5QS350PG+K1obsGeTLs
         nwYWMfWQKWgPN0p16aOlnN9Xp6IuofS5E6iGDi753bhKMKHkUZYzSP1ZEh+OIrapb8c2
         qYI+knxRKQq07uf9uBlAYtLcSEoWCg8RkisveC+WiXsV8IycvUYvp6/a4u4Itt9clCph
         Eo+55y4Mf6Icq+oRHYI2i9YreOoYxyWmQ+KuBkjf7aqBthfIgAQgC1y3lPUd3qBJ1WjJ
         Z2F7ot0w8x/qX4yEaXZoXrScB6wy0vMRShosHjou+nIG5ZuFZQvQ7Lvh+Bp9eQ6hRnk6
         LDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUP7Am6dqKQpcjzJq6n2SpwU7duYqMrmSYTw//dN1jE=;
        b=hEfytFGjs/ETospzzbnlu0+jWyy0ImEwtr1Zs+1aEG7ytsdd3FIpgFCMBD7cMqrbwP
         tLgquP7zaBi4rYWta1uYfkI/ZeOEAbj/2NrJAB8FTZ+ugGKv4QEWhB23EGgX0Gg8TuW+
         N1kRE/CcA9qwG/ovEuZTKqmX0ZxMCJnHGOnDvm5ngAcFasFqr0eT1haR6m3QvipU7+N2
         Jj7DD1u1tCO5eNXuOK/hn4Q/bnHd3i9E1MdpAMIYf9Hn07DWp5WNaRmwErvedq+TxkCE
         +f6sLNm9EU3Ly0ef6Ug2ovrx8o/BrQcNHjU6/8vNn8OtDKTeQ+vz5Vsu6C4v01C67GSX
         wZbw==
X-Gm-Message-State: ANoB5pmTsGAM6nnctk3JjkkN+A3y5CyEIQY7WyBef9UyylO3yrbjc6PE
        PqQYTtEWVG71rlDnvdwyY566/tbi2lqY
X-Google-Smtp-Source: AA0mqf4l9NPUP6hc/93wp2DgPah9wde9Y1AD7ULpN3RN77cOgH/3wyTWu9HsVxGuzHuTSSQ1wwGvHw==
X-Received: by 2002:a17:90a:898b:b0:218:bbfb:72e1 with SMTP id v11-20020a17090a898b00b00218bbfb72e1mr16563515pjn.64.1669267491235;
        Wed, 23 Nov 2022 21:24:51 -0800 (PST)
Received: from thinkpad ([59.92.97.13])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b00213c7cf21c0sm303574pjt.5.2022.11.23.21.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 21:24:50 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:54:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221124052443.GA5119@thinkpad>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
 <Y3sryFh84eK/sWKF@hovoldconsulting.com>
 <20221121083036.ppwfprrheuf7xl7c@vireshk-i7>
 <20221122132633.GB157542@thinkpad>
 <20221124042304.pk3rh7nfkanhlgsm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124042304.pk3rh7nfkanhlgsm@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 24, 2022 at 09:53:04AM +0530, Viresh Kumar wrote:
> On 22-11-22, 18:56, Manivannan Sadhasivam wrote:
> > If there is no .set_rate() callback implemented by the clock provider, it won't
> > hurt, right?
> 
> It shouldn't, I guess. Well, in that case, is the first patch even
> required ? Maybe we should keep it, this makes clear that we won't
> even call set_rate(), irrespective of the face that it is implemented
> or not.
> 

I don't think that detail is required to be made explicit. If someone cares,
they can easlily find out by glancing through the OPP code.

So IMO, we don't need patch 1/2.

> Also, the clk provider may not be part of this file later on, for
> other SoC versions, and it is better in that case too.
> 

We cannot predict what the HW guys will come up with ;) But as said above, I
don't think it is necessary to to make it explicit.

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
