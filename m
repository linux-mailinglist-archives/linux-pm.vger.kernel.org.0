Return-Path: <linux-pm+bounces-16522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107109B1FBC
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 19:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E04C2814C6
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D5126BFF;
	Sun, 27 Oct 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e69KR6wY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482792FE33
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730054591; cv=none; b=D70OwQYmj0M5rb5Ek6GVnTPWGlA6ajTgGAp5tBMBL/6RqVHLUzoKOexbtqGI0OeLpXdKwd2vtGZH3SknuS6zgjp4kL6rtHrvPfiBirD/X8OP6RTCrF6b3ez59/1BZxWWBVfWBLSkvGirhqClDn/izVUkv3E9MZR+/JGWZX4EhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730054591; c=relaxed/simple;
	bh=Y7eDTT5rYkqqluZNycx/YuJkShfskHYMMOYrl65VQVQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VNkq9VIq2u9fOhJUwaZ5FvHlI7XSUFeJvSdfUa/SV1b02J0e4d7ciYSMyS/0tg0Cxs7ykDqOUBSHsiDJ6DH5MIbBMtRdh0juB2WviFIhNxRgI01DmbYw+TNInfzMv/hh3cGZgZ3NxwTnWo5K4eE1FU9cdwatiAc7IF7jswB7YDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e69KR6wY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE716C4CEC3
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730054590;
	bh=Y7eDTT5rYkqqluZNycx/YuJkShfskHYMMOYrl65VQVQ=;
	h=From:To:Subject:Date:From;
	b=e69KR6wYHWG0Ec9D+8sG7g9No3g6IKH4FuH+kfmKlpkuekq8a3wKB0nG4JK+arViD
	 wU24hN7OJcfphIsqBIys08HTeWK/04w9BAF9k18rRaMQv8wlh+a9jjUi6e3vkTzejN
	 x3nJ4BgpvOWNlmPpJS9tcdCzWDFMfdMA58ikdlaBl6mfalTKMSSvY6Nbeb8lWa2Yc+
	 k9J+3ImRNJK/5MbYkj81QYlI9tslbGk3OH2V7fWf7OfFIzc+vf6n5q27t8yG/udNxv
	 o5kiUS8gyYHSwX6n12NNhFpqFAnQA9SrzsZ6YeSQ7u7+C4DoK6CJ33T9Rudqmegu8O
	 dedTddRB+RrZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0DEAC53BC5; Sun, 27 Oct 2024 18:43:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] New: [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer):
 Could not retrieve highest performance (-19)
Date: Sun, 27 Oct 2024 18:43:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

            Bug ID: 219431
           Summary: [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
                    not retrieve highest performance (-19)
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: intelfx@intelfx.name
        Regression: No

Created attachment 307075
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307075&action=3Dedit
dmesg

With https://lore.kernel.org/lkml/20240905163007.1350840-1-superm1@kernel.o=
rg/
applied (or on 6.12-rc3+), booting on a Ryzen 9 5950X CPU (Zen 3, Vermeer)
yields the newly-promoted warning:

```
[    0.623843] Could not retrieve highest performance (-19)
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

