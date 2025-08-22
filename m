Return-Path: <linux-pm+bounces-32882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E658EB30E4E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EEA5E04A6
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA7296BC6;
	Fri, 22 Aug 2025 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ESe3/dus"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59940284B25
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842042; cv=none; b=AM6USk9ojgn5xsBk4CQZIG9DIRzNUm6iRmV+5n9m4E1zxz7pLsDU+v7xo5NzAf8WD5ponDSDpeH+lPVwJyqbyRIIyRGXKYLb2vAAWwlQFDuzhvp7RuoZP9Z9+MSvVVMdXG3ct6++hiv7WlN3sUP/v4/bIBZUAVCCkL9k9pd4wck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842042; c=relaxed/simple;
	bh=pbC0zznHXkbEt+YEqvwTQLLxgdvA33OzMMpfI+ESG9s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=APDXW7r4te04Ztjt6+sTaJmbTitEgSt1j8uFeaToM4q1gHu7xs+nycYfJXyhLRF2LfErCDcjhdG4w4IVAV80p37w03L9Vg9pSuArzmvWz34ij44CFZCWaQI6fVnzRkZwtz5CI1SVDkHhTer/y8MrqL0J5/hBMzfxWMcaZ4gZINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ESe3/dus; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.55.29] (ip174-65-98-148.sd.sd.cox.net [174.65.98.148])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4c7Ts21XJGz4cTg;
	Fri, 22 Aug 2025 01:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1755842038; bh=pbC0zznHXkbEt+YEqvwTQLLxgdvA33OzMMpfI+ESG9s=;
	h=Date:To:From:Subject;
	b=ESe3/dusPSca7ikkq4lIbsH9BH4yk8S3RoEIwr42+FoMMwL0rosA2qBrsxbo1HfT2
	 r2YH1NHsNhSDY/wMoUN+9RXKQM9dIqAoKY9cUE8n47riCyzFeRTmCMHXG8WRn7ftI9
	 y9ozvSjxtEz84LNgC9iuroJ1cKMaWwVFB1hgIPlE=
Message-ID: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
Date: Thu, 21 Aug 2025 22:53:56 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lukasz.luba@arm.com, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
From: Kenneth Crudup <kenny@panix.com>
Subject: I think there's an issue with e3f1164fc9e ("PM: EM: Support late CPUs
 booting and capacity adjustment") if there's "holes" in your CPU topology
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


So I'm testing the "Energy Model" CPU scheduler, which means I need to 
set "nosmt"; this means I've got "holes" in my CPUs:

----
$  ls /dev/cpu | sort -n
0
2
4
6
8
10
12
13
14
15
16
17
18
19
----

So in .../kernel/power/energy_model.c , when this line gets to a CPU 
"hole", it throws an error and breaks out of the loop:

----
	   policy = cpufreq_cpu_get(cpu);
            if (!policy) {
                        pr_debug("Accessing cpu%d policy failed\n", cpu);
                        schedule_delayed_work(&em_update_work,
                                               msecs_to_jiffies(1000));
                        break;
            }
----

... but I'm thinking (and its working here for me) that a simple 
"continue" for those three lines handles the "CPU hole" case:

----
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index ea7995a25780..df6cae6f8845 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -795,12 +795,9 @@ static void em_check_capacity_update(void)
                         continue;

                 policy = cpufreq_cpu_get(cpu);
-               if (!policy) {
-                       pr_debug("Accessing cpu%d policy failed\n", cpu);
-                       schedule_delayed_work(&em_update_work,
-                                             msecs_to_jiffies(1000));
-                       break;
-               }
+               if (!policy)
+                       continue;
+
                 cpufreq_cpu_put(policy);

                 dev = get_cpu_device(cpu);
----

Thoughts?

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


