Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16E6ABCA0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404776AbfIFPgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 11:36:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42988 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404705AbfIFPgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 11:36:02 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so13631287iod.9
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2019 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=kTgosfN0neZTZhxwJDlG4CrYVurwaJPgUd1kS1DxLEc=;
        b=HmoSeId5rz1lcvKhYC+RC2++GarqhXbtYABE/TozdH54xhiKcS67xMX2tsL05Qj8NR
         69POHOQAfbqfr1Vxk2RK/84mJ1aiZakUSeh6s0ksE6WYhwJHIfNf05zqQ+I0AsVsEHnM
         fE0TNdhNK2ZC5dfvJk9k94GpcTZPi05TEdOGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=kTgosfN0neZTZhxwJDlG4CrYVurwaJPgUd1kS1DxLEc=;
        b=MYEw4dxP+1wsU700Z+0MOC1t0tD1JBmaN1aV2OueMRyfnloJ/yENCPhW0avqgv5xp4
         14pom7zDcFRafZmsOh4gtDiQHbMHL7+8EpS6Xs23WarzVbp3Y8DfaEcpAzy7lIK2tlwq
         x9V5z9iNL+SAuzjAxdKKelfCJCTkTo+nfFaE9Ilay2p3J6K2OBoVIgHd0emHpevbJ3sS
         m2Y31MYBGj4StPVFfrmYvu/BUXPnxoQ7QqQBP1uwslahd7qXMDxa3RYa6FPwddVyxX8/
         GVsCrFexYR3yElCShUVpSvB3CQgClFu0ONp47NQGC4IvuZ6+9Po0Bpl/0Qnl9WCm+k/d
         0ygw==
X-Gm-Message-State: APjAAAWqsFIjXLP201Lo3Aj52xBJSSkH6ZFqImGZlwVzWY4Sq48O2TNK
        bQTuVwNdRPdit47mKtIIPYRgHw==
X-Google-Smtp-Source: APXvYqwWODD1d+ATcaxlgE0bxQMmj8fYOSD/wLQwHK/fTf9nwFZZ3MmQe/hScdjVOTiAH3quodXa4w==
X-Received: by 2002:a5d:9402:: with SMTP id v2mr10748337ion.182.1567784161441;
        Fri, 06 Sep 2019 08:36:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u10sm7295618ior.81.2019.09.06.08.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:36:00 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.4-rc1
Message-ID: <3087ddf7-b0cc-fdf1-4dd2-5d6c630bdbba@linuxfoundation.org>
Date:   Fri, 6 Sep 2019 09:35:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------FB26170692DA6BC2A342C932"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------FB26170692DA6BC2A342C932
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

Please pull the following update for Linux 5.4-rc1 or 5.4-rc2 depending
on your pull request schedule for Linus.

This cpupower update for Linux 5.4-rc1 consists of bug fixes and
German translation updates from Benjamin Weis.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

   Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.4-rc1

for you to fetch changes up to 87ce243206944a57383309dcbcdcc5750e6c905b:

   cpupower: update German translation (2019-08-29 10:18:52 -0600)

----------------------------------------------------------------
linux-cpupower-5.4-rc1

This cpupower update for Linux 5.4-rc1 consists of bug fixes and
German translation updates from Benjamin Weis.

----------------------------------------------------------------
Benjamin Weis (1):
       cpupower: update German translation

Geert Uytterhoeven (1):
       cpupower: Add missing newline at end of file

Sébastien Szymanski (1):
       tools/power/cpupower: fix 64bit detection when cross-compiling

  tools/power/cpupower/Makefile                      |  14 +-
  tools/power/cpupower/bench/cpufreq-bench_plot.sh   |   2 +-
  tools/power/cpupower/bench/cpufreq-bench_script.sh |   2 +-
  tools/power/cpupower/po/de.po                      | 344 
+++++++++++----------
  4 files changed, 190 insertions(+), 172 deletions(-)
----------------------------------------------------------------


--------------FB26170692DA6BC2A342C932
Content-Type: text/x-patch;
 name="linux-cpupower-5.4-rc1.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.4-rc1.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 9063fca480b3..c8622497ef23 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -18,7 +18,6 @@ OUTDIR := $(shell cd $(OUTPUT) && pwd)
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
-include ../../scripts/Makefile.arch
 
 # --- CONFIGURATION BEGIN ---
 
@@ -69,11 +68,6 @@ bindir ?=	/usr/bin
 sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
 includedir ?=	/usr/include
-ifeq ($(IS_64_BIT), 1)
-libdir ?=	/usr/lib64
-else
-libdir ?=	/usr/lib
-endif
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
 confdir ?=      /etc/
@@ -100,6 +94,14 @@ RANLIB = $(CROSS)ranlib
 HOSTCC = gcc
 MKDIR = mkdir
 
+# 64bit library detection
+include ../../scripts/Makefile.arch
+
+ifeq ($(IS_64_BIT), 1)
+libdir ?=	/usr/lib64
+else
+libdir ?=	/usr/lib
+endif
 
 # Now we set up the build system
 #
diff --git a/tools/power/cpupower/bench/cpufreq-bench_plot.sh b/tools/power/cpupower/bench/cpufreq-bench_plot.sh
index 9061b4f1244e..f5f8b3c8f062 100644
--- a/tools/power/cpupower/bench/cpufreq-bench_plot.sh
+++ b/tools/power/cpupower/bench/cpufreq-bench_plot.sh
@@ -88,4 +88,4 @@ done
 echo >> $dir/plot_script.gpl
 
 gnuplot $dir/plot_script.gpl
-rm -r $dir
\ No newline at end of file
+rm -r $dir
diff --git a/tools/power/cpupower/bench/cpufreq-bench_script.sh b/tools/power/cpupower/bench/cpufreq-bench_script.sh
index 4e9714b876d2..785a3679c704 100644
--- a/tools/power/cpupower/bench/cpufreq-bench_script.sh
+++ b/tools/power/cpupower/bench/cpufreq-bench_script.sh
@@ -85,4 +85,4 @@ function create_plots()
 }
 
 measure
-create_plots
\ No newline at end of file
+create_plots
diff --git a/tools/power/cpupower/po/de.po b/tools/power/cpupower/po/de.po
index 70887bb8ba95..9780a447bb55 100644
--- a/tools/power/cpupower/po/de.po
+++ b/tools/power/cpupower/po/de.po
@@ -8,66 +8,66 @@ msgstr ""
 "Project-Id-Version: cpufrequtils 006\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2011-03-08 17:03+0100\n"
-"PO-Revision-Date: 2009-08-08 17:18+0100\n"
-"Last-Translator:  <linux@dominikbrodowski.net>\n"
+"PO-Revision-Date: 2019-06-02 15:23+0200\n"
+"Last-Translator: Benjamin Weis <benjamin.weis@gmx.com>\n"
 "Language-Team: NONE\n"
 "Language: \n"
 "MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=ISO-8859-1\n"
+"Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=2; plural=(n != 1);\n"
 
 #: utils/idle_monitor/nhm_idle.c:36
 msgid "Processor Core C3"
-msgstr ""
+msgstr "Prozessorkern C3"
 
 #: utils/idle_monitor/nhm_idle.c:43
 msgid "Processor Core C6"
-msgstr ""
+msgstr "Prozessorkern C6"
 
 #: utils/idle_monitor/nhm_idle.c:51
 msgid "Processor Package C3"
-msgstr ""
+msgstr "Prozessorpaket C3"
 
 #: utils/idle_monitor/nhm_idle.c:58 utils/idle_monitor/amd_fam14h_idle.c:70
 msgid "Processor Package C6"
-msgstr ""
+msgstr "Prozessorpaket C6"
 
 #: utils/idle_monitor/snb_idle.c:33
 msgid "Processor Core C7"
-msgstr ""
+msgstr "Prozessorkern C7"
 
 #: utils/idle_monitor/snb_idle.c:40
 msgid "Processor Package C2"
-msgstr ""
+msgstr "Prozessorpaket C2"
 
 #: utils/idle_monitor/snb_idle.c:47
 msgid "Processor Package C7"
-msgstr ""
+msgstr "Prozessorpaket C7"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:56
 msgid "Package in sleep state (PC1 or deeper)"
-msgstr ""
+msgstr "Paket in Schlafzustand (PC1 oder tiefer)"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:63
 msgid "Processor Package C1"
-msgstr ""
+msgstr "Prozessorpaket C1"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:77
 msgid "North Bridge P1 boolean counter (returns 0 or 1)"
-msgstr ""
+msgstr "North Bridge P1 boolescher Zähler (gibt 0 oder 1 zurück)"
 
 #: utils/idle_monitor/mperf_monitor.c:35
 msgid "Processor Core not idle"
-msgstr ""
+msgstr "Prozessorkern ist nicht im Leerlauf"
 
 #: utils/idle_monitor/mperf_monitor.c:42
 msgid "Processor Core in an idle state"
-msgstr ""
+msgstr "Prozessorkern ist in einem Ruhezustand"
 
 #: utils/idle_monitor/mperf_monitor.c:50
 msgid "Average Frequency (including boost) in MHz"
-msgstr ""
+msgstr "Durchschnittliche Frequenz (einschließlich Boost) in MHz"
 
 #: utils/idle_monitor/cpupower-monitor.c:66
 #, c-format
@@ -75,6 +75,8 @@ msgid ""
 "cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
 "interval_sec | -c command ...]\n"
 msgstr ""
+"cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c Befehl ...]\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:69
 #, c-format
@@ -82,36 +84,40 @@ msgid ""
 "cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
 "interval_sec | -c command ...]\n"
 msgstr ""
+"cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c Befehl ...]\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:71
 #, c-format
 msgid "\t -v: be more verbose\n"
-msgstr ""
+msgstr "\t -v: ausführlicher\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:73
 #, c-format
 msgid "\t -h: print this help\n"
-msgstr ""
+msgstr "\t -h: diese Hilfe ausgeben\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
 msgid "\t -i: time interval to measure for in seconds (default 1)\n"
-msgstr ""
+msgstr "\t -i: Zeitintervall für die Messung in Sekunden (Standard 1)\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:75
 #, c-format
 msgid "\t -t: show CPU topology/hierarchy\n"
-msgstr ""
+msgstr "\t -t: CPU-Topologie/Hierarchie anzeigen\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:76
 #, c-format
 msgid "\t -l: list available CPU sleep monitors (for use with -m)\n"
 msgstr ""
+"\t -l: verfügbare CPU-Schlafwächter auflisten (für Verwendung mit -m)\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:77
 #, c-format
 msgid "\t -m: show specific CPU sleep monitors only (in same order)\n"
 msgstr ""
+"\t -m: spezifische CPU-Schlafwächter anzeigen (in gleicher Reihenfolge)\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:79
 #, c-format
@@ -119,71 +125,73 @@ msgid ""
 "only one of: -t, -l, -m are allowed\n"
 "If none of them is passed,"
 msgstr ""
+"nur einer von: -t, -l, -m ist erlaubt\n"
+"Wenn keiner von ihnen übergeben wird,"
 
 #: utils/idle_monitor/cpupower-monitor.c:80
 #, c-format
 msgid " all supported monitors are shown\n"
-msgstr ""
+msgstr " werden alle unterstützten Wächter angezeigt\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:197
 #, c-format
 msgid "Monitor %s, Counter %s has no count function. Implementation error\n"
-msgstr ""
+msgstr "Wächter %s, Zähler %s hat keine Zählfunktion. Implementierungsfehler\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:207
 #, c-format
 msgid " *is offline\n"
-msgstr ""
+msgstr " *ist offline\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:236
 #, c-format
 msgid "%s: max monitor name length (%d) exceeded\n"
-msgstr ""
+msgstr "%s: max. Wächternamenslänge (%d) überschritten\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:250
 #, c-format
 msgid "No matching monitor found in %s, try -l option\n"
-msgstr ""
+msgstr "Kein passender Wächter in %s gefunden, versuchen Sie die Option -l\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:266
 #, c-format
 msgid "Monitor \"%s\" (%d states) - Might overflow after %u s\n"
-msgstr ""
+msgstr "Wächter \"%s\" (%d Zustände) - Könnte nach %u s überlaufen\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:319
 #, c-format
 msgid "%s took %.5f seconds and exited with status %d\n"
-msgstr ""
+msgstr "%s hat %.5f Sekunden gedauert und hat sich mit Status %d beendet\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:406
 #, c-format
 msgid "Cannot read number of available processors\n"
-msgstr ""
+msgstr "Anzahl der verfügbaren Prozessoren kann nicht gelesen werden\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:417
 #, c-format
 msgid "Available monitor %s needs root access\n"
-msgstr ""
+msgstr "Verfügbarer Wächter %s benötigt root-Zugriff\n"
 
 #: utils/idle_monitor/cpupower-monitor.c:428
 #, c-format
 msgid "No HW Cstate monitors found\n"
-msgstr ""
+msgstr "Keine HW C-Zustandswächter gefunden\n"
 
 #: utils/cpupower.c:78
 #, c-format
 msgid "cpupower [ -c cpulist ] subcommand [ARGS]\n"
-msgstr ""
+msgstr "cpupower [ -c cpulist ] Unterbefehl [ARGS]\n"
 
 #: utils/cpupower.c:79
 #, c-format
 msgid "cpupower --version\n"
-msgstr ""
+msgstr "cpupower --version\n"
 
 #: utils/cpupower.c:80
 #, c-format
 msgid "Supported subcommands are:\n"
-msgstr ""
+msgstr "Unterstützte Unterbefehle sind:\n"
 
 #: utils/cpupower.c:83
 #, c-format
@@ -191,11 +199,15 @@ msgid ""
 "\n"
 "Some subcommands can make use of the -c cpulist option.\n"
 msgstr ""
+"\n"
+"Einige Unterbefehle können die Option -c cpulist verwenden.\n"
 
 #: utils/cpupower.c:84
 #, c-format
 msgid "Look at the general cpupower manpage how to use it\n"
 msgstr ""
+"Schauen Sie sich die allgemeine cpupower manpage an, um zu erfahren, wie man "
+"es benutzt\n"
 
 #: utils/cpupower.c:85
 #, c-format
@@ -217,30 +229,31 @@ msgstr "Bitte melden Sie Fehler an %s.\n"
 #: utils/cpupower.c:114
 #, c-format
 msgid "Error parsing cpu list\n"
-msgstr ""
+msgstr "Fehler beim Parsen der CPU-Liste\n"
 
 #: utils/cpupower.c:172
 #, c-format
 msgid "Subcommand %s needs root privileges\n"
-msgstr ""
+msgstr "Unterbefehl %s benötigt root-Rechte\n"
 
 #: utils/cpufreq-info.c:31
 #, c-format
 msgid "Couldn't count the number of CPUs (%s: %s), assuming 1\n"
 msgstr ""
-"Konnte nicht die Anzahl der CPUs herausfinden (%s : %s), nehme daher 1 an.\n"
+"Anzahl der CPUs konnte nicht herausgefinden werden (%s: %s), es wird daher 1 "
+"angenommen\n"
 
 #: utils/cpufreq-info.c:63
 #, c-format
 msgid ""
 "          minimum CPU frequency  -  maximum CPU frequency  -  governor\n"
-msgstr ""
-"          minimale CPU-Taktfreq. -  maximale CPU-Taktfreq. -  Regler  \n"
+msgstr "          minimale CPU-Frequenz  -  maximale CPU-Frequenz  -  Regler\n"
 
 #: utils/cpufreq-info.c:151
 #, c-format
 msgid "Error while evaluating Boost Capabilities on CPU %d -- are you root?\n"
 msgstr ""
+"Fehler beim Evaluieren der Boost-Fähigkeiten bei CPU %d -- sind Sie root?\n"
 
 #. P state changes via MSR are identified via cpuid 80000007
 #. on Intel and AMD, but we assume boost capable machines can do that
@@ -250,50 +263,50 @@ msgstr ""
 #: utils/cpufreq-info.c:161
 #, c-format
 msgid "  boost state support: \n"
-msgstr ""
+msgstr "  Boost-Zustand-Unterstützung: \n"
 
 #: utils/cpufreq-info.c:163
 #, c-format
 msgid "    Supported: %s\n"
-msgstr ""
+msgstr "    Unterstützt: %s\n"
 
 #: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
 msgid "yes"
-msgstr ""
+msgstr "ja"
 
 #: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
 msgid "no"
-msgstr ""
+msgstr "nein"
 
 #: utils/cpufreq-info.c:164
-#, fuzzy, c-format
+#, c-format
 msgid "    Active: %s\n"
-msgstr "  Treiber: %s\n"
+msgstr "    Aktiv: %s\n"
 
 #: utils/cpufreq-info.c:177
 #, c-format
 msgid "    Boost States: %d\n"
-msgstr ""
+msgstr "    Boost-Zustände: %d\n"
 
 #: utils/cpufreq-info.c:178
 #, c-format
 msgid "    Total States: %d\n"
-msgstr ""
+msgstr "    Gesamtzustände: %d\n"
 
 #: utils/cpufreq-info.c:181
 #, c-format
 msgid "    Pstate-Pb%d: %luMHz (boost state)\n"
-msgstr ""
+msgstr "    Pstate-Pb%d: %luMHz (Boost-Zustand)\n"
 
 #: utils/cpufreq-info.c:184
 #, c-format
 msgid "    Pstate-P%d:  %luMHz\n"
-msgstr ""
+msgstr "    Pstate-P%d:  %luMHz\n"
 
 #: utils/cpufreq-info.c:211
 #, c-format
 msgid "  no or unknown cpufreq driver is active on this CPU\n"
-msgstr "  kein oder nicht bestimmbarer cpufreq-Treiber aktiv\n"
+msgstr "  kein oder ein unbekannter cpufreq-Treiber ist auf dieser CPU aktiv\n"
 
 #: utils/cpufreq-info.c:213
 #, c-format
@@ -303,12 +316,12 @@ msgstr "  Treiber: %s\n"
 #: utils/cpufreq-info.c:219
 #, c-format
 msgid "  CPUs which run at the same hardware frequency: "
-msgstr "  Folgende CPUs laufen mit der gleichen Hardware-Taktfrequenz: "
+msgstr "  CPUs, die mit der gleichen Hardwarefrequenz laufen: "
 
 #: utils/cpufreq-info.c:230
 #, c-format
 msgid "  CPUs which need to have their frequency coordinated by software: "
-msgstr "  Die Taktfrequenz folgender CPUs werden per Software koordiniert: "
+msgstr "  CPUs, die ihre Frequenz mit Software koordinieren müssen: "
 
 #: utils/cpufreq-info.c:241
 #, c-format
@@ -318,22 +331,22 @@ msgstr "  Maximale Dauer eines Taktfrequenzwechsels: "
 #: utils/cpufreq-info.c:247
 #, c-format
 msgid "  hardware limits: "
-msgstr "  Hardwarebedingte Grenzen der Taktfrequenz: "
+msgstr "  Hardwarebegrenzungen: "
 
 #: utils/cpufreq-info.c:256
 #, c-format
 msgid "  available frequency steps: "
-msgstr "  mögliche Taktfrequenzen: "
+msgstr "  verfügbare Frequenzschritte: "
 
 #: utils/cpufreq-info.c:269
 #, c-format
 msgid "  available cpufreq governors: "
-msgstr "  mögliche Regler: "
+msgstr "  verfügbare cpufreq-Regler: "
 
 #: utils/cpufreq-info.c:280
 #, c-format
 msgid "  current policy: frequency should be within "
-msgstr "  momentane Taktik: die Frequenz soll innerhalb "
+msgstr "  momentane Richtlinie: Frequenz sollte innerhalb "
 
 #: utils/cpufreq-info.c:282
 #, c-format
@@ -346,29 +359,28 @@ msgid ""
 "The governor \"%s\" may decide which speed to use\n"
 "                  within this range.\n"
 msgstr ""
-"  liegen. Der Regler \"%s\" kann frei entscheiden,\n"
-"                    welche Taktfrequenz innerhalb dieser Grenze verwendet "
-"wird.\n"
+"  sein. Der Regler \"%s\" kann frei entscheiden,\n"
+"                    welche Geschwindigkeit er in diesem Bereich verwendet.\n"
 
 #: utils/cpufreq-info.c:293
 #, c-format
 msgid "  current CPU frequency is "
-msgstr "  momentane Taktfrequenz ist "
+msgstr "  momentane CPU-Frequenz ist "
 
 #: utils/cpufreq-info.c:296
 #, c-format
 msgid " (asserted by call to hardware)"
-msgstr "  (verifiziert durch Nachfrage bei der Hardware)"
+msgstr " (durch Aufruf der Hardware sichergestellt)"
 
 #: utils/cpufreq-info.c:304
 #, c-format
 msgid "  cpufreq stats: "
-msgstr "  Statistik:"
+msgstr "  cpufreq-Statistiken: "
 
 #: utils/cpufreq-info.c:472
-#, fuzzy, c-format
+#, c-format
 msgid "Usage: cpupower freqinfo [options]\n"
-msgstr "Aufruf: cpufreq-info [Optionen]\n"
+msgstr "Aufruf: cpupower freqinfo [Optionen]\n"
 
 #: utils/cpufreq-info.c:473 utils/cpufreq-set.c:26 utils/cpupower-set.c:23
 #: utils/cpupower-info.c:22 utils/cpuidle-info.c:148
@@ -377,11 +389,9 @@ msgid "Options:\n"
 msgstr "Optionen:\n"
 
 #: utils/cpufreq-info.c:474
-#, fuzzy, c-format
+#, c-format
 msgid "  -e, --debug          Prints out debug information [default]\n"
-msgstr ""
-"  -e, --debug          Erzeugt detaillierte Informationen, hilfreich\n"
-"                       zum Aufspüren von Fehlern\n"
+msgstr "  -e, --debug          Gibt Debug-Informationen aus [Standard]\n"
 
 #: utils/cpufreq-info.c:475
 #, c-format
@@ -424,7 +434,7 @@ msgstr "  -p, --policy         Findet die momentane Taktik heraus *\n"
 #: utils/cpufreq-info.c:482
 #, c-format
 msgid "  -g, --governors      Determines available cpufreq governors *\n"
-msgstr "  -g, --governors      Erzeugt eine Liste mit verfügbaren Reglern *\n"
+msgstr "  -g, --governors      Ermittelt verfügbare cpufreq-Regler *\n"
 
 #: utils/cpufreq-info.c:483
 #, c-format
@@ -449,8 +459,7 @@ msgstr ""
 #: utils/cpufreq-info.c:486
 #, c-format
 msgid "  -s, --stats          Shows cpufreq statistics if available\n"
-msgstr ""
-"  -s, --stats          Zeigt, sofern möglich, Statistiken über cpufreq an.\n"
+msgstr "  -s, --stats          Zeigt cpufreq-Statistiken an, falls vorhanden\n"
 
 #: utils/cpufreq-info.c:487
 #, c-format
@@ -464,13 +473,13 @@ msgstr ""
 #: utils/cpufreq-info.c:488
 #, c-format
 msgid "  -b, --boost          Checks for turbo or boost modes  *\n"
-msgstr ""
+msgstr "  -b, --boost          Prüft auf Turbo- oder Boost-Modi  *\n"
 
 #: utils/cpufreq-info.c:489
 #, c-format
 msgid ""
-"  -o, --proc           Prints out information like provided by the /proc/"
-"cpufreq\n"
+"  -o, --proc           Prints out information like provided by the "
+"/proc/cpufreq\n"
 "                       interface in 2.4. and early 2.6. kernels\n"
 msgstr ""
 "  -o, --proc           Erzeugt Informationen in einem ähnlichem Format zu "
@@ -509,8 +518,8 @@ msgid ""
 "For the arguments marked with *, omitting the -c or --cpu argument is\n"
 "equivalent to setting it to zero\n"
 msgstr ""
-"Bei den mit * markierten Parametern wird '--cpu 0' angenommen, soweit nicht\n"
-"mittels -c oder --cpu etwas anderes angegeben wird\n"
+"Für die mit * markierten Argumente ist das Weglassen des Arguments\n"
+"-c oder --cpu gleichbedeutend mit der Einstellung auf Null\n"
 
 #: utils/cpufreq-info.c:580
 #, c-format
@@ -525,8 +534,8 @@ msgid ""
 "You can't specify more than one --cpu parameter and/or\n"
 "more than one output-specific argument\n"
 msgstr ""
-"Man kann nicht mehr als einen --cpu-Parameter und/oder mehr als einen\n"
-"informationsspezifischen Parameter gleichzeitig angeben\n"
+"Sie können nicht mehr als einen Parameter --cpu und/oder\n"
+"mehr als ein ausgabespezifisches Argument angeben\n"
 
 #: utils/cpufreq-info.c:600 utils/cpufreq-set.c:82 utils/cpupower-set.c:42
 #: utils/cpupower-info.c:42 utils/cpuidle-info.c:213
@@ -538,17 +547,17 @@ msgstr "unbekannter oder falscher Parameter\n"
 #, c-format
 msgid "couldn't analyze CPU %d as it doesn't seem to be present\n"
 msgstr ""
-"Konnte nicht die CPU %d analysieren, da sie (scheinbar?) nicht existiert.\n"
+"CPU %d konnte nicht analysiert werden, da sie scheinbar nicht existiert\n"
 
 #: utils/cpufreq-info.c:620 utils/cpupower-info.c:142
 #, c-format
 msgid "analyzing CPU %d:\n"
-msgstr "analysiere CPU %d:\n"
+msgstr "CPU %d wird analysiert:\n"
 
 #: utils/cpufreq-set.c:25
-#, fuzzy, c-format
+#, c-format
 msgid "Usage: cpupower frequency-set [options]\n"
-msgstr "Aufruf: cpufreq-set [Optionen]\n"
+msgstr "Aufruf: cpupower frequency-set [Optionen]\n"
 
 #: utils/cpufreq-set.c:27
 #, c-format
@@ -556,7 +565,7 @@ msgid ""
 "  -d FREQ, --min FREQ      new minimum CPU frequency the governor may "
 "select\n"
 msgstr ""
-"  -d FREQ, --min FREQ      neue minimale Taktfrequenz, die der Regler\n"
+"  -d FREQ, --min FREQ      neue minimale CPU-Frequenz, die der Regler\n"
 "                           auswählen darf\n"
 
 #: utils/cpufreq-set.c:28
@@ -571,7 +580,7 @@ msgstr ""
 #: utils/cpufreq-set.c:29
 #, c-format
 msgid "  -g GOV, --governor GOV   new cpufreq governor\n"
-msgstr "  -g GOV, --governors GOV  wechsle zu Regler GOV\n"
+msgstr "  -g GOV, --governors GOV   neuer cpufreq-Regler\n"
 
 #: utils/cpufreq-set.c:30
 #, c-format
@@ -579,29 +588,29 @@ msgid ""
 "  -f FREQ, --freq FREQ     specific frequency to be set. Requires userspace\n"
 "                           governor to be available and loaded\n"
 msgstr ""
-"  -f FREQ, --freq FREQ     setze exakte Taktfrequenz. Benötigt den Regler\n"
-"                           'userspace'.\n"
+"  -f FREQ, --freq FREQ     bestimmte Frequenz, die eingestellt werden soll.\n"
+"                           Erfordert einen verfügbaren und geladenen "
+"userspace-Regler\n"
 
 #: utils/cpufreq-set.c:32
 #, c-format
 msgid "  -r, --related            Switches all hardware-related CPUs\n"
-msgstr ""
-"  -r, --related            Setze Werte für alle CPUs, deren Taktfrequenz\n"
-"                           hardwarebedingt identisch ist.\n"
+msgstr "  -r, --related            Schaltet alle hardwarebezogenen CPUs um\n"
 
 #: utils/cpufreq-set.c:33 utils/cpupower-set.c:28 utils/cpupower-info.c:27
 #, c-format
 msgid "  -h, --help               Prints out this screen\n"
-msgstr "  -h, --help               Gibt diese Kurzübersicht aus\n"
+msgstr "  -h, --help               Gibt diesen Bildschirm aus\n"
 
 #: utils/cpufreq-set.c:35
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Notes:\n"
 "1. Omitting the -c or --cpu argument is equivalent to setting it to \"all\"\n"
 msgstr ""
-"Bei den mit * markierten Parametern wird '--cpu 0' angenommen, soweit nicht\n"
-"mittels -c oder --cpu etwas anderes angegeben wird\n"
+"Hinweis:\n"
+"1. Das Weglassen des Arguments -c oder --cpu ist gleichbedeutend mit der "
+"Einstellung auf \"all\"\n"
 
 #: utils/cpufreq-set.c:37
 #, fuzzy, c-format
@@ -636,17 +645,21 @@ msgid ""
 "frequency\n"
 "   or because the userspace governor isn't loaded?\n"
 msgstr ""
-"Beim Einstellen ist ein Fehler aufgetreten. Typische Fehlerquellen sind:\n"
-"- nicht ausreichende Rechte (Administrator)\n"
-"- der Regler ist nicht verfügbar bzw. nicht geladen\n"
-"- die angegebene Taktik ist inkorrekt\n"
-"- eine spezifische Frequenz wurde angegeben, aber der Regler 'userspace'\n"
-"  kann entweder hardwarebedingt nicht genutzt werden oder ist nicht geladen\n"
+"Fehler beim Festlegen neuer Werte. Häufige Fehler:\n"
+"- Verfügen Sie über die erforderlichen Administrationsrechte? (Superuser?)\n"
+"- Ist der von Ihnen gewünschte Regler verfügbar und mittels modprobe "
+"geladen?\n"
+"- Versuchen Sie eine ungültige Richtlinie festzulegen?\n"
+"- Versuchen Sie eine bestimmte Frequenz festzulegen, aber der "
+"userspace-Regler ist nicht verfügbar,\n"
+"   z.B. wegen Hardware, die nicht auf eine bestimmte Frequenz eingestellt "
+"werden kann\n"
+"   oder weil der userspace-Regler nicht geladen ist?\n"
 
 #: utils/cpufreq-set.c:170
 #, c-format
 msgid "wrong, unknown or unhandled CPU?\n"
-msgstr "unbekannte oder nicht regelbare CPU\n"
+msgstr "falsche, unbekannte oder nicht regelbare CPU?\n"
 
 #: utils/cpufreq-set.c:302
 #, c-format
@@ -654,8 +667,8 @@ msgid ""
 "the -f/--freq parameter cannot be combined with -d/--min, -u/--max or\n"
 "-g/--governor parameters\n"
 msgstr ""
-"Der -f bzw. --freq-Parameter kann nicht mit den Parametern -d/--min, -u/--"
-"max\n"
+"Der -f bzw. --freq-Parameter kann nicht mit den Parametern -d/--min, "
+"-u/--max\n"
 "oder -g/--governor kombiniert werden\n"
 
 #: utils/cpufreq-set.c:308
@@ -664,18 +677,18 @@ msgid ""
 "At least one parameter out of -f/--freq, -d/--min, -u/--max, and\n"
 "-g/--governor must be passed\n"
 msgstr ""
-"Es muss mindestens ein Parameter aus -f/--freq, -d/--min, -u/--max oder\n"
-"-g/--governor angegeben werden.\n"
+"Mindestens ein Parameter aus -f/--freq, -d/--min, -u/--max und\n"
+"-g/--governor muss übergeben werden\n"
 
 #: utils/cpufreq-set.c:347
 #, c-format
 msgid "Setting cpu: %d\n"
-msgstr ""
+msgstr "CPU einstellen: %d\n"
 
 #: utils/cpupower-set.c:22
 #, c-format
 msgid "Usage: cpupower set [ -b val ] [ -m val ] [ -s val ]\n"
-msgstr ""
+msgstr "Aufruf: cpupower set [ -b val ] [ -m val ] [ -s val ]\n"
 
 #: utils/cpupower-set.c:24
 #, c-format
@@ -689,6 +702,8 @@ msgstr ""
 msgid ""
 "  -m, --sched-mc  [VAL]    Sets the kernel's multi core scheduler policy.\n"
 msgstr ""
+"  -m, --sched-mc  [VAL]    Legt die Mehrkern-Scheduler-Richtlinie des "
+"Kernels fest.\n"
 
 #: utils/cpupower-set.c:27
 #, c-format
@@ -700,37 +715,37 @@ msgstr ""
 #: utils/cpupower-set.c:80
 #, c-format
 msgid "--perf-bias param out of range [0-%d]\n"
-msgstr ""
+msgstr "--perf-bias-Parameter außerhalb des Bereichs [0-%d]\n"
 
 #: utils/cpupower-set.c:91
 #, c-format
 msgid "--sched-mc param out of range [0-%d]\n"
-msgstr ""
+msgstr "Parameter --sched-mc außerhalb des Bereichs [0-%d]\n"
 
 #: utils/cpupower-set.c:102
 #, c-format
 msgid "--sched-smt param out of range [0-%d]\n"
-msgstr ""
+msgstr "Parameter --sched-smt außerhalb des Bereichs [0-%d]\n"
 
 #: utils/cpupower-set.c:121
 #, c-format
 msgid "Error setting sched-mc %s\n"
-msgstr ""
+msgstr "Fehler beim Einstellen von sched-mc %s\n"
 
 #: utils/cpupower-set.c:127
 #, c-format
 msgid "Error setting sched-smt %s\n"
-msgstr ""
+msgstr "Fehler beim Einstellen von sched-smt %s\n"
 
 #: utils/cpupower-set.c:146
 #, c-format
 msgid "Error setting perf-bias value on CPU %d\n"
-msgstr ""
+msgstr "Fehler beim Einstellen des perf-bias-Wertes auf der CPU %d\n"
 
 #: utils/cpupower-info.c:21
 #, c-format
 msgid "Usage: cpupower info [ -b ] [ -m ] [ -s ]\n"
-msgstr ""
+msgstr "Aufruf: cpupower info [ -b ] [ -m ] [ -s ]\n"
 
 #: utils/cpupower-info.c:23
 #, c-format
@@ -740,9 +755,10 @@ msgid ""
 msgstr ""
 
 #: utils/cpupower-info.c:25
-#, fuzzy, c-format
+#, c-format
 msgid "  -m, --sched-mc     Gets the kernel's multi core scheduler policy.\n"
-msgstr "  -p, --policy         Findet die momentane Taktik heraus *\n"
+msgstr ""
+"  -m, --sched-mc     Ruft die Mehrkern-Scheduler-Richtlinie des Kernels ab.\n"
 
 #: utils/cpupower-info.c:26
 #, c-format
@@ -756,17 +772,20 @@ msgid ""
 "\n"
 "Passing no option will show all info, by default only on core 0\n"
 msgstr ""
+"\n"
+"Wenn Sie keine Option übergeben, werden alle Informationen angezeigt, "
+"standardmäßig nur auf Kern 0\n"
 
 #: utils/cpupower-info.c:102
 #, c-format
 msgid "System's multi core scheduler setting: "
-msgstr ""
+msgstr "Mehrkern-Scheduler-Einstellung des Systems: "
 
 #. if sysfs file is missing it's: errno == ENOENT
 #: utils/cpupower-info.c:105 utils/cpupower-info.c:114
 #, c-format
 msgid "not supported\n"
-msgstr ""
+msgstr "nicht unterstützt\n"
 
 #: utils/cpupower-info.c:111
 #, c-format
@@ -786,164 +805,161 @@ msgstr ""
 #: utils/cpupower-info.c:147
 #, c-format
 msgid "Could not read perf-bias value\n"
-msgstr ""
+msgstr "perf-bias-Wert konnte nicht gelesen werden\n"
 
 #: utils/cpupower-info.c:150
 #, c-format
 msgid "perf-bias: %d\n"
-msgstr ""
+msgstr "perf-bias: %d\n"
 
 #: utils/cpuidle-info.c:28
-#, fuzzy, c-format
+#, c-format
 msgid "Analyzing CPU %d:\n"
-msgstr "analysiere CPU %d:\n"
+msgstr "CPU %d wird analysiert:\n"
 
 #: utils/cpuidle-info.c:32
 #, c-format
 msgid "CPU %u: No idle states\n"
-msgstr ""
+msgstr "CPU %u: Keine Ruhezustände\n"
 
 #: utils/cpuidle-info.c:36
 #, c-format
 msgid "CPU %u: Can't read idle state info\n"
-msgstr ""
+msgstr "CPU %u: Ruhezustands-Informationen können nicht gelesen werden\n"
 
 #: utils/cpuidle-info.c:41
 #, c-format
 msgid "Could not determine max idle state %u\n"
-msgstr ""
+msgstr "Max. Ruhezustand %u konnte nicht bestimmt werden\n"
 
 #: utils/cpuidle-info.c:46
 #, c-format
 msgid "Number of idle states: %d\n"
-msgstr ""
+msgstr "Anzahl der Ruhezustände: %d\n"
 
 #: utils/cpuidle-info.c:48
-#, fuzzy, c-format
+#, c-format
 msgid "Available idle states:"
-msgstr "  mögliche Taktfrequenzen: "
+msgstr "Verfügbare Ruhezustände:"
 
 #: utils/cpuidle-info.c:71
 #, c-format
 msgid "Flags/Description: %s\n"
-msgstr ""
+msgstr "Merker/Beschreibung: %s\n"
 
 #: utils/cpuidle-info.c:74
 #, c-format
 msgid "Latency: %lu\n"
-msgstr ""
+msgstr "Latenz: %lu\n"
 
 #: utils/cpuidle-info.c:76
 #, c-format
 msgid "Usage: %lu\n"
-msgstr ""
+msgstr "Aufruf: %lu\n"
 
 #: utils/cpuidle-info.c:78
 #, c-format
 msgid "Duration: %llu\n"
-msgstr ""
+msgstr "Dauer: %llu\n"
 
 #: utils/cpuidle-info.c:90
 #, c-format
 msgid "Could not determine cpuidle driver\n"
-msgstr ""
+msgstr "cpuidle-Treiber konnte nicht bestimmt werden\n"
 
 #: utils/cpuidle-info.c:94
-#, fuzzy, c-format
+#, c-format
 msgid "CPUidle driver: %s\n"
-msgstr "  Treiber: %s\n"
+msgstr "CPUidle-Treiber: %s\n"
 
 #: utils/cpuidle-info.c:99
 #, c-format
 msgid "Could not determine cpuidle governor\n"
-msgstr ""
+msgstr "cpuidle-Regler konnte nicht bestimmt werden\n"
 
 #: utils/cpuidle-info.c:103
 #, c-format
 msgid "CPUidle governor: %s\n"
-msgstr ""
+msgstr "CPUidle-Regler: %s\n"
 
 #: utils/cpuidle-info.c:122
 #, c-format
 msgid "CPU %u: Can't read C-state info\n"
-msgstr ""
+msgstr "CPU %u: C-Zustands-Informationen können nicht gelesen werden\n"
 
 #. printf("Cstates: %d\n", cstates);
 #: utils/cpuidle-info.c:127
 #, c-format
 msgid "active state:            C0\n"
-msgstr ""
+msgstr "aktiver Zustand:            C0\n"
 
 #: utils/cpuidle-info.c:128
 #, c-format
 msgid "max_cstate:              C%u\n"
-msgstr ""
+msgstr "max_cstate:              C%u\n"
 
 #: utils/cpuidle-info.c:129
-#, fuzzy, c-format
+#, c-format
 msgid "maximum allowed latency: %lu usec\n"
-msgstr "  Maximale Dauer eines Taktfrequenzwechsels: "
+msgstr "maximal erlaubte Latenz: %lu usec\n"
 
 #: utils/cpuidle-info.c:130
 #, c-format
 msgid "states:\t\n"
-msgstr ""
+msgstr "Zustände:\t\n"
 
 #: utils/cpuidle-info.c:132
 #, c-format
 msgid "    C%d:                  type[C%d] "
-msgstr ""
+msgstr "    C%d:                  Typ[C%d] "
 
 #: utils/cpuidle-info.c:134
 #, c-format
 msgid "promotion[--] demotion[--] "
-msgstr ""
+msgstr "promotion[--] demotion[--] "
 
 #: utils/cpuidle-info.c:135
 #, c-format
 msgid "latency[%03lu] "
-msgstr ""
+msgstr "Latenz[%03lu] "
 
 #: utils/cpuidle-info.c:137
 #, c-format
 msgid "usage[%08lu] "
-msgstr ""
+msgstr "Aufruf[%08lu] "
 
 #: utils/cpuidle-info.c:139
 #, c-format
 msgid "duration[%020Lu] \n"
-msgstr ""
+msgstr "Dauer[%020Lu] \n"
 
 #: utils/cpuidle-info.c:147
-#, fuzzy, c-format
+#, c-format
 msgid "Usage: cpupower idleinfo [options]\n"
-msgstr "Aufruf: cpufreq-info [Optionen]\n"
+msgstr "Aufruf: cpupower idleinfo [Optionen]\n"
 
 #: utils/cpuidle-info.c:149
-#, fuzzy, c-format
+#, c-format
 msgid "  -s, --silent         Only show general C-state information\n"
 msgstr ""
-"  -e, --debug          Erzeugt detaillierte Informationen, hilfreich\n"
-"                       zum Aufspüren von Fehlern\n"
+"  -s, --silent         Nur allgemeine C-Zustands-Informationen anzeigen\n"
 
 #: utils/cpuidle-info.c:150
-#, fuzzy, c-format
+#, c-format
 msgid ""
-"  -o, --proc           Prints out information like provided by the /proc/"
-"acpi/processor/*/power\n"
+"  -o, --proc           Prints out information like provided by the "
+"/proc/acpi/processor/*/power\n"
 "                       interface in older kernels\n"
 msgstr ""
-"  -o, --proc           Erzeugt Informationen in einem ähnlichem Format zu "
-"dem\n"
-"                       der /proc/cpufreq-Datei in 2.4. und frühen 2.6.\n"
-"                       Kernel-Versionen\n"
+"  -o, --proc           Gibt Informationen so aus, wie sie von der "
+"Schnittstelle\n"
+"                       /proc/acpi/processor/*/power in älteren Kerneln "
+"bereitgestellt werden\n"
 
 #: utils/cpuidle-info.c:209
-#, fuzzy, c-format
+#, c-format
 msgid "You can't specify more than one output-specific argument\n"
-msgstr ""
-"Man kann nicht mehr als einen --cpu-Parameter und/oder mehr als einen\n"
-"informationsspezifischen Parameter gleichzeitig angeben\n"
+msgstr "Sie können nicht mehr als ein ausgabenspezifisches Argument angeben\n"
 
 #~ msgid ""
 #~ "  -c CPU, --cpu CPU    CPU number which information shall be determined "
@@ -956,6 +972,6 @@ msgstr ""
 #~ "  -c CPU, --cpu CPU        number of CPU where cpufreq settings shall be "
 #~ "modified\n"
 #~ msgstr ""
-#~ "  -c CPU, --cpu CPU        Nummer der CPU, deren Taktfrequenz-"
-#~ "Einstellung\n"
+#~ "  -c CPU, --cpu CPU        Nummer der CPU, deren "
+#~ "Taktfrequenz-Einstellung\n"
 #~ "                           werden soll\n"

--------------FB26170692DA6BC2A342C932--
