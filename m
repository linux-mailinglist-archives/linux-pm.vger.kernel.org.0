Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E367481DB9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 16:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhL3Ped (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 10:34:33 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:38865 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhL3Pec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 10:34:32 -0500
Received: by mail-qk1-f179.google.com with SMTP id i187so20826227qkf.5
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 07:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ngbsgpp7W5oyvkxqPT5TtkKSwvbB5MJ3hwgR1Tmea8c=;
        b=Fa/QD7kWrbyEJJJTUM/IAZCp++aN1qPGZQDULIGfsiaNEGTQ4OAP+b4TOqXpOYGXqF
         E6KW8RqwheTo9htEf0TfAg08f/36dZwMHFxQGoTezfvtdA7uI7dtu5p4H08t0kUm70iM
         1IfuPINj8raYcHMl5bgSpBnHixedVUZ1gwm0ihens28+God3zGGbNbrq3ELvJEkRjDnC
         Tq98sOMWSBINx4CzjsAgf86efPd774U+o1olYyuv54CEqdMvZYz+Hl06rgyBhpm9JQUw
         CHmHA/kNrmmC/1kwaki1Q23arcit1/e5+p6/VQDcFXzoJQtZ9X+rg5GEhtFgjIkla7mx
         +gTA==
X-Gm-Message-State: AOAM531E5QN9RgeVsyZcTuUB4TALntLvjVq+pyBCQPFPzZlBY66EU5/h
        ksqy8dradQN/XyhYpVnzIAXLGiAtVmhBngVKm0rbm2aL
X-Google-Smtp-Source: ABdhPJwjE8Q4BPf+T3ho7wQ0pyQLaz9ACdJLAZoULPTpue5C+qWOkTyRLLOzyke9MTbLK7fdew0uPo4IJclz3499Zr8=
X-Received: by 2002:a05:620a:40d1:: with SMTP id g17mr22400527qko.621.1640878472045;
 Thu, 30 Dec 2021 07:34:32 -0800 (PST)
MIME-Version: 1.0
References: <174f49e0-628d-f5e4-2f99-874524fb9f5e@gmail.com>
In-Reply-To: <174f49e0-628d-f5e4-2f99-874524fb9f5e@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 16:34:21 +0100
Message-ID: <CAJZ5v0h94OHd_kSFEPOtjqpJhzOsBinQ_mg==aUwN2itYNGu-g@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Annotate pm_runtime_resume_and_get() as __must_check
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 23, 2021 at 8:21 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> In the error case this function returns w/o the usage counter being
> incremented. Not checking the return code will likely result in a
> usage counter imbalance in the error case therefore.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/pm_runtime.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index eddd66d42..aa106f5fb 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -384,9 +384,8 @@ static inline int pm_runtime_get(struct device *dev)
>   * The possible return values of this function are the same as for
>   * pm_runtime_resume() and the runtime PM usage counter of @dev remains
>   * incremented in all cases, even if it returns an error code.
> - * Consider using pm_runtime_resume_and_get() instead of it, especially
> - * if its return value is checked by the caller, as this is likely to result
> - * in cleaner code.
> + * Consider using pm_runtime_resume_and_get() instead of it if its return
> + * value is checked by the caller, as this is likely to result in cleaner code.
>   */
>  static inline int pm_runtime_get_sync(struct device *dev)
>  {
> @@ -401,7 +400,7 @@ static inline int pm_runtime_get_sync(struct device *dev)
>   * PM usage counter. Return 0 if the runtime PM usage counter of @dev has been
>   * incremented or a negative error code otherwise.
>   */
> -static inline int pm_runtime_resume_and_get(struct device *dev)
> +static inline __must_check int pm_runtime_resume_and_get(struct device *dev)
>  {
>         int ret;
>
> --

Applied as 5.17 material, thanks!
