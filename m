Return-Path: <linux-pm+bounces-26150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53FA9B859
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 21:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F49C1BA72CE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FC28A1CA;
	Thu, 24 Apr 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vxY1Rxo7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA862853F3;
	Thu, 24 Apr 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523405; cv=none; b=eXqtEkewGtZTvRhLVXFoCSH99XIQLWBkggJNXHTHG3N2O1z/UYge3FsETc5PfK/kIhjawTxAUlClrhvDE8Dx9Xf/x4znZ0rxA7XavZ/40Pacca2v4Fdrk43KlJQz/EZea5M61Ao/oHZhfNsxLi/sduLpqLhKnVUgkeRzozoK5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523405; c=relaxed/simple;
	bh=eXnj+KAXnFSZnb5V3g6/iPdGT5cf4dZCvLTmLpj+qAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gc2Lz6u5A0aCg8KrSHLH7g0yYg5+rGAl/D3RPat6xDjBYLRdiTrmuH8pFxlN9HNmwP3c6tDxZPzlm3tQlepEJKU3Ww7DP8y+3/a6eoepsBoDVh+B5/xncHamduUj2bpSNnELyTRAwAdVDoOtj6dm9l9MYhyUkd8s1MWrsfByLg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vxY1Rxo7; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BDE55662FA9;
	Thu, 24 Apr 2025 21:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745523400;
	bh=eXnj+KAXnFSZnb5V3g6/iPdGT5cf4dZCvLTmLpj+qAI=;
	h=From:Subject:Date;
	b=vxY1Rxo7I5U0M7rWeqxALZYW/8DukLKZIwckqL1VgdrwjGo8baMBL6Nj3QbDBm3Nj
	 wUcCWByDoDyJU1N5H2RYisjFoI23zSb5cIsGQ8Oa8HQxjbiYi01RXDvAGup/CHT776
	 Fi+wSjkOzXQGuQKF6xF37wjZvTrL0kjQgZO98s7TbIqUF01/Fn48FhzeDBRgtjDnSl
	 V9ie9tQWJctZljhLv0X1jYWfSzMccK0ywivsN2G8JxhmL75dyyPM+o/HW44D/O3Gw7
	 x+oTqzEudQ5RRyANz6NeaSPZug14CEPVG6SpXs7ivI6dt+tscepcDBDl4pMQI9YYD8
	 V65gggjGxqc3w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 regressions@lists.linux.dev, Johan Hovold <johan@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject:
 Re: [PATCH v3] cpufreq: Avoid using inconsistent policy->min and policy->max
Date: Thu, 24 Apr 2025 21:36:39 +0200
Message-ID: <12665363.O9o76ZdvQC@rjwysocki.net>
In-Reply-To:
 <CAJZ5v0i7-LuBX5VCwn_LhyT=RkmQMn6qv3duc+RViXxJBwk2LA@mail.gmail.com>
References:
 <5907080.DvuYhMxLoT@rjwysocki.net> <aAplED3IA_J0eZN0@linaro.org>
 <CAJZ5v0i7-LuBX5VCwn_LhyT=RkmQMn6qv3duc+RViXxJBwk2LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehsthgvphhhrghnrdhgvghrhhholhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

On Thursday, April 24, 2025 6:37:46 PM CEST Rafael J. Wysocki wrote:
> Hi,
>=20
> On Thu, Apr 24, 2025 at 6:21=E2=80=AFPM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, Apr 16, 2025 at 04:12:37PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Since cpufreq_driver_resolve_freq() can run in parallel with
> > > cpufreq_set_policy() and there is no synchronization between them,
> > > the former may access policy->min and policy->max while the latter
> > > is updating them and it may see intermediate values of them due
> > > to the way the update is carried out.  Also the compiler is free
> > > to apply any optimizations it wants both to the stores in
> > > cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> > > which may result in additional inconsistencies.
> > >
> > > To address this, use WRITE_ONCE() when updating policy->min and
> > > policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> > > them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> > > in cpufreq_set_policy() to avoid storing intermediate values in
> > > policy->min and policy->max with the help of the observation that
> > > their new values are expected to be properly ordered upfront.
> > >
> > > Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> > > ordering of policy->min and policy->max, which may happen depending on
> > > the ordering of operations when this function and cpufreq_set_policy()
> > > run concurrently, into account by always honoring the max when it
> > > turns out to be less than the min (in case it comes from thermal
> > > throttling or similar).
> > >
> > > Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> > > Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > This replaces the last 3 patches in
> > >
> > > https://lore.kernel.org/linux-pm/6171293.lOV4Wx5bFT@rjwysocki.net/
> > >
> > > v2 -> v3:
> > >    * Fold 3 patches into one.
> > >    * Drop an unrelated white space fixup change.
> > >    * Fix a typo in a comment (Christian).
> > >
> > > v1 -> v2: Cosmetic changes
> > >
> > > ---
> > >  drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++++++++++-------
> > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > >
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -495,8 +495,6 @@
> > >  {
> > >       unsigned int idx;
> > >
> > > -     target_freq =3D clamp_val(target_freq, policy->min, policy->max=
);
> > > -
> > >       if (!policy->freq_table)
> > >               return target_freq;
> > >
> > > @@ -520,7 +518,22 @@
> > >  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *poli=
cy,
> > >                                        unsigned int target_freq)
> > >  {
> > > -     return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
> > > +     unsigned int min =3D READ_ONCE(policy->min);
> > > +     unsigned int max =3D READ_ONCE(policy->max);
> > > +
> > > +     /*
> > > +      * If this function runs in parallel with cpufreq_set_policy(),=
 it may
> > > +      * read policy->min before the update and policy->max after the=
 update
> > > +      * or the other way around, so there is no ordering guarantee.
> > > +      *
> > > +      * Resolve this by always honoring the max (in case it comes fr=
om
> > > +      * thermal throttling or similar).
> > > +      */
> > > +     if (unlikely(min > max))
> > > +             min =3D max;
> > > +
> > > +     return __resolve_freq(policy, clamp_val(target_freq, min, max),
> > > +                           CPUFREQ_RELATION_LE);
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> > >
> > > @@ -2338,6 +2351,7 @@
> > >       if (cpufreq_disabled())
> > >               return -ENODEV;
> > >
> > > +     target_freq =3D clamp_val(target_freq, policy->min, policy->max=
);
> > >       target_freq =3D __resolve_freq(policy, target_freq, relation);
> > >
> > >       pr_debug("target for CPU %u: %u kHz, relation %u, requested %u =
kHz\n",
> > > @@ -2631,11 +2645,15 @@
> > >        * Resolve policy min/max to available frequencies. It ensures
> > >        * no frequency resolution will neither overshoot the requested=
 maximum
> > >        * nor undershoot the requested minimum.
> > > +      *
> > > +      * Avoid storing intermediate values in policy->max or policy->=
min and
> > > +      * compiler optimizations around them because they may be acces=
sed
> > > +      * concurrently by cpufreq_driver_resolve_freq() during the upd=
ate.
> > >        */
> > > -     policy->min =3D new_data.min;
> > > -     policy->max =3D new_data.max;
> > > -     policy->min =3D __resolve_freq(policy, policy->min, CPUFREQ_REL=
ATION_L);
> > > -     policy->max =3D __resolve_freq(policy, policy->max, CPUFREQ_REL=
ATION_H);
> > > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CP=
UFREQ_RELATION_H));
> > > +     new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ_R=
ELATION_L);
> > > +     WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->ma=
x : new_data.min);
> >
> > I've tested the cpufreq throttling again in 6.15-rc3 to check your fix
> > for the schedutil CPUFREQ_NEED_UPDATE_LIMITS regression I reported [1].
> > The CPU frequency is now being throttled correctly when reaching high
> > temperatures. Thanks for fixing this!
> >
> > Unfortunately, the opposite case has now regressed with this patch:
> > After the CPU frequency has been throttled due to high temperature and
> > the device cools down again, the CPU frequency is stuck at minimum until
> > you reboot. policy->max will never restore to the maximum frequency.
> >
> > I've confirmed that this causes unexpected slowness after temperature
> > throttling on a Qualcomm X1E laptop, and Johan has confirmed that e.g.
> > the ThinkPad X13s is also affected. I would expect that most devices
> > using cpufreq cooling in the kernel are affected.
> >
> > Looking at the code, I think the problem is that __resolve_freq() ->
> > cpufreq_frequency_table_target() -> cpufreq_table_find_index*() and
> > cpufreq_is_in_limits() are still using the old policy->min/max value.
> > In this patch, you have only moved the clamp_val() usage directly in
> > __resolve_freq().
>=20
> You are right, that's the problem.
>=20
> The fix is basically straightforward, pass min and max to
> cpufreq_frequency_table_target() and propagate downward, but making
> that change may be somewhat error-prone.
>=20
> I'll try to cut a patch to test tomorrow.

Actually, I have it already, so please find appended.

Please give it a go as soon as you reasonably can.

Thanks!

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] cpufreq: Fix setting policy limits when frequency table=
s are used

Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
policy->max") overlooked the fact that policy->min and policy->max were
accessed directly in cpufreq_frequency_table_target() and in the
functions called by it and the changes made by that commit led to
problems with setting policy limits.

Address this by passing the target frequency limits to __resolve_freq()
and cpufreq_frequency_table_target() and propagating them to the
functions called by the latter.

=46ixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and p=
olicy->max")
Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/cpufreq/cpufreq.c          |   22 ++++++----
 drivers/cpufreq/cpufreq_ondemand.c |    3 -
 drivers/cpufreq/freq_table.c       |    6 +-
 include/linux/cpufreq.h            |   81 ++++++++++++++++++++++++--------=
=2D----
 4 files changed, 72 insertions(+), 40 deletions(-)

=2D-- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -491,14 +491,18 @@
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
=20
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
=2D		unsigned int target_freq, unsigned int relation)
+				   unsigned int target_freq,
+				   unsigned int min, unsigned int max,
+				   unsigned int relation)
 {
 	unsigned int idx;
=20
 	if (!policy->freq_table)
 		return target_freq;
=20
=2D	idx =3D cpufreq_frequency_table_target(policy, target_freq, relation);
+	target_freq =3D clamp_val(target_freq, min, max);
+
+	idx =3D cpufreq_frequency_table_target(policy, target_freq, min, max, rel=
ation);
 	policy->cached_resolved_idx =3D idx;
 	policy->cached_target_freq =3D target_freq;
 	return policy->freq_table[idx].frequency;
@@ -532,8 +536,7 @@
 	if (unlikely(min > max))
 		min =3D max;
=20
=2D	return __resolve_freq(policy, clamp_val(target_freq, min, max),
=2D			      CPUFREQ_RELATION_LE);
+	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
=20
@@ -2351,8 +2354,8 @@
 	if (cpufreq_disabled())
 		return -ENODEV;
=20
=2D	target_freq =3D clamp_val(target_freq, policy->min, policy->max);
=2D	target_freq =3D __resolve_freq(policy, target_freq, relation);
+	target_freq =3D __resolve_freq(policy, target_freq, policy->min,
+				     policy->max, relation);
=20
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2650,8 +2653,11 @@
 	 * compiler optimizations around them because they may be accessed
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
=2D	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RE=
LATION_H));
=2D	new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_=
L);
+	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
+					       new_data.min, new_data.max,
+					       CPUFREQ_RELATION_H));
+	new_data.min =3D __resolve_freq(policy, new_data.min, new_data.min,
+				      new_data.max, CPUFREQ_RELATION_L);
 	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_da=
ta.min);
=20
 	trace_cpu_frequency_limits(policy);
=2D-- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -76,7 +76,8 @@
 		return freq_next;
 	}
=20
=2D	index =3D cpufreq_frequency_table_target(policy, freq_next, relation);
+	index =3D cpufreq_frequency_table_target(policy, freq_next, policy->min,
+					       policy->max, relation);
 	freq_req =3D freq_table[index].frequency;
 	freq_reduc =3D freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg =3D freq_req - freq_reduc;
=2D-- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -115,8 +115,8 @@
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
=20
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
=2D				 unsigned int target_freq,
=2D				 unsigned int relation)
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation)
 {
 	struct cpufreq_frequency_table optimal =3D {
 		.driver_data =3D ~0,
@@ -147,7 +147,7 @@
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq =3D pos->frequency;
=20
=2D		if ((freq < policy->min) || (freq > policy->max))
+		if (freq < min || freq > max)
 			continue;
 		if (freq =3D=3D target_freq) {
 			optimal.driver_data =3D i;
=2D-- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -788,8 +788,8 @@
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *pol=
icy);
=20
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
=2D				 unsigned int target_freq,
=2D				 unsigned int relation);
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
=20
@@ -852,12 +852,12 @@
 	return best;
 }
=20
=2D/* Works only on sorted freq-tables */
=2Dstatic inline int cpufreq_table_find_index_l(struct cpufreq_policy *poli=
cy,
=2D					     unsigned int target_freq,
=2D					     bool efficiencies)
+static inline int find_index_l(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
=2D	target_freq =3D clamp_val(target_freq, policy->min, policy->max);
+	target_freq =3D clamp_val(target_freq, min, max);
=20
 	if (policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_al(policy, target_freq,
@@ -867,6 +867,14 @@
 						   efficiencies);
 }
=20
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_l(policy, target_freq, policy->min, policy->max, effici=
encies);
+}
+
 /* Find highest freq at or below target in a table in ascending order */
 static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *polic=
y,
 					      unsigned int target_freq,
@@ -920,12 +928,12 @@
 	return best;
 }
=20
=2D/* Works only on sorted freq-tables */
=2Dstatic inline int cpufreq_table_find_index_h(struct cpufreq_policy *poli=
cy,
=2D					     unsigned int target_freq,
=2D					     bool efficiencies)
+static inline int find_index_h(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
=2D	target_freq =3D clamp_val(target_freq, policy->min, policy->max);
+	target_freq =3D clamp_val(target_freq, min, max);
=20
 	if (policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ah(policy, target_freq,
@@ -935,6 +943,14 @@
 						   efficiencies);
 }
=20
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_h(policy, target_freq, policy->min, policy->max, effici=
encies);
+}
+
 /* Find closest freq to target in a table in ascending order */
 static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *polic=
y,
 					      unsigned int target_freq,
@@ -1005,12 +1021,12 @@
 	return best;
 }
=20
=2D/* Works only on sorted freq-tables */
=2Dstatic inline int cpufreq_table_find_index_c(struct cpufreq_policy *poli=
cy,
=2D					     unsigned int target_freq,
=2D					     bool efficiencies)
+static inline int find_index_c(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
=2D	target_freq =3D clamp_val(target_freq, policy->min, policy->max);
+	target_freq =3D clamp_val(target_freq, min, max);
=20
 	if (policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ac(policy, target_freq,
@@ -1020,7 +1036,17 @@
 						   efficiencies);
 }
=20
=2Dstatic inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, i=
nt idx)
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_c(policy, target_freq, policy->min, policy->max, effici=
encies);
+}
+
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
+					unsigned int min, unsigned int max,
+					int idx)
 {
 	unsigned int freq;
=20
@@ -1029,11 +1055,13 @@
=20
 	freq =3D policy->freq_table[idx].frequency;
=20
=2D	return freq =3D=3D clamp_val(freq, policy->min, policy->max);
+	return freq =3D=3D clamp_val(freq, min, max);
 }
=20
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *po=
licy,
 						 unsigned int target_freq,
+						 unsigned int min,
+						 unsigned int max,
 						 unsigned int relation)
 {
 	bool efficiencies =3D policy->efficiencies_available &&
@@ -1044,21 +1072,18 @@
 	relation &=3D ~CPUFREQ_RELATION_E;
=20
 	if (unlikely(policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_UNSORTED))
=2D		return cpufreq_table_index_unsorted(policy, target_freq,
=2D						    relation);
+		return cpufreq_table_index_unsorted(policy, target_freq, min,
+						    max, relation);
 retry:
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
=2D		idx =3D cpufreq_table_find_index_l(policy, target_freq,
=2D						 efficiencies);
+		idx =3D find_index_l(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_H:
=2D		idx =3D cpufreq_table_find_index_h(policy, target_freq,
=2D						 efficiencies);
+		idx =3D find_index_h(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_C:
=2D		idx =3D cpufreq_table_find_index_c(policy, target_freq,
=2D						 efficiencies);
+		idx =3D find_index_c(policy, target_freq, min, max, efficiencies);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -1066,7 +1091,7 @@
 	}
=20
 	/* Limit frequency index to honor policy->min/max */
=2D	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
+	if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
 		efficiencies =3D false;
 		goto retry;
 	}




