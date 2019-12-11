Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A355911C004
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 23:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLKWoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 17:44:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLKWoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 17:44:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so103005wmd.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHar8caGVk2CHYCleN7lzgXckcrdAjaPRcEzE+leMkc=;
        b=adUlVTiTz/iXrhnDM4CQmeVqAvo6g5aR4wZlXa2/qvQCfFdJBMaA2fP1Ktz4VgakJ9
         BBO+16TMexseKta7EmbwHlfuSVpAUrBIWuLnAcmcbhRlSQYM6MMjAGNk+cmk3dzipVKv
         5yCOUdWh0IB2vW2QZ/ipPZ6smv+S6mBHKcruTY9jukDzyAdeoICyWz1xtbaXYzMSfl/a
         NCjpGmD1r4vd2dBLCDnZiK1efTFD/2/OnfIvbI8G3NGDY4khNeRauKAu1pEEqxOH1049
         UF4UA8Yy1Xme/7jfzyq9w2d9PQzmCjdGMfBXhYWITGHxf4AMCkQPj5C+0izWgcdzs+fw
         NJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHar8caGVk2CHYCleN7lzgXckcrdAjaPRcEzE+leMkc=;
        b=sbi1tmBQdHe85Itfk5qVb/qQ1//Xb2y4HGnuSu9/9ClaSfJ7NWmUoS76c3BZ1mHzMN
         XZp57sbjR35Gw8PgKysbdobxJqhMPkywJFqO0QXywOwA8FvK4Wv42Wi4dLeTRqYkfNUJ
         cJoUEADATO1Zzk8v/KcxkAHpB45wSXcCiRFLcHi3yuWXEjdWPWPJj/drSL8olC44MbAL
         dZKt757wyYYzMrxiEDHsKhIjB+UzUp4ctP3RwWHltjyjXZcb/130BAWxc0k4hX38NEiv
         lkOp5/Rie+y1M9IzvuZdM4T6rgoGGEvyG/osTjzyyhaLXKUqX7Mg4qJ306JAPO6/SnDz
         N74g==
X-Gm-Message-State: APjAAAUTVB0qSp433+gKw7nmc/qy1LK45cPFv7sa4r9phGnH3oguuJRe
        x3EUjcdFyHJsRhNzG/zuWXvUhw==
X-Google-Smtp-Source: APXvYqxWuk+Lrm/FHXMVcb/FiFoVob5UTEWEOs3xuQsfhMJjYIGsVdmNDISq1z+WL1stPmn98F97Hw==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr2420119wmk.94.1576104241537;
        Wed, 11 Dec 2019 14:44:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:48f7:48fb:71cb:f13a])
        by smtp.gmail.com with ESMTPSA id s16sm3798809wrn.78.2019.12.11.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 14:44:00 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org, martin.kepplinger@puri.sm
Subject: [PATCH V5 1/3] thermal/drivers/cpu_cooling: Add idle cooling device documentation
Date:   Wed, 11 Dec 2019 23:43:45 +0100
Message-Id: <20191211224347.1001-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Provide some documentation for the idle injection cooling effect in
order to let people to understand the rational of the approach for the
idle injection CPU cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
  V4:
    - Fixed typos, replaced 'period' per 'duty cycles', clarified some
      wording (Amit Kucheria)
---
 .../driver-api/thermal/cpu-idle-cooling.rst   | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
new file mode 100644
index 000000000000..13d7fe4e8de8
--- /dev/null
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -0,0 +1,189 @@
+
+Situation:
+----------
+
+Under certain circumstances a SoC can reach a critical temperature
+limit and is unable to stabilize the temperature around a temperature
+control. When the SoC has to stabilize the temperature, the kernel can
+act on a cooling device to mitigate the dissipated power. When the
+critical temperature is reached, a decision must be taken to reduce
+the temperature, that, in turn impacts performance.
+
+Another situation is when the silicon temperature continues to
+increase even after the dynamic leakage is reduced to its minimum by
+clock gating the component. This runaway phenomenon can continue due
+to the static leakage. The only solution is to power down the
+component, thus dropping the dynamic and static leakage that will
+allow the component to cool down.
+
+Last but not least, the system can ask for a specific power budget but
+because of the OPP density, we can only choose an OPP with a power
+budget lower than the requested one and under-utilize the CPU, thus
+losing performance. In other words, one OPP under-utilizes the CPU
+with a power less than the requested power budget and the next OPP
+exceeds the power budget. An intermediate OPP could have been used if
+it were present.
+
+Solutions:
+----------
+
+If we can remove the static and the dynamic leakage for a specific
+duration in a controlled period, the SoC temperature will
+decrease. Acting on the idle state duration or the idle cycle
+injection period, we can mitigate the temperature by modulating the
+power budget.
+
+The Operating Performance Point (OPP) density has a great influence on
+the control precision of cpufreq, however different vendors have a
+plethora of OPP density, and some have large power gap between OPPs,
+that will result in loss of performance during thermal control and
+loss of power in other scenarios.
+
+At a specific OPP, we can assume that injecting idle cycle on all CPUs
+belong to the same cluster, with a duration greater than the cluster
+idle state target residency, we lead to dropping the static and the
+dynamic leakage for this period (modulo the energy needed to enter
+this state). So the sustainable power with idle cycles has a linear
+relation with the OPP’s sustainable power and can be computed with a
+coefficient similar to:
+
+	    Power(IdleCycle) = Coef x Power(OPP)
+
+Idle Injection:
+---------------
+
+The base concept of the idle injection is to force the CPU to go to an
+idle state for a specified time each control cycle, it provides
+another way to control CPU power and heat in addition to
+cpufreq. Ideally, if all CPUs belonging to the same cluster, inject
+their idle cycles synchronously, the cluster can reach its power down
+state with a minimum power consumption and reduce the static leakage
+to almost zero.  However, these idle cycles injection will add extra
+latencies as the CPUs will have to wakeup from a deep sleep state.
+
+We use a fixed duration of idle injection that gives an acceptable
+performance penalty and a fixed latency. Mitigation can be increased
+or decreased by modulating the duty cycle of the idle injection.
+
+     ^
+     |
+     |
+     |-------                         -------
+     |_______|_______________________|_______|___________
+
+     <------>
+       idle  <---------------------->
+                    running
+
+      <----------------------------->
+              duty cycle 25%
+
+	      
+The implementation of the cooling device bases the number of states on
+the duty cycle percentage. When no mitigation is happening the cooling
+device state is zero, meaning the duty cycle is 0%.
+
+When the mitigation begins, depending on the governor's policy, a
+starting state is selected. With a fixed idle duration and the duty
+cycle (aka the cooling device state), the running duration can be
+computed.
+
+The governor will change the cooling device state thus the duty cycle
+and this variation will modulate the cooling effect.
+
+     ^
+     |
+     |
+     |-------                 -------
+     |_______|_______________|_______|___________
+
+     <------>
+       idle  <-------------->
+                running
+
+      <----------------------------->
+              duty cycle 33%
+
+
+     ^
+     |
+     |
+     |-------         -------
+     |_______|_______|_______|___________
+
+     <------>
+       idle  <------>
+              running
+
+      <------------->
+       duty cycle 50%
+
+The idle injection duration value must comply with the constraints:
+
+- It is less than or equal to the latency we tolerate when the
+  mitigation begins. It is platform dependent and will depend on the
+  user experience, reactivity vs performance trade off we want. This
+  value should be specified.
+
+- It is greater than the idle state’s target residency we want to go
+  for thermal mitigation, otherwise we end up consuming more energy.
+
+Power considerations
+--------------------
+  
+When we reach the thermal trip point, we have to sustain a specified
+power for a specific temperature but at this time we consume:
+
+ Power = Capacitance x Voltage^2 x Frequency x Utilisation
+
+... which is more than the sustainable power (or there is something
+wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
+fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
+because we don’t want to change the OPP. We can group the
+‘Capacitance’ and the ‘Utilisation’ into a single term which is the
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+
+ Pdyn = Cdyn x Voltage^2 x Frequency
+
+The power allocator governor will ask us somehow to reduce our power
+in order to target the sustainable power defined in the device
+tree. So with the idle injection mechanism, we want an average power
+(Ptarget) resulting in an amount of time running at full power on a
+specific OPP and idle another amount of time. That could be put in a
+equation:
+
+ P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
+			(Trunning + Tidle)
+  ...
+
+ Tidle = Trunning x ((P(opp)running / P(opp)target) - 1)
+
+At this point if we know the running period for the CPU, that gives us
+the idle injection we need. Alternatively if we have the idle
+injection duration, we can compute the running duration with:
+
+ Trunning = Tidle / ((P(opp)running / P(opp)target) - 1)
+
+Practically, if the running power is less than the targeted power, we
+end up with a negative time value, so obviously the equation usage is
+bound to a power reduction, hence a higher OPP is needed to have the
+running power greater than the targeted power.
+
+However, in this demonstration we ignore three aspects:
+
+ * The static leakage is not defined here, we can introduce it in the
+   equation but assuming it will be zero most of the time as it is
+   difficult to get the values from the SoC vendors
+
+ * The idle state wake up latency (or entry + exit latency) is not
+   taken into account, it must be added in the equation in order to
+   rigorously compute the idle injection
+
+ * The injected idle duration must be greater than the idle state
+   target residency, otherwise we end up consuming more energy and
+   potentially invert the mitigation effect
+
+So the final equation is:
+
+ Trunning = (Tidle - Twakeup ) x
+		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
-- 
2.17.1

