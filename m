Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274CB427B70
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhJIPoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 11:44:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61308 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhJIPox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 11:44:53 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 5a75a4ada7a1e827; Sat, 9 Oct 2021 17:42:55 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3D480661ECD;
        Sat,  9 Oct 2021 17:42:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Maulik Shah <mkshah@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Subject: Re: [PATCH 1/2] cpuidle: Avoid calls to cpuidle_resume|pause() for s2idle
Date:   Sat, 09 Oct 2021 17:42:53 +0200
Message-ID: <4665489.GXAFRqVoOG@kreacher>
In-Reply-To: <CAPDyKFpJqnoG5HGwGoMvBBXBCBt=eTqMcdX_A29eY05LLgLi3w@mail.gmail.com>
References: <20210929144451.113334-1-ulf.hansson@linaro.org> <07e6821c-c221-e90d-c977-4d6b55c1ab8d@codeaurora.org> <CAPDyKFpJqnoG5HGwGoMvBBXBCBt=eTqMcdX_A29eY05LLgLi3w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrjeejrdehuddrkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdejjedrhedurdekgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehmkhhshhgrhhestghouggvrghurhhorhgrrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
 ohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhinhgtvghnthdrghhuihhtthhotheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopegsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlshhrrghosegtohguvggruhhrohhrrgdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 6, 2021 3:10:55 PM CEST Ulf Hansson wrote:
> On Wed, 6 Oct 2021 at 12:22, Maulik Shah <mkshah@codeaurora.org> wrote:
> >
> > Hi,
> >
> > On 9/29/2021 8:14 PM, Ulf Hansson wrote:
> > > In s2idle_enter(), cpuidle_resume|pause() are invoked to re-allow calls to
> > > the cpuidle callbacks during s2idle operations. This is needed because
> > > cpuidle is paused in-between in dpm_suspend_noirq() and dpm_resume_noirq().
> > >
> > > However, calling cpuidle_resume|pause() from s2idle_enter() looks a bit
> > > superfluous, as it also causes all CPUs to be waken up when the first CPU
> > > wakes up from s2idle.
> >
> > Thanks for the patch. This can be good optimization to avoid waking up
> > all CPUs always.
> >
> > >
> > > Therefore, let's drop the calls to cpuidle_resume|pause() from
> > > s2idle_enter(). To make this work, let's also adopt the path in the
> > > cpuidle_idle_call() to allow cpuidle callbacks to be invoked for s2idle,
> > > even if cpuidle has been paused.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >   drivers/cpuidle/cpuidle.c |  7 ++++++-
> > >   include/linux/cpuidle.h   |  2 ++
> > >   kernel/power/suspend.c    |  2 --
> > >   kernel/sched/idle.c       | 40 ++++++++++++++++++++++-----------------
> > >   4 files changed, 31 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > index ef2ea1b12cd8..c76747e497e7 100644
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c
> > > @@ -49,7 +49,12 @@ void disable_cpuidle(void)
> > >   bool cpuidle_not_available(struct cpuidle_driver *drv,
> > >                          struct cpuidle_device *dev)
> > >   {
> > > -     return off || !initialized || !drv || !dev || !dev->enabled;
> > > +     return off || !drv || !dev || !dev->enabled;
> > > +}
> > > +
> > > +bool cpuidle_paused(void)
> > > +{
> > > +     return !initialized;
> > >   }
> > >
> > >   /**
> > > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > > index fce476275e16..51698b385ab5 100644
> > > --- a/include/linux/cpuidle.h
> > > +++ b/include/linux/cpuidle.h
> > > @@ -165,6 +165,7 @@ extern void cpuidle_pause_and_lock(void);
> > >   extern void cpuidle_resume_and_unlock(void);
> > >   extern void cpuidle_pause(void);
> > >   extern void cpuidle_resume(void);
> > > +extern bool cpuidle_paused(void);
> > >   extern int cpuidle_enable_device(struct cpuidle_device *dev);
> > >   extern void cpuidle_disable_device(struct cpuidle_device *dev);
> > >   extern int cpuidle_play_dead(void);
> > > @@ -204,6 +205,7 @@ static inline void cpuidle_pause_and_lock(void) { }
> > >   static inline void cpuidle_resume_and_unlock(void) { }
> > >   static inline void cpuidle_pause(void) { }
> > >   static inline void cpuidle_resume(void) { }
> > > +static inline bool cpuidle_paused(void) {return true; }
> > >   static inline int cpuidle_enable_device(struct cpuidle_device *dev)
> > >   {return -ENODEV; }
> > >   static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
> > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > index eb75f394a059..388a5de4836e 100644
> > > --- a/kernel/power/suspend.c
> > > +++ b/kernel/power/suspend.c
> > > @@ -97,7 +97,6 @@ static void s2idle_enter(void)
> > >       raw_spin_unlock_irq(&s2idle_lock);
> > >
> > >       cpus_read_lock();
> > > -     cpuidle_resume();
> > >
> > >       /* Push all the CPUs into the idle loop. */
> > >       wake_up_all_idle_cpus();
> >
> > wake_up_all_idle_cpus() will still cause all CPUs to be woken up when
> > first cpu wakes up.
> >
> > say for example,
> > 1. device goes to s2idle suspend.
> > 2. one CPU wakes up to handle irq (irq is not a wake irq but left
> > enabled at GIC because of IRQF_NOSUSPEND flag) so such irq will not
> > break suspend.
> > 3. The cpu handles the irq.
> > 4. same cpu don't break s2idle_loop() and goes to s2idle_enter() where
> > it wakes up all existing idle cpus due to wake_up_all_idle_cpus()
> > 5. all of CPUs again enter s2idle.
> >
> > to avoid waking up all CPUs in above case, something like below snip may
> > help (i have not tested yet),
> >
> > when CPUs are in s2idle_loop(),
> >
> > 1. set the s2idle state to enter.
> > 2. wake up all cpus from shallow state, so that they can re-enter
> > deepest state.
> > 3. Forever loop until a break with some wake irq.
> > 4. clear the s2idle state.
> > 5. wake up all cpus from deepest state so that they can now stay in
> > shallow state/running state.
> >
> > void s2idle_loop(void)
> > {
> >
> > +       s2idle_state = S2IDLE_STATE_ENTER;
> > +       /* Push all the CPUs to enter deepest available state */
> > +       wake_up_all_idle_cpus();
> >          for (;;) {
> >                  if (s2idle_ops && s2idle_ops->wake) {
> >                          if (s2idle_ops->wake())

So generally you don't know what will break loose in the ->wake() callback
and so you don't know what idle states the CPUs will end up in before
s2idle_enter().

You could optimize for the case when ->wake() is not present, though.

> >                                 ..
> >                  s2idle_enter();
> >          }
> > +       s2idle_state = S2IDLE_STATE_NONE;
> > +       /* Push all the CPUs to enter default_idle() from this point */
> > +       wake_up_all_idle_cpus();
> > }



