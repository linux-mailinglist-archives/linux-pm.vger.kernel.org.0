Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE681B1031
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDTPcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:32:04 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDTPcD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:32:03 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mrwnt-1iuIhr0h4H-00nvVg; Mon, 20 Apr 2020 17:32:02 +0200
Received: by mail-qk1-f179.google.com with SMTP id v7so11056711qkc.0;
        Mon, 20 Apr 2020 08:32:01 -0700 (PDT)
X-Gm-Message-State: AGi0Pua+Sbjzm0thY+o7fUntTF8W24BCNGRpIcWUBkapo0SsPKP1cq26
        CJcZvhWSQEp2hvEmdBCkfORIefnbPQTnwa6gAtI=
X-Google-Smtp-Source: APiQypKss06g58JOx2CAuoSVyQnWDrXkNWtjIKGx96inYGqheqlBCcxiPw404obxJ+1ETrjvTEtREO95m0t3bnuLKQE=
X-Received: by 2002:a37:63d0:: with SMTP id x199mr16115619qkb.3.1587396720972;
 Mon, 20 Apr 2020 08:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-12-robh@kernel.org>
In-Reply-To: <20200419170810.5738-12-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:31:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VeKhe7J_p+UaYPcpVsYA3Wv3KyGnPWBf2mgbtAHHuZw@mail.gmail.com>
Message-ID: <CAK8P3a0VeKhe7J_p+UaYPcpVsYA3Wv3KyGnPWBf2mgbtAHHuZw@mail.gmail.com>
Subject: Re: [PATCH 11/17] mfd: vexpress-sysreg: Use devres API variants
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
X-Provags-ID: V03:K1:zt1av8uYvJWZLjk/j5TV6kN332shp+ND+9BQzIU/XlSF7smmKuP
 V1c1bah5fx9M+TkSWf6EVE/tSKb9hZyb4P0IJHFTzvlaOacA3dqn3cK4umT/Yk9YUvzc9Mh
 hU8GhyCfGtA8d+y2rTG3yKNvTG5fKjyxVCY7UbmM9KanfxbfwAaB60gk9pP60YRJELYP3qD
 I5igVy5ZhucdjlMFd/HBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uUEsrTcd+7U=:5n9kDl7og2BZR9CS0g6vux
 fgQvIf1Fkp1XNfsNMX3cKpWSav1rA6sa4sULbYKv8XYyT5BwZydXTsaxO3NU/L/vHGUQ6X/TD
 dO/pVfgXm/IfvyxZ1X8QyrshaPNsVYYVs4zExNoeHiJvv7F8N8S36wxPCSTTHV3VNuMq3vMlp
 Ql1nFrvhYS0iwLQR4kPAxtaTFZH5iI7irgJjU5sCc+Y2zaMaWfdzwhd9sae6f9iIvCf1vuZ/i
 /O04QuGxUFGe1mM4GZMKmezDpqXN4S/HiX15S3mwSAJrG6YaW9PCx+wsunyhGsXVGF2Jzx+TE
 3wBFDphfjs871Dejb4OlOc23jjJkHSajtjpdhszfKrjHV0PbDTPDgLSMmnmXk2jjpBpmevtMJ
 xdHL9NKZuZ07qPLDVwp+y8tfNWzJ8TNYWgVaLVIcxanbJpw69DpFsQI+7EgY8dSHPrg/WLieL
 3yAqwszC6ElvBcesf3t60LLgw6pwasQX0TceFbU19iTADZb2SUbcMkS6BuxKGhdhJqezjmav1
 cLBOImFC4bS7g5vOHB9swkYiOn6XVWrbHQu8Yf2JKjipLfougbSUqN4Ydo0gkUKTQmSWl++Av
 7fOfnhOyZzLuG8/i0YSqsWsNjep80I54mpKYNfL0Dk+tG4MK32QRvTewX42w+rrR8UxRfI1E+
 gnb3Tr9yqsOHZBqcMTqkMA2HsRLBajmI98tpc2+BvJDMXWELAKQHiSkmce1+pe3nS+pAppPfJ
 54jCo50aJmaJG2uT0EAKJpLFeUYA/95x2K/qYJSV50EHzpPNQYM3Rk8olNDhJ/y7kBH4XNc2T
 0NCr5B/rtH834zVeUM8Ak63kcy3ipmvMe7tKSYMyBlOKlQAE7E=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Use the managed devm_gpiochip_add_data() and devm_mfd_add_devices()
> instead of their unmanaged counterparts. With this, no .remove() hook is
> needed for driver unbind.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
