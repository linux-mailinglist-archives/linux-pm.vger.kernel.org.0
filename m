Return-Path: <linux-pm+bounces-23998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32EA602BA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C449420E30
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC851F4E30;
	Thu, 13 Mar 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cVJXQdAL"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9231F462E;
	Thu, 13 Mar 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898134; cv=none; b=utBtBTP7yWWhI05Rgv34Pfpha91ZYIAzyQBQS6+t7krgxCmcCCkLPzBJHskcgs4MrgFrkec/IAatC5BVTBEEZZqfzVoCxkewiiMhbCX1FXaiI8FC771z3mFT6pQwglDIMfuI1fY9OD2Oht4hfe3gzYo6iaDiWKoBXa9/ZuZojhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898134; c=relaxed/simple;
	bh=n2GShKglS+Ia1CAmYp1RdUj7x9QJWvg9K2CEAXic+iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jat6voJXlZ0prr1BSVy0O6GKytBA+YpPINOqg3ySamkgni3h9aqLQb3k+1TWsqZfRZhjj/Xwk2xIsKfpB5bpJcq4l6jlxb39IVFNgF6mN/z64qePmR431Q5BSeJ8eFLjNc761FfVEP5zo8TnAL2zSP7xhu6WScRwfAGmUtKjq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cVJXQdAL; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 3181bb750b2b3b3b; Thu, 13 Mar 2025 21:35:30 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D68F98E4517;
	Thu, 13 Mar 2025 21:35:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741898130;
	bh=n2GShKglS+Ia1CAmYp1RdUj7x9QJWvg9K2CEAXic+iE=;
	h=From:Subject:Date;
	b=cVJXQdALAXAqDFijkpIvw9bXjdoP8o9ncl/yoUnDJE5zz2mSGVDNrtSjnCGQu6oOt
	 s/rqQWMCO3ryRw0cKa9tDQfCi4hpMfOyvLSt/EkQIxFtwBVxFj0k7foEFsfwIgpbgZ
	 S2gyDFbf0rRqgooNI2b2q9X8yOKChIUyXiZZ2osF8PAdVfkODE2fkyZswaubVXivuP
	 tChgTvEh/ssEIQVjQ43BeN5iDUsmmwSas8VLCaWG1hdBNPx5g4TvZDB9Y5edhVRP8k
	 psonGHHKqFs6Rx7dGrifDeCJ9LVgSS30fqT6a548JYYHa5zjbMJMyODyb7ejrEDrIM
	 aX1GDajjXj5fg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v2 0/3] PM: sleep: Improvements of async suspend and resume of devices
Date: Thu, 13 Mar 2025 21:17:27 +0100
Message-ID: <1915694.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

Hi Everyone,

This is a new iteration of the async suspend/resume improvements work:

https://lore.kernel.org/linux-pm/13709135.uLZWGnKmhe@rjwysocki.net/

which includes some rework and fixes of the last 3 patches in the series
linked above.  The first 2 patches in that series have been applied
already and are waiting for the 6.15 merge window.

This new iteration is based on linux-pm.git/linux-next and on the recent
fix related to direct-complete:

https://lore.kernel.org/linux-pm/12627587.O9o76ZdvQC@rjwysocki.net/

The following part of the original cover letter is still applicable:

"Overall, the idea is that instead of starting an async work item for every
async device upfront, which is not very efficient because the majority of
those devices will not be able to make progress due to dependencies anyway,
the async handling is only started upfront for the devices that are likely
to be able to make progress.  That is, devices without parents in the resume
path and leaf devices (ie. devices without children or consumers) in the
suspend path (the underlying observation here is that devices without parents
are likely to have no suppliers too whereas devices without children that
have consumers are not unheard of).  This allows to reduce the amount of
processing that needs to be done to start with.

Then, after processing every device ("async" or "sync"), "async" processing
is started for some devices that have been "unblocked" by it, which are its
children in the resume path or its parent and its suppliers in the suspend
path.  This allows asynchronous handling to start as soon as it makes sense
without delaying the "async" devices unnecessarily.

Fortunately, the additional plumbing needed to implement this is not
particularly complicated."

Patch [1/3] deals with the resume path for all device resume phases.  Since
v1 it's been modified to avoid using dpm_list_mtx for protecting the
power.work_in_progress flag and a new lock is used specifically for that
now which should reduce lock contention.

Patch [2/3] optimizes the "suspend" phase which has the most visible effect (on
the systems in my office the speedup is in the 100 ms range which is around 20%
of the total device resume time).  Since v1 it's been adjusted to the changes
in patch [1/3] and two issues in it have been fixed: dpm_async_suspend_superior()
actually walks the device's suppliers and all devices are moved to the target
list in dpm_suspend() even if there is an error so that they can be resumed
properly in that case.

Patch [3/3] extend this to the "suspend late" and "suspend noirq" phases.

Thanks!






