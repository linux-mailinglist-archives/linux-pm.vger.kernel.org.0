Return-Path: <linux-pm+bounces-20974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6151DA1D6FC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 14:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B088D3A3774
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84A1FFC45;
	Mon, 27 Jan 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="b2fYOm5w"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E11FF601;
	Mon, 27 Jan 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985120; cv=none; b=VUbq9MVtJYuOKSGA8phqyHj61KQ8viy+FdMzyPPXoniZ+mfFf8cmv+nyRIlE1PjCadEj6QA1lU8FoCLmsSJ/unhayhd8k3oBa1SQBGGyhcwcFNbG2B5SWaP/RWzkm4bQO9Zt9JKiXQSkGT67q2/gxLpBEphkZfFLERkVHSQFWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985120; c=relaxed/simple;
	bh=Mxq9kTfxl4QM1Wo0Veln6ypKNUU9RWmOXaODD7Zn9Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWmTEWa2fCQTez8KUB6mUFBQMlJyMGF5A3nkWUWrvJZ7j71h9o8DwNptPPuIAzcjZ37Uy3JjwoAtRKmwT/kIReVaJZZ7Okw43zBTTf8gm/7Dm03QpjYICe06W80MLTXLYA/AqvuMESioi2Jz+gCo4ZbfoVSbf8eDTyeCjl2WZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=b2fYOm5w; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d27bca23f75ecda4; Mon, 27 Jan 2025 14:38:35 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5466B7524A5;
	Mon, 27 Jan 2025 14:38:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737985115;
	bh=Mxq9kTfxl4QM1Wo0Veln6ypKNUU9RWmOXaODD7Zn9Jk=;
	h=From:Subject:Date;
	b=b2fYOm5wGR2l0mFGFDiqsJLrNjgOAGwry3fp+Wx2PAeUEJirQloXfGpwSLmNmPFpU
	 FY7cfso80tKLKAnlw1WyTtvAB6uXIAHp/Rsb1yMjae1s+fgAoquUHoiEJuilg4l6X+
	 tsT1uUqI0WaekonjqMkdjsoHc9WPzW6hsPew4x+OwmYtdJ+tRG0qnh3u7iFO2JJ6zH
	 tT3Wl1rBdgz7aHarFj+j6SU+ZkvC3yj0mWS3KTt9gKagkqEJBgVEadkA16MwmSh11W
	 0P4MQsugdSnddJXVmrpmRAWr2S8rGseRK6vWKrtwzXdVpp6W9zlvo4Tg0GAy0lYq5f
	 qRQBC40sUUBRw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1 1/2] PM: EM: Drop unused parameter from em_adjust_new_capacity()
Date: Mon, 27 Jan 2025 14:37:29 +0100
Message-ID: <2369979.ElGaqSPkdT@rjwysocki.net>
In-Reply-To: <6137833.lOV4Wx5bFT@rjwysocki.net>
References: <6137833.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudeffeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhmpdhrtghpthhtoheprhhitggrrhguohdrnhgvrhhiqdgtrghluggvrhhonheslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The max_cap parameter is never used in em_adjust_new_capacity(), so
drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/energy_model.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -728,8 +728,7 @@
  * are correctly calculated.
  */
 static void em_adjust_new_capacity(struct device *dev,
-				   struct em_perf_domain *pd,
-				   u64 max_cap)
+				   struct em_perf_domain *pd)
 {
 	struct em_perf_table __rcu *em_table;
 
@@ -800,7 +799,7 @@
 			 cpu, cpu_capacity, em_max_perf);
 
 		dev = get_cpu_device(cpu);
-		em_adjust_new_capacity(dev, pd, cpu_capacity);
+		em_adjust_new_capacity(dev, pd);
 	}
 
 	free_cpumask_var(cpu_done_mask);




