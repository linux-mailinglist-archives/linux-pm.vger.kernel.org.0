Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA5481D50
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 15:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhL3O5g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 09:57:36 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:38628 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbhL3O5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 09:57:36 -0500
Received: by mail-qt1-f180.google.com with SMTP id 8so21904194qtx.5
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 06:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kyEWX6EvoHUObYeMVkKHj4uMl0mU+cGvMTGFA37bmM=;
        b=7HdPuPONxyLwkx1yPtINUlxtolQLQ+/1vIVDZJNaNNLbz7c8o3XXEcutmrz2It47pP
         etSGhJ+r19l1Om///NOrZh4gKA0gVZ2cmRVuYWmKSi7ZKrj+ah5pO8gK6cA6vZtfuxwC
         yZTyzDUuEh2x3R11tqyYj2uG/lfew0rCoHYTDX6z1V45nLbipThYMPVXwbVBFSerBcN+
         Kt+Icm4qBZ/WXYKxbwzMAMf49IXC15n+pKjLwHqPKUSbyrcY29Zp4iJGwqmfA4ltttwX
         fIwCMulLUg18aSKQUvf5X4XcuvjYUHeyfwEeeWQL48pQx13N9vaI8Jlr61W9FEAzvz1c
         62Jw==
X-Gm-Message-State: AOAM5331tmByl1g3Zujk9YUn5kgT9MUA7+1qIXXMO2JZ++Bo5Tgy7g9n
        iR1jiU3BSiDW2xaVpfjtLYdw6S1y+e/gREjTdfE=
X-Google-Smtp-Source: ABdhPJydpOmMGI7Bm0wE8xXeC5dIDlxKM0Jw1uC/zfq9eT9AiCfAz2ws+tfnFiyPycmKwzDLQuLSZ5KynPWfaCJGcyw=
X-Received: by 2002:a05:622a:1113:: with SMTP id e19mr23491378qty.612.1640876255606;
 Thu, 30 Dec 2021 06:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20211229034341.juivahmqhoqzjtgo@vireshk-i7>
In-Reply-To: <20211229034341.juivahmqhoqzjtgo@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 15:57:24 +0100
Message-ID: <CAJZ5v0jvtxopMpYuR64xDYezma3+rNqEPV8uNbbSRcfOEySmcw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.17-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 29, 2021 at 4:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request updates the documentation to match with the latest code.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
>
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 489a00ef46c93e85ed540d91836317cc469371ac:
>
>   Documentation: power: Update outdated contents in opp.rst (2021-12-27 09:47:52 +0530)
>
> ----------------------------------------------------------------
> Tang Yizhou (1):
>       Documentation: power: Update outdated contents in opp.rst
>
>  Documentation/power/opp.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> --

Pulled, thanks!
