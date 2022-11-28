Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5A63B2B2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 21:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiK1UCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 15:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiK1UCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 15:02:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46D2CE0F;
        Mon, 28 Nov 2022 12:02:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s12so16933345edd.5;
        Mon, 28 Nov 2022 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSK+eaHylm+Y13rqvf4SObv/vl8twX3el/dnPTTsZyo=;
        b=noIVvyLaSxO4+PvrolTGNGR2pw16f2jj07e2wmchcLxiB9xPzdDtzG6/lmMdqLtmuE
         YEWS3Ia4EMl9fxBhnal9OmD2Cj1WzH9DZpCetJHg96uE2c6eHD2eR5ZT9h5UJq+ZnY/s
         HODRKkjBL9caehne/Qu98jvaeA53T56LlvOWHP1xGfeQf+xiqAw3sVJxjb4euhR87zi5
         cuZUYjAWfy2QCDih7OAj21In/K6Hu5kFI1kKX2gDEf0sBQ/BagG4LaOPktGXkZYSpIbr
         e+4ZyD/oDfJm54ewYo2FayHWpxWmY+QrL60tz1uiafp1grxHhESucfYBJHG/IDWivoi8
         rVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSK+eaHylm+Y13rqvf4SObv/vl8twX3el/dnPTTsZyo=;
        b=6S9KWrZxbZMP1YbbanL2UQ/MHMbe+NBrIftZqSbJzi2czaEhe9R0slM4ZS7jGUbG26
         aMe2bNbrxkywzKULK1SgX6jxd4jSBdObGfIPocpBF0nnsDrluWxs/lsETPIGst4aa2Vh
         25airydiII5YTs+fOh6PXcE+5E7KGcXN84qHZzLDPsWyrq+gQEDMiSUNAoLU4TNtljaq
         v1fZAJvYvTvELNhEBoAzYv+/aKLh2bT4sLJXE8+5t+9QuH15gl1LWdGzxuHPHLk/uXUj
         X1d+JQ4MpjsOVoK+4CjQC0tBXAVDRiStyL0r5VPJY9ndImfr2Cwo1KLB3oLLv/rdkFDx
         M+rg==
X-Gm-Message-State: ANoB5pmYnrc1+NwBtl4ivXaYIqo5aOzQqSd8tcQ2kHg4xVeZvEiJD6Sz
        M1EyQtTZj66oTxojhSh7RMINnYFIfroqHw==
X-Google-Smtp-Source: AA0mqf52vlvx+DmZqZf6K5QKyPMTYir9jjGoFZ3rfAtUNdnmIex2oVSQjPVPeaOhgB9VEgaLi+ZZpQ==
X-Received: by 2002:a05:6402:b55:b0:469:bd35:655c with SMTP id bx21-20020a0564020b5500b00469bd35655cmr33346191edb.245.1669665748611;
        Mon, 28 Nov 2022 12:02:28 -0800 (PST)
Received: from localhost.localdomain ([109.172.173.254])
        by smtp.googlemail.com with ESMTPSA id k21-20020a17090666d500b0073a20469f31sm5314086ejp.41.2022.11.28.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 12:02:28 -0800 (PST)
From:   Zurab Kargareteli <zuraxt@gmail.com>
Cc:     trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        Zurab Kargareteli <zuraxt@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH] cpupower: Add Georgian translation
Date:   Tue, 29 Nov 2022 00:01:27 +0400
Message-Id: <20221128200213.11796-1-zuraxt@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Georgian language for cpupower

Signed-off-by: Zurab Kargareteli <zuraxt@gmail.com>

changelog:

- Initial commit of Georgian translation
---
 tools/power/cpupower/po/ka.po | 983 ++++++++++++++++++++++++++++++++++
 1 file changed, 983 insertions(+)
 create mode 100644 tools/power/cpupower/po/ka.po

diff --git a/tools/power/cpupower/po/ka.po b/tools/power/cpupower/po/ka.po
new file mode 100644
index 000000000000..ef71dbac5a13
--- /dev/null
+++ b/tools/power/cpupower/po/ka.po
@@ -0,0 +1,983 @@
+# Georgian translation for cpufrequtils package
+# Georgian messages for cpufrequtils.
+# Copyright (C) 2004-2022 Dominik Brodowski <linux@dominikbrodowski.net>
+# This file is distributed under the same license as the cpufrequtils package.
+# Ekaterine Papava <katopapava@gmail.com>, 2022.
+
+msgid ""
+msgstr ""
+"Project-Id-Version: cpufrequtils 006\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2011-03-08 17:03+0100\n"
+"PO-Revision-Date: 2022-09-18 22:12+0200\n"
+"Last-Translator: Ekaterine Papava <katopapava@gmail.com>\n"
+"Language-Team: NONE\n"
+"Language: ka\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+"X-Generator: Poedit 3.1.1\n"
+
+#: utils/idle_monitor/nhm_idle.c:36
+msgid "Processor Core C3"
+msgstr "პროცესორის ბირთვი C3"
+
+#: utils/idle_monitor/nhm_idle.c:43
+msgid "Processor Core C6"
+msgstr "პროცესორის ბირთვი C6"
+
+#: utils/idle_monitor/nhm_idle.c:51
+msgid "Processor Package C3"
+msgstr "პროცესორის პაკეტი C3"
+
+#: utils/idle_monitor/nhm_idle.c:58 utils/idle_monitor/amd_fam14h_idle.c:70
+msgid "Processor Package C6"
+msgstr "პროცესორის პაკეტი C6"
+
+#: utils/idle_monitor/snb_idle.c:33
+msgid "Processor Core C7"
+msgstr "პროცესორის Core C7"
+
+#: utils/idle_monitor/snb_idle.c:40
+msgid "Processor Package C2"
+msgstr "პროცესორის პაკეტი C2"
+
+#: utils/idle_monitor/snb_idle.c:47
+msgid "Processor Package C7"
+msgstr "პროცესორის პაკეტი C7"
+
+#: utils/idle_monitor/amd_fam14h_idle.c:56
+msgid "Package in sleep state (PC1 or deeper)"
+msgstr "პაკეტი ძილის მდგომარეობაში (PC1 ან ღრმა)"
+
+#: utils/idle_monitor/amd_fam14h_idle.c:63
+msgid "Processor Package C1"
+msgstr "პროცესორის პაკეტი C1"
+
+#: utils/idle_monitor/amd_fam14h_idle.c:77
+msgid "North Bridge P1 boolean counter (returns 0 or 1)"
+msgstr "ჩრდილო ხიდის P1 ლოგიკური მთვლელი (აბრუნებს 0 ან 1-ს)"
+
+#: utils/idle_monitor/mperf_monitor.c:35
+msgid "Processor Core not idle"
+msgstr "პროცესორის ბირთვი უქმი არაა"
+
+#: utils/idle_monitor/mperf_monitor.c:42
+msgid "Processor Core in an idle state"
+msgstr "პროცესორის ბირთვი უქმ მდგომარეობაში არაა"
+
+#: utils/idle_monitor/mperf_monitor.c:50
+msgid "Average Frequency (including boost) in MHz"
+msgstr "საშუალო სიხშირე (პიკურის ჩათვლით) მეგაჰერცებში"
+
+#: utils/idle_monitor/cpupower-monitor.c:66
+#, c-format
+msgid ""
+"cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c command ...]\n"
+msgstr ""
+"cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"ინტერვალი_წმ | -c ბრძანება ...]\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:69
+#, c-format
+msgid ""
+"cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c command ...]\n"
+msgstr ""
+"cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"ინტერვალი_წმ | -c ბრძანება ...]\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:71
+#, c-format
+msgid "\t -v: be more verbose\n"
+msgstr "\t -v: დამატებითი ინფორმაციის გამოტანა\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:73
+#, c-format
+msgid "\t -h: print this help\n"
+msgstr "\t -h: ამ დახმარების გამოტანა\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:74
+#, c-format
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
+msgstr ""
+"\t -i: გასაზომი დროის ინტერვალი, წამებში (ნაგულისხმები მნიშვნელობაა 1)\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:75
+#, c-format
+msgid "\t -t: show CPU topology/hierarchy\n"
+msgstr "\t -t: CPU -ის ტოპოლოგიის/იერარქიის ჩვენება\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:76
+#, c-format
+msgid "\t -l: list available CPU sleep monitors (for use with -m)\n"
+msgstr ""
+"\t -l: CPU-ის ძილის მონიტორების სიის გამოტანა (განკუთვნილია -m -სთან ერთად "
+"გამოსაყენებლად)\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:77
+#, c-format
+msgid "\t -m: show specific CPU sleep monitors only (in same order)\n"
+msgstr ""
+"\t -m: მხოლოდ მითითებული CPU-ის ძილის მონიტორების ჩვენება (იგივე "
+"მიმდევრობით)\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:79
+#, c-format
+msgid ""
+"only one of: -t, -l, -m are allowed\n"
+"If none of them is passed,"
+msgstr ""
+"დასაშვებია მხოლოდ ერთ-ერთის: -t, -l ან -m მითითება\n"
+"თუ მითითებული არც ერთი არაა,"
+
+#: utils/idle_monitor/cpupower-monitor.c:80
+#, c-format
+msgid " all supported monitors are shown\n"
+msgstr " ნაჩვენები იქნება ყველა მხარდაჭერილი მონიტორი\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:197
+#, c-format
+msgid "Monitor %s, Counter %s has no count function. Implementation error\n"
+msgstr ""
+"მონიტორი %s, მთვლელი %s. დათვლის ფუნქცია არ გააჩნია. განხორციელების შეცდომა\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:207
+#, c-format
+msgid " *is offline\n"
+msgstr " *გათიშულია\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:236
+#, c-format
+msgid "%s: max monitor name length (%d) exceeded\n"
+msgstr "%s: მონიტორის სახელის მაქსიმალური სიგრძე (%d) გადაჭარბებულია\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:250
+#, c-format
+msgid "No matching monitor found in %s, try -l option\n"
+msgstr "%s-ში აღწერილი მონიტორი ვერ ვიპოვე. სცადეთ -l პარამეტრი\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:266
+#, c-format
+msgid "Monitor \"%s\" (%d states) - Might overflow after %u s\n"
+msgstr "მონიტორი \"%s\" (%d მდგომარეობა) - გადაივსება %u წამის შემდეგ\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:319
+#, c-format
+msgid "%s took %.5f seconds and exited with status %d\n"
+msgstr "%s-ს %.5f წამი დასჭირდა და მუშაობა სტატუსით %d დაასრულა\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:406
+#, c-format
+msgid "Cannot read number of available processors\n"
+msgstr "ხელმისაწვდომი პროცესორების რიცხვის წაკითხვა შეუძლებელია\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:417
+#, c-format
+msgid "Available monitor %s needs root access\n"
+msgstr "ხელმისაწვდომ მონიტორს (%s) root-ის წვდომს სჭირდება\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:428
+#, c-format
+msgid "No HW Cstate monitors found\n"
+msgstr "აპარატურული C-მდგომარეობის მონიტორები ვერ ვიპოვე\n"
+
+#: utils/cpupower.c:78
+#, c-format
+msgid "cpupower [ -c cpulist ] subcommand [ARGS]\n"
+msgstr "cpupower [ -c cpu-ებისსია ] ქვებრძანება [არგუმენტები]\n"
+
+#: utils/cpupower.c:79
+#, c-format
+msgid "cpupower --version\n"
+msgstr "cpupower --version\n"
+
+#: utils/cpupower.c:80
+#, c-format
+msgid "Supported subcommands are:\n"
+msgstr "ხელმისაწვდომი ქვებრძანებებია:\n"
+
+#: utils/cpupower.c:83
+#, c-format
+msgid ""
+"\n"
+"Some subcommands can make use of the -c cpulist option.\n"
+msgstr ""
+"\n"
+"ზოგიერთ ქვებრძანებას შეუძლია -c cpu-ებისსია პარამეტრი გამოიყენოს.\n"
+
+#: utils/cpupower.c:84
+#, c-format
+msgid "Look at the general cpupower manpage how to use it\n"
+msgstr ""
+"გამოყენების ინსტრუქციისთვის cpupower-ის სახელმძღვანელოში (manpage) ჩაიხედეთ\n"
+
+#: utils/cpupower.c:85
+#, c-format
+msgid "and read up the subcommand's manpage whether it is supported.\n"
+msgstr ""
+"და წაიკითხეთ ქვებრძანების სახელმძღვანელო (manpage), თუ ის მხარდაჭერილია.\n"
+
+#: utils/cpupower.c:86
+#, c-format
+msgid ""
+"\n"
+"Use cpupower help subcommand for getting help for above subcommands.\n"
+msgstr ""
+"\n"
+"ზემოთ მოყვანილი ქვებრძანებების შესახებ ინფორმაციის მისაღებად გამოიყენეთ "
+"cpupower help ქვებრძანების_სახელი.\n"
+
+#: utils/cpupower.c:91
+#, c-format
+msgid "Report errors and bugs to %s, please.\n"
+msgstr "გთხოვთ, შეცდომების შესახებ გვაცნობეთ აქ; %s.\n"
+
+#: utils/cpupower.c:114
+#, c-format
+msgid "Error parsing cpu list\n"
+msgstr "CPU-ების სიის დამუშავების შეცდომა\n"
+
+#: utils/cpupower.c:172
+#, c-format
+msgid "Subcommand %s needs root privileges\n"
+msgstr "ქვებრძანებას %s root-ის პრივილეგიები სჭირდება\n"
+
+#: utils/cpufreq-info.c:31
+#, c-format
+msgid "Couldn't count the number of CPUs (%s: %s), assuming 1\n"
+msgstr ""
+"CPU-ების (%s: %s) რაოდენობის მიღების შეცდომა. ჩაითვლება, რომ უდრის 1-ს\n"
+
+#: utils/cpufreq-info.c:63
+#, c-format
+msgid ""
+"          minimum CPU frequency  -  maximum CPU frequency  -  governor\n"
+msgstr ""
+"          CPU-ის მინიმალური სიხშირე  -  CPU-ის მაქსიმალური სიხშირე  -  "
+"მმართველი\n"
+
+#: utils/cpufreq-info.c:151
+#, c-format
+msgid "Error while evaluating Boost Capabilities on CPU %d -- are you root?\n"
+msgstr ""
+"შეცდომა %d-ე CPU-ის პიკური დატვირთვის მართვის შესაძლებლობების შეფასებისას -- "
+"გაქვთ თუ არა root პრივილეგიები?\n"
+
+#. P state changes via MSR are identified via cpuid 80000007
+#. on Intel and AMD, but we assume boost capable machines can do that
+#. if (cpuid_eax(0x80000000) >= 0x80000007
+#. && (cpuid_edx(0x80000007) & (1 << 7)))
+#.
+#: utils/cpufreq-info.c:161
+#, c-format
+msgid "  boost state support: \n"
+msgstr "  პიკის მდგომარეობის მხარდაჭერა: \n"
+
+#: utils/cpufreq-info.c:163
+#, c-format
+msgid "    Supported: %s\n"
+msgstr "    მხარდაჭერილია: %s\n"
+
+#: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
+msgid "yes"
+msgstr "დიახ"
+
+#: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
+msgid "no"
+msgstr "არა"
+
+#: utils/cpufreq-info.c:164
+#, c-format
+msgid "    Active: %s\n"
+msgstr "    აქტიური: %s\n"
+
+#: utils/cpufreq-info.c:177
+#, c-format
+msgid "    Boost States: %d\n"
+msgstr "    პიკის მდგომარეობები: %d\n"
+
+#: utils/cpufreq-info.c:178
+#, c-format
+msgid "    Total States: %d\n"
+msgstr "    სულ მდგომარეობები: %d\n"
+
+#: utils/cpufreq-info.c:181
+#, c-format
+msgid "    Pstate-Pb%d: %luMHz (boost state)\n"
+msgstr "    Pstate-Pb%d: %luმჰც (პიკში)\n"
+
+#: utils/cpufreq-info.c:184
+#, c-format
+msgid "    Pstate-P%d:  %luMHz\n"
+msgstr "    Pstate-P%d:  %luმჰც\n"
+
+#: utils/cpufreq-info.c:211
+#, c-format
+msgid "  no or unknown cpufreq driver is active on this CPU\n"
+msgstr " ამ CPU-ზე cpufreq-ის დრაივერი უცნობია, ან არ არსებობს\n"
+
+#: utils/cpufreq-info.c:213
+#, c-format
+msgid "  driver: %s\n"
+msgstr "  დრაივერი: %s\n"
+
+#: utils/cpufreq-info.c:219
+#, c-format
+msgid "  CPUs which run at the same hardware frequency: "
+msgstr "  CPU-ები, რომლებიც ერთი და იგივე აპარატურულ სიხშირეზე მუშაობენ: "
+
+#: utils/cpufreq-info.c:230
+#, c-format
+msgid "  CPUs which need to have their frequency coordinated by software: "
+msgstr "  CPU-ები, რომლებსაც მათი სიხშირის პროგრამული კოორდინაცია სჭირდებათ: "
+
+#: utils/cpufreq-info.c:241
+#, c-format
+msgid "  maximum transition latency: "
+msgstr "  მაქსიმალური გარდამავალი დაყოვნება: "
+
+#: utils/cpufreq-info.c:247
+#, c-format
+msgid "  hardware limits: "
+msgstr "  აპარატურული ლიმიტები: "
+
+#: utils/cpufreq-info.c:256
+#, c-format
+msgid "  available frequency steps: "
+msgstr "  ხელმისაწვდომი სიხშირის ბიჯები: "
+
+#: utils/cpufreq-info.c:269
+#, c-format
+msgid "  available cpufreq governors: "
+msgstr "  cpufreq -ის ხელმისაწვდომი მმართველები: "
+
+#: utils/cpufreq-info.c:280
+#, c-format
+msgid "  current policy: frequency should be within "
+msgstr "  მიმდინარე პოლიტიკა: სიხშირის დიაპაზონია "
+
+#: utils/cpufreq-info.c:282
+#, c-format
+msgid " and "
+msgstr " და "
+
+#: utils/cpufreq-info.c:286
+#, c-format
+msgid ""
+"The governor \"%s\" may decide which speed to use\n"
+"                  within this range.\n"
+msgstr ""
+"მმართველს \"%s\" შეუძლია გადაწყვიტოს, რომელი სიჩქარე გამოიყენოს\n"
+"                                                         ამ დიაპაზონიდან.\n"
+
+#: utils/cpufreq-info.c:293
+#, c-format
+msgid "  current CPU frequency is "
+msgstr "  CPU-ის მიმდინარე სიხშირეა "
+
+#: utils/cpufreq-info.c:296
+#, c-format
+msgid " (asserted by call to hardware)"
+msgstr " (დამტკიცებულია აპარატურული გადამოწმებით)"
+
+#: utils/cpufreq-info.c:304
+#, c-format
+msgid "  cpufreq stats: "
+msgstr "  cpufreq -ის სტატისტიკა: "
+
+#: utils/cpufreq-info.c:472
+#, c-format
+msgid "Usage: cpupower freqinfo [options]\n"
+msgstr "გამოყენება: cpupower freqinfo [პარამეტრები]\n"
+
+#: utils/cpufreq-info.c:473 utils/cpufreq-set.c:26 utils/cpupower-set.c:23
+#: utils/cpupower-info.c:22 utils/cpuidle-info.c:148
+#, c-format
+msgid "Options:\n"
+msgstr "პარამეტრები:\n"
+
+#: utils/cpufreq-info.c:474
+#, c-format
+msgid "  -e, --debug          Prints out debug information [default]\n"
+msgstr "  -e, --debug          გამართვის ინფორმაციის ჩვენება [ნაგულისხმები]\n"
+
+#: utils/cpufreq-info.c:475
+#, c-format
+msgid ""
+"  -f, --freq           Get frequency the CPU currently runs at, according\n"
+"                       to the cpufreq core *\n"
+msgstr ""
+"  -f, --freq          სიხშირის მიღება, რომლითაც CPU ამჟამად მუშაობს, \n"
+"                       cpufreq ბირთვის შესაბამისად *\n"
+
+#: utils/cpufreq-info.c:477
+#, c-format
+msgid ""
+"  -w, --hwfreq         Get frequency the CPU currently runs at, by reading\n"
+"                       it from hardware (only available to root) *\n"
+msgstr ""
+"  -w, --hwfreq         სიხშირის მიღება, რომლითაც CPU ახლა მუშაობს, "
+"მნიშვნელობის\n"
+"                       პირდაპირ აპარატურიდან წაკითხვით (საჭიროა root-ის "
+"პრივილეგიები) *\n"
+
+#: utils/cpufreq-info.c:479
+#, c-format
+msgid ""
+"  -l, --hwlimits       Determine the minimum and maximum CPU frequency "
+"allowed *\n"
+msgstr ""
+"  -l, --hwlimits       CPU-ის მინიმალური და მაქსიმალური დასაშვები სიხშირის "
+"განსაზღვრა *\n"
+
+#: utils/cpufreq-info.c:480
+#, c-format
+msgid "  -d, --driver         Determines the used cpufreq kernel driver *\n"
+msgstr ""
+"  -d, --driver         ბირთვის მიერ გამოყენებული cpufreq -ის დრაივერი *\n"
+
+#: utils/cpufreq-info.c:481
+#, c-format
+msgid "  -p, --policy         Gets the currently used cpufreq policy *\n"
+msgstr ""
+"  -p, --policy         cpufreq -ის ამჟამად გამოყენებული პოლიტიკის მიღება*\n"
+
+#: utils/cpufreq-info.c:482
+#, c-format
+msgid "  -g, --governors      Determines available cpufreq governors *\n"
+msgstr ""
+"  -g, --governors      cpufreq-ის ხელმისაწვდომი მმართველების დადგენა *\n"
+
+#: utils/cpufreq-info.c:483
+#, c-format
+msgid ""
+"  -r, --related-cpus   Determines which CPUs run at the same hardware "
+"frequency *\n"
+msgstr ""
+"  -r, --related-cpus   განსაზღვრავს, რომელი CPU-ები მუშაობს ერთი და იგივე "
+"აპარატურულ სიხშირეზე *\n"
+
+#: utils/cpufreq-info.c:484
+#, c-format
+msgid ""
+"  -a, --affected-cpus  Determines which CPUs need to have their frequency\n"
+"                       coordinated by software *\n"
+msgstr ""
+"  -a, --affected-cpus  განსაზღვრავს, რომელი CPU-ებს სჭირდებათ მათი სიხშირის\n"
+"                       პროგრამული კოორდინაცია *\n"
+
+#: utils/cpufreq-info.c:486
+#, c-format
+msgid "  -s, --stats          Shows cpufreq statistics if available\n"
+msgstr ""
+"  -s, --stats          cpufreq -ის სტატისტიკის ჩვენება, თუ ის "
+"ხელმისაწვდომია\n"
+
+#: utils/cpufreq-info.c:487
+#, c-format
+msgid ""
+"  -y, --latency        Determines the maximum latency on CPU frequency "
+"changes *\n"
+msgstr ""
+"  -y, --latency        CPU -ის სიხშირის ცვლილების მაქსიმალური დაყოვნების "
+"დადგენა *\n"
+
+#: utils/cpufreq-info.c:488
+#, c-format
+msgid "  -b, --boost          Checks for turbo or boost modes  *\n"
+msgstr "  -b, --boost          ტურბო და პიკური რეჟიმების შემოწმება  *\n"
+
+#: utils/cpufreq-info.c:489
+#, c-format
+msgid ""
+"  -o, --proc           Prints out information like provided by the /proc/"
+"cpufreq\n"
+"                       interface in 2.4. and early 2.6. kernels\n"
+msgstr ""
+"  -o, --proc           გამოიტანს ინფორმაციას, რომელიც /proc/cpufreq-ის "
+"მიერაა მოწოდებული.\n"
+"                       ეს ინტერფეისი 2.4. და ადრეულ 2.6. ბირთვებში იყო "
+"ხელმისაწვდომი\n"
+
+#: utils/cpufreq-info.c:491
+#, c-format
+msgid ""
+"  -m, --human          human-readable output for the -f, -w, -s and -y "
+"parameters\n"
+msgstr ""
+"  -m, --human           -f, -w, -s და -y პარამეტრების გამოტანის "
+"ადამიანისთვის გასაგებ ფორმატში ჩვენება\n"
+
+#: utils/cpufreq-info.c:492 utils/cpuidle-info.c:152
+#, c-format
+msgid "  -h, --help           Prints out this screen\n"
+msgstr "  -h, --help           ამ ეკრანის გამოტანა\n"
+
+#: utils/cpufreq-info.c:495
+#, c-format
+msgid ""
+"If no argument or only the -c, --cpu parameter is given, debug output about\n"
+"cpufreq is printed which is useful e.g. for reporting bugs.\n"
+msgstr ""
+"თუ არგუმენტები საერთოდ არ გადაცემულა ან გადაცემულია -c ან --cpu, მოხდება "
+"cpufreq-ის\n"
+"დრაივერის დამატებითი შეტყობინებების გამოტანა, რომელიც გამართვისთვისაა "
+"საჭირო.\n"
+
+#: utils/cpufreq-info.c:497
+#, c-format
+msgid ""
+"For the arguments marked with *, omitting the -c or --cpu argument is\n"
+"equivalent to setting it to zero\n"
+msgstr ""
+"არგუმენტებისთვის, რომლებიც *-ით არიან მონიშნულები, -c/--cpu \n"
+"არგუმენტის გამოტოვება მის ნულოვან მნიშვნელობაზე დაყენებას უდრის\n"
+
+#: utils/cpufreq-info.c:580
+#, c-format
+msgid ""
+"The argument passed to this tool can't be combined with passing a --cpu "
+"argument\n"
+msgstr ""
+"ამ პროგრამისთვის გადაცემული არგუმენტის --cpu არგუმენტთან გადაცემა ერთად არ "
+"შეიძლება\n"
+
+#: utils/cpufreq-info.c:596
+#, c-format
+msgid ""
+"You can't specify more than one --cpu parameter and/or\n"
+"more than one output-specific argument\n"
+msgstr ""
+"ერთ --cpu პარამეტრზე ან/და ერთ გამოტანის-შესატყვისი \n"
+"არგუმენტზე მეტის მითითება აკრძალულია\n"
+
+#: utils/cpufreq-info.c:600 utils/cpufreq-set.c:82 utils/cpupower-set.c:42
+#: utils/cpupower-info.c:42 utils/cpuidle-info.c:213
+#, c-format
+msgid "invalid or unknown argument\n"
+msgstr "არასწორი ან უცნობი არგუმენტი\n"
+
+#: utils/cpufreq-info.c:617
+#, c-format
+msgid "couldn't analyze CPU %d as it doesn't seem to be present\n"
+msgstr "%d-ე CPU-ის ანალიზი შეუძლებელია. ის არ არსებობს\n"
+
+#: utils/cpufreq-info.c:620 utils/cpupower-info.c:142
+#, c-format
+msgid "analyzing CPU %d:\n"
+msgstr "%d-ე CPU -ის ანალიზი:\n"
+
+#: utils/cpufreq-set.c:25
+#, c-format
+msgid "Usage: cpupower frequency-set [options]\n"
+msgstr "გამოყენება: cpupower frequency-set [პარამეტრები]\n"
+
+#: utils/cpufreq-set.c:27
+#, c-format
+msgid ""
+"  -d FREQ, --min FREQ      new minimum CPU frequency the governor may "
+"select\n"
+msgstr ""
+"  -d FREQ, --min FREQ      CPU-ის ახალი მინიმალური სიხშირე, რომელიც "
+"მმართველს შეუძლია, აირჩიოს\n"
+
+#: utils/cpufreq-set.c:28
+#, c-format
+msgid ""
+"  -u FREQ, --max FREQ      new maximum CPU frequency the governor may "
+"select\n"
+msgstr ""
+"  -u FREQ, --max FREQ      CPU-ის ახალი მაქსიმალური სიხშირე, რომელიც "
+"მმართველს შეუძლია, აირჩიოს\n"
+
+#: utils/cpufreq-set.c:29
+#, c-format
+msgid "  -g GOV, --governor GOV   new cpufreq governor\n"
+msgstr "  -g GOV, --governor GOV   cpufreq-ის ახალი მმართველი\n"
+
+#: utils/cpufreq-set.c:30
+#, c-format
+msgid ""
+"  -f FREQ, --freq FREQ     specific frequency to be set. Requires userspace\n"
+"                           governor to be available and loaded\n"
+msgstr ""
+"  -f FREQ, --freq FREQ     მითითებული სიხშირის დაყენება. საჭიროა, "
+"მომხმარებლის სივრცეში გაშვებული\n"
+"                           მმართველი ხელმისაწვდომი და ჩატვირთული იყოს\n"
+
+#: utils/cpufreq-set.c:32
+#, c-format
+msgid "  -r, --related            Switches all hardware-related CPUs\n"
+msgstr ""
+"  -r, --related            ყველა აპარატურულად-დაავშირებული CPU-ის გადართვა\n"
+
+#: utils/cpufreq-set.c:33 utils/cpupower-set.c:28 utils/cpupower-info.c:27
+#, c-format
+msgid "  -h, --help               Prints out this screen\n"
+msgstr "  -h, --help           ამ ეკრანის გამოტანა\n"
+
+#: utils/cpufreq-set.c:35
+#, c-format
+msgid ""
+"Notes:\n"
+"1. Omitting the -c or --cpu argument is equivalent to setting it to \"all\"\n"
+msgstr ""
+"შენიშვნა:\n"
+"1. -c/--cpu პარამეტრის გამოტოვება იგივეა, რაც \"all\" (ყველას) მითითება\n"
+
+#: utils/cpufreq-set.c:37
+#, c-format
+msgid ""
+"2. The -f FREQ, --freq FREQ parameter cannot be combined with any other "
+"parameter\n"
+"   except the -c CPU, --cpu CPU parameter\n"
+"3. FREQuencies can be passed in Hz, kHz (default), MHz, GHz, or THz\n"
+"   by postfixing the value with the wanted unit name, without any space\n"
+"   (FREQuency in kHz =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000).\n"
+msgstr ""
+"2. The -f FREQ, --freq FREQ პარამეტრის შეთავსება შეუძლებელია სხვა "
+"პარამეტრებთან,\n"
+"   -c CPU, --cpu CPU -ის გარდა\n"
+"3. სიხშირეების გადაცემა შეიძლება ჰერცებში (hz), კილოჰერცებში, (KHz) "
+"(ნაგულისხმები), მეგაჰერცებში (MHz), GHz და THz.\n"
+"   რიცხვის შემდეგ შესაბამისი ერთეულის, გამოტოვების გარეშე, მიწერით\n"
+"   (სიხშირე in kHz(კილოჰერცი) =^ Hz(ჰერცი) * 0.001 =^ MHz(მეგაჰერცი) * 1000 "
+"=^ GHz(გიგაჰერცი) * 1000000).\n"
+
+#: utils/cpufreq-set.c:57
+#, c-format
+msgid ""
+"Error setting new values. Common errors:\n"
+"- Do you have proper administration rights? (super-user?)\n"
+"- Is the governor you requested available and modprobed?\n"
+"- Trying to set an invalid policy?\n"
+"- Trying to set a specific frequency, but userspace governor is not "
+"available,\n"
+"   for example because of hardware which cannot be set to a specific "
+"frequency\n"
+"   or because the userspace governor isn't loaded?\n"
+msgstr ""
+"ახალი მნიშვნელოების დაყენება შეუძლებელია. ხშირად დაშვებული შეცდომებია:\n"
+"- გაქვთ თუ არა ადმინისტრატორის უფლებები? (მომხმარებელი root)\n"
+"- არის თუ არა მოთხოვნილი მმართველი ხელმისაწვდომი და შესაბამისი მოდული "
+"modprobe-ით ჩატვირთული?\n"
+"- ცდილობთ დააყენოთ არასწორი პოლიტიკა?\n"
+"- ცდილობთ დააყენოთ განსაზღვრული სიხშირე მაშინ, როცა მომხმარებლის სივრცის "
+"მმართველი ხელმიუწვდომელია.\n"
+"  მაგალითად აპარატურის გამო, რომელსაც მითითებული სიხშირის დაყენება არ "
+"შეუძლია,\n"
+"  ან იქნებ მომხმარებლის სივრცის მმართველი ჩატვირთული არაა?\n"
+
+#: utils/cpufreq-set.c:170
+#, c-format
+msgid "wrong, unknown or unhandled CPU?\n"
+msgstr "არასწორი, უცნობი ან არასასურველი CPU?\n"
+
+#: utils/cpufreq-set.c:302
+#, c-format
+msgid ""
+"the -f/--freq parameter cannot be combined with -d/--min, -u/--max or\n"
+"-g/--governor parameters\n"
+msgstr ""
+"პარამეტრი -f/--freq არ შეიძლება-d/--min, -u/--max და\n"
+"-g/--governor პარამეტრებთან ერთად იყოს მითითებული\n"
+
+#: utils/cpufreq-set.c:308
+#, c-format
+msgid ""
+"At least one parameter out of -f/--freq, -d/--min, -u/--max, and\n"
+"-g/--governor must be passed\n"
+msgstr ""
+"საჭიროა -f/--freq, -d/--min, -u/--max, and\n"
+"-g/--governor პარამეტრებიდან ერთის გადაცემა მაინც\n"
+
+#: utils/cpufreq-set.c:347
+#, c-format
+msgid "Setting cpu: %d\n"
+msgstr "CPU-ის დაყენება: %d\n"
+
+#: utils/cpupower-set.c:22
+#, c-format
+msgid "Usage: cpupower set [ -b val ] [ -m val ] [ -s val ]\n"
+msgstr "გამოყენება: cpupower set [ -b მნიშვნ ] [ -m მნიშვნ ] [ -s მნიშვნ ]\n"
+
+#: utils/cpupower-set.c:24
+#, c-format
+msgid ""
+"  -b, --perf-bias [VAL]    Sets CPU's power vs performance policy on some\n"
+"                           Intel models [0-15], see manpage for details\n"
+msgstr ""
+"  -b, --perf-bias [VAL]    Intel-ის ზოგიერთ მოდელზე [0-15] CPU-ის კვებასა და "
+"წარმადობას შორის დამოკიდებულების დაყენება\n"
+"                           მეტი დეტალისთვის იხილეთ სახელმძღვანელო (manpage)\n"
+
+#: utils/cpupower-set.c:26
+#, c-format
+msgid ""
+"  -m, --sched-mc  [VAL]    Sets the kernel's multi core scheduler policy.\n"
+msgstr ""
+"  -m, --sched-mc   [VAL]     ბირთვის მრავალბირთვიანობის მგეგმავის პოლიტიკის "
+"დაყენება.\n"
+
+#: utils/cpupower-set.c:27
+#, c-format
+msgid ""
+"  -s, --sched-smt [VAL]    Sets the kernel's thread sibling scheduler "
+"policy.\n"
+msgstr ""
+"  -s, --sched-smt  [VAL]    ბირთვის ნაკადის დის მგეგმავის პოლიტიკის "
+"დაყენება.\n"
+
+#: utils/cpupower-set.c:80
+#, c-format
+msgid "--perf-bias param out of range [0-%d]\n"
+msgstr "--perf-bias პარამეტრი დიაპაზონიდან [0-%d]\n"
+
+#: utils/cpupower-set.c:91
+#, c-format
+msgid "--sched-mc param out of range [0-%d]\n"
+msgstr "--sched-mc პარამეტრი დიაპაზონიდან [0-%d]\n"
+
+#: utils/cpupower-set.c:102
+#, c-format
+msgid "--sched-smt param out of range [0-%d]\n"
+msgstr "--sched-smt პარამეტრი დიაპაზონიდან [0-%d]\n"
+
+#: utils/cpupower-set.c:121
+#, c-format
+msgid "Error setting sched-mc %s\n"
+msgstr "შეცდომა sched-mc -ის დაყენებისას: %s\n"
+
+#: utils/cpupower-set.c:127
+#, c-format
+msgid "Error setting sched-smt %s\n"
+msgstr "შეცდომა sched-smt-ის დაყენებისას: %s\n"
+
+#: utils/cpupower-set.c:146
+#, c-format
+msgid "Error setting perf-bias value on CPU %d\n"
+msgstr "%d-ე CPU-ზე perf-bias -ის მნიშვნელობის დაყენების შეცდომა\n"
+
+#: utils/cpupower-info.c:21
+#, c-format
+msgid "Usage: cpupower info [ -b ] [ -m ] [ -s ]\n"
+msgstr "გამოყენება: cpupower info [ -b ] [ -m ] [ -s ]\n"
+
+#: utils/cpupower-info.c:23
+#, c-format
+msgid ""
+"  -b, --perf-bias    Gets CPU's power vs performance policy on some\n"
+"                           Intel models [0-15], see manpage for details\n"
+msgstr ""
+"  -b, --perf-bias [VAL]    Intel-ის ზოგიერთ მოდელზე [0-15] CPU-ის კვებასა და "
+"წარმადობას შორის დამოკიდებულების მიღება\n"
+"                           მეტი დეტალისთვის იხილეთ სახელმძღვანელო (manpage)\n"
+
+#: utils/cpupower-info.c:25
+#, c-format
+msgid "  -m, --sched-mc     Gets the kernel's multi core scheduler policy.\n"
+msgstr ""
+"  -m, --sched-mc     ბირთვის მრავალბირთვიანობის მგეგმავის პოლიტიკის მიღება.\n"
+
+#: utils/cpupower-info.c:26
+#, c-format
+msgid ""
+"  -s, --sched-smt    Gets the kernel's thread sibling scheduler policy.\n"
+msgstr "  -s, --sched-smt    ბირთვის ნაკადის დის მგეგმავის პოლიტიკის მიღება.\n"
+
+#: utils/cpupower-info.c:28
+#, c-format
+msgid ""
+"\n"
+"Passing no option will show all info, by default only on core 0\n"
+msgstr ""
+"\n"
+"მნიშვნელობის არ-გადაცემის შემთხვევაში ნაჩვენები იქნება სრული ინფორმაცია. "
+"ნაგულისხმევად მხოლოდ ნულოვან ბირთვზე\n"
+
+#: utils/cpupower-info.c:102
+#, c-format
+msgid "System's multi core scheduler setting: "
+msgstr "სისტემის მრავალბირთვიანობის მმართველის პარამეტრი: "
+
+#. if sysfs file is missing it's: errno == ENOENT
+#: utils/cpupower-info.c:105 utils/cpupower-info.c:114
+#, c-format
+msgid "not supported\n"
+msgstr "მხარდაუჭერელია\n"
+
+#: utils/cpupower-info.c:111
+#, c-format
+msgid "System's thread sibling scheduler setting: "
+msgstr "სისტემის ნაკადის დის მართვის პარამეტრი: "
+
+#: utils/cpupower-info.c:126
+#, c-format
+msgid "Intel's performance bias setting needs root privileges\n"
+msgstr "Intel-ის წარმადობის bias-ის დაყენებას root-ის პრივილეგიები სჭირდება\n"
+
+#: utils/cpupower-info.c:128
+#, c-format
+msgid "System does not support Intel's performance bias setting\n"
+msgstr ""
+"სისტემას intel-ის performance bias-ის დაყენების მხარდაჭერა არ გააჩნია\n"
+
+#: utils/cpupower-info.c:147
+#, c-format
+msgid "Could not read perf-bias value\n"
+msgstr "შეცდომა perf-bias -ის მნიშვნელობის წაკითხვისას\n"
+
+#: utils/cpupower-info.c:150
+#, c-format
+msgid "perf-bias: %d\n"
+msgstr "perf-bias: %d\n"
+
+#: utils/cpuidle-info.c:28
+#, c-format
+msgid "Analyzing CPU %d:\n"
+msgstr "%d-ე CPU -ის ანალიზი:\n"
+
+#: utils/cpuidle-info.c:32
+#, c-format
+msgid "CPU %u: No idle states\n"
+msgstr "CPU %u: უქმი მდგომარეობების გარეშე\n"
+
+#: utils/cpuidle-info.c:36
+#, c-format
+msgid "CPU %u: Can't read idle state info\n"
+msgstr "CPU %u: უქმი მდგომარეობის ინფორმაციის წაკითხვა შეუძლებელია\n"
+
+#: utils/cpuidle-info.c:41
+#, c-format
+msgid "Could not determine max idle state %u\n"
+msgstr "მაქსიმალური უქმე მდგომარეობის %u დადგენის შეცდომა\n"
+
+#: utils/cpuidle-info.c:46
+#, c-format
+msgid "Number of idle states: %d\n"
+msgstr "უქმე მდგომარეობების რაოდენობა: %d\n"
+
+#: utils/cpuidle-info.c:48
+#, c-format
+msgid "Available idle states:"
+msgstr "ხელმისაწვდომი უქმე მდგომარეობები:"
+
+#: utils/cpuidle-info.c:71
+#, c-format
+msgid "Flags/Description: %s\n"
+msgstr "ალმები/აღწერა: %s\n"
+
+#: utils/cpuidle-info.c:74
+#, c-format
+msgid "Latency: %lu\n"
+msgstr "დაყოვება: %lu\n"
+
+#: utils/cpuidle-info.c:76
+#, c-format
+msgid "Usage: %lu\n"
+msgstr "გამოყენება: %lu\n"
+
+#: utils/cpuidle-info.c:78
+#, c-format
+msgid "Duration: %llu\n"
+msgstr "ხანგრძლივობა: %llu\n"
+
+#: utils/cpuidle-info.c:90
+#, c-format
+msgid "Could not determine cpuidle driver\n"
+msgstr "CPUidle-ის დრაივერის დადგენის შეცდომა\n"
+
+#: utils/cpuidle-info.c:94
+#, c-format
+msgid "CPUidle driver: %s\n"
+msgstr "CPUidle -ის დრაივერი: %s\n"
+
+#: utils/cpuidle-info.c:99
+#, c-format
+msgid "Could not determine cpuidle governor\n"
+msgstr "CPUidle-ის მმართველის დადგენის შეცდომა\n"
+
+#: utils/cpuidle-info.c:103
+#, c-format
+msgid "CPUidle governor: %s\n"
+msgstr "CPUidle მმართველი: %s\n"
+
+#: utils/cpuidle-info.c:122
+#, c-format
+msgid "CPU %u: Can't read C-state info\n"
+msgstr "CPU %u: C-state -ის ინფორმაციის წაკითხვის შეცდომა\n"
+
+#. printf("Cstates: %d\n", cstates);
+#: utils/cpuidle-info.c:127
+#, c-format
+msgid "active state:            C0\n"
+msgstr "აქტიური მდგომარეობა:            C0\n"
+
+#: utils/cpuidle-info.c:128
+#, c-format
+msgid "max_cstate:              C%u\n"
+msgstr "max_cstate:              C%u\n"
+
+#: utils/cpuidle-info.c:129
+#, c-format
+msgid "maximum allowed latency: %lu usec\n"
+msgstr "მაქსიმალური დასაშვები დაყოვნება: %lu usec\n"
+
+#: utils/cpuidle-info.c:130
+#, c-format
+msgid "states:\t\n"
+msgstr "მდგომარეობები:\t\n"
+
+#: utils/cpuidle-info.c:132
+#, c-format
+msgid "    C%d:                  type[C%d] "
+msgstr "    C%d:                  ტიპი[C%d] "
+
+#: utils/cpuidle-info.c:134
+#, c-format
+msgid "promotion[--] demotion[--] "
+msgstr "promotion[--] demotion[--] "
+
+#: utils/cpuidle-info.c:135
+#, c-format
+msgid "latency[%03lu] "
+msgstr "დაყოვნება[%03lu] "
+
+#: utils/cpuidle-info.c:137
+#, c-format
+msgid "usage[%08lu] "
+msgstr "გამოყენება[%08lu] "
+
+#: utils/cpuidle-info.c:139
+#, c-format
+msgid "duration[%020Lu] \n"
+msgstr "ხანგრძლივობა[%020Lu] \n"
+
+#: utils/cpuidle-info.c:147
+#, c-format
+msgid "Usage: cpupower idleinfo [options]\n"
+msgstr "გამოყენება: cpupower idleinfo [პარამეტრები]\n"
+
+#: utils/cpuidle-info.c:149
+#, c-format
+msgid "  -s, --silent         Only show general C-state information\n"
+msgstr "  -s, --silent         მხოლოდ ზოგადი C-state -ის ინფორმაციის ჩვენება\n"
+
+#: utils/cpuidle-info.c:150
+#, c-format
+msgid ""
+"  -o, --proc           Prints out information like provided by the /proc/"
+"acpi/processor/*/power\n"
+"                       interface in older kernels\n"
+msgstr ""
+"  -o, --proc           გამოაქვს ინფორმაცია, როგორც ის /proc/acpi/processor/*/"
+"power ფაილშია აღწერილი.\n"
+"                       ინტერფეისი ძველ ბირთვებში იყო ხელმისაწვდომი\n"
+
+#: utils/cpuidle-info.c:209
+#, c-format
+msgid "You can't specify more than one output-specific argument\n"
+msgstr "ერთზე მეტი გამოტანის-შესატყვისი არგუმენტის მითითება აკრძალულია\n"
-- 
2.30.2

