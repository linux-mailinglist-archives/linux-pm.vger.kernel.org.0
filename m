Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4C3B72F9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhF2NMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 09:12:48 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37747 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhF2NMl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 09:12:41 -0400
Received: by mail-oi1-f176.google.com with SMTP id h9so26206489oih.4
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 06:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+k/LJtxOcAqdDDUKT3QsyKiu4B+UkY+Qv5iXhujdC0=;
        b=EJq98veQXJoycBoUdAHHAUYKMGj2wIEZAHinw2QKByotDn2EFrRNmghYaj4BxENU1g
         O8UCGPk8zNXbYy5AzxDipyVhW4dTFBWe3bG6hv/mCLgNUp6sn3HZpVonYeobMxoz3Jri
         iA9ZoEmdl4v/RDDd1plRLjqsWlgzRf3cBIPxrQzHQdlOkkiOfMj9wDHI7s6UDWaoDtsw
         Dt+DBhvm2YXeHdOq+uKVviGd3jUD341eJ8iFaezndmQTxCgGAqXmTdsFC+MoHJhncTg6
         b75+bh0pn0apHxbDSpbFaW0yBZ4rv2OUOm73ySSkK0JycOwC/HHfMuDgiHnmjT7fx8xD
         kh8Q==
X-Gm-Message-State: AOAM530UuaJ8zie0d+d+ciMxME/OoVKnDkd+psdlroTFPwrukWCa35v7
        3i++O6NmcZDmvzSmOraOBRXwVlrXG18ITMFWA+8=
X-Google-Smtp-Source: ABdhPJxetHUkRgDdYOatgVyKpmMlbLfsWiicNiW7TszJj8bDWdyd6hQiCBZ++6IGaeHEXn2qbI8CPOY4x3qdSFuWkKI=
X-Received: by 2002:aca:417:: with SMTP id 23mr6687488oie.71.1624972212944;
 Tue, 29 Jun 2021 06:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210628073023.gytz3hkqy64hkzdr@vireshk-i7>
In-Reply-To: <20210628073023.gytz3hkqy64hkzdr@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jun 2021 15:09:56 +0200
Message-ID: <CAJZ5v0hePOc00aw_tQvFo=S=crUb6MxHpGMbQwPzjL6dd2eHEA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.14
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 28, 2021 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request:
>
> - allows partial use of required-opps for non-genpd users.
>
> - does a minor cleanup and uses list_del_init().

Pulled, thanks!


> -------------------------8<-------------------------
>
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
>
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 4fa82a87ba55f5eca7d194055572110652daa264:
>
>   opp: Allow required-opps to be used for non genpd use cases (2021-06-18 09:00:55 +0530)
>
> ----------------------------------------------------------------
> Hsin-Yi Wang (1):
>       opp: Allow required-opps to be used for non genpd use cases
>
> Yang Yingliang (1):
>       opp: use list_del_init instead of list_del/INIT_LIST_HEAD
>
>  drivers/opp/core.c | 10 ++++++++++
>  drivers/opp/of.c   | 27 +++------------------------
>  2 files changed, 13 insertions(+), 24 deletions(-)
>
> --
> viresh
