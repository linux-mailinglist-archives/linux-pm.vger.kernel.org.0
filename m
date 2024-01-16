Return-Path: <linux-pm+bounces-2259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EE782FD25
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 23:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75861C28C14
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 22:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C712030D;
	Tue, 16 Jan 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4DNYJL5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51911249E3
	for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2024 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444029; cv=none; b=RoV/QsUfPVhBiuPCI2C/SiiKmw6XGFB7pXfeLBFeuiTficRIqGxro0dpgUnbZ/W8WAnUTyPVhc2VUEO8sM4FMhDbJb301ZFRfo/JP+pDo4KAToCqhWr6hs6mhrbOB1x1QxZXKdnD/Hc2xE+0ULoRbC2MSmrWRBE8+jHilC9d/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444029; c=relaxed/simple;
	bh=ZEBCgHQrTt42yDQi6jXzlS/xiAcm+6uljPXHzgWiHzU=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=eyKk1i3jTCs+1nNqwKCY+AvV4eRgqAak7+SpfvH6AY4fQ6RdMpvnF8yH7fKUFJEG6pxMfXLH13EwuZNdewvT0LqrmldvAHV2vFteMC3JWQWknD+L6gK+/kd8DT49uFhHoIO7H2fmCrQWpS2wDxiugO1kebDR5e/4XvglWnCdx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4DNYJL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A51CAC43399
	for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2024 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705444028;
	bh=ZEBCgHQrTt42yDQi6jXzlS/xiAcm+6uljPXHzgWiHzU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k4DNYJL5/FkAdp63YFptiPDmp0VoqvcDpOLsLO+UAwCDvE+rmwypSWv9Q+0xUtBWs
	 o1Hzj+I99YIWK6Ex/3AtuML3meZdVrfLEz8NdOJVNZKUKMHvOLpTWzaZuLSzMn9GYo
	 0xzWM1D2SRdMHn/ZvfbZHblfb0IhCS1K1O1blUhUc+0kfWBZBXOqxM/r0/VdEF4UMt
	 fg4EPIksm3NcxL0k9m7BRQBx0UJznEsLHFI+FXth14WiIbiRZZgZuEjcJjw3nCN9Ez
	 9PZ58x0AnuhRX7z8V/LKQFQRaE6GZ8NmXGKbi1jWef/qkWR4JfK2AjcGtxL7z0Nq+Y
	 xfowMPUBp75yQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 92409C53BD4; Tue, 16 Jan 2024 22:27:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 16 Jan 2024 22:27:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alessio.disandro@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-218171-137361-EeqUrsJbJl@https.bugzilla.kernel.org/>
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

Alessio Di Sandro (alessio.disandro@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alessio.disandro@gmail.com

--- Comment #24 from Alessio Di Sandro (alessio.disandro@gmail.com) ---
Created attachment 305722
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305722&action=3Dedit
ACPI tables for TR3970 MSI Creator TRX40

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

