Return-Path: <linux-pm+bounces-24605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A5A757A3
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A163ABC9A
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0221A5BAE;
	Sat, 29 Mar 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3EBXBFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669017A31A
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743275078; cv=none; b=Upb0a8UqzU3CoU7OPki70J7f5jSVhmd2KCpbcrOYcjxQPQ1quEpGYBsLkOaWBYyWmRY9wmbZROfrZ/nRkYYK1lfBrjvvKqtuXJpzG2PH25GEFh3q5JAGpQ1m6CaotAC5AN5isukCody6uPHE4Xpokhk6PuH2xS0vwWcLwjvy+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743275078; c=relaxed/simple;
	bh=FSw8jjEDmsUYO7GjRPNf6d05OS/+SyOPl0v8Z2eqNxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3Ye65g1HeAqcxa5N6lPBjxGuFBB9eWELJWBY6M+Nhv8ztiNoeuvBER18JS2c+Oy8P6vIjnC1iDI9XHuog1h4nBghJr/aU2P03MW0Ge632GkO+FLbdSCJzP4IZoRF0SFWnexylM9bZbgHe8N5e8zDgby6QMR2uBRlFlKaJH3dfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3EBXBFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03E5CC4CEE5
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743275078;
	bh=FSw8jjEDmsUYO7GjRPNf6d05OS/+SyOPl0v8Z2eqNxI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d3EBXBFtEwPbJniJA7Fzks7n7YMuxTcAQNUP1DUsDISzM/tduIdQNelDd8fbWM46d
	 IbidQua8JD+bK7H81Z7d53y89UGwAGbK1CUSxwlAS+VPs1zKMLa4N/ftHejWPhIFjs
	 Fox2RxaZypHnia/BlZAPSn9CPaT3wkEkKldWckfIaqNpZZkrlIEWFjrV58VYWM8rx+
	 57mrPNqBP1DRjbVRmYxgb6a2b94fFHHHBxLIVszEnTDDUl2Nk09Whbr5AobmLqmUMf
	 QMExgAW3vtldH+IODZkLwj2bLxoZcI0mxEVUh9o4BDp7pSuayidKKR89T7HUovyIGs
	 LSxACUgyxu8vQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9BA8C41613; Sat, 29 Mar 2025 19:04:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219966] modpost: EXPORT symbol "policy_has_boost_freq"
 [vmlinux] version generation failed, symbol will not be versioned.
Date: Sat, 29 Mar 2025 19:04:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219966-137361-V1UaoIroem@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219966-137361@https.bugzilla.kernel.org/>
References: <bug-219966-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219966

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.14.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

