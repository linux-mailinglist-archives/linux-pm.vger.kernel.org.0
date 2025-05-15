Return-Path: <linux-pm+bounces-27206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B6AB9094
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 22:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DF34E5FDC
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AE28C2C6;
	Thu, 15 May 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGsAvRMT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB0A1F153C
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339869; cv=none; b=uTZsD9hizpyyOnREWmJgXFli5hbOIGGdF6uhxLHTOGGCivXXEPxKNrdWin+poq4lN980I77VtgXTJSGqLC8N5WjmDq2FxXSiQgS9PBIdqgzYxw1Px4/NmRqycERTQdOp/0ChIXaSrSxZP5zozIcOLBf0iL4Q3jb7dfTZlrNFHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339869; c=relaxed/simple;
	bh=FdifujrBAraqz9xS20WH/dST01wMNePtkb/C3d3MKaA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GKNNR7md0TtyD+3JhI45Wr39uqzoL6cW4T21ObOIIb8uGpv9X6oDdzuvBXDSlprzY7FlgIrXUbdfAU2Ou9HUYCMNLHOPsSGM3CNsitHndtE2kPqrVQJ+wn3cVXGcaGfjeq2zFZ6uEK4fVveisTijzsSsioM6xt/tkbLrvzXxze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGsAvRMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9346C4CEE7;
	Thu, 15 May 2025 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747339869;
	bh=FdifujrBAraqz9xS20WH/dST01wMNePtkb/C3d3MKaA=;
	h=Date:To:Cc:From:Subject:From;
	b=FGsAvRMTRXRA1tVEHQ9Tt42to8ifFmdcWIQS4zBCP0fYasZpch+LsgcMcHy/+9kUn
	 1W5ERLbOAavRbNB8UXCf2bVOQEx5MwDai1tO+2+UWGL809naG+PIslvJi+GRco6xrm
	 f6MkP4yxS3cQ5UwWyCapHkcaZF+ulvuYyWJmhyr6lgfLYa/5WXSpXqqUMjEUZdNwVM
	 5LMbx1esoNX5fZyh2ZB+CpH411BXxBNOLOUCQNTyLokceS9qtofUWzu4C6KAz+VKH9
	 +5KEcmyQEW01+zagT5/BZUH9zsrQpl5bPRRoRBNwRrOl2Y54297HGBsCYFhckTE+61
	 T/nzwnIfMw/vg==
Message-ID: <bfe60af9-0246-4ae9-a15a-24e10def6d9f@kernel.org>
Date: Thu, 15 May 2025 15:11:05 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate content for 6.16 (5/15/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The following changes since commit d26d16438bc5fd5524121244cc133f9872a63210:

   amd-pstate-ut: Reset amd-pstate driver mode after running selftests 
(2025-05-05 12:07:42 -0500)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.16-2025-05-15

for you to fetch changes up to f6b1eebbdbc75377f98fc9774bb86ffc270dae8e:

   cpufreq/amd-pstate: Avoid shadowing ret in 
amd_pstate_ut_check_driver() (2025-05-13 11:12:44 -0500)

----------------------------------------------------------------
amd-pstate changes for 6.16 (5/15/25)

Fix an error caught with -Werror in amd-pstate-ut.

----------------------------------------------------------------
Nathan Chancellor (1):
       cpufreq/amd-pstate: Avoid shadowing ret in 
amd_pstate_ut_check_driver()

  drivers/cpufreq/amd-pstate-ut.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

