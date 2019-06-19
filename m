Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867454B838
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFSM2U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 08:28:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39020 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFSM2U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 08:28:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so16177965otq.6;
        Wed, 19 Jun 2019 05:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkqxDQxaoP4bZHVemNak1GsJ+YOnJiiFXfkLhDNKRc4=;
        b=gvcBmI66xXrBP5+Jk2zO1D4++wI2WogAy0xLZ/5M3StlaNV0SXnn3WoLOeTaCRIRUl
         NXUNrkkTKgLYFvK5bEC8L2D9MIGWoEwo0PuKI5QiFPYLdgIQAgTTs20pa4lx6Yo227Ck
         84rTK+pyGTP9heEoykx6pqElgVKehn5wScrOS/ippBzsMeOmbSwOgmfKSxJixZox149q
         e7e2HIttBhSvxh9yWG7QpkjUrP3ysKrYipWVnRDuqPCSGLiQx5n2ym3blofQ/ywuKqHs
         2Lt76L79JD8Up8FCQcDmkhINpLVN5+ORlhb++cOKBuO7mnF9WzRQ6dsdKCHAVbvZN9O6
         0nsA==
X-Gm-Message-State: APjAAAXnkJzW4O4027/ynpS525eAWNoBFl5ni0nSn00jaWFCjN4u+7nS
        Wqwyb1dqNJaoO1B5wBshi/1kn54L7LH5WL4g5xUbAQ==
X-Google-Smtp-Source: APXvYqzYviKAQmZCcYPk9Ok0Mn8ppwliIjXjrV1wp/5C+WyaMBH2nWvDpbWKL7Cl2P3JwZUmGxNEO6o8V1ISO/3A3KM=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr5443795oto.167.1560947299668;
 Wed, 19 Jun 2019 05:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560944014.git.viresh.kumar@linaro.org> <8c563c8f3515ceefd88875160302b6fd472c3dac.1560944014.git.viresh.kumar@linaro.org>
In-Reply-To: <8c563c8f3515ceefd88875160302b6fd472c3dac.1560944014.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 14:28:08 +0200
Message-ID: <CAJZ5v0gmkAS-A2eT5VUyuBMD9+FfsM0HL-HPeUYUV24_oMTvVw@mail.gmail.com>
Subject: Re: [PATCH 4/6] cpufreq: Use has_target() instead of !setpolicy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> For code consistency, use has_target() instead of !setpolicy everywhere,
> as it is already done at several places.

That's OK

> Maybe we should also use !has_target() for setpolicy case to use only one expression
> for this differentiation.

But I'm not sure what you mean here?
