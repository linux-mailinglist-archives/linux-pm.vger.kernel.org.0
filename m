Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579FAEC72D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 18:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfKARCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 13:02:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40566 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbfKARCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 13:02:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id p59so8025665edp.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 10:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uoew/fPqh/5Cx3han3omflzNw7btngpjIhB4RSS554=;
        b=su0v+t2/zHb/+Ycbm8IoT85044e28DekaSi6pIlCuqpY1R9oMw8l1OT2BvcSf4KJCi
         28wYbaiQhULy7ahgvbTFo3THSqMo9HHRedD1dvUwZHc/RFOAngwJHWuXTS/qvzmMmowd
         6Wv12xdE5veqh6NvTviRqP7LQhFM/QgTbPPTdKMh2E930PdlVews9wks8wMzK4UXmsIc
         aHI8CflK8oNF+BhWXKnWaCNYOWhDjqUmsFrPcwJUcuy9M01tm8DqbjqyPi+IbVURqIno
         IttXnF+MHgdFETUc5WjimsPk/a3Yni3UA/MlD8tfweYcmGrecqaV8DhrmUyG3NGbz0dn
         hXGQ==
X-Gm-Message-State: APjAAAVdlAg7x9YIbv02/zIlnTRWxRXgteV0oar7Cg1Fvuf/cDP75Th8
        LBV8tVSlti6EY5iGvGMxfCFeUDYIWkB7GALr4Ycnew==
X-Google-Smtp-Source: APXvYqy6mcKjgVIUaNEoM2d4tSgLqIUk++sXg2gAMUCNlKSpAm+jXFoN4FjzdL8JEs8Rt+aTyaeufJNIPxyCL4iaoKA=
X-Received: by 2002:a50:bb48:: with SMTP id y66mr13868752ede.66.1572627754739;
 Fri, 01 Nov 2019 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191031131422.18887-1-rui.zhang@intel.com>
In-Reply-To: <20191031131422.18887-1-rui.zhang@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 1 Nov 2019 13:02:23 -0400
Message-ID: <CAJvTdKnjNwRDVukT_JONSTfzG-6kzxHFzNJoyWFpbmoHwTr45g@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Add Cometlake support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Applied -- thanks!

On Thu, Oct 31, 2019 at 9:14 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> From: Chen Yu <yu.c.chen@intel.com>
>
> From a turbostat point of view, Cometlake is like Kabylake.
>
> Suggested-by: Rui Zhang <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 5d0fddda842c..985e195f066b 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4610,6 +4610,8 @@ unsigned int intel_model_duplicates(unsigned int model)
>         case INTEL_FAM6_SKYLAKE:
>         case INTEL_FAM6_KABYLAKE_L:
>         case INTEL_FAM6_KABYLAKE:
> +       case INTEL_FAM6_COMETLAKE_L:
> +       case INTEL_FAM6_COMETLAKE:
>                 return INTEL_FAM6_SKYLAKE_L;
>
>         case INTEL_FAM6_ICELAKE_L:
> --
> 2.17.1
>


-- 
Len Brown, Intel Open Source Technology Center
