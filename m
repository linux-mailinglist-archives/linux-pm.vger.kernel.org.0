Return-Path: <linux-pm+bounces-10102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F491A28D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95817286046
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50C132464;
	Thu, 27 Jun 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aRUzmIlL"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7B29CA;
	Thu, 27 Jun 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480183; cv=none; b=hFqN+uPUpnClfJxNhj006dyesaRnqy50m5/y8XLJWgGAbuviuf/vLzz8ZjrZnPVwjVwL6bvrwfvd7HRpJ2HK3kohZ3qjdxNnW9BwO/KMBHhexraZyCP4DGhulJCciyypTplrf8ZJh07QdQu1GUYVgeRZf0gW4eL4r7wrsTtiCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480183; c=relaxed/simple;
	bh=8rTGnWqNInw87U+tkomQ8TzsRAn+aHNWqfHv9PoJx0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/1vnyLBsD5YZOKreAu3fXICh3UNLH3SdI9b34Dlp9AFWkatSWyPmMj7s0nEWAlxn/9pnsH4o3asf0bFT7FvLSOQq/rCPj5shdrsAtNfQWrWxSxrgwQMRBqf3YbBvM3MLkd1XHQDEvmPI6BbF7JOllPyaD68YnFLtDUeJFJH/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aRUzmIlL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719480167; bh=8rTGnWqNInw87U+tkomQ8TzsRAn+aHNWqfHv9PoJx0o=;
	h=From:To:Cc:Subject:Date;
	b=aRUzmIlL2st4pqUdVz/t79EeKEOiX1n1htXjJuUQcRBtwSH2ib78RGci+nGhYOjV7
	 O1cRX8flHxaTL3Yd9Fym3z2A+YYGIl5t7VHbRG4RHVjIceOSEg+a76XJF/B3OvSAXh
	 27gLqstRORpynB5EfnsRfzBnt3BBSZaB1futB3bF/n2aVi3WvEf2ur9CIkTar8b8jF
	 kt3C7qjnoUls7e/tIbSLy4W6jPjZ50hKySS9GBP3xRDpWRXKRi8pjqrtIYji8CuhCR
	 LR6g7XPiRNrGYMCThlMRtnr48NYVvG8eHFldi+7tGVJzWTRfYfNN+JC+hTb7kdIfV+
	 OYM5jpvuj/f6A==
To: trenn@suse.com
Cc: shuah@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	danielhejduk@disroot.org
Subject: [PATCH] Correcting all needs work translations, Adding some transaltion and changing maintainer of the cpupower tool
Date: Thu, 27 Jun 2024 11:21:56 +0200
Message-ID: <20240627092159.7724-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
---
 tools/power/cpupower/po/cs.mo | Bin 0 -> 12805 bytes
 tools/power/cpupower/po/cs.po | 172 ++++++++++++++++++----------------
 2 files changed, 91 insertions(+), 81 deletions(-)
 create mode 100644 tools/power/cpupower/po/cs.mo

diff --git a/tools/power/cpupower/po/cs.mo b/tools/power/cpupower/po/cs.mo
new file mode 100644
index 0000000000000000000000000000000000000000..e82a23760d4f26a628d9402f84c20bfda1df4263
GIT binary patch
literal 12805
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

literal 0
HcmV?d00001

diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index bfc7e1702..807dabbc1 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -4,49 +4,49 @@
 # Copyright (C) 2007 kavol
 # This file is distributed under the same license as the cpufrequtils package.
 #
-# Karel Volný <kavol@seznam.cz>, 2007, 2008.
+# Daniel Hejduk <danielhejduk@disroot.org>.
 msgid ""
 msgstr ""
 "Project-Id-Version: cs\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2011-03-08 17:03+0100\n"
-"PO-Revision-Date: 2008-06-11 16:26+0200\n"
-"Last-Translator: Karel Volný <kavol@seznam.cz>\n"
+"PO-Revision-Date: 2024-06-27 10:49+0200\n"
+"Last-Translator: Daniel Hejduk <danielhejduk@disroot.org>\n"
 "Language-Team: Czech <diskuze@lists.l10n.cz>\n"
 "Language: cs\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
-"Plural-Forms:  nplurals=3; plural=(n==1) ? 0 : (n>=2 && n<=4) ? 1 : 2;\n"
-"X-Generator: KBabel 1.11.4\n"
+"Plural-Forms: nplurals=3; plural=(n==1) ? 0 : (n>=2 && n<=4) ? 1 : 2;\n"
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
@@ -217,12 +221,12 @@ msgstr ""
 msgid "Report errors and bugs to %s, please.\n"
 msgstr ""
 "Chyby v programu prosím hlaste na %s (anglicky).\n"
-"Chyby v překladu prosím hlaste na kavol@seznam.cz (česky ;-)\n"
+"Chyby v překladu prosím hlaste na danielhejduk@disroot.org (česky ;-)\n"
 
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


