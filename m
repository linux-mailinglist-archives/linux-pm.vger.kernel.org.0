Return-Path: <linux-pm+bounces-12-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F07F295C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563541F24BC4
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B162FE08;
	Tue, 21 Nov 2023 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACtfpuGz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933E3C081
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF801C433C8
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700560291;
	bh=VC2w265Z2fLpDjq17+3WI3YB7OyJ75sHmWl1PheI5IY=;
	h=From:To:Subject:Date:From;
	b=ACtfpuGzK4w89rErjdrFlDFD9j8Cbll+soj7wFMc1/Trg4QkF4XFstCECDt0Z1I7m
	 8S/KUUVMQjlxGus32z5OenuFjezeDDZv90jpt/826X7DxEFQCofhLuh9y6cO5FonVC
	 gDUHBybyrH7/jMFF06iunPStDBqh9Xt6KP55FJXsnXg4eo4J6Zf4Qtyk/EdHTy6577
	 M+yyy+aZ9+381W3+9opSDoybXv3G10qhD/06TGTtunepd9UPB5Pv6KfhrLX8wToug0
	 SRwvTBxUPgaXXloHQs6Hw6AO5ue5WCZyFp4nqQEKRanBNhl9qbJI2u3mo/mh1J3Dmt
	 WWfAMWG/R8Zxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A98B2C53BC6; Tue, 21 Nov 2023 09:51:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] New: amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 21 Nov 2023 09:51:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218171-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 218171
           Summary: amd-pstate not loading on zen2 threadripper 3960x
                    (trx40
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: badouri.g@gmail.com
        Regression: No

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

