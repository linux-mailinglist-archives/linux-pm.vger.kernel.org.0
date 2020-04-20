Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B021B01B7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTGo2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTGo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 02:44:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432CC061A0F
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 23:44:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n6so5275808ljg.12
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgOqIRpLDJeJNx24vbd2CV+KIapgXOXxX4iBPbrgTik=;
        b=K2Pjm9Tj7zHwiYuKEvfwP7zEG7BkatDtSAcfTeYN4jFzItHyBGcGvx4RxenavagXY/
         Uz/SGDvIdDurFIJWSLmvvbOoxUED4gcDKNuXrNqVNg60GHuJkTm9zSoeXZHfHXGpOWhD
         sY1+IVYGVAUjM1RoLVWRpIaYwbwPcIE/a09AGaP0wNLSRkHMMqpLZJU2hn+m8C3/mrHA
         5n28aqYcyKEO1CDDkGpSzPdCGayLaieagMquIm356hadahuyUNHE73LbxMkmXVSYE0tr
         hei0pLQrHr4BnjGhKch95pifzAoXA5CyEJGTqzSnuOIiUTZR2Hn+wfpur5tfgIWyqROP
         fTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgOqIRpLDJeJNx24vbd2CV+KIapgXOXxX4iBPbrgTik=;
        b=SDBoC93VYEy1gI5o+6l7xC67k+3cgAoQf1M0f9bQofhiPnoMsB/uZ270WCiHW/GGga
         m7JmYR89/thaLg0JbL7DUefArHIgCAXE9emlEo6DWuFpnkJgEXgt5WLIN5hT2UKttKAY
         vW+owsdqAxHI9GPD49AuX80MxIs6ihMqkpl9Tm6Txdu+eSk/Jkh25rUxZ/7ZRRqHwuFX
         9m62hzVOBc8hnlUcJyxY1ptSU03bi/QBDeQRDwpBJrVAhei8wLZPHKqkhy//estX3yHQ
         ydQ6u16vCqqgFmeUHdU3t3S4U+s5xZwPSnGVHXWCVXqTRhQXXwnTMd7zK0BkEP9T+43y
         T1Lw==
X-Gm-Message-State: AGi0PuZJjmE4iGnC8lo3nmtKx9RPz2XKv1pqr4DxbvTBvSzuasoenxCV
        qR+YfurjG55WhfRJ110fKpSSt8mlshMhVzY6nr4Ixw==
X-Google-Smtp-Source: APiQypIWrvbuGilFqwUK4J/jFPRrcItaSJloXE/A2PHW3NnuJWBony0etnuvXn7iJyfUT6gETNUhWZTt7e4q+ysOKeg=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr6983364ljg.99.1587365064709;
 Sun, 19 Apr 2020 23:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-6-robh@kernel.org>
In-Reply-To: <20200419170810.5738-6-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Apr 2020 08:44:13 +0200
Message-ID: <CACRpkdY7YWQobPt7KHJWkzScag-y608rhc6+vzLo_3hDWT1iig@mail.gmail.com>
Subject: Re: [PATCH 05/17] clk: versatile: Kill CONFIG_COMMON_CLK_VERSATILE
To:     Rob Herring <robh@kernel.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:

> CONFIG_COMMON_CLK_VERSATILE doesn't really do anything other than hiding
> Arm Ltd reference platform clock drivers. It is both selected by the
> platforms that need it and has a 'depends on' for those platforms. It
> selects REGMAP_MMIO, but really CONFIG_ICST should do that. Also,
> CONFIG_ICST can't be enabled for COMPILE_TEST unless something else
> selected it.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Good catch!

Since this conflicts a bit with other Kconfig patches I have pending for
mach:s in arch/arm it'd be great if I can get an ACK from the clk
maintainers and merge it with the rest in a pull request to the
SoC tree.

Yours,
Linus Walleij
