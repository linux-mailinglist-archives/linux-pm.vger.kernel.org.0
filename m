Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A2560E4E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 02:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiF3Auc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 20:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiF3Auc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 20:50:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A43FDAB
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 17:50:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 65so16586825pfw.11
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ec4XEkBPA35XnLcPG87goxGDH+EEGY22aWvX/z3PefI=;
        b=NFWCuFGRbcAjPzdLWOr/NQp3XWuDNO6BMyHySS+trahq6mX9UFO7j+zQOkjuhlioWl
         xSYxRMQtRJOqPe6f8aUpkpL4C7uRkzlXaGc1roT4R/8VsrW+toIgTh/7JqCViwZCe/Eo
         bM3/bnNdqFYGfV+tPNcVNd3eWRc0Rn5hwxOdK1VlUJRRIZ3O9GRQV5RBdLfmhk10TlJk
         2ATBJG6SR6FP3U4213Q+Xm15I5KrUa3o0Fr+ZWYv1hYrq+etlRvLYAfJW1P6ul5x863m
         GIRBOHuiCVrxZTYkdgcV7H2J/2nN8WZlUCw9A7RUKMGArEVcHcudATd8abMaGeTV4LBH
         kHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ec4XEkBPA35XnLcPG87goxGDH+EEGY22aWvX/z3PefI=;
        b=ylfCXYCpuvafhfLdJz9O5seV5ct0MLUjdYFkMDRE85vSR82KTVFqYECE+xN/zfIrZA
         vXM4xAODm9hPl43AbQdvPL91S0v18hN2QDPK1RlRHdvzMyBUVvFcN6G6CQ5cmqCGDxbs
         yMA1E1ex61t8x28D0Jxwz4QvGlQgOWZ3zO2OTjfLRVcFDgLXqcueigSHkEMd1pgsQPQz
         G63mVEyv9vIimway3HGWvK5JN+/xL+wffs57rn7wLDf2BhmVbj3ns2EnbFrcDzm1F1P8
         1cXfd4SYw0VGRq8oEr1tOPGDq/JhcnlM9jwoFlizQcORnW7eHtFkqJq5kFMRbq2TWfHW
         pqcg==
X-Gm-Message-State: AJIora/3IZcFT2kmE1eY/TPtMjBu8LXWtM5Jb3IqdOTotZxM3OvjgoiV
        MVG21xtuhUr0PkP2IieFI81hAw==
X-Google-Smtp-Source: AGRyM1vwxJL4Embx1Cw1olp7yFM3sPbrYAoDKdwqAqD4m7eulhQl7MEsYnny1f0udvYVdgE3PBRHgA==
X-Received: by 2002:a65:6bd4:0:b0:405:2d64:532c with SMTP id e20-20020a656bd4000000b004052d64532cmr5361306pgw.179.1656550230789;
        Wed, 29 Jun 2022 17:50:30 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79244000000b005252a06750esm4541969pfp.182.2022.06.29.17.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:50:30 -0700 (PDT)
Date:   Thu, 30 Jun 2022 06:20:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
 <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
 <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
 <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-06-22, 21:33, Dmitry Osipenko wrote:
> Today I noticed that tegra30-devfreq driver now fails to probe because
> dev_pm_opp_find_freq_ceil() fails with -ERANGE. This patch is guilty for
> that. Could you please take a look?

I remember this corner case now [1] and it was easy to miss this. So
you want the OPP core to still parse the DT to read opp-hz, but don't
want dev_pm_opp_set_opp() to update the clock rate for it.

What was the reason for this again ?

I have a couple of solutions in mind, but one may be other than second
and so want to know the real issue at hand first.

-- 
viresh

[1] https://lore.kernel.org/lkml/71451eb2-46b2-1ea0-efcc-0811568159a4@gmail.com/
