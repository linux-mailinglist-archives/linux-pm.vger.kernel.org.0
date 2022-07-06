Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857CC568C8D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiGFPXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiGFPXj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 11:23:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A017052
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 08:23:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so10938307pfb.4
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DDTgoj1jp1g8suA37nuSuQrm4nVNe/H8nOJKr5Nvi0=;
        b=cFcexwjZOJ0fITRZd/D8GaW95trrWBANNl55bssV5aM9/OKNX017JVQrPg6Wlvbmil
         xwVnLGDg2MSVzCt4MR+suEzCDPAw7P3z2o7EFRnoLJrbZ9vMmnWPMDn7h68QlcQaJEIO
         C8RhjLmdHk7PXNA7/y26Ah1FQ3cUla4ByNKGPSNH7bVo2V9AbE0J5t9sM/qNb1XaT+Or
         CRbBVODKq0RMKCAXSIQmJIt4eBHkxnPPXIwroFmPCUr8SL+pvnGJNMskPPDICL9M8amq
         1mh0vYvN6iqYrKD7l9VY+CwGR6XMMTGzJJ8LfbxBMNe+qZxBiBTRAB8FcxK9Apdec5d6
         mkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DDTgoj1jp1g8suA37nuSuQrm4nVNe/H8nOJKr5Nvi0=;
        b=WCoccv3/SCA4oPm4Eezv3cGx351OjuzevuFqI1OhgIipW52g6FEWmReo8RoyjSD6If
         butS6uQRCXJF6oX5GK5J6UYbfpCulyX3qNJV2XK6sZqzJrP9S9JuQfX/b0svujPPgNpC
         mSkkrdpnLN49bYevYYGekkR8XcKOmHafrtWQTDGOS0raZPwcG5WLEV/LTebmoKW8MDjh
         M9/anZaz7Unem949bocI7hQLfMx9GXQU11axcTfKAbAJAJDh3R2a8Bz54UFH4LlWXpFF
         7LSmjyynPlJIL4l/Eq1j+6TFbN4krNh/Ndx+nzjdDQaGdQ132G3Cdve+XIX9VaGwjA6p
         qbgw==
X-Gm-Message-State: AJIora8HPDnaZdG0nyTKF9IP43SpKpIwSHy+ItrlIrKcqQC1ZCfhb/dd
        KRHB2IrNZ/nGHvMD89+s4OOOcg==
X-Google-Smtp-Source: AGRyM1vOu+U4rg62/OuStTjMI5ZLfLyp3YhtznAcTClM8axaxY5pjzfYIkfoMkdXZ0zgh3TpSpD/Jg==
X-Received: by 2002:a63:3807:0:b0:40c:73a7:b6cf with SMTP id f7-20020a633807000000b0040c73a7b6cfmr34203690pga.240.1657121017292;
        Wed, 06 Jul 2022 08:23:37 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm24176464pgk.76.2022.07.06.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:23:36 -0700 (PDT)
Date:   Wed, 6 Jul 2022 20:53:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/3] cpufreq: Panic if policy is active in
 cpufreq_policy_free()
Message-ID: <20220706152333.fvgybznz3j6ffmre@vireshk-i7>
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
 <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
 <CAJZ5v0gswDEdK9-gC1dPr9BFPv3G9rs+JYe-7=1JZ11OMoBb-g@mail.gmail.com>
 <20220615045957.55ocdyddcac3vwct@vireshk-i7>
 <CAJZ5v0gDCS8mkoFjnqOAi9gGuhTheE79FwvRWgeoxagMj3Ok0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gDCS8mkoFjnqOAi9gGuhTheE79FwvRWgeoxagMj3Ok0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-07-22, 15:49, Rafael J. Wysocki wrote:
> WARN_ON() would be somewhat better, but then I'm not sure if having a
> full call trace in this case is really useful, because we know when
> cpufreq_policy_free() can be called anyway.
> 
> Maybe just print a warning message.

The warning will get printed, yes, but I am sure everyone will end up
ignoring it, once it happens.

One of the benefits of printing the call-stack is people will take it
seriously and report it, and we won't miss a bug, if one gets in
somehow.

-- 
viresh
