Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394CAB12D0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfILQdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Sep 2019 12:33:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37738 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfILQdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2019 12:33:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id i1so24567364edv.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2019 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msUdi5YBel2OVDrDo1+uyLwwUusTvM/xvzLZubYz7OA=;
        b=GBJCBWPgl2dc8+HNuQf1RTfy6jPLqbTh7mDxwpHH1oyPHvV3zzKhsqGVQ3FrC+IVIg
         3i5IOdDOe/aB8PktDA3fGkFDAavYUp5fM99tchMLrXKSpBs9HTJgC37+nGripDuJoXqi
         IJnQ2CIiUJPqgf4kIqQq2OlnURdj0mHSz5wYNccZ0O2kOy2oBC5kEheb90BvkailMY0j
         AuV63Y41t4Mwh4bnFZLN9Iot9xz0UGLhyb9sDwWsuCOjZdjEmABHXwLfm2Lsl5gicOYP
         ToveXkW0adFoiSyrL3Tmv4jJvj1lKiiTS0txnouBBy3qchwB+2zEnvsAucyePTpRagZS
         MgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msUdi5YBel2OVDrDo1+uyLwwUusTvM/xvzLZubYz7OA=;
        b=sfv0rIcOLSkvsTdF+g4eKSBqOBE/vAYla+0tjz9U+YHi4J1V1N3NqKLAPlvJsNPTtb
         rZhu/6yMiQxFEIvO7D3lmVkVG8qqZRXx7TNvU+8r8KR05phEBPsKoqeiSvEV5yrQMG3u
         8ZN0Pxy3CpLRSNNRVbmcsgeSbnobbd+FDiWPZ/LErIkmtIze4G9dRmETeSpQwX/vSCg8
         9NuThvjWu8ueSF9sC04y16yyiQFj7PNfmeVfZEOFklCOwp8WS3vryV+JGJxsJMCSV2jb
         Py0cCnTeJEDhcI66wCqKh7hku8uxTz52saMRekQ5Koog3ONPpKbnfBjUg9pokKtx79v0
         4e9A==
X-Gm-Message-State: APjAAAWx4X+fGiPF+6UBnugfCCLaRlyMBHGZK4cU5WbmMx96kZ74S33q
        I/2rC2qDsPjuAdLZRjNMgyMsWjAnb8sSLoM3cvO9Bg==
X-Google-Smtp-Source: APXvYqx9ZSP+/BXU64qwVN0heopbP6R5011EOG98+cGZ7+O7vLQ5X/xwHHg3SvqQLy021lp3JGhdK5gSYLWEuS+5Z1U=
X-Received: by 2002:a17:907:20f1:: with SMTP id rh17mr4026893ejb.71.1568306018629;
 Thu, 12 Sep 2019 09:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
In-Reply-To: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Thu, 12 Sep 2019 09:33:27 -0700
Message-ID: <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as a module
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 29, 2019 at 1:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Building individual drivers as modules is fine but allowing a core
> framework to be built as a module makes it really complex and should be
> avoided.
>
> Whatever uses the interconnect core APIs must also be built as a module
> if interconnect core is built as module, else we will see compilation
> failures.
>
> If another core framework (like cpufreq, clk, etc), that can't be built
> as module, needs to use interconnect APIs then we will start seeing
> compilation failures with allmodconfig configurations as the symbols
> (like of_icc_get()) used in other frameworks will not be available in
> the built-in image.
>
> Disallow the interconnect core to be built as a module to avoid all
> these issues.
>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/interconnect/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index bfa4ca3ab7a9..b6ea8f0a6122 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig INTERCONNECT
> -       tristate "On-Chip Interconnect management support"
> +       bool "On-Chip Interconnect management support"
>         help
>           Support for management of the on-chip interconnects.
>
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
