Return-Path: <linux-pm+bounces-20227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE70A0926B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AED2164373
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D920E015;
	Fri, 10 Jan 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="IIxwpPwG"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232220E703;
	Fri, 10 Jan 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516808; cv=none; b=i/IUOZePEjWw9ZGoVUoIVxFTNo/x3+bBKKSyoEydWJY+3nAIVAlmhIgrxNVSfyAxTd7fS1WVdICqyPV82M9oiN97rnTmXAlVDDYjya1cKFX3PgD7sSH54oJ7SMUO3oztLr6qZli72mqrDyGlydyaOM1Q8ThGuEC+FGTBR87PcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516808; c=relaxed/simple;
	bh=uW/ugZM0hITtzeLLS0Jw26EUUNfhmarB6omouNNWEds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VLtlzMNx/vVpVuHvb58aw1FSyRLwDM3Na/NSiti/Md4y6ZzO4kg8B/yTm2Hp8gZ7z6rpp/+Q5LuyXyMvK7jtVYTZ3cwI5iCU8BMxCCu21e9fkTfcY9KukC66nRBhyDRQCvgCuCa2GP/bf1Dt3LClbBWnkPA7+aO1Hsi8xVGBpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=IIxwpPwG; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4b01693e2680a597; Fri, 10 Jan 2025 13:46:44 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9E7F58E05BB;
	Fri, 10 Jan 2025 13:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736513204;
	bh=uW/ugZM0hITtzeLLS0Jw26EUUNfhmarB6omouNNWEds=;
	h=From:Subject:Date;
	b=IIxwpPwGqZ1zW7iYYsnjWVxTR6ly/a6o9xinz712/IR4xMhrH6oJpxDuWZv8XUhC/
	 zswM73rQKHejdd6wxPOYL32cHSq6li6aoG+6EvJK+q4K09TM/Se6FLTPqFdUJKxIZf
	 UnIIVzQ4KQ/UI4esSX2LlaBB6CPiYMLRI4r3r+iwpke8/hnZraKG0Z/3VHFV9WB2F3
	 FIiBlp6OcnOEOGAFFYR+ju/nsPVUdKOZyWUqY660qWeI7WBAOINV6hWhqyTY2tHP7k
	 a0tI1gK7rxCMyqxANx0R6GoO9axwDqGGwc0wiYF83dD/PTcVkC8PlFO17jPt3ix/Sx
	 Dbhq1eflKB28g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v1] cpuidle: menu: Update documentation after previous changes
Date: Fri, 10 Jan 2025 13:46:43 +0100
Message-ID: <12589281.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghrthgvmhdrsghithihuhhtshhkihihsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") and
other previous changes, the description of the menu governor in the
documentation does not match the code any more, so update it as
appropriate.

Fixes: 38f83090f515 ("cpuidle: menu: Remove iowait influence")
Fixes: 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst |   72 +++++++++++++------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -269,27 +269,7 @@
 the CPU will ask the processor hardware to enter), it attempts to predict the
 idle duration and uses the predicted value for idle state selection.
 
-It first obtains the time until the closest timer event with the assumption
-that the scheduler tick will be stopped.  That time, referred to as the *sleep
-length* in what follows, is the upper bound on the time before the next CPU
-wakeup.  It is used to determine the sleep length range, which in turn is needed
-to get the sleep length correction factor.
-
-The ``menu`` governor maintains two arrays of sleep length correction factors.
-One of them is used when tasks previously running on the given CPU are waiting
-for some I/O operations to complete and the other one is used when that is not
-the case.  Each array contains several correction factor values that correspond
-to different sleep length ranges organized so that each range represented in the
-array is approximately 10 times wider than the previous one.
-
-The correction factor for the given sleep length range (determined before
-selecting the idle state for the CPU) is updated after the CPU has been woken
-up and the closer the sleep length is to the observed idle duration, the closer
-to 1 the correction factor becomes (it must fall between 0 and 1 inclusive).
-The sleep length is multiplied by the correction factor for the range that it
-falls into to obtain the first approximation of the predicted idle duration.
-
-Next, the governor uses a simple pattern recognition algorithm to refine its
+It first uses a simple pattern recognition algorithm to obtain a preliminary
 idle duration prediction.  Namely, it saves the last 8 observed idle duration
 values and, when predicting the idle duration next time, it computes the average
 and variance of them.  If the variance is small (smaller than 400 square
@@ -301,29 +281,39 @@
 taken as the "typical interval" value and so on, until either the "typical
 interval" is determined or too many data points are disregarded, in which case
 the "typical interval" is assumed to equal "infinity" (the maximum unsigned
-integer value).  The "typical interval" computed this way is compared with the
-sleep length multiplied by the correction factor and the minimum of the two is
-taken as the predicted idle duration.
-
-Then, the governor computes an extra latency limit to help "interactive"
-workloads.  It uses the observation that if the exit latency of the selected
-idle state is comparable with the predicted idle duration, the total time spent
-in that state probably will be very short and the amount of energy to save by
-entering it will be relatively small, so likely it is better to avoid the
-overhead related to entering that state and exiting it.  Thus selecting a
-shallower state is likely to be a better option then.   The first approximation
-of the extra latency limit is the predicted idle duration itself which
-additionally is divided by a value depending on the number of tasks that
-previously ran on the given CPU and now they are waiting for I/O operations to
-complete.  The result of that division is compared with the latency limit coming
-from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
-framework and the minimum of the two is taken as the limit for the idle states'
-exit latency.
+integer value).
+
+If the "typical interval" computed this way is long enough, the governor obtains
+the time until the closest timer event with the assumption that the scheduler
+tick will be stopped.  That time, referred to as the *sleep length* in what follows,
+is the upper bound on the time before the next CPU wakeup.  It is used to determine
+the sleep length range, which in turn is needed to get the sleep length correction
+factor.
+
+The ``menu`` governor maintains an array containing several correction factor
+values that correspond to different sleep length ranges organized so that each
+range represented in the array is approximately 10 times wider than the previous
+one.
+
+The correction factor for the given sleep length range (determined before
+selecting the idle state for the CPU) is updated after the CPU has been woken
+up and the closer the sleep length is to the observed idle duration, the closer
+to 1 the correction factor becomes (it must fall between 0 and 1 inclusive).
+The sleep length is multiplied by the correction factor for the range that it
+falls into to obtain an approximation of the predicted idle duration that is
+compared to the "typical interval" determined previously and the minimum of
+the two is taken as the idle duration prediction.
+
+If the "typical interval" value is small, which means that the CPU is likely
+to be woken up soon enough, the sleep length computation is skipped as it may
+be costly and the idle duration is simply predicted to equal the "typical
+interval" value.
 
 Now, the governor is ready to walk the list of idle states and choose one of
 them.  For this purpose, it compares the target residency of each state with
-the predicted idle duration and the exit latency of it with the computed latency
-limit.  It selects the state with the target residency closest to the predicted
+the predicted idle duration and the exit latency of it with the with the latency
+limit coming from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
+framework.  It selects the state with the target residency closest to the predicted
 idle duration, but still below it, and exit latency that does not exceed the
 limit.
 




