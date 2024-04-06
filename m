Return-Path: <linux-pm+bounces-5997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA889A883
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 04:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649851C21041
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 02:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAC1B7FD;
	Sat,  6 Apr 2024 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg6+EqA4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58C1AACC
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712372218; cv=none; b=ClV9CKlLuKbP76ZkOStf48DS10CRFjJqxWbZ1YSg5sR0iOLH/9mKlJf+ifA2R3mxujuN4EIrUSV7aotpd06sQHPOi9GSdWDqOcOMyn8yKqoIru/oft6Fl6se0wPxz2TCwENta6QKnZbXNgNsIc4WNNkhVFC3tIos+B5tqLW2FzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712372218; c=relaxed/simple;
	bh=7tk6/AYXv74Wb/Cto0vcfmZlToI3hvwV+kKzCQc3qHo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=swU46tfLslQQJKPJ3lZhZHR0EBxVhKNhja2PieVdQOT0dxqf0E1IV+8UTDdTPCcJf4nD9f2HcRtJMECzuQuZ8FApV8rIrM0AWKcntQ0G9vx16y4QtAiW9StUuGwtv0yBqhZ70NsNFdK6ETv1+RZcpRZsfXtTadGhwYIOtExMNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg6+EqA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EBC1C433C7
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 02:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712372217;
	bh=7tk6/AYXv74Wb/Cto0vcfmZlToI3hvwV+kKzCQc3qHo=;
	h=From:To:Subject:Date:From;
	b=sg6+EqA4COGIv+KwlIm/rDPEuhMfO+G5xxYCpO/nNmKNKHBr3OWtHtLZZx6RiZhS3
	 3J16UVYPm+TFzUFGcK4out+ompi5ofyRczYH28ptOeaiezxH7r2Tsbpvi9FyWW2E54
	 n9oqQ9FkZi23n8VIwGEoZiZ5bAb3K3M/2weBZZ2H4ehzbEvdfhLYzDcEVSWXYLAUVY
	 g48+9RdhHfhFO3AcZuiNz9wIJvzzXdJGQ97zAe46Mmn1RySoQ7P+OiwMdwyG0qh5Ak
	 p9FByBrBPMwE2qwSsjzjY4dke/IZtNM4o8OYPAQ0p9JFu7hZxNcPoYpLAawIkscLOn
	 //N5MWr3ANRzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78C89C53BD3; Sat,  6 Apr 2024 02:56:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] New: Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sat, 06 Apr 2024 02:56:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

            Bug ID: 218686
           Summary: Fail to set energy_performance_preference of amd
                    processor on asus ga403uv
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: al0uette@outlook.com
        Regression: No

Created attachment 306091
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306091&action=3Dedit
ssdt table containing _CPC things

I enabled amd-pstate-epp driver by appending 'amd_pstate=3Dactive' to kernel
cmdline, and set scaling_governer to powersave, and

'cat
/sys/devices/system/cpu/cpu*/cpufreq/energy_performance_available_preferenc=
es'

do show

'default performance balance_performance balance_power power'.

However when I try to change epp to anything other than 'performance'(which=
 is
the default) with something like

'echo power |sudo tee
/sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference',

I get 'tee:
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference: Unkn=
own
error 524', which, according to source code, I guess is ENOTSUPP. And I gue=
ss
it's because cppc_set_epp_perf() in     linux/drivers/acpi/cppc_acpi.c chec=
ks
CPC_IN_PCC(epp_set_reg), and think the register doesn't exist. However I do=
 see
the _CPC things in my ssdt. Don't know its' a bug in kernel or BIOS so I re=
port
it here

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

