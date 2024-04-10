Return-Path: <linux-pm+bounces-6145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D889EAD5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163B1B22C38
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373CF2837A;
	Wed, 10 Apr 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIdKeFO4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1E14A8C
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730461; cv=none; b=iG4oqL01zuWrpEHfUHcAZmK2wDF5h0Yp35ST1QhVrFJMsr3tgS6kX54RL8hGXFUqXO6hBllt4M/jC6G4BW0/OYZC1i3jhXFGBYbKDzBh0iqT82308daRcW1FAcr41YyKWApY08YiMUdJjzDyPvfKt7EBNzkztCsvD2u+vAzdoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730461; c=relaxed/simple;
	bh=T+gkV4XWLjMM6Z++28M9X+bJL0oW2PDnu5nPq31/zTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRcogoTuZYhn8sjck+BNaXvd5PhhcCI76C6rDYZsd/czCUoFFbTa38vNMQqyHlG11g+wWbXqNNAkUFbQ1FPfE5F7YYQPN0ARJRD5F1H4NW2BlkP2+tNXoJQRhogvSb/6+2uzQJSGEceqSRXwVUrNdH1MNzjHVZBdHPlywgc4gXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIdKeFO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B486C43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712730460;
	bh=T+gkV4XWLjMM6Z++28M9X+bJL0oW2PDnu5nPq31/zTY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rIdKeFO4tNAnbNl0J3N7sfKsSI6RxSZi0rpQksIXLqnKz9aKI5VpYOL9n0mfutuuM
	 EFJcl8+NFzH2d228SoC9cqK53w2TKAY0JJwDNUWqrdpcKf2jhWTmzwN5LMJoiGBclc
	 UVkEY6xvWKelFGdi5o/DtprO7UmXm46Y6UGaJf/ih8gBKplXkXShjJhL/SHl0uiL3E
	 IrJQ+ITEJdKVOYnTOiY5VdSV7LgNewVVJ0gczxruYRaGTqf4NcLXE3hF0C7uiUc/I7
	 EFbBxs60o6m7jbSQXSQI9kdulNwpRPYxVjf79KkWYAfiVu82QdJDj49KhnNcalIFh3
	 3Za6AVlgtTKqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9396CC53BD9; Wed, 10 Apr 2024 06:27:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:27:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-zxaoO0xGvT@https.bugzilla.kernel.org/>
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

--- Comment #11 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #10)
> =EF=BC=83=E3=80=80sudo apt install msr-tools
> =EF=BC=83=E3=80=80sudo rdmsr 0xc00102b3 -a
> please try this to capture the msr values.

I did capture msr value, but it shows segmentation fault, which has been
presented in my output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

