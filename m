Return-Path: <linux-pm+bounces-8487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B68D679D
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A061C24CBA
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098316F83D;
	Fri, 31 May 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhBlNw8X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE66770F3
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175142; cv=none; b=mzwkm0bFXrXLjsa2NYtG6N4kgD7OfLiu5XJt8yGLlR26/HyC7paQ7ccTw5fXEM38BHrqOnqimVlzc0l7K5L09GRhoxflNMVtrp7buPZsPj6euIif3Esi9y6znsY1aTieZpE2V3REUK+tRJiYoSo6NwcE5jGRLnprN5XDRKj3JvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175142; c=relaxed/simple;
	bh=NcS0b9gtFKNlsKo1hS4Yf9umQioTDdCIr98YgKhS8YQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sht72rijoXKg1kcJbZ1s4LlHJ0t9Kzkhdtg9R7IGIwJ8JjreaIr4EJdciq30E/yf9y+QRonO/Ail4Olb/EAXQDY5X5IezwXWfnvhAlRh1miiYK2G7rUYcBmlQjiBNIFdc01ggtb/558xJFy1JXDdV3Ge60F5pQkaj6Ag7svgz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhBlNw8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07C7BC32786
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175141;
	bh=NcS0b9gtFKNlsKo1hS4Yf9umQioTDdCIr98YgKhS8YQ=;
	h=From:To:Subject:Date:From;
	b=hhBlNw8X5wMG+8IY6tSO+fs57ANSy/ZpPtdqA4amQnAZ87u/2Q/U1QoykXXIW/YqO
	 TysaMo1Gqv4yJvJDl8Y8cU0wO+J/34HEOYxXQwx01GhwEeIZ8vrAyLp041BB0YRtUW
	 crhBPZPlgudobzN1pXWq/4/s0+bw4Jc7IwbiLYTwj3SIFycJS1dGihWBr9omtWwndx
	 DRXPxc9J68l66xT5ussB0SQ9ePcS6WqHSfYzM6FUFdNOnLGMmWNWqJWE79nv56ySAZ
	 Gmsx7KfYm3pDBUnJyQTH4e581Yga7LmB4q+hBPNXLZPaFQSk58tK0RIKxd8ymQVNpT
	 eGRKApFufPhmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EA594C53B7E; Fri, 31 May 2024 17:05:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218919] New: My machine enter automaticaly in ondemand but my
 kernel config have default CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE enable by
 default
Date: Fri, 31 May 2024 17:05:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218919-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218919

            Bug ID: 218919
           Summary: My machine enter automaticaly in ondemand but my
                    kernel config have default
                    CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE enable by
                    default
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hi Kernel Team,

I notice this today:

```
analyzing CPU 6:
  driver: intel_cpufreq
  CPUs which run at the same hardware frequency: 6
  CPUs which need to have their frequency coordinated by software: 6
  maximum transition latency: 20.0 us.
  hardware limits: 800 MHz - 5.00 GHz
  available cpufreq governors: conservative, ondemand, userspace, powersave,
performance, schedutil
  current policy: frequency should be within 800 MHz and 5.00 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 800 MHz.

```

Ondemand is enabled on boot, but in my kernel config i have
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE at default option.

CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy

I think is not correctly this.

Reproduce:
1. intel_pstate=3Dpassive
2. intel_pstate=3Ddisable
2. intel_pstate=3Dno_hwp
4. acpi_cpufreq

I not have installed userspace controller for scheduler.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

