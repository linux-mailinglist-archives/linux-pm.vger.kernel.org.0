Return-Path: <linux-pm+bounces-26754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27AEAACEFD
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B86982652
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1771FF61E;
	Tue,  6 May 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="o8ZiNbMj"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC21EB5DD;
	Tue,  6 May 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564587; cv=none; b=RcfdfIUgH+Zv/WsULU/7ncKolSV+3rOVemQaxOwUqGrc7G5zdM8n6BPpAKBAE7eWvRp+xCIpc8JV3uYAsXrvFlH/4GTwJCUtTbNy0ZqJjitmeOUwRdOVWUY4FqVht0/yOY8e+gukl5OG90Ram6qZhFwmwqvBLdFaHOvaigvgHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564587; c=relaxed/simple;
	bh=3ifhBa8IsbFHOoBX5X+2uisAdJUzd51bhh3lYFD8pJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JblbrVMRDy8yfIH4B6OCRp+wRmNlInHm6c8xfO+3dVE0dW3ijtto3IJBnYWm+zSFQEBTZjExQQBE87cRBnihc0DY7KXpDCBYcE/70HM1vWulQtDv0kD7lRPLj7N9NbGkrKBTB8EAlEi/j27rDwsjH2K08f5OQor3aVnLHPW7iB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=o8ZiNbMj; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 26541666BB5;
	Tue,  6 May 2025 22:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564578;
	bh=3ifhBa8IsbFHOoBX5X+2uisAdJUzd51bhh3lYFD8pJo=;
	h=From:Subject:Date;
	b=o8ZiNbMjd2E/slvetW65vMCFZpkGwqOyrGH5a//PblFJiZ537EZtZZUGe/u2RGjZM
	 ey1JoaC+viV+QoHlmdKI5/dojbiWBMxqlzuED699t2qDrpnLTV+c8y+9pUt5WFi2gc
	 MjCCkHPQKGOPBvkJzfhS9FAZA9z8FwzajbKdtOaiQFnI/Lbs1DIFddDKVvcw7oIP4J
	 bk80rvpFJh1gGyEYsiWjv9eKE+f3uOnTtNiYoaTEbuSXLGci3Vgj7mPFY3VrKfsQ+h
	 pzYBYuF4+Y3p7hV9fB71yFAyeEaB/pvZXqbepwG1+8b5l7dSMt16dqrVF6wIHNetLn
	 CVcmgpQvRf72g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v2 0/7] cpufreq: intel_pstate: Enable EAS on hybrid platforms without
 SMT
Date: Tue, 06 May 2025 22:32:47 +0200
Message-ID: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

Hi Everyone,

This is a new (and most likely final) version of

https://lore.kernel.org/linux-pm/3344336.aeNJFYEL58@rjwysocki.net/

The most significant difference between it and the above is that schedutil is
now required for EAS to be enabled, like on the other platforms using EAS,
which means that intel_pstate needs to operate in the passive mode in order
to use it (the most straightforward way to switch it over to the passive mode
is to write "passive" to /sys/devices/system/cpu/intel_pstate/status).

Accordingly, the changes that were needed for EAS to work without schedutil are
not needed any more, so there is one patch less in the series because of that
and patch [5/7] is simpler than its previous version because some changes made
by it are not necessary any more.

Another patch that has been dropped is

https://lore.kernel.org/linux-pm/1964444.taCxCBeP46@rjwysocki.net/

because it didn't take CPU online into account properly and it is not essential
for the current hardware anyway.

There is a new patch, [7/7], which adds CAS/EAS/hybrid support description to
the intel_pstate admin-guide documentation.

The following paragraph from the original cover letter still applies:

"The underlying observation is that on the platforms targeted by these changes,
Lunar Lake at the time of this writing, the "small" CPUs (E-cores), when run at
the same performance level, are always more energy-efficient than the "big" or
"performance" CPUs (P-cores).  This means that, regardless of the scale-
invariant utilization of a task, as long as there is enough spare capacity on
E-cores, the relative cost of running it there is always lower."

The first 2 patches depend on the current cpufreq material queued up for 6.16
in linux-pm.git/linux-next (and in linux-next proper) and are not really
depended on by the rest of the series, but I've decided to include them into
this series because they have been slightly updated since the previous version,
mostly to take review feedback into account (I'm going to queue them up for
6.16 shortly because they don't appear to be objectionable).

The next 2 patches (Energy Model code changes) were reviewed previously, but
they are only needed because of patch [5/7].

Patch [5/7] has not changed much except that some changes made by the previous
version have been dropped from it.  Also its changelog has been updated.  It
causes perf domains to be registered per CPU and in addition to the primary cost
component, which is related to the CPU type, there is a small component
proportional to performance whose role is to help balance the load between CPUs
of the same type.

The expected effect is still that the CPUs of the "low-cost" type will be
preferred so long as there is enough spare capacity on any of them.

Patch [6/7] has been updated to walk all of the cache leaves and look for
the ones with level equal to 3 because the check used in the previous version
does not always work.

The documentation patch, [7/7], is new.

Please refer to the individual patch changelogs for details.

Thanks!




