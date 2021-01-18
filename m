Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F62F9DD2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbhARKrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 05:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390201AbhARKeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 05:34:31 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A905C061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 02:33:26 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id 186so6459804vsz.13
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adiPbiEP1YT6K9N1O0mWeeG4Pxclh7kWVlewQqbqeNE=;
        b=I3qVuBr5uDMMAfGcazh4VHKHknGJ0eoa0uFRy3D86VXscngmO6tKadEb8Tf2J9n3rY
         Wk6qdTAlcNr2fk4JZjTwHDYfs1/VYbw1AFxrB8AW28CwyG+Y+8XVdpzq4llf/epKoR9k
         iZniMhqgneDNT6L6Wjpyapo/qMi/m+7C7A7EN7HZLGMnKFVv3c8LSjXZkXN3dZiQg4pN
         yKdif6tHIgU3b373dIpgsnOyC/d38I9Js8UYY9lpS1Bk/TCj7cBiILsGEGCRvuR+Boa/
         22QUys2sv67Jll9loPfC0rqQBGwqY6hAPPuSDD+BDM4QKipHQ4T0SQ/wZoxMugDQuXCj
         4Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adiPbiEP1YT6K9N1O0mWeeG4Pxclh7kWVlewQqbqeNE=;
        b=rWMCEZJ+vz27tevo/TddcVWVa0DlXkJVObYcb9rljwgOHL3cXinpu1ecKAEqyBZiAX
         2BdUBNEttL10YcVg4gapZPf4/YbHmGDT54qP66jo4RwdJlvF4ljK7YwfC8HCljBlfKhg
         OXvxeuTzYh3xHbugKPffHtTO0jTFMCNXfJNe86y/GMscPxUGZ563FHC7Q56xfA2/Cc1j
         oZq9Gxh8BJS/1rQMA6adGhWxqBFnMC524RoIBf523FhBxWny5U5lgsVPSYwNTAgWlT8d
         Xfi4LOOcAsj1neJyYBHgPYfntEYnaOvB4KVgnrItrMhQ9IHMK65Yef/xmLnmC15VsnlW
         zQlA==
X-Gm-Message-State: AOAM530TIuu0ZYRGaNzPXszGtE/5pCu54LkLKarr/SzmW3WqtEmzn2Oc
        vW2fjgoONrUsQZ+JhMqkyZiPNlMpRKPUPDNVW4WBug==
X-Google-Smtp-Source: ABdhPJz7J/RbHIZCaRXKtv4bI/4J9V1bWxYQzBjJDzVZXkaPGqqSpE/x0WWPE3R4rM1rIh4V9JZj+GO+3R+IOR7Ne3c=
X-Received: by 2002:a67:c787:: with SMTP id t7mr7915130vsk.48.1610966005685;
 Mon, 18 Jan 2021 02:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20210118011330.4145-1-digetx@gmail.com> <20210118011330.4145-4-digetx@gmail.com>
In-Reply-To: <20210118011330.4145-4-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jan 2021 11:32:48 +0100
Message-ID: <CAPDyKFpKHQQjbeBdnx1AVHmYJFD0XaXSqps8XZUyCK_9VB5FeA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PM: domains: Make of_genpd_add_subdomain() to
 return -EPROBE_DEFER
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 18 Jan 2021 at 02:13, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Driver of a power domain provider may not be ready at the time of
> of_genpd_add_subdomain() invocation. Make this function to return
> -EPROBE_DEFER instead of -ENOENT in order to remove a need from
> power domain drivers to handle the error code specially.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2ab77aa516eb..7ef6764ee30f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2462,7 +2462,7 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
>  out:
>         mutex_unlock(&gpd_list_lock);
>
> -       return ret;
> +       return ret == -ENOENT ? -EPROBE_DEFER : ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>
> --
> 2.29.2
>
