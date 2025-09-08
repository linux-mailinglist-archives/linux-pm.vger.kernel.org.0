Return-Path: <linux-pm+bounces-34119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5CB4829B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 04:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4207AEB12
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 02:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15A18FDBD;
	Mon,  8 Sep 2025 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Z/+D2ft0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F035947;
	Mon,  8 Sep 2025 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298641; cv=none; b=of23AaCY1a8kcDjOYk2Zi80JGVJ4KAtrnYlruh66f5+ghKGlFEYvOrmiqvpsHgiszCElfv1q/krbyAdmlY+F5aMK9fedvr1WkZZpEubeKVwPFnXYLRtMYRnNUD3Ho38FKNiL/+QcUNU3qhqoGQf/oQ8ae8Iqz9rXKue1up92VjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298641; c=relaxed/simple;
	bh=ija5YrBdzB7ujRPrPMZuJtQ5PuaD0vVgmgDUqOyN/q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4hy/ZQh162QVfp0DWGvnD0l7qNQFPWi+0lhanmnLs5CBRVuHAlcW8mTqmClfLTHN79ZwZGTeSJyoGRoHpG1nfqVD5Df0YPIG/W9e20Es3knJRmAx5gBKdJMursku8DzQgXnNStJO8Bm3SV7qL1VvKowyElyVTPl5b9LOJRies4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Z/+D2ft0; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757298627;
	bh=Stju0P/KofAABVuqomZXEdLi27uVOYqXgW40v0OuM/s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Z/+D2ft0MKYnKOOxJ6UvOycyJaDb8bfo/oWSBkjFwbpZqxYpbrjvTNMYaXFvvfL/d
	 jh8TMNMUirXCE0uF7rJNwLuN0fm+aqruLfOC0eiAMJzTk+WaARO1CKwMNKWbNKU+SA
	 US+bKCe5L79ov8n/fG4hlTyzEdPMjJp1N35kqfxE=
X-QQ-mid: zesmtpip2t1757298161ta6177e0c
X-QQ-Originating-IP: WDQM5me8nkZOXI0HLTfOQN71XB1G4/2b0NGq3GfmU6s=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Sep 2025 10:22:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16752903429154270373
EX-QQ-RecipientCnt: 10
From: tuhaowen <tuhaowen@uniontech.com>
To: rafael@kernel.org
Cc: huangbibo@uniontech.com,
	kernel-team@android.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	saravanak@google.com,
	tuhaowen@uniontech.com,
	wusamuel@google.com
Subject: Re: [PATCH v2] PM: Add configurable sync timeout for suspend and hibernation
Date: Mon,  8 Sep 2025 10:22:38 +0800
Message-Id: <20250908022238.6852-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJZ5v0jBRy=CvZiWQQaorvc-zT+kkaB6+S2TErGmkaPAGmHLOQ@mail.gmail.com>
References: <CAJZ5v0jBRy=CvZiWQQaorvc-zT+kkaB6+S2TErGmkaPAGmHLOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtJoEQFRGvIzP042hH21Sty0Ti3KizlgH+CYML/TCIaDOzZonB3tpDgL
	utxGoQeYtH74RhJujayi/eKCnxu02ecGoFG8UFQadGOG+y84PazuhcdpAbup0qSuPCJS8sP
	pGg18Yl+xzh7gTxhxgK2pykkLoYgc/IHGW4i+E1gj6/Amjk9/3zXz2UPHImZ8Zt+U+K1NRa
	Ufl5NC/uAeKgO/NDFC2B2mV+q8iaI5t7Igd0Q4R261/emLVqO4TJ9VgToAfP3Z4CJzE1fh4
	dg51Z3huXR0umbQE18NshaafkDqJZ0sJZImdTc/pGrCsSh95K0tAZt1r1/6wAX7aofBoojV
	xwxsZh1EttKe6oMfpVEMerd9sDLObNVo6v25dasmynawYrTQoIeK0iRUf2EAJmyeSY1g1YO
	N2pSMkwlVjp8mKSCVawhPKSxyS1LiGA6BORCxSoNb9DxiA0QOdgMUsFKjzkj1R70FDATiEa
	Cfq+guvaUh0hB4Q4dSJY0SMDzNzgy7Kvp1V0J5ETn3ArkgBcwGclRbjN+iwDlrWF4cmQo8y
	m5g3FXRX7+RhT+LImmLMuv2OC7kB3Eslsapdz0d1NfEd0rSaqAcbPS8HWgQL5xBQJpF0vt/
	ypI451xAPISRRY31/JBdUBH6ajbIuM1exFIu5oH98mZG0RBOmL2zWqSEZd0YaStZrWJA5rl
	KAX6eqs7ZK9zFFWUgQ+C/K79dpLQCvtM6B6QVoowVE9D6FtYOsHN7Z5w2/RMsIqPV/9jGla
	8d9gHHiSNgTt/jybsQ8NbDOCgiTpIQaCfJ6r2fhxB/NjkFxxxr0cJuN82HSJYbfTOV+MGh+
	1N9leSYd33GRGP5XsZnALKipGHaGmzDNz6fi+sy9KyHuhpQrCAeteq6+9adxNLzcpFOs3Cx
	2X2NwllRyNinSGvKDr6TDOy+YrO33Fc21en92zol3hAU5qVpvlAWhrQBqy8oAzPhLXUocEA
	Wei1kMSm7XrUEOuxWH1/DCBV+xKPp8N+yIj3x2AR/Tv9F5pjSyvDT3EnNLBuinFYUJ6K47E
	ycdTvh5w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Sep 5, 2025 at 9:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 5, 2025 at 11:25 AM tuhaowen <tuhaowen@uniontech.com> wrote:
> >
> > When large file operations are in progress during system suspend or
> > hibernation, the ksys_sync() call can hang for extended periods,
> > leading to unresponsive system behavior. Users copying large files
> > to USB drives may experience black screen hangs when attempting to
> > suspend, requiring forced power cycles.
> 
> You need to talk to the authors of the series mentioned above (now
> CCed) and come up with a common approach.  I have no strong preference
> and I'm not going to choose one over the other unless I'm told by
> everybody interested that this is the way to go.
> 
> I personally think that syncing filesystems during system suspend, in
> contrast with hibernation, is rather pointless and hibernation users
> can be expected to be sufficiently patient.
> 
> There's already /sys/power/sync_on_suspend, so why not use it to
> disable the sync on suspend altogether?

Hi Rafael,

Thank you for your feedback on the sync timeout patch.

Regarding your suggestion to use /sys/power/sync_on_suspend to disable sync
altogether, I have concerns about this approach. When resuming from S3
suspend or hibernation, USB and other removable block devices often
disconnect and get rescanned by the kernel. If we disable sync completely
before suspend, any pending writes in the page cache will be lost when
these devices disconnect during the sleep cycle. This can lead to
filesystem metadata corruption, partition table corruption on USB drives,
and data loss for users who were writing files before suspend.

No major Linux distribution dares to enable the sync_on_suspend disable
option by default precisely because of these data corruption risks.

Regarding coordination with the patch series mentioned above, I understand
the need for alignment and I'm actively working on this. I have initiated
discussions with Samuel Wu and the Google team to explore how we can merge
our approaches into a unified solution.

I will coordinate with them to present a unified patch series that
incorporates the best aspects of both approaches.

Best regards,
Haowen Tu

