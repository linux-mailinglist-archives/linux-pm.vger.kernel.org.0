Return-Path: <linux-pm+bounces-24394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12549A6BF86
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD53BA8DD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F422D78B;
	Fri, 21 Mar 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0H3QZK2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8E22D787
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573748; cv=none; b=HoMJ0lviSVx7Vs/DvYTIovOvgtmzE1SexqcPrUzpzp1PEqAIDDta/Vs3cujT8CywtiCXYJXUxuNYPbTtum24Nz7J4CbhLbntZbWJooJB8q7FK+F7aRArHu8SOuG3rbqFE4N6KMyEra6qdNfTsqf0KzpY5F/DsM/9gY17s93qtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573748; c=relaxed/simple;
	bh=cirN5qO8EWUGb/nQHgt9bheciylPMX30J4M15lZK86s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flqUBNDB2uZCcIqEXH0BJSsnDjvm8xZB8uk/2KXS8izG33TaJJR2O6m6Yv5AFwEsRr97w+npviNI14zob5s4ZhspAr7mCnYG3DKDS9WMyVrHlwL5kIKIfZr/uE76hZ4R2Yw018ipOryCakJUE+qKX98jy5KuHiP0h8UlX2282xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0H3QZK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 187B6C4CEE8
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573748;
	bh=cirN5qO8EWUGb/nQHgt9bheciylPMX30J4M15lZK86s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a0H3QZK2Mp8wD7zsI2N1UmZx/cfIf3PgnowfmQTAg7Ugs+zuIVd4QlU3a2kxT7EaP
	 l3Q0Zt4MrfMdQovyGvDaoZlvW+oKJvzh4BjV09Z+W9+iMDx6DGUacD9+WhPvHmvVAq
	 i5EYxLbAat121Eqftds7J17Flz9Lpa2DLHrs0e6w8etKrk1iD53rtG1X/ntqt3d4Ey
	 Jqa+l/Hwh8ScU7WSHTVNnd07o+1NoqQ3PNJjEBdzcTAAdIVEYhBKC+nl4nniZ/S0Ui
	 U5p87LWefswO6/JWOhSxxm6CVrqXSnfHrYo8Bhsxg7Tjv1HslvAlqbJ5bJp82xhjGh
	 vG3zhL+CFFWxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0FD6BC41612; Fri, 21 Mar 2025 16:15:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 16:15:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: diogotavc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219858-137361-urzNR7ICMM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #7 from Diogo Carvalho (diogotavc@protonmail.com) ---
not sure that was the best way to send the report, sorry!

Regarding the kernel, I'll try to compile and test it later today. If not,
probably only on Monday

The issue doesn't seem to be regarding any specific scaling driver, tho, as=
 I
said. It's something else, as it affects every scaling driver (including the
generic acpi driver)

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

