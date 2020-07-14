Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33021F243
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGNNQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 09:16:25 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:45893 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGNNQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 09:16:25 -0400
Received: by mail-oo1-f66.google.com with SMTP id a9so3325523oof.12;
        Tue, 14 Jul 2020 06:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAHonr/EX22GXSSLURAad0tCboLdlq1IazrJJKl7ts0=;
        b=LVLaIuZ2S40c8xPpdboqQI/u5JVSNoFZ8WbCWoSEXmoy2MOJes/PBIWQAtSoQeSAa2
         u5oms+grOjP7HtoR8n5mKUQeN/+dHjc7OUbw3Z31PgkPl73iOELH7xwa1LxDwD5sLyms
         30VNzu7iDMdFD27Dem7+B8RUUJoeSRvSvuVw5dqzQLxnMDZyK/Ng6VkZlhQScFYGlLxX
         Ye+fDKd8Jqpad70FTkaGlpxJwf3OWFcX+UASJV5HWQKZf8oKsmT7Hr7QluFhG/weV2nu
         xkop6ifgfNc4JPh2g2QNb9L3bdGkecQ55FHw8x2qQv0rNERxQdRbyjNuRkO1Xwu6u22O
         tvvg==
X-Gm-Message-State: AOAM532ycATd7lxtmpTLt7Uy6G+4CzuBhVpp90cpBlJKxzZdnQiMXtcK
        a4P5gbP4RYtj+wnwKp3DylYJXCTs3u0xDPZvs5JRaA==
X-Google-Smtp-Source: ABdhPJwKDy9QlQ4NrEX6WcDj3pqOx8svRxGgJkWilKCvk0x1maAoDZON3QHgO5KTT1zd+BIgIaQbDUWN1zTsBZf5jlE=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr4419978oov.75.1594732583976;
 Tue, 14 Jul 2020 06:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200714125625.2584-1-geert+renesas@glider.be>
In-Reply-To: <20200714125625.2584-1-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 15:16:11 +0200
Message-ID: <CAJZ5v0j9=R+_-Js6C79yom7wbwnaF4TE1ggryUtCWHFnnqjA0w@mail.gmail.com>
Subject: Re: [PATCH] PM / Domains: Restore comment indentation for generic_pm_domain.child_links
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 2:56 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The rename of generic_pm_domain.slave_links to
> generic_pm_domain.child_links accidentally dropped the TAB to align the
> member's comment.  Re-add the lost TAB to restore indentation.
>
> Fixes: 8d87ae48ced2dffd ("PM: domains: Fix up terminology with parent/child")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Feel free to fold into the original, if deemed appropriate.
> ---
>  include/linux/pm_domain.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 574a1fadb1e50631..ee11502a575b0eca 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -96,7 +96,7 @@ struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
>         struct list_head parent_links;  /* Links with PM domain as a parent */
> -       struct list_head child_links;/* Links with PM domain as a child */
> +       struct list_head child_links;   /* Links with PM domain as a child */
>         struct list_head dev_list;      /* List of devices */
>         struct dev_power_governor *gov;
>         struct work_struct power_off_work;
> --

Applied with a minor edit in the subject, thanks!
