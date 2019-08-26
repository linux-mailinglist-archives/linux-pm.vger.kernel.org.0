Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5A9CB4F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 10:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfHZIMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 04:12:32 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41778 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbfHZIMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 04:12:32 -0400
Received: by mail-ot1-f52.google.com with SMTP id o101so14357630ota.8
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2019 01:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm/hza7H8fMbOftXAhtVZhAuQXjAizf7aBRGPiBet98=;
        b=q6s+puoBPpnNYXr6l58Ncc6CQiErpUMCIEvVebF4fEGrFHRYfTB4qKjprNeKB/Pjal
         lrwNR7sCmImGqV6qctPsn5SqYBu4RU8LQf235cSLxOyqLiYr/CREqXO/2XomqThgBoId
         JmWrM0QfMsyv9LuClkxbQybwDTzLYgAcEgYP4qNWuOVu3R1i2tnpMFJuu0udPidxdbc8
         bGBqpOpI9Wjt3Ar+ztlEUGO4QZVQwgRHv/gINKObxnhZ5F+Hxq51J1lEaHTDP7sZzpMy
         98t7T9VGZ6Tz9amIdCQ3DS1X117NTqGcpxGs7kCOGhhFAUjXsZC2a0Zy49UZ06v60o0V
         s1zA==
X-Gm-Message-State: APjAAAWzlXS18HXi9uNeMEHHQrcrWcxtacjjbkUf2Wy/RhKD+Ak2bu71
        xsauYvLC+fZgTp/8yksQpj1udukPzkyxXbXp1hA=
X-Google-Smtp-Source: APXvYqx7u/1fMdlozltDf7NSNQpMqK/xSwNSHT6HY5cfF2Fs1LSA2R1/YlBBH8FhhuZHkrh5wHPsFLmwAGzWSmP8WWQ=
X-Received: by 2002:a05:6830:1e0c:: with SMTP id s12mr9501391otr.262.1566807151366;
 Mon, 26 Aug 2019 01:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0PZbTpbzRmUq5gUBDr8ScGY7S-iqN9GhJJLrgB6Jqfxjw61Q@mail.gmail.com>
In-Reply-To: <CAJ0PZbTpbzRmUq5gUBDr8ScGY7S-iqN9GhJJLrgB6Jqfxjw61Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Aug 2019 10:12:17 +0200
Message-ID: <CAJZ5v0ipEMst=QCBjWAkD1BpLNK0Ad2SoQYDXsr2LwsxV-bN+w@mail.gmail.com>
Subject: Re: [PULL REQUEST for Rafael, Linux-PM] PM / devfreq fixes and driver updates
To:     MyungJoo Ham <myungjoo.ham@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 25, 2019 at 6:57 AM MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
>
> Dear Rafael,
>
> Here goes pull request from PM / devfreq with device driver updates and fixes.
>
> Cheers,
> MyungJoo
>
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:
>
>   Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)
>
> are available in the git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> tags/pullreq201908
>
> for you to fetch changes up to 0ef7c7cce43f6ecc2b96d447e69b2900a9655f7c:
>
>   PM / devfreq: passive: Use non-devm notifiers (2019-08-25 12:47:31 +0900)
>
> - ----------------------------------------------------------------
> Pull Request from devfreq to PM
>
> This series include:
>
> - - Tegra driver fixes
> - - new Tegra devices
> - - Rockchip fixes
> - - Exynos-bus fixes
> - - Event: add "event type"
> - - Passive: notifier updates

Pulled, thanks!
