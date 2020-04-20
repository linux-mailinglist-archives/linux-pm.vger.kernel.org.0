Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAEA1B0FBF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTPRk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:17:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58993 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgDTPRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:17:39 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MkYg4-1ixDiO1PLy-00m2bW; Mon, 20 Apr 2020 17:17:38 +0200
Received: by mail-qt1-f169.google.com with SMTP id x2so8770048qtr.0;
        Mon, 20 Apr 2020 08:17:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuY/iZ6ttYSFVF9++O17st1rSes9xUvWaxkOZYUXA/EtuACW3moS
        BnsSBkyhVU7LpFjmGI8MMGyLiTeClvWmELcmT1c=
X-Google-Smtp-Source: APiQypIZpcbpVguGnPVp2wcc994cFV0BoBRFUnMkzk8Awyyhz/lIgecL9i9/JcHFcxSM2GnbEmja+3MHVnQ4/GLwybU=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr5661013qtn.18.1587395857124;
 Mon, 20 Apr 2020 08:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-2-robh@kernel.org>
In-Reply-To: <20200419170810.5738-2-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:17:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bjyBDHnOVv2NwFA_wZvtH6O8R9godAg8zE3HpFe75ww@mail.gmail.com>
Message-ID: <CAK8P3a2bjyBDHnOVv2NwFA_wZvtH6O8R9godAg8zE3HpFe75ww@mail.gmail.com>
Subject: Re: [PATCH 01/17] ARM: vexpress: Move vexpress_flags_set() into arch code
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
X-Provags-ID: V03:K1:2+L3TmmH6fDJ7kiV/Y6W/e2A8/uSLSXkD7MBhCL2H1Mwg9VVQh0
 73e4tK46L5RJ0KRLI+iuddNKnDCgYLPcWJ3bLNyXWOXBrfqXG9qpkJPVuhXo2kWgnoYzsoP
 4IJ+V+FO3GruezDGh/3zVFKxmD4RX+soMxxiN5XJz+qh6am6XMudT7OM/4NDha0c+3HS8Z2
 C/6hI/ZpvHrUFeSEXXmoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XVFbk9G7Osg=:hFWl265yAWdQLVm5oPqS3L
 pPNvXZp6nT9/KhSSp1gjOQy0QYbs+UcR0KZ/tnN9qcSMYCnPSbmWFmImwXlSDdDR7yiDVsszY
 1/VhHbL/FtOaYbWWnxBwMRQCK5coqyPN0sVbGJYN1b1Q5RM4TuCnHZVngyS7KmzCx6bWwipq5
 6IYBJcKoBLjr0QvWUVfCwfRLxmX5YwRguJDs2P1LwVQ2iniU+Ged++jYngvIcRRzeKRoCXiLy
 +xfd3R71xcuG5QID3UnVliCv4deBF976hIArZkrNrMH/2p/sClKtRQzEdghJVuY9e7xeDrUQK
 z+mkiEw49cZVyQC6X0tkx3bkrP5Kr9JTk4D+wNvlKiqhclESbVs0aULqpOBzbNbhf2MlO54od
 vn4I/+zWrdWdkeu1peYcmi4QLKw+UwOboNHJUpXmhXaR08ghlZ79f/Bu6MVAvbOH5AydaO91Q
 lOmBUYXQqOWBQDkUFW2F5iIXhFE4ZUwZ9GpFxDNgbpfvj84Vkk8+bxgxunxZL7nWohmiIHgbJ
 heI7jxdOrB/eqXqR0uM1w5VkbE8exOHFe4CCcKTPq9mrsBAGGBtMzHVa63cYDZUpsRyea6Eom
 LXc/qBtC/vn4gffOhXh+gbVOm43tcDJpLuG03Y4UnUhXbW/NMCNMvhZVK6ThPmj57wzv5qDZT
 Q4xS38+JCihPnIL/sgxXauiLP/ogOuIM7rURXwHeuOVgqUYMnTCZg+BzefWv8z+jxWE3vBhWg
 KNTCzAPczwXt4fXTdHS/C2G3WB/ljRPU/m0a0PvwLPKivLpa4KAVHPRR/yLQbV8jBSmB4EgTC
 LX4oae4xcuzmEG8jhcR+vogQy/CdIizHg5S4NOB3ijJB/f/U6Y=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> vexpress_flags_set() is only used by the platform SMP related code and
> has nothing to do with the vexpress-sysreg MFD driver other than both
> access the same h/w block. It's also only needed for 32-bit systems and
> must be built-in for them. Let's move vexpress_flags_set() closer to
> where it is being used. This will allow for vexpress-sysreg to be built
> as a module.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
