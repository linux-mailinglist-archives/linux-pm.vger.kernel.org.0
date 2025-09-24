Return-Path: <linux-pm+bounces-35292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F50B9B6DC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654F97B4146
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957463218BD;
	Wed, 24 Sep 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHCG0msM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706133191BF
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737946; cv=none; b=KfQrAVr1X13StaXSzTho+l/jjdRplit+BuIOXWrm7xP0l66WhaNZhAMuD6fRhWvlwZcHSgyv3mRMsPjLtl0JzutwAD9ZG/weuBJNsVF83Qj4PqJ3dqGxERtHw6VLPXW7Gi61VZz40uAZzEjdksjCT6ujv/JsqubNkT38jaAjq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737946; c=relaxed/simple;
	bh=BZPKJ0XFlprDdQEyGRaO7UrDeIivYofeTfVoDEJdqnk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PRh5XOgCWDsrMU30U1yNySOab/IeYw2Xr0ZULIOGZjoFSWKgFVWhc03GIlYJ9cT5wbcKBRbYfTt/Ksn3wLFu6z64I2F1cg2uvFCTOeLWCGkWI+Oir+9DkXptNhU4yN0mTOwU6Jtnf/Ose+M4WxxagDWfwL8JYHLoxPaY8XL2Qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHCG0msM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF7FC4CEE7;
	Wed, 24 Sep 2025 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737945;
	bh=BZPKJ0XFlprDdQEyGRaO7UrDeIivYofeTfVoDEJdqnk=;
	h=Date:To:Cc:From:Subject:From;
	b=fHCG0msM9GFKZ1fDssNNsli6aPO6AYTA0/JEYMo2dLobArU8fSb3SeWOHZk+0135t
	 GDmQpjC/QDPyjgQxSdrNZaK7E9cInJdjzrJWS0eYRLGNyQwCpl7GzPgrDO7pdxUJNF
	 CtUmd0rbedySnsi5foV4sC2VuYDbpsB8cCIDtFykSep7XVXYyGfXhTgUVkrRpEAfR4
	 pS2yFVlfqdRClkiV0P8cCsm0Hkgbp1HTvQaXv6dZVS0yJFn3QKHKsjywsoxecSL70v
	 DevdzxtP60bBNCItcYUaRFzr5FNgoOUhoeUsRri0vjCmjIHGgbO4ruQgWA8HYinSuy
	 D4iKktY9DgNuQ==
Message-ID: <e483800a-53d6-4d48-9a6b-04ad7636b662@kernel.org>
Date: Wed, 24 Sep 2025 13:19:04 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate content for 6.18
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

   Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.18-2025-09-24

for you to fetch changes up to e3f761be5a178bdd5cd80351c5ca0a0cf675ef7e:

   tools/power/x86/amd_pstate_tracer: Fix python gnuplot package names 
(2025-09-23 13:42:20 -0500)

----------------------------------------------------------------
amd-pstate content for 6.18

* Fix for amd_pstate_trace package references

----------------------------------------------------------------
Kuan-Wei Chiu (1):
       tools/power/x86/amd_pstate_tracer: Fix python gnuplot package names

  tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

