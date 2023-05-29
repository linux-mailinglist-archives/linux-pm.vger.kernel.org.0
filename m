Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250E971438A
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 07:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjE2FCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 01:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjE2FB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 01:01:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACB1A5
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2023 21:59:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d247a023aso2127328b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2023 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685336337; x=1687928337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqooid6rmRrosD+pJG/icvSkXG6P8Aj4zGJCWNMCDzI=;
        b=lWCjy6/gom3CjuWsJMdNX+Q/mnZzn7uPuhFWQN/C55p7IwlzfICaUB4c7RUgkGmCxo
         5+dSFXu5kIYepnItblVNLhSqxuQDv/otMABgR3atbAwtqcSU9nmV7ZD+Rxzow+Jd7dsC
         6H1pjhvsi42XYSFfAFTX+pn/I1I0Qmwuu5P9TRsT3Mo12TWAEifFMyk8whcx70CSB2Zo
         Tj5hhlqf0FH7POGkl7xiKgMr0b4V1O65fi+h6hHsxvMnBUQIX75+8dTqytmzZq0d9lDo
         MT0b9TE4Gp44xdWDwFf+LxlVY74Ubji7Pv3yulkCDnDSg1QTF15ILlQMzEs4z1k4+gih
         LKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685336337; x=1687928337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqooid6rmRrosD+pJG/icvSkXG6P8Aj4zGJCWNMCDzI=;
        b=dyj1O/A8O2MOWmTBUQQmfUgUwTgj6ilJhrr4cyZjoL5fWWDEfmTwRksgyA5Vbyfves
         2xfC6L7dI5uet1gGCYObatMNRWvN4j7/hTx3GJDemRaHsSIiR9VlHXnmMX2Og8OtIqcp
         QgaDKfe8AqYmFXqT6yK8cKKldzvzdJqycVS671DrzYGoO6xkGRLfD8mvQm2LaPxnD4RH
         uP8PFXSEaCbqOs8QU352ADdhs+CFlrLqqBt1OJky9bmfKa6Tt/35ozcID08Nt20NahNG
         KZrDxExZfzDLVv3y7vj1ks9SMSU7O9M7EV3GzGYdUj11z/KmwfQuLAumfiukPGOU1EGm
         0kPw==
X-Gm-Message-State: AC+VfDzzk/CIiRoKuwVBxBotiLFoyS4puF4mpP6YgEhLiJ9kcU5TxZMb
        vaBxyWPL6CeSnl86rOBKh3MeOg==
X-Google-Smtp-Source: ACHHUZ50HVXC4y+n6kFH/mPdG1qlWl38vipty4Vnphdu+aiEObvFBGlAbGdZ8ndZKCiH9HjlrQwR2g==
X-Received: by 2002:a05:6a00:985:b0:640:ddf8:607a with SMTP id u5-20020a056a00098500b00640ddf8607amr12394367pfg.14.1685336337325;
        Sun, 28 May 2023 21:58:57 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78156000000b0063d375ca0cbsm5906687pfn.151.2023.05.28.21.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 21:58:56 -0700 (PDT)
Date:   Mon, 29 May 2023 10:28:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Message-ID: <20230529045854.gh36k5my4i35jspc@vireshk-i7>
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
 <f8731d93-b335-6d9a-183c-34a652f45455@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8731d93-b335-6d9a-183c-34a652f45455@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-23, 12:59, Konrad Dybcio wrote:
> There are some users which have tight power sequencing requirements,
> like the Qualcomm Adreno GPU.
> 
> Dropping the entire OPP kills clocks, bw and required-opps at once,
> but on certain Adrenos we need something like:
> 
> 
> disable memory clock (clk)
> disable all other clocks, including the opp-managed core clock (clk_bulk)
> kill one, fully manually controlled genpd (manual runtime pm)
> remove bus vote (func proposed in this patch)
> kill another genpd (manual runtime pm)
> kill the opp-managed genpd (automatic pm calls)
> 
> Changing the order kills the chip until you reboot the whole board and
> setting freq=0 using dev_pm_opp_set_rate doesn't drop the bw vote.

I am a bit confused now.

What's the exact problem with dev_pm_opp_set_rate(dev, 0) ? It does set the
bandwidth too, from what I can see.

-- 
viresh
