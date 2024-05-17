Return-Path: <linux-pm+bounces-7926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D288C82BC
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2C3282B67
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789DDF5C;
	Fri, 17 May 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMQT2xYr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22380D535
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935834; cv=none; b=j20eHfPR2NGdzlxoRt/kD0XkKTbz7h3K3dASBLpgnuopOgRodbkCMT5EPyPY0Eso8lHNW+fMKO/qPAU8vh9R69BzxhzoziSecsOZ9qL7ax2gXfX5dAPMYMyx1aDV92lmGJmbE4W/woTMAxo1WDPlwlS576uFFX5j109WjmAiAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935834; c=relaxed/simple;
	bh=HIgyYOwWWv0Fvk6c0K9LDvCKB6BnHvv+Hd9dhbjxKKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQJrV084W1TP+u1vPcjpUiMjidu0av1Rva8jXiFYQh413VNMUD334Z1WSbaG/bg5UDYImOVKpT/sB6UZmLmY71DBKdT80vTTczlw2kl1jHQN67U7nrMeMPg0SDopHEpZiz+0iLAFY4h4QDYL9SV88ouXwbmAenWIgb29kWOmoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMQT2xYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3976C32789
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715935833;
	bh=HIgyYOwWWv0Fvk6c0K9LDvCKB6BnHvv+Hd9dhbjxKKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EMQT2xYr0DmRWG9HpkzNa2XJNcmbxm7kRKLqIjVQuHUdkgKvh0a8AGIPC+zXy1DUr
	 bG2DXxwIRIdyTfxoSJtoNauk30unmA+5RWrnqGv0aK46wYDvu1Ph+5Ye7W3maj0QGa
	 xqb+U04jAFPo2JPavdAn48QiWY7tVvP2vPgUuUGpLcbNR+zZybCDbP0gaMzXW1YIwl
	 x4/MSKnUERNQajJz4xHuDTietXtY6tGjqiyeNj/QIwrqP7GF+2MW+GGhmq5kzqTKUD
	 IL+nuQWaCb0SS+DoYvFCt0dl5p+PqJ6+/vLJrzjumuMCp95p0ndi6/V+EIOHRByx9K
	 xrMUimPv2motQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 95B53C433DE; Fri, 17 May 2024 08:50:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Fri, 17 May 2024 08:50:33 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-LfbwjPmXxR@https.bugzilla.kernel.org/>
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

--- Comment #45 from al0uette@outlook.com ---
Hi Perry, I consulted ASUS for this problem and they're unwilling to provide
help, and it has been 3 months since the last BIOS update. Today I notice t=
his
bug tracker: https://bugzilla.kernel.org/show_bug.cgi?id=3D218171, which se=
ems
have similar issue. Do you think it is possible to fix this problem with
similar method?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

