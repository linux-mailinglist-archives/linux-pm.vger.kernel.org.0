Return-Path: <linux-pm+bounces-14914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C5989A4F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 07:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2B71F214CE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 05:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB92D7B8;
	Mon, 30 Sep 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCAbMkOm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE611459EA
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727675628; cv=none; b=CtO7pJxD+5TEgUDfcVqjM/JMY5JQ1U9b3hy3I4G8gYPlswbKZwxknqKSjGnDQ3CRnSREEIrDaCsMc63qsxU0RriF7JYEsYCVg7NgaJznV4k9esk1NgMB7LVm0BAJAdc09ZeJJWAsYxwfmRQGg9IbZWe1GTWI1AYdV2q6MZEtH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727675628; c=relaxed/simple;
	bh=Mz1lu6YkuGdtKbv7zBhpzHNqovn/ihC0c++1WHHB3YY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gscJ8wRv8Pta6lY2VyARCUYQsO6s0Db+nsAjk/mM/hBgv79fSOtQe5Duzp127qJkU6J/mqzNPAuq7NoWworM21SK6SqKi3VfJ5EpkR+u9pKXakOj8hEYQKpEownEBYYzE1ussMYvEwY/qY619uFGppSCX74tjiv5CIlOlqFzyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCAbMkOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA40C4CECF
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 05:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727675628;
	bh=Mz1lu6YkuGdtKbv7zBhpzHNqovn/ihC0c++1WHHB3YY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oCAbMkOmNzoKfT6Su1hQTnwc+C5Emz9usEyI3F4TRXmquDbyAPDoO7232f4WLYCA+
	 Ack+gIMlff3+5xT2gcJieVMD3Un6VR/JtFG/2KCrKpHgWli2kScDg3JvOvoQTHO/0a
	 REO9rP4ksmg7v45AHmJOnRhJMcpO98Qm3uavolfcCmCrU4aynCj5c167tyyus1ZZjs
	 7B5wdrnVnptfbfvKMjSsz/StrQFXPCpJmb3V/v8+d0YaZR+oqRWFndYAerSJ3cvJlX
	 GtLHK7LFmP6JLNOWVr8HFHWIZqEkFgLCtpz+7SV/TvXdP51uuM8Ov/owukT3795MYx
	 bpp+6WVao+VmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 611FEC53BC2; Mon, 30 Sep 2024 05:53:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Mon, 30 Sep 2024 05:53:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Dhananjay.Ugwekar@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219332-137361-AB5OrfxH3N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

Dhananjay Ugwekar (AMD) (Dhananjay.Ugwekar@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Dhananjay.Ugwekar@amd.com

--- Comment #6 from Dhananjay Ugwekar (AMD) (Dhananjay.Ugwekar@amd.com) ---
(In reply to Artem S. Tashkinov from comment #0)
> Created attachment 306935 [details]
> A dump of /sys/devices/system/cpu
>=20
> I've played with various tee: /sys/devices/system/cpu/cpufreq/policy0/*
> options and now on Linux 6.11 and Ryzen 7 5800X I'm getting this:
>=20
> perfbias.sh power
> Now: performance
> Switching to: power
> tee: /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy10/energy_performance_preferen=
ce:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy11/energy_performance_preferen=
ce:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy12/energy_performance_preferen=
ce:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy13/energy_performance_preferen=
ce:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy14/energy_performance_preferen=
ce:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy15/energy_performance_preferen=
ce:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy1/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy2/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy4/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy5/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy6/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy7/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy8/energy_performance_preferenc=
e:
> Device or resource busy
> tee: /sys/devices/system/cpu/cpufreq/policy9/energy_performance_preferenc=
e:
> Device or resource busy
> Result: performance
>=20
> This doesn't seem right.

I see from the attachment that you are using performance governor, so you a=
re
limited to only performance EPP hint, trying to write other EPP hints
(power/balance_power/balance_performance) will show the above error.=20

You'll need to change to powersave governor to use these hints. Please let =
me
know if this fixes your issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

