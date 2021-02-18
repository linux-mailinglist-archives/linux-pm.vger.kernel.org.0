Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252B31EF61
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 20:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBRTLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 14:11:50 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46459 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhBRRl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 12:41:58 -0500
Received: by mail-ot1-f50.google.com with SMTP id o10so2581405ote.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 09:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8n6PzhTwwqc/x7VxdjKA2P81D19TXeAs+2o1Js6BYU=;
        b=fPfYdsnlDbhnlERIdSWVReIk6KzCUnoAeW05O9Z7BPTfaTu3xLJhQGzdKSZqf3Ktop
         1oLIGs0bS5B63kHB9KD47MhaNjL2HGpOBbn47CxH3aRe9egkW+lMOhvc5ItcxvMi4Ynm
         rcEjEyufMhCeyxqMIy8qWVRBDzdU7b3CFfYlvvgb54rOV2Id5zx7qG5BS+zHHOBhWjQR
         VzgUh1DKCr6V9y3UIIPBjGnC1anq0Rze4SHO/RC9v+pPYvAUyEd1ayNN6N9EriX6QGXN
         yoeg+LDl1i+WlrCAQBo6a19Qzbekp4QeKrVGaEqZGd1+2Os1vRgMdSk3n4mKZxW3plTw
         sNBA==
X-Gm-Message-State: AOAM532nc4dSYfRR+c+Ov51dCcXF1LrCQOqkUZ7RJNtJOten0fAkTR5D
        6sm2vSC2xeWbnjNpPy/24+qeHNbuomW/RkMj3Fs=
X-Google-Smtp-Source: ABdhPJy3UHbQ9O0xfY7XZwwSIXoO5e1ANiDv+TVjSHQ1zluaR2ZRZbqidkwc/VqynojjKPtytwPUEtd21tWgBPczkEo=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr3840497otg.321.1613670076619;
 Thu, 18 Feb 2021 09:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20210218072055.tfnwyv3hzcrgtopx@vireshk-i7>
In-Reply-To: <20210218072055.tfnwyv3hzcrgtopx@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Feb 2021 18:41:05 +0100
Message-ID: <CAJZ5v0g68-=00p2sREVa+wg3hECHyQXbH-9psmdvUq+aipkJAQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.12
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 18, 2021 at 8:21 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single patch to fix an issue where a frequency
> update may get skipped.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit 86ad9a24f21ea7aac7deed06fe9556392568d88a:
>
>   PM / devfreq: Add required OPPs support to passive governor (2021-02-04 16:48:16 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to de04241ab87afcaac26f15fcc32a7bd27294dd47:
>
>   opp: Don't skip freq update for different frequency (2021-02-18 12:31:08 +0530)

Pulled, thanks!

Please note that this will be pushed after the previous PM pull
request has been merged, though.
