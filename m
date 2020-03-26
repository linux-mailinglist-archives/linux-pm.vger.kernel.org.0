Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0219442A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCZQUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 12:20:23 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42374 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZQUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 12:20:23 -0400
Received: by mail-pg1-f178.google.com with SMTP id h8so3108793pgs.9;
        Thu, 26 Mar 2020 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMiM6+K1a4dVIx/HoFdfYa4TGUCl/66i+foEoGRP+No=;
        b=DnlH9eUx7GD//Yd7fLQCB3vLlQFDaVNcQEcOASEmRya4oqmTUGp7poqUMLLKNnzGVA
         tCpujyWDWirabMK3gD9E9WJ9cNHRGj3UGrGU2fIg7rH1W7rOQelayGn8tR5N16a9CxSH
         FRmef1UX5aIcw2CiY+iqp945NAKfh7V6FT2XtbGWDGARAqr01cepbXHtKbl1qB4/pSiQ
         OuYpxBu5Ma8qMhnGnwLAqIldY2/ewuwZ1wcc1AMF2Q3m7srdzYTrpb3BysJvgoVjmXeW
         7qR4eGucSGtc9x8wUmGxmSDuQ0o+wxDPFf5DWLSMtWXVXyolzwv/+DZc7UyzEiy2smjy
         0N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMiM6+K1a4dVIx/HoFdfYa4TGUCl/66i+foEoGRP+No=;
        b=YRLKu0pxsIYMM/VAg6WLaETL8qAGtURGeZMFoJeEIqIueETBwe2KXaISih88DPJa71
         CYXAnCnasNLBS70SNtOd3J7mRvJN665/e5oGXaBgLVp7qeLyzy4tyvhLXtq/C8S0BQkd
         nTiIBrzJdDD3Z6QoWaKC7tqnqQH8ryprSEqfQrKu4sUX4z/Yo96zmP3P31fZip/pQvQn
         Yt+5rDTGjqPvyUVaijVuLAZDyBYHMG8Opmy+nFpKGjvy5xxfrrfgv+u0AJ1IPOy33naM
         FgsKki2/5UYnohKu7zY9xoYVrd56qJ2QJQZjhTWqOcxYVxCMNva03tjCxBcRlEE+zOIs
         Gjyg==
X-Gm-Message-State: ANhLgQ3vWB2ZPMOVqsUJ8lb9lQ1Ii2qGSwLXHql/iZXzkJe6QizV4NcY
        ogeKDSInwwwbZEqnmga1sgI=
X-Google-Smtp-Source: ADFU+vuTnsBjUYEVkOOc5YGKiWgOPoLAkVl36F45WJ6U9dy86dJB/dJfNc6fMr7hTtWp1jO04wsT3g==
X-Received: by 2002:aa7:959a:: with SMTP id z26mr9809359pfj.211.1585239621565;
        Thu, 26 Mar 2020 09:20:21 -0700 (PDT)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id i124sm2024198pfg.14.2020.03.26.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:20:20 -0700 (PDT)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     dsmythies@telus.net, srinivas.pandruvada@linux.intel.com,
        rjw@rjwysocki.net, len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] tools/power/x86/intel_pstate_tracer: fix a broken y-axis scale
Date:   Thu, 26 Mar 2020 09:20:07 -0700
Message-Id: <20200326162007.25670-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A fixed y-axis scale was missed during a change to autoscale.
Correct it.

Fixes: 709bd70d070ee6d775c6e77e40e8444bd5fa123f
"tools/power/x86/intel_pstate_tracer: change several graphs to autoscale y-axis"

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 256199c7a182..3c47865bb247 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -235,7 +235,6 @@ def plot_duration_cpu():
     output_png = 'all_cpu_durations.png'
     g_plot = common_all_gnuplot_settings(output_png)
 #   autoscale this one, no set y range
-    g_plot('set ytics 0, 500')
     g_plot('set ylabel "Timer Duration (MilliSeconds)"')
     g_plot('set title "{} : cpu durations : {:%F %H:%M}"'.format(testname, datetime.now()))
 
-- 
2.25.1

