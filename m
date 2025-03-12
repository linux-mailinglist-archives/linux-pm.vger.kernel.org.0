Return-Path: <linux-pm+bounces-23899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D847EA5D410
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B7C1897F31
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 01:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26641172A;
	Wed, 12 Mar 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnOcUuic"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC772F24
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743176; cv=none; b=DOro4AThKoEk+KvVr/lDfHmWHZRGnmPhijQB8ljJtFbZaMs12C7+kz7E7zrWjdX0yHp+QQ2VsLnOPBR+kOjjD5qnpPEhFv6UXJxTQLa8hSEexgoq+IQw8seyz6rcidBhxwM+fhCzGubZZhfye1vnoK4e+/5szvyisja5lSaV8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743176; c=relaxed/simple;
	bh=GGxfgq0uhUwoYS2j2u7GXWkBpqhveX9fPtwLvhqQaxg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M++o+4nAfOWYBz0NmVUMKPFYJEMG3+JML7DfK8wYfmw4vHG9H6vWm2rXP/RX+h7WGs9ZlqExvxN5Q/afR8f6j2oQTEMfm02wpSz90b5ioWgoksBZ5AEQVMFCX7NPFsiC5ulqBXFISufTBMFJgpo80CMPZkrX9xbyeVjK6c9BlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnOcUuic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5365CC4CEED
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 01:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741743176;
	bh=GGxfgq0uhUwoYS2j2u7GXWkBpqhveX9fPtwLvhqQaxg=;
	h=From:To:Subject:Date:From;
	b=tnOcUuicY1WlF+pJ4TetwGwXNn77fspC9u7zpdoZeXSU89SIK1ugg+KvK9kWv6sLD
	 L3QnpnyWJYjCIW3VkGK+PN6AAzbmgS08/D2KDQ1/b9Plowpbaw3P70Q7QeiP12fyk3
	 J8uf3dspS9SA9LxkGmdf/W1Gd4kifynvaPYQGMLkFiuEELdKhYwQcoeobI7bZZP+dF
	 FQg/nF7vGJbdF5jzjgVVD3bR5p1dGiGHNLCP3ij5OqA8kJjR74eerWk8S6MqiyLLpq
	 +X8tgRf7Nlzhy5alzetbzSCl3nQOS+qkbje40XPvOFK+Rps46DwXgDAC6sIaX3bjeg
	 gnopq3K9pUtKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 43B8BC41614; Wed, 12 Mar 2025 01:32:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] New: AMD Zen 2 broken power management after sleep
Date: Wed, 12 Mar 2025 01:32:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: diogotavc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219858-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

            Bug ID: 219858
           Summary: AMD Zen 2 broken power management after sleep
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: diogotavc@protonmail.com
        Regression: No

I have a ThinkPad E14 Gen 3 (Ryzen 7 5700U, Zen 2) running Fedora 41 with t=
he
6.13.5-200.fc41.x86_64 kernel. After sleep (s2idle), the device will no lon=
ger
respect hints or sysfs nodes (not sure these are the right terms). At first=
 I
thought this could be related to a recent BIOS/firmware upgrade, but it was=
n't
a new occurance (tho, I hadn't taken any time to understand and diagnose the
issue).

As an example, sometimes I'll set the profile to Power Saver (regardless if
it's tuned-ppd or power-profiles-daemon), or manually set the value of
`/sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference` to `po=
wer`
and `/sys/devices/system/cpu/cpu*/cpufreq/boost` to `0`, and it'll boost
seemingly arbitrarily even if CPU load is low. To keep track of a few stats,
quickly wrote the following script:

```bash
#!/bin/bash

# Battery
batteryPath=3D"/sys/class/power_supply/BAT0"
batteryStatus=3D$(cat "$batteryPath/status")
# Fan
currentLevel=3D$(cat /proc/acpi/ibm/fan | grep "level:" | awk '{print $2}')
fanSpeed=3D$(sensors | grep 'fan1:' | tail -c 10 | tr -d ' ' | sed 's/RPM//=
')
# CPU
cpuTemp=3D$(sensors | grep 'CPU:' | tail -c 10 | tr -d ' ' | sed 's/=C2=B0C=
//')
cpuFreq=3D$(awk -F ': ' '/cpu MHz/ {print int($2)}' /proc/cpuinfo | sort -n=
r |
head -n 1)
# Power consumption
consumption=3D$(expr $(cat "$batteryPath/power_now") / 100000)
units=3D$(expr $consumption / 10)
decimal=3D$(expr $consumption % 10)
consumption=3D$units.$decimal

echo "Battery:        $consumption W ($batteryStatus)"
echo "Fan Speed:      $fanSpeed RPM ($currentLevel)"
echo "Temperature:    $cpuTemp=C2=B0C ($cpuFreq MHz)"
```

With this script, I can verify that the max frequency (between all threads)
before suspending is typically around 1.4GHz for the task at hand and, after
suspending, is glued to 4.3GHz almost permanently for the same task (near
idle). I've also taken the time, in multiple different scenarios, to see how
many threads were hitting those clock speeds, and it always seemed to be 2 =
to
4, with every other thread between 2 and 3GHz (although usually the latter,
keeping in mind the base clock is 1.8GHz). This, as you'd imagine, causes a=
 ton
of unnecessary heat and energy consumption (might not manifest itself as mu=
ch
for lighter tasks, but can be problematic if the load is higher).

One side note is that sometimes I'd wake the laptop up and have only the fi=
rst
core with boost set to `0` and the rest with boost set to `1`
(`/sys/devices/system/cpu/cpu*/cpufreq/boost`). Not sure it's relevant, but=
 it
was something I noticed.

It happens on all scaling drivers (`amd_pstate=3Dactive`, `amd_pstate=3Dpas=
sive`,
`amd_pstate=3Dguided`, and `amd_pstate=3Ddisable`) and seems to happen excl=
usively
on kernels 6.13 and up (6.11 doesn't display this behaviour at all, and my
testing with 6.12 isn't yet very conclusive), so it's reproducible. It's not
exclusive to Fedora, but may be specific to my laptop model and/or my CPU.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

