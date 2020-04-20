Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192501B1002
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTP1N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:27:13 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTP1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:27:11 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MowSu-1isnkS2PpG-00qOh7; Mon, 20 Apr 2020 17:27:06 +0200
Received: by mail-qv1-f51.google.com with SMTP id v38so4855483qvf.6;
        Mon, 20 Apr 2020 08:27:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuaZYvuyRsq58uSjVOe0SmNgWXUYNkt1Y9X2fHXu4Gvlj0cYjbZg
        wgcreCicNzqHa1t1wRAcQAu8NwSPCLBZIUZkfnQ=
X-Google-Smtp-Source: APiQypJY4e69j8jIL+s5vF/j7gio8ULkDsO83cBqoR8Hjix4uZ83n4bPAVVPQRfqjcQFYTucLdXeHPEnt3VU5UPRKHo=
X-Received: by 2002:ad4:4d50:: with SMTP id m16mr14104121qvm.222.1587396425446;
 Mon, 20 Apr 2020 08:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-8-robh@kernel.org>
In-Reply-To: <20200419170810.5738-8-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:26:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18FP9NtJrsJdFZkMMM9ToFGiCJdLZRXkPuHSLUO+Zniw@mail.gmail.com>
Message-ID: <CAK8P3a18FP9NtJrsJdFZkMMM9ToFGiCJdLZRXkPuHSLUO+Zniw@mail.gmail.com>
Subject: Re: [PATCH 07/17] clk: vexpress-osc: Use the devres clock API variants
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
X-Provags-ID: V03:K1:nfu0q7SluVtFJTi7o3wSeW9189Uis/+YCl/uYbUq1odT0RrPnb1
 VsXNEKl0r4GcOXEjIN81/kcJJdb62iGq7RyqToImFwNl8qTYfuNiTjpAEUzhuWQml4of3Sc
 pIIE4aaSH8pB+6K5WZCP46gMhyxr8dpU+9RuhUnDwZNg/hNguPQb7cHYFgx8oadW2I+C7NY
 Olqu8PX0hUBprUPcHOU1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rIooyW71Zz4=:0vsvLrvaI/poNYkPX8wHnp
 33mdy9Xk3dZ9XLrYNYoup2XCA++rYli+CTKnALuOHskFkDKonbBHJEg9nffcLZlGnI4lTqNe/
 boTWYjtMXeO7HYTjyPLJn7d+NMdf0PSr4YTnAMUYfgJ1U5v/5kh3mALVrwV+XG6zA0XDu6Rtl
 Ks+r7MTeJ+hKxdItt2BFTySsh5CBhOrO4JMskpcflt+aQ23FqZFoxccgHPfgf2iZDjZX4CzEd
 36qgVS5shHq3eizKZT41t8FldP0F8allVtG1leOTu0cBHliXGz5R6w4Ky8jssMNFweAN+SGLn
 7oN4KvGx0msOONngJhZEoXbvAOzP96DEOQGsKjXvpLVt37bJ+H1BT/MXrJDIUyM9vpXKm8ARx
 lhLeGtHn7Iblkr0lZTgcHpff3MLyWbhzJ1ifZwbP5noTbENHrMZsHyJ+KP7wo8Lpt1qgUlALS
 LlQ1m5Ic73WfxVUXe2bNiRJDEGrBn7qIiGFzHz5ssem5iGWH0RVctLOlHMpANVK1bzHNB3kBw
 bg0oyk0tBcKlAdTAb4ombq/5pzLgjnVdL5vCHWVKM1HseMHdx6NsEA58R8dF7w5nLzjFMUxOy
 qaWnq6a6bu+vojskV3D6B+7Z2U4mUCUEkrSgqSfCg3yaPDi3S71Y/r2TuJWyDj9ouwpn+SZ5b
 oFkC/HMs4Ky7CmAq0Y1SEDiSESoveYDE91vNx22iWV+nLGUtEDBp7NJYRo1df1TF+8WOgB5Lm
 outMns0pNZqyMEaucJ98EtwUGpAC/S3ZSmy79LtczhOpij8yhs/F+BHbgwj2TQsWflSN1xuk2
 86VuUlJYPw2NbPaD3AJ3N9FUuVxa8kjBATcNCmj+0sbD3bxPgo=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to enable the vexpress-osc clock driver as a module,
> convert the driver to use the managed devres clock API variants. With
> this, a driver .remove() hook is not needed.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
