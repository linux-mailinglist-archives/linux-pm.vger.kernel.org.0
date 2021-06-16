Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87BB3A9254
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhFPG35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhFPG3x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38FE613D9;
        Wed, 16 Jun 2021 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824867;
        bh=pFz1r1h81+i/mGF2uSwI/JWJDbJHTjv4eb/e5YOT/x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYfgYHwNp0MhA43ycg3oBKgjFegfCdzvwjjfbOzdtQJJkyF/PhpATBxickn+RaDGG
         u/3munXQXN5OQU1BcqiLrC7GWWplw/ahSi9lDPVZ/hruFzB6iXUQMskHuOksji0cXB
         i4PjjOlP/HLo+OHaSWj9Lzwc0zNa/vZwhDZn1Gg2MLxJyPbeCFmG/JqwXNXmupGQ+X
         ILxd7swAnVAEc/dvv+B2wvBqbNeJUlw8cPPO64cUUUwhuQUq8EwZx1SMKPOUqK3ogo
         y3iajYKnSUFI5qvSPZDTq4msZsX89Cxp8U1sOR2wgKYyysEtfawvvxXqyg/A6JwSVo
         nThgNHvn287uA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kIU-0B; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 03/29] docs: admin-guide: pm: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:18 +0200
Message-Id: <04616d9fc0b4a0d33486fa0018631a2db2eba860.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/pm/intel_idle.rst   | 16 ++++++++++------
 Documentation/admin-guide/pm/intel_pstate.rst |  9 +++++----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 89309e1b0e48..b799a43da62e 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -20,8 +20,8 @@ Nehalem and later generations of Intel processors, but the level of support for
 a particular processor model in it depends on whether or not it recognizes that
 processor model and may also depend on information coming from the platform
 firmware.  [To understand ``intel_idle`` it is necessary to know how ``CPUIdle``
-works in general, so this is the time to get familiar with :doc:`cpuidle` if you
-have not done that yet.]
+works in general, so this is the time to get familiar with
+Documentation/admin-guide/pm/cpuidle.rst if you have not done that yet.]
 
 ``intel_idle`` uses the ``MWAIT`` instruction to inform the processor that the
 logical CPU executing it is idle and so it may be possible to put some of the
@@ -53,7 +53,8 @@ processor) corresponding to them depends on the processor model and it may also
 depend on the configuration of the platform.
 
 In order to create a list of available idle states required by the ``CPUIdle``
-subsystem (see :ref:`idle-states-representation` in :doc:`cpuidle`),
+subsystem (see :ref:`idle-states-representation` in
+Documentation/admin-guide/pm/cpuidle.rst),
 ``intel_idle`` can use two sources of information: static tables of idle states
 for different processor models included in the driver itself and the ACPI tables
 of the system.  The former are always used if the processor model at hand is
@@ -98,7 +99,8 @@ states may not be enabled by default if there are no matching entries in the
 preliminary list of idle states coming from the ACPI tables.  In that case user
 space still can enable them later (on a per-CPU basis) with the help of
 the ``disable`` idle state attribute in ``sysfs`` (see
-:ref:`idle-states-representation` in :doc:`cpuidle`).  This basically means that
+:ref:`idle-states-representation` in
+Documentation/admin-guide/pm/cpuidle.rst).  This basically means that
 the idle states "known" to the driver may not be enabled by default if they have
 not been exposed by the platform firmware (through the ACPI tables).
 
@@ -186,7 +188,8 @@ be desirable.  In practice, it is only really necessary to do that if the idle
 states in question cannot be enabled during system startup, because in the
 working state of the system the CPU power management quality of service (PM
 QoS) feature can be used to prevent ``CPUIdle`` from touching those idle states
-even if they have been enumerated (see :ref:`cpu-pm-qos` in :doc:`cpuidle`).
+even if they have been enumerated (see :ref:`cpu-pm-qos` in
+Documentation/admin-guide/pm/cpuidle.rst).
 Setting ``max_cstate`` to 0 causes the ``intel_idle`` initialization to fail.
 
 The ``no_acpi`` and ``use_acpi`` module parameters (recognized by ``intel_idle``
@@ -202,7 +205,8 @@ Namely, the positions of the bits that are set in the ``states_off`` value are
 the indices of idle states to be disabled by default (as reflected by the names
 of the corresponding idle state directories in ``sysfs``, :file:`state0`,
 :file:`state1` ... :file:`state<i>` ..., where ``<i>`` is the index of the given
-idle state; see :ref:`idle-states-representation` in :doc:`cpuidle`).
+idle state; see :ref:`idle-states-representation` in
+Documentation/admin-guide/pm/cpuidle.rst).
 
 For example, if ``states_off`` is equal to 3, the driver will disable idle
 states 0 and 1 by default, and if it is equal to 8, idle state 3 will be
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index df29b4f1f219..7a7d4b041eac 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -18,8 +18,8 @@ General Information
 (``CPUFreq``).  It is a scaling driver for the Sandy Bridge and later
 generations of Intel processors.  Note, however, that some of those processors
 may not be supported.  [To understand ``intel_pstate`` it is necessary to know
-how ``CPUFreq`` works in general, so this is the time to read :doc:`cpufreq` if
-you have not done that yet.]
+how ``CPUFreq`` works in general, so this is the time to read
+Documentation/admin-guide/pm/cpufreq.rst if you have not done that yet.]
 
 For the processors supported by ``intel_pstate``, the P-state concept is broader
 than just an operating frequency or an operating performance point (see the
@@ -445,8 +445,9 @@ Interpretation of Policy Attributes
 -----------------------------------
 
 The interpretation of some ``CPUFreq`` policy attributes described in
-:doc:`cpufreq` is special with ``intel_pstate`` as the current scaling driver
-and it generally depends on the driver's `operation mode <Operation Modes_>`_.
+Documentation/admin-guide/pm/cpufreq.rst is special with ``intel_pstate``
+as the current scaling driver and it generally depends on the driver's
+`operation mode <Operation Modes_>`_.
 
 First of all, the values of the ``cpuinfo_max_freq``, ``cpuinfo_min_freq`` and
 ``scaling_cur_freq`` attributes are produced by applying a processor-specific
-- 
2.31.1

