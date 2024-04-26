Return-Path: <linux-pm+bounces-7145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86E8B2DD5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 02:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92161C2168F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593437B;
	Fri, 26 Apr 2024 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuwfsBgE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D20364
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714089962; cv=none; b=iOoeJKnCS4YuQcDYfJKNd/VZnrIwOt6/n6OPxhx5ypl+luizre+x7cuFq7droLEV9V590sSwupuJhqPNXeheD3w0BA4Mo5Nfn/+YWv9cOLqUd026vR1Tqb16EqUssxD3RZOsZjyq/xdY5ErWaqa4XVg1BcuokNkJe97xmAe1aUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714089962; c=relaxed/simple;
	bh=V94VzsfsZL10EkIBNAUcluc0sKXfJzHXBh4fAWv6dhQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtA+ROWL53DmuZMJigtNYgqeyaZabyArTYQk/plmSdVSm/JP54d+BC2TACGKoQ+9ztUq0JolzNXadQvs2+UGmkbg3h3M7m8PvMTiJxxNMAS2kTgvIbklpSKdoNvinJf5gn6Yt+j503TVAY1Lo7+L+qgla71CayaP02h0fGFHzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuwfsBgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E47CBC113CC
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714089961;
	bh=V94VzsfsZL10EkIBNAUcluc0sKXfJzHXBh4fAWv6dhQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QuwfsBgEGeaqvVWL12PamUcINY6BYNW3hXsbCkPiPo7FPO3UOlDdCLoUzXjuuaNBW
	 5YzY6vkJ7huiiUC1l18oQj3doO4uG8H5DqLZICSvQvHd34ddNQOUv9nluKTmab1enc
	 EakY8BHZsDASnDxi39c+7Fij4pdpBFjhzqmotJ8LwIIHlW2xZ+NOU/9oLLhWzAAQOy
	 TG3jmz7m/UKqYggBVhUH72y70JlmtJzlyDS5nSnDgA/rnr8miGZwXab72T3RhGgOnf
	 ME+DuipF2Gyf3U579/jUeECdgUfFXmilIQb52gIIoP7uYXo4RyFoezITBHOlFXFQtM
	 +700h0BOS2Kcg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B837CC43230; Fri, 26 Apr 2024 00:06:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 26 Apr 2024 00:06:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-21uHcW0gSH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #11 from Gaha (gahabana@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #10)
> In that case, would you be able to bisect perhaps?  I think you can
> *probably* focus the bisect on drivers/cpufreq directory so it should be
> relatively quick.=20=20
>=20
> Even if that is indeterminate you'll at least have a bunch of function
> hashes you can use to reduce the number of steps for a full kernel tree
> bisect.

Hi, tx but am not sure I'd know how to do that.=20
Just wanted to report a bug and help to the best of my abilities to get it
sorted out as it may impact more people down the road.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

