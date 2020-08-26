Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3879252F7E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgHZNTa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgHZNT3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:19:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293F3C061756
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 06:19:29 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c6so1675348ilo.13
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barpilot-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bUwFpYACD42QxgeWE3X2J+SkloJfTYibKZZtGpBYro=;
        b=MKGu8xBXuUL0hWLb9wlh+CJNb/mq6JRX8wD1m7pPWqQlF5GhAjq6+R2g0sT0XYEHay
         TV8Mirg6gUHJZyyWX3WCf+C9KoYh7TkcRVOAyh0eUKTbyXcRxDHDE/pGTgectmIdyCYL
         N+d8o2vx7UppJcgXYHzY+9GKAiphMhEBmcktUkTHu+/u8CW1FWIOqHiuoInlcrIy0T2N
         fxOFKCdtpQHid5M69mLCPL+R4/qvglvlvfslAySirBIIlQK2QIDx+jRW0rPUpYej8UvT
         iw+Bw4qLKIe2L1ZVxblSGkzhksCPrHqi2+aCTLwu1Doqt4vS7GakpNdc8VhwF15843/h
         It9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bUwFpYACD42QxgeWE3X2J+SkloJfTYibKZZtGpBYro=;
        b=nENBS5RBJNTgM12LtwVeQM3nWOX8e/5Oc3KK4kr/8dFEkHaojwn429V0Tp0f6Q1+bT
         bPpedpbWW900KFQao67bXnsEmG1rOP4Abeqtkst1fFV90uCRU8nCcjg7/Sc7EY0uYpk8
         KBcnJ7J0J+3W5oyBpRBjlqdrSCyfxshQh3F/gGguegQ2aO8t6hw+pd9JuyALDzcW9QVZ
         kKB65sNrDGrDsiFf2W8dqPVJo1dGCH3taWprCMrpRY3hUvNieWVfA94a39Rk6l/Ots2G
         TNCyAjl7Y0ooZQnw+fiFJV8XZJSsAX82E1MTnea8k7y6Urp7zuqV5wxkIkByjWferQXk
         mEhQ==
X-Gm-Message-State: AOAM533oO/teUgDywhPN2I6qw5RV8jQbAckfO7ZMnjGNgwKSIBIQFJZP
        KDPKxAOQXJ8SxqkL6DUJvkP2kMnWZcq3EE3p/2HiQA==
X-Google-Smtp-Source: ABdhPJwcGzezTYdoMZl6prnQJJJRb+htE8S3GWQCqeoJr/SCWSoAuxxw9Po3V0R/Dmd7im1HBqH+X3edHjMwIKkwlCg=
X-Received: by 2002:a92:9fdb:: with SMTP id z88mr13012107ilk.57.1598447967035;
 Wed, 26 Aug 2020 06:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com> <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
In-Reply-To: <a7c8ee4b54b5f205548c055b7b8d599c1bd7ddeb.camel@gmail.com>
From:   Guilhem Lettron <guilhem@barpilot.io>
Date:   Wed, 26 Aug 2020 15:19:15 +0200
Message-ID: <CAGX5Wg2rzm74RprNYVzbkGBUx8WJZ5etKE_UOg8S3Eoyd=h2pg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     dedekind1@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Aug 2020 at 15:09, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 15:03 +0200, Guilhem Lettron wrote:
> > On my laptop, a Dell XPS 13 7390 2-in-1 with i7-1065G7, ACPI only
> > report "C1_ACPI", "C2_ACPI" and "C3_ACPI".
>
> Did you try to dig into the BIOS menus and check if you can enable
> more/deeper C-states?

Yes everything is enabled relative to C-states.
I find, at least, 1 people with same problem:
https://community.clearlinux.org/t/intel-idle-on-10th-ice-lake/3939/9

>
> Artem.
>

Guilhem Lettron
