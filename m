Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D29C48603
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFQOvb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 10:51:31 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:40444 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfFQOvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 10:51:31 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id RqrH2000C3XaVaC01qrHBK; Mon, 17 Jun 2019 16:51:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsya-0002M8-O9; Mon, 17 Jun 2019 16:51:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsya-0001l7-M8; Mon, 17 Jun 2019 16:51:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] cpupower: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:51:15 +0200
Message-Id: <20190617145115.6719-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/power/cpupower/bench/cpufreq-bench_plot.sh   | 2 +-
 tools/power/cpupower/bench/cpufreq-bench_script.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/bench/cpufreq-bench_plot.sh b/tools/power/cpupower/bench/cpufreq-bench_plot.sh
index 9061b4f1244ec7e3..f5f8b3c8f062a6fa 100644
--- a/tools/power/cpupower/bench/cpufreq-bench_plot.sh
+++ b/tools/power/cpupower/bench/cpufreq-bench_plot.sh
@@ -88,4 +88,4 @@ done
 echo >> $dir/plot_script.gpl
 
 gnuplot $dir/plot_script.gpl
-rm -r $dir
\ No newline at end of file
+rm -r $dir
diff --git a/tools/power/cpupower/bench/cpufreq-bench_script.sh b/tools/power/cpupower/bench/cpufreq-bench_script.sh
index 4e9714b876d23b7a..785a3679c704e525 100644
--- a/tools/power/cpupower/bench/cpufreq-bench_script.sh
+++ b/tools/power/cpupower/bench/cpufreq-bench_script.sh
@@ -85,4 +85,4 @@ function create_plots()
 }
 
 measure
-create_plots
\ No newline at end of file
+create_plots
-- 
2.17.1

