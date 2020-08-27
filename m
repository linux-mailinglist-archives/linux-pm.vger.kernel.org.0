Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0055D2544BF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgH0MFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 08:05:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43612 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgH0MCU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 08:02:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id j21so4348967oii.10;
        Thu, 27 Aug 2020 05:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w87Wjrt0hH5OBUFHY4Ofs51H+e/iPgf40ZaoFuUim6c=;
        b=qan5h1BODPXOIyL15mJe0fpHyNcBVRiaQftXM9Vd3xTvAeGwo+bu1IUJUqyFut2QZ9
         YC0y6HpCILRka2bEKbK7Zm41fafDizTzo1C6fXHzYJdHBQEmOlTY4pJRLedStJ+6evHb
         4UDCrvtWADVX6VFqH3GxTYyP2yj7E3h/l4MtghwsQLaMQsRQpaNLNax82//FsYSmkvPw
         4ETGTC3MdRuG8Czt1xDlYcLviGx3SD34+5LMdEVTL/bLoOuEcwwEeYaqOqs6T2wIl3Tg
         1yaa0lnST+R8sUADjZ4ONIBnkgQZ1uWuBzKUwYI+DxTP5za/TQJNxORwfy5UoxDcHePj
         my7A==
X-Gm-Message-State: AOAM5336dmSkADWLHoHoBAXuegZ83v7GSOzsTJSWo1Le4C5TENDc+m1K
        Ak5GmQxWtO8DLo47EHWCuqmvGVLkGqp/0wqUqPbT4+f1
X-Google-Smtp-Source: ABdhPJzV+sSj3VgjAs1ALzDiBgJpH5s/BbK9M6Z51fs6trVCmIFa01P8Nl7JAaX5UBSFeJsJfheOg1+NTiCNPTDLBJY=
X-Received: by 2002:aca:110a:: with SMTP id 10mr6149426oir.68.1598525705214;
 Thu, 27 Aug 2020 03:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <906198d77aa73613a1b588425aa45e5025ee60cb.1598505843.git.viresh.kumar@linaro.org>
In-Reply-To: <906198d77aa73613a1b588425aa45e5025ee60cb.1598505843.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Aug 2020 12:54:53 +0200
Message-ID: <CAJZ5v0iTmowt48RHZGrx6aFm4OsJ0FXHk1WWstAJ=hvc7oJ_dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: No need to verify cpufreq_driver in show_scaling_cur_freq()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 27, 2020 at 7:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> "cpufreq_driver" is guaranteed to be valid here, no need to check it
> here.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 02ab56b2a0d8..47aa90f9a7c2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -703,8 +703,7 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>         freq = arch_freq_get_on_cpu(policy->cpu);
>         if (freq)
>                 ret = sprintf(buf, "%u\n", freq);
> -       else if (cpufreq_driver && cpufreq_driver->setpolicy &&
> -                       cpufreq_driver->get)
> +       else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>                 ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>         else
>                 ret = sprintf(buf, "%u\n", policy->cur);
> --

This and the [2/2] applied, the latter with some minor edits in the
subject/changelog.

Thanks!
