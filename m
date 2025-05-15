Return-Path: <linux-pm+bounces-27172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10051AB7D96
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD67A862A41
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964EA288C80;
	Thu, 15 May 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sYw2JwaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F1280A57
	for <linux-pm@vger.kernel.org>; Thu, 15 May 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289576; cv=none; b=PXm8sZFG1SA566W97hcktPaFUYKNrnhep2BkMRWjdg/wNlRsOV+1AseLtwWhaLfEodA6uppGLg0iV2pA+TFEMeDsLpKx/tpd7EbU+S5HT+LayXBApdlNZAAV9Ug+CeQchefL5FluSgiGtT0Q3dJhWWUqUeHtCIGUoUR3U6TevBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289576; c=relaxed/simple;
	bh=nV8LNEHzNw4XM/C8Ve7z6p3b3ZFApm3ugvilKIoC1wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7TITD3K/rjiUOEQChAliGLc5oAB5NxmXT++8IGRaaYB88lbK5rvpV4mCHmRA80gJjfCn8camvM++cAmZtSpw6cQU6zE0D5kC7GhFRmFyMccb+/MXPL1ra583k+5GwZIl/YG76LzXs2sTCM86J/kHdzgMjX+5BimyTJEVGavCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sYw2JwaZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ACAEfF2QFSc6szu+oHQZGDcdynjEdtwuIa2X/ehdwYM=; t=1747289574;
	x=1747721574; b=sYw2JwaZCCrvVn1FQEdgcunXsIZ+mnoXeCI2n0Ixb97/+z6yojvrPX2oC4loh
	5QKvkbm3Zu8aaCJdCQedsUXHJoXGjy2nMcO6MF0Tn+A80RJzBaTJ53yQE80y8/f5GXYkfhVY+PkB0
	GOr1uDYlQRGZaf2mrsAit0May3nqO/MFkSGj3WizPC0NErT8h3/7ilN0YBIKqJJrLiBm5T/TO04O7
	C7EBIHNAykjIHmlG5eYXJgQa+X8douqZQjWM0hUNMotTis/HxAqcq1n/jJaifhMVREMXx/ixNR7J7
	EwIxqWroKTdaqZgoaZckRSe1dXsq7zoIF8lA+qbLxCkv/RvvCg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uFRpr-002yNF-0V;
	Thu, 15 May 2025 08:12:51 +0200
Message-ID: <260b6d79-ab61-43b7-a0eb-813e257bc028@leemhuis.info>
Date: Thu, 15 May 2025 08:12:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
To: Francesco Poli <invernomuto@paranoici.org>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
 <16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>
 <20250514222329.2db4ac81fccd10661d763ee4@paranoici.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250514222329.2db4ac81fccd10661d763ee4@paranoici.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1747289574;e3677f5b;
X-HE-SMSGID: 1uFRpr-002yNF-0V

On 14.05.25 22:23, Francesco Poli wrote:
> On Wed, 14 May 2025 14:41:35 +0200 Thorsten Leemhuis wrote:
>> Sadly with those fixes in I noticed another issue I missed earlier. One
>> from the "small differences between different Linux distributions that
>> make all our lives hard". :-/
>
> OK, the fix is simple: all other distros should be more similar to
> Debian!   ;-)
> 
> ...just kidding, of course!   :p

:-D

>> On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
> [...]
>>> +	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
>>
>> That last line to the best of my knowledge is wrong on distributions
>> like Fedora, where ${libdir} expands to /usr/lib64/ -- which is the
>> right path for libraries, but the wrong one for systemd units, as they
>> are always stored in /usr/lib/systemd/system (at least on Fedora). Not
>> sure what the right fix it, it might be something like defining
>>
>> unitdir ?= /usr/lib/systemd/system
>>
>> earlier in the Makefile and then using it in the last quoted line above.
> 
> This could be the right fix, I think.
> And it would improve the flexibility of the Makefile, as well.
> 
> If nobody raises objections, I will prepare another patch to address
> this issue.

Thx!

FWIW, after sending my mail my brain worked out that there is another
problem. One that was there before your patches. One someone here might
be interested to address. That

libdir ?=       /usr/lib

in tools/power/cpupower/Makefile will obviously do the wrong thing on
distros that use /usr/lib64/ for 64bit libs (like Fedora and iirc
openSUSE, too -- and all their derivatives of course). From a quick look
other Makefiles we ship handle that fine by default, as during a quick
grep I spotted code to handle the right lib/lib64 placement in Makefiles
like tools/lib/bpf/Makefile, tools/net/ynl/Makefile, or
tools/lib/perf/Makefile.

Ciao, Thorsten

