Return-Path: <linux-pm+bounces-31777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BBB19051
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 00:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9783A69AE
	for <lists+linux-pm@lfdr.de>; Sat,  2 Aug 2025 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE3427466C;
	Sat,  2 Aug 2025 22:21:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BA2CCDB
	for <linux-pm@vger.kernel.org>; Sat,  2 Aug 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.16.16.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754173313; cv=none; b=Vvu80NUmr8BTD4ahxm1g23ekQJdGb4kbD3SFOHznSoG7AWIWEfPrifxqsR+KIUvK4CSSSTbukVdGJx7a90FJq6azpeFVSSq/JhI5N3iBARpCbCzpGuFFJsLSzZvUbBKx1DVQSHa9TDyqXm4Q4MAl6p6YbAgFVaQ+fUQvRT5Mb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754173313; c=relaxed/simple;
	bh=BxVXvebcsUFX2WcpsYUfIk9WfQ3Jx85290p+XNIfvB4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oeJJJzbe+l8DHFA3AlQ5SJ4nAoLbZM9M4+ZZx8F++xky4ejSq4D3rJyAz5BcxjTdhc6d5nfyHgHLEHf8iwKpYhJrPpKttwtKIjwnee7WQvyNJ8stNJ81g7igV75ghtidkYSkXsgc7fDZczCx6LSw7FsZWB4FIafk08tDbwqm9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar; spf=pass smtp.mailfrom=grulic.org.ar; arc=none smtp.client-ip=200.16.16.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grulic.org.ar
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
	by pd.grulic.org.ar (Postfix) with ESMTPSA id 533C280371
	for <linux-pm@vger.kernel.org>; Sat,  2 Aug 2025 19:23:38 -0300 (-03)
Date: Sun, 3 Aug 2025 00:21:35 +0200
From: Marcos Dione <mdione@grulic.org.ar>
To: linux-pm@vger.kernel.org
Subject: [Possible bug]: thermal and an scaling governor issues
Message-ID: <aI6Pb99qXaSaB-Fy@ioniq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


    Before anything, please CC: me, as I'm not subscribed to the list.

    Right now I'm running 6.12.38+deb13-amd64 from Debian
testing/unstable, which are the same due to the freeze until next week :)

    It all seems to have started at the beginning of the year. The
symptom was hiccups which could be seen as high load (f.i. 40 on an 8
core machine) with not much CPU usage. I tracked it down to
prometheus-node-exporter stalling on disk accesses. Looking with strace
I find there were multisecond reads on files related to sensonrs in
general, which I still experience:

23:30:13.855780 (+     0.004490) openat(AT_FDCWD, "/sys/class/hwmon/hwmon1/in0_input", O_RDONLY) = 3 <0.000152>
23:30:13.856286 (+     0.000494) fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0 <0.000052>
23:30:13.856574 (+     0.000286) read(3, "12686\n", 4096) = 6 <3.196855>
23:30:17.053632 (+     3.197072) close(3) = 0 <0.000061>

23:33:39.689505 (+     0.000167) openat(AT_FDCWD, "/sys/class/hwmon/hwmon5/fan1_input", O_RDONLY) = 3 <0.000081>
23:33:39.689708 (+     0.000201) fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0 <0.000047>
23:33:39.689870 (+     0.000164) read(3, "3225\n", 4096) = 5 <0.018190>
23:33:39.708237 (+     0.018376) close(3) = 0 <0.000060>

23:33:39.710771 (+     0.000151) openat(AT_FDCWD, "/sys/class/hwmon/hwmon5/fan2_input", O_RDONLY) = 3 <0.000073>
23:33:39.710947 (+     0.000176) fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0 <0.000042>
23:33:39.711089 (+     0.000141) read(3, "3215\n", 4096) = 5 <0.128783>
23:33:39.840088 (+     0.129024) close(3) = 0 <0.000067>

    Accumulating all those reads led to the node exporter to gradually
take more and more time to finish the scrape, going beyond the 15s
between scrapes. I'm not sure, but I think at some point the node
exporter just launches goroutines to do these sweeps and they just pile
up one on top of the other. I had to disable the collectors.

    That's problem #1.

    Today I was (ab)using the 8 cores compiling stuff, while watching
videos, so a load of above 10. I'm using (KDE's?) upowerd, but I'm not
sure this has any impact. KDE's power plasmoid shows it's using the
p[erformance governor, but checking the files I get another story:

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
powersave
powersave
powersave
powersave
powersave
powersave
powersave
powersave

    So I manually set them to performance:

$ echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
performance
performance
performance
performance
performance
performance
performance

    But CPU frequency stays below the 1GHz for a 3.8GHz CPU and the
temps stay below 47C.

    Now, I'm not sure if these things are connected, but I wager they
do. Even if they aren't, they are annoying independently. The problem
is: I have no idea how to debug this. I see no particular info in dmesg.
I tried other Debian kernel versions all down to the latest 5.x I could
get. I'm open to a slow tracking down of this thing because it has been
working for some 6.5y before these behaviors. My other alternative is to
buy new HW.

    Cheers,

	-- Marcos.

