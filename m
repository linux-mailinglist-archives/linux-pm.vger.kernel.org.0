Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C554358B29
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhDHRQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:16:12 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41818 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhDHRQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:16:09 -0400
Received: by mail-oi1-f175.google.com with SMTP id z15so2908081oic.8;
        Thu, 08 Apr 2021 10:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yr66sxC+1g5GcSTJpK+4XHiatspr4xLME96kf8P3oqk=;
        b=P3fihZHxg5ki0LH5iQMaW1dealr4YYsz3UOXMthMSlBQekyH+RVeXuyqfQrrM3Z/jk
         s1F8mko/TZiCsZrdmRQOIbOjLL7cwlpciIznuHb1qB0/6XxWVokf8eKk+fbuKbeqku3N
         iYG0SWrKw4OV1n9A2s1n2uCuX7k2jh07JQuoue+gET99oZhTaDCoRGuZloQyFu6QIFO9
         Lwc3+akI5g4kcYGkgWte7t6cY4nvUd8a7LoicrgghXKgnio2+dsBqCp5PlHTxv3IFmHe
         ETWjErqMExm7J5ibezmyTd+PPlhPGhL3fWtJDNAxz+cuHfozbs3Mt6lU8uO2X0QgV7Cq
         MdSA==
X-Gm-Message-State: AOAM533WD6zZweIAEynkKFSf1TuPEGTjzWoqNvQ+ApL0QQd9mwX1KfzX
        332/0Ct7BevO0FCe5tHNOI3fxjkp/56W1XwIum7PquEb
X-Google-Smtp-Source: ABdhPJz/rnehChE2sYDXHhBDJuK0Ry00WSqZ5GbGMOZxT8XSg6im95K595uOoVzCH1Y7KjN2sp8WN6JrCKDCS/FlAtE=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr7013767oie.157.1617902157897;
 Thu, 08 Apr 2021 10:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210402061422.3396-1-yuehaibing@huawei.com>
In-Reply-To: <20210402061422.3396-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:15:47 +0200
Message-ID: <CAJZ5v0hH35PSfbSjXOoA-5J2ep3Q0YVS6BbdnYBbrVhMMEBKKg@mail.gmail.com>
Subject: Re: [PATCH -next] PM: runtime: Replace inline function pm_runtime_callbacks_present()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 2, 2021 at 8:14 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> commit 9a7875461fd0 ("PM: runtime: Replace pm_runtime_callbacks_present()")
> forget to change the inline version.
>
> Fixes: 9a7875461fd0 ("PM: runtime: Replace pm_runtime_callbacks_present()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index b492ae00cc90..6c08a085367b 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -265,7 +265,7 @@ static inline void pm_runtime_no_callbacks(struct device *dev) {}
>  static inline void pm_runtime_irq_safe(struct device *dev) {}
>  static inline bool pm_runtime_is_irq_safe(struct device *dev) { return false; }
>
> -static inline bool pm_runtime_callbacks_present(struct device *dev) { return false; }
> +static inline bool pm_runtime_has_no_callbacks(struct device *dev) { return false; }
>  static inline void pm_runtime_mark_last_busy(struct device *dev) {}
>  static inline void __pm_runtime_use_autosuspend(struct device *dev,
>                                                 bool use) {}
> --

Applied as 5.13 material, thanks!
