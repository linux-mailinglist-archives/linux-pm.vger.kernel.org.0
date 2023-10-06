Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6A7BB1F7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjJFHJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 03:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJFHJ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 03:09:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8AEEB
        for <linux-pm@vger.kernel.org>; Fri,  6 Oct 2023 00:09:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0ecb9a075so13605645ad.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Oct 2023 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696576166; x=1697180966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ix4pQAzWFH3l8TYA1pZkl9Bx0YvuYD4ExOCvfP59A=;
        b=imNPx5IlU1qtlfgSjsGc7FaJg1k3j3vU6r4xGQcjhhX9EHOsTW4Wd0CuqH+Z2u7PeM
         flVOUA9dkqyTmI98i76mHhnNIkkoKn4i1nyGwT1oLwFQSX121ppPApH/35e0Xr1+mxg2
         X2Q7lRL4vTK8RYg7gx7J+XKWj0Mf8N+lEGllOfd/gorowe/tsUu0aefyLKXdFladGh30
         BJDm+xM/N3EAZwm+cqGXwG2JODUtG4EQoIFZxLVaBAPWrCJDyGd7/lQIaTj0OrnRCZrp
         rGpXSrUcxcJ/dt3GfGIqQEDsoDA02Szwd6hyEZRz9e2hHaWCh9kMHItVdn6b+9cbvG/E
         fJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576166; x=1697180966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ix4pQAzWFH3l8TYA1pZkl9Bx0YvuYD4ExOCvfP59A=;
        b=DLJjjtCOlU6S2ZMDvFfzoRGqOEeGgZsrlCzzZvLPUcuztUxZ8YByNbnA1VvrPQ1Q1I
         uY/2ACgPoKcJS1TrQogEZ2tq4+ayFTE1Rws1sWdbNoeKm5pTc+vY+k17UCjuBrNdCixf
         kzYE0VXrsKS3ymZCdJu63ER7QOPRDeQngDqY0zlMz0B87DkdozCSjEDFo8RK+AyBSa3s
         3ID3AyAwz3pZpa8YMj6B+7/eLKdtUeeEWcFwnuiuYTkkXmJRnaHumwKypOtN/Dzr7bpz
         wy83wED3q+AGQEdytkg/+OgD02V/ne+uVKyqeKIA0mdgYiB+DPdM4iL062gl3c7LRuXl
         Te4A==
X-Gm-Message-State: AOJu0YxhvKdFJBJXsaDgViavDiiWJ82ucPN+enRVi8xWQkzPfR2l/U/K
        bN/HKzSuvUUwsZH9MK8MNoo6gg==
X-Google-Smtp-Source: AGHT+IGPT2TrSlWvfu/luyb0+78z1cuvGwxlrHt9xIsh9ALOrCdKQgFyObbg2zqlqc5pM6A0/5KK+w==
X-Received: by 2002:a17:903:124d:b0:1bf:d92e:c5a7 with SMTP id u13-20020a170903124d00b001bfd92ec5a7mr8400052plh.28.1696576165741;
        Fri, 06 Oct 2023 00:09:25 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001c6092d35b9sm3027846plg.85.2023.10.06.00.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:09:25 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:39:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] firmware: arm_scmi: Add generic OPP support to the
 SCMI performance domain
Message-ID: <20231006070923.hf3izdazuwng7uv5@vireshk-i7>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-10-ulf.hansson@linaro.org>
 <20230929162522.zjoh5d2tqspzm3nc@bogus>
 <20231003082133.xyu46szs3jfm6fks@vireshk-i7>
 <20231003112647.bbqwnre5bzijw5sg@bogus>
 <20231004050806.sba3ogq76yiylrro@vireshk-i7>
 <20231005150649.p6viyorcucq2irsi@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005150649.p6viyorcucq2irsi@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-10-23, 16:06, Sudeep Holla wrote:
> Thanks, I wasn't expecting these patches in the branch, but if you are
> aware off and are fine with it, I have no objections.
> 
> 	dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps
> 	OPP: debugfs: Fix warning with W=1 builds
> 	OPP: Remove doc style comments for internal routines
> 	OPP: Add dev_pm_opp_find_level_floor()

Ahh, I didn't create a fresh branch for this but added them on top of
OPP changes. Fixed it now. Fetch the repo again.

-- 
viresh
