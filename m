Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F0129D773
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgJ1WYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:24:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35172 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbgJ1WY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:24:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id w191so1255567oif.2;
        Wed, 28 Oct 2020 15:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Sv2FVoxnqW/ZZL6On0xD6CMoZAcuyjIfOT9376yoH8=;
        b=rqRSRRX7acYNnPFjl/UGml/5HXbamyNX+MDtOANAP4DRktQJN9smXodJnSiMShEQTN
         mIISW5INDBHASkskNZUHtis0MqDNaDvXT+kl7308qejMTx2fxYWYfsTkFiEpEOhpCkAh
         3aZ2WH1SogpZbydNbZ8nZ8p56hdmdCZVn9DZUDlnV+fmepjyp/BuTuPwFecGp8vYYOG+
         kQ9xHwNwWuo7ZI2DziPafz2qGl565R5Ai92C3lELPIlcm8S8FKwVdofEBMgJagWum/Cd
         EE8sfLpbsCj20NiI7pvvLAlvzU4VXgHa3jsLEhSHmN+7+qag+rbja+CeSrYE5UzY2bhZ
         OWmA==
X-Gm-Message-State: AOAM532t8TouyN3PfIy7wDEsT4G9UGHS0oUKBkznkO0ZYAuy/V03wfBV
        vSsJuxUFl0k3r8moOWjsZ9aRn6tPbnBwDscLkUqi0vR5
X-Google-Smtp-Source: ABdhPJyblUt9XGbqG//4Rk9sfsTFBrwwgwHA1TBlEHDbR6syB2Nw14Bq1Q16HKbBNe5BKXGGevPeQscCGwnL0JZWNpU=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr266429oiw.69.1603904785647;
 Wed, 28 Oct 2020 10:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201027185934.1586984-1-trix@redhat.com>
In-Reply-To: <20201027185934.1586984-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Oct 2020 18:06:14 +0100
Message-ID: <CAJZ5v0iGDnDbUnb5AYYMrV2st7Vc=kDSHp-YB1xKS-ccea8=XQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: speedstep: remove unneeded semicolon
To:     trix@redhat.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 8:00 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/cpufreq/speedstep-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
> index a13a2d1e444e..0b66df4ed513 100644
> --- a/drivers/cpufreq/speedstep-lib.c
> +++ b/drivers/cpufreq/speedstep-lib.c
> @@ -240,7 +240,7 @@ unsigned int speedstep_get_frequency(enum speedstep_processor processor)
>                 return pentium3_get_frequency(processor);
>         default:
>                 return 0;
> -       };
> +       }
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(speedstep_get_frequency);
> --

Applied as 5.10-rc material, thanks!
