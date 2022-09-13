Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170F95B685F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Sep 2022 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiIMHIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Sep 2022 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMHIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2022 03:08:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976E2A27A
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 00:08:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id iw17so10932878plb.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mvmuLsSAKf6NFlks0U+6xfWp1Ez97s8X79X4CqxYQyc=;
        b=tSMTDdnP+rodHt16YIhNWSeH6jTmhIUNFsSUyqyW4VOSX1aEycQ8N625T/4WaA4j70
         37ssDFg80n5PlJ9Uu376GShkjgQfUwqJeaZv027jIz5aVMjWcnQ1Nm2BSjB+0OJfcwGn
         3qDw+4gUe/IpTaP2LGdWrH1gpJ6sJoPl2s/MNFZO4Y8t21uAvkVz1X/uqXMS2EhoOltt
         q7mKndYb88lXgfHAbnVsXz4bK4ub7ARV7lroG40T3wFjRdHw3DTE/aATy8kjwyLOBAZD
         s/RZwalHP3Ov6f6IHGFv8bF36+HwBUh3LpTn1Rs6998OxQLjHEL+kVpEOhBUmvu8gzbr
         gOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mvmuLsSAKf6NFlks0U+6xfWp1Ez97s8X79X4CqxYQyc=;
        b=pcEk3C69OdM3pwZFiwm/mUq2k7ssoogUeMb9dHXO5+KrUlV0+Hcr8rr2EXO5N07cDM
         ZYGaYaiGT64nJTSj4vEtucD3+TCcMnU6+JIN+Qq7YTCpcot2zOs/mRYRbnzbUkc1+aUk
         WA9MlmCu5gH1wRZtruZtqFKq/sYBR6zGwmlNIv6RR/5MrMgi6EyFM+/5sxc4T+SO70KQ
         8zzB86qRLC89v0ZhSbCHGs4QFKvMgPGjnRqVLJBQC27MsX1OpYJF/lzjHq/9OyXWyXwv
         X4n0K/TDF/DRXb94t3f6HxxnxNvUazDHvpNs3YOItGU/l1f5Fd+QOKCj1A/oiw9WdIA8
         B+aA==
X-Gm-Message-State: ACgBeo1TELTOPnPxB1ZjVKk9t9EfGtoTDTHV432QDZlIEnMi6G9WImYi
        ixC15h2CnnDxjTyLWZVyB7HDGw==
X-Google-Smtp-Source: AA6agR5PgbUtdW6ugx5JM1ibGxaJ2oK46ZcXQKSQSQHweAIzkqqN8tBb8c5sTchHxjpZ1HHffSq6Bw==
X-Received: by 2002:a17:90b:1e0f:b0:200:61cb:c718 with SMTP id pg15-20020a17090b1e0f00b0020061cbc718mr2467018pjb.36.1663052920108;
        Tue, 13 Sep 2022 00:08:40 -0700 (PDT)
Received: from leoy-huanghe.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001769ee307d8sm7404651plb.59.2022.09.13.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 00:08:39 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:08:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Huang Yiwei <quic_hyiwei@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, djakov@kernel.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: Add the missing MODULE_LICENSE
Message-ID: <YyAscuyA1pKmEDH1@leoy-huanghe.lan>
References: <20220913062721.5986-1-quic_hyiwei@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913062721.5986-1-quic_hyiwei@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yiwei,

On Tue, Sep 13, 2022 at 02:27:21PM +0800, Huang Yiwei wrote:
> Since icc-common.c can be compiled as module, add the missing
> MODULE_LICENSE to avoid compile errors.

Just curious how you can enable config INTERCONNECT_QCOM as "m"
(module)?

I checked the config INTERCONNECT_QCOM which is dependent on
INTERCONNECT, and INTERCONNECT has below dependency:

  - DRM_TEGRA [=n] && HAS_IOMEM [=y] && (ARCH_TEGRA [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && DRM [=m] && OF [=y]
  - TEGRA_MC [=n] && MEMORY [=y] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n] && COMMON_CLK [=y])

Seems to me, it's impossible to enable INTERCONNECT as "m" because the
dependency ARCH_TEGRA/OF/COMMON_CLK cannot be configured as "m".

Thanks,
Leo
