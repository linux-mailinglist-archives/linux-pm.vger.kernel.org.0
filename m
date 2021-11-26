Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75A045F3A3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhKZSXY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 13:23:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43886 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhKZSVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 13:21:23 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 45918bb20015dcf0; Fri, 26 Nov 2021 19:18:08 +0100
Received: from kreacher.localnet (unknown [213.134.181.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E003F66ABF7;
        Fri, 26 Nov 2021 19:18:07 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
Date:   Fri, 26 Nov 2021 19:18:06 +0100
Message-ID: <2105700.irdbgypaU6@kreacher>
In-Reply-To: <acb3ac6c-d6e6-c3f7-6b04-12d3a1fbf0a1@linaro.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org> <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com> <acb3ac6c-d6e6-c3f7-6b04-12d3a1fbf0a1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.132
X-CLIENT-HOSTNAME: 213.134.181.132
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrhedvgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukedurddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddrudefvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegushhmhihthhhivghssehtvghluhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
 gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, November 26, 2021 6:43:24 PM CET Daniel Lezcano wrote:
> On 26/11/2021 18:21, Rafael J. Wysocki wrote:
> > Hi Doug,
> > 
> > On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
> >>
> >> Hi Daniel,
> >>
> >> This patch introduces a regression, at least on my test system.
> >> I can no longer change CPU frequency scaling drivers, for example
> >> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
> >> (A.K.A. active mode). The task just hangs forever.
> >>
> >> I bisected the kernel and got this commit as the result.
> >> As a double check, I reverted this commit:
> >> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
> >> on kernel 5.16-rc2 and the issue was resolved.
> >>
> >> While your email is fairly old, I observe that it was only included as of
> >> kernel 5.16-rc1.
> >>
> >> Command Example that never completes:
> >>
> >> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
> >>
> >> syslog excerpt attached.
> > 
> > This looks like it may be problematic:
> > 
> > diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> > index f6076de39540..98841524a782 100644
> > --- a/drivers/powercap/dtpm_cpu.c
> > +++ b/drivers/powercap/dtpm_cpu.c
> > @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> >        return ret;
> > }
> > 
> > -int dtpm_register_cpu(struct dtpm *parent)
> > +static int __init dtpm_cpu_init(void)
> > {
> >        int ret;
> > 
> > so please try to remove the __init annotation from dtpm_cpu_init() and
> > see if that helps.
> 
> Yes, actually that should be called only if it is configured properly.

What do you mean?

> The dtpm_cpu just initializes itself unconditionally, I did not figured
> out there is the usually allyesconfig used by default by the distros.

Well, it is.

> That should be fixed with a proper DT configuration [1]
> 
> [1]
> https://lore.kernel.org/all/20211124125506.2971069-3-daniel.lezcano@linaro.org/

No, we are talking about systems without any DT at all here.



