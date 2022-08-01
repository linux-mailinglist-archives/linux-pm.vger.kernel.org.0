Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7A5862AD
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 04:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiHACgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 Jul 2022 22:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiHACgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2022 22:36:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3964D632A
        for <linux-pm@vger.kernel.org>; Sun, 31 Jul 2022 19:36:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h28so3019591pfq.11
        for <linux-pm@vger.kernel.org>; Sun, 31 Jul 2022 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/btFMtkRWmBmwZL2J5Giju8R89Pj69dl4iEYhrOPPD0=;
        b=l14ypADMZwmwBX3PPuNnhfhC0pkWgO3nxHo/kcyqcDQQy6USdhzex+seukGsSkiqSF
         CD7pjPOYfJb33Kd7/A6vDuOlVFJR69nqhta9PCeUDn5y37fM+EkdqrOWOxK0nM364cNI
         2hS6W+ancz2HhSWKGABkGucgEiskAd7ylplsxyesLdgbKYAGyM0I/K+ZEXPCQJj/GkFL
         8Y9XaXvYU44xz7LbcwFhfHWp3z3bb1GMR4qPIK58+MeCotpAY7lzMuOK025gYsWI0JgR
         W00nJkIsFipx8cXltA+pedB7ltCKnQ+3K6ezUJJcMD8vPYZcKGA2QkZCWNkwtVcXUu7k
         0vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/btFMtkRWmBmwZL2J5Giju8R89Pj69dl4iEYhrOPPD0=;
        b=QTRGYqG7EK/NKdtC7MXY4XUwqG4YnpOak5WMB5zAvnXgSWkZ8tEjvJLTApU9YPptUi
         v8uRHJSCL27UIClZQ2w7VflVNpr8PdBViDB5s5hxEvYwLtJd7+IERYnMR6hBOxSxruUZ
         6FHMmZhOkxnSmFGDVNLAUelW4EU1xFcq6qEcyPn1YD4i9Tj44ErTE+YSyEYhl+s7MTrE
         54bn9oCzm10WCNd0linJdSolmArREL2RK5OQiVKC5RSw/O7z7FE3B0Gfk2vGHNFhEYow
         j3TajGfzlM7mJkENuEd+iWizK7VIiQdDogV0pLK0x+OhGjIHgToLYS77XGaUWP3piFPC
         RxaA==
X-Gm-Message-State: AJIora//xJG2cv9s47iZek7JAOccg7GTsOLGD5B5r3JwXYaruYfAG8o6
        POXKexhhV1mDjHH1Fwxei9fGwCdu9jM1Cg==
X-Google-Smtp-Source: AGRyM1uWuPpbJThAzj8401hKyu6FavGanE+K+gT78KliFc+nSDEucI4aDKw5IqZW2VO01+cLRobseA==
X-Received: by 2002:a05:6a00:24c6:b0:52b:ee89:eca9 with SMTP id d6-20020a056a0024c600b0052bee89eca9mr14043056pfv.78.1659321406689;
        Sun, 31 Jul 2022 19:36:46 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b0016d1f6d1b99sm8237530plx.49.2022.07.31.19.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:36:46 -0700 (PDT)
Date:   Mon, 1 Aug 2022 08:06:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
 dev_pm_opp_set_config+0x344/0x620
Message-ID: <20220801023636.p5ytjqasedpohmdy@vireshk-i7>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
 <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
 <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-07-22, 14:55, Stanimir Varbanov wrote:
> Hi Viresh,
> 
> I can take a look and provide a patch to fix that.

Any update on this ? I am going to send pull request for 5.20 very soon and it
would have been much better if this was fixed before I send that.

-- 
viresh
