Return-Path: <linux-pm+bounces-43364-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e7ixA3YSo2lJ9gQAu9opvQ
	(envelope-from <linux-pm+bounces-43364-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 17:06:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBFE1C435E
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C095E3006791
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08620274B4A;
	Sat, 28 Feb 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qacDT2ms"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963B8F48
	for <linux-pm@vger.kernel.org>; Sat, 28 Feb 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772294770; cv=none; b=lUHgvLxdSDxQiEmqyJRN4z05JwhKfmHLwJlkb3LV8VbQ049MutWedv2DFUc7bfMGuAsxKrrFtIOW4O8dV3KgEaVLAhFR3vLf9pbFH3vuca2R2lxw0TZ1+H+mvZ/84ukd9ykZZ2/W/zUwZRPFYA1Gh/BGpJieok498EoWj2Fs3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772294770; c=relaxed/simple;
	bh=MUMwr2u5lCDbJIr6Pa+cEQCU/kSJY7HfZeRM3W9uQQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiUfpbxcx/WpCc/XOSmM2Btas5YQzwBdQ1gNnVyn+9w+cRpYTi1vxL4DsGBDyijfSQYOimvP1DarZ8KvuYDvaaJCfPCPme2FW5crxOabvPbx2l2fb80DpxUnqJj5Czx+yk+xBep1pGDp+3khDYGgRsdRWA88rS0pLRWJs9A4Kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qacDT2ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BD07C116D0
	for <linux-pm@vger.kernel.org>; Sat, 28 Feb 2026 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772294770;
	bh=MUMwr2u5lCDbJIr6Pa+cEQCU/kSJY7HfZeRM3W9uQQw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qacDT2mszHxRpz52Xy+7K/Awk0OsBQOXkx3iRyQ/thMpCWFVDkerjRF7VqtbM6zkT
	 0/fQG4z7DmUgMJZmijTWOK/EDnFZwhEPDwAp+F0vM1R521QIMTIm7HJQVFFel4iSet
	 HJEK9tfB/7AyIJ/2UBVVMhUwU+R2XuRN7XkwO92EDw9Kc/Tns72AFx5RRB2CnGhNdq
	 Pm7VABqXxvYTfxZsHJFBzyUm9UO2E1dDO4bglty/xCcBvZt6xqjqgYLmviSAqMAJOO
	 WMaZvFRfrtwyxnMwiwP+F/LD4E+Izt80MelgsUqlbQ0Dn4YRHP1+xdwCRgOlprfkCt
	 c72HvwecG9rrw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 743E1C41612; Sat, 28 Feb 2026 16:06:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220117] cpufreq performance governor doesn't correctly apply in
 combination with isolcpus
Date: Sat, 28 Feb 2026 16:06:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dsmythies@telus.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220117-137361-ieClOiYSIS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220117-137361@https.bugzilla.kernel.org/>
References: <bug-220117-137361@https.bugzilla.kernel.org/>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43364-lists,linux-pm=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[bugzilla-daemon@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FBFE1C435E
X-Rspamd-Action: no action

https://bugzilla.kernel.org/show_bug.cgi?id=3D220117

--- Comment #3 from Doug Smythies (dsmythies@telus.net) ---
Yes, this is not a bug and can be closed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

