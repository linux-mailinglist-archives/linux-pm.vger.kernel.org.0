Return-Path: <linux-pm+bounces-8419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9D8D4995
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD611F219B5
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DD185088;
	Thu, 30 May 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="tRqABsrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CD183A87;
	Thu, 30 May 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064475; cv=none; b=k/ZpVNg1TiwoTWUivhGKYcVS0vupGD9GCmXzx8SINPKJ84b5tcsGKQpkQWbZ4JkTz8JipIouqV6GaDojqO2CuSghHaXCOAiaZKCJztrZdAkFUTgLhbfhwcJx3ZW5nbpHRdWQHGqp5GvrI/h77PyWXUaZ7aVN7PwBwp/Tq8PP/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064475; c=relaxed/simple;
	bh=OQhhkThCCb6XD1WjJ1Qd/C+fkTC4zhTX508I22a4y1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=sawSPlT2AvvTuipSW8//C+tQeWS5E4Ufh4FxxpIInHwlgE1Kx+Ccii6ZyelEOH01/9tnH3U0GR87HKvERFmgFtFKrcEFznA18AHeqGXSat1u4MKrdnVtZsfo2G8DUS/toLC5E8RsBpGZ3GNR1AaIfmJ7I/XAgZY4U5aS+N3GfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=tRqABsrh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=zY0Qu+QJXHc8dveVOi28HDt+6kTfFSXuaXR6SyDV5sM=;
	t=1717064473; x=1717496473; b=tRqABsrhngFAnpaS10TTwta97E9RwyWF7TIifZyakx6jw0e
	x/VL1k1qvrsBP8G6WzklZTRYBXqrBuVsx9k82Qpb/ryhcg/ZJZiJ2a52hTCsAnVDcV1+7gtiKs04H
	i2A/ewVXeL1cYi7Mo0HHgNBr7v8QglrKNYTFXms2SoYSxU4ck4OgMkoBkvqA620IyD9FDpfH4/cUA
	JE2uGqvXOx7/OqMlM+eZSCBsxzx6s9eo5byVrbY97zee363zGnmNj1B6m0RhDC90Ou2WVQ5RDml9K
	/oIiwAAncHj3xMMhKnvf5lnMVOgdmzA6289uzFN9oQZL5gjprDH4c6KYABdvbRZw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCcuE-0008Ss-Jg; Thu, 30 May 2024 12:21:10 +0200
Message-ID: <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
Date: Thu, 30 May 2024 12:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Regression, thermal: core: battery reading wrong after wake from S3
 [Was: Bug Report according to thermal_core.c]
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: "fhortner@yahoo.de" <fhortner@yahoo.de>, linux-pm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717064473;aef88e0d;
X-HE-SMSGID: 1sCcuE-0008Ss-Jg

[adding the culprits author, LKML, and the regression mailing list to
the list of recipients; changing subject, too]

On 29.05.24 21:52, fhortner@yahoo.de wrote:
> After bisection I have reported a bug according to thermal_core.c:
> After "Resume thermal zones asynchronously" commit: Wrong Battery
> Reading after Wake from S3 Sleep - Lenovo Thinkpad P1 Gen2
>
> https://bugzilla.kernel.org/show_bug.cgi?id=218881
> Could you please have a look at it 
> 
> I have performed a bisection and the culprit is this commit: Resume
> thermal zones asynchronously
> git bisect bad 5a5efdaffda5d23717d9117cf36cda9eafcf2fae
> # first bad commit: [5a5efdaffda5d23717d9117cf36cda9eafcf2fae] thermal:
> core: Resume thermal zones asynchronously
> 
> I have also verified it by compiling a kernel

Side note: not critical at all, but would have been good if you had
specified which kernel version you build.

> without this commit.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 5a5efdaffda5d23717d9117cf36cda9eafcf2
#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=218881
#regzbot title
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

