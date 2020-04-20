Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5190D1B12CD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 19:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgDTRSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 13:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbgDTRSU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 13:18:20 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7AE208E4;
        Mon, 20 Apr 2020 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403099;
        bh=MrAH2VsY+TtODBX+fkAcZq5uw1kTGKG8R7HORSOSQ/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JApMb1e4vC54i64Ik32l+IgfX1JaXzs+OgggR9IYG6T8OqAzdISMsR3/gqcukApT9
         Ej5J3hNwvzi8GEfCZKycTuZ3e48jJoxHFMy0KKji32mE2H1mCcKP9EemAHgt5/7/ZF
         04AHn/xCJO8E6lre5jdeyufKMEsTNuPdwWLdB/uE=
Received: by mail-qk1-f178.google.com with SMTP id l25so11502954qkk.3;
        Mon, 20 Apr 2020 10:18:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuY4NSFrOBlhFh8GYoaOeLykZPyZZu29HkB6BFkKSIJAXT6XYrc2
        pemtGA9ACjUw5OYT66uXCXA77KwiRl7mCGnFNw==
X-Google-Smtp-Source: APiQypJNfkN/fMd0KGM+5Vg1LBXgehBt4JTvfg6zC0uiCkKgQlI0eLwWlHUfc/lg4IOOlDLeLOR+fGB8lSNqdL7SWWM=
X-Received: by 2002:a37:c43:: with SMTP id 64mr15949855qkm.119.1587403098789;
 Mon, 20 Apr 2020 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-9-robh@kernel.org>
 <CAK8P3a0YmD6Ay6t=Wxmugvg=YM0fCtetgnqz1vTYs1rFD-9TFg@mail.gmail.com>
In-Reply-To: <CAK8P3a0YmD6Ay6t=Wxmugvg=YM0fCtetgnqz1vTYs1rFD-9TFg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Apr 2020 12:18:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZ4S=no9hPQO+jtwfd7E7HrHm8dAt9jZ3eh96dYCcy-g@mail.gmail.com>
Message-ID: <CAL_JsqLZ4S=no9hPQO+jtwfd7E7HrHm8dAt9jZ3eh96dYCcy-g@mail.gmail.com>
Subject: Re: [PATCH 08/17] clk: vexpress-osc: Support building as a module
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
        Linux PM list <linux-pm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 20, 2020 at 10:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Enable building the vexpress-osc clock driver as a module.
>
> >
> >  config CLK_VEXPRESS_OSC
> > -       bool "Clock driver for Versatile Express OSC clock generators"
> > -       depends on VEXPRESS_CONFIG || COMPILE_TEST
> > +       tristate "Clock driver for Versatile Express OSC clock generators"
> > +       depends on VEXPRESS_CONFIG
>
> Why do you remove the "|| COMPILE_TEST" here?

Looks like a rebasing error. I only added it in patch 5.

It has to depend on VEXPRESS_CONFIG because
devm_regmap_init_vexpress_config doesn't have an empty function.

Rob
