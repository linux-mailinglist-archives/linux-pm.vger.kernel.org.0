Return-Path: <linux-pm+bounces-10178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7891BB69
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361FA1C22D93
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552E1534E6;
	Fri, 28 Jun 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bUMThw2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC91509AC;
	Fri, 28 Jun 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566748; cv=none; b=PQ3XO3Sjc68o0X8BgyWlYc1sKTKIxWbVsfPN91nL4ID5dmmST5NkvtKYo2w5gERlXUUK3Y6hP4K/r2QsdAGqYQE5GV4LxLWyyPOzXHLv3GsbkChbVlTp0ORJ736leVAb4iM/WRKhOPG/m8eiNb7WtvYZoNc6P19sZ+9EcXAyPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566748; c=relaxed/simple;
	bh=MdoznMXqPEhcbUlW/pz5NEY7NEbaaBp33xqwQY8bkoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tk1KUFrdVTeV50WuLmUQVgqXrlrZaqH5SAaHuwN/iuJvEHZ/P05VhDT5KztzntotRCWiZUtHEizfHGlXHKiqevHFMa+MDrxBW0vgOADVx5MvpKP1HmhdnEs38o6iVz6+qM3+vBE4RMv21VgQ6IGiZz9TbXBHl+8uvGd5YB0DpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bUMThw2A; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719566742; bh=MdoznMXqPEhcbUlW/pz5NEY7NEbaaBp33xqwQY8bkoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUMThw2A+621XgMzlmDpPwVk6t1SR+aTGGKmrEZckCG28LVhm+C+duCHAx9Lq54d3
	 lYE3JZX/DSeZtrqEP/aUYSjohuKo7mFbIInUjaCt9X4HNQX6W353HptbfQQ7FrtPpx
	 OQNVwkHlAx58q8ZtqDKI3HYQuSQhDVNN7lDJravYP28FcyeCYYkJL7M/ORBVR28iBC
	 osXXwpTLMouqPngOc8Ke6zlKeY4TdeKHN5Bqea2emaD532ucWGMsn9G8dKkK5bFCtz
	 i84lCTh/jny7piYrShr1UoJbYBeopCPh1bDYx+34FMI9C3fFu6HCR2NwlvwJ4nDTPp
	 y9teoj1ioxF+Q==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 2/4] Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
Date: Fri, 28 Jun 2024 11:25:02 +0200
Message-ID: <20240628092508.3664-3-danielhejduk@disroot.org>
In-Reply-To: <20240627135437.2301-1-danielhejduk@disroot.org>
References: <20240627135437.2301-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixing needs work strings and adding new strings

This translation is just uncomplete, the translation was probably done
by program. I fixed it all.
---
 tools/power/cpupower/po/cs.po | 162 ++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 76 deletions(-)

diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index 64fe78861..8c6e254a1 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -18,35 +18,35 @@ msgstr ""
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms:  nplurals=3; plural=(n==1) ? 0 : (n>=2 && n<=4) ? 1 : 2;\n"
-"X-Generator: KBabel 1.11.4\n"
+"X-Generator: Poedit 3.4.4\n"
 
 #: utils/idle_monitor/nhm_idle.c:36
 msgid "Processor Core C3"
-msgstr ""
+msgstr "Procesor Core C3"
 
 #: utils/idle_monitor/nhm_idle.c:43
 msgid "Processor Core C6"
-msgstr ""
+msgstr "Procesor Core C6"
 
 #: utils/idle_monitor/nhm_idle.c:51
 msgid "Processor Package C3"
-msgstr ""
+msgstr "Procesorový balíček C3"
 
 #: utils/idle_monitor/nhm_idle.c:58 utils/idle_monitor/amd_fam14h_idle.c:70
 msgid "Processor Package C6"
-msgstr ""
+msgstr "Procesorový balíček C6"
 
 #: utils/idle_monitor/snb_idle.c:33
 msgid "Processor Core C7"
-msgstr ""
+msgstr "Procesor Core C7"
 
 #: utils/idle_monitor/snb_idle.c:40
 msgid "Processor Package C2"
-msgstr ""
+msgstr "Procesorový balíček C2"
 
 #: utils/idle_monitor/snb_idle.c:47
 msgid "Processor Package C7"
-msgstr ""
+msgstr "Procesorový balíček C7"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:56
 msgid "Package in sleep state (PC1 or deeper)"
@@ -54,7 +54,7 @@ msgstr ""
 
 #: utils/idle_monitor/amd_fam14h_idle.c:63
 msgid "Processor Package C1"
-msgstr ""
+msgstr "Procesorový balíček C1"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:77
 msgid "North Bridge P1 boolean counter (returns 0 or 1)"
@@ -62,15 +62,15 @@ msgstr ""
 
 #: utils/idle_monitor/mperf_monitor.c:35
 msgid "Processor Core not idle"
-msgstr ""
+msgstr "Procesor Core není v klidovém stavu"
 
 #: utils/idle_monitor/mperf_monitor.c:42
 msgid "Processor Core in an idle state"
-msgstr ""
+msgstr "Procesor Core je v klidovém stavu"
 
 #: utils/idle_monitor/mperf_monitor.c:50
 msgid "Average Frequency (including boost) in MHz"
-msgstr ""
+msgstr "Průměrná frekvence (včetně boostu) v MHz"
 
 #: utils/idle_monitor/cpupower-monitor.c:66
 #, c-format
@@ -78,6 +78,8 @@ msgid ""
 "cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
 "interval_sec | -c command ...]\n"
 msgstr ""
+"cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interní_sekundy | -c příkaz ...]\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:69
 #, c-format
@@ -85,21 +87,23 @@ msgid ""
 "cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
 "interval_sec | -c command ...]\n"
 msgstr ""
+"cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interní_sekundy | -c příkaz ...]\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:71
 #, c-format
 msgid "\t -v: be more verbose\n"
-msgstr ""
+msgstr "\t -v: být víc upovídaný\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:73
 #, c-format
 msgid "\t -h: print this help\n"
-msgstr ""
+msgstr "\t-h, --help: Vypíše tuto nápovědu\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
 msgid "\t -i: time interval to measure for in seconds (default 1)\n"
-msgstr ""
+msgstr "\t -i: časové intervaly pro měření v sekundách (výchozí 1)\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:75
 #, c-format
@@ -222,7 +226,7 @@ msgstr ""
 #: utils/cpupower.c:114
 #, c-format
 msgid "Error parsing cpu list\n"
-msgstr ""
+msgstr "Chyba v parsování procesorového listu\n"
 
 #: utils/cpupower.c:172
 #, c-format
@@ -259,25 +263,25 @@ msgstr ""
 #: utils/cpufreq-info.c:163
 #, c-format
 msgid "    Supported: %s\n"
-msgstr ""
+msgstr "    Podporováno: %s\n"
 
 #: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
 msgid "yes"
-msgstr ""
+msgstr "ano"
 
 #: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
 msgid "no"
-msgstr ""
+msgstr "ne"
 
 #: utils/cpufreq-info.c:164
-#, fuzzy, c-format
+#, c-format
 msgid "    Active: %s\n"
-msgstr "  ovladač: %s\n"
+msgstr "    Aktivní: %s\n"
 
 #: utils/cpufreq-info.c:177
 #, c-format
 msgid "    Boost States: %d\n"
-msgstr ""
+msgstr "    Boostové stavy: %d\n"
 
 #: utils/cpufreq-info.c:178
 #, c-format
@@ -305,14 +309,14 @@ msgid "  driver: %s\n"
 msgstr "  ovladač: %s\n"
 
 #: utils/cpufreq-info.c:219
-#, fuzzy, c-format
+#, c-format
 msgid "  CPUs which run at the same hardware frequency: "
-msgstr "  CPU, které musí měnit frekvenci zároveň: "
+msgstr "  Procesory, které jsou na stejné hardwarové frekvenci: "
 
 #: utils/cpufreq-info.c:230
-#, fuzzy, c-format
+#, c-format
 msgid "  CPUs which need to have their frequency coordinated by software: "
-msgstr "  CPU, které musí měnit frekvenci zároveň: "
+msgstr "  Procesory, které musí mít jejich frekvenci ovládanou softwarem: "
 
 #: utils/cpufreq-info.c:241
 #, c-format
@@ -350,7 +354,7 @@ msgid ""
 "The governor \"%s\" may decide which speed to use\n"
 "                  within this range.\n"
 msgstr ""
-"  Regulátor \"%s\" může rozhodnout jakou frekvenci použít\n"
+"Regulátor \"%s\" může rozhodnout jakou frekvenci použít\n"
 "                    v těchto mezích.\n"
 
 #: utils/cpufreq-info.c:293
@@ -369,9 +373,9 @@ msgid "  cpufreq stats: "
 msgstr "  statistika cpufreq: "
 
 #: utils/cpufreq-info.c:472
-#, fuzzy, c-format
+#, c-format
 msgid "Usage: cpupower freqinfo [options]\n"
-msgstr "Užití: cpufreq-info [přepínače]\n"
+msgstr "Užití: cpupower freqinfo [přepínače]\n"
 
 #: utils/cpufreq-info.c:473 utils/cpufreq-set.c:26 utils/cpupower-set.c:23
 #: utils/cpupower-info.c:22 utils/cpuidle-info.c:148
@@ -380,7 +384,7 @@ msgid "Options:\n"
 msgstr "Přepínače:\n"
 
 #: utils/cpufreq-info.c:474
-#, fuzzy, c-format
+#, c-format
 msgid "  -e, --debug          Prints out debug information [default]\n"
 msgstr "  -e, --debug          Vypíše ladicí informace\n"
 
@@ -427,20 +431,21 @@ msgid "  -g, --governors      Determines available cpufreq governors *\n"
 msgstr "  -g, --governors      Zjistí dostupné regulátory cpufreq *\n"
 
 #: utils/cpufreq-info.c:483
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "  -r, --related-cpus   Determines which CPUs run at the same hardware "
 "frequency *\n"
 msgstr ""
-"  -a, --affected-cpus  Zjistí, které CPU musí měnit frekvenci zároveň *\n"
+"  -r, --related-cpus  Zjistí, které procesory jsou na stejné frekvenci *\n"
 
 #: utils/cpufreq-info.c:484
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "  -a, --affected-cpus  Determines which CPUs need to have their frequency\n"
 "                       coordinated by software *\n"
 msgstr ""
-"  -a, --affected-cpus  Zjistí, které CPU musí měnit frekvenci zároveň *\n"
+"  -a, --affected-cpus  Zjistí, které procesory musí mít svoji frekvenci\n"
+"                       ovládanou softwarem *\n"
 
 #: utils/cpufreq-info.c:486
 #, c-format
@@ -448,13 +453,13 @@ msgid "  -s, --stats          Shows cpufreq statistics if available\n"
 msgstr "  -s, --stats          Zobrazí statistiku cpufreq, je-li dostupná\n"
 
 #: utils/cpufreq-info.c:487
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "  -y, --latency        Determines the maximum latency on CPU frequency "
 "changes *\n"
 msgstr ""
-"  -l, --hwlimits       Zjistí minimální a maximální dostupnou frekvenci CPU "
-"*\n"
+"  -y, --latency        Zjistí maximální latenci na změně procesorové "
+"frekvence *\n"
 
 #: utils/cpufreq-info.c:488
 #, c-format
@@ -468,16 +473,17 @@ msgid ""
 "cpufreq\n"
 "                       interface in 2.4. and early 2.6. kernels\n"
 msgstr ""
-"  -o, --proc           Vypíše informace ve formátu, jaký používalo rozhraní\n"
+"  -o, --proc           Vypíše informace ve formátu, jaký používalo "
+"rozhraní\n"
 "                       /proc/cpufreq v kernelech řady 2.4 a časné 2.6\n"
 
 #: utils/cpufreq-info.c:491
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "  -m, --human          human-readable output for the -f, -w, -s and -y "
 "parameters\n"
 msgstr ""
-"  -m, --human          Výstup parametrů -f, -w a -s v „lidmi čitelném“ "
+"  -m, --human          Výstup parametrů -f, -w a -s a -y v „lidmi čitelném“ "
 "formátu\n"
 
 #: utils/cpufreq-info.c:492 utils/cpuidle-info.c:152
@@ -488,12 +494,14 @@ msgstr "  -h, --help           Vypíše tuto nápovědu\n"
 #: utils/cpufreq-info.c:495
 #, c-format
 msgid ""
-"If no argument or only the -c, --cpu parameter is given, debug output about\n"
+"If no argument or only the -c, --cpu parameter is given, debug output "
+"about\n"
 "cpufreq is printed which is useful e.g. for reporting bugs.\n"
 msgstr ""
 "Není-li zadán žádný parametr nebo je-li zadán pouze přepínač -c, --cpu, "
 "jsou\n"
-"vypsány ladicí informace, což může být užitečné například při hlášení chyb.\n"
+"vypsány ladicí informace, což může být užitečné například při hlášení "
+"chyb.\n"
 
 #: utils/cpufreq-info.c:497
 #, c-format
@@ -509,7 +517,8 @@ msgstr ""
 msgid ""
 "The argument passed to this tool can't be combined with passing a --cpu "
 "argument\n"
-msgstr "Zadaný parametr nemůže být použit zároveň s přepínačem -c nebo --cpu\n"
+msgstr ""
+"Zadaný parametr nemůže být použit zároveň s přepínačem -c nebo --cpu\n"
 
 #: utils/cpufreq-info.c:596
 #, c-format
@@ -537,9 +546,9 @@ msgid "analyzing CPU %d:\n"
 msgstr "analyzuji CPU %d:\n"
 
 #: utils/cpufreq-set.c:25
-#, fuzzy, c-format
+#, c-format
 msgid "Usage: cpupower frequency-set [options]\n"
-msgstr "Užití: cpufreq-set [přepínače]\n"
+msgstr "Užití: cpupower frequency-set [přepínače]\n"
 
 #: utils/cpufreq-set.c:27
 #, c-format
@@ -567,7 +576,8 @@ msgstr "  -g GOV, --governors GOV  Nový regulátor cpufreq\n"
 #: utils/cpufreq-set.c:30
 #, c-format
 msgid ""
-"  -f FREQ, --freq FREQ     specific frequency to be set. Requires userspace\n"
+"  -f FREQ, --freq FREQ     specific frequency to be set. Requires "
+"userspace\n"
 "                           governor to be available and loaded\n"
 msgstr ""
 "  -f FREQ, --freq FREQ     Frekvence, která má být nastavena. Vyžaduje, aby "
@@ -580,21 +590,22 @@ msgid "  -r, --related            Switches all hardware-related CPUs\n"
 msgstr ""
 
 #: utils/cpufreq-set.c:33 utils/cpupower-set.c:28 utils/cpupower-info.c:27
-#, fuzzy, c-format
+#, c-format
 msgid "  -h, --help               Prints out this screen\n"
 msgstr "  -h, --help           Vypíše tuto nápovědu\n"
 
 #: utils/cpufreq-set.c:35
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Notes:\n"
-"1. Omitting the -c or --cpu argument is equivalent to setting it to \"all\"\n"
+"1. Omitting the -c or --cpu argument is equivalent to setting it to "
+"\"all\"\n"
 msgstr ""
-"Není-li při použití přepínačů označených * zadán parametr -c nebo --cpu,\n"
-"předpokládá se jeho hodnota 0.\n"
+"Poznámky:\n"
+"1. Vynechání -c nebo --cpu přepínače je ekvivalent na nastavení \"all\"\n"
 
 #: utils/cpufreq-set.c:37
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "2. The -f FREQ, --freq FREQ parameter cannot be combined with any other "
 "parameter\n"
@@ -603,12 +614,11 @@ msgid ""
 "   by postfixing the value with the wanted unit name, without any space\n"
 "   (FREQuency in kHz =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000).\n"
 msgstr ""
-"Poznámky:\n"
-"1. Vynechání parametru -c nebo --cpu je ekvivalentní jeho nastavení na 0\n"
 "2. Přepínač -f nebo --freq nemůže být použit zároveň s žádným jiným vyjma -"
 "c\n"
 "   nebo --cpu\n"
-"3. Frekvence (FREQ) mohou být zadány v Hz, kHz (výchozí), MHz, GHz nebo THz\n"
+"3. Frekvence (FREQ) mohou být zadány v Hz, kHz (výchozí), MHz, GHz nebo "
+"THz\n"
 "   připojením názvu jednotky bez mezery mezi číslem a jednotkou\n"
 "   (FREQ v kHz =^ Hz * 0,001 = ^ MHz * 1000 =^ GHz * 1000000)\n"
 
@@ -659,7 +669,7 @@ msgstr ""
 #: utils/cpufreq-set.c:347
 #, c-format
 msgid "Setting cpu: %d\n"
-msgstr ""
+msgstr "Nastavuji procesor:%d\n"
 
 #: utils/cpupower-set.c:22
 #, c-format
@@ -729,9 +739,9 @@ msgid ""
 msgstr ""
 
 #: utils/cpupower-info.c:25
-#, fuzzy, c-format
+#, c-format
 msgid "  -m, --sched-mc     Gets the kernel's multi core scheduler policy.\n"
-msgstr "  -p, --policy         Zjistí aktuální taktiku cpufreq *\n"
+msgstr "  -m, --sched-mc     Zjistí pravidla pro multi jádrové plánování\n"
 
 #: utils/cpupower-info.c:26
 #, c-format
@@ -783,9 +793,9 @@ msgid "perf-bias: %d\n"
 msgstr ""
 
 #: utils/cpuidle-info.c:28
-#, fuzzy, c-format
+#, c-format
 msgid "Analyzing CPU %d:\n"
-msgstr "analyzuji CPU %d:\n"
+msgstr "Analyzování procesoru %d:\n"
 
 #: utils/cpuidle-info.c:32
 #, c-format
@@ -808,9 +818,9 @@ msgid "Number of idle states: %d\n"
 msgstr ""
 
 #: utils/cpuidle-info.c:48
-#, fuzzy, c-format
+#, c-format
 msgid "Available idle states:"
-msgstr "  dostupné frekvence: "
+msgstr "Dostupné frekvence:"
 
 #: utils/cpuidle-info.c:71
 #, c-format
@@ -820,7 +830,7 @@ msgstr ""
 #: utils/cpuidle-info.c:74
 #, c-format
 msgid "Latency: %lu\n"
-msgstr ""
+msgstr "Latence: %lu\n"
 
 #: utils/cpuidle-info.c:76
 #, c-format
@@ -838,9 +848,9 @@ msgid "Could not determine cpuidle driver\n"
 msgstr ""
 
 #: utils/cpuidle-info.c:94
-#, fuzzy, c-format
+#, c-format
 msgid "CPUidle driver: %s\n"
-msgstr "  ovladač: %s\n"
+msgstr "ovladač: %s\n"
 
 #: utils/cpuidle-info.c:99
 #, c-format
@@ -876,7 +886,7 @@ msgstr ""
 #: utils/cpuidle-info.c:130
 #, c-format
 msgid "states:\t\n"
-msgstr ""
+msgstr "stavy:\t\n"
 
 #: utils/cpuidle-info.c:132
 #, c-format
@@ -904,31 +914,31 @@ msgid "duration[%020Lu] \n"
 msgstr ""
 
 #: utils/cpuidle-info.c:147
-#, fuzzy, c-format
+#, c-format
 msgid "Usage: cpupower idleinfo [options]\n"
-msgstr "Užití: cpufreq-info [přepínače]\n"
+msgstr "Užití: cpupower idleinfo [přepínače]\n"
 
 #: utils/cpuidle-info.c:149
-#, fuzzy, c-format
+#, c-format
 msgid "  -s, --silent         Only show general C-state information\n"
-msgstr "  -e, --debug          Vypíše ladicí informace\n"
+msgstr "  -s, --silent          Ukáže pouze základní informace o C-stavech\n"
 
 #: utils/cpuidle-info.c:150
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "  -o, --proc           Prints out information like provided by the /proc/"
 "acpi/processor/*/power\n"
 "                       interface in older kernels\n"
 msgstr ""
-"  -o, --proc           Vypíše informace ve formátu, jaký používalo rozhraní\n"
-"                       /proc/cpufreq v kernelech řady 2.4 a časné 2.6\n"
+"  -o, --proc           Vypíše informace které jsou obsaženy v /proc/acpi/"
+"processor/*/power\n"
+"                       rozhraní ve starších verzích jádra\n"
 
 #: utils/cpuidle-info.c:209
-#, fuzzy, c-format
+#, c-format
 msgid "You can't specify more than one output-specific argument\n"
 msgstr ""
-"Nelze zadat více než jeden parametr -c nebo --cpu\n"
-"anebo více než jeden parametr určující výstup\n"
+"Nemůžeš specifikovat více jak jeden přepínač pro nastavování vypisování\n"
 
 #~ msgid ""
 #~ "  -c CPU, --cpu CPU    CPU number which information shall be determined "
-- 
2.45.2


