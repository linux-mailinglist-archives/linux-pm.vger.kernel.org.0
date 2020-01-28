Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37614AE8A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 05:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgA1EA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 23:00:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA1EA2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 23:00:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so6267124pgk.2;
        Mon, 27 Jan 2020 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRvZ4+zNuGgoPLNJrb+Azqj+S6OggUFM688SUmeIEAk=;
        b=Dqy5ePLQT5J60BJWWahsTF6pJUCTaobq2ue+sb4ZP3dgkfjUlaUG76r3YQUOjqM4G6
         lNdIXJj6IA+KETfRHKGNEMKiFMoYo/GEMBvceM9D56ZKfEHRk8IyIecnuJzOi+pUjB1d
         8dC2nFrLN9B40qtEyQMcY2Qs70wZPZH7MUXkP6r8K7b9P0qJV+qFOCOhmusOsxwodKNn
         Ql91fdXRCmwmNpwhn8bnF3hwKK814DTlhfJ7ztN14TEic+bejFYeh2BveddMqrgpmd6Z
         T2PQJZOxanJHMZKxevphg0I01Cx38ohsPlk+TZtrDbjhZViFFgjbYKwssL1wRwg4sGmt
         aijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRvZ4+zNuGgoPLNJrb+Azqj+S6OggUFM688SUmeIEAk=;
        b=SJjqHepEWc9gzLAgvN2vTSt9mHUMAfzSGmAkWwkJuTgHN9LZy0DVPJ4T9MIpCJcHqD
         dhnyFCc8B5JaqU9KPbf8PhdHtvWCWfiveX6zFi8Lxd4LhTD/A60QP2NSZx2mC0Uyov/b
         PBANduh6Ood0FM4767OwUPlLkliGGxLd/T69zudjuxbYhrmu2UbLmIsWkiOkBQp7G1jz
         E+qlkmlcAsAC+qwAssRfziuEYFjWRQ0JoCHAfuxqWZiuRubIkEujrnqDtSHdwPeqmofN
         72UX7/an/FpxLas+mcIlWl/Km1aAbtM3zqXzm+A4gM1TymRjeXVDxIKdrjNnU1X1GwMh
         f/rQ==
X-Gm-Message-State: APjAAAWwf6oSemGbA81GRpkQx5QQvgdSZZmu6mgUxAdpzF/MHioeYE+G
        xui3QBejyNrSqdWswTxp090=
X-Google-Smtp-Source: APXvYqy2RrWYHpQ6ECBSu3tGZexknI4VsQ2y68/A+AbwzZw2TO2fO0+rl+GUpOWwPHdwsqWA0mWThA==
X-Received: by 2002:a63:111e:: with SMTP id g30mr23742161pgl.251.1580184028057;
        Mon, 27 Jan 2020 20:00:28 -0800 (PST)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id d22sm17464489pgg.52.2020.01.27.20.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 20:00:27 -0800 (PST)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     dsmythies@telus.net, srinivas.pandruvada@linux.intel.com,
        rjw@rjwysocki.net, len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] tools/power/x86/intel_pstate_tracer: changes for python 3 compatibility
Date:   Mon, 27 Jan 2020 19:59:56 -0800
Message-Id: <20200128035957.2577561-2-dsmythies@telus.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200128035957.2577561-1-dsmythies@telus.net>
References: <20200128035957.2577561-1-dsmythies@telus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some syntax needs to be more rigorous for python 3.
Backwards compatibility tested with python 2.7

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 .../intel_pstate_tracer.py                    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 2d6d342b148f..1351975d0769 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -11,11 +11,11 @@ then this utility enables and collects trace data for a user specified interval
 and generates performance plots.
 
 Prerequisites:
-    Python version 2.7.x
+    Python version 2.7.x or higher
     gnuplot 5.0 or higher
-    gnuplot-py 1.8
+    gnuplot-py 1.8 or higher
     (Most of the distributions have these required packages. They may be called
-     gnuplot-py, phython-gnuplot. )
+     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
 
     HWP (Hardware P-States are disabled)
     Kernel config for Linux trace is enabled
@@ -181,7 +181,7 @@ def plot_pstate_cpu_with_sample():
         g_plot('set xlabel "Samples"')
         g_plot('set ylabel "P-State"')
         g_plot('set title "{} : cpu pstate vs. sample : {:%F %H:%M}"'.format(testname, datetime.now()))
-        title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+        title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
         plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_SAMPLE, C_TO)
         g_plot('title_list = "{}"'.format(title_list))
         g_plot(plot_str)
@@ -198,7 +198,7 @@ def plot_pstate_cpu():
 #    the following command is really cool, but doesn't work with the CPU masking option because it aborts on the first missing file.
 #    plot_str = 'plot for [i=0:*] file=sprintf("cpu%03d.csv",i) title_s=sprintf("cpu%03d",i) file using 16:7 pt 7 ps 1 title title_s'
 #
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_TO)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
@@ -212,7 +212,7 @@ def plot_load_cpu():
     g_plot('set ylabel "CPU load (percent)"')
     g_plot('set title "{} : cpu loads : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_LOAD)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
@@ -226,7 +226,7 @@ def plot_frequency_cpu():
     g_plot('set ylabel "CPU Frequency (GHz)"')
     g_plot('set title "{} : cpu frequencies : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_FREQ)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
@@ -241,7 +241,7 @@ def plot_duration_cpu():
     g_plot('set ylabel "Timer Duration (MilliSeconds)"')
     g_plot('set title "{} : cpu durations : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_DURATION)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
@@ -255,7 +255,7 @@ def plot_scaled_cpu():
     g_plot('set ylabel "Scaled Busy (Unitless)"')
     g_plot('set title "{} : cpu scaled busy : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_SCALED)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
@@ -269,7 +269,7 @@ def plot_boost_cpu():
     g_plot('set ylabel "CPU IO Boost (percent)"')
     g_plot('set title "{} : cpu io boost : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_BOOST)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
@@ -283,7 +283,7 @@ def plot_ghz_cpu():
     g_plot('set ylabel "TSC Frequency (GHz)"')
     g_plot('set title "{} : cpu TSC Frequencies (Sanity check calculation) : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).replace('\n', ' ')
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
     plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_GHZ)
     g_plot('title_list = "{}"'.format(title_list))
     g_plot(plot_str)
-- 
2.24.0

