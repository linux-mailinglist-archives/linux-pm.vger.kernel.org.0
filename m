Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B21B518E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 02:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDWAya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 20:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDWAy3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 20:54:29 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B13E2075A;
        Thu, 23 Apr 2020 00:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587603269;
        bh=EdeAQ2EdBIQEUfUEWY+K0rWxiAbfj3atcOU3hxgWKyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U6eIpZ4dnkMiG9rnK5P7Ne5VcVRJzLtgh6wGjJ421bhNj3OJyq6TyzpmwccXDczX8
         GZm6rDL3BmglFyz3Ru8xJp4K1LbRYEpPLDdT4rYXMFF1MalxjWggEkrG4/otS1kk9V
         6Yu2Mt/XZpKjosxzTyls8cNSfzU74NEVM4xcS3Rc=
Received: by mail-qt1-f171.google.com with SMTP id x8so3481488qtp.13;
        Wed, 22 Apr 2020 17:54:29 -0700 (PDT)
X-Gm-Message-State: AGi0PuYjIcf2BTZ6YG4sgP7GhVHTRbdlpxJlC2wK16R2XY5TzgFBTkey
        KRwfAnnEQsQZj5xPotU/AD+SaER3abmnWEq2rg==
X-Google-Smtp-Source: APiQypLM57Lkh8iAgNUZnacihwoOR74d09qQ7Q5sY/K/hAUmznUbIS0nhBAnRSBkMJUqszGyIlIZBbd7gRjPBC5mzIc=
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr496433qtr.136.1587603268256;
 Wed, 22 Apr 2020 17:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-16-robh@kernel.org>
 <158754906803.132238.5380277174069330915@swboyd.mtv.corp.google.com>
In-Reply-To: <158754906803.132238.5380277174069330915@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Apr 2020 19:54:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJb7x+gcsxstvdRkUD75=cJ7DsASmhCJKdoQJ62rBHvXw@mail.gmail.com>
Message-ID: <CAL_JsqJb7x+gcsxstvdRkUD75=cJ7DsASmhCJKdoQJ62rBHvXw@mail.gmail.com>
Subject: Re: [PATCH 15/17] vexpress: Move site master init to vexpress-config bus
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 4:51 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Is the subject supposed to say 'set master' vs. 'site master'?

Humm, maybe 'master site' instead.

>
> Quoting Rob Herring (2020-04-19 10:08:08)
> > There's only a single caller of vexpress_config_set_master() from
> > vexpress-sysreg.c. Let's just make the registers needed available to
> > vexpress-config and move all the code there. The registers needed aren't
> > used anywhere else either. With this, we can get rid of the private API
> > between these 2 drivers.
> >
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
