Return-Path: <linux-pm+bounces-11917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F144F947B9D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6952846E1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4691591F1;
	Mon,  5 Aug 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXKgY9yp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E9158DDF
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863487; cv=none; b=SXxLAR5hRu06FpBGxaddcsDjEYnAAW0CuH0fG9oMe4B2SRa4HMwLPWNur3ElzGlg86m7UE5YCUJg9OaPW1D4ulDgEwUBJIOm3tMwFzJLwFOPIAaavwzEec8U8nmAgRbfDVnezDPORTLTV60r4mbofHPKgtKe79lpUia3Xnp6F8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863487; c=relaxed/simple;
	bh=v+nuePAurtuF+Xck3Y5Suw+Gj+b0EqJ9TVHR9qHPjks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QTQG+tNMhOwqPchkdmL8YhBoRjlZTvNBnNdaFHTLxBoOELwBUyTb5oryuHoJ/tfuc3nlO7eUjbKKgLp57Jqp34bAOMoYC7IIz2voRyvQV4XiWA+XPxQn+1K2gdD4NGxm3ZahvdMzu+cPawUxuH4YnjQxxy3b/CjQizopIU46nYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXKgY9yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DF78C4AF12
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722863487;
	bh=v+nuePAurtuF+Xck3Y5Suw+Gj+b0EqJ9TVHR9qHPjks=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WXKgY9ypSAWPK3X3rd+ejC4AUC6Z2dpwtXDNFrglL9LZFgtAYZJaR2bVSLdsDFHQY
	 +yhWleQO1edoFzLsfazhmIASmzvA0O+UgJvfnw9VK/ELrTlwtcE3WhlycA7kF/Cca9
	 L59iElR/rxc71g1T3lDj5+mr3ocJz/lASDVOu+pS8WvnC/xYmJI3VWMH1iJhn3v9lc
	 fJYfqcDCtcCkJ1Toar760clwkctquayf+U37I+FmCWlUsufh9vXxcxIZfxJ0dT/1uC
	 F8FUfAXAEJNiS3OaHTB7/+xL/8XkpinEq5WjRHb+1cUgjOe4frkhTMNy7M6k3ruxW0
	 ykTqLGmjpVpXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 062CBC53BBF; Mon,  5 Aug 2024 13:11:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 05 Aug 2024 13:11:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-n4iDgV3TgC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

--- Comment #73 from Chema (chemasanchezgarabito@gmail.com) ---
Also I see that in the kernel logs when booting it says the following:


=E2=98=81  ~  sudo dmesg | grep CPPC
[    1.565705] ACPI CPPC: Parsed CPC struct for CPU: 0
[    1.565845] ACPI CPPC: Parsed CPC struct for CPU: 1
[    1.565928] ACPI CPPC: Parsed CPC struct for CPU: 2
[    1.566022] ACPI CPPC: Parsed CPC struct for CPU: 3
[    1.566136] ACPI CPPC: Parsed CPC struct for CPU: 4
[    1.566246] ACPI CPPC: Parsed CPC struct for CPU: 5
[    1.566365] ACPI CPPC: Parsed CPC struct for CPU: 6
[    1.566476] ACPI CPPC: Parsed CPC struct for CPU: 7
[    1.566566] ACPI CPPC: Parsed CPC struct for CPU: 8
[    1.566651] ACPI CPPC: Parsed CPC struct for CPU: 9
[    1.566736] ACPI CPPC: Parsed CPC struct for CPU: 10
[    1.566844] ACPI CPPC: Parsed CPC struct for CPU: 11
[    1.566952] ACPI CPPC: Parsed CPC struct for CPU: 12
[    1.567067] ACPI CPPC: Parsed CPC struct for CPU: 13
[    1.567191] ACPI CPPC: Parsed CPC struct for CPU: 14
[    1.567341] ACPI CPPC: Parsed CPC struct for CPU: 15
[    1.585000] amd_pstate: AMD CPPC shared memory based functionality is
supported
[    1.586011] ACPI CPPC: _CPC in PCC is not supported
[    1.586134] ACPI CPPC: _CPC in PCC is not supported
[    1.586204] ACPI CPPC: _CPC in PCC is not supported
[    1.586230] ACPI CPPC: _CPC in PCC is not supported
[    1.586275] ACPI CPPC: _CPC in PCC is not supported
[    1.586302] ACPI CPPC: _CPC in PCC is not supported
[    1.586347] ACPI CPPC: _CPC in PCC is not supported
[    1.586376] ACPI CPPC: _CPC in PCC is not supported
[    1.586412] ACPI CPPC: _CPC in PCC is not supported
[    1.586469] ACPI CPPC: _CPC in PCC is not supported
[    1.586494] ACPI CPPC: _CPC in PCC is not supported
[    1.586530] ACPI CPPC: _CPC in PCC is not supported
[    1.586579] ACPI CPPC: _CPC in PCC is not supported
[    1.586616] ACPI CPPC: _CPC in PCC is not supported
[    1.586644] ACPI CPPC: _CPC in PCC is not supported
[    1.586669] ACPI CPPC: _CPC in PCC is not supported


And that logs are thrown in:

    - L879 cppc_acpi.c
    - L1491 cppc_api.c

And first one means that=20
/**
 * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
 * @pr: Ptr to acpi_processor containing this CPU's logical ID.
 *
 *      Return: 0 for success or negative value for err.
 */
int acpi_cppc_processor_probe(struct acpi_processor *pr)
is working correctly

But then "int cppc_set_epp_perf" throwing because of "if
(CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg))" is not met

So can correclty read the CPC object of ACPI but not write with PCC in the =
CPC
obj?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

