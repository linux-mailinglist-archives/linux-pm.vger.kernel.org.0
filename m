Return-Path: <linux-pm+bounces-2704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE983B97E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 07:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA070283A25
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B7101CE;
	Thu, 25 Jan 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PScqFAnV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D46FD1
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163463; cv=none; b=Hh1UIPuMOdRZKcnqwaJxXIcYEs4f+VMmDsXF+4bFKpgl6OwL9GmHFqJiD/oK4B4KMby/0EoaRI6SKInDBezEHFZYcx1SAF1huVW2mlSSahZtluGI5CJchR3twJaz13Rd2I9gL4Cns7vevi0ql/fza+TEcaZ14r+cZffNAfKqEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163463; c=relaxed/simple;
	bh=TMTmOLRtFZlMZPx1/g3mNRs377PZeSOMSx1gsecNnJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZha6ngI/q+XGYe4klb8OT89/eRwsNxSFvQlLKL2qqXJZ+X4MPDyH4JtMDK3+J6uoIZ+G8xDHBOZWLpiXXcJfpc7ZyI3ET4qhQpwZrOXu98CNu9QvleQ//+/d71h8LE3lBH0yp63zrwW0fx9vzuVxjAMCsij6Q1Oh5OP3ZUqboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PScqFAnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DE76C433B1
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 06:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706163462;
	bh=TMTmOLRtFZlMZPx1/g3mNRs377PZeSOMSx1gsecNnJQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PScqFAnVXQEY20TtNZa04g9kr/mlQO5uCqo0uDV7Im/F33FXMoDJN+hO/GXbhuBk9
	 rLapj7MUyLIA8HRF/CW/ERt4TQXLAFpD30Y0J11DDZRblCapxGE+//zKHgveGKw+MU
	 d1mt5qgzm+0sQunoHWHs2SfFx5uwueAVg7NiXXnXXSkMTB/cyKmkKUClRF/2C3PEJu
	 ysbjAXRNBemjmbUktI6WAosk9WoWpsS6nqAJnXqmbiTaI6Ubs8YpZsB2nsJeM5UCQm
	 Fk/3FKbl9m6cFIv/NbTzlt9N7oUuo3okX2CVomsN7FhfAAy7uLzk72JIxDbJalJ8Cd
	 gq66+XzBx9khQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F830C53BCD; Thu, 25 Jan 2024 06:17:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 25 Jan 2024 06:17:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218171-137361-d0H7D52PUl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #35 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Created attachment 305776
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305776&action=3Dedit
patch to enable amd psate driver for Family 17H

Hi all,
Please try this patch on your system, I would like to see if the system BIOS
still looking for some other fixes.=20

I am not sure if the pstate driver can be loaded successfully on your system
with this patch, if CPPC capabilities missing on your system, we still add =
some
other fixes on for the broken BIOS.=20

after you build and boot your system,
please help to provide below info to me to check the driver status.

# sudo dmidecode -t system
# sudo cpupower frequency-info

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf




Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

