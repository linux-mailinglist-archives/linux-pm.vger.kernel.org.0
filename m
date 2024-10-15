Return-Path: <linux-pm+bounces-15684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03999F69C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 20:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DBA1F241CA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86D1F8186;
	Tue, 15 Oct 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbLpSH2U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEC1B6D0D;
	Tue, 15 Oct 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018445; cv=none; b=F0ADxgsMvV/jsgNNv8Ta+3nPMsecUbLfDWWbiqC1QurDgoceVsAwES71T6k/mR+NxotG3yJwf0TromoJYERuhsyytnb1CK45Qbp7fkyQUiVzk7yybLkFnHD2QACPAG4cSlqyIA9UDyzEfdc0peB5kP362FPjSpwOsHUXln3+D2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018445; c=relaxed/simple;
	bh=oc6r51IU3ElN0l0y8vAenj78LCwM/tIZljK4TGSj8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k90Y/Znon/RFXtUogWl72KOk5l2OXTagTq4MT/ktgK3+RkNmbFRcstqu6Uu6kx4m0xD+mbhXG3yNB6wqLm0VdMwbFMC5Cd64YL8JTqFD+/psA+AS9cOj+GGrGwpkttPOTqVXWf4qQlNM6NsB+mwz6D7JtyRT2snuryMO9nn/sUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbLpSH2U; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so110772a91.1;
        Tue, 15 Oct 2024 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729018442; x=1729623242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNPQSR+0pzEo54KRzyh9enSvSVnmWo/0DILCTcj87os=;
        b=IbLpSH2U0aBpxQRwo9zqr1411GaAG6Toh5Z5lRMx5AJFH2dO/I0OXdQeIep4t9E3kv
         iBegaMZcOQ1Cxeskru9P/rbXBDF5YzcRQPX5HUWVXmLC5CODPNVD1dmmRtY1JAEXySit
         NZ4dREv/CeWli3kmPXiSx2kjiOVAwwNzvu1hKtuoYRnXbGEi4VmeEBVjO9FsS+yzeeYo
         TxQzy4RvQ1Jh2jMhOYtcbhAKxr/xa9wGTUPA8OfEsSIe7ia7RTUqv5+J9okPfkvXNR0V
         +htN2hr/xRdY5ahvmS0N0I0TwlBR7VCBMiyVwhQerJmqWBQG2oJHtPFi2FTzR9pGMVTI
         tkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018442; x=1729623242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNPQSR+0pzEo54KRzyh9enSvSVnmWo/0DILCTcj87os=;
        b=T+jw27OhY7d+XLZ3I/4Anxzkv9Lu+8Ok64Sqc/3IWT9Rg4aRkpbpM9/jlp0F/tVCyc
         j92qJb4fSFKrXia9HUunnEhW0aHMcPPcQ9SvlmaI9C/n/fpYrqn/twjVf1Xb7lKi14XG
         VHa9AiaSdhFOg6ixzqmEp6Kni5P+TGgcelWYEp2RBZVV/TW2D7NsDnWM7kQ5wLQeD5+D
         PW4DtuwAjTyWL0jUYeTmjOocwTeGw1llReGKQXMHrTK6cO7Zts3yVGDYr48b1Idg/SMo
         xXrNXCmDrM35RUke8+g1wSfHxwmmwD+QK+nZo36xxWFmCJkl1MVv7On0NJnLK5jh5Y5B
         Rq3g==
X-Forwarded-Encrypted: i=1; AJvYcCUIG1Z9dEdWjF9Usg2WYrvTbH+mDHczLlKZvVNgP6dC7mk7Hl3lcR6J9S1edh/NaSqCnN4BBpG315BhVq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLAQSM1IHfNly5ihvS9qezEBAgFZNn/6tqJNkbKJjb8MP8Z99
	T9qBzJCyKk1yQ86syq3qziVFlbtj02t6ZcHo6E/lS+GGtNNhhV860Yvfyimgsn7hW7ux
X-Google-Smtp-Source: AGHT+IEen7axE0w9NVxR90A5UQJAp/inBwaz0evUuqTTInH2Px0xPnb4is8OpBCsNny8khPlmFU0uA==
X-Received: by 2002:a17:90b:3712:b0:2d8:7a63:f9c8 with SMTP id 98e67ed59e1d1-2e3aa151561mr2251397a91.14.1729018441371;
        Tue, 15 Oct 2024 11:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6388:1246::1d2:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b5cfsm15129765ad.205.2024.10.15.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:54:00 -0700 (PDT)
From: Kieran Moy <kfatyuip@gmail.com>
To: shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccheng@linuxfoundation.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH v2] cpupower: Add Chinese Simplified translation
Date: Wed, 16 Oct 2024 02:53:47 +0800
Message-ID: <20241015185348.8306-1-kfatyuip@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for the oversight, thanks for your help!

Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
---
 tools/power/cpupower/Makefile    |   2 +-
 tools/power/cpupower/po/zh_CN.po | 942 +++++++++++++++++++++++++++++++
 2 files changed, 943 insertions(+), 1 deletion(-)
 create mode 100644 tools/power/cpupower/po/zh_CN.po

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f4010..3ea5cb7f3 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -57,7 +57,7 @@ LIB_MIN=			1
 
 PACKAGE =			cpupower
 PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
-LANGUAGES = 			de fr it cs pt ka
+LANGUAGES = 			de fr it cs pt ka zh_CN
 
 
 # Directory definitions. These are default and most probably
diff --git a/tools/power/cpupower/po/zh_CN.po b/tools/power/cpupower/po/zh_CN.po
new file mode 100644
index 000000000..0489abffb
--- /dev/null
+++ b/tools/power/cpupower/po/zh_CN.po
@@ -0,0 +1,942 @@
+# Chinese Simplified translations for cpufrequtils package
+# Copyright (C) 2004 THE PACKAGE'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the cpufrequtils package.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: cpufrequtils 006\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2011-03-08 17:03+0100\n"
+"PO-Revision-Date: 2024-05-22 15:36+0000\n"
+"Last-Translator: Kieran Moy <kfatyuip@gmail.com>\n"
+"Language-Team: NONE\n"
+"Language: zh_CN\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Generator: Poedit 3.4.2\n"
+
+#: utils/idle_monitor/nhm_idle.c:36
+msgid "Processor Core C3"
+msgstr "处理器 Core C3"
+
+#: utils/idle_monitor/nhm_idle.c:43
+msgid "Processor Core C6"
+msgstr "处理器 Core C6"
+
+#: utils/idle_monitor/nhm_idle.c:51
+msgid "Processor Package C3"
+msgstr "处理器套件 C3"
+
+#: utils/idle_monitor/nhm_idle.c:58 utils/idle_monitor/amd_fam14h_idle.c:70
+msgid "Processor Package C6"
+msgstr "处理器套件 C6"
+
+#: utils/idle_monitor/snb_idle.c:33
+msgid "Processor Core C7"
+msgstr "处理器 Core C7"
+
+#: utils/idle_monitor/snb_idle.c:40
+msgid "Processor Package C2"
+msgstr "处理器套件 C2"
+
+#: utils/idle_monitor/snb_idle.c:47
+msgid "Processor Package C7"
+msgstr "处理器套件 C7"
+
+#: utils/idle_monitor/amd_fam14h_idle.c:56
+msgid "Package in sleep state (PC1 or deeper)"
+msgstr "Package in sleep state （PC1 或更深）"
+
+#: utils/idle_monitor/amd_fam14h_idle.c:63
+msgid "Processor Package C1"
+msgstr "处理器套件 C1"
+
+#: utils/idle_monitor/amd_fam14h_idle.c:77
+msgid "North Bridge P1 boolean counter (returns 0 or 1)"
+msgstr "北桥 P1 布尔计数器（返回 0 或 1）"
+
+#: utils/idle_monitor/mperf_monitor.c:35
+msgid "Processor Core not idle"
+msgstr "处理器 Core不空闲"
+
+#: utils/idle_monitor/mperf_monitor.c:42
+msgid "Processor Core in an idle state"
+msgstr "处理器 Core处于空闲状态"
+
+#: utils/idle_monitor/mperf_monitor.c:50
+msgid "Average Frequency (including boost) in MHz"
+msgstr "平均频率（包括增加频率），单位 MHz"
+
+#: utils/idle_monitor/cpupower-monitor.c:66
+#, c-format
+msgid ""
+"cpupower monitor: [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c command ...]\n"
+msgstr ""
+"cpupower monitor：[-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c command...]\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:69
+#, c-format
+msgid ""
+"cpupower monitor: [-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c command ...]\n"
+msgstr ""
+"cpupower monitor：[-v] [-h] [ [-t] | [-l] | [-m <mon1>,[<mon2>] ] ] [-i "
+"interval_sec | -c command...]\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:71
+#, c-format
+msgid "\t -v: be more verbose\n"
+msgstr "-v：更详细\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:73
+#, c-format
+msgid "\t -h: print this help\n"
+msgstr "-h：打印此帮助\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:74
+#, c-format
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
+msgstr "-i：测量的时间间隔（以秒为单位）（默认 1）\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:75
+#, c-format
+msgid "\t -t: show CPU topology/hierarchy\n"
+msgstr "-t：显示CPU拓扑/层次结构\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:76
+#, c-format
+msgid "\t -l: list available CPU sleep monitors (for use with -m)\n"
+msgstr "-l：列出可用的 CPU 睡眠监视器（与 -m 一起使用）\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:77
+#, c-format
+msgid "\t -m: show specific CPU sleep monitors only (in same order)\n"
+msgstr "-m：仅显示特定的CPU睡眠监视器（按相同顺序）\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:79
+#, c-format
+msgid ""
+"only one of: -t, -l, -m are allowed\n"
+"If none of them is passed,"
+msgstr ""
+"仅允许以下之一：-t、-l、-m\n"
+"如果都没有通过的话"
+
+#: utils/idle_monitor/cpupower-monitor.c:80
+#, c-format
+msgid " all supported monitors are shown\n"
+msgstr " 显示所有支持的显示器\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:197
+#, c-format
+msgid "Monitor %s, Counter %s has no count function. Implementation error\n"
+msgstr "监视器 %s、计数器 %s 无计数功能。 执行错误\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:207
+#, c-format
+msgid " *is offline\n"
+msgstr " *离线\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:236
+#, c-format
+msgid "%s: max monitor name length (%d) exceeded\n"
+msgstr "%s：超出最大监视器名称长度 (%d)\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:250
+#, c-format
+msgid "No matching monitor found in %s, try -l option\n"
+msgstr "在 %s 中找不到匹配的监视器，请尝试 -l 选项\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:266
+#, c-format
+msgid "Monitor \"%s\" (%d states) - Might overflow after %u s\n"
+msgstr "监视器“%s”（%d 状态）- 可能会在 %u 秒后溢出\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:319
+#, c-format
+msgid "%s took %.5f seconds and exited with status %d\n"
+msgstr "%s 用了 %.5f 秒并退出，状态为 %d\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:406
+#, c-format
+msgid "Cannot read number of available processors\n"
+msgstr "无法读取可用处理器的数量\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:417
+#, c-format
+msgid "Available monitor %s needs root access\n"
+msgstr "可用监视器 %s 需要 root 访问权限\n"
+
+#: utils/idle_monitor/cpupower-monitor.c:428
+#, c-format
+msgid "No HW Cstate monitors found\n"
+msgstr "未找到 HW Cstate 监视器\n"
+
+#: utils/cpupower.c:78
+#, c-format
+msgid "cpupower [ -c cpulist ] subcommand [ARGS]\n"
+msgstr "cpupower [ -c cpulist ] subcommand [ARGS]\n"
+
+#: utils/cpupower.c:79
+#, c-format
+msgid "cpupower --version\n"
+msgstr "cpupower --version\n"
+
+#: utils/cpupower.c:80
+#, c-format
+msgid "Supported subcommands are:\n"
+msgstr "支持的子命令有：\n"
+
+#: utils/cpupower.c:83
+#, c-format
+msgid ""
+"\n"
+"Some subcommands can make use of the -c cpulist option.\n"
+msgstr ""
+"\n"
+"某些子命令可以使用 -c cpulist 选项。\n"
+
+#: utils/cpupower.c:84
+#, c-format
+msgid "Look at the general cpupower manpage how to use it\n"
+msgstr "看看一般的cpupower manpage如何使用它\n"
+
+#: utils/cpupower.c:85
+#, c-format
+msgid "and read up the subcommand's manpage whether it is supported.\n"
+msgstr "并阅读子命令的manpage是否受支持。\n"
+
+#: utils/cpupower.c:86
+#, c-format
+msgid ""
+"\n"
+"Use cpupower help subcommand for getting help for above subcommands.\n"
+msgstr ""
+"\n"
+"使用 cpupower help subcommand获取上述子命令的帮助。\n"
+
+#: utils/cpupower.c:91
+#, c-format
+msgid "Report errors and bugs to %s, please.\n"
+msgstr "请向 %s 报告错误和错误。\n"
+
+#: utils/cpupower.c:114
+#, c-format
+msgid "Error parsing cpu list\n"
+msgstr "解析cpu列表时出错\n"
+
+#: utils/cpupower.c:172
+#, c-format
+msgid "Subcommand %s needs root privileges\n"
+msgstr "子命令 %s 需要 root 权限\n"
+
+#: utils/cpufreq-info.c:31
+#, c-format
+msgid "Couldn't count the number of CPUs (%s: %s), assuming 1\n"
+msgstr "无法计算 CPU 数量（%s：%s），假设为 1\n"
+
+#: utils/cpufreq-info.c:63
+#, c-format
+msgid ""
+"          minimum CPU frequency  -  maximum CPU frequency  -  governor\n"
+msgstr "最低 CPU 频率 - 最高 CPU 频率 - 调速器\n"
+
+#: utils/cpufreq-info.c:151
+#, c-format
+msgid "Error while evaluating Boost Capabilities on CPU %d -- are you root?\n"
+msgstr "评估 CPU %d 上的 Boost 功能时出错 - 您是 root 吗？\n"
+
+#. P state changes via MSR are identified via cpuid 80000007
+#. on Intel and AMD, but we assume boost capable machines can do that
+#. if (cpuid_eax(0x80000000) >= 0x80000007
+#. && (cpuid_edx(0x80000007) & (1 << 7)))
+#.
+#: utils/cpufreq-info.c:161
+#, c-format
+msgid "  boost state support: \n"
+msgstr "  升压状态支持：\n"
+
+#: utils/cpufreq-info.c:163
+#, c-format
+msgid "    Supported: %s\n"
+msgstr "    支持：%s\n"
+
+#: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
+msgid "yes"
+msgstr "是"
+
+#: utils/cpufreq-info.c:163 utils/cpufreq-info.c:164
+msgid "no"
+msgstr "不是"
+
+#: utils/cpufreq-info.c:164
+#, c-format
+msgid "    Active: %s\n"
+msgstr "    活跃：%s\n"
+
+#: utils/cpufreq-info.c:177
+#, c-format
+msgid "    Boost States: %d\n"
+msgstr "    提升状态：%d\n"
+
+#: utils/cpufreq-info.c:178
+#, c-format
+msgid "    Total States: %d\n"
+msgstr "    状态总数：%d\n"
+
+#: utils/cpufreq-info.c:181
+#, c-format
+msgid "    Pstate-Pb%d: %luMHz (boost state)\n"
+msgstr "    Pstate-Pb%d：%luMHz（升压状态）\n"
+
+#: utils/cpufreq-info.c:184
+#, c-format
+msgid "    Pstate-P%d:  %luMHz\n"
+msgstr "    Pstate-P%d：%luMHz\n"
+
+#: utils/cpufreq-info.c:211
+#, c-format
+msgid "  no or unknown cpufreq driver is active on this CPU\n"
+msgstr "  该 CPU 上没有或未知的 cpufreq 驱动程序处于活动状态\n"
+
+#: utils/cpufreq-info.c:213
+#, c-format
+msgid "  driver: %s\n"
+msgstr "  驱动程序：%s\n"
+
+#: utils/cpufreq-info.c:219
+#, c-format
+msgid "  CPUs which run at the same hardware frequency: "
+msgstr "  以相同硬件频率运行的 CPU："
+
+#: utils/cpufreq-info.c:230
+#, c-format
+msgid "  CPUs which need to have their frequency coordinated by software: "
+msgstr "  需要通过软件协调频率的 CPU："
+
+#: utils/cpufreq-info.c:241
+#, c-format
+msgid "  maximum transition latency: "
+msgstr "  最大转换延迟："
+
+#: utils/cpufreq-info.c:247
+#, c-format
+msgid "  hardware limits: "
+msgstr "  硬件限制："
+
+#: utils/cpufreq-info.c:256
+#, c-format
+msgid "  available frequency steps: "
+msgstr "  可用频率范围："
+
+#: utils/cpufreq-info.c:269
+#, c-format
+msgid "  available cpufreq governors: "
+msgstr "  可用的cpufreq调节器："
+
+#: utils/cpufreq-info.c:280
+#, c-format
+msgid "  current policy: frequency should be within "
+msgstr "  当前政策：频率应在"
+
+#: utils/cpufreq-info.c:282
+#, c-format
+msgid " and "
+msgstr "和"
+
+#: utils/cpufreq-info.c:286
+#, c-format
+msgid ""
+"The governor \"%s\" may decide which speed to use\n"
+"                  within this range.\n"
+msgstr ""
+"调速器“%s”可以决定使用哪种速度\n"
+"                   在这个范围内。\n"
+
+#: utils/cpufreq-info.c:293
+#, c-format
+msgid "  current CPU frequency is "
+msgstr "  当前CPU频率是"
+
+#: utils/cpufreq-info.c:296
+#, c-format
+msgid " (asserted by call to hardware)"
+msgstr " （通过调用硬件来断言）"
+
+#: utils/cpufreq-info.c:304
+#, c-format
+msgid "  cpufreq stats: "
+msgstr "  cpu频率统计："
+
+#: utils/cpufreq-info.c:472
+#, c-format
+msgid "Usage: cpupower freqinfo [options]\n"
+msgstr "用法：cpupower freqinfo [选项]\n"
+
+#: utils/cpufreq-info.c:473 utils/cpufreq-set.c:26 utils/cpupower-set.c:23
+#: utils/cpupower-info.c:22 utils/cpuidle-info.c:148
+#, c-format
+msgid "Options:\n"
+msgstr "选项：\n"
+
+#: utils/cpufreq-info.c:474
+#, c-format
+msgid "  -e, --debug          Prints out debug information [default]\n"
+msgstr "  -e, --debug 打印出调试信息[默认]\n"
+
+#: utils/cpufreq-info.c:475
+#, c-format
+msgid ""
+"  -f, --freq           Get frequency the CPU currently runs at, according\n"
+"                       to the cpufreq core *\n"
+msgstr ""
+"  -f, --freq 获取CPU当前运行的频率，根据\n"
+"                        到 cpufreq 核心 *\n"
+
+#: utils/cpufreq-info.c:477
+#, c-format
+msgid ""
+"  -w, --hwfreq         Get frequency the CPU currently runs at, by reading\n"
+"                       it from hardware (only available to root) *\n"
+msgstr ""
+"  -w, --hwfreq 通过读取获取CPU当前运行的频率\n"
+"                        它来自硬件（仅适用于root）*\n"
+
+#: utils/cpufreq-info.c:479
+#, c-format
+msgid ""
+"  -l, --hwlimits       Determine the minimum and maximum CPU frequency "
+"allowed *\n"
+msgstr "  -l, --hwlimits 确定允许的最小和最大 CPU 频率 *\n"
+
+#: utils/cpufreq-info.c:480
+#, c-format
+msgid "  -d, --driver         Determines the used cpufreq kernel driver *\n"
+msgstr "  -d, --driver 确定使用的 cpufreq 内核驱动程序 *\n"
+
+#: utils/cpufreq-info.c:481
+#, c-format
+msgid "  -p, --policy         Gets the currently used cpufreq policy *\n"
+msgstr "  -p, --policy 获取当前使用的cpufreq策略 *\n"
+
+#: utils/cpufreq-info.c:482
+#, c-format
+msgid "  -g, --governors      Determines available cpufreq governors *\n"
+msgstr "  -g, --governors 确定可用的 cpufreq 调节器 *\n"
+
+#: utils/cpufreq-info.c:483
+#, c-format
+msgid ""
+"  -r, --related-cpus   Determines which CPUs run at the same hardware "
+"frequency *\n"
+msgstr "  -r, --lated-cpus 确定哪些 CPU 以相同的硬件频率运行 *\n"
+
+#: utils/cpufreq-info.c:484
+#, c-format
+msgid ""
+"  -a, --affected-cpus  Determines which CPUs need to have their frequency\n"
+"                       coordinated by software *\n"
+msgstr ""
+"  -a, --affected-cpus 确定哪些 CPU 需要其频率\n"
+"                        由软件协调*\n"
+
+#: utils/cpufreq-info.c:486
+#, c-format
+msgid "  -s, --stats          Shows cpufreq statistics if available\n"
+msgstr "  -s, --stats 显示 cpufreq 统计信息（如果有）\n"
+
+#: utils/cpufreq-info.c:487
+#, c-format
+msgid ""
+"  -y, --latency        Determines the maximum latency on CPU frequency "
+"changes *\n"
+msgstr "  -y, --latency 确定 CPU 频率变化的最大延迟*\n"
+
+#: utils/cpufreq-info.c:488
+#, c-format
+msgid "  -b, --boost          Checks for turbo or boost modes  *\n"
+msgstr "  -b, --boost 检查 Turbo 或 boost 模式 *\n"
+
+#: utils/cpufreq-info.c:489
+#, c-format
+msgid ""
+"  -o, --proc           Prints out information like provided by the /proc/"
+"cpufreq\n"
+"                       interface in 2.4. and early 2.6. kernels\n"
+msgstr ""
+"  -o, --proc 打印 /proc/cpufreq 提供的信息\n"
+"                        2.4 中的接口。 以及 2.6 之前的内核。\n"
+
+#: utils/cpufreq-info.c:491
+#, c-format
+msgid ""
+"  -m, --human          human-readable output for the -f, -w, -s and -y "
+"parameters\n"
+msgstr "  -m, -- human -f, -w, -s 和 -y 参数的人类可读输出\n"
+
+#: utils/cpufreq-info.c:492 utils/cpuidle-info.c:152
+#, c-format
+msgid "  -h, --help           Prints out this screen\n"
+msgstr "  -h, --help 打印此屏幕\n"
+
+#: utils/cpufreq-info.c:495
+#, c-format
+msgid ""
+"If no argument or only the -c, --cpu parameter is given, debug output "
+"about\n"
+"cpufreq is printed which is useful e.g. for reporting bugs.\n"
+msgstr ""
+"screen如果没有参数或仅给出了 -c, --cpu 参数，则调试输出有关\n"
+"cpufreq 被打印出来，这很有用，例如 用于报告错误。\n"
+
+#: utils/cpufreq-info.c:497
+#, c-format
+msgid ""
+"For the arguments marked with *, omitting the -c or --cpu argument is\n"
+"equivalent to setting it to zero\n"
+msgstr ""
+"对于标有 * 的参数，省略 -c 或 --cpu 参数是\n"
+"相当于将其设置为零\n"
+
+#: utils/cpufreq-info.c:580
+#, c-format
+msgid ""
+"The argument passed to this tool can't be combined with passing a --cpu "
+"argument\n"
+msgstr "传递给此工具的参数不能与传递 --cpu 参数结合使用\n"
+
+#: utils/cpufreq-info.c:596
+#, c-format
+msgid ""
+"You can't specify more than one --cpu parameter and/or\n"
+"more than one output-specific argument\n"
+msgstr ""
+"您不能指定多个 --cpu 参数和/或\n"
+"多个特定于输出的参数\n"
+
+#: utils/cpufreq-info.c:600 utils/cpufreq-set.c:82 utils/cpupower-set.c:42
+#: utils/cpupower-info.c:42 utils/cpuidle-info.c:213
+#, c-format
+msgid "invalid or unknown argument\n"
+msgstr "无效或未知的参数\n"
+
+#: utils/cpufreq-info.c:617
+#, c-format
+msgid "couldn't analyze CPU %d as it doesn't seem to be present\n"
+msgstr "无法分析 CPU %d，因为它似乎不存在\n"
+
+#: utils/cpufreq-info.c:620 utils/cpupower-info.c:142
+#, c-format
+msgid "analyzing CPU %d:\n"
+msgstr "分析 CPU %d：\n"
+
+#: utils/cpufreq-set.c:25
+#, c-format
+msgid "Usage: cpupower frequency-set [options]\n"
+msgstr "用法：cpupower frequency-set [选项]\n"
+
+#: utils/cpufreq-set.c:27
+#, c-format
+msgid ""
+"  -d FREQ, --min FREQ      new minimum CPU frequency the governor may "
+"select\n"
+msgstr "  -d FREQ, --min FREQ 调控器可以选择的新的最小 CPU 频率\n"
+
+#: utils/cpufreq-set.c:28
+#, c-format
+msgid ""
+"  -u FREQ, --max FREQ      new maximum CPU frequency the governor may "
+"select\n"
+msgstr "  -u FREQ, --max FREQ 调控器可以选择的新的最大 CPU 频率\n"
+
+#: utils/cpufreq-set.c:29
+#, c-format
+msgid "  -g GOV, --governor GOV   new cpufreq governor\n"
+msgstr "  -g GOV, --governor GOV 新的 cpufreq 调节器\n"
+
+#: utils/cpufreq-set.c:30
+#, c-format
+msgid ""
+"  -f FREQ, --freq FREQ     specific frequency to be set. Requires "
+"userspace\n"
+"                           governor to be available and loaded\n"
+msgstr ""
+"  -f FREQ, --freq FREQ 要设置的特定频率。 需要用户空间\n"
+"                            调速器可用并已加载\n"
+
+#: utils/cpufreq-set.c:32
+#, c-format
+msgid "  -r, --related            Switches all hardware-related CPUs\n"
+msgstr "  -r, --related 切换所有与硬件相关的CPU\n"
+
+#: utils/cpufreq-set.c:33 utils/cpupower-set.c:28 utils/cpupower-info.c:27
+#, c-format
+msgid "  -h, --help               Prints out this screen\n"
+msgstr "  -h, --help 打印此屏幕\n"
+
+#: utils/cpufreq-set.c:35
+#, c-format
+msgid ""
+"Notes:\n"
+"1. Omitting the -c or --cpu argument is equivalent to setting it to "
+"\"all\"\n"
+msgstr ""
+"注意：\n"
+"1.省略-c或--cpu参数相当于将其设置为“all”\n"
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
+"2. -f FREQ、--freq FREQ参数不能与任何其他参数组合使用\n"
+"    除了 -c CPU、--cpu CPU 参数\n"
+"3. 频率可以以 Hz、kHz（默认）、MHz、GHz 或 THz 为单位传递\n"
+"    通过在值后面添加所需的单位名称，不带任何空格\n"
+"    （以 kHz 为单位的频率 =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000）。\n"
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
+"设置新值时出错。 常见错误：\n"
+"- 您有适当的管理权吗？ （超级用户？）\n"
+"- 您请求的调控器是否可用并已进行 modprobed？\n"
+"- 尝试设置无效的策略？\n"
+"- 尝试设置特定频率，但用户空间调控器不可用，\n"
+"    例如由于硬件无法设置为特定频率\n"
+"    或者因为用户空间调控器未加载？\n"
+
+#: utils/cpufreq-set.c:170
+#, c-format
+msgid "wrong, unknown or unhandled CPU?\n"
+msgstr "错误、未知或未处理的CPU？\n"
+
+#: utils/cpufreq-set.c:302
+#, c-format
+msgid ""
+"the -f/--freq parameter cannot be combined with -d/--min, -u/--max or\n"
+"-g/--governor parameters\n"
+msgstr ""
+"-f/--freq 参数不能与 -d/--min、-u/--max 或\n"
+"-g/--调速器参数\n"
+
+#: utils/cpufreq-set.c:308
+#, c-format
+msgid ""
+"At least one parameter out of -f/--freq, -d/--min, -u/--max, and\n"
+"-g/--governor must be passed\n"
+msgstr ""
+"-f/--freq、-d/--min、-u/--max 和 -f/--freq 中的至少一个参数\n"
+"-g/--governor 必须通过\n"
+
+#: utils/cpufreq-set.c:347
+#, c-format
+msgid "Setting cpu: %d\n"
+msgstr "设置CPU：%d\n"
+
+#: utils/cpupower-set.c:22
+#, c-format
+msgid "Usage: cpupower set [ -b val ] [ -m val ] [ -s val ]\n"
+msgstr "用法： cpupower set [ -b val ] [ -m val ] [ -s val ]\n"
+
+#: utils/cpupower-set.c:24
+#, c-format
+msgid ""
+"  -b, --perf-bias [VAL]    Sets CPU's power vs performance policy on some\n"
+"                           Intel models [0-15], see manpage for details\n"
+msgstr ""
+"  -b, --perf-bias [VAL] 设置 CPU 的功耗与性能策略\n"
+"                            Intel 型号 [0-15]，请参阅manpage了解详细信息\n"
+
+#: utils/cpupower-set.c:26
+#, c-format
+msgid ""
+"  -m, --sched-mc  [VAL]    Sets the kernel's multi core scheduler policy.\n"
+msgstr "  -m, --sched-mc [VAL] 设置内核的多核调度程序策略。\n"
+
+#: utils/cpupower-set.c:27
+#, c-format
+msgid ""
+"  -s, --sched-smt [VAL]    Sets the kernel's thread sibling scheduler "
+"policy.\n"
+msgstr "  -s, --sched-smt [VAL] 设置内核的线程同级调度程序策略。\n"
+
+#: utils/cpupower-set.c:80
+#, c-format
+msgid "--perf-bias param out of range [0-%d]\n"
+msgstr "--perf-bias 参数超出范围 [0-%d]\n"
+
+#: utils/cpupower-set.c:91
+#, c-format
+msgid "--sched-mc param out of range [0-%d]\n"
+msgstr "--sched-mc 参数超出范围 [0-%d]\n"
+
+#: utils/cpupower-set.c:102
+#, c-format
+msgid "--sched-smt param out of range [0-%d]\n"
+msgstr "--sched-smt 参数超出范围 [0-%d]\n"
+
+#: utils/cpupower-set.c:121
+#, c-format
+msgid "Error setting sched-mc %s\n"
+msgstr "设置 sched-mc %s 时出错\n"
+
+#: utils/cpupower-set.c:127
+#, c-format
+msgid "Error setting sched-smt %s\n"
+msgstr "设置 sched-smt %s 时出错\n"
+
+#: utils/cpupower-set.c:146
+#, c-format
+msgid "Error setting perf-bias value on CPU %d\n"
+msgstr "在 CPU %d 上设置性能偏差值时出错\n"
+
+#: utils/cpupower-info.c:21
+#, c-format
+msgid "Usage: cpupower info [ -b ] [ -m ] [ -s ]\n"
+msgstr "用法：cpupower info [-b][-m][-s]\n"
+
+#: utils/cpupower-info.c:23
+#, c-format
+msgid ""
+"  -b, --perf-bias    Gets CPU's power vs performance policy on some\n"
+"                           Intel models [0-15], see manpage for details\n"
+msgstr ""
+"  -b, --perf-bias    获取 CPU 在某些方面的功耗与性能策略\n"
+"                            Intel 型号 [0-15]，请参阅联机帮助页了解详细信"
+"息\n"
+
+#: utils/cpupower-info.c:25
+#, c-format
+msgid "  -m, --sched-mc     Gets the kernel's multi core scheduler policy.\n"
+msgstr "  -m, --sched-mc 获取内核的多核调度程序策略。\n"
+
+#: utils/cpupower-info.c:26
+#, c-format
+msgid ""
+"  -s, --sched-smt    Gets the kernel's thread sibling scheduler policy.\n"
+msgstr "  -s, --sched-smt    获取内核的线程同级调度程序策略。\n"
+
+#: utils/cpupower-info.c:28
+#, c-format
+msgid ""
+"\n"
+"Passing no option will show all info, by default only on core 0\n"
+msgstr ""
+"\n"
+"不传递任何选项将显示所有信息，默认情况下仅在核心 0 上\n"
+
+#: utils/cpupower-info.c:102
+#, c-format
+msgid "System's multi core scheduler setting: "
+msgstr "系统的多核调度器设置："
+
+#. if sysfs file is missing it's: errno == ENOENT
+#: utils/cpupower-info.c:105 utils/cpupower-info.c:114
+#, c-format
+msgid "not supported\n"
+msgstr "不支持\n"
+
+#: utils/cpupower-info.c:111
+#, c-format
+msgid "System's thread sibling scheduler setting: "
+msgstr "系统的线程兄调度程序设置："
+
+#: utils/cpupower-info.c:126
+#, c-format
+msgid "Intel's performance bias setting needs root privileges\n"
+msgstr "Intel的性能偏差设置需要root权限\n"
+
+#: utils/cpupower-info.c:128
+#, c-format
+msgid "System does not support Intel's performance bias setting\n"
+msgstr "系统不支持Intel的性能偏差设置\n"
+
+#: utils/cpupower-info.c:147
+#, c-format
+msgid "Could not read perf-bias value\n"
+msgstr "无法读取性能偏差值\n"
+
+#: utils/cpupower-info.c:150
+#, c-format
+msgid "perf-bias: %d\n"
+msgstr "性能偏差：%d\n"
+
+#: utils/cpuidle-info.c:28
+#, c-format
+msgid "Analyzing CPU %d:\n"
+msgstr "正在分析 CPU %d：\n"
+
+#: utils/cpuidle-info.c:32
+#, c-format
+msgid "CPU %u: No idle states\n"
+msgstr "CPU %u：无空闲状态\n"
+
+#: utils/cpuidle-info.c:36
+#, c-format
+msgid "CPU %u: Can't read idle state info\n"
+msgstr "CPU %u：无法读取空闲状态信息\n"
+
+#: utils/cpuidle-info.c:41
+#, c-format
+msgid "Could not determine max idle state %u\n"
+msgstr "无法确定最大空闲状态 %u\n"
+
+#: utils/cpuidle-info.c:46
+#, c-format
+msgid "Number of idle states: %d\n"
+msgstr "空闲状态数：%d\n"
+
+#: utils/cpuidle-info.c:48
+#, c-format
+msgid "Available idle states:"
+msgstr "可用的空闲状态："
+
+#: utils/cpuidle-info.c:71
+#, c-format
+msgid "Flags/Description: %s\n"
+msgstr "标志/描述：%s\n"
+
+#: utils/cpuidle-info.c:74
+#, c-format
+msgid "Latency: %lu\n"
+msgstr "延迟：%lu\n"
+
+#: utils/cpuidle-info.c:76
+#, c-format
+msgid "Usage: %lu\n"
+msgstr "用法：%lu\n"
+
+#: utils/cpuidle-info.c:78
+#, c-format
+msgid "Duration: %llu\n"
+msgstr "持续时间：%llu\n"
+
+#: utils/cpuidle-info.c:90
+#, c-format
+msgid "Could not determine cpuidle driver\n"
+msgstr "无法确定 cpuidle 驱动程序\n"
+
+#: utils/cpuidle-info.c:94
+#, c-format
+msgid "CPUidle driver: %s\n"
+msgstr "CPU 空闲驱动程序：%s\n"
+
+#: utils/cpuidle-info.c:99
+#, c-format
+msgid "Could not determine cpuidle governor\n"
+msgstr "无法确定 cpuidle 调控器\n"
+
+#: utils/cpuidle-info.c:103
+#, c-format
+msgid "CPUidle governor: %s\n"
+msgstr "CPU 空闲调节器：%s\n"
+
+#: utils/cpuidle-info.c:122
+#, c-format
+msgid "CPU %u: Can't read C-state info\n"
+msgstr "CPU %u：无法读取 C 状态信息\n"
+
+#. printf("Cstates: %d\n", cstates);
+#: utils/cpuidle-info.c:127
+#, c-format
+msgid "active state:            C0\n"
+msgstr "活动状态:            C0\n"
+
+#: utils/cpuidle-info.c:128
+#, c-format
+msgid "max_cstate:              C%u\n"
+msgstr "最大c状态:              C%u\n"
+
+#: utils/cpuidle-info.c:129
+#, c-format
+msgid "maximum allowed latency: %lu usec\n"
+msgstr "允许的最大延迟：%lu usec\n"
+
+#: utils/cpuidle-info.c:130
+#, c-format
+msgid "states:\t\n"
+msgstr "状态：\t\n"
+
+#: utils/cpuidle-info.c:132
+#, c-format
+msgid "    C%d:                  type[C%d] "
+msgstr "    C%d:                  类型[C%d]"
+
+#: utils/cpuidle-info.c:134
+#, c-format
+msgid "promotion[--] demotion[--] "
+msgstr "晋升[--] 降级[--]"
+
+#: utils/cpuidle-info.c:135
+#, c-format
+msgid "latency[%03lu] "
+msgstr "延迟[%03lu]"
+
+#: utils/cpuidle-info.c:137
+#, c-format
+msgid "usage[%08lu] "
+msgstr "使用情况[%08lu]"
+
+#: utils/cpuidle-info.c:139
+#, c-format
+msgid "duration[%020Lu] \n"
+msgstr "持续时间[%020Lu]\n"
+
+#: utils/cpuidle-info.c:147
+#, c-format
+msgid "Usage: cpupower idleinfo [options]\n"
+msgstr "用法：cpupower idleinfo [选项]\n"
+
+#: utils/cpuidle-info.c:149
+#, c-format
+msgid "  -s, --silent         Only show general C-state information\n"
+msgstr "  -s, --silent 只显示一般C状态信息\n"
+
+#: utils/cpuidle-info.c:150
+#, c-format
+msgid ""
+"  -o, --proc           Prints out information like provided by the /proc/"
+"acpi/processor/*/power\n"
+"                       interface in older kernels\n"
+msgstr ""
+"  -o, --proc 打印 /proc/acpi/processor/*/power 提供的信息\n"
+"                        旧内核中的接口\n"
+
+#: utils/cpuidle-info.c:209
+#, c-format
+msgid "You can't specify more than one output-specific argument\n"
+msgstr "您不能指定多个特定于输出的参数\n"
+
+#~ msgid ""
+#~ "  -c CPU, --cpu CPU    CPU number which information shall be determined "
+#~ "about\n"
+#~ msgstr ""
+#~ "  -c CPU, --cpu CPU    NumÃ©ro du CPU pour lequel l'information sera "
+#~ "affichÃ©e\n"
+
+#~ msgid ""
+#~ "  -c CPU, --cpu CPU        number of CPU where cpufreq settings shall be "
+#~ "modified\n"
+#~ msgstr ""
+#~ "  -c CPU, --cpu CPU        numÃ©ro du CPU Ã  prendre en compte pour les\n"
+#~ "                           changements\n"
-- 
2.47.0


