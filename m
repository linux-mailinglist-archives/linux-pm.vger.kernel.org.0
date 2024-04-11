Return-Path: <linux-pm+bounces-6254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DDF8A070A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 06:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08971C20DAC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 04:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482513C3CA;
	Thu, 11 Apr 2024 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihQW1OGv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246713C3C3
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809125; cv=none; b=cRxXMiVhtB73g7PeDFS49iSeaWQGTkr7YRAETnW1PUScaARLhXcOfssWpuO9tLJI47fSQQj+QauCCnuXeZhdeyM1Dlpy4IvRB/VorDuhwYY6ACbV5psKNEATxw/5P6XvJDbKGfw7grNWzyn5v4dymwzMhI1IoOgpp1WxSe56zHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809125; c=relaxed/simple;
	bh=9Ay8WCRGdOWd4QObDOm4Pzeo7daZ8hEZ0kkHw8Xm+vY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/6im2DTxlszQIEjRiiUEBLdhwInROvRLNH7F+HsI86hFCIcMeANORzlM7rO9+RMmHmORCWgzn0W8wSuq0uzVvVsMcpUe+QXvc5V4cB3VBmWWjpfIKz4VdDk1KGqwd7rZ/ozncUwJJse9hxONbvy1eTqBQFsGO5He4Hlv2e/0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihQW1OGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA35C43390
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 04:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712809125;
	bh=9Ay8WCRGdOWd4QObDOm4Pzeo7daZ8hEZ0kkHw8Xm+vY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ihQW1OGvIlohKThfY1gHWeRLUe2I9pYgsMQrPpR39CSDmJISFIYf7W069c4rUEMNK
	 WFUkGy8Maaz9A+945SBHQH3fuWIA+D09ewp9uXWLfk43II6j8d4nFGA8vBPwRqYbmK
	 63iO72MLoJa6GgrDlzqPOPtIMzdTlpPNVQeVOQWhE7f9k/6o1W/cCzeprlqPE3F5wY
	 /PqXE3IEWdG3cAGqRjbbFf1Tu7Z1E9nYh7f/Aj4OOCKrTi9vq4k12x1WdQ96HHeV1n
	 wM+w6xTPqKK06GFWIQmVnImD7nU/v+Ccw0urbDwCXzUdMduAguYzky2HeIFb29ED9l
	 /0HfY4smocQ5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 73BD2C53BD6; Thu, 11 Apr 2024 04:18:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 04:18:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-3PELNxqDNy@https.bugzilla.kernel.org/>
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

--- Comment #25 from al0uette@outlook.com ---
Strangely I found CPPC do work on Windows

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

