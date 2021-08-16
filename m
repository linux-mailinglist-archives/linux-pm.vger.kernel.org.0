Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517743ED940
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhHPOzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 16 Aug 2021 10:55:01 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46781 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhHPOzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 10:55:00 -0400
Received: by mail-ot1-f44.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso8455792ott.13
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 07:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bNfntNACi/0vP4ZoM7LCHXxpvJ1kGJPfle7pZMW/uLo=;
        b=kkH+JLDDAgdvLOhiJt2eQTsH2c4EgKV2LFCsTc9QjloLKn13C6mwQCIeFfZjXtqPTm
         r/RRXM/TzPz0lkEtIWe1nilx5xPy8sRBJCp/0YO3qNY5jSvq0H3sgXR8tKN9AVXAqW1q
         xx3eGme+mpwwK1b0/OQgUHt7zkfOFPGmuay2bPrQlANWbNBH/0N+Y5xSIAkwUS+wdPUb
         J8fuRG/IkJlhBSFFXsP4by3KgOmcBTJ8Uxamd6rGt/KUHeAJEryDgRwJBqNqc2VWalcU
         gN6T8J0EWYfaW62WCGv4aVoLc9yHOH/hsZN6DSahLxEEpsCHCm4LvsSG1+XsrlGNFVtN
         xKwg==
X-Gm-Message-State: AOAM532lBkTxiOVgKaslITz0D8BLu2LTsFvBM9Ke1L8QGwoSLz4tPufG
        JPp+LZHl9QAEAlhjyZdTzVibtAC/JBbcUmxwAIE=
X-Google-Smtp-Source: ABdhPJwVNPPWthgthKcZBwWiWBzHWjZglUkn+p3PDQBkToxi9kLV/29oUbOEtLBEBwlY9LVWYp9ZaAcTSM3JIm09ikE=
X-Received: by 2002:a9d:a75:: with SMTP id 108mr12803446otg.260.1629125668920;
 Mon, 16 Aug 2021 07:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210816042302.b5gblymaguy5qvbq@vireshk-i7>
In-Reply-To: <20210816042302.b5gblymaguy5qvbq@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 16:54:02 +0200
Message-ID: <CAJZ5v0hMJy4L4FMPr5ZQJw9pQb78vs0091Gc6Z1WDMNqSaViAg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.14
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 16, 2021 at 6:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request removes few WARN() statements from the OPP core.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
>
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes
>
> for you to fetch changes up to c3ddfe66d2bb511f7fbcdc8e64952c7859e7e69d:
>
>   opp: Drop empty-table checks from _put functions (2021-08-16 09:42:08 +0530)

Pulled, thanks!


> ----------------------------------------------------------------
> Dmitry Osipenko (1):
>       opp: Drop empty-table checks from _put functions
>
> Michał Mirosław (1):
>       opp: remove WARN when no valid OPPs remain
>
>  drivers/opp/core.c | 15 ---------------
>  drivers/opp/of.c   |  5 +++--
>  2 files changed, 3 insertions(+), 17 deletions(-)
