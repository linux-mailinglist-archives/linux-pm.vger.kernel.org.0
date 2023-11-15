Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441897EBCC8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Nov 2023 06:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjKOFcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 00:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOFcx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 00:32:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C038D0
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 21:32:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc0d0a0355so49569685ad.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 21:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700026370; x=1700631170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wn0zR94MODGMnkK7iYRg3HxxZuO2tLtbCdWXHHLP9tA=;
        b=xW6E0Qdpd+ltYldXhAWQZtbJnw9IAqXzju4v8AhVyD0mHVlRKVx3QUoyXeHAObx5BH
         H6Leoqks9t7/vj/oUAcPLCX8+WZupd2j41gYOjUSRrAYrZkd+2hWWBj8/PROqERucpte
         Z/s7RUM2pP4FhGSEoW2pS8JxXm+laYcRuwOuZyoshc+LCjXIcGeoyebQXkwaR0hOZ4mV
         3nvceya59JyoA0vseXFHntUiGpmppfMEtPekzoSNVU5PGIkuqa8fptX+LCGvd9e5/2NX
         JRgLg2++joAzlTHBDVjrgGdS9TpjMQ62Q5PWyAmjRb1R1fxrIw+ivwEdQ3wwuGhXAiZu
         Gcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700026370; x=1700631170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn0zR94MODGMnkK7iYRg3HxxZuO2tLtbCdWXHHLP9tA=;
        b=KE1Fm8Qm1NzMCx1sipuRzjWsZO6nz0UABICmizHIRti3rSo/oJ00sbeGMH1tNQ1AlF
         IRXU3eDHlj+AEgcJF/lpx5Q0dlt962XBTkvQOBItnEE8S3hxnNiyZs5WTyy72DX75BOm
         SdLaZ7MY/+RyKpj8XLotGPDUoWqN750Z1iGo91PyrZRqcQCsJ349ZjWZ9MG4N3mm1Jvy
         vUHJPOTTGO739PsSFQP7/lcq3/F4hB526SwC1a2bfAeKvgnOBPO4x9+zuWNhaNXErdV9
         8EoZKnhXX2dqDSR7B0qYBiVkwDeEtBFTFIwXtixBLWvmSaxLM+d37HhfajKaF8l4uu0a
         PYgA==
X-Gm-Message-State: AOJu0YwZP+w7bsis/cBqu15ycwwIHylvS2oZDz/7GNt6cduRRJ3nTRRu
        4A09o+w8lje35ClHzQw+Ht7jWg==
X-Google-Smtp-Source: AGHT+IEFZaA4NAKfIV9zxh+7zPwUJ/gat7funlktQfai7iTSSU+VmcJXORoDZziDD5/nZaQpwYFSNg==
X-Received: by 2002:a17:903:234b:b0:1cc:9781:4782 with SMTP id c11-20020a170903234b00b001cc97814782mr5616546plh.62.1700026369734;
        Tue, 14 Nov 2023 21:32:49 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709028c9200b001bdeedd8579sm6571007plo.252.2023.11.14.21.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 21:32:48 -0800 (PST)
Date:   Wed, 15 Nov 2023 11:02:46 +0530
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
Message-ID: <20231115053246.i5x4bdgtrjvoui2e@vireshk-i7>
References: <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
 <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
 <20231030102944.nrw4bta467zxes5c@vireshk-i7>
 <CAPDyKFrn97POKuNc3cMM9TOaw-f-ufLwYtUY8_L2w8+hzECWOA@mail.gmail.com>
 <20231106070830.7sd3ux3nvywpb54z@vireshk-i7>
 <CAPDyKFpgPdMLR12ajYFasCjm-Y-ZyVVtQz3j1CZVWfN9T3Gg0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpgPdMLR12ajYFasCjm-Y-ZyVVtQz3j1CZVWfN9T3Gg0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-23, 14:50, Ulf Hansson wrote:
> If this is only for required-opps and devices being hooked up to a PM
> domain (genpd), my suggestion would be to keep avoiding doing the
> propagation to required-opps-parents. For the similar reasons to why
> we don't do it for clock/regulators, the propagation and aggregation,
> seems to me, to belong better in genpd.
> 
> Did that make sense?

Hmm, it does. Let me see what I can do on this..

-- 
viresh
