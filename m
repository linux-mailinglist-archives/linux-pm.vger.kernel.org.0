Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D3712515
	for <lists+linux-pm@lfdr.de>; Fri, 26 May 2023 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbjEZKxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 May 2023 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEZKx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 06:53:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0634194
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 03:53:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2981e3abso659852b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685098403; x=1687690403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZaUcPzxpXLq4q3ksbnQken4Ept0l6BdGBrTXJ2GhJ0=;
        b=LVkU7SDd5isg+vkO4TFsklxe8wPkV2HjaU47K+MWPblNxRO2I1XL7kz7zLI+sD8bJz
         iso/X23qLbOnACM5eeUJsIxkIEUeIBSGJN7FqcplLvKCFrmG/uvt6Pg0n0udK1xkuJXA
         j5Tkz7m3ESH1KFawyrKjwD4lPvC3t247yeL410EWyGKQHcVgO6blQQAM7v4eRfjNWoFR
         vfi+2bev4zTOAZ6HtyZnUZRx7iwkRHX37/qrhuOLMKMKnCG1yxptKqUtDdcwKXkNQ1Y0
         pQEIEmMDODrZ5KEiNHDks5fPTWESfrz9kD0i/wAeF2K2b8Gq1U8rNlnw3ZU5VTuDES/U
         toUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685098403; x=1687690403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZaUcPzxpXLq4q3ksbnQken4Ept0l6BdGBrTXJ2GhJ0=;
        b=e9CSslk6u2AELOVovPhhHUVFn5MJVj8q/2U4i3mwnebxRJd6MsxAeskTUnXcwtIL9R
         f1h0Ltl32myRluL3LtVqN6aCl5IH8fqFfPNaj1KxNpE0+ESUXPlh2bq3NqB9ZES39MAa
         9rR5gXr4YY6N20mPVvntl1SLyxXjd8XTcrgfvw6DUdt4vb+A8OolPEiypk0pkvKZFOLN
         bRAKs4NlRkrHDUK5a+7JyhFJBcoqalpp2y8dZtzsbaprcqxUdTXfw0YqWQpu24Gu6Ikk
         KW3X1a7xPCIk5su/9hAquj86+P3V3pPgi196ORdqADu9YIHhmInfXIDF6zl0Y4WHVO0U
         rniQ==
X-Gm-Message-State: AC+VfDy+fr84UAXGhZ7EfmN2soht6/Xl0GqBcEXzYI/MW/T69Fdo0CAr
        JR8VIwbXBOnP8Rh+37WlU8EMtw==
X-Google-Smtp-Source: ACHHUZ5cBOagZMGeGoDaS3frB1q6nyW4neA6oySmK5jIoJt0MCmuMOHyEB+7VQMy1vjpp1vMNZk7Tw==
X-Received: by 2002:a05:6a20:3d0f:b0:10b:ecde:291f with SMTP id y15-20020a056a203d0f00b0010becde291fmr1935400pzi.57.1685098403340;
        Fri, 26 May 2023 03:53:23 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id gl21-20020a17090b121500b00253305f36c4sm4365923pjb.18.2023.05.26.03.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:53:22 -0700 (PDT)
Date:   Fri, 26 May 2023 16:23:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Message-ID: <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-23, 11:17, Konrad Dybcio wrote:
> Currently it's not possible to set just the bandwidth if the OPP
> describes other properties (required-opps, opp-hz etc.).
> 
> Introduce dev_pm_opp_set_bw() to solve this problem.

The OPP core (intentionally) doesn't provide any such interface for
freq, volt, bw, level, etc.

Setting just one of the properties for a device is potentially harmful and the
OPP must be set as a whole and so this isn't allowed. There is
dev_pm_opp_set_freq(), but it uses freq to just find the OPP and sets entire OPP
only.

Why should be break this for bw ?

-- 
viresh
