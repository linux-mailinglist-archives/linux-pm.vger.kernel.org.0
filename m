Return-Path: <linux-pm+bounces-8006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8848CA554
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5731F214D5
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 00:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952652579;
	Tue, 21 May 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxpefbGz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B3A2D
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250525; cv=none; b=HlmfeWPxH7qmaMyVTBtuatiAUh5gXuX2kHTFBxjHnw7+NP6lCGMXTXD1iC1BdrtElvG/RyEdke7Gpmxa5sFYyG2maHroRIQY8L/Z1tMGA7Zqe0MxieeoqI0hrsHAR0IDZ9Fryaj54tYCi2Uncqh9tH4K0yqWTsbNmmTQy2LSVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250525; c=relaxed/simple;
	bh=zTCZOAX3ND2wIH61PbgGuMUIXEOKCTaR9k5v84GFGGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+6ffa2UuIMC/JPLgrUS4frEn0jfNM91vGOy9BuetVIwksRj2hI1fmuXzehWYgbOV2BjqHJVAO4FRswC37KXFMSkkaJA2SS+0VO3xq/3ceoWy21KrmsOKnTaAzoqn0KKO1Wt7l+1HWB2a0kqd/cK6zDtBrkwMkG49Ab9Vo4mifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxpefbGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9378C4AF07
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716250524;
	bh=zTCZOAX3ND2wIH61PbgGuMUIXEOKCTaR9k5v84GFGGE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mxpefbGzVrWa2LF9WcN3Im9fcqwqtM3bcNlyOV2NwZj4UJP+Bz/i+TFnnHWaBWYHx
	 NZQX95fhlV7a9xgl5Nx1IDBzphFWhx5dwVcqHGF0P7L0DVDERHDF5neZwhIypuLjvE
	 X7y/rvv8T21TlJ6hZwQ8n4R+SbBh7rPHnQX7hx18wT5WjH+ylZ+KE/Xi+9wK1yUQ+f
	 qY5nM5unoViuiOsQ0R1nduz7lHRqiD6YZ8ZzJn1a6bj5/FmcMeHSqFPYXm6xEi3ghn
	 g3Nz1l1/iWnyNCZdxbNUjSxPjlQjVonkC7wZrM8JbjKIRXPGOzTbJjaSrVLy1eOHzm
	 Y/2wGc5/PYVzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E2C0AC53BB8; Tue, 21 May 2024 00:15:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Tue, 21 May 2024 00:15:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-218865-137361-B7KJGZeVLd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

Matthew Stapleton (matthew4196@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|NULL pointer reference if   |NULL pointer reference if
                   |amd_pstate=3Ddisabled on a    |X86_AMD_PSTATE_DEFAULT_M=
ODE
                   |AMD CPU that supports CPPC  |=3D1 on a AMD CPU that
                   |                            |supports CPPC

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

