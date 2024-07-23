Return-Path: <linux-pm+bounces-11320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E001B939B57
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1511C21AF2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03913D882;
	Tue, 23 Jul 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdWhvGvI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1113B5A6
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718284; cv=none; b=QEzq8yAJFLI0N65twcEqxO69hcHhmvBcWCV/HvgqLHCUXQx9vkw9ORHsCtIG1mHIQQcnFMuLOmkHaInKgSb5lKfkHDOgLE2WxZd0VPIOAGm4IWcAAPj2o4d2OxNe9sNMdpM7tf1FC3rXIGEvK2fe/Xz/WDbMIe6HfrlLRbHMQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718284; c=relaxed/simple;
	bh=T/KN/byA9PVG91kv1EP5/edNXEl11gJAtJ8Sw3B+Ucc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hA80k8EJF1jebBjfmUriSo/f05uyHuU3Z/lX75vQ/Iulj9m+VaRX6SaP3fQZiw10lmXsQ07t8yNwRqrYWlegB1mvXAv7Xpn3tDD5niiMDcSthmC3MPgsEW8Uv12IdN4PaTmbBOznsswS6Iu1HAY6LSM/T8PajZO1A+sp8sc8/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdWhvGvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0232C4AF0C
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721718283;
	bh=T/KN/byA9PVG91kv1EP5/edNXEl11gJAtJ8Sw3B+Ucc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EdWhvGvIGZ+POHl4UQ9WH7KruRW3hVRPhR2pDAX1KjdK59sJJ6RRAnBDwjKvKfPjz
	 0bHVaU3J6bhYopMtw3J4ntQrizR0v3Pu5R8lBoDCeDFWf9v2kesEm7g2ILvutJs3Ro
	 FvAnVPf6mvesVUh8KEHFvcSVGTWciqpKaz/U00gYa0kP4wUgOvW4q7Liq0Us4XHQ/t
	 NfgYqYRXglpz4v8KrEz9+3ASQltzBquiBHHdxaLlV016LIUvqsV3+rDgGPbUYJqZ1h
	 erllf/L7eoU9GZWCT6xlpF7lAuJku04FNqi5cf6wvedm/bMXesEhQdbVqRSalY3Cv4
	 PWySKe35lnKzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A89B0C53B7F; Tue, 23 Jul 2024 07:04:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Tue, 23 Jul 2024 07:04:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219051-137361-6ZKMPSR2Q6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

Perry Yuan(AMD) (Perry.Yuan@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Mario is OOO lately,=20



[  864.970948] asus_wmi: fan_curve_get_factory_default (0x00110024) failed:=
 -61
[  864.972365] asus_wmi: fan_curve_get_factory_default (0x00110025) failed:=
 -61
[  864.973533] asus_wmi: fan_curve_get_factory_default (0x00110032) failed:=
 -19


The errors show the BIOS broken to get factory default fan curve data.
I would like sugguest to submit support case to ASUS for further help.

The system reset is triggered when system reach critical temperature.

"I noticed that the processor runs at lower frequencies than 20.04, so do t=
he
fans, most of the time at 0 rpm. Temps 50-70 degrees."

Like you said, the frequencies are lower than 20.04 which have no amd-pstate
driver loaded, so the system temperature increasing slower than 24.04 kernel
which has amd-pstate-epp driver loaded.

I would guess the root cause is system fan error instead of amd-pstate driv=
er.
After you resolve the Fan issue, system will not reset any more.

static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
{
        struct fan_curve_data *curves;
        u8 buf[FAN_CURVE_BUF_LEN];
        int err, fan_idx;
        u8 mode =3D 0;

        if (asus->throttle_thermal_policy_available)
                mode =3D asus->throttle_thermal_policy_mode;
        /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
        if (mode =3D=3D 2)
                mode =3D 1;
        else if (mode =3D=3D 1)
                mode =3D 2;
        // asus_wmi_evaluate_method_buf failed here, it is a broken bios is=
sue.
        err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, =
buf,
                                           FAN_CURVE_BUF_LEN);
        if (err) {
                pr_warn("%s (0x%08x) failed: %d\n", __func__, fan_dev, err);
                return err;
        }
.....
}

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

