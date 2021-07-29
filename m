Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47D3DA8A5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhG2QO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 12:14:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49238 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhG2QO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 12:14:59 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id a6e25b56ef76a7db; Thu, 29 Jul 2021 18:14:54 +0200
Received: from kreacher.localnet (89-64-80-223.dynamic.chello.pl [89.64.80.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 185AC669F29;
        Thu, 29 Jul 2021 18:14:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Subject: Re: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
Date:   Thu, 29 Jul 2021 18:14:53 +0200
Message-ID: <4334837.LvFx2qVVIh@kreacher>
In-Reply-To: <CAAYoRsVko5jG=xqH=KTochqQu95i7PDo_6f1LCPGvAP0=XdVTA@mail.gmail.com>
References: <1867445.PYKUYFuaPT@kreacher> <2178828.iZASKD2KPV@kreacher> <CAAYoRsVko5jG=xqH=KTochqQu95i7PDo_6f1LCPGvAP0=XdVTA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.223
X-CLIENT-HOSTNAME: 89-64-80-223.dynamic.chello.pl
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrheefgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddrvddvfeenucfuphgrmhfkphepkeelrdeigedrkedtrddvvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddvvdefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepughsmhihthhhihgvshesthgvlhhushdrnhgvthdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, July 29, 2021 8:34:37 AM CEST Doug Smythies wrote:
> On Wed, Jul 28, 2021 at 10:47 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, July 28, 2021 3:52:51 PM CEST Rafael J. Wysocki wrote:
> > > On Tue, Jul 27, 2021 at 10:06 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > Further to my reply of 2021.07.04  on this, I have
> > > > continued to work with and test this patch set.
> > > >
> > > > On 2021.06.02 11:14 Rafael J. Wysocki wrote:
> > > >
> > > > >This series of patches addresses some theoretical shortcoming in the
> > > > > TEO (Timer Events Oriented) cpuidle governor by reworking its idle
> > > > > state selection logic to some extent.
> > > > >
> > > > > Patches [1-2/5] are introductory cleanups and the substantial changes are
> > > > > made in patches [3-4/5] (please refer to the changelogs of these two
> > > > > patches for details).  The last patch only deals with documentation.
> > > > >
> > > > > Even though this work is mostly based on theoretical considerations, it
> > > > > shows a measurable reduction of the number of cases in which the shallowest
> > > > > idle state is selected while it would be more beneficial to select a deeper
> > > > > one or the deepest idle state is selected while it would be more beneficial to
> > > > > select a shallower one, which should be a noticeable improvement.
> > > >
> > > > I am concentrating in the idle state 0 and 1 area.
> > > > When I disable idle state 0, the expectation is its
> > > > usage will fall to idle state 1. It doesn't.
> > > >
> > > > Conditions:
> > > > CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> > > > HWP: disabled
> > > > CPU frequency scaling driver: intel_pstate, active
> > > > CPU frequency scaling governor: performance.
> > > > Idle configuration: As a COMETLAKE processor, with 4 idle states.
> > > > Sample time for below: 1 minute.
> > > > Workflow: Cross core named pipe token passing, 12 threads.
> > > >
> > > > Kernel 5.14-rc3: idle: teo governor
> > > >
> > > > All idle states enabled: PASS
> > > > Processor: 97 watts
> > > > Idle state 0 entries: 811151
> > > > Idle state 1 entries: 140300776
> > > > Idle state 2 entries: 889
> > > > Idle state 3 entries: 8
> > > >
> > > > Idle state 0 disabled: FAIL <<<<<
> > > > Processor: 96 watts
> > > > Idle state 0 entries: 0
> > > > Idle state 1 entries: 65599283
> > > > Idle state 2 entries: 364399
> > > > Idle state 3 entries: 65112651
> > >
> > > This looks odd.
> > >
> > > Thanks for the report, I'll take a look at this.
> >
> > I have found an issue in the code that may be responsible for the
> > observed behavior and should be addressed by the appended patch (not
> > tested yet).
> >
> > Basically, the "disabled" check in the second loop over states in
> > teo_select() needs to exclude the first enabled state, because
> > there are no more states to check after that.
> >
> > Plus the time span check needs to be done when the given state
> > is about to be selected, because otherwise the function may end up
> > returning a state for which the sums are too low.
> >
> > Thanks!
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |   26 ++++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/teo.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> > +++ linux-pm/drivers/cpuidle/governors/teo.c
> > @@ -404,25 +404,27 @@ static int teo_select(struct cpuidle_dri
> >                         intercept_sum += bin->intercepts;
> >                         recent_sum += bin->recent;
> >
> > -                       if (dev->states_usage[i].disable)
> > +                       if (dev->states_usage[i].disable && i > idx0)
> >                                 continue;
> >
> >                         span_ns = teo_middle_of_bin(i, drv);
> > -                       if (!teo_time_ok(span_ns)) {
> > -                               /*
> > -                                * The current state is too shallow, so select
> > -                                * the first enabled deeper state.
> > -                                */
> > -                               duration_ns = last_enabled_span_ns;
> > -                               idx = last_enabled_idx;
> > -                               break;
> > -                       }
> >
> >                         if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
> >                             (!alt_intercepts ||
> >                              2 * intercept_sum > idx_intercept_sum)) {
> > -                               idx = i;
> > -                               duration_ns = span_ns;
> > +                               if (!teo_time_ok(span_ns) ||
> > +                                   dev->states_usage[i].disable) {
> > +                                       /*
> > +                                        * The current state is too shallow or
> > +                                        * disabled, so select the first enabled
> > +                                        * deeper state.
> > +                                        */
> > +                                       duration_ns = last_enabled_span_ns;
> > +                                       idx = last_enabled_idx;
> > +                               } else {
> > +                                       idx = i;
> > +                                       duration_ns = span_ns;
> > +                               }
> >                                 break;
> >                         }
> 
> Hi Rafael,

Hi Doug,

Thanks for the feedback, much appreciated!

> I tried the patch and when I disabled idle state 0
> got, very similar to before:
> 
> Idle state 0 disabled: FAIL
> Processor: 95 watts
> Idle state 0 entries: 0
> Idle state 1 entries: 65,475,534
> Idle state 2 entries: 333144
> Idle state 3 entries: 65,247,048
> 
> However, I accidently left it for about 30 minutes
> and noticed:
> 
> Idle state 0 disabled:
> Processor: 83 watts
> Idle state 0 entries: 0
> Idle state 1 entries: 88,706,831
> Idle state 2 entries: 100
> Idle state 3 entries: 662

This means that idle state 0 data are disregarded after disabling it
and that most likely is because the second loop in teo_select() should
be over all states down to idle state 0 (not only down to the first
enabled one).

So below is an updated patch (not tested yet).

---
 drivers/cpuidle/governors/teo.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -397,32 +397,34 @@ static int teo_select(struct cpuidle_dri
 		intercept_sum = 0;
 		recent_sum = 0;
 
-		for (i = idx - 1; i >= idx0; i--) {
+		for (i = idx - 1; i >= 0; i--) {
 			struct teo_bin *bin = &cpu_data->state_bins[i];
 			s64 span_ns;
 
 			intercept_sum += bin->intercepts;
 			recent_sum += bin->recent;
 
-			if (dev->states_usage[i].disable)
+			if (dev->states_usage[i].disable && i > 0)
 				continue;
 
 			span_ns = teo_middle_of_bin(i, drv);
-			if (!teo_time_ok(span_ns)) {
-				/*
-				 * The current state is too shallow, so select
-				 * the first enabled deeper state.
-				 */
-				duration_ns = last_enabled_span_ns;
-				idx = last_enabled_idx;
-				break;
-			}
 
 			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
 			    (!alt_intercepts ||
 			     2 * intercept_sum > idx_intercept_sum)) {
-				idx = i;
-				duration_ns = span_ns;
+				if (!teo_time_ok(span_ns) ||
+				    dev->states_usage[i].disable) {
+					/*
+					 * The current state is too shallow or
+					 * disabled, so select the first enabled
+					 * deeper state.
+					 */
+					duration_ns = last_enabled_span_ns;
+					idx = last_enabled_idx;
+				} else {
+					idx = i;
+					duration_ns = span_ns;
+				}
 				break;
 			}
 



