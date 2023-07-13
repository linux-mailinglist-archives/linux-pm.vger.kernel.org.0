Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC487517E9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 07:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGMFMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 01:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjGMFMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 01:12:40 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7D2117
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 22:12:39 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5633b7e5f90so294958eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689225159; x=1691817159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU3f9OQKR2a7cxUcrQLuhTivCLhFp5YGHO1sZ351/7Q=;
        b=Pv4KC/jmX1h5RaGkzhk8xIJryS9ZzM7mZcrr/uDY07pmNgkFBFXi76SA34H7wrSNbm
         2GrFH3B8nV4H9ZA2A0xx7AR8g4wXrKCfyHcdtXk/Yb6SO9IpfxhyDMiQ1kVoJQ68Z9IC
         XynCc+GxdtaFT8x+aN2AHekUB+xkIAAMh100S/st7SZtbDb2G0Ldzy5+7apv+AQ7RA9A
         wQWya2zHM9DA1JY2iCeIoROSkIFQF0R+Z5OjuM9kSmrFkfz6UMmHkwdP3o94tyrOuRC2
         ZOyHq83pHb65uoE786MEeBrO3uHR0OfXUoQ0GP/RpTkBuRNCM3STYBySeQNRIi1yMq7/
         cfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689225159; x=1691817159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU3f9OQKR2a7cxUcrQLuhTivCLhFp5YGHO1sZ351/7Q=;
        b=COBI8BN06GL30CnAD/ljInCNiUoV5sluGKbaTeFcmBjbYMH7PpRIXgRgf4L3eJluxF
         PNEaxr4lAiIJCezYLzQBbaqP7gKZ8Vd6K1Cvm/M4cjLzYK7w2e+IJ7mJVeD+glTHL2SA
         qtexC5JrDIZez1p4yNewe2bTBewjG8Ny//ZEozuHJuYLCDb7pkYjCdbVoqttc6swRwCr
         bL9jzCNtdywzPNvrQQc4svNNm2l0CpaJF35LJuO5fZMEVHVx7z+lPqWgS/Onyo4PwcCm
         Jb00EKWp3dTtv8R4DyxUr+xCqf4Z8xHMNMXdbFd0LpDuMmil/n+hXvI3d4HfCQivpjxh
         Qh9g==
X-Gm-Message-State: ABy/qLbWeHPCALDJq7lexA0qYH7+i6Tm+ac7pajcgoyYS/dt6HJwIYmb
        J7rS/XKfMbmTZTHmAltQ2Wct9A==
X-Google-Smtp-Source: APBJJlFVtfh+brkVU8HuhcMpavDiEm/S4lSKG6xVm8+rGf5PEmPcC8RMTgmTfkwIgecc9BruTvLlXQ==
X-Received: by 2002:a05:6358:6f06:b0:133:835:8e03 with SMTP id r6-20020a0563586f0600b0013308358e03mr830173rwn.16.1689225158671;
        Wed, 12 Jul 2023 22:12:38 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id o11-20020a63a80b000000b0050fa6546a45sm4549950pgf.6.2023.07.12.22.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:12:38 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:42:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Message-ID: <20230713051235.ob5z3li3lz52xtzm@vireshk-i7>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
 <20230712163406.GG102757@thinkpad>
 <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
 <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
 <20230713050550.GB3047@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713050550.GB3047@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-07-23, 10:35, Manivannan Sadhasivam wrote:
> We can settle with this custom callback for now. If there are drivers in the
> future trying to do the same (skipping 0 freq) then we can generalize.

Just for completeness, there isn't much to generalize here apart from
changing the DT order of clocks. Isn't it ?

The change require for the OPP core makes sense, I will probably just
push it anyway.

-- 
viresh
