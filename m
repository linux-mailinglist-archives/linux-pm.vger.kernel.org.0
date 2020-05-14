Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC661D38E3
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENSHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgENSHy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 14:07:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C30C061A0C
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 11:07:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t25so3702433qtc.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clHL0oUq/03c2y1mV9/1cNUzUcz8pXGusMKN5fRmGO0=;
        b=B5RbZO+eNJRg2BP4B5j6ifuWozKFeTtzPd4PXnxticebFSRJ9G1d+VlOaGBINqXdSN
         IdQMWg+fsReR94i5urJvUxfZlx1yccK67kr7Z5duD8+aIZoB5rBAxvyu4epyA8yw0U6T
         jUyKVBjBu955nyW9K97I/OO4FkEnAcf+y5aEsJ6j1YrUFzM2ODSfmMeaRYF4YNdlXC31
         cIYFAUooiXJdT/n6px3cObx3dszlPs2uBJoGPGe1qhlYOaDjm7c4Bc7Uhgc2A40hhTim
         JBqHOqQlbT/iEyMVfl1n9SB4auzCzXljB/8wuaJ0sMWZzKvPSsxJGxQ7Ggn7KlDrqbVD
         fciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clHL0oUq/03c2y1mV9/1cNUzUcz8pXGusMKN5fRmGO0=;
        b=ObAoisIg9isfwt6BdDSPnq+CGofNNc7JpjH27FNwwUK5isknx8OyUQqDiQ3JADk4VH
         gM1WC6cI4pv+/3b3Rkb550ed4acv7hSbLn7TnPkYkJo8RNkjoCLrWcS08G2OvdlK3vws
         paRX1ABqaW3vhPN3Z2kdfRYcLz6N+ok6RWD9j5uHgm/M6fcExTm1VbmUhHPCLLSF9vrK
         gfNEdyV8d80IQdLr4SCqFo47TR38atqPuQICxFqs3F/mtz2aocCZKHmFPDAmEfpctlXE
         +sfHo8Ev0ZCs4PZPN/1nsaA4c5WmmTIfmKtbM8AA+fkRiZ7G3n407QCGsen0HBLbyLMf
         fsEg==
X-Gm-Message-State: AOAM533uN5vUSaLs8m3m6HY4jMMCmVQgwBJpinNcTl3hXtXR0Hl+WHTX
        0hN1ZopeShbPO+1LPeKknmODXC/rVcfS5h8saHQvhg==
X-Google-Smtp-Source: ABdhPJxDZg4DGARE25PrzpZ/8OsUBHKXrJFL9nnS1VzpHfkcytk6EAVgQqplKRPr6o2q9VCJJ51ly9K/zR3OIx9QoPQ=
X-Received: by 2002:ac8:699a:: with SMTP id o26mr5720746qtq.92.1589479672972;
 Thu, 14 May 2020 11:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200513101751.111907-1-pterjan@google.com> <CAJZ5v0hSGYCwAED6TWq=dPv+W=YSZ3p+3T1tbkfbhL5pWnOO8A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hSGYCwAED6TWq=dPv+W=YSZ3p+3T1tbkfbhL5pWnOO8A@mail.gmail.com>
From:   Pascal Terjan <pterjan@google.com>
Date:   Thu, 14 May 2020 19:07:36 +0100
Message-ID: <CAANdO=LoeMxhVM4_H6v0r2Qdn04x1VcTnD7Y3e7BsXBemaR+Mw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Delete unused define_one_ro/rw macros
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 May 2020 at 12:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 12:18 PM Pascal Terjan <pterjan@google.com> wrote:
> >
> > They were already unused when cpuidle was introduced.
> >
> > Signed-off-by: Pascal Terjan <pterjan@google.com>
> > ---
> >  drivers/cpuidle/sysfs.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > index cdeedbf02646..7729cf622d1e 100644
> > --- a/drivers/cpuidle/sysfs.c
> > +++ b/drivers/cpuidle/sysfs.c
> > @@ -167,11 +167,6 @@ struct cpuidle_attr {
> >         ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
> >  };
> >
> > -#define define_one_ro(_name, show) \
> > -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
> > -#define define_one_rw(_name, show, store) \
> > -       static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
> > -
> >  #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
> >
> >  struct cpuidle_device_kobj {
> > --
>
> This patch doesn't apply on top of the cpuidle material for 5.8
> present in linux-next, thanks!

Funny timing, it was actually already done a few weeks ago after all
those years :)
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=2f516e7cbe88f05023b6cc458d3a22b7dc56af99
