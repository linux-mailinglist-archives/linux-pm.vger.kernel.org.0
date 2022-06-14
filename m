Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005FC54A72A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 04:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354828AbiFNC5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353253AbiFNC4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 22:56:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E53439B81
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 19:46:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 184so7254464pga.12
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8Vdme45KPD8JEMgxgTxJv+TT9cOmNZag0xSTrMvHCk=;
        b=TXgZgG2MyqB6u9KrLPm7Y/iQ+IMLF6gw7RKK4yM3S68AKE4ckOhx9gQ7eWo7g3Fe/D
         OWbv5/gykB5suQ/V3/23m3i39Ij5IgGrtqVSLXoBRI4h/XO1y4ZcUrXW7Nnr1CLQd7rY
         e1SNBNCzETFi98Mvlhx046mZQFJBpmNGYP/PpT3qxDShbGJAQan2JMeJKq/P9T7/TcIO
         a6lEZQljf/lCCPjhP77qc9MmQ9EAmZ+GMZ7opPNP9RBciT7pRJQN9YBpT7zk6Zw10rW9
         lv/rW86ylpzjVeeoc0OEhY6tBOGlTNKeF9Uf5IWG9m2v5jtUwrffwLfPon8X1dnWbapJ
         dSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8Vdme45KPD8JEMgxgTxJv+TT9cOmNZag0xSTrMvHCk=;
        b=VaZg8rEq39y9WbIay3ZavS4rXsQ3R0UKiAOn91qW604qT20wEcN94bB3P5Jfz+uDY6
         cYimVuz3WI6H1ITloBEN05gt0SuGawdyxUrMIbb3TBEy6gUa+lN+I17iuUjw6cCe2fLm
         mVJssJuLSlpLmZblztEnzXvcjY3psJvxpiEhE8qtAlyzu4MHnVjlh2c76XS0QJdz9DxM
         0czVzxPR43ALpI02Ixy4Sx73bHOG3+esiRH+fcRZj3gq6FuUjgDpbVGQz/NFQ1uT8V4N
         Dr6BiCIFeDDABxc7tHI8qDLpHqdUMNY2lgSVZ9JSVQ9ssRvuTi7b9S5vtNhX88ygerW1
         kY6A==
X-Gm-Message-State: AOAM531QqwAi7/8OR/dJp1ZbwwKL7x5n0YVsmICXcICommkeOo+wno/u
        5FCZTvKkZ9gDUDJr/2aJGr7U7w==
X-Google-Smtp-Source: ABdhPJwMWgShVCjR8uxh+FdIHIBWKCV9uSyVFt2uqFD/oIvOb4Ckp5Xkw3ycFjo5ci2/God8rBP8HQ==
X-Received: by 2002:a05:6a00:124d:b0:51b:f2ac:ef8a with SMTP id u13-20020a056a00124d00b0051bf2acef8amr2324008pfi.72.1655174809120;
        Mon, 13 Jun 2022 19:46:49 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id f27-20020aa79d9b000000b0050dc762814fsm6152711pfq.41.2022.06.13.19.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 19:46:48 -0700 (PDT)
Date:   Tue, 14 Jun 2022 08:16:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] OPP: Use generic key finding helpers for level key
Message-ID: <20220614024646.gf4ociwakw72bi3b@vireshk-i7>
References: <Yqc6CgShqb/RId3D@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqc6CgShqb/RId3D@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-06-22, 16:22, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch b26e72f76892: "OPP: Use generic key finding helpers for
> level key" from Jun 2, 2022, leads to the following Smatch static
> checker warning:
> 
> 	drivers/opp/core.c:688 dev_pm_opp_find_level_ceil()
> 	warn: passing casted pointer 'level' to '_find_key_ceil()' 32 vs 64.
> 
> drivers/opp/core.c
>     678  * ERANGE:        no match found for search
>     679  * ENODEV:        if device not found in list of registered devices
>     680  *
>     681  * The callers are required to call dev_pm_opp_put() for the returned OPP after
>     682  * use.
>     683  */
>     684 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>     685                                               unsigned int *level)
>                                                       ^^^^^^^^^^^^^^^^^^^^
>     686 {
>     687         return _find_key_ceil(dev, (unsigned long *)level, 0, true,
>                                            ^^^^^^^^^^^^^^^^^^^^^^
> This will corrupt memory.
> 
> Fortunately, there are not callers so we are safe...  Can we just delete
> this instead of fixing the corruption?

I expect the callers to be added eventually, so fixed the offending patch
itself. Thanks.

The same problem was there in bandwidth specific helpers too, fixed them as
well.

-- 
viresh
