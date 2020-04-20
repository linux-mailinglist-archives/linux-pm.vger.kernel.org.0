Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1CB1B1038
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgDTPcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:32:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDTPcf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:32:35 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKbXu-1jenVc2lZc-00KzPH; Mon, 20 Apr 2020 17:32:32 +0200
Received: by mail-qk1-f177.google.com with SMTP id 20so10966769qkl.10;
        Mon, 20 Apr 2020 08:32:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuZzKJZx5TUAXtVjzVIHfHDHAkzOgGby7jsFStrGdfJVyelJ9yDn
        krqYZuwtbPKps75j8gNIJlzMTHJKEJnrbwXbi6w=
X-Google-Smtp-Source: APiQypKsf/Hx11xL620kC/5u0IK+jaiJ9QMyBbO11T3fK9/yTcQO5zVm2KODcJguNDK4FKGUi7pp/GdcXdzmK3UiSdA=
X-Received: by 2002:a37:ba47:: with SMTP id k68mr16851450qkf.394.1587396751408;
 Mon, 20 Apr 2020 08:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-13-robh@kernel.org>
In-Reply-To: <20200419170810.5738-13-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:32:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+o=DQNJ8UTJzq1ugm12RTfyaUwYx=KW6Xx6uWE2zOOw@mail.gmail.com>
Message-ID: <CAK8P3a2+o=DQNJ8UTJzq1ugm12RTfyaUwYx=KW6Xx6uWE2zOOw@mail.gmail.com>
Subject: Re: [PATCH 12/17] mfd: vexpress-sysreg: Support building as a module
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
X-Provags-ID: V03:K1:qy1QX3kS57KI3Nikyt9zCKU14owQpJaLBWCFRTQeSNJipz3OotF
 ZgBvrd8JYP8M7uNtvvcU1r9aub0ioXxovy0y9IcySFvkvBmBIloBNcmgzM8S/iT65Il5Oyb
 NRos8r38ZbYbOgRna909nneCo8JBxOvMf8Ag3Kw4DNawLnhfTe7AxLjRO4n53GPC1XyFFl8
 5eFNram3vONJq3wiSVkfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eiSP8PzxZFY=:eEtHIvo2boq4B7B0P+fLsh
 GdVbOpKRxZmBpMoQlkseR+RD2J/BegJp4pmFQ1sdAQiS2GlrgggFNzneKLRtEqEqPxC27Cb3f
 I1ThWpyeK7qMNy/+rkJpiVbUXJq0R6V8hvrhmQoPy7wK9LwNB8/73Sja4KcSp4XyuueMnU4V1
 qb23ev6hDdks8Z2AUWhn79kd7FDDP+AAzueJN/LNj/X3T+CZxKUXHAJR/74F+lmpB31hlIsV0
 RoVLKkCjEDcM2lKeKox2fWNP7u8J8l+Pe9sASvmrDAbAv8/zrYDVM6gVRx3hOEWjdJAV1ihnK
 pEY5nmTdVnVo6CiQ1SyIGHsFlMwG2SbiQBaNsp71eCwZikV6zoJDY6fZoRtc9JBvv+RdXwVT3
 6DmftP5EJjpZgUYllhMifeTXT9NuNn5DaogavXDmXbVARDD7UNI/w5AORa3yR/5b307s9L+iD
 wJvaiirGTcVIySb2tzJmrKIfSN5dDnOwuryMPYZCpRsx5CRB6bqiBDp4LOKeeIe63dpeyTgX3
 QRggHbiU1mEySrmy+6Jqn+vMi1U3xlYTJtvZjJvvj1RonyG8/M26gePT0Q0v1Iu7tAcOo936Q
 vZvlidEexQ9AYNUg/PBmSl4dx0Xax/QlZA6czqbUlVk49P7qVU9kVvbwne+7ee89qYppiB8UM
 MMSZJoP36Bm4B7S4r8x80e19bgjqVFqIfewapOEyKjFC5aK4cH4jfRXMiKtqUbNkXrdWbqE4p
 Sw09//znDAG8LYMkZ3BbFuM7Rez8+CGKnlk11rsVsO5Zq20uVWU34O7Hoq5+T+3BdASs2XtF2
 u9gW4EKBcTM+Fy6xsERVBskLJ83KaPjYGodN35Xo0cXo33qY4g=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Enable building the vexpress-sysreg driver as a module.

> -
> -       /* Need the sysreg early, before any other device... */
> -       for_each_matching_node(node, vexpress_sysreg_match)
> -               of_platform_device_create(node, NULL, NULL);

Is this safe to remove? If yes, please mention it in the changelog.

      Arnd
