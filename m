Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16431B5F8A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgDWPi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 11:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbgDWPi6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 11:38:58 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142CA21582;
        Thu, 23 Apr 2020 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587656338;
        bh=Wyu9njrWlhbl7xf7oU5Wt4MW02zQKWUfKmPdIYJCS0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xRMSLfCbE0Vw3xMU4fnO//Q4cZSfE5hkCFSOe6ZvHH6D9J/nOp0Ug94nN5MBnfqcs
         gblM2xujaaLkfOQpowbZvxT6qkM+Sp3vWTewAnDGPs22E3VIcloVFrBuPpU0S1d8eT
         uNrIBWpIEAHt8kYTypKjK0wjr7y/WLH+LsZgg87o=
Received: by mail-qk1-f171.google.com with SMTP id 23so1962644qkf.0;
        Thu, 23 Apr 2020 08:38:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuY7fmMd+2nFIjIgI7vSbx4z8kKWPT4K5/RVEBD/h56P6XUXzH01
        zE4tRVWKcEEET+bLIA/X+9CRFLHbEIIK1+LGpA==
X-Google-Smtp-Source: APiQypK3p49qKpfBlVKXdtl+eplKi5bsSct+10rTJ7VfvZd7h2kFVzE91169u5oa40cUZAZqg4c5h3ql6gSKT2CIpyk=
X-Received: by 2002:a37:cc1:: with SMTP id 184mr4344618qkm.254.1587656337201;
 Thu, 23 Apr 2020 08:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-7-robh@kernel.org>
 <20200422205202.GF25585@bogus>
In-Reply-To: <20200422205202.GF25585@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Apr 2020 10:38:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKO0KkYEq59t5+BECkK6uOHEkbW2ra6SeNDT9afiMhmSg@mail.gmail.com>
Message-ID: <CAL_JsqKO0KkYEq59t5+BECkK6uOHEkbW2ra6SeNDT9afiMhmSg@mail.gmail.com>
Subject: Re: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
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

On Wed, Apr 22, 2020 at 3:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Sun, Apr 19, 2020 at 12:07:59PM -0500, Rob Herring wrote:
> > While 64-bit Arm reference platforms have SP810 for clocks for SP804
> > timers, they are not needed since the arch timers are used instead.
> >
>
> Shouldn't we disable selection of SP804 for arm64 at the same time ?

SP804 is already not selected for VEXPRESS. Only RPi and HiSilicon
enable it on arm64. Though it makes me wonder why they require it as
they should have arch timer too.

Rob
