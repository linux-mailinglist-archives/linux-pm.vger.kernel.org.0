Return-Path: <linux-pm+bounces-32025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B80B1D152
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 05:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C700A5806D4
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 03:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139211C8633;
	Thu,  7 Aug 2025 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n0PDiEYy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2C3208;
	Thu,  7 Aug 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538606; cv=none; b=V4QSM22mmXlYItIAFLzo/CUCmGnI7SUU4OdI37qMG3INjz8VfSZ67prxRVV/Zk8TCu3vJUqsUNs+446bsb2TkW86yuK497nMGBBejXZoAOYh00/46T55wWnVA6oAlr1GY4RAr5r9NgwnbJp/8FEyPRKt9NBAucEdmDCdydCd3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538606; c=relaxed/simple;
	bh=Qxb85cl9U42rTmh7WcEeQ+bEsn1aS4qSVA/Py/fzCe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egkS14geoUjDUCAUnD795kxXpgqnGxyckyKpxX+DDPbvzdzJLi+QHWn+Im5o04u9SNZr61NIAhBcG8EIP5wb1565mucGzbQiIIy3Zu1Exp4bAtqeEESHzD5AZSx0xd4eqILNmM/Q114PHqRWT2fas6g4cXKcoYgKJsnv8HGp4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n0PDiEYy; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1754538459;
	bh=Qxb85cl9U42rTmh7WcEeQ+bEsn1aS4qSVA/Py/fzCe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=n0PDiEYyJ/1nQgrgGJotAA7DCdv7BhXtL0K1bCqfyhB/zo6UenqFYTuZyIfYp/NvI
	 ABpVpsjiDzT8nKFm31RQBGKtx3LgRMI5vFOaZQybrLGMbFelEPszSYJL7cbd4EL2nz
	 gUqn/Bn0aXrbj40gSMRyTp4WwErdaA1oibkxZwM8=
X-QQ-mid: zesmtpsz4t1754538422t76fa1b8b
X-QQ-Originating-IP: wWwqj91rJyGP9PREyFInh9BgpPLpCS0dxOxI0/X1WAQ=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 11:47:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8239364816034580918
EX-QQ-RecipientCnt: 10
Message-ID: <09CBAB1CC89DA3CA+31b5524d-2781-4f0b-b544-0a833eaf3c8e@uniontech.com>
Date: Thu, 7 Aug 2025 11:47:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: repair mangled powercap comment
To: Shuah Khan <skhan@linuxfoundation.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wangyuli@uniontech.com, Guanwentao@uniontech.com, Zhanjun@uniontech.com
References: <20250806-mangled_cpupower-v1-1-1a559130326b@uniontech.com>
 <b89a0377-2a1c-418f-a897-966cf1cd4789@linuxfoundation.org>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <b89a0377-2a1c-418f-a897-966cf1cd4789@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MUhbxDHfRDzV1VkF9mDlPp6+zxR0kSsvESZLMdJ/dzMgbLG2bzt4k2/R
	Z882SbjZP45Wi6pzwAyEc8DJvWB8XW3zw284d7aAN646wOnldPkKFzl1xEiA0dlEXYWCLYJ
	MrXto7PYgOkPKjD0Lb5FWYqSaTrKgoomHAGtkBw837KBLkAfrkLGlw9Xy/tPWnVfOde0T0w
	+McrFPGImIz3eUcj+ssBrOi1/I92f+WSysYssbVzikNMNU4rPlQvq3ocane2FOuSkxT+jyY
	MbNFF/RODJfxYcu4p5NhyfWehteJ3bhPxJANRitnPz9jMwYthnqNYnDIuhe4MTYRTsYn0Fs
	8ZfTPZF1iW/o1EBKyLRSzyWUsTa2svYvXBNhrOM+u5UQ0ii6r6DpE76e2iw422p59hN9lCj
	e0870Txn8pyLWZGet7j1HJ+FqiHUZYqpsefft3U7+TK+nSCrxrgc2x3sXi4Rj1GDKCNK5SA
	ee4A+jVqRxozdbmsOPyKFUDzCZS5JxdIr1gVPCRKu3Mn1uWR03dU1ayEQDogi36qrzOK/YS
	G/5nlXxgv27sOhdZVJfBsH3lTMpN6yXU2HVxj0Q5Y0ytIHgRasLrdJRzDjWpIa9mljVGIjU
	jTDdoHS1Okmo3Sxb7v+7+4Q6KCJurwsby/uJ424VRCJrD2VjPUwyE1s7hYO3V8kpLOyw3Eh
	3PZFJEenEGDRk/2exI76AJWRN4zWs6Hau9UjuITAHIofsBr82HRqlLznGkfv8W+8Jj9GTna
	EcVYELLVRFm3vWkXKPJ893QwF7yodl5+BsRyC2tDDBJkp9pzduEinZ+HkXux8lBSkUVT9o6
	2wLljIdWRx0N9Hq79nkO6plFy2iyp7chOS2s4TSZZZ9+M5guJ9uFl9WoOoUjXWMnw2xVBhT
	9q4n8wg6RcIvLrEeBNJUBBQpLKNTjZ0K0J0MFk1gDoaWKcWgnh6NfiTiJ87cfCrTxw1mSMD
	h7v6UAangcXWoRLrX0i0Iu8V73MEiGkLWnxmJBaMOD5ngrCYyiptsveY5HObqJ1iRGV+uRS
	YN+KIpelGTgj/fFDM8T3dyFPzA4w7OreZa3kt1u1/aQL1G4KoOmRuD3yPJ4IU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On 07/08/2025 07.37, Shuah Khan wrote:
> On 8/6/25 01:08, Cryolitia PukNgae via B4 Relay wrote:
>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>> The current comment exhibits clear patch application artifacts:
>> 1. A stray '-' prefix indicating failed line removal
>> 2. Broken sentence structure from improper context patching
>>
>> What appears to be version control residue has persisted since its
>> initial introduction and through the 2022 kernel submission[1]. While
>> my archaeological efforts only trace back to the 2017 openSUSE patch[2],
>> the corrupted syntax suggests even older origins that remain elusive -
>> perhaps maintainers with longer institutional memory could shed light
>> on its provenance.
>>
>> Restore grammatical sanity by:
>> - Removing the redundant second line with its leading '-'
>> - Preserving only the primary statement about RAPL hardcoding
>> - Eliminating the fragmented "should show up" clause
>>
>> The result reflects reality without speculative future-proofing.
>>
>> 1. https://lore.kernel.org/all/20221123111810.16017-2-trenn@suse.de/
>> 2. https://build.opensuse.org/request/show/535512
>
> Lots of information for a simple comment spacing change.

The critical issue is the leading '-' in the comment, not just spacing. This is almost certainly a patch application artifact - likely from a more earlier source than the 2017 openSUSE patch.

> What are we fixing here? What happens if we don't fix it?

Nothing happens. The kernel will run as usual, but cleaner than leaving version control artifacts confusing future readers.

>
> thanks,
> -- Shuah
>

