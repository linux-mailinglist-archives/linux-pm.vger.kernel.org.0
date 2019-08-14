Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B08CE8C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfHNIdx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 04:33:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45471 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfHNIdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 04:33:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id a30so15666693lfk.12
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5fo4g4+jTzEPPS8NQRIYLI3z/B0HGMqXSSYS0pphEc=;
        b=M7fDqA2ev3AaD0nQWyOj2IILz7JS+CusJowE3rw2HWWxQWP5bTn4JIVf4EXeU+h2VV
         dNtGZicyTPIW+AroFdMrISmo0K7Wa/Ry0A/A0Hov7yo6P3Kvm/XUFQKbuFgPiI4BeFed
         xyE4+85JhfoCDyLi69SCvuKDP9eMzv6vGULq3NopmDYKw0PL7FWkIJEr+vHFTQHOEGwm
         jsCPQlZIEWncomumM9JEmluiIhGX9EI1ZmzgqrHNkU6nqj+AkNv7VSxgtcgo9dzyXToM
         K7hfIA0czHnYUSSKNV+yrrwZCUvtTzXRKjgfW2gj2OmBE+1fxZxrjFX/iIzWKEAU8eT3
         pUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5fo4g4+jTzEPPS8NQRIYLI3z/B0HGMqXSSYS0pphEc=;
        b=uCKtno0cxmE9U0jxS6xahrcat5O5JcP190JKYJ/9uy3rlUnYsFcnNDkqXSb02ZQouB
         kdJHLVkUKLuQ72FUT4WZ6XogGlwenKqQ1yS5XJkVWVmoA06ry1kWaCf1/ygWZEHNmd6U
         MY+WoqfL8yZ5V8gWfHPcKRl5xcjQQAjn4612+BiWJSfy0DtHYOOyQBes+y/Jg+qHh+PC
         1juT9pGRfKyjTKdCG/ZJ4yNXzpjzyK3mn0+G1C+YpdMuj2TAAI1DtcLJKJkjzZdM/+fs
         NBLd2YBXRuqw5Bpnd2L2BIymCEG/jsqhaXlUahY0eoLpNfqta0FKowR5ahl6+cgyP0Lw
         tYyQ==
X-Gm-Message-State: APjAAAUvBqKsLs00L8hggjj8IfGfpQI2DabxGCufpPOrPiYRnVxQ71mC
        yzxqEDg6cM+kn8XOgCEC5rxSdgc+a4bXyPM9ccQO9A==
X-Google-Smtp-Source: APXvYqzvtd7+XwTL/eQMqN1AuBlMWDwk28758OmtF4qoQrqmv1Bq47tZFUSl03jCW/t21U3acG+NN+hoacaPwYJsMyw=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr22869417lfq.152.1565771631899;
 Wed, 14 Aug 2019 01:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com> <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:33:39 +0200
Message-ID: <CACRpkdZ6--v6bdmn7=fjPDxiza0cbuHQN93_fyu+fTCkJpq_Gg@mail.gmail.com>
Subject: Re: [PATCH v8 02/21] pinctrl: tegra: Add write barrier after all
 pinctrl register writes
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 9, 2019 at 1:47 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:

> This patch adds write barrier after all pinctrl register writes
> during resume to make sure all pinctrl changes are complete.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
