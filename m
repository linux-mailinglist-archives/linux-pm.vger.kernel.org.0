Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EFF7DFEB6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Nov 2023 06:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKCF3D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Nov 2023 01:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKCF3D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 01:29:03 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3E18B
        for <linux-pm@vger.kernel.org>; Thu,  2 Nov 2023 22:28:57 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so928676a34.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2023 22:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698989337; x=1699594137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5BuWds/Km7S1ap/RjvexaNEcZ8RFMVEsbKbJHRq8sI=;
        b=J9zcEp3qm+4bRTtdvA/9kaLHA+PkHKw2mOzybVUOvLH2JNHwG5ej6tZgg9La0Dlotk
         pLG2QwMIV1ApCKOxXpbqXScqV0bh/dqPjbei8OrSwrTQX/8lqfSiZhLIDCF783cLRm4i
         QVz+CR4CtZfH9q6iaCvXWp6RKOXBqqdHrs/l2jbq9xr6Z6DJlRDr31lviyKUtt6V16fb
         JGYP3VkdG2c0X5oJ3XMsPy0mVJyTfnX0OX2q2VLrAPcaO0o68INpa1pbSKRQ+ahjbRtY
         Ch8tTaWaV5dJzqST+e6Tn1layj05meqP8nmNxh/ypbnEG7nJKMp277Rb4uIJeOOKNlib
         vQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698989337; x=1699594137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5BuWds/Km7S1ap/RjvexaNEcZ8RFMVEsbKbJHRq8sI=;
        b=jvV69PdGUx1RlUtPq6IBOBmEzVIMRtR4k93bGVLMMC430FdGEzefd26/YDJIitHQ90
         B4acl9mwzzgqPl9QuTYg7QPka+4TYQzPfxDPWZkXPzi0Be3HXIDXxVqsjdSlwr5Bb2uS
         X5z07tYn9yaGs1xkeY21V7ZC4grz2Xf83+GT3T6LKREEnQsTxu3GnYVN2HARfUenjgQy
         iSD4Cu58CIezfRn2B4//clSonKDItCarjcEITbJMm/TbejCejdF9uY1A/0AOCa8NAzQb
         /QmBkmw1+sjVYNo0FfJcTIPg6IiIQO5aC7GYTf1w8A/VKt0M4PhjELqxqzpxWSZsVPfG
         O/ww==
X-Gm-Message-State: AOJu0Yw2AGl3zo7QfpuNUGGUgwo7P7LBXbnC2pPuksdPP0W8XYrRo9zi
        4JMeYJg8Gnnk1LrL7lWqP4zKtA==
X-Google-Smtp-Source: AGHT+IEvTVDta+QU5POWQFXjIRIq+4Spd7NzF6ZNGRMoKviplKh2yc6/E+96Cv7AM3VXzgvFFAAbSQ==
X-Received: by 2002:a05:6830:1d9:b0:6c0:e5c3:40b5 with SMTP id r25-20020a05683001d900b006c0e5c340b5mr20551418ota.6.1698989336873;
        Thu, 02 Nov 2023 22:28:56 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b0069343e474bcsm592667pfd.104.2023.11.02.22.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 22:28:56 -0700 (PDT)
Date:   Fri, 3 Nov 2023 10:58:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] OPP: Simplify required-opp handling
Message-ID: <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698661048.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-23, 15:54, Viresh Kumar wrote:
> Hello,
> 
> I wasn't able to test this locally (despite trying to hack it around) and need
> help from someone who is `virt_devs` field of `struct dev_pm_opp_config`.
> 
> Pushed here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps
> 
> V1->V2:
> - Support opp-level 0, drop vote i.e..
> - Fix OPP pointer while calling dev_pm_opp_set_opp() recursively.
> - Minor checks and fixes.
> - Add Reviewed-by from Ulf.

Stephan, Ulf,

Any feedback on this before I merge it ?

-- 
viresh
