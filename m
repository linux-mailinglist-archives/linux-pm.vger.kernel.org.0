Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1666A27DD20
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 01:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgI2Xx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 19:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgI2Xx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 19:53:27 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32212C0613D1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 16:53:27 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id w25so28925vsk.9
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOMvpJf6jnH+JyF4Og6jExEF8H9zHVHC1Jf6qwYVtbM=;
        b=iI8aT1Wp1Gb1k5+bUZubbPKESeO6IaGvH04eyr/FlKisSVUJrSN7sxDr7ZHh6ykQ/k
         p7cNKRYxDABzhCKvmHmHPKiowzooCDlBaAZvhSAf2IiRXIGwzXrOzYmprGqkR3t5zyME
         2T3KDDuBxMrpVIi6xezEVmNob5wdPQLidqukU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOMvpJf6jnH+JyF4Og6jExEF8H9zHVHC1Jf6qwYVtbM=;
        b=OZgJAbdfP65JW6PXAwl6thnIKgbx0QBElz2/zO/oHeAF+8sMk7iMCl5OGuyXkVPaP2
         qagcsnIhsB7m87AUz9jLLbR9dRdCLKpc2T0uVAWtDBaPfiZLSKzWwns+NP7ePugE69SY
         Me1JhTtPmzw1SGAW0ska7cA+krUj/BZ23F1tX3Jxq3bYYo4VqGfLsDZvwgzZcmeivAyt
         Izkq3JHwWYlwIOp1Jf/D+HxHpV3gb9WgVxSDSBrkZlE0BTx2MZu3o8816b58/KYRZY08
         GMjnGtIGKjpnEB7o5HvkjQZ0IKIH9VXj/usL5wPJfJTRD8t+K3ohpl4PDH8yqHGbCUPy
         ICbg==
X-Gm-Message-State: AOAM531y/3/4AHeo4PihtokCt3psRFCrjh5qqLSuG/nwA86H4wu6mglV
        AOEMiS88cDSA4TxsYJ5TUFf/CLw4EyUgqQ==
X-Google-Smtp-Source: ABdhPJyokEidCpeBhyLQqJ594CeJtEWnk0K36RCYIgVJNJOhlYGnwKaG8fCmfNpgfQcZ0fSIv7rjJw==
X-Received: by 2002:a67:f9d6:: with SMTP id c22mr4630773vsq.49.1601423606086;
        Tue, 29 Sep 2020 16:53:26 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id f206sm1696555vkf.37.2020.09.29.16.53.24
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 16:53:25 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id n2so4061146uaw.11
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 16:53:24 -0700 (PDT)
X-Received: by 2002:ab0:29d7:: with SMTP id i23mr2207uaq.121.1601423604458;
 Tue, 29 Sep 2020 16:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200929121610.16060-1-lukasz.luba@arm.com>
In-Reply-To: <20200929121610.16060-1-lukasz.luba@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Sep 2020 16:53:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
Message-ID: <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Model (EM) can store power values in milli-Watts or in abstract
> scale. This might cause issues in the subsystems which use the EM for
> estimating the device power, such as:
> - mixing of different scales in a subsystem which uses multiple
>   (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
> - assuming that energy [milli-Joules] can be derived from the EM power
>   values which might not be possible since the power scale doesn't have to
>   be in milli-Watts
>
> To avoid misconfiguration add the needed documentation to the EM and
> related subsystems: EAS and IPA.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
>  Documentation/power/energy-model.rst                | 13 +++++++++++++
>  Documentation/scheduler/sched-energy.rst            |  5 +++++
>  3 files changed, 26 insertions(+)

I haven't read through these files in massive detail, but the quick
skim makes me believe that your additions seem sane.  In general, I'm
happy with documenting reality, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I will note: you haven't actually updated the device tree bindings.
Thus, presumably, anyone who is specifying these numbers in the device
tree is still supposed to specify them in a way that mW can be
recovered, right?  Said another way: nothing about your patches makes
it OK to specify numbers in device trees using an "abstract scale",
right?

-Doug
