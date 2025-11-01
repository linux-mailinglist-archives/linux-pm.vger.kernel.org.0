Return-Path: <linux-pm+bounces-37241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD70C278A2
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 06:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D00406CB4
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 05:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60BF2882D3;
	Sat,  1 Nov 2025 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6KA+W9V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0F10942
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761976602; cv=none; b=Afpd/Vk13m0JoV9F2O8EzPo0qAog998mclkxydMPd7azPBgO7Y0uMP/6NcTbfbztvwui6kNMjM2Ia/xo9ZsMLOv8chbyqNPtl+0fkSK4M9I+XFoxVhILmJBOk8cgUFta8bItCETerQ0TwDfRrbG3oBhGtcrV+4yB2s0x+v+BLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761976602; c=relaxed/simple;
	bh=ciqXU+1NcuVr4iigJo4KYFshbbWaXN1fMRAm85K4jo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWazhHT6sro3yDUixO2gQfyvinYYMWctZE1ak6mSNMMnJRuSz88QDk/uPGnbP1oBQ/OZ4lcwILS4gBaYSCHCRCLKkJ+3u215UUpCQMUS/nWv2AUSmsYKCO24Q0GIPrHp3h12zGg45i6ke8i8KARp1dGjAWrZQkzkRccbWO7gz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6KA+W9V; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-88f239686f2so321412385a.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761976599; x=1762581399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRCZltpC3RV67ZWRzBd3H/sPBTtda5yz34HGDlmtPjs=;
        b=e6KA+W9V931lxF4l6UbnyH1SGU1QpYowTIK/a6/OG//mboqQtUwoIJUOpbjOp3qQIr
         eq7J4G/ju6fIicJnEk/LWIGMNgzWJl1a2tHvMUg1hnXI3rVrK2/HlzbyC0ofFUTt8WNd
         EANidwJjFg8/KN6yrVbEn7sZZzxoOsjxNKj2QVQ9JzsD2ExpA3l8RRASt8ThnsdkWCZB
         rrIAlcFSibMyh6DD/xKcP9+YHGHiU+xjCAgHiD8mCoEY04gctVHZL0zObrAAVMu3BGeE
         CpcG/w4hfRBkGQQobHZ5tj0bgir1lAmdqx3UQYgbS8Ig1acAPde/Bt30CY/+LXRplxOi
         K4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761976599; x=1762581399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRCZltpC3RV67ZWRzBd3H/sPBTtda5yz34HGDlmtPjs=;
        b=kLxa+N8v1XwknEnlRccu0wYwvCLD+ydTAxyR4KFvgegM5OS2RBtq2lqWN8ld4NbL4u
         Y5rJSZFW7g5XmJfrMV5x38qkQWYieSpq8+XybPQJLgYNjCFNqxCLYeaJiaTKqOWX4dzw
         rSjUM+sh3n1NPqjXcR4GoGLkogZWnX+4tOwZEg8A9A5Cmn3rbNQa9y1ViXGclcTw3kaS
         efsIoh7H05r/R9PXbN9wEVminRMxO59zW9irsS92XXO+zDn7Hntu7i6sQCwVhJ2/OL6O
         3M8sRvNQF+yrs1SK4JI5PhQzrtw7hRr8k6zwMzUpxpZz4Rywg4IIjm93QCZVqkGDvX3R
         9d2g==
X-Forwarded-Encrypted: i=1; AJvYcCXTK2io85azdspLwXjJKNy4plhpa2/DMrunGhZ8D2+JmB1/8LVYCp8Q03e6CPoagE6KrADVLvCyWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzENmo1elvm74j0OUxEEqWvtKd34tMMuBsvo+HgrDaI3zfuigpY
	IWd6Xi1laLRDNwHQ55uWzH/rXb1Wi2dq+i6e/B2jv2piAEL4Eg2ChlLR
X-Gm-Gg: ASbGncumCyBV707hMrYH3mZf7sqyKrgLXCQCDtDufFBqjjZ2yrF9thtUBjsMvxAtlLz
	WKMAi4gQ2IxzKxrQQFe2wTfyLnenCRu3FIeI6C/MPyWEwfqbt9HyeRjwzJjIlgNt6XmjY7p5QaE
	fbgpeqmfzDDrs9Fm4loXFcGCWMpI3vVKsvqXD3q+ORLAyl9rsagmmFbAaXdlJOisQvpmSuQGx2D
	evNuYMD9tLZBq6Ak0aDImaUV5kOPoFhZ98PAMDLOFuC/aH23RfxvcQEonjh1wDtYoKmwPjIB6Qk
	5m78gNZJB9X+qJqGdV4A9TPooCPQfFAxdnyu1O0pWi04mvx9xW/Axabn4pXLfyU4UlKWAT99aTt
	/0/f9apObp7FxuILVmE3YKBvLWYouiilR1/F5BiE2LdzQy9ipM/TzvlslZRQ+y0PpQpmcfdqz74
	dx
X-Google-Smtp-Source: AGHT+IHc0zrGSwszyLR24bRSf09Tu7kSTOa11Mr2wBs5EV0LlCeYsUd+vTRKfV7uXA70Z5R/dSJUTw==
X-Received: by 2002:a05:620a:700d:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8ab9b59957emr747008785a.74.1761976598533;
        Fri, 31 Oct 2025 22:56:38 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac0357f7desm247195085a.41.2025.10.31.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 22:56:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EF0004209E50; Sat, 01 Nov 2025 12:56:25 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: intel-pstate: Use :ref: directive for internal linking
Date: Sat,  1 Nov 2025 12:56:14 +0700
Message-ID: <20251101055614.32270-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19443; i=bagasdotme@gmail.com; h=from:subject; bh=ciqXU+1NcuVr4iigJo4KYFshbbWaXN1fMRAm85K4jo8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmsCwr/T7+j+OREpvLzGbKiPadX7evzuMQTa1o21fb2u aX3AiYFdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiU/kYfjImPrp05v/deZUO Lw3WrxKczKt3Ldxi2tp7pscPChuITIliZLhR+TDOatIpq6lCj1prDEX2aPuapfxk//Zkrq+Yrvb lQ1wA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

pstate docs uses standard reST construct (`Section title`_) for
cross-referencing sections (internal linking), rather than for external
links. Incorrect cross-references are not caught when these are written
in that syntax, however (fortunately docutils 0.22 raise duplicate
target warnings that get fixed in cb908f8b0acc7e ("Documentation:
intel_pstate: fix duplicate hyperlink target errors")).

Convert the cross-references to use :ref: directive, which doesn't
exhibit this problem.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 133 +++++++++---------
 1 file changed, 70 insertions(+), 63 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 9cdd9dad651698..fde967b0c2e0e5 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -48,8 +48,9 @@ only way to pass early-configuration-time parameters to it is via the kernel
 command line.  However, its configuration can be adjusted via ``sysfs`` to a
 great extent.  In some configurations it even is possible to unregister it via
 ``sysfs`` which allows another ``CPUFreq`` scaling driver to be loaded and
-registered (see `below <status_attr_>`_).
+registered (see :ref:`below <status_attr>`).
 
+.. _operation_modes:
 
 Operation Modes
 ===============
@@ -62,7 +63,7 @@ a certain performance scaling algorithm.  Which of them will be in effect
 depends on what kernel command line options are used and on the capabilities of
 the processor.
 
-.. _Active Mode:
+.. _active_mode:
 
 Active Mode
 -----------
@@ -96,7 +97,7 @@ Which of the P-state selection algorithms is used by default depends on the
 Namely, if that option is set, the ``performance`` algorithm will be used by
 default, and the other one will be used by default if it is not set.
 
-.. _Active Mode With HWP:
+.. _active_mode_hwp:
 
 Active Mode With HWP
 ~~~~~~~~~~~~~~~~~~~~
@@ -127,7 +128,7 @@ Energy-Performance Bias (EPB) knob (otherwise), which means that the processor's
 internal P-state selection logic is expected to focus entirely on performance.
 
 This will override the EPP/EPB setting coming from the ``sysfs`` interface
-(see `Energy vs Performance Hints`_ below).  Moreover, any attempts to change
+(see :ref:`energy_performance_hints` below).  Moreover, any attempts to change
 the EPP/EPB to a value different from 0 ("performance") via ``sysfs`` in this
 configuration will be rejected.
 
@@ -196,7 +197,7 @@ This is the default P-state selection algorithm if the
 :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
 is not set.
 
-.. _Passive Mode:
+.. _passive_mode:
 
 Passive Mode
 ------------
@@ -295,12 +296,12 @@ Unlike ``_PSS`` objects in the ACPI tables, ``intel_pstate`` always exposes
 the entire range of available P-states, including the whole turbo range, to the
 ``CPUFreq`` core and (in the passive mode) to generic scaling governors.  This
 generally causes turbo P-states to be set more often when ``intel_pstate`` is
-used relative to ACPI-based CPU performance scaling (see `below <acpi-cpufreq_>`_
-for more information).
+used relative to ACPI-based CPU performance scaling (see
+:ref:`below <acpi-cpufreq>` for more information).
 
 Moreover, since ``intel_pstate`` always knows what the real turbo threshold is
 (even if the Configurable TDP feature is enabled in the processor), its
-``no_turbo`` attribute in ``sysfs`` (described `below <no_turbo_attr_>`_) should
+``no_turbo`` attribute in ``sysfs`` (described :ref:`below <no_turbo_attr>`) should
 work as expected in all cases (that is, if set to disable turbo P-states, it
 always should prevent ``intel_pstate`` from using them).
 
@@ -313,12 +314,12 @@ pieces of information on it to be known, including:
 
  * The minimum supported P-state.
 
- * The maximum supported `non-turbo P-state <turbo_>`_.
+ * The maximum supported :ref:`non-turbo P-state <turbo>`.
 
  * Whether or not turbo P-states are supported at all.
 
- * The maximum supported `one-core turbo P-state <turbo_>`_ (if turbo P-states
-   are supported).
+ * The maximum supported :ref:`one-core turbo P-state <turbo>` (if turbo
+   P-states are supported).
 
  * The scaling formula to translate the driver's internal representation
    of P-states into frequencies and the other way around.
@@ -406,10 +407,10 @@ Energy-Aware Scheduling Support
 
 If ``CONFIG_ENERGY_MODEL`` has been set during kernel configuration and
 ``intel_pstate`` runs on a hybrid processor without SMT, in addition to enabling
-`CAS <CAS_>`_ it registers an Energy Model for the processor.  This allows the
+:ref:`CAS` it registers an Energy Model for the processor.  This allows the
 Energy-Aware Scheduling (EAS) support to be enabled in the CPU scheduler if
 ``schedutil`` is used as the  ``CPUFreq`` governor which requires ``intel_pstate``
-to operate in the `passive mode <Passive Mode_>`_.
+to operate in the :ref:`passive mode <passive_mode>`.
 
 The Energy Model registered by ``intel_pstate`` is artificial (that is, it is
 based on abstract cost values and it does not include any real power numbers)
@@ -438,7 +439,7 @@ the ``energy_model`` directory in ``debugfs`` (typlically mounted on
 User Space Interface in ``sysfs``
 =================================
 
-.. _Global Attributes:
+.. _global_attributes:
 
 Global Attributes
 -----------------
@@ -452,8 +453,8 @@ argument is passed to the kernel in the command line.
 
 ``max_perf_pct``
 	Maximum P-state the driver is allowed to set in percent of the
-	maximum supported performance level (the highest supported `turbo
-	P-state <turbo_>`_).
+	maximum supported performance level (the highest supported :ref:`turbo
+	P-state <turbo>`).
 
 	This attribute will not be exposed if the
 	``intel_pstate=per_cpu_perf_limits`` argument is present in the kernel
@@ -461,8 +462,8 @@ argument is passed to the kernel in the command line.
 
 ``min_perf_pct``
 	Minimum P-state the driver is allowed to set in percent of the
-	maximum supported performance level (the highest supported `turbo
-	P-state <turbo_>`_).
+	maximum supported performance level (the highest supported :ref:`turbo
+	P-state <turbo>`).
 
 	This attribute will not be exposed if the
 	``intel_pstate=per_cpu_perf_limits`` argument is present in the kernel
@@ -471,18 +472,18 @@ argument is passed to the kernel in the command line.
 ``num_pstates``
 	Number of P-states supported by the processor (between 0 and 255
 	inclusive) including both turbo and non-turbo P-states (see
-	`Turbo P-states Support`_).
+	:ref:`turbo`).
 
 	This attribute is present only if the value exposed by it is the same
 	for all of the CPUs in the system.
 
 	The value of this attribute is not affected by the ``no_turbo``
-	setting described `below <no_turbo_attr_>`_.
+	setting described :ref:`below <no_turbo_attr>`.
 
 	This attribute is read-only.
 
 ``turbo_pct``
-	Ratio of the `turbo range <turbo_>`_ size to the size of the entire
+	Ratio of the :ref:`turbo range <turbo>` size to the size of the entire
 	range of supported P-states, in percent.
 
 	This attribute is present only if the value exposed by it is the same
@@ -494,7 +495,7 @@ argument is passed to the kernel in the command line.
 
 ``no_turbo``
 	If set (equal to 1), the driver is not allowed to set any turbo P-states
-	(see `Turbo P-states Support`_).  If unset (equal to 0, which is the
+	(see :ref:`turbo`).  If unset (equal to 0, which is the
 	default), turbo P-states can be set by the driver.
 	[Note that ``intel_pstate`` does not support the general ``boost``
 	attribute (supported by some other scaling drivers) which is replaced
@@ -503,11 +504,11 @@ argument is passed to the kernel in the command line.
 	This attribute does not affect the maximum supported frequency value
 	supplied to the ``CPUFreq`` core and exposed via the policy interface,
 	but it affects the maximum possible value of per-policy P-state	limits
-	(see `Interpretation of Policy Attributes`_ below for details).
+	(see :ref:`policy_attributes_interpretation` below for details).
 
 ``hwp_dynamic_boost``
 	This attribute is only present if ``intel_pstate`` works in the
-	`active mode with the HWP feature enabled <Active Mode With HWP_>`_ in
+	:ref:`active mode with the HWP feature enabled <active_mode_hwp>` in
 	the processor.  If set (equal to 1), it causes the minimum P-state limit
 	to be increased dynamically for a short time whenever a task previously
 	waiting on I/O is selected to run on a given logical CPU (the purpose
@@ -522,12 +523,12 @@ argument is passed to the kernel in the command line.
 	Operation mode of the driver: "active", "passive" or "off".
 
 	"active"
-		The driver is functional and in the `active mode
-		<Active Mode_>`_.
+		The driver is functional and in the :ref:`active mode
+		<active_mode>`.
 
 	"passive"
-		The driver is functional and in the `passive mode
-		<Passive Mode_>`_.
+		The driver is functional and in the :ref:`passive mode
+		<passive_mode>`.
 
 	"off"
 		The driver is not functional (it is not registered as a scaling
@@ -555,13 +556,15 @@ argument is passed to the kernel in the command line.
 	attribute to "1" enables the energy-efficiency optimizations and setting
 	to "0" disables them.
 
+.. _policy_attributes_interpretation:
+
 Interpretation of Policy Attributes
 -----------------------------------
 
 The interpretation of some ``CPUFreq`` policy attributes described in
 Documentation/admin-guide/pm/cpufreq.rst is special with ``intel_pstate``
 as the current scaling driver and it generally depends on the driver's
-`operation mode <Operation Modes_>`_.
+:ref:`operation mode <operation_modes>`.
 
 First of all, the values of the ``cpuinfo_max_freq``, ``cpuinfo_min_freq`` and
 ``scaling_cur_freq`` attributes are produced by applying a processor-specific
@@ -570,9 +573,10 @@ Also, the values of the ``scaling_max_freq`` and ``scaling_min_freq``
 attributes are capped by the frequency corresponding to the maximum P-state that
 the driver is allowed to set.
 
-If the ``no_turbo`` `global attribute <no_turbo_attr_>`_ is set, the driver is
-not allowed to use turbo P-states, so the maximum value of ``scaling_max_freq``
-and ``scaling_min_freq`` is limited to the maximum non-turbo P-state frequency.
+If the ``no_turbo`` :ref:`global attribute <no_turbo_attr>` is set, the driver
+is not allowed to use turbo P-states, so the maximum value of
+``scaling_max_freq`` and ``scaling_min_freq`` is limited to the maximum
+non-turbo P-state frequency.
 Accordingly, setting ``no_turbo`` causes ``scaling_max_freq`` and
 ``scaling_min_freq`` to go down to that value if they were above it before.
 However, the old values of ``scaling_max_freq`` and ``scaling_min_freq`` will be
@@ -584,7 +588,7 @@ and ``scaling_min_freq`` corresponds to the maximum supported turbo P-state,
 which also is the value of ``cpuinfo_max_freq`` in either case.
 
 Next, the following policy attributes have special meaning if
-``intel_pstate`` works in the `active mode <Active Mode_>`_:
+``intel_pstate`` works in the :ref:`active mode <active_mode>`:
 
 ``scaling_available_governors``
 	List of P-state selection algorithms provided by ``intel_pstate``.
@@ -605,20 +609,22 @@ processor:
 	Shows the base frequency of the CPU. Any frequency above this will be
 	in the turbo frequency range.
 
-The meaning of these attributes in the `passive mode <Passive Mode_>`_ is the
+The meaning of these attributes in the :ref:`passive mode <passive_mode>` is the
 same as for other scaling drivers.
 
 Additionally, the value of the ``scaling_driver`` attribute for ``intel_pstate``
 depends on the operation mode of the driver.  Namely, it is either
-"intel_pstate" (in the `active mode <Active Mode_>`_) or "intel_cpufreq" (in the
-`passive mode <Passive Mode_>`_).
+"intel_pstate" (in the :ref:`active mode <active_mode>`) or "intel_cpufreq"
+(in the :ref:`passive mode <passive_mode>`).
+
+.. _pstate_limits_coordination:
 
 Coordination of P-State Limits
 ------------------------------
 
 ``intel_pstate`` allows P-state limits to be set in two ways: with the help of
-the ``max_perf_pct`` and ``min_perf_pct`` `global attributes
-<Global Attributes_>`_ or via the ``scaling_max_freq`` and ``scaling_min_freq``
+the ``max_perf_pct`` and ``min_perf_pct`` :ref:`global attributes
+<global_attributes>` or via the ``scaling_max_freq`` and ``scaling_min_freq``
 ``CPUFreq`` policy attributes.  The coordination between those limits is based
 on the following rules, regardless of the current operation mode of the driver:
 
@@ -640,17 +646,18 @@ on the following rules, regardless of the current operation mode of the driver:
 
  3. The global and per-policy limits can be set independently.
 
-In the `active mode with the HWP feature enabled <Active Mode With HWP_>`_, the
+In the :ref:`active mode with the HWP feature enabled <active_mode_hwp>`, the
 resulting effective values are written into hardware registers whenever the
 limits change in order to request its internal P-state selection logic to always
 set P-states within these limits.  Otherwise, the limits are taken into account
-by scaling governors (in the `passive mode <Passive Mode_>`_) and by the driver
-every time before setting a new P-state for a CPU.
+by scaling governors (in the :ref:`passive mode <passive_mode>`) and by the
+driver every time before setting a new P-state for a CPU.
 
 Additionally, if the ``intel_pstate=per_cpu_perf_limits`` command line argument
 is passed to the kernel, ``max_perf_pct`` and ``min_perf_pct`` are not exposed
 at all and the only way to set the limits is by using the policy attributes.
 
+.. _energy_performance_hints:
 
 Energy vs Performance Hints
 ---------------------------
@@ -710,9 +717,9 @@ output.
 On those systems each ``_PSS`` object returns a list of P-states supported by
 the corresponding CPU which basically is a subset of the P-states range that can
 be used by ``intel_pstate`` on the same system, with one exception: the whole
-`turbo range <turbo_>`_ is represented by one item in it (the topmost one).  By
-convention, the frequency returned by ``_PSS`` for that item is greater by 1 MHz
-than the frequency of the highest non-turbo P-state listed by it, but the
+:ref:`turbo range <turbo>` is represented by one item in it (the topmost one).
+By convention, the frequency returned by ``_PSS`` for that item is greater by
+1 MHz than the frequency of the highest non-turbo P-state listed by it, but the
 corresponding P-state representation (following the hardware specification)
 returned for it matches the maximum supported turbo P-state (or is the
 special value 255 meaning essentially "go as high as you can get").
@@ -738,18 +745,18 @@ benefit from running at turbo frequencies will be given non-turbo P-states
 instead.
 
 One more issue related to that may appear on systems supporting the
-`Configurable TDP feature <turbo_>`_ allowing the platform firmware to set the
-turbo threshold.  Namely, if that is not coordinated with the lists of P-states
-returned by ``_PSS`` properly, there may be more than one item corresponding to
-a turbo P-state in those lists and there may be a problem with avoiding the
-turbo range (if desirable or necessary).  Usually, to avoid using turbo
-P-states overall, ``acpi-cpufreq`` simply avoids using the topmost state listed
-by ``_PSS``, but that is not sufficient when there are other turbo P-states in
-the list returned by it.
+:ref:`Configurable TDP feature <turbo>` allowing the platform firmware to set
+the turbo threshold.  Namely, if that is not coordinated with the lists of
+P-states returned by ``_PSS`` properly, there may be more than one item
+corresponding to a turbo P-state in those lists and there may be a problem with
+avoiding the turbo range (if desirable or necessary).  Usually, to avoid using
+turbo P-states overall, ``acpi-cpufreq`` simply avoids using the topmost state
+listed by ``_PSS``, but that is not sufficient when there are other turbo
+P-states in the list returned by it.
 
 Apart from the above, ``acpi-cpufreq`` works like ``intel_pstate`` in the
-`passive mode <Passive Mode_>`_, except that the number of P-states it can set
-is limited to the ones listed by the ACPI ``_PSS`` objects.
+:ref:`passive mode <passive_mode>`, except that the number of P-states it can
+set is limited to the ones listed by the ACPI ``_PSS`` objects.
 
 
 Kernel Command Line Options for ``intel_pstate``
@@ -764,11 +771,11 @@ of them have to be prepended with the ``intel_pstate=`` prefix.
 	processor is supported by it.
 
 ``active``
-	Register ``intel_pstate`` in the `active mode <Active Mode_>`_ to start
-	with.
+	Register ``intel_pstate`` in the :ref:`active mode <active_mode>` to
+        start with.
 
 ``passive``
-	Register ``intel_pstate`` in the `passive mode <Passive Mode_>`_ to
+	Register ``intel_pstate`` in the :ref:`passive mode <passive_mode>` to
 	start with.
 
 ``force``
@@ -801,12 +808,12 @@ of them have to be prepended with the ``intel_pstate=`` prefix.
 	and this option has no effect.
 
 ``per_cpu_perf_limits``
-	Use per-logical-CPU P-State limits (see `Coordination of P-state
-	Limits`_ for details).
+	Use per-logical-CPU P-State limits (see
+        :ref:`pstate_limits_coordination` for details).
 
 ``no_cas``
-	Do not enable `capacity-aware scheduling <CAS_>`_ which is enabled by
-	default on hybrid systems without SMT.
+	Do not enable :ref:`capacity-aware scheduling <CAS>` which is enabled
+        by default on hybrid systems without SMT.
 
 Diagnostics and Tuning
 ======================
@@ -818,7 +825,7 @@ There are two static trace events that can be used for ``intel_pstate``
 diagnostics.  One of them is the ``cpu_frequency`` trace event generally used
 by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event specific
 to ``intel_pstate``.  Both of them are triggered by ``intel_pstate`` only if
-it works in the `active mode <Active Mode_>`_.
+it works in the :ref:`active mode <active_mode>`.
 
 The following sequence of shell commands can be used to enable them and see
 their output (if the kernel is generally configured to support event tracing)::
@@ -830,7 +837,7 @@ their output (if the kernel is generally configured to support event tracing)::
  gnome-terminal--4510  [001] ..s.  1177.680733: pstate_sample: core_busy=107 scaled=94 from=26 to=26 mperf=1143818 aperf=1230607 tsc=29838618 freq=2474476
  cat-5235  [002] ..s.  1177.681723: cpu_frequency: state=2900000 cpu_id=2
 
-If ``intel_pstate`` works in the `passive mode <Passive Mode_>`_, the
+If ``intel_pstate`` works in the :ref:`passive mode <passive_mode>`, the
 ``cpu_frequency`` trace event will be triggered either by the ``schedutil``
 scaling governor (for the policies it is attached to), or by the ``CPUFreq``
 core (for the policies with other scaling governors).

base-commit: eda819ce75b976da206c2c605d380a881e9281b1
-- 
An old man doll... just what I always wanted! - Clara


