Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7D1B16AA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTUHU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 16:07:20 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58813 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgDTUHT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 16:07:19 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MderZ-1irq2m38AD-00Zjuu; Mon, 20 Apr 2020 22:07:17 +0200
Received: by mail-qk1-f177.google.com with SMTP id g74so12121934qke.13;
        Mon, 20 Apr 2020 13:07:17 -0700 (PDT)
X-Gm-Message-State: AGi0Publ1bZEWi+heVILQKN5kJNTbcOigHURO2SK3owzAb8T7iC4DGbU
        kYSnB2p1Dt8k7FFAZISU/XZCOFUr1Nj9YaGCn3M=
X-Google-Smtp-Source: APiQypIAhB8mGz6XM0SD8ArnZJY6aRKd7XU6MxbJm3d0s6y853Y/+oeV+mBwceNCaK3NIlM89N1GSdGstRKXiXTq2KM=
X-Received: by 2002:a37:a046:: with SMTP id j67mr18240249qke.286.1587413236560;
 Mon, 20 Apr 2020 13:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-7-robh@kernel.org>
 <CAK8P3a2cxU3UYSj19Rt6pcUAtA1uTiQx46MF=92q_asmMOXMnA@mail.gmail.com> <CAL_JsqJS5o7_Ep50vfhNBOQ2sczgD+dNuiF8+GwjHUu7tN9j7Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJS5o7_Ep50vfhNBOQ2sczgD+dNuiF8+GwjHUu7tN9j7Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 22:07:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3YQaQESsb61rZKopddmiKdm2qK_mS+yiBY5th0xSHOjw@mail.gmail.com>
Message-ID: <CAK8P3a3YQaQESsb61rZKopddmiKdm2qK_mS+yiBY5th0xSHOjw@mail.gmail.com>
Subject: Re: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
To:     Rob Herring <robh@kernel.org>
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
X-Provags-ID: V03:K1:MDDR7O5z3srHf9k4tFMNpMqyjLlTrKq8QJuFfR5s3iqWoApvmWA
 o/12HEdOg0bICi0AD+txwsSTRNV4Gu3MxmyYx1SIYzk9VpWsKK+KnRJ4mhXXCOqUiUNmTn7
 WkgypqL5wBih8h6bmCo8zZ4B1uqDrT1BNIIWQLgjQDK5k+/l1QeR8lKTtSK0WhbQIVcIZAI
 9Mh4rS6PhXi2xCLls4xvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/+MCRj5Tck=:IlB8SHvEelKZ6OqI+7S/Rs
 gdbVNRwOEd9NsTzChaE4lygKYFVuArsmBCJpm+fw9x5/IA9708kHQ3hxUbMmZlViAY/pYYJQL
 gWL6UOQFsN0aA9zrJqj+8a5E0YKfqlkz56ENxqzN737oYTrBhxfgfcB9QjgW9oJ04MaOQSWP5
 EDqw+r/jj5yaez19jbYOMQbU/P0+d3hpwZ37OALhBBt5haJEN6psVehsGzDbWeTEBxw+Mtly/
 nZ4DIMD4sQxZL5CcQiDI+s6ZomZqHF0NW72s3/sinjy6zsEA7Q8xYnQFT5SmPIPtSD42uVUoq
 IBS/iLQmIRWRQ4BwKNUAvNRxY30YzD96MFP4GDFnT7b8S8RuqvtttZfGEeIMMPFQBDcfG/dDS
 y+htNKFmRiwTyAFi+UKOEtFkYOEZ5R+63BEfT7179LbwtKhbFZ2rHrI3zzZp2LF3/02e6GLS4
 /4bAuzavHaoV2+GMJ0s4dvDPk9QjP4RnmuKoNUrWtfh0YN0b3rClHW9coFiexwUGrhweBl++6
 /tal7rjyRxCIj3r3hgeQVTk+mQptrvCjuAuwdZT/ZPKIENUymJZAJxXHiUG/M4bKUu9OU9RuQ
 0jfrZHEz3GROR301re97Mfd38G/5xp56phRf7F2wL7OFF9aju3vnANY0IVIboV20x8a0nIaft
 fODmvSCjJ6Lv7LVIZuvqIZiIiie39/1Z01bdqWh7j3O0vzH+JrD21FHhPM9u2bZnFBno6vHSR
 +I4YeqdtgOf45ahiK6/XOs8WoA9D/e3uXKNgNb9cGAcE7Asf00zP1I5mQyf4MWali/alK0oqJ
 8BibD69fSquXXvhXC19K1WYl2YSm14qxpYXDgNvOMId8U0ttvQ=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 20, 2020 at 7:48 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Apr 20, 2020 at 10:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > While 64-bit Arm reference platforms have SP810 for clocks for SP804
> > > timers, they are not needed since the arch timers are used instead.
> > >
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > >
> > >  config CLK_SP810
> > >         bool "Clock driver for ARM SP810 System Controller"
> > > -       default y if ARCH_VEXPRESS
> > > +       default y if (ARCH_VEXPRESS && ARM)
> >
> > But maybe add "|| (COMPILE_TEST && OF)" for extra points.
>
> On a 'default y'? Not necessary.

Ah right, that would indeed result in negative points.

      Arnd
