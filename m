Return-Path: <linux-pm+bounces-7735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FB8C2F13
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 04:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BD51F23867
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9F17BA3;
	Sat, 11 May 2024 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWAVylPE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7376125C0
	for <linux-pm@vger.kernel.org>; Sat, 11 May 2024 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394902; cv=none; b=KT0Bxh+uOZiqfHLBMch9rF61vYUJV6VoHQiXua/FlCL1aCkDzENGH8bKr05O2N/DXjw23CNjDr35aRI97FZmAKHk0QPrmCKEEpfs+62M49Jti+4RPJAXSxoh0SSDvFosTE3B9XiCKkJAI6sdIhA9hknTjRfzRtQpRk7GgX7O0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394902; c=relaxed/simple;
	bh=K0RaXVZn95IrCQoredgNsGwkPF/HHtBv7tlZRWejsEA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pUILVbUEUcdMmGaPK1pL06g6S09NGQWUe0ZwJbVpFeYazEcVM7eupR7/78vmxPC+nua5px6t5/cLAFnBpN1eA4e8u7huzlE4Q8ebGwFyMQqH/Tc++ScWHB2EilDcWyjiuaMVow64vX3+bepXVUqQsELAjnaoWxgea6DDt8Eyl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWAVylPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63BA1C32781
	for <linux-pm@vger.kernel.org>; Sat, 11 May 2024 02:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394902;
	bh=K0RaXVZn95IrCQoredgNsGwkPF/HHtBv7tlZRWejsEA=;
	h=From:To:Subject:Date:From;
	b=IWAVylPEM/n71tXYEWkFuJXdd2BR9ZXl7A+qb9as5lSrSPcKhcTlsuHksvm+8M3WR
	 FCIutZ6bgqBb/b9ZG4+Q8/2JboN2FDv0eWal3jLSSC4gecjDa/WLytt9omqP5Ia4cH
	 E7BNXy7sZapQfJUFUbdhx0Jqdjqjjr1XFB78tqPFTI7RAq5VLVNGc53TfJ++d6z/lp
	 QKiRSZpLGI+/EopGbQBC4xhjonw56z4yQdo7sD5kd6qKW2nH2zbVPiMDjWJiCGJWNE
	 1hTx4G1eMvMhpGGjbj1pPAbJoazx3iIF1FQo0R/ZIcWPYfGqhxZCdcXv6hhqwmDlr0
	 8oTJyI8WJMwyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5387BC53B6E; Sat, 11 May 2024 02:35:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218827] New: A question about the cpu freq policy
Date: Sat, 11 May 2024 02:35:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: chizhiling@163.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218827-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218827

            Bug ID: 218827
           Summary: A question about the cpu freq policy
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: low
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: chizhiling@163.com
        Regression: No

When I write an unsupported freq to the scaling_max_freq/scaling_min_freq n=
ode.

If the cpu not support this freq, Shouldn't an error be returned?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

