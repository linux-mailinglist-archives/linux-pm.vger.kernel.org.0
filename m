Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B663499CF
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYS4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 14:56:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47470 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCYS4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 14:56:15 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id ecdf7dd5ee01525c; Thu, 25 Mar 2021 19:56:13 +0100
Received: from kreacher.localnet (89-64-80-106.dynamic.chello.pl [89.64.80.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 282A4669104;
        Thu, 25 Mar 2021 19:56:12 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length() from returning negative value
Date:   Thu, 25 Mar 2021 19:56:11 +0100
Message-ID: <5712356.lOV4Wx5bFT@kreacher>
In-Reply-To: <20210325131400.GA938586@lothringen>
References: <20210311123708.23501-1-frederic@kernel.org> <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM> <20210325131400.GA938586@lothringen>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudehtddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddruddtiedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgidvtddulegtfihmsehsthhfgidrtggrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlrdhjrdifhihsohgtkhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghp
 thhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohephigvhihunhhfvghngheshhhurgifvghirdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhtohhsrghtthhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=13 Fuz1=13 Fuz2=13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, March 25, 2021 2:14:00 PM CET Frederic Weisbecker wrote:
> On Tue, Mar 16, 2021 at 04:08:08PM +0000, Zhou Ti (x2019cwm) wrote:
> > But I don't think it's a good idea to handle this in callers, because logically the function shouldn't return negative values. Returning 0 directly would allow idle governors to get another chance to select again.
> 
> Hmm, I'm going to leave the last word to Rafael since cpuidle are the only
> callers of this. In any case we need to fix it.

Yes, we do.

So I said that I preferred to address this in the callers and the reason why
is because, for example, for the teo governor it would be a matter of using
a different data type to store the tick_nohz_get_sleep_length() return value,
like in the (untested) patch below.

So at least in this case there is no need to add any new branches anywhere.

I'm still not sure about menu, because it is more complicated, but even if
that one needs an extra branch, that is a win already.

---
 drivers/cpuidle/governors/teo.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -100,8 +100,8 @@ struct teo_idle_state {
  * @intervals: Saved idle duration values.
  */
 struct teo_cpu {
-	u64 time_span_ns;
-	u64 sleep_length_ns;
+	s64 time_span_ns;
+	s64 sleep_length_ns;
 	struct teo_idle_state states[CPUIDLE_STATE_MAX];
 	int interval_idx;
 	u64 intervals[INTERVALS];
@@ -216,7 +216,7 @@ static bool teo_time_ok(u64 interval_ns)
  */
 static int teo_find_shallower_state(struct cpuidle_driver *drv,
 				    struct cpuidle_device *dev, int state_idx,
-				    u64 duration_ns)
+				    s64 duration_ns)
 {
 	int i;
 
@@ -242,7 +242,7 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
-	u64 duration_ns;
+	s64 duration_ns;
 	unsigned int hits, misses, early_hits;
 	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;



