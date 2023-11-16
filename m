Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5487EDEB7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 11:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjKPKon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 05:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbjKPKol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 05:44:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73D81B8
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 02:44:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso485919a12.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700131477; x=1700736277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiLOh24j4eoUK7LZ6otpZgVebzeyiIBGFFVrKcQ+fSQ=;
        b=Cg5toAWsiNoShmDQK7j1zFF5dYKcdcYiDRj+SyIKBtCXZsrvWPgJE4NfASNkBFEB6+
         1UyPnffpqeojjNZWLhk2KXBp1ZamUBo3a2m0nb278rFdYklcMUI0D+yUyXOem/5gDqTQ
         CxNgWorvbS4Q5E6YFCPc0bn4+PyZ9hwrPXwK6xKoSLHepEZFXQ4zybcr4kM2YBnLikLA
         b87ppkKkc9AinLE5SsTI0uLB/jx9vlXuU1l7Cgqf0AhY0jP8bmEaeIWsde3KuyMGvmks
         fMh5p4U9IY3c/DYAf7FhUcD4pif8y/PG9vngO8qn6dFqBhV/CmUHf9j/nx1kqpuxuAJh
         UNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131477; x=1700736277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiLOh24j4eoUK7LZ6otpZgVebzeyiIBGFFVrKcQ+fSQ=;
        b=oeuKz8LS3eeJ+JlE9xYIJHBuT0p+tM6ME9Mmk3bCQj9fj3fy4U49rT/TztodaFrji9
         pMDFV9kigjSoUL6OfWvmBpEeknnZUCOQ8++IaZ6efBxBjWptKGupAoUzk/qQEvkPu9HM
         QW0bx0qxaAWMiVOzTe8fePMGNkQbY/OZ725uKVlSEod+P5+KBKi4xtZU70ueR04ZS3m/
         lq3nDZZKfXWsWWj0E/uZrvL5xUBcIm8bDzQwmlPR7WuSOy+mYfUQcXJA4Hhs5WR+cnO2
         vkR9GIxB3JjsdeLw9GGMDjkLXk0W497xeWz2Kb8aEgNWChZ0HTLlkvc8Sl0WXrvqRrR0
         RMXA==
X-Gm-Message-State: AOJu0YxRJJZ3pNNlHGhrsCoclB9mp99UACHzyg05ap1JAxUZFZAJTTvU
        42fWsw+f/Q0rKBY9Y5vOifiJaQ==
X-Google-Smtp-Source: AGHT+IG+6AE8DfPONTWqgJ8xui34M+vOQoM5NFd4mTORi/CJ9o8XSR7KB9tKL+/BqTnD7rzqYxG+ig==
X-Received: by 2002:a05:6a20:244e:b0:15e:d84:1c5e with SMTP id t14-20020a056a20244e00b0015e0d841c5emr19322604pzc.38.1700131476904;
        Thu, 16 Nov 2023 02:44:36 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm4215318pfk.219.2023.11.16.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:44:36 -0800 (PST)
Date:   Thu, 16 Nov 2023 16:14:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <20231116104434.fnukzusznc3kifbn@vireshk-i7>
References: <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
 <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
 <20231030102944.nrw4bta467zxes5c@vireshk-i7>
 <CAPDyKFrn97POKuNc3cMM9TOaw-f-ufLwYtUY8_L2w8+hzECWOA@mail.gmail.com>
 <20231106070830.7sd3ux3nvywpb54z@vireshk-i7>
 <CAPDyKFpgPdMLR12ajYFasCjm-Y-ZyVVtQz3j1CZVWfN9T3Gg0w@mail.gmail.com>
 <20231115053246.i5x4bdgtrjvoui2e@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115053246.i5x4bdgtrjvoui2e@vireshk-i7>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-11-23, 11:02, Viresh Kumar wrote:
> On 10-11-23, 14:50, Ulf Hansson wrote:
> > If this is only for required-opps and devices being hooked up to a PM
> > domain (genpd), my suggestion would be to keep avoiding doing the
> > propagation to required-opps-parents. For the similar reasons to why
> > we don't do it for clock/regulators, the propagation and aggregation,
> > seems to me, to belong better in genpd.
> > 
> > Did that make sense?
> 
> Hmm, it does. Let me see what I can do on this..

Hi Ulf,

I have sent V3 with a new commit at the end to take care of this.

-- 
viresh
