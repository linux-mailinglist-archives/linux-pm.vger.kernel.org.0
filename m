Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DEE7D06CA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 05:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbjJTDVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjJTDVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 23:21:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787FDD49
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 20:21:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso366578b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697772100; x=1698376900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvi7YH2NIy5UBrE4ZQ4YiiWnJtMoiG/cFOIeIIJPu00=;
        b=na1D9wzgMcm6Fby90h062b/8l3VlKsbKHdjwkIxabUb105KZuJzNNajxZ/qPO5WqPz
         BXABj95mD2PqNLVKR8hOZ534Hm3dL1qb2dQRiysoUX4PsSOPqkck3jBTvA+2c2XTkYhI
         cfI3eSNXquHE5q2H5kGp/zsoNers2Wysj8FMNFwiqCwKic2+K1UymoJ7jA7bbYtcsv4G
         6G0xM7cFIlYCRi7ZPPlhYNxLBrjw8kkljoAGZTHpbzlDzsNb7mCRkSmPWs4HSsO4IzxF
         rF3GmB9dcd4UTPz5nQbbk5pPOUeEXf22U52LL75dwjZCnbcxFGaXa6bEsPS/tgrx1xey
         UyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697772100; x=1698376900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvi7YH2NIy5UBrE4ZQ4YiiWnJtMoiG/cFOIeIIJPu00=;
        b=rFlOEO70orKDlSHirWEAE9vKb/IIVIMOX12hKLC2ffE5VQm0Lyt+cexEW0zbwcbD32
         0cjML5hyHrVnyX4TxuoqCFiHHyeft7uLEDiaFx6p+4Nhnrb7wi2XQlEjeAJxp8igmLD+
         LKgxareWTW5H15HxeeZCMA70pN4h4dTyeXy9tySs0qgeV0OXDL3ikjkxxn01K0f/rlbe
         7f8mVMy6EgeCl0i1+NGVsit8rrOjjm/Vid8V/KXgTCpj+SU6SE5DaU+iaOYQOnPiAp3H
         WH0HCBzfiy4WPgxMuriO8sfpeMehqzP1goNIPwEIdX7q1uIyGXChBHHlu3kCgk3YygcX
         zWBw==
X-Gm-Message-State: AOJu0Yy8ZKYy7Esp+3UUITBU2r6GqaoTRRwi+iTvL6skf6ZkEcyzD9mH
        siFDpyO90hn1Pb2SfvkWQCgSeteoQ5r5DPZ5/nI=
X-Google-Smtp-Source: AGHT+IFxtbM4N3xpLxO8aSljL+cc8jSINKc4eo543h/Ls8Hwbn52zsKXOHN9qlGhKeHHEyHAhUgAOQ==
X-Received: by 2002:aa7:9e09:0:b0:6b2:6835:2a7f with SMTP id y9-20020aa79e09000000b006b268352a7fmr528118pfq.22.1697772099913;
        Thu, 19 Oct 2023 20:21:39 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id w65-20020a626244000000b006b73af176c7sm515575pfb.157.2023.10.19.20.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 20:21:39 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:51:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Message-ID: <20231020032137.xykrp42cpmcvdys3@vireshk-i7>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
 <20231019102342.5f4oyxd6hmjcju6g@vireshk-i7>
 <ZTEzuz7VrDGIoR7H@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTEzuz7VrDGIoR7H@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-10-23, 15:48, Stephan Gerhold wrote:
> Sure, I will try to test it until end of next week, with both single and
> multiple power domains assigned to the CPU. Is there something
> particular you would like me to look for? Or just that the scaling still
> works correctly as before?

Yeah, simple test to ensure scaling works fine is all I need.
Shouldn't take a lot of time. Thanks.

-- 
viresh
