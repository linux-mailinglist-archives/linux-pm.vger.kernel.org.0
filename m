Return-Path: <linux-pm+bounces-63-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC497F4088
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96713281145
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425BC8494;
	Wed, 22 Nov 2023 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbTp3gVT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD814002
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C1EC433C7
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700642962;
	bh=DtoOMtvOo8iA9U4jlHV1z7rJyS/uFnf6KuQOllrDZ/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KbTp3gVTriEYwleqRu+lojK2QTr5Oe0T5x6YL+flH/7eU6TkAX8jQM/lqRPl5X7Mb
	 TxDTpuMLGIFUTlm6VCUuwLApWD5TROVmS7X7ZWTq/fMwj8GIjYjS8LtwVUkH6J1KNW
	 d9RXZtsgWJH1ztTFCz9WFTbCMxkXhxpo6IQVxXtudADqT7yyZGxiWI4deDBSluG9Zs
	 2qwX5JMMurfP6t36fuyWCATeSHEyFD32O8B6rxd9hW+jNz/SHPJ/q0hbEP7REKzVK+
	 cKI/TCndJDxBWiBWAIiEEN+VZuVr+UiBrQjnl24libGf5u4dYAmMW6FRMUUvpfFlu5
	 cxQU8KoYmnncw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 68C86C53BCD; Wed, 22 Nov 2023 08:49:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 08:49:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218171-137361-ySaM03MLwe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #7 from Gino Badouri (badouri.g@gmail.com) ---
Created attachment 305458
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305458&action=3Dedit
Asus ROG Zenith II Extreme bios version 1802 (2023/06/20) with CPPC and
Preferred Core enabled

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

