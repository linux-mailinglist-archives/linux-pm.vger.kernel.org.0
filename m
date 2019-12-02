Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8517E10F180
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 21:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLBU20 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 15:28:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54314 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLBU2Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 15:28:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so705549wmj.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 12:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6TOUAUpf290Soz5pSkfNzyRRTkHTSc9qnKiA/fCb8o=;
        b=UYf3GhONDa27GK7l36RzzSk2ThG/2hBAsQ3uSAgaUtS0a/aCkVlsGJ97hM/ZKjOfdX
         XMpbYOHSnMGHOEy0cJQeUk4A3avr87X9HodGDQqyce3kL8BdFvb6oH2v01Gs6z66QlmP
         JF8FEISgylcS58SpyZET8BYfLxvKAF0kQu34NqnGGUXYsG9wUf5TFK/OWUjckerfskiw
         i0nmkCHGYlhIZ1jUQyV8apDMVB4iJGii3ypjJE4Sc4NYoJRsDClRTh/CahaXiQe9j9MP
         wG8unBQL2dw+CrS/AMTTolWDo98+qU/f3T6c81Bb1E2uKp3dUM5yPeSncXZUwqn43aMj
         /AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6TOUAUpf290Soz5pSkfNzyRRTkHTSc9qnKiA/fCb8o=;
        b=SeIeHjvEz/zu3cGC9U9kznGRHJ6NeX6ldgjz6WU2fuc0MCRmUJtcMp3acPeI1j3qJ2
         83gArOCZZycA9GUuANgnatAZ6rvxD7+WwEjtmCQp3eoUxb6HH0xMLz8bjICnMeR0iVSd
         Z/skRqVIs0Ks6ppobcgXmS0rv2rCpjB8X1xTwnMMxXYMtJDfWvnuUGrWRddJHmmP5whG
         873oz0qWns/xfLsMlzJMpsFJV3EzYCX44SigsPbcMwkrJaPaWKidBKkSdGV+WwePciw0
         r2ulr5XHuK6m7Q+vroqw7sHh+qPdnDXoUwJF316eClqfym7sH5QIdkpoSYb1urk15wjw
         30dg==
X-Gm-Message-State: APjAAAUTgSNfbS3PFi49w5dyJNTo3y6qeQL+xGTcjaMIi0+T85Gri59U
        kSDtmJvE4yuXvsqLFFT6uv3XTQ==
X-Google-Smtp-Source: APXvYqwXBQh5FOsLbQHQxK+wUwdiHwnF1zOl6bKoAmw1Q41O0ndfKVQsLHRONXs9Qui0GaQ8/yHwSg==
X-Received: by 2002:a1c:2395:: with SMTP id j143mr29746361wmj.128.1575318503203;
        Mon, 02 Dec 2019 12:28:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id k20sm556456wmj.10.2019.12.02.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:28:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] thermal/drivers/cpu_cooling: Add idle cooling device documentation
Date:   Mon,  2 Dec 2019 21:28:13 +0100
Message-Id: <20191202202815.22731-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202202815.22731-1-daniel.lezcano@linaro.org>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
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
---
 .../driver-api/thermal/cpu-idle-cooling.rst   | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
new file mode 100644
index 000000000000..457cd9979ddb
--- /dev/null
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -0,0 +1,166 @@
+
+Situation:
+----------
+
+Under certain circumstances a SoC can reach the maximum temperature
+limit or is unable to stabilize the temperature around a temperature
+control. When the SoC has to stabilize the temperature, the kernel can
+act on a cooling device to mitigate the dissipated power. When the
+maximum temperature is reached and to prevent a reboot or a shutdown,
+a decision must be taken to reduce the temperature under the critical
+threshold, that impacts the performance.
+
+Another situation is when the silicon reaches a certain temperature
+which continues to increase even if the dynamic leakage is reduced to
+its minimum by clock gating the component. The runaway phenomena will
+continue with the static leakage and only powering down the component,
+thus dropping the dynamic and static leakage will allow the component
+to cool down.
+
+Last but not least, the system can ask for a specific power budget but
+because of the OPP density, we can only choose an OPP with a power
+budget lower than the requested one and underuse the CPU, thus losing
+performances. In other words, one OPP under uses the CPU with a power
+lesser than the power budget and the next OPP exceed the power budget,
+an intermediate OPP could have been used if it were present.
+
+Solutions:
+----------
+
+If we can remove the static and the dynamic leakage for a specific
+duration in a controlled period, the SoC temperature will
+decrease. Acting at the idle state duration or the idle cycle
+injection period, we can mitigate the temperature by modulating the
+power budget.
+
+The Operating Performance Point (OPP) density has a great influence on
+the control precision of cpufreq, however different vendors have a
+plethora of OPP density, and some have large power gap between OPPs,
+that will result in loss of performance during thermal control and
+loss of power in other scenes.
+
+At a specific OPP, we can assume injecting idle cycle on all CPUs,
+belonging to the same cluster, with a duration greater than the
+cluster idle state target residency, we drop the static and the
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
+their idle cycle synchronously, the cluster can reach its power down
+state with a minimum power consumption and static leakage
+drop. However, these idle cycles injection will add extra latencies as
+the CPUs will have to wakeup from a deep sleep state.
+
+     ^
+     |
+     |
+     |-------       -------       -------
+     |_______|_____|_______|_____|_______|___________
+
+      <----->
+       idle  <---->
+              running
+
+With the fixed idle injection duration, we can give a value which is
+an acceptable performance drop off or latency when we reach a specific
+temperature and we begin to mitigate by varying the Idle injection
+period.
+
+The mitigation begins with a maximum period value which decrease when
+more cooling effect is requested. When the period duration is equal to
+the idle duration, then we are in a situation the platform can’t
+dissipate the heat enough and the mitigation fails. In this case the
+situation is considered critical and there is nothing to do. The idle
+injection duration must be changed by configuration and until we reach
+the cooling effect, otherwise an additionnal cooling device must be
+used or ultimately decrease the SoC performance by dropping the
+highest OPP point of the SoC.
+
+The idle injection duration value must comply with the constraints:
+
+- It is lesser or equal to the latency we tolerate when the mitigation
+  begins. It is platform dependent and will depend on the user
+  experience, reactivity vs performance trade off we want. This value
+  should be specified.
+
+- It is greater than the idle state’s target residency we want to go
+  for thermal mitigation, otherwise we end up consuming more energy.
+
+Minimum period
+--------------
+
+The idle injection duration being fixed, it is obvious the minimum
+period can’t be lesser than that, otherwise we will be scheduling the
+idle injection task right before the idle injection duration is
+complete, so waking up the CPU to put it asleep again.
+
+Maximum period
+--------------
+
+The maximum period is the initial period when the mitigation
+begins. Theoretically when we reach the thermal trip point, we have to
+sustain a specified power for specific temperature but at this time we
+consume:
+
+ Power = Capacitance x Voltage^2 x Frequency x Utilisation
+
+... which is more than the sustainable power (or there is something
+wrong on the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
+fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
+because we don’t want to change the OPP. We can group the
+‘Capacitance’ and the ‘Utilisation’ into a single term which is the
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+
+ Pdyn = Cdyn x Voltage^2 x Frequency
+
+The IPA will ask us somehow to reduce our power in order to target the
+sustainable power defined in the device tree. So with the idle
+injection mechanism, we want an average power (Ptarget) resulting on
+an amount of time running at full power on a specific OPP and idle
+another amount of time. That could be put in a equation:
+
+ P(opp)target = ((trunning x (P(opp)running) + (tidle P(opp)idle)) /
+			(trunning + tidle)
+  ...
+
+ tidle = trunning x ((P(opp)running / P(opp)target) - 1)
+
+At this point if we know the running period for the CPU, that gives us
+the idle injection, we need. Alternatively if we have the idle
+injection duration, we can compute the running duration with:
+
+ trunning = tidle / ((P(opp)running / P(opp)target) - 1)
+
+Practically, if the running power is lesses than the targeted power,
+we end up with a negative time value, so obviously the equation usage
+is bound to a power reduction, hence a higher OPP is needed to have
+the running power greater than the targeted power.
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
+ trunning = (tidle - twakeup ) x
+		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
-- 
2.17.1

