Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27068618FD4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Nov 2022 06:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKDFIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Nov 2022 01:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDFIr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 01:08:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332E26C2
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 22:08:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l6so3607791pjj.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2022 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZuYmijo8QlWxzyWj52D3xChIIrIG0zUx1PRNxy4tmw=;
        b=sdZoFrt0lZtsB5ru4ezWP5HrT8uoWzW8CpAgcU1SOaaII5P5xy3jSGMDv9IfqUWcIA
         MOSGACBVVqRW485NR4nOTz2kulZb1aHkJXkyeAWhqZOP+o1+16lisl3O1AK969y8WQn7
         tsKLD0mNv5PZ+PHbP8DLhyOoqIcYybYYc6WoNzPdYtaX/buESkUisZ4Sv0QAOlXG32t2
         ryszDC0UruDaF+g/kQ7SgeIrL7duLS2TtQjnDNYogq3rxB3/j7L4Otg1+ZwGplU8kLD5
         yD3LX8wMsedOHI+x45jxA4YJhbdHLUQbDTM4xVmUp+J1lP11tK0nAOpavB7Ja4bTfPKK
         sZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZuYmijo8QlWxzyWj52D3xChIIrIG0zUx1PRNxy4tmw=;
        b=ClLCiLuXPIMRijzkOFCAkmalb7XHD5wCdP4VfapAOlrNTRI2VBLT8R9RVR6su/Li35
         yThsywpDQidK4ai5dAwBAfDLDsJdFOYigCse9GLRG1LMDM4OIDZgQefSIU3sGk5lSnDZ
         TSzJrkaDMq+Gl7xU6JuphabQCpiO1X/RAJgV7JKbNGpulXZAf6blKV0KhSrfDkIafr/J
         4PHFhgUjMdsZ3qX61BJxyPM/lwKhbnHy26yfmQR+Hdu/7Xf9t/ZX8ai4Y3BbXx5NyvcH
         WZ5zzUmCOwkVYBI31ZHmwQlYrY6KrR60yMQYwIA4OyffT7X6xXIVYbnrwcN7ve2y53vS
         xIjw==
X-Gm-Message-State: ACrzQf2sPPS6Zv3VD3m78J4MEtKYSe66GgjdQ0y7w66701w8Td5h1Yxc
        OHv2HVJK3FaA71x/WrsqizzYyg==
X-Google-Smtp-Source: AMsMyM7V64KY0pAq9JsldRxPQ9bXMIBrlW0D5pOzpdy0gXilSd1Y7LOfgYMu+dfE4Tvc6wTIM+Elqw==
X-Received: by 2002:a17:90b:4a43:b0:212:fd76:be5d with SMTP id lb3-20020a17090b4a4300b00212fd76be5dmr36294883pjb.152.1667538525805;
        Thu, 03 Nov 2022 22:08:45 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id v126-20020a632f84000000b0046f9f4a2de6sm1563028pgv.74.2022.11.03.22.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:08:45 -0700 (PDT)
Date:   Fri, 4 Nov 2022 10:38:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in
 opp_parse_supplies()
Message-ID: <20221104050843.6t2dhckkmujxy7tm@vireshk-i7>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
 <5acd93462bff6c108d65802fd39f6002dfadd1a0.1667473008.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5acd93462bff6c108d65802fd39f6002dfadd1a0.1667473008.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-11-22, 16:31, Viresh Kumar wrote:
> From: James Calligeros <jcalligeros99@gmail.com>
> 
> The opp-microwatt property was added with the intention of providing
> platforms a way to specify a precise value for the power consumption
> of a device at a given OPP to enable better energy-aware scheduling
> decisions by informing the kernel of the total static and dynamic
> power of a device at a given OPP, removing the reliance on the EM
> subsystem's often flawed estimations. This property is parsed by
> opp_parse_supplies(), which creates a hard dependency on the
> opp-microvolt property.
> 
> Some platforms, such as Apple Silicon, do not describe their device's
> voltage regulators in the DT as they cannot be controlled by the kernel
> and/or rely on opaque firmware algorithms to control their voltage and
> current characteristics at runtime. We can, however, experimentally
> determine the power consumption of a given device at a given OPP, taking
> advantage of opp-microwatt to provide EAS on such devices as was
> initially intended.
> 
> Allow platforms to specify and consume any subset of opp-microvolt,
> opp-microamp, or opp-microwatt without a hard dependency on
> opp-microvolt to enable this functionality on such platforms.
> 
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Rewritten by Viresh on top of his changes.
> 
>  drivers/opp/of.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)

Plus this fix:

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 273fa9c0e1c0..e55c6095adf0 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -673,7 +673,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
                              struct opp_table *opp_table)
 {
        u32 *microvolt, *microamp, *microwatt;
-       int ret, i, j;
+       int ret = 0, i, j;
        bool triplet;

        microvolt = opp_parse_microvolt(opp, dev, opp_table, &triplet);

-- 
viresh
