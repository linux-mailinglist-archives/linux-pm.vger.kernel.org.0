Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B31567EBA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiGFGjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFGju (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 02:39:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715E915807
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 23:39:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j3so884943pfb.6
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vRmDjPpc1ypdcneiWKEOt2A9rTdMJLx78Cgy5W5981I=;
        b=n2H4gCdeHo2gNaIplHcteu9pNdBzHjiMsZ3HktbeujIfTSTHZOIp8M6i9KFOS/7tGo
         AGG0KWlbosrHRn6oXOB/3NXtAS+fw9ucxy3MMKMh7JmCZg+NF4fPZmECERwUugcbmlDG
         Q7qY6Y+kcP11LhpO5z553sCkV53YQkExlJ11RGhbVaIQoVwnWCVogdPDpK9YDveaJ2B8
         QBlZx1dToQ1uDdrjAXV9eEueKGMNKaDenn9rpgJBPtPCdF3X4cobBb7piYAfPKkYQIS6
         LW+2XO6gTYgy77S3O/VFScec0XhN8bNR6S24/06C49uV0i/xvXtEO2cLsZ0TikvoYaWd
         HUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRmDjPpc1ypdcneiWKEOt2A9rTdMJLx78Cgy5W5981I=;
        b=qsygQ4Bfyi+7m7BJFeFHHjSSR6lAkU3bu7DJKgWiSKzcoY4u3eCmGawsroBeYsvwau
         uCJ7HMWzqYAZpoaJppPDVvcrSWlvQZxgiZHhGQJmTn2/UiqGg7lZQrXULZaS1H31/2Bx
         98bXuB0s3sb+GVkoEkeO+ruYE49t62amVeM2UiMHEFW1SQ1lSEZ6qSt9OXP26HT+knBX
         PO7AYvwhJU6Ys+JJc5/3q7xlRDOFPZjiRwAOFcJtjOJ5PSmQXSfSM3KvTtNdRb46FM3Q
         mY7JUm7RHNFazKdDAa3a9LI5sLqSUC2v4NBZcHXMmlr/3ef16RNS3vbhwc2dRwq/cZjN
         W4cw==
X-Gm-Message-State: AJIora/ZvLXBXbyyTd5S92qPSjC0u6xGm2HnG+wSV/4aEEwAXHigiRby
        VUncGwz/D7kpfvSu4vi1FCf6RA==
X-Google-Smtp-Source: AGRyM1uxQGhUy5Sr+MIJTzxNS6ZGjSIqdJU5vg3JQGPO6WWbvIuMl58/vYe/PFW+FZfao0qAeALdqA==
X-Received: by 2002:a65:42cc:0:b0:3a9:f71f:33f9 with SMTP id l12-20020a6542cc000000b003a9f71f33f9mr32966547pgp.391.1657089588947;
        Tue, 05 Jul 2022 23:39:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0051c2fc79aa8sm24619356pfb.91.2022.07.05.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 23:39:48 -0700 (PDT)
Date:   Wed, 6 Jul 2022 12:09:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 09/13] OPP: Assert clk_count == 1 for single clk
 helpers
Message-ID: <20220706063946.pmtkwiyfzxx5ka7h@vireshk-i7>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <f039572f213ee49125d3d1ea4e64a94b79778426.1657003420.git.viresh.kumar@linaro.org>
 <df997015-df77-2bcb-1551-6e8da4acb36a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df997015-df77-2bcb-1551-6e8da4acb36a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-07-22, 19:21, Krzysztof Kozlowski wrote:
> Where is the safety problem with multiple-clocks case?

All these APIs, which I have added the assert to now, are designed
with a single clk/freq in mind. They simply take a clock frequency
value as input and do something based on it. It only works fine with
single clk case, as more information is required for multiple clock
case, a freq value isn't sufficient here. In order to avoid abuse or
accidental use of the wrong API, these WARNs were required.

> And how users of PM OPP API are supposed to iterate/find OPPs they
> want if the API now throws WARN?

We need to provide new APIs for that, as I mentioned in the cover
letter and the other mail I sent you yesterday.

Specifically, if we want to have OPP finder API based on freq value,
then it needs to either have index + freq as input, or an array of
frequencies (one for each clk) as input.

Though I am not sure what you would need at the moment, as you can
also use opp-level for OPPs as they match UFS gears, that was my
understanding from earlier discussion.

-- 
viresh
