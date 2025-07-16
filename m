Return-Path: <linux-pm+bounces-30946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7331B07E7C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 22:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB6E3A6AEB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23D1DB95E;
	Wed, 16 Jul 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWLFd+0P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469993F9C5
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696098; cv=none; b=ifCTxBv/7nURyBjd1TSCAX3Jgf2UpAFPtNLsFtudyjWAR5JzZttplX3d+50WrAfS6XLoNpX0Mhu3e2D/5Pzp2ZKrDnh66ls2muHoGPfKUmdZH9u4Ux/i2mztk2Yk95MajpQAruS0vIgWXKQHpXzz+I0VyHd2F7E750ZXZq1CwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696098; c=relaxed/simple;
	bh=ErMVlOPjSgKYJVNmu9Si7DL4hUIDWYM+o2EhjR1+TS8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NL5te3yiex3wOOLK/36MY93l2GYyeDu3Vj3L3VBA+kJbULpN/O6NGppVWFw/y64Orz/ytU122P+OmAE4nTF6W1M1gyVgafVDsT1TYuHUJY9axLXzTzBHA6WvrtFHaoVTJCSuEf9Q9I5k788zYAaTqI0eOB0oAuCsKgOUapTPnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWLFd+0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770D4C4CEF1;
	Wed, 16 Jul 2025 20:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752696097;
	bh=ErMVlOPjSgKYJVNmu9Si7DL4hUIDWYM+o2EhjR1+TS8=;
	h=Date:To:Cc:From:Subject:From;
	b=AWLFd+0P+GLzdpHXSlt03jAhbDwsmfma+iTRPGrE040knSlM/GqjBzdkObd/EGVbG
	 zUrVZpFHreznuNBDHjDvRd2S/uJa9lwThfP3fqNRXG6h6ViZzxOX+gfZ34n5OBx5aW
	 yu7QJIwCYRHMQsj48c9bL9CGDyiEjLHrYRBZGXprmaRWnOhVzgy8hfglu6Qdktqmx6
	 z+AOCYd+W2ORclRJ5+2c3nGUe5fDMlZdR2bW4kpLSKDcRcP4FI2DQLBq8FMu+RhFbZ
	 Kmrj+1BDSRB9L0RzMndzb9Pyu4gyVUMsY/0WNCkIXAQUwbh/xYB9t5WIESy+Z27TJE
	 5UivCcvcJOMyA==
Message-ID: <bd21aada-a816-485a-b0d0-c4530adf0425@kernel.org>
Date: Wed, 16 Jul 2025 15:01:36 -0500
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
Subject: [GIT PULL] amd-pstate 6.17 content (7/16/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

   Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.17-2025-07-16

for you to fetch changes up to efbc5b4ac98e187375bf14c18ecc76988d3bab3c:

   Documentation: amd-pstate:fix minimum performance state label error 
(2025-07-16 14:55:58 -0500)

----------------------------------------------------------------
amd-pstate 6.17 content

Documentation update

----------------------------------------------------------------
shouyeliu (1):
       Documentation: amd-pstate:fix minimum performance state label error

  Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

