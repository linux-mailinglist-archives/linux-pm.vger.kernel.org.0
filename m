Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2840E7CA49B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJPJ5p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJPJ5m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 05:57:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C39C
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 02:57:37 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9c1989509bso82550276.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697450257; x=1698055057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hKjoOi4o5+S+AeezdYGJJ4hDML7IkdvZOe/iiNGtC3Y=;
        b=mLibRbkTrLjmE+P8buCzg2ct6caoFP6fGCJ7PzUYpYa0LYd8Ae1qiic+u2CZUtywEX
         LwkzEbSboSUEE8Jum7bu4w/EbFt9Rl6niikvpTKJSBF2+f7PFSBbGpyatlg2PXk7OTpC
         0ksQMHPMN7lDPm9xUkuPXu5QVlu2EpPLp/PmKxbuxulVj19PQfnlUfZ38SkF/yIKbZp8
         41DCnhmH9AerUidJJbJbygHiUezIxeBWcnzgC//d2ZRrSCvKuWNcG/mVjxx5AUayCpBi
         PiWXkbxK2e8ifwFma4o/uN5XYSAhywuB0FAKUFdSJM5p/bX2MP3Ff5Ve7BoxoiYu3q89
         D3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450257; x=1698055057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKjoOi4o5+S+AeezdYGJJ4hDML7IkdvZOe/iiNGtC3Y=;
        b=Q156NYnABgyOeYOWk27I4SIc5vMmFjIP3/x8Tn5DBQgVsLLBDxvBpWrxJLpL1gJIqa
         f+qh9yZbWFC9W07/MGtckqkYVskb4313D7fI/QUR/77tHSf+zic09r/PDFpxzrSuZRBg
         vEbSvpIeUl+VYkd9tubdr8btQSqWHR3cNPje5HSN4/Ok32aS8soLptIPh9Y0Rkj582qo
         0oJej1k8TvIIk7L3fFP6kD9eKq6kb5RNk6WHgTVqC9OfEFKRTHyFbtnWSalJYvof6i/B
         HZR/kzitHwEk690qSKP/y36zE9jh4Qu7zB/f+D8mJAjRMhEKHoxaSUeG/c4OhXXjxxJx
         2ZHA==
X-Gm-Message-State: AOJu0Yw0inpYdmMV9S34mOgx5fcHZcFxe4atl5rRLqt3gokxAUdxxo2p
        jVHBZS1TvbdAqSDlBtgr7pKYyVgi8E7BF7+9TkzahQ==
X-Google-Smtp-Source: AGHT+IHHcNd6ZxteZ55i9Bv8DA2ZdBh4OSwPe1StlRTNHtmkrLL8lLGTzHPYOJmGBiagODNvTnJX7VCsR87NKE02b38=
X-Received: by 2002:a25:7481:0:b0:d9b:146e:5d85 with SMTP id
 p123-20020a257481000000b00d9b146e5d85mr3912253ybc.5.1697450257161; Mon, 16
 Oct 2023 02:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231012152108.101270-1-ulf.hansson@linaro.org> <169719833142.3828427.5236534342833939623.b4-ty@nvidia.com>
In-Reply-To: <169719833142.3828427.5236534342833939623.b4-ty@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 11:57:00 +0200
Message-ID: <CAPDyKFpa4Wb2fXRS52cYa4=hs-K63y_Re52tS2VJsO9A31eZeA@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/5] PM: domains: Drop pm_genpd_opp_to_performance_state()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 13 Oct 2023 at 13:59, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
>
> On Thu, 12 Oct 2023 17:21:08 +0200, Ulf Hansson wrote:
> > Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <-> level
> > dance"), there is no longer any users of the
> > pm_genpd_opp_to_performance_state() API, while a few genpd providers are still
> > assigning the redundant ->opp_to_performance_state() callback.
> >
> > Let's clean this up so we can drop pm_genpd_opp_to_performance_state() and the
> > callback too.
> >
> > [...]
>
> Applied, thanks!
>
> [1/5] soc/tegra: pmc: Drop the ->opp_to_performance_state() callback
>       commit: cda263907a6f88c75fb97cf7adecffaafb6237ec

Thierry, I was planning to queue up the complete series through my
pmdomain tree, my apologies if that wasn't clear. I want to get rid of
the actual genpd API and the genpd callback altogether (patch5).

Would it be possible for you to drop the above patch from your tree
and provide an ack instead?

Kind regards
Uffe
