Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75525663A2
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGEG7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 02:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEG7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 02:59:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF9FD1
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 23:59:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d5so10202205plo.12
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VNHiUGwQOsu7UA6RtMt6UvhL2D1FX1PORHMBoWhLfD4=;
        b=z6etQfMnTbRrOcBrlN/iGHfzncd6ag4b5iN4UmJeWIyOsBpisXTRRrJ/gvO1VfnUwP
         1Bhy3dgSynR08aHh/R8byFYCa43fCrlakxi4+3ssqQx7dAiJiuQeTaM2D03Tse/wqYRS
         iPS5y4RBqKCrgmI13zGtZXQvjSlxXJnWT/CdvasFacgK/+Ep++XM574JxnCwhc31YeXU
         1b5PwvqKvUFChqc8vgoqzuuAxTAdbzTIQapwyO57MxBykTo50UL7n90im+7yPZFjNpRE
         yc80A82JZzQ52uJqmBUZprwmB7w/ASQtB1elQynTXn97Zyw55S3jR3VB7p5gW/+8x8Sc
         VQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNHiUGwQOsu7UA6RtMt6UvhL2D1FX1PORHMBoWhLfD4=;
        b=7KfIYAqYF4kal0pY2Xm4zpg82EkK7OX1iYTGtIHQlluV5wsSs/1gcpod6dNQ60VkGB
         qA5NPwvGWO7IQUXarqwn6VzOH8qNDi8R49VJLvwUqmrjR0h33gNBZNviSFuErdX8Gvr/
         eI5cZG8p/XjVmuhfUAI1BS7w4pPvVl0RC0pLf6E6xc3eFeu8CwGUPaklUlUTdwS+fB/Q
         iylUZODrJWPHi+eOfqh32Wf6udISmd+Ab3Sfq4oFUk7SNyDiZVKgIw4j6tUQCbx2jgB3
         0VZH5iCCAuKj9kScYLMhcnqsQdYL4ZeKu8Gqtak4QEOGSFDAsTevYcqQoMEX6QHbk+s/
         LCGA==
X-Gm-Message-State: AJIora+2AOgG7fvy/gaNDuUS3K2QKBfahZmc/qYbxOf+QKlrSaFpsKg4
        pTG21DP+9FiTqXj6fX9LPTApN2UEcKYLJQ==
X-Google-Smtp-Source: AGRyM1s12wAWEf1FeyoLI4yLjcshz3btgDoC6a3E4Ygji4hbulwSG8IAxWF5dNR4t68BnI3qBg4Arg==
X-Received: by 2002:a17:90b:19d3:b0:1ed:5596:1ee5 with SMTP id nm19-20020a17090b19d300b001ed55961ee5mr42381061pjb.83.1657004383035;
        Mon, 04 Jul 2022 23:59:43 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b00168b113f222sm22696770pln.173.2022.07.04.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:59:42 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:29:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220705065940.v3n2s7bgr6eai3rf@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <de13cca4-3a33-6482-7b02-f89796f45325@linaro.org>
 <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cac6c79-ea9a-1f48-c6f1-2e04b54590a4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-06-22, 14:39, Krzysztof Kozlowski wrote:
> On 30/06/2022 14:32, Krzysztof Kozlowski wrote:
> > On 10/06/2022 10:20, Viresh Kumar wrote:
> >> +	ret = _read_rate(new_opp, opp_table, np);
> >> +	if (ret)
> >> +		return ret;
> >> +	else if (opp_table->clk_count == 1)
> > 
> > Shouldn't this be >=1? I got several clocks and this one fails.
> 
> Actually this might be correct, but you need to update the bindings. Now
> you require opp-level for case with multiple clocks.

I have thought about this again and adding such "fake" property in DT
doesn't look right, specially in binding document. It maybe fine to
have a "level" property in your case of UFS, where we want something
to represent gears. But others may not want it.

So, in the new version I am sending now, we still consider opp-hz
property as the property that uniquely identifies an OPP. Just that we
compare all the rates now, and not just the first one. I have updated
_opp_compare_keys() for this as well.

The drivers, for multiple clock case, are expected to call
dev_pm_opp_set_opp() to set the specific OPP. Though how they find the
target OPP is left for the users to handle. For some, we may have
another unique OPP property, like level, which can be used to find the
OPP. While in case of others, we may want to implement freq-based OPP
finder APIs for multiple clock rates. I have decided not to implement
them in advance, and add them only someone wants to use them.

-- 
viresh
