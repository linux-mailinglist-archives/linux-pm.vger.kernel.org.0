Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFD1B0FC4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDTPSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:18:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35553 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTPSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:18:20 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mgvan-1ijD55342f-00hQ2S; Mon, 20 Apr 2020 17:18:18 +0200
Received: by mail-qv1-f50.google.com with SMTP id di6so4823158qvb.10;
        Mon, 20 Apr 2020 08:18:18 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ38vsZJcpzp2kqobonx6eO7LSxqFiirw0T6Lj8YMJEjsjscdl0
        8BNpPc5OJ2p8R/2SU8dkZ+/TBZ2/tJL9uu7DoEc=
X-Google-Smtp-Source: APiQypIYLpHDVLIMUalFL+Ue1X763cp1SLfC0IW6vt53VSaaqpIHDwT5p5Bmw0zf4vcEQTX/oZGO/0S8b0BoM+G1Upw=
X-Received: by 2002:a0c:b78e:: with SMTP id l14mr15824930qve.4.1587395897579;
 Mon, 20 Apr 2020 08:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-3-robh@kernel.org>
In-Reply-To: <20200419170810.5738-3-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:18:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0NXDi-MmxP-FiBU3qGx1N_FkO7Bqc5QERFWX27Gv-YCg@mail.gmail.com>
Message-ID: <CAK8P3a0NXDi-MmxP-FiBU3qGx1N_FkO7Bqc5QERFWX27Gv-YCg@mail.gmail.com>
Subject: Re: [PATCH 02/17] arm64: vexpress: Don't select CONFIG_POWER_RESET_VEXPRESS
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
X-Provags-ID: V03:K1:Tp2LnLEhd4X2vqDV8HQtZFYFErMJ7R61I8pdcN8k2pcN+L88K1s
 jCC36jx9p5I+xp36lHn0I7oNfZuPn1d6CTpCNp1zB8Ni2RtpakLtez7xz58NOLrYxH9T5IR
 4ZtAPLDtXsnrU+vNt5GavPoCCC6JaA0GFpC2bBsrV60sYxsxjhUxDnyvfkTiv8IlSL9ErbO
 nRU3kv96RThIXRorkGm4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rqE7TDpNgas=:kflCzo0EgTKtHhr39IDREC
 tMf9ZknamJCAaxqu5EYG27Qy9I/cuhu9dkBN4cZ2L74S3pKjRxgINbOe8iBGEraFNynMc6+fs
 yDXUXriu2bKhO+4TOTV5VxIWGtVqVND2UC3PwVpSqH6cU3roegu41GvwXsUNgrZd1cVonYMzs
 0txmV9iP+RJFXnsZlrOHgyXW6NhpfZL1YNpgqlH7AiZjssIPU0RMOw2n7ECH0jb5I9/AuG5vD
 7Q86+K7itAB04sfnv0H4GDfTSSnrv4rVkwHbUdoUyJzTFw5g7L9bF+Fe1aSIcUWIRowsLKWrh
 wVwD97r1uUjZ2pF20434OWvu+qHd0UBGz5qxdB8QvOUI6pkrUDazKaPkHxn8eQwblhWcQZ+8W
 kBaCVDhahLKYHXPAolwWXiM8v3pGTB24F9c/o/lDsqhq4d4muhxRSO6ZVl52a4n0WMLdPqh2P
 wmy1QjzJxLpdkj3QHVLZUpwpZIFxxUHdL+F/JscP9W8Z87dpsvaEyGl3bY+0nBWpzVJIGsVDh
 giUNJ76pLRb7hrG78jZ9M/nTsRviazACENXrgKB6gV9jR3fM3iLYKAtSWmNArzYwhIoyYqcfs
 DRStUjV0s5rhYlQvikhf/s4Y1hlKFgqmMSoYfIjZiHEBOl7ZE1ng8gZyDVwg6zgwazKN5wvZm
 y0TNMpZFhue8xDF8GqBstZRDUnCMIzevydbGOJn9whkj+EEF+ci4ajO8oAyF4Ar7M8pVlVCwX
 3zZLbNsWoAZHq5LK23CgCkU22OXkTcXoHDo3tZPIXN9Y7LR4E3etV9GgFeqsZiozzvVK92Y9c
 toRutu4r/D7jMVYqMVUJbX+sFUTIve5I8LJZBan19QBhxGkU0c=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> The VExpress power-off/reset driver is not needed on 64-bit platforms as
> PSCI power-off and reset can be used instead. Stop selecting it so it
> can be disabled and not always built-in.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
