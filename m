Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C046120FBE8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgF3Sju (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:39:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46762 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgF3Sjt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 14:39:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id l63so17277694oih.13;
        Tue, 30 Jun 2020 11:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UvTp9bo5BGLWrozn0b9r4ZbImtVYoW1saxIXIYZe7E=;
        b=m5vf2yeYEmQQvR029pydYxr60KwwteAiiBTu7z8QteMDi7jEROwhZFDWLRAdA1Pb5d
         GLJ4BlaAZuqY/7GI4smlssegPEZ59wwM6xdwFZLQ/jhTDI4DoS9QR7mSRTQVcZya6h2g
         gH2JUlC1CHVS1I8b82spWVfENDwp4w9oiuy+FadNjOCmZ0pOkT1yT9BGrdluUD9/OISu
         PdrUcSzVPrEjThR62MleVZBXdObzG/DwTHMjAObjuI7qY4vGXol0pA9oiCh9UAplUkzT
         oM+UPJJAeyoNmE7/kXq7IhEO4QYJpkfOSvIUctpGZl1Dw0mepmHD6CWsfJb2JIPUQF0t
         nudg==
X-Gm-Message-State: AOAM530kuoV3W7g9cca0HXTQ/dQNcBfiRv0GvEPsoQchm09KXaT/n/By
        Gyu/+B3ouPkrorTxzVCs6U5D88Vbg8M4jtPUPzGr7A==
X-Google-Smtp-Source: ABdhPJyYS3812JK8xEOO9o4rXVkyyuGMBIaKjlQNHAgmdOlmnyzM0VrI30qA+axFY9QWiIfNrG9PDJGcbSOku9k9bC4=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr18016228oia.103.1593542389170;
 Tue, 30 Jun 2020 11:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <2f00a5847708547a57920e24a2ec5e76b265cde9.1593425047.git.viresh.kumar@linaro.org>
In-Reply-To: <2f00a5847708547a57920e24a2ec5e76b265cde9.1593425047.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 20:39:38 +0200
Message-ID: <CAJZ5v0hffQ1JBWM_iP25Bta0+tu9cxvi4UmX2RsyqqVNjoPXGA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Remove the weakly defined cpufreq_default_governor()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 29, 2020 at 10:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The default cpufreq governor is chosen with the help of a "choice"
> option in the Kconfig which will always end up selecting one of the
> governors and so the weakly defined definition of
> cpufreq_default_governor() will never get called.
>
> Moreover, this makes us skip the checking of the return value of that
> routine as it will always be non NULL.
>
> If the Kconfig option changes in future, then we will start getting a
> link error instead (and it won't go unnoticed as in the case of the weak
> definition).
>
> Suggested-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Based over the following series:
> - [PATCH V4 0/3] cpufreq: Allow default governor on cmdline and fix
>   locking issues
>
>  drivers/cpufreq/cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index ad94b1d47ddb..036f4cc42ede 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1056,11 +1056,6 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
>         return 0;
>  }
>
> -__weak struct cpufreq_governor *cpufreq_default_governor(void)
> -{
> -       return NULL;
> -}
> -
>  static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
>         struct cpufreq_governor *gov = NULL;
> @@ -1079,8 +1074,6 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>
>                 if (!gov) {
>                         gov = cpufreq_default_governor();
> -                       if (!gov)
> -                               return -ENODATA;
>                         __module_get(gov->owner);
>                 }
>
> --

Applied as 5.9 material, thanks!
