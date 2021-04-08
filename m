Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6B358F28
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 23:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhDHVaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 17:30:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHVaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 17:30:16 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mdvua-1m2IY91N0o-00aztr; Thu, 08 Apr 2021 23:30:03 +0200
Received: by mail-oi1-f171.google.com with SMTP id 25so2208171oiy.5;
        Thu, 08 Apr 2021 14:30:02 -0700 (PDT)
X-Gm-Message-State: AOAM533YXAP+6RI8auigr7sjDj79+QpWQizW2MzwVNhTcD/2iBI6x6aY
        QG1skkgj09cpcgUgwRmS9EA9s9WdGg/jPZZMhXE=
X-Google-Smtp-Source: ABdhPJy0iWrhNPTZiYV5V76eutOZ5yur0zzh+RpJdmWXk6BV1PCspWe/8HGv1qdBtvUvk7EkkRQbIYcXbgnILzx2lHg=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr7492382oie.67.1617917401802;
 Thu, 08 Apr 2021 14:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210408205858.51751-1-masahiroy@kernel.org> <20210408205858.51751-3-masahiroy@kernel.org>
In-Reply-To: <20210408205858.51751-3-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 23:29:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3gzfZhNdp-_=HCxoMw385nGQeNOhhH8X+uyN=AMvHJ8Q@mail.gmail.com>
Message-ID: <CAK8P3a3gzfZhNdp-_=HCxoMw385nGQeNOhhH8X+uyN=AMvHJ8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pm: allow drivers to drop #ifdef and __maybe_unused
 from pm callbacks
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jBCef5MBplAyhl76VQF9Oz/gsjkGI646Ek39SGM6gF/9FUydqP3
 RKHFm6nBVAILMMau+SlIBizvt+Uf9D8nj4jJp33wo6W7MfUlWzCZK286b9ZAlhsRVK7vOTR
 U7Zsyy71yKPhIXd5BQnuUc4B+neTcrY4EjxxjS+qLg6gzp/K/KXofiXLaVHfZBEdiRyyLY2
 WBg+6e8lH5pKKbO85xIcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yD+w5GzQUF8=:65dIGNT0YpnNeLFMR/yjE3
 tiuRIXRgv3lLwhO9WqBhDuGerF4/u5KyJsgKJuQFBqpliwXtuRq4SYL82x8kcSesnus9yX1sB
 Jdw6lR3JevWjGdCJMwmfieS5K5KgRFD4rpTJ2ec9RQN2po7S4qoYVLgU8Q0VKLtS3ytfyWcu8
 6x+MEBAG3XxaC/yaOovdpsDmHG4N0lAX+HRla7hW3lGBHnnWCgG635ObrDZSgVaxJrXs5uaa2
 F91TK+J8x0EfjHlVX5S6zdvspXa+QyjPHw28hncPWb4IuGLjtxwKYRoUKyHXno+7q91YyXOrO
 vqdbigPo0y1nHeWzzZOo9uIlg3J1bpoktX197AZyMK/nFSQb55N3np17RXtOmth3IK1Btzn/P
 IILhDErrxS4zg6LedNHqAnT5e+1/qxg8Y1umMG4L/QA7E+8dTd5gFdH7QzXs0s1sewfXYFV2u
 WvQapsBUWn3ZG781mT/zCl1DR0rxYao=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 11:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Drivers typically surround suspend and resume callbacks with #ifdef
> CONFIG_PM(_SLEEP) or mark them as __maybe_unused in order to avoid
> -Wunused-const-variable warnings.
>
> With this commit, drivers will be able to remove #ifdef CONFIG_PM(_SLEEP)
> and __maybe_unsed because unused functions are dropped by the compiler
> instead of the preprocessor.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I tried this before and could not get it to work right.

>
> -#ifdef CONFIG_PM_SLEEP
> +#define pm_ptr(_ptr)           PTR_IF(IS_ENABLED(CONFIG_PM), _ptr)
> +#define pm_sleep_ptr(_ptr)     PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), _ptr)
> +
>  #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -       .suspend = suspend_fn, \
> -       .resume = resume_fn, \
> -       .freeze = suspend_fn, \
> -       .thaw = resume_fn, \
> -       .poweroff = suspend_fn, \
> -       .restore = resume_fn,
> -#else
> -#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> -#endif
> +       .suspend  = pm_sleep_ptr(suspend_fn), \
> +       .resume   = pm_sleep_ptr(resume_fn), \
> +       .freeze   = pm_sleep_ptr(suspend_fn), \
> +       .thaw     = pm_sleep_ptr(resume_fn), \
> +       .poweroff = pm_sleep_ptr(suspend_fn), \
> +       .restore  = pm_sleep_ptr(resume_fn),

The problem that I think you inevitably hit is that you run into a missing
declaration for any driver that still uses an #ifdef around a static
function.

The only way I can see us doing this is to create a new set of
macros that behave like the version you propose here but leave
the old macros in place until the last such #ifdef has been removed.

       Arnd
