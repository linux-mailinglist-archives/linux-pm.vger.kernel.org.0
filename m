Return-Path: <linux-pm+bounces-8044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F348B8CC394
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D799B20E77
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34BF1C683;
	Wed, 22 May 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2KQaD9i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C418645
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389605; cv=none; b=UY2Eh/XZZTqAX7tsNpWdfKrHjCFYsGA4L0udnOM+drKx6v0TCTFi/i7gC2CYBCME16ogfjjvi3RDvMt2RP9LgoGqwIL5xIoNJ2JrxUCMb0nsiLTPFWD80zvCV1JfDXPnH/IyX/Y4GZNiiwXd4z67CftD8uBW/r3kbaGrNFZVTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389605; c=relaxed/simple;
	bh=B2g7VjM/pDPqyPbdWUk6I18xsPBV8XhidZ4Uhc66X4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WsrE0XKvhHro7nz0442qAjtCSnY5DB7fJvYyHl+43ddLC6j+99meWR8lk/mk9kyMb+uEwkRuzlqW3MsLs4Gfmqz5C15lSXYR+z0QI/brSmT++YNMAXJmbcrpdGFc/8M5RiVKw4IPupwLyNb/o1tlELtJ2RjQN6Oz6kQe/ylrcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2KQaD9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BE0BC32782
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716389605;
	bh=B2g7VjM/pDPqyPbdWUk6I18xsPBV8XhidZ4Uhc66X4s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p2KQaD9ioYT19qIWqjB08f/vkvPcTd52FVpuEa/oyb7OYmSe/JEGUrWsPPRxM2DGp
	 NLW4+7kDGA9dvm7BRqqjkK275qBFn6wEN8cljNA9ae1eaClgiviXnvIyNavyFn2XDB
	 msjlRw4YDf3TbIcz/pLbdSvXcJSflXhWK0oy7aghVncIoEFu/+deDdnI164bMXXDHo
	 2p61dzO18wTAqHlUwReAMQXgJYIyGBOfXWw4VHb050BTJoH29MhzTWhiP3Qi0C5AVY
	 lxBPZdh9qzGAc2Y2VrlkPPz9tA7FjJ0yTRSGGUYMi1VT/Ik+vJ1MUch2hQRSZSw/kw
	 UiZswgTsLUWCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 435F6C53B73; Wed, 22 May 2024 14:53:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 22 May 2024 14:53:24 +0000
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
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-KQWLCjghzL@https.bugzilla.kernel.org/>
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

--- Comment #50 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Mike from comment #49)
> Hi All,
>=20
> I have the same ga403uv system.
>=20
> watch -d cat /sys/devices/system/cpu/cpu*/acpi_cppc/feedback_ctrs
>=20
> Returns changing values, does't this mean cppc is active?
>=20
> Mike.

Hi Mike,

Could you share the output of below commands on your system?

sudo rdmsr 0xc00102b3 -a
sudo rdmsr 0xc00102b0 -a
sudo rdmsr 0xc00102b1 -a
sudo cpuid -l 0x80000008 -r

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

