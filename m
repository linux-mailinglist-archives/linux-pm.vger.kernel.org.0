Return-Path: <linux-pm+bounces-14900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7067698959D
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 15:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F15CB23134
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131F178384;
	Sun, 29 Sep 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9sTfMLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E21E868
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727615641; cv=none; b=Nw8Blqvdwa4KiKuTP7QzuVYUSKKyTMXhUy/mJZxXeixMzocx2a3HDKcxTAMzS3uctn7+aCJLrEJQcJsSf2i5xy6gp+n4TNUPBjbGqhfWN+FSfXvbfOKudV7IlIYD/z53W0ygVBuCTi/52MKU+KVZpfUz4yvYCxU2C3S5qPIvAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727615641; c=relaxed/simple;
	bh=Lawi5HHq4gM+ArgEg57pjdrhPZni3nZga+/7q1Cfwg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKEL2JLqqKJxdVqSqLHgXW+ty27KY69D+oiRQzrGuNj2UjXp5egfV380OleDsUwMd/xPpkxSspPHZu+n51uDq8hINhAhyM6jOpjvl/0bOtXEMCiZRH8Na0aIIUIeTs3ZiU7VHm6X+nzwgqASQ6GMZPLISj6Mre9M5XXQg682fzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9sTfMLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1C5DC4CECD
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727615641;
	bh=Lawi5HHq4gM+ArgEg57pjdrhPZni3nZga+/7q1Cfwg4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j9sTfMLBDWoufizjh1aqkjghYzk0ZXxEBQxtPpFKIPMQsfwx/G6xvwruoOHGR4LCX
	 UOcDxdebDAC7qaXi7Tc4TOeTEPoBh8KMpYlNZtQEf3Gfs82rz91p1Go4aklTd9Nw3g
	 PW8HTLlk52pievPdD9FOxkVmtmp6QFnLKdCJdgg02dSzKcBYJJrcSG7JFKQ2GoUo5p
	 FF593vmaGj4qZTzEbfx8BpOLTwCtZltVT/apBSJvL3u2E7JD5XGw1YMsZGkCrDeKM9
	 CHV8A9eDaZPQ25N2MeALyICUNYT0AZ8D5PTZxY9gsqqZMdmOUhSLH3ZpOkFs49D7KG
	 YXLCYq5k4YhRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E37BBC53BC8; Sun, 29 Sep 2024 13:14:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Sun, 29 Sep 2024 13:14:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219332-137361-uyaAMvdSFK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Created attachment 306936
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306936&action=3Dedit
perfbias.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

