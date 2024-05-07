Return-Path: <linux-pm+bounces-7601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAAA8BEAF5
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F91F21016
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F316C87D;
	Tue,  7 May 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRX3LfBQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BA16C84E
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104621; cv=none; b=QhbyFkoiuE/04kxdLVsqR912oTZm8lrx+lcwSG56i/2EIEtqm2r6fM74PIzj3lI2G+lJZ12VzGpfQF0PJ0NtBSCo/xIbrm5GdneAo2A+9CO+a819ueFclUyPZUBd8Y85EsQKBMjh7eW+61hZLdgpEnmLqEC5IvRhBRlCj08lJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104621; c=relaxed/simple;
	bh=jamEsGadSpWyGltfiF594BVpvU3Yic6BBKJYrrRkv3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X54XVasrBw/esIrl3wXJbhLfdImfh9R8AHObBD1eG02geBg+m3ZLGJ+3+HLRn+Y15Z4NHUTLwpy6gxseIgPzoUR1lIDbs+cR9434T+wS3pm/9/3iYhKRCTKQvVNvS3svIsi1kValVRxZ++tTHqE/iyOIVC+oH5bcCpgMqDT4QdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRX3LfBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A802C4AF63
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715104620;
	bh=jamEsGadSpWyGltfiF594BVpvU3Yic6BBKJYrrRkv3Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YRX3LfBQeYhB2WJSdVsDiqt8CP5UDZ+b6oMVCRB+0ViWQGHPp38P8i+BMKa2UYjCJ
	 LhFivXfoEyr0m2a/UJdRnnzXp21qvJAkzBEVJx3B8T11+5+yi4/2WPLmSAaY/OXMZz
	 NOnzrztTkalX/IXIdZWtu6SZLXFMeiL8ecg4Wa/QMCN+knDJBztLyV0U6EzqU5tD2J
	 9fVO2e9ctu8gZVfJpSbYrnt+SwwPOTBmOApS/28iZdg6ajHS1L3n0hjAGgSpnv7HaO
	 wr1ydQ91e7iIrIJuIscotGpDFWtNMrNs5MFrAbyQgd2v43ZL+jbEFZoRMukPMkdHd/
	 g5An6sMCzoQzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C3D6C53B6D; Tue,  7 May 2024 17:57:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 17:57:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-qRhE5Vvfgq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #32 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
I've pulled out just the relevant fix to it's own patch here:

https://lore.kernel.org/linux-pm/20240507174810.46709-1-mario.limonciello@a=
md.com/T/#u

I applied that to 6.9-rc7 and tested it.  Can you see if that helps you?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

