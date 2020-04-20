Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894C31B1027
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgDTPac (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:30:32 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTPab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:30:31 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTiHb-1jnMCG42hR-00U4J1; Mon, 20 Apr 2020 17:30:30 +0200
Received: by mail-qt1-f174.google.com with SMTP id x2so8818605qtr.0;
        Mon, 20 Apr 2020 08:30:29 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ40VgoHUTBlpxLLuSE2A/7ziRB2wyjRRcQO6SIeo+/qoNi9cNZ
        kbS1sBGX7BBZNjlmsggp8KTlMduRjEVFH6UkzGY=
X-Google-Smtp-Source: APiQypLhLzIsRYWGfF98DBq4uKZzSzPJN8MMOTvy5MVhjl3hGP85aC/0o1FORjrYoWyWldZp7YYnG/7IW5g/n71Fn60=
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr16681150qtj.7.1587396628774;
 Mon, 20 Apr 2020 08:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-11-robh@kernel.org>
In-Reply-To: <20200419170810.5738-11-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:30:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yPiSEBA_bjy2EAcRygp0MqtTgt8Tu-JNJrx6Bb_Ff0A@mail.gmail.com>
Message-ID: <CAK8P3a1yPiSEBA_bjy2EAcRygp0MqtTgt8Tu-JNJrx6Bb_Ff0A@mail.gmail.com>
Subject: Re: [PATCH 10/17] mfd: vexpress-sysreg: Drop unused syscon child devices
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
X-Provags-ID: V03:K1:U3ia42+8D9VdLdRYEoWAj3mkxdMr64og7S7/6hCavBP4Gt/btKu
 Nlre9aVQ6BzaaTy91D6CrRNLI8eFdVfGxpiyjMSKKxU1ZeTfUf5v4cXnCxz/CX5qnI6lPwM
 YMYqcidj41qZ/dozslguipKWnXYwsHj/AP0k1A/9Hy9oB50Z7WjP8uBvzQVAgLGQiWmfhZp
 IxzJ3j1B4yEJ7xc2OL4Gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mDbQBQOuMvA=:HRKpxf58zlW7L9awzwtLrT
 lSLfEwDeFkWMXWNc1z9P2MQRHV+X/K3JqE5gwSm8wynPeqbOPq9VCmK9w9dzfYQiXGbv+O5K3
 NUhz/guUzpyPIl9m2elkMDPBcmmPB2P8dbnBpF/L10K/arVc4eKvVp3ZeBqQiJZjabBfyE47p
 1CJ9vbjIXa+rj+lvEM1H+e9Ddv8u6X0iM5Z3R82s98JRDS29ATZkj+ziFLFc2m/nOarvk1S47
 O/I6UoljZzLdoblbrcr2Dj1J/CuZYThtv25AWj+4PN927AZZdo8fWGL/ehGNDiG4P2+fulhg1
 WBWqk+JSU6E4PuOcF9pF2Pl9NpktWhfBlSnW/PSs9pKphJGn2Z5IauOR7f8DVY4xWGpfd/IMC
 mc7rKaxvB+BXcc1xGZSlbr6QNi4o1HNpJQkUA/KYxR+/wWxxNWZfRKz2KXt9q0iS44lqsAQJC
 D1RF8GOs3H3/YFHUB5Tk2zYEpT6DlRLcApC/HxQ5AqWnvBoPCd8lMPOz6ZrUFd+UeFOpLfQST
 mNDxQIEhJRRB8F+MwcD4yWl3vKB78806TGUSn+QAA9F9o+yKnQeMYxVNJJHcx/Dte0aj6y4Pi
 M6CIuC34YcWbl5Xk6/INh54p8PM1t53lVWviK1vTCmtHZW/9QmX3bLM5IW874yAL+NlSRr0Sg
 FrAqKDykNv37azktMtPJ7jyMb19bZoewRIjEtJjHqm3NSzDaa+6j2uq7PjECS6tI2dFKcMXNA
 sryjKcQOX1/V+0RXIEsC4qGlAqslM2HcWMmFqnDuPy+bxUN3c6GXjZUChwI4Q1LEIbBNIMi1C
 MZ6tH/DVpDpsl9xrt44vdvqU7apg+pgnS8tVunOPryUlsItMPs=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

No description? It would be nice to know why it was added in the first place,
or at least that you were unsuccessful in finding out why.

       Arnd
