Return-Path: <linux-pm+bounces-20600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6D5A14A68
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD5916A8F3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F91F6687;
	Fri, 17 Jan 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="KCBHr6Pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8F1B4F0C
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100357; cv=none; b=RvzUOPdFqHknXGmUpLGSZy+XbTorhq2nGl8HpZ+ScJzvNVDeribsE6H2DTFxVrbdZ1ECXO+FQksz2Yp/hh5eVvqOFBsZf+aSsfaEoof9401+U2b2NkDh1NxmVSfsbYPPdqWKc4XFyijEwqKBrJPmg6tgXTozybtILbCaWoqvsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100357; c=relaxed/simple;
	bh=E1LQIE7A3BgeZ+4yFDmM8zl4yAhscW3P2uZTCe0E7QQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BxNTH1VwDS5LqIYBSJkHKl31qlpODaEDlIcni+CKfTkYA5UvwDr0FZw0+eJKTo+SLDdBbD32ePD2V5ReewaWPHZ0m11N1ooc1PyQxXkvA7X+yuTManz8Sqt+prq1ICqitMM4gmxEWP1AHOi97HIQpZDqlLWOkp5bjr5M879mk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=KCBHr6Pp; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Fri, 17 Jan 2025 08:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1737100347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1LQIE7A3BgeZ+4yFDmM8zl4yAhscW3P2uZTCe0E7QQ=;
	b=KCBHr6PpbeKy+Ngi4T06ug2ZvbfATktuu3JnlVaBVNoIkHgi7IOqZwbgYQBny79GEfWKJA
	zfI046qs2mMrfgHHn4MyrDnNVN85Wkk8Ig1ezp3UQuf5hBqn0sfaOY3mnQBbyL8f4pbL6b
	bnpU3jCMDSRzS2QJzrvb5SsASz2WWbBIF3rXKEeifiNt4RskNO4uUX4gRW9IsOtcZT+pVB
	q46aioIDLKdPxZu7A/t5bJYlzvhe4gPIopELEGyffLbJZ/bbJphADZZJ8L8nxOG+U3ISui
	B2POw8E5xEARl6/cfEs/fveS1aMFX2903rV12KyANd1E4K0Yd9RFus9/Bj/ESw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
 rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
 kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D_Kernel_booted_via_k?=
 =?US-ASCII?Q?exec_fails_to_resume_from_hibernation?=
In-Reply-To: <Z4nRWnysvuxLWU32@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a> <Z4Zjmva-pLbLjtQv@desktop0a> <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv> <Z4ejbdJr87V3IwV8@desktop0a> <Z4jy-NoLxpwaLfyD@desktop0a> <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv> <Z4nRWnysvuxLWU32@MiWiFi-R3L-srv>
Message-ID: <1A927798-F31C-49EE-8CE9-657FA6E72842@r-ricci.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On 17 January 2025 04:41:14 CET, Baoquan He <bhe@redhat=2Ecom> wrote:
>On 01/17/25 at 09:55am, Baoquan He wrote:
>> On 01/16/25 at 12:52pm, Roberto Ricci wrote:
>> > On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
>> > > On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
>> > > > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
>> > > > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
>> =2E=2E=2Esnip=2E=2E=2E
>> > Also, I can't reproduce with the default config (make defconfig),
>> > therefore something in my config (I already sent it) may play a role=
=2E
>>=20
>> What I tried is defconfig on 6=2E13-rc7, let me try your config again=
=2E
>
>I tried your config on the latest kernel, reboot will fail during the
>new kernel bootup after newly built kernel was installed=2E
>
>I haven't compared your config with the defconfig to see their
>difference=2E Wondering where your config comes from=2E
>

(Re-sending as I forgot to add CC, sorry)

It's based on the config used by my distribution:
https://raw=2Egithubusercontent=2Ecom/void-linux/void-packages/41335626868=
0b477b42a4af9462b9bb49491ca19/srcpkgs/linux6=2E12/files/x86_64-dotconfig
I ran `make olddefconfig` and `make localmodconfig`, then
I made a few changes in nconfig, such as enabling KASAN
and UBSAN=2E

The kernels provided by the distribution, which have very
minimal patches, are affected as well=2E

