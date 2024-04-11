Return-Path: <linux-pm+bounces-6255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A38A070B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 06:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621631F21926
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406FF13B794;
	Thu, 11 Apr 2024 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox4UrACg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8252A1DC
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809190; cv=none; b=fzRF4101US0ZHObkp3adJG3I90Mnc38QSb7EdBvOCRuNoLuPCmCv35Izd6sX1kwdENfIS7ZHLwSvwpcn60vaMEkhFcMCAN8ZCEnQNqLSDyZc3v1ttMsG416pD8cymEsIRoNqopsEQkua6QPU0dJ8QTZ57J7+f9ahvJYFV3vbmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809190; c=relaxed/simple;
	bh=DkVrLfso/tYp5+QkO+PjZr1y246c7jmol7o48VLb1TQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2px6m9kfuByyoWkHXN/PG9QGGb+tezohAVjlNbLGd+qkN/rOtjPqpuitSj3m+Q970txjS3QnDCpQy/a/I4WeKYoapxBiwoj6nHZf0tTobold6YdQaTCANG/VTRi1/CS8uCRgp/8fIEy2pDXrJO2nVpN5Upr1ULWUTTb3/9TWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox4UrACg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B54C433C7
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 04:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712809189;
	bh=DkVrLfso/tYp5+QkO+PjZr1y246c7jmol7o48VLb1TQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ox4UrACgumyuZLajeTl1k3pjzPD5O9cDOjbaghWE/fV5V1TNaDz4Qkfez1yIZSLST
	 Pmg4HD5iGRUJBLHMLphW/kkrDJ00lfzZgObxaAtbItTaSqSJ8Dvr2WFAPgWON063tA
	 9Lku7u82H/q4tt5a9hkb7BSxYEPJTHB9jWPD1qpa/JF9IdJYYccct8BQTNaIb/gpcq
	 EYK9cB4xpHSvv4zfh2NJ1OEHehhTToCf/6PthysRrz0J1ZaWKrCXUCz8j/FqOM7wSG
	 s9DS0AqCN7XBswIZ8wKAHtgitv62pO7kMiVKfMkLCvYHaK1k0twkTC37112ZmYI4g3
	 ks2oluAnhALcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 98A7BC53BD6; Thu, 11 Apr 2024 04:19:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 04:19:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-FtrzIkPciZ@https.bugzilla.kernel.org/>
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

--- Comment #26 from al0uette@outlook.com ---
Created attachment 306126
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306126&action=3Dedit
Screenshot of HWinfo64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

