Return-Path: <linux-pm+bounces-7723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD38C26A8
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B202865C4
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DB171653;
	Fri, 10 May 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gJs39LlX"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70A170843;
	Fri, 10 May 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350846; cv=none; b=dtuHku4COO9nU8lPvPxY8S0seMceA4taunjToJlzVEG31oKv0I40Uuzzuvqv3pydzwVphE+L8TwL78bff1P/3zncxjLDkQLN3o++/lwOkdMA/djS/sfokLzUYnR+443GkP4ieWX12Bb8SvmcflGbo6JHWheIlMbL8dJD1vu665c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350846; c=relaxed/simple;
	bh=RsE8cY+fp2GsTqdqdSmy9XchkKlPuwqpX3nJ/Sby/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBqDkCdnPXEx5IL+U/5bHBJd/WtaejgKv8motTRKlU4Yncm8ToWPVP9GwDWJ+7RUmNi/eQJ4UOvA2BhuNgPp7PP/n/+KXqkdAbpnSgAWsej3EAdhXs3T4sJsSLQW/lpkMZyylIZXC/snz4JEf/pwoGSaljDE5LybVpkT9NyswGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gJs39LlX reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c0c6590cd904fc47; Fri, 10 May 2024 16:20:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2AC5C2102F3F;
	Fri, 10 May 2024 16:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350842;
	bh=RsE8cY+fp2GsTqdqdSmy9XchkKlPuwqpX3nJ/Sby/c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJs39LlX+gm5mot3VuKjk7JtsjYE7kKdUs3E/eX8Azo6uadQsN3/O6fT27anfIy57
	 NwJzpf5BqcuI/nYFGsiVv2JdM7KORjjekgdYcvjpksUAtDwOYfloIsbHtyAi9fOIyu
	 HI6/XSgCqJeCPA7gnWR7PNy2LtTNv3KMSBkv9DdOpHV6fzggSwA3nceMOZcJBS0w5M
	 QQf7PC5IRM0y8oJW0ajQ1w7CtgsnK25PtEP7ps60qVmV+tyAKw8YLEgnMbzYXqF/2D
	 udalKxaoUugRQPDQC/hxVz1bVGHIzbM4VziUWxjjK5s8+SMPRvo87cGsrRyyJWpK7T
	 vib2FzKSGb7og==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 1/6] thermal: sysfs: Trigger zone temperature updates on sysfs
 reads
Date: Fri, 10 May 2024 16:13:31 +0200
Message-ID: <3304112.44csPzL39Z@kreacher>
In-Reply-To: <13518388.uLZWGnKmhe@kreacher>
References: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reading the zone temperature via sysfs causes the driver callback to
be invoked, but it does not cause the thermal zone object to be updated.

This is problematic if the zone temperature read via sysfs differs from
the temperature value stored in the thermal zone object as it may cause
the kernel and user space to act against each other in some cases.

For this reason, make temp_show() trigger a zone temperature update if
the temperature returned by thermal_zone_get_temp() is different from
the temperature value stored in the thermal zone object.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c  |    2 +-
 drivers/thermal/thermal_sysfs.c |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -42,6 +42,9 @@ temp_show(struct device *dev, struct dev
 	if (ret)
 		return ret;
 
+	if (temperature != READ_ONCE(tz->temperature))
+		thermal_zone_device_update(tz, THERMAL_EVENT_TEMP_SAMPLE);
+
 	return sprintf(buf, "%d\n", temperature);
 }
 
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -429,7 +429,7 @@ static void update_temperature(struct th
 	}
 
 	tz->last_temperature = tz->temperature;
-	tz->temperature = temp;
+	WRITE_ONCE(tz->temperature, temp);
 
 	trace_thermal_temperature(tz);
 




