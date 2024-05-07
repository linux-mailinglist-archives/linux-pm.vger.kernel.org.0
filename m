Return-Path: <linux-pm+bounces-7570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F768BDDD9
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BC61C213A4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D514D6F7;
	Tue,  7 May 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1pAIydH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2A10E3
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073298; cv=none; b=Mvd5o5wozDXU47wbW4FTVH6O5tGom59yw/wX2pv+kIvaV9uY/XINpubijHNfuMuVT3DVANAAODwWUkWcVyIRKl3oIyr0EN3sqVO67ejJowyjcMLEIyhJU7NOx4gb0vR16Mtxh2tsy+8kpqnQ669VfQ3/C26z7xBPeZKred9/ZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073298; c=relaxed/simple;
	bh=WlRWE63t9WaNTXOZSZysoZ98tiUZT/VzqchY5XCcbVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFqsYn2T1vXRDT9vpzr0+TkAWj9MZWVsS6t/Yr272/DICnhVQSOnSfNYD9rFu5Uy2HL98U/BwN5OMVPup9h0eHZkjJmdKZwSfl25MFgu9cgCVkj4DN6zXTTq3uK3oa61hnxWgE1/I1ggXcIFJbh+GjyWvId4DbJcd+6zCt2ztPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1pAIydH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2A7DC4DDE0
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715073297;
	bh=WlRWE63t9WaNTXOZSZysoZ98tiUZT/VzqchY5XCcbVo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k1pAIydHHVLylYzsKemui2H6dZ3EOgRCMwAhIM63QzANmqq0Ed6cQywcrGHqd6vIt
	 2dlVOKMs0CydwnDrgTkOJ3JpbyqMv5Jpd71kw0kTkmQMDZfiV84a6Ccy5HKC7hiYME
	 3UC2qo2DI9iBZMQOJUipGcTojDFXlgZcEg+RsMaQ92fpdPHxDiuHSsAzXBxeNZ6s0W
	 sems0wSLp3oXzLmBnQcBycFJo7lh11lM1rfOMqhS5w+1F1qpNcjt94zugxqidOiP0o
	 lZe2O8rtu92rKIu0IH6sx7huex6knd0SXBEEVztzxAfpXY09fpcpHBZ9blcfDCuvLQ
	 ejR3onitMBA0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C9256C16A72; Tue,  7 May 2024 09:14:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 09:14:57 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218759-137361-cW7AxM1tmY@https.bugzilla.kernel.org/>
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

--- Comment #21 from Gaha (gahabana@gmail.com) ---
Created attachment 306267
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306267&action=3Dedit
result of 'git am --show-current-patch=3Ddiff'

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

