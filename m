Return-Path: <linux-pm+bounces-34120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9FB482B0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 04:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE4B17B368
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 02:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA501E522;
	Mon,  8 Sep 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NzM8OPT4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CC171CD;
	Mon,  8 Sep 2025 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757299673; cv=none; b=OlDZTsCOtMg1sh6hKusqad+XOAll8bWwk1TUTiw5iZudFXYvbPRfpKWhb2GsZ3exFwcVkXYEi9cgHu9EhcyI+Nda8zCR3mW/SQz7A84CSjh+eUF/0BaRi+iLDpQNqIxZRRvfW7pJxEWGTuu15efVjeSJDXiv/Ckhkc2OfaKVzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757299673; c=relaxed/simple;
	bh=6PGniREo8iRRFGqf6SO/b73DgB7O+ZEKcoaMpvkIT28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7TtlpUvCf2HHOkbGYD+rxVfQ61EeNOr6a/auxOv/xjFESW7pEsqwwjS8HgjwvAGYEbSSRSIOEpSXpfldW7gEKXh5NwU5mc9Y7/Drqj/4bmCGyOSdHBg+uuxc3Lp+pWe4qg0SbZ8i19dCoGZSYcqouV6DD8DP3QZk1Csq+jzEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NzM8OPT4; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757299637;
	bh=Kq5+ie83WAWG3dfLGgHu/YamvwscaWTECpHTn+2Mb8k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NzM8OPT4cHTA3kwdEWbe1vkloBMBhH6jaQIAn/W0Riu1IEP0N3BBl5qS4xQkSOBjX
	 CjBYFBmVF8OnPJOCla3cpe/vmMH3REHMeoW+4RlLlxwktY/EF4MSC2XZG2KmUnZVMx
	 +wyn+OUeQNO33CqQfnsrx6jk2z48iSSBVqonLR0o=
X-QQ-mid: zesmtpip4t1757299617t525c1d29
X-QQ-Originating-IP: sTFAx9BjWx3E+pTv9b41bJNlMLIKiEhtlvUot1PuhSE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Sep 2025 10:46:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4028751903999020214
EX-QQ-RecipientCnt: 8
From: tuhaowen <tuhaowen@uniontech.com>
To: wusamuel@google.com,
	saravanak@google.com
Cc: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huangbibo@uniontech.com
Subject: Sync timeout mechanisms - Request for coordination
Date: Mon,  8 Sep 2025 10:46:55 +0800
Message-Id: <20250908024655.14636-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7JihbTpIyPv5hIB4CbsVYZYi2dZXHpVnqKgFL4WvyXGDDGCxXVtQhow
	nUk2dfSHx1YOWKkvqjTOxxDUPd8OMkYFzi07NDU0wXt860gUv1POVZQsoY1UJ+eAf14/So8
	jj5kT2anL83dKX9GScv8OH0lK7AgoLBDAVnfMuM3EpkR3IjmgS5yAl9MtaMPCyszIA5jUuC
	GdIqsc+df5B33AME0NXXwHomCcD89PIE27HURyHtWwCsoXw29xeffuSGxJIPO0hMjm2j6SO
	wvgJ36wIUhqBTyuchgW+YMhZz4rPG4YrjSg5KKKjKAIKYKlFrOMPD6z9LBEe+yvCZ7GLah1
	4ZQ6SVoY7YnizRU9jun5m4Ngn9vJsyJzkwFzvB/ANPwFIydDy0I0vufVHLwHEJ+BoPByl54
	7JKM2RRDogPFEqtoE1BfuUFP7ZjeQ6XmoNaLst1dMVxLKaCPfqh+nEIgtRoTEl+wrskbMlf
	4xNymRXpOh6hp5YxAkgyaPbD8f+xi7iPVHTztPP4v0OESH/AfYVhVGYz5vDGxClAo5IVLmP
	6Unf1T4dPuT6IGPO996V8uwdfMYySs/kOjge+er1fZkD9MhonxBf72CkNdwTDEiHu+qTBLM
	YmNHeRmsIIqqoc+BRy5GJO2zBO1Uz3++nhEarh0CPOUxmRbTzXwCuveJK8/z6wo9FxZOdYY
	/MOio0LbvUPaDs4qM5Ui+Owo7L6jJqariUM1xk6nZPXf9b1oN/GuJnusYSc/1s2hNzsTf4r
	nUf9uGwRyUiwvOQta81drN0ru4cmJ9IXj6jl09fof6bfQ6jpzsO0DxwpNleudOe1Gwcl8SR
	dLdTt602Ag8sno4Bex2sKJPwPiHtj5KcAWeywATin1vLWQkg2cokB/L4effCMyjO+EtBWjB
	TXarzvSiOeffreyaUr86+G7phOXchZufCRjxdv6HAy0ylRjxRmSStB7gw07wzgEd2k8IjcA
	dNbLwCUE52+VCuPPdDMHbfflmazloDOIfRttiaLNIxJpoClDXXatx9WTlkdkgScCQaLIAIw
	O7AZfvNQMHl0jEiLUZMxVCDw0UFkFw90iwf+SjTA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi Samuel and Saravana,

I hope this email finds you well. I'm reaching out regarding the sync
timeout mechanisms for suspend/hibernation that we've both been working on.

Rafael from the upstream kernel has indicated that he would prefer us to
coordinate our approaches rather than having two separate implementations.
He mentioned your patch series "PM: Support aborting suspend during
filesystem sync" and suggested we work together on a unified solution.

I would like to discuss how we can merge our approaches. Below is a
summary of my current implementation:

**My approach - Time-based timeout mechanism:**
- Introduces a configurable timeout for sync operations during both
  suspend and hibernation
- Uses kthread with wait_for_completion_timeout() to implement timeout
- Provides sysfs interface /sys/power/sleep_sync_timeout for runtime
  configuration  
- Default behavior unchanged (timeout disabled by default)
- Addresses scenarios where sync is excessively slow without wakeup events

You can see the detailed implementation and Rafael's feedback at:
https://lore.kernel.org/linux-pm/CAJZ5v0jBRy=CvZiWQQaorvc-zT+kkaB6+S2TErGmkaPAGmHLOQ@mail.gmail.com/

**Key differences I see between our approaches:**
1. Your solution focuses on aborting sync when wakeup events occur
2. My solution addresses cases where there are no wakeup events but sync
   is excessively slow (e.g., slow/faulty storage)
3. Your approach uses workqueue + completion, mine uses kthread + timeout
4. Both aim to prevent indefinite hangs but cover different scenarios

**Potential unified approach:**
I believe both mechanisms could complement each other:
- Event-driven abort (your approach) for responsive wakeup handling
- Time-based timeout (my approach) for proactive protection against
  slow storage
- Single, unified implementation in kernel/power/main.c

Would you be interested in discussing how we can combine these approaches?
I'm open to:
1. Merging the implementations into a single solution
2. Adopting your workqueue approach with added timeout functionality
3. Any other technical approach you think would work better

Looking forward to your thoughts and collaboration.

Best regards,
Haowen Tu

