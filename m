Return-Path: <linux-pm+bounces-3151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92687845337
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508821F2853F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F415AAA3;
	Thu,  1 Feb 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQKgUS8z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8815A498
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777798; cv=none; b=RA2M/S9N575hX6F+ZbY94Gytxo5plFkSg2p1rtcoC0bd7TKqOXXZcA3iV0WwFmQB5nr5hf4uXpmoMNIVU72twluDt+zjJTfSrpmNuXAHsWpd7Zci/sA8XLuZe4/BwyPe6s9GRpGkJ//x09ABljr5aYt5wtQ/UTWfFZebEhNcoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777798; c=relaxed/simple;
	bh=joWe/uQnLhPHYqZePLww3c88V9y3rxMwVr7bQ94hT1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bORYNku9MJG8GRaZKu233xhCH4qumKpSq1P2r3Gl4suNc3L0SnVsWASWWeI9jQg3l7h0MkdzplWbi7E81vm5+v9nPj9wTUPtFj++9sZXeZzXJ1WdZR/ROSnbBSVtTSyvvtf55CvQtQ+tPq8vhCN+YKF601mEAS+/QrXQcqrrckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQKgUS8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD842C433A6
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706777797;
	bh=joWe/uQnLhPHYqZePLww3c88V9y3rxMwVr7bQ94hT1c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FQKgUS8zrWYsGaQ29xRVVt2UKCJ2f90cCqmwYSnxZmED15CF7y9PyEX2pfYgA3rqG
	 eZlXfVRk1k0wSCUmuxC4/q5CyYF3sPLarWc9rVnLHdv0V5KwVl/sdB+XWlY9aNoTdm
	 ytdSjHeDQf63HkFRypSosbEyLF8NrHQM2/FUYIIuz6lF+Nd7KmIMhLJwVLSJ0yOv5a
	 hOV64sf9NiXgoUDyPXuY0UMaNXIOwpX+IqCtxQo8cuMK12rW+rapIJkmLL7VUj3whg
	 P7mdTFg3zOhRUwr5HP3ZmdFrOcBNh9t1YmF33hJf2157OEziRXeHfde0PKFuJKP6tF
	 JJ2xjLXSVuN9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BB22DC53BD5; Thu,  1 Feb 2024 08:56:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 08:56:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-AG2UzUO8ts@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #44 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
cpufreq_freq_attr_ro(amd_pstate_max_freq);

the sysfs entry is ready only, so it is not allowing to write the new max f=
req
value to it.

you can try to limit the freq with scaling_max_freq and scaling_min_freq.

The boost patches and scaling_max_freq support are not same topics, if the
boost patches can work, however scaling_max_freq is not working, we can fil=
e a
new ticket to track that problem.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

