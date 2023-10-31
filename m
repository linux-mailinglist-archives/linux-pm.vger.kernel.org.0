Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862E7DC5DD
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 06:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJaF0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 01:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJaF0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 01:26:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AFDC1
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2023 22:26:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9b7c234a7so47507235ad.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2023 22:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698729990; x=1699334790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWWTAw4O7AjDj0Sh1SsAmZTItwGjI/fDezH/BgyVAlw=;
        b=iyrIthBau1EczbLqvOsotIzapV+5EhdWLZ9IKJsAaWCZxzqAwYlOyJIbQoEZX2oVHg
         Fn7HyX7H6nWQn3mHBgTbZMO0pQyMnwj7SxbeNp0IrMYvNOlc3q6iqKq4bCPU8zoT7xCs
         u0XnBmqy0CYAMjh4gyG6CvRbPASF9NOABXo0EtAjpDBJ7dFN10e6aOFNzEsg+WoT8pEs
         8nMd3TbxEAjJQz7h4aCc5F/bxDneK7OKsnHDSAD8wC7mLPwqzedFBbjALFRdCXmsxc1N
         /FkLCqgWvUd3eqBxmzH0GOhqjvHH5plGNJYsR+Vdac9cjUBDBkV/bG8G0ILnvpxzYWhP
         KQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698729990; x=1699334790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWWTAw4O7AjDj0Sh1SsAmZTItwGjI/fDezH/BgyVAlw=;
        b=NBGLoSmUgx6od9muxTa0Ugz/4zQ9YeETquIzNy+pIjXXqKYULcz1lmb8BPL+FRGnh7
         /jJW5ImxUmTbmjbw00ol8JbJ1gZp3SR1e9+4MPPD45u0jTE4ldKKbCUpODeqmEHv0DVt
         fVB8osHfcewARzkpUENriMg3PbfW5Rg5Pfbq4oBO68fldX9cds3sAUE2te71TKZsfkI6
         hMJQEqozVs4yQxRg4Mmb7JAa4K5sxDgwgWEt5or92kXsc4+DgXMhzhI3TabLTofYjSCa
         DOdV1sqib2JHYOxtLT4OcAcKS9bHvl9yZ63Huzra6kxgYEmOGMk4evdJ3Hoy+5Nvy2Mm
         JI2g==
X-Gm-Message-State: AOJu0Yzyc75WnkQ4guTCvm5lfS7sux/TqT3iuzfrh4wlOOYgbpTxJ8d5
        QM88OTdY0TPE8G77d7DF6ofGgA==
X-Google-Smtp-Source: AGHT+IFRsDvU9Ch0ArXYOjF51BybtwVhnioDTXiPUiKEzIPIm4/O5fxqCwWUN5s5DgpBwf+zLj58Iw==
X-Received: by 2002:a17:902:e404:b0:1cc:33ee:ddf with SMTP id m4-20020a170902e40400b001cc33ee0ddfmr6596269ple.33.1698729990342;
        Mon, 30 Oct 2023 22:26:30 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001b86dd825e7sm399274plg.108.2023.10.30.22.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:26:29 -0700 (PDT)
Date:   Tue, 31 Oct 2023 10:56:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] OPP: Level zero is valid
Message-ID: <20231031052627.3xuryhy3o4rk5nb2@vireshk-i7>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
 <36de122e568dcba371d3581e5f936243b405a874.1698661048.git.viresh.kumar@linaro.org>
 <3d686b62-13a2-4107-86ff-d9753cb177fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d686b62-13a2-4107-86ff-d9753cb177fb@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-23, 19:47, Konrad Dybcio wrote:
> On 30.10.2023 11:24, Viresh Kumar wrote:
> > The level zero can be used by some OPPs to drop performance state vote
> > for the device. It is perfectly fine to allow the same.
> > 
> > _set_opp_level() considers it as an invalid value currently and returns
> > early.

> So, currently if the device is PM-enabled, but OPP requirements are lifted,

How exactly are the OPP requirements lifted ?

By calling dev_pm_opp_set_opp(dev, NULL) ?

This will work fine even without this commit.

> is the API currently internally stuck at the last non-zero level?
> 
> Just trying to understand if this could fix some silent issues

Also the issue I am trying to solve here came in existence only during the 6.7
merge window and doesn't affect the genpds linked via required-opps. And this
commit will soon be merged.

-- 
viresh
