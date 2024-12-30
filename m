Return-Path: <linux-pm+bounces-19847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942139FE5BB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 12:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768261881B74
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FA1A706A;
	Mon, 30 Dec 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F24ENGJE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D21A0BF1
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735559624; cv=none; b=MXirVgGykSFerAoE+VlFy30ddQ1V5kQvWfLYv+9tUV1Mtkqnl4ELcl/VGgmVRM9ct6fO++XnzQAhpoOhYoK/x4A64aArLAYkRoXKXbUU1zvm80YcHgIcGy+AcM2dzQl2w9b9ApDfkK/Jgs28O87bCuU5zIjLHjeJLlaVZzQTGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735559624; c=relaxed/simple;
	bh=rw1u2lnJAZZ2GUZjLa15TbmDEZc4FRFoQjy+zrI5hNA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgAylYxf64q2Qhc+Y0uO4yxOAqYtzJxd5Os+6jIbCHXoHWFE3PlZyJAmhd5d801BDWCavfFHdqqxJ5tvRu+bAkKLTVgYPb4Gja44qKxTh4jtkLcYKc9YgZub+Dyf0KrlIBh/8USjLPMCfIyBgZW6FUM1ttuIpC/aIMS3wVfUW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F24ENGJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D3EAC4CED7
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735559623;
	bh=rw1u2lnJAZZ2GUZjLa15TbmDEZc4FRFoQjy+zrI5hNA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F24ENGJEbCbzOj6vqFoQC0BGQ+L3QaDnwkennXFGoO+oKWWRnaGVCo1tq6q0PRitk
	 YPZjLvDnXBKvXV/Y5R9Mhwoh2aMxLOothd1FEfkuxdS5WYIfl5+J0uGimXPP2hiW2/
	 21PqjqVr1aYLzMdHxW2OAz00ahws+V+pvsD7be243zB3IMuzLIbyiah98i56oJyvS3
	 APF6seNMT5srZJ19pawkNpBuNFH91ZkaPxVZlGLn0mBO3KmVgk9AV9LIMiVBxdgQVP
	 h5Kipmy8Fjd+QHaSkD+iPVNFE83w++bPTVJI7PLT1pn5endIA2eibmf38K8ma29lJo
	 6uuaWhpqYNj2Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 95ADCC41606; Mon, 30 Dec 2024 11:53:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219640] [REGRESSION, BISECTED] Preferred cores working
 incorrectly for Zen3 CPU (regression)
Date: Mon, 30 Dec 2024 11:53:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-219640-137361-99PgOwHGRK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219640-137361@https.bugzilla.kernel.org/>
References: <bug-219640-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219640

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Preferred cores working     |[REGRESSION, BISECTED]
                   |incorrectly for Zen3 CPU    |Preferred cores working
                   |(regression)                |incorrectly for Zen3 CPU
                   |                            |(regression)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

