Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCB244063
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMVQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:16:48 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46942 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:16:48 -0400
Received: by mail-ej1-f66.google.com with SMTP id p24so7684140ejf.13;
        Thu, 13 Aug 2020 14:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqgP8/kqqaBWz0T8s13lcZ2MzqpMIhm25KCZWBaRfQQ=;
        b=O4BrTjnCxNHmbaIlJbV3CNZU6Ku0En9//7EOiQBlZhjrZtRjYe5Etv2ynovBTsI5Wx
         smObhat0BS5Ydo3RSbDBoYDA6SJRp5rKL9+E7yRVUpmRWQXLPqBRNwDo3I33hpTeIW3J
         Jp9Tzzk/ftCKj3lNozxk8U8ySTV5Dr0KQiQ6TAehFdDGdulM14OH76dmddea4o0Jkxo1
         L7ybM8CTy2IwPRA3rxPx2IV9B7RhybTGVIv3U37z0srzsXN7Y5v1Dx6t3mslzH1bi2rF
         lr1M7A0Q0k6WRXrlIjZEdJokuNMPX7M4Q3HhMj+99Na5nT0OR47TqLzuFHUUXNWDFcbU
         NZrw==
X-Gm-Message-State: AOAM530pJrS6Doi3uGP0V1bot1zw9r99BSeZB9UuNx2Qt3vCAQfLyORL
        /M1KeXwOKZVeULij1MeZ6kCosFrjWcHslWriG90=
X-Google-Smtp-Source: ABdhPJyjpf8YQQq9CUV59pcQHNLsIPVil2cwEyvmjMXjDvOvyLLSsyOWGLrV0/6ONfvQrzwLqKyf9ZrgfMmtA9Ofub4=
X-Received: by 2002:a17:907:2082:: with SMTP id pv2mr1374764ejb.188.1597353406609;
 Thu, 13 Aug 2020 14:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200326203637.1892-1-dsmythies@telus.net>
In-Reply-To: <20200326203637.1892-1-dsmythies@telus.net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 17:16:35 -0400
Message-ID: <CAJvTdKnyeTvJ_iP=XTet0ggs7FqswWQsfYQr5crnPPwOTfBMRg@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Always print idle in the
 system configuration header
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Applied.

thanks!
-Len

On Thu, Mar 26, 2020 at 4:36 PM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> If the --quiet option is not used, turbostat prints a useful system
> configuration header during startup. Inclusion of idle system configuration
> information is a function of inclusion in the columns choosen to be displayed.
>
> Always list the idle system configuration.
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  tools/power/x86/turbostat/turbostat.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 33b370865d16..834b86676d00 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -3530,9 +3530,6 @@ dump_sysfs_cstate_config(void)
>         int state;
>         char *sp;
>
> -       if (!DO_BIC(BIC_sysfs))
> -               return;
> -
>         if (access("/sys/devices/system/cpu/cpuidle", R_OK)) {
>                 fprintf(outf, "cpuidle not loaded\n");
>                 return;
> --
> 2.25.1
>


-- 
Len Brown, Intel Open Source Technology Center
