Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885CB14AE8C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 05:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgA1EAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 23:00:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45462 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA1EAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 23:00:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so6242340pgk.12;
        Mon, 27 Jan 2020 20:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VaV+TCz+P8SwfgAEkIAIx0NiElaucyvHYe3YKrATciA=;
        b=rSpGlQB2sMAkmSJjAkD9CNOH28jCMb9IkZJTlzDgrwR2L4UaC/ryVxcS5bdz96i1Yw
         gGeupO8OLaXX9p1OSnyQ6b9D6kdbKd++JWKLqkl27/ZAu9Rwtb94etA9u2AZBlYwrVdP
         BnWDgieM5/Mhqjbbxd0GenTXxxEoBawsx7FhGV1QcNYuE7ZOMlxx8GmXO9+WQfnsoG8E
         W2OIK2yRo5B0PqUTDEnJ9/uAoXE/byHZGJ2tQQoPGltkIrb7CRaQR9yhQK5avKGc1F9X
         5LAijHqL9M/80ioFXZFROdIDVCfFl57vjn71hHJhqChE1vPqvRXALHyln/BNaYhpQ5ih
         cgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaV+TCz+P8SwfgAEkIAIx0NiElaucyvHYe3YKrATciA=;
        b=n+7MaPh0oOIHQifvIkk6Zqv3LhM3gTvdbUqhKZyqppPp2lXwBJFcf9whQS8TWjLGNl
         xl6GoNCeAMkl+mwYHodNyqGhYNy9TRz+moljmV69RaVf1LTYQA5JlLitoWhAKOCYpdjj
         I39/+1SKre6ToyKbfkD7bXdacX67UQI6hZlS5/byoyGx3AWZy3alZxXTZsUM+fWtDLul
         LfZ/foX3V3iTadBNvz0UW3vaTvbpHmMYkZRhwtuOTGK+9LWgKPs8dzU/KHvlY+yoq/KF
         Xr3kXEbmxq61y+xm9Bm3nTmHGbiQ49u4/sZI3L5551QhMZd1Ist0lr0+Bpf3TkzlrUhy
         B7FQ==
X-Gm-Message-State: APjAAAUrWnlDF3sd1PkpQZrvwdgPkExEZBfEq4IfBYlPHUKTZlGC/Ehq
        8ivByuv8Qkb8sYvFeVJzZGI=
X-Google-Smtp-Source: APXvYqwXQxM2zxpQ7MQLAjsdHMmmrFjrITL8x6OZXVpX7DLFQb1VnqnhoVeZV+rdVn10nrVFk9u8PA==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr2019186pfi.25.1580184035437;
        Mon, 27 Jan 2020 20:00:35 -0800 (PST)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id d22sm17464489pgg.52.2020.01.27.20.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 20:00:34 -0800 (PST)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     dsmythies@telus.net, srinivas.pandruvada@linux.intel.com,
        rjw@rjwysocki.net, len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: change several graphs to autoscale y-axis
Date:   Mon, 27 Jan 2020 19:59:57 -0800
Message-Id: <20200128035957.2577561-3-dsmythies@telus.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128035957.2577561-1-dsmythies@telus.net>
References: <20200128035957.2577561-1-dsmythies@telus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Processors have exceeded some of the fixed y-axis scale maximum values.
Change them to autoscale the y-axis.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 .../intel_pstate_tracer/intel_pstate_tracer.py   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 1351975d0769..256199c7a182 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -104,7 +104,7 @@ def plot_perf_busy_with_sample(cpu_index):
     if os.path.exists(file_name):
         output_png = "cpu%03d_perf_busy_vs_samples.png" % cpu_index
         g_plot = common_all_gnuplot_settings(output_png)
-        g_plot('set yrange [0:40]')
+#   autoscale this one, no set y1 range
         g_plot('set y2range [0:200]')
         g_plot('set y2tics 0, 10')
         g_plot('set title "{} : cpu perf busy vs. sample : CPU {:0>3} : {:%F %H:%M}"'.format(testname, cpu_index, datetime.now()))
@@ -125,7 +125,7 @@ def plot_perf_busy(cpu_index):
     if os.path.exists(file_name):
         output_png = "cpu%03d_perf_busy.png" % cpu_index
         g_plot = common_all_gnuplot_settings(output_png)
-        g_plot('set yrange [0:40]')
+#   autoscale this one, no set y1 range
         g_plot('set y2range [0:200]')
         g_plot('set y2tics 0, 10')
         g_plot('set title "{} : perf busy : CPU {:0>3} : {:%F %H:%M}"'.format(testname, cpu_index, datetime.now()))
@@ -144,9 +144,7 @@ def plot_durations(cpu_index):
     if os.path.exists(file_name):
         output_png = "cpu%03d_durations.png" % cpu_index
         g_plot = common_all_gnuplot_settings(output_png)
-#       Should autoscale be used here? Should seconds be used here?
-        g_plot('set yrange [0:5000]')
-        g_plot('set ytics 0, 500')
+#       autoscale this one, no set y range
         g_plot('set title "{} : durations : CPU {:0>3} : {:%F %H:%M}"'.format(testname, cpu_index, datetime.now()))
         g_plot('set ylabel "Timer Duration (MilliSeconds)"')
 #       override common
@@ -176,7 +174,7 @@ def plot_pstate_cpu_with_sample():
     if os.path.exists('cpu.csv'):
         output_png = 'all_cpu_pstates_vs_samples.png'
         g_plot = common_all_gnuplot_settings(output_png)
-        g_plot('set yrange [0:40]')
+#       autoscale this one, no set y range
 #       override common
         g_plot('set xlabel "Samples"')
         g_plot('set ylabel "P-State"')
@@ -191,7 +189,7 @@ def plot_pstate_cpu():
 
     output_png = 'all_cpu_pstates.png'
     g_plot = common_all_gnuplot_settings(output_png)
-    g_plot('set yrange [0:40]')
+#   autoscale this one, no set y range
     g_plot('set ylabel "P-State"')
     g_plot('set title "{} : cpu pstates : {:%F %H:%M}"'.format(testname, datetime.now()))
 
@@ -222,7 +220,7 @@ def plot_frequency_cpu():
 
     output_png = 'all_cpu_frequencies.png'
     g_plot = common_all_gnuplot_settings(output_png)
-    g_plot('set yrange [0:4]')
+#   autoscale this one, no set y range
     g_plot('set ylabel "CPU Frequency (GHz)"')
     g_plot('set title "{} : cpu frequencies : {:%F %H:%M}"'.format(testname, datetime.now()))
 
@@ -236,7 +234,7 @@ def plot_duration_cpu():
 
     output_png = 'all_cpu_durations.png'
     g_plot = common_all_gnuplot_settings(output_png)
-    g_plot('set yrange [0:5000]')
+#   autoscale this one, no set y range
     g_plot('set ytics 0, 500')
     g_plot('set ylabel "Timer Duration (MilliSeconds)"')
     g_plot('set title "{} : cpu durations : {:%F %H:%M}"'.format(testname, datetime.now()))
-- 
2.24.0

