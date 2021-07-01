Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77A93B91AB
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhGAMeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 08:34:14 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37553 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhGAMeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 08:34:14 -0400
Received: by mail-ot1-f47.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so6339645ota.4
        for <linux-pm@vger.kernel.org>; Thu, 01 Jul 2021 05:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JpP5ehYRCF8lZ1JVWanAzAmguyu+yF3X/jd6+S185c=;
        b=W0uMQFF84wfMxxIiJt41wfepsV+kChYlzT7uQlFjMce4JBrlXTEQbiWlq71kJMQhMV
         7Cq48Mf6CDqqpqQcktSYZFrA97YpuXLNveT+On7hRaMSVr8W9tME9RsIiCYObVTw/pbh
         9Oxb/o4tks0xCrOGTH2uL0oce1nzMimTjzpFVG1GhVEfZlUFPzLXureGP57fBF691cKR
         NaCZ8xR+Ydn1IdSLzLGO+T8dUWeJcQqWKP8dVUBvuVgFQoyZQnXW9FskOkoPsvmzh4qT
         jE6KFCC+wVp9nqQ5ku8fNJgqBQP/60Kk5WMX2IiPq1/JXjn6cNy2MCyIn41OwP+B38cP
         cxWw==
X-Gm-Message-State: AOAM533yf3Z/avULP/14SPnwHsXE74c+dKRs3VD6qJ+Yww7vzGNCWSVm
        R3MjFurnji0NabIqeqrsEGONq9MmK4HqqLD6Np0=
X-Google-Smtp-Source: ABdhPJzoJYXoJsjmWCb8DEQXMoju+xGTqQ8usZw02Cj6qPBaddMpPiHJp3Q64nGWU3EgpjYsFNrmAtpOWIYawN/VTn8=
X-Received: by 2002:a9d:1905:: with SMTP id j5mr13624706ota.321.1625142702377;
 Thu, 01 Jul 2021 05:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210701033613.ydoxbc5tydzqbln3@vireshk-i7>
In-Reply-To: <20210701033613.ydoxbc5tydzqbln3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Jul 2021 14:31:30 +0200
Message-ID: <CAJZ5v0h42oGQyjXZbKXxzK2N2gaQpm0b_UoFu=BFUB7oYLuH_w@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.14
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 1, 2021 at 5:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Add frequency invariance support for CPPC driver again and related
>   fixes/changes. (This is based on commit 9357a380f90a ("cpufreq:
>   CPPC: Migrate to ->exit() callback instead of ->stop_cpu()") from
>   the PM tree).
>
> - Minor changes/cleanups for Meditak driver (Fabien Parent and Seiya
>   Wang), Qcom platform (Sibi Sankar), and SCMI driver (Christophe
>   JAILLET).
>
> - New bindings for generic performance domains (Sudeep Holla).
>
> - Rename black/white-lists (Viresh Kumar).
>
> Thanks.

Pulled, thanks!
