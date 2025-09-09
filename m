Return-Path: <linux-pm+bounces-34212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB59B4A33B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92863AEE01
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4E3081A0;
	Tue,  9 Sep 2025 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SlrU92n6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D11F63CD;
	Tue,  9 Sep 2025 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402099; cv=none; b=aEoGMQ0mo1rP7QrF180KbKcpatyoqvgyd950rKSchkI7y/h7tKQTv6+FT/UeEE6JbF7Nx9/E1e+CUjiSgkEUvGY1YJR3FC8ohTNCiEq9d2b+A05YxeBl5aLEdvC6Pf7Eoobp/eAb3zKbg4NgahdquCgelFE2FuM97yAWaV5FrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402099; c=relaxed/simple;
	bh=sdzyGvAeSQcWy2Wz5QBoX+n7sFpI/UYQ1+upoQjj2gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lpw7zBQ2lfy/i1R3I2gE2hKNHJBlqbeAteOh0+kxlYB0sY0LuuPLoIgfUKeVIcCG2w5uGZphFpoxFf7LIzzaOUzPCGGY1+QPyEi9qqmhrg00L7654YzHYMeMZQalBsi4g01ESRJjvafYeLoCfsA6NE5JRNQI74dLG9eQDd/EQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SlrU92n6; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757402066;
	bh=8lcessy/nAgKWdegjgS+z0CjoTlOYUe+2td5ZTpR1gg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SlrU92n6/PeGrf8BEGCaBaawvlYmSvn0QOG7UXyx8G6U3Ne2frz5aOQJibths4Lt2
	 CNrD6BQf6gNxXZkciSMdixdzZ2dPwIAlMFylIpBSI5aUsTE57oDmHrey+DpSWQ20ln
	 0re7iRsFSYdMpvywAn0L/ppD/593ge+e/8epH3zA=
X-QQ-mid: zesmtpip3t1757402041t7b363f5d
X-QQ-Originating-IP: +DSaXXEyindzSN4CBI5FKSFnJnQ3fuH7iGAW7a1hL1M=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 15:13:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3187990918985432852
EX-QQ-RecipientCnt: 9
From: tuhaowen <tuhaowen@uniontech.com>
To: pavel@kernel.org,
	rafael@kernel.org
Cc: saravanak@google.com,
	huangbibo@uniontech.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	tuhaowen@uniontech.com,
	wusamuel@google.com
Subject: Different approaches to sync timeout: Desktop vs Mobile use cases
Date: Tue,  9 Sep 2025 15:13:58 +0800
Message-Id: <20250909071358.5943-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAGETcx-mA1kBw+r+tJOdpdqKHZQfNHvA-JS8wXc_ZHhj23WtMg@mail.gmail.com>
References: <CAGETcx-mA1kBw+r+tJOdpdqKHZQfNHvA-JS8wXc_ZHhj23WtMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MBKLumFSBSSx8aYpfKbK/5BkKDPkyjIEAPiiBfaT3NfM1dyMymZ4pGcW
	+Sxj0e+vg1X5uXiVGTwkyKDteoxDLziB0PPciJVAnoly8bnvdRsTKNlF4QbSLU83eKq3RLC
	2QJLrtg0t6LkmZz3t/lznb2FAz/Z+HLnK1E8uNK05YpYT9oneY+N0k5uBEZb0Cw8Zuyqcvu
	D1aJ5YVBv31rTxcLjhnvnNN5H8TVCpJhHY+4cJmTM8sy0tHAIoom4ywrpmbadKDyhjcx5xr
	cQ4R6nfCcds8BsOtNxIweMR/AmZUy/kDh3gjDyp5eSsrxtMNHbF+00Ur7x6aoqOkqYlrT2a
	y/xgJSZMX/C1q6hZw6FCmuGF7X4N+8W0ohRuE3pDJqTiyGBYGpTL3GqXX4pOqUKkVMDzOIo
	D9zBj5Dpw2oPZAQf5CWu/NU7CKWkwxcn9Rgw1JOFXn+QvAxXPB+di/Ttx6vgTzJXoW7J0CX
	5mcLJuxDhFmDxJgPA+Dij2vJ3CP51TcU7FPtxa5A7i/IFz1DEL7CtXXmwDTEIzg0EoVOjMP
	oKQA13sU4ufMeCL+7FuCUMUVAHBpuOLNHIH8g8D0hPLfnnarf0MtqC4/vXCgrfNEswiS0OB
	hGosmK5hBoLBr6tv/Z7CjAVaSuq9Jtrw+Z+7Ehrk0/QR92SDJgFE76rsFhYlQwNvaksVbK2
	eRlByrbUMCI6N9EjpXkc5x3Qqst6rdcwB4Lp++QxSQtmOHN+bh5nryjxPikBpShpZaohmG7
	CWxkmHFemCzMFK9Zjr7xnuYgbAeAJroqOtogMB9hYW9BjVQFTAna8HZx3tsvP0Dr3q1+PqF
	OVSAUbUUDq66rMnCxZ8HyT2/ds8LJyX4P9XKMlU5PWPPrVfhXhcsjCrbftlKYk9ESisC9fQ
	jzpoZuTXn+zKRUisgFM4U87INSaFIi7erVLI950E/FiIWEThZjspuXw1XxQd4EJXDM0pD7P
	fgwLgVKKcgB5+qUBaFnrgw7iTd9hXwesOIgQnG43PcluKTp/amXStiSDGMRPL4yGMlBVf7c
	kdVvZAvBizN7IU+p8DOICmFMcdQ8ueW//thNkoipcIeUPo8XFC
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi Rafael and Linux PM maintainers,

I hope this email finds you well. I'm writing to discuss the different 
approaches that have emerged regarding sync timeout mechanisms during 
suspend/hibernation, and to seek guidance on how to proceed.

## Background

We (UnionTech) and the Google Android team (Saravana, Samuel) have been 
working on similar but fundamentally different solutions to address sync 
hangs during suspend operations. After discussions with Saravana, it has 
become clear that our approaches diverge significantly due to different 
use cases and environments.

## Our Approach - Desktop/PC Focus

Our patch: https://lore.kernel.org/all/20250909065836.32534-1-tuhaowen@uniontech.com/

**Use Case**: Desktop/laptop systems where users expect immediate feedback
**Problem**: When large file operations are in progress (e.g., copying 
files to USB drives) and users initiate suspend, ksys_sync() can hang 
indefinitely, especially when block devices are removed during the process. 
This results in:
- Black screen with no user feedback
- Users assuming the system has frozen
- Need for forced power cycles
- Poor user experience

**Solution**: Configurable sync timeout (default disabled for compatibility)
- If sync exceeds timeout, suspend fails gracefully with user feedback
- Sync continues in background after system resumes
- User can take corrective action (eject devices, etc.)
- Prevents false impression of system freeze

## Google's Approach - Mobile/Android Focus

Their patch: https://lore.kernel.org/all/CAGETcx8x5G75sQ9zVkxe+BpK7WsEk+LS6KDMd5BBR=xWPMtevg@mail.gmail.com/

**Use Case**: Mobile devices where power consumption is critical
**Problem**: Unnecessary wake-ups during sync operations
**Solution**: Abort sync only when wakeup events occur
- Wait indefinitely for sync if no wakeup sources are active
- Prioritize power efficiency over user responsiveness
- Suitable for devices where black screen is expected behavior

## Key Differences

1. **User Expectations**:
   - Desktop: Users expect responsive feedback and ability to recover
   - Mobile: Users expect device to "just work" when they next unlock

2. **Hardware Context**:
   - Desktop: Removable storage, active file operations, power adapter available
   - Mobile: Integrated storage, controlled app lifecycle, battery dependent

3. **Problem Focus**:
   - Desktop: Prevent indefinite hangs and provide user feedback
   - Mobile: Prevent unnecessary power consumption

4. **Timeout Philosophy**:
   - Desktop: Proactive timeout to maintain responsiveness
   - Mobile: Reactive abort only when wakeup events require it

## Technical Considerations

Both solutions address legitimate but different problems:

- **Desktop scenario**: User copying large files, removes USB drive, initiates 
  suspend -> ksys_sync() hangs indefinitely -> black screen -> user thinks 
  system froze

- **Mobile scenario**: Background sync during suspend -> unnecessary wake-ups 
  -> battery drain

## Request for Guidance

Given these different environments and requirements, we believe both 
approaches have merit for their respective use cases. However, we want 
to ensure we follow the kernel community's preferred approach for handling 
such divergent requirements.

Would you prefer:

1. **Unified solution**: Combine both approaches in a single patchset 
   (more complex but comprehensive)

2. **Separate solutions**: Allow both patches to coexist, targeting 
   different use cases

3. **Staged approach**: Land one solution first, then build upon it 
   (Saravana suggested this approach)

4. **Different direction**: An alternative approach we haven't considered

## Our Position

We believe the desktop use case requires proactive timeout mechanisms 
because:
- Users directly interact with the system and expect feedback
- Removable storage creates unique failure scenarios
- The cost of a failed suspend attempt is much lower than an unresponsive system
- Data integrity is preserved through background sync continuation

We're happy to collaborate on a unified solution, but we also recognize 
that desktop and mobile environments may legitimately require different 
approaches to the same underlying kernel mechanisms.

Thank you for your time and guidance on this matter. We look forward to 
your feedback on how to best serve both desktop and mobile use cases 
within the kernel's power management subsystem.

Best regards,
Haowen Tu

