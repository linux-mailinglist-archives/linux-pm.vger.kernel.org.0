Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662391B1288
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDTRFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 13:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRFi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 13:05:38 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA8E2145D;
        Mon, 20 Apr 2020 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402338;
        bh=Xc6XrmLSCIcb51KsMBWF6mTM27IZYmEb7/lQXrM3bu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q4T1kv7HdPS1P5AZLjTSWBTvlZzn4+euSJBG9XPEJqjOF4FmZ514Wr1grHZzGoua5
         6Z5ff+J6X2CSm24a61Qi0qetLCs0LuaKfQckhEVrAzSFRhtpFfxW3wmn5ON7BcecsZ
         6dSEhbpXs3HPlIIV5+JtrFntF009WAxyXwsB7qck=
Received: by mail-qv1-f43.google.com with SMTP id di6so5043991qvb.10;
        Mon, 20 Apr 2020 10:05:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuZqErpcVbfR2EA8n7RaMcdOJQ+MLh8XDW1GAGAKVLMsyVoD8qKe
        hN7OtplDue/2OyvCcgUOdU6cUljQnfOPIgOmBw==
X-Google-Smtp-Source: APiQypIDWoULtjcdPMhHTwUbjhB5PgHOYuP8qk/54NpEcp5kyQVmA7he6ResPS2EXZ7aD56hadG6ccO+LfE9ccPnqZk=
X-Received: by 2002:ad4:4ae3:: with SMTP id cp3mr14899713qvb.136.1587402337413;
 Mon, 20 Apr 2020 10:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-13-robh@kernel.org>
 <CAK8P3a2+o=DQNJ8UTJzq1ugm12RTfyaUwYx=KW6Xx6uWE2zOOw@mail.gmail.com>
In-Reply-To: <CAK8P3a2+o=DQNJ8UTJzq1ugm12RTfyaUwYx=KW6Xx6uWE2zOOw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Apr 2020 12:05:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKDXq9g3UsmNe1JbQuySYW0LhHpE3yR+Qowx9u3-T7eNQ@mail.gmail.com>
Message-ID: <CAL_JsqKDXq9g3UsmNe1JbQuySYW0LhHpE3yR+Qowx9u3-T7eNQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] mfd: vexpress-sysreg: Support building as a module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 20, 2020 at 10:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Enable building the vexpress-sysreg driver as a module.
>
> > -
> > -       /* Need the sysreg early, before any other device... */
> > -       for_each_matching_node(node, vexpress_sysreg_match)
> > -               of_platform_device_create(node, NULL, NULL);
>
> Is this safe to remove? If yes, please mention it in the changelog.

Well, yes and no (I think). This was purely to instantiate the device
early before the default DT probing would do it (as all the parents
are 'simple-bus' the default would descend to these nodes). It's fine
after patch 14 for sure, but before that I think it is changing the
initcall/probe order. So I'll stick this between patch 15 and 16.

Rob
