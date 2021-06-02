Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBACC398329
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFBHkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhFBHkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 03:40:21 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B008C061574
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 00:38:39 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id m23so759680uao.12
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+TTh5KqzQy7Y+EAoFlysDwIssfmwwnP8VJI5NXEb/8=;
        b=ui0SAsqvnSKtekZ5xaMzh11I/7tb6Y8cTj9gTGMe0c2ln73DXlIhrzNtUOa+1vynrg
         /cmEUeDyzFYRMqdDbOO2EQjxLgQq3Gb9eW376DtmojBSYF9o3PleaIq4+f6J5P8CXTQ5
         EjEpZfGq6VXaMFeHwTcLGBTwWyrUpenqTZzmX+TYRPp23PnzakSnJZ+Ay7YUp/oPF5Pv
         o/7jLjZb6EF4Miy//21ONjkRZgV8xLVr8RQOlWoh4/1d9g0/Fhy2ESTiEHyn3Q59VGVy
         h1eNVx8WS4qLUopqJDSO6fVMGnD38ZAgoyRedhLkHJmKSfPmdTrXplCUxjHLI6RVKv+C
         xf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+TTh5KqzQy7Y+EAoFlysDwIssfmwwnP8VJI5NXEb/8=;
        b=hFKJ2PZeGdwbEW2FT0mqTTqcQ0GS+7Jx5k8FK5ZNL+iK9jsVWi/ZI9Hkpd5msB4/zh
         7OYq3fbuGPmeoagxzE9ljYxD+HPTQT2R5Sdql1/2NHTgNtUNIyU743X2zuovGzPbgGTL
         TwyNP86KVSnANm8UYpCoSGbt2NXClefEvpk37bgnApMiKOmHDa0HTPS4r8A2HOZ37QDm
         7aE07mJzN4yaeL51puCL9jn9xk3h3IZKNeqcXKq+zcE1vfpU2A2zhH3OxfRcUDgQ3Tzz
         sC5rRdIVLe0FAcuCZJunvULtxeQDjfRSp5i8jiPS7/6aNL2pOk9q5UZBi/x/EJ5rJDGk
         TEQQ==
X-Gm-Message-State: AOAM531p8ryee01Km5324RC0Ol6UCCGT0GTWnLmWvaQFrAYtfzMU3ewx
        nm58zQz4Bwhrrd11qW2kTOpqEzxE9IG403WRe9aEuLsh2EtFu8wa
X-Google-Smtp-Source: ABdhPJzyd7BJ2tG/pzaTds/WFODrDilZ8jvrif516usWWpuQ3h/Tm2Vr5Wt8EbH3eFPPfqiJWc+o7XOTCEPsPWLEuEk=
X-Received: by 2002:ab0:100f:: with SMTP id f15mr20386864uab.100.1622619518153;
 Wed, 02 Jun 2021 00:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210601231003.9845-1-digetx@gmail.com>
In-Reply-To: <20210601231003.9845-1-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Jun 2021 09:38:01 +0200
Message-ID: <CAPDyKFpMCkp5tHHcZJZf6sC4+C_xGGnhUWJg5+6hHbDT8FD_Bg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] NVIDIA Tegra core power domain follow up
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2 Jun 2021 at 01:10, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Remove the lockdep_set_class(), which Ulf Hansson asked for. And
> prevent core domain syncing if domain node is missing in device-tree,
> which I accidentally missed to add after squashing the standalone
> domain driver into the PMC driver.
>
> Dmitry Osipenko (2):
>   soc/tegra: pmc: Don't sync core domain if it's missing in device-tree
>   soc/tegra: pmc: Remove usage of lockdep_set_class()
>
>  drivers/soc/tegra/pmc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
