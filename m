Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2704159D80
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBKXin (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgBKXim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:42 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id b104e132117a5803; Wed, 12 Feb 2020 00:38:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: [PATCH 27/28] Documentation: PM: QoS: Update to reflect previous code changes
Date:   Wed, 12 Feb 2020 00:36:35 +0100
Message-ID: <263587662.Lb29Xrxheq@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Update the PM QoS documentation to reflect the previous code changes
regarding the removal of PM QoS classes and the CPU latency QoS API
rework.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst | 73 +++++++++++++--------------
 Documentation/power/pm_qos_interface.rst | 86 +++++++++++++++-----------------
 2 files changed, 75 insertions(+), 84 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 6a06dc473dd6..5605cc6f9560 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -583,20 +583,17 @@ Power Management Quality of Service for CPUs
 The power management quality of service (PM QoS) framework in the Linux kernel
 allows kernel code and user space processes to set constraints on various
 energy-efficiency features of the kernel to prevent performance from dropping
-below a required level.  The PM QoS constraints can be set globally, in
-predefined categories referred to as PM QoS classes, or against individual
-devices.
+below a required level.
 
 CPU idle time management can be affected by PM QoS in two ways, through the
-global constraint in the ``PM_QOS_CPU_DMA_LATENCY`` class and through the
-resume latency constraints for individual CPUs.  Kernel code (e.g. device
-drivers) can set both of them with the help of special internal interfaces
-provided by the PM QoS framework.  User space can modify the former by opening
-the :file:`cpu_dma_latency` special device file under :file:`/dev/` and writing
-a binary value (interpreted as a signed 32-bit integer) to it.  In turn, the
-resume latency constraint for a CPU can be modified by user space by writing a
-string (representing a signed 32-bit integer) to the
-:file:`power/pm_qos_resume_latency_us` file under
+global CPU latency limit and through the resume latency constraints for
+individual CPUs.  Kernel code (e.g. device drivers) can set both of them with
+the help of special internal interfaces provided by the PM QoS framework.  User
+space can modify the former by opening the :file:`cpu_dma_latency` special
+device file under :file:`/dev/` and writing a binary value (interpreted as a
+signed 32-bit integer) to it.  In turn, the resume latency constraint for a CPU
+can be modified from user space by writing a string (representing a signed
+32-bit integer) to the :file:`power/pm_qos_resume_latency_us` file under
 :file:`/sys/devices/system/cpu/cpu<N>/` in ``sysfs``, where the CPU number
 ``<N>`` is allocated at the system initialization time.  Negative values
 will be rejected in both cases and, also in both cases, the written integer
@@ -605,32 +602,34 @@ number will be interpreted as a requested PM QoS constraint in microseconds.
 The requested value is not automatically applied as a new constraint, however,
 as it may be less restrictive (greater in this particular case) than another
 constraint previously requested by someone else.  For this reason, the PM QoS
-framework maintains a list of requests that have been made so far in each
-global class and for each device, aggregates them and applies the effective
-(minimum in this particular case) value as the new constraint.
+framework maintains a list of requests that have been made so far for the
+global CPU latency limit and for each individual CPU, aggregates them and
+applies the effective (minimum in this particular case) value as the new
+constraint.
 
 In fact, opening the :file:`cpu_dma_latency` special device file causes a new
-PM QoS request to be created and added to the priority list of requests in the
-``PM_QOS_CPU_DMA_LATENCY`` class and the file descriptor coming from the
-"open" operation represents that request.  If that file descriptor is then
-used for writing, the number written to it will be associated with the PM QoS
-request represented by it as a new requested constraint value.  Next, the
-priority list mechanism will be used to determine the new effective value of
-the entire list of requests and that effective value will be set as a new
-constraint.  Thus setting a new requested constraint value will only change the
-real constraint if the effective "list" value is affected by it.  In particular,
-for the ``PM_QOS_CPU_DMA_LATENCY`` class it only affects the real constraint if
-it is the minimum of the requested constraints in the list.  The process holding
-a file descriptor obtained by opening the :file:`cpu_dma_latency` special device
-file controls the PM QoS request associated with that file descriptor, but it
-controls this particular PM QoS request only.
+PM QoS request to be created and added to a global priority list of CPU latency
+limit requests and the file descriptor coming from the "open" operation
+represents that request.  If that file descriptor is then used for writing, the
+number written to it will be associated with the PM QoS request represented by
+it as a new requested limit value.  Next, the priority list mechanism will be
+used to determine the new effective value of the entire list of requests and
+that effective value will be set as a new CPU latency limit.  Thus requesting a
+new limit value will only change the real limit if the effective "list" value is
+affected by it, which is the case if it is the minimum of the requested values
+in the list.
+
+The process holding a file descriptor obtained by opening the
+:file:`cpu_dma_latency` special device file controls the PM QoS request
+associated with that file descriptor, but it controls this particular PM QoS
+request only.
 
 Closing the :file:`cpu_dma_latency` special device file or, more precisely, the
 file descriptor obtained while opening it, causes the PM QoS request associated
-with that file descriptor to be removed from the ``PM_QOS_CPU_DMA_LATENCY``
-class priority list and destroyed.  If that happens, the priority list mechanism
-will be used, again, to determine the new effective value for the whole list
-and that value will become the new real constraint.
+with that file descriptor to be removed from the global priority list of CPU
+latency limit requests and destroyed.  If that happens, the priority list
+mechanism will be used again, to determine the new effective value for the whole
+list and that value will become the new limit.
 
 In turn, for each CPU there is one resume latency PM QoS request associated with
 the :file:`power/pm_qos_resume_latency_us` file under
@@ -647,10 +646,10 @@ CPU in question every time the list of requests is updated this way or another
 (there may be other requests coming from kernel code in that list).
 
 CPU idle time governors are expected to regard the minimum of the global
-effective ``PM_QOS_CPU_DMA_LATENCY`` class constraint and the effective
-resume latency constraint for the given CPU as the upper limit for the exit
-latency of the idle states they can select for that CPU.  They should never
-select any idle states with exit latency beyond that limit.
+(effective) CPU latency limit and the effective resume latency constraint for
+the given CPU as the upper limit for the exit latency of the idle states that
+they are allowed to select for that CPU.  They should never select any idle
+states with exit latency beyond that limit.
 
 
 Idle States Control Via Kernel Command Line
diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 0d62d506caf0..064f668fbdab 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -7,86 +7,78 @@ performance expectations by drivers, subsystems and user space applications on
 one of the parameters.
 
 Two different PM QoS frameworks are available:
-1. PM QoS classes for cpu_dma_latency
+1. CPU latency QoS.
 2. The per-device PM QoS framework provides the API to manage the
    per-device latency constraints and PM QoS flags.
 
-Each parameters have defined units:
-
- * latency: usec
- * timeout: usec
- * throughput: kbs (kilo bit / sec)
- * memory bandwidth: mbs (mega bit / sec)
+The latency unit used in the PM QoS framework is the microsecond (usec).
 
 
 1. PM QoS framework
 ===================
 
-The infrastructure exposes multiple misc device nodes one per implemented
-parameter.  The set of parameters implement is defined by pm_qos_power_init()
-and pm_qos_params.h.  This is done because having the available parameters
-being runtime configurable or changeable from a driver was seen as too easy to
-abuse.
-
-For each parameter a list of performance requests is maintained along with
-an aggregated target value.  The aggregated target value is updated with
-changes to the request list or elements of the list.  Typically the
-aggregated target value is simply the max or min of the request values held
-in the parameter list elements.
+A global list of CPU latency QoS requests is maintained along with an aggregated
+(effective) target value.  The aggregated target value is updated with changes
+to the request list or elements of the list.  For CPU latency QoS, the
+aggregated target value is simply the min of the request values held in the list
+elements.
+
 Note: the aggregated target value is implemented as an atomic variable so that
 reading the aggregated value does not require any locking mechanism.
 
+From kernel space the use of this interface is simple:
 
-From kernel mode the use of this interface is simple:
-
-void pm_qos_add_request(handle, param_class, target_value):
-  Will insert an element into the list for that identified PM QoS class with the
-  target value.  Upon change to this list the new target is recomputed and any
-  registered notifiers are called only if the target value is now different.
-  Clients of pm_qos need to save the returned handle for future use in other
-  pm_qos API functions.
+void cpu_latency_qos_add_request(handle, target_value):
+  Will insert an element into the CPU latency QoS list with the target value.
+  Upon change to this list the new target is recomputed and any registered
+  notifiers are called only if the target value is now different.
+  Clients of PM QoS need to save the returned handle for future use in other
+  PM QoS API functions.
 
-void pm_qos_update_request(handle, new_target_value):
+void cpu_latency_qos_update_request(handle, new_target_value):
   Will update the list element pointed to by the handle with the new target
   value and recompute the new aggregated target, calling the notification tree
   if the target is changed.
 
-void pm_qos_remove_request(handle):
+void cpu_latency_qos_remove_request(handle):
   Will remove the element.  After removal it will update the aggregate target
   and call the notification tree if the target was changed as a result of
   removing the request.
 
-int pm_qos_request(param_class):
-  Returns the aggregated value for a given PM QoS class.
+int cpu_latency_qos_limit():
+  Returns the aggregated value for the CPU latency QoS.
+
+int cpu_latency_qos_request_active(handle):
+  Returns if the request is still active, i.e. it has not been removed from the
+  CPU latency QoS list.
 
-int pm_qos_request_active(handle):
-  Returns if the request is still active, i.e. it has not been removed from a
-  PM QoS class constraints list.
+int cpu_latency_qos_add_notifier(notifier):
+  Adds a notification callback function to the CPU latency QoS. The callback is
+  called when the aggregated value for the CPU latency QoS is changed.
 
-int pm_qos_add_notifier(param_class, notifier):
-  Adds a notification callback function to the PM QoS class. The callback is
-  called when the aggregated value for the PM QoS class is changed.
+int cpu_latency_qos_remove_notifier(notifier):
+  Removes the notification callback function from the CPU latency QoS.
 
-int pm_qos_remove_notifier(int param_class, notifier):
-  Removes the notification callback function for the PM QoS class.
 
+From user space:
 
-From user mode:
+The infrastructure exposes one device node, /dev/cpu_dma_latency, for the CPU
+latency QoS.
 
-Only processes can register a pm_qos request.  To provide for automatic
+Only processes can register a PM QoS request.  To provide for automatic
 cleanup of a process, the interface requires the process to register its
-parameter requests in the following way:
+parameter requests as follows.
 
-To register the default pm_qos target for the specific parameter, the process
-must open /dev/cpu_dma_latency
+To register the default PM QoS target for the CPU latency QoS, the process must
+open /dev/cpu_dma_latency.
 
 As long as the device node is held open that process has a registered
 request on the parameter.
 
-To change the requested target value the process needs to write an s32 value to
-the open device node.  Alternatively the user mode program could write a hex
-string for the value using 10 char long format e.g. "0x12345678".  This
-translates to a pm_qos_update_request call.
+To change the requested target value, the process needs to write an s32 value to
+the open device node.  Alternatively, it can write a hex string for the value
+using the 10 char long format e.g. "0x12345678".  This translates to a
+cpu_latency_qos_update_request() call.
 
 To remove the user mode request for a target value simply close the device
 node.
-- 
2.16.4





