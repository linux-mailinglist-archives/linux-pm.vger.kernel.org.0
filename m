Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEA358928
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhDHQAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 12:00:50 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34687 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHQAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 12:00:50 -0400
Received: by mail-ot1-f53.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so2793116otn.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 09:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmLOvdI0zsV5U+neZZqzTs4DMkJ1UXpiBzEy9litWBE=;
        b=a7HkRP5cTpiyQDuqnHCQVF/br8XUXM/+fQQapaNcJxOVCXhcALmDW5ie710x46aHGK
         mRw2OOzctxcaGkZXdTXxcTdgvZ019Ps7QM0QxKemKbaK/Fsa3uHE2V7OicAITYVPCJLH
         17AVjtafuVLem9+G2y8+n+j4AzvsyS+GqtI/IsdwKOs57YQ5Nftzc3UWIqCT/T5PHkwY
         L3e9edgxCYwktmtCtPli7ubc+dN1pM6gb2tVHYkJn4fgUJKYIsQO6kEqsNl3Nlnz1Z+M
         y0kqb7nywaVLjusQD+2+tXiaVI+0lSH+2R/1ESAkxVpc5MkoLLGIA22SL1MnpsBAGTvf
         ekag==
X-Gm-Message-State: AOAM531IJATFQjcN968tDoHl3umldJh6008Lrc4whXmxqSGqpeWG7CI0
        w9p0+xgqKdT/Jn9cJi8AGv3f7Xq9IQPGo675hig=
X-Google-Smtp-Source: ABdhPJxsN2XtRuw+20Awbtf8iwV9qhcPySLgYbKnvLeqcH25R178NSZjZTezwUlJ612/uIQMlLvifprHQ+p6bXzs02A=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr8425117otr.321.1617897638739;
 Thu, 08 Apr 2021 09:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210408152209.GA1299604@rowland.harvard.edu>
In-Reply-To: <20210408152209.GA1299604@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 18:00:27 +0200
Message-ID: <CAJZ5v0jjhF=Xpk_WrAFXkcCh44tnqdy16uBxrPLsRcWO6VX3Ow@mail.gmail.com>
Subject: Re: [PATCH] PM: Add documentation for pm_runtime_resume_and_get()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Linux-PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 5:22 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter") added a new runtime-PM API function without
> adding any documentation for it.

Well, there is a kerneldoc comment which counts as documentation, so
I'd rather say "without updating the documentation in runtime_pm.rst".

> This patch adds the missing documentation.

But otherwise fair enough.

> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Zhang Qilong <zhangqilong3@huawei.com>
> Fixes: dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
>
> ---
>
>
> [as1954]
>
>
>  Documentation/power/runtime_pm.rst |    4 ++++
>  1 file changed, 4 insertions(+)
>
> Index: usb-devel/Documentation/power/runtime_pm.rst
> ===================================================================
> --- usb-devel.orig/Documentation/power/runtime_pm.rst
> +++ usb-devel/Documentation/power/runtime_pm.rst
> @@ -339,6 +339,10 @@ drivers/base/power/runtime.c and include
>        checked additionally, and -EACCES means that 'power.disable_depth' is
>        different from 0
>
> +  `int pm_runtime_resume_and_get(struct device *dev);`
> +    - run pm_runtime_resume(dev) and if successful, increment the device's
> +      usage counter; return the result of pm_runtime_resume
> +
>    `int pm_request_idle(struct device *dev);`
>      - submit a request to execute the subsystem-level idle callback for the
>        device (the request is represented by a work item in pm_wq); returns 0 on
