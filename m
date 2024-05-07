Return-Path: <linux-pm+bounces-7600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605D8BEACF
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26121C23CDB
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B016C868;
	Tue,  7 May 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhEJI3jy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FB1607A7
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104125; cv=none; b=YdSOhqXiJUp9CLXDePZWEmRlpLzVGChAHlQGdJSeF21kVuLLfc+Ztz91gwHr0/20A1KZzHzDCAWWx62jU6afURi05LO7oOsT3cUP1wnH5fge+iFnbvOP8EK2R/P8Rfz5/CNz5YYLKK2U/T7oPZuYJM0b8KNAxV7OG5RTCWy/DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104125; c=relaxed/simple;
	bh=JPDpDuARG4OSh85TNF8zt3dsjTJg9Rytq+MPkN0POaY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snY/kopKfiQvVHgo3eN1jMX+nEUyjH0zrLZvJGwkR7p5BLx04Z7T2nfC8SBLw0IoijYI4jqo7ssqhm0ISyuX9TA3xZbnCXkiJAVw7O7gH/QTwD7YQU8PF4JAnLecTwpsVYCOhjyrkm0QUXxIdblw6ODcnSFhEDK4YLiN+da5df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhEJI3jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C12E9C4DDE2
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 17:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715104124;
	bh=JPDpDuARG4OSh85TNF8zt3dsjTJg9Rytq+MPkN0POaY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LhEJI3jyv21DYXwhJZm5xNrDRtnG2an34iSo1gECxqPFSuiO29kMOfqrv6SdB/Dbt
	 BfUFtrAeZuaAYRw7QdH1hHX+S5ldn8KLukulBqig/Ic9sIoiz6am/Wh3awEK0DW1NZ
	 XUIHd20lBmrsN2CXsnP9cXwp+cT2QMinO3qHxKmB/a/0nCJFRzHAr+JYdcvWVd4SF3
	 jGq7WG1QtSl4MW9gTr3aIxOlVe7Z2jHzl14hcVPpO21K7T7B1CA96Yzbo4Kalncaq2
	 OYtIjie9Axr9PgOyVNOjm7H5ekYMg6nQ5qvs2Ooe26h0rnbtD+FtrTjDJHRCGCvesS
	 430wxbTePlZSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ACCEDC53B6B; Tue,  7 May 2024 17:48:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 17:48:44 +0000
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
Message-ID: <bug-218759-137361-DCAXlhFjyf@https.bugzilla.kernel.org/>
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

--- Comment #31 from Gaha (gahabana@gmail.com) ---
btw i did clone both linux-next as well as linux-pm and could not apply tho=
se
patches to either of them :(

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

