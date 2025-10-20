Return-Path: <linux-pm+bounces-36520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADCDBF3BFF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 23:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C92918C460B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B508335093;
	Mon, 20 Oct 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cxUTcAXz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A127C178;
	Mon, 20 Oct 2025 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995670; cv=none; b=Ov9ndWH6NhXrH/BGaeueSfYT8XIHWGQgKjtmOecY8cIVPYUiglfN+lXxL+j+5Y+8eHWuqeXZhNtZ3BhwZg9NArsMfzoEoPibPj9RbMhxGluqUDqpqxbJMs/qodwva9YGObxClBsxOZQB3ttGjlCOcUu8Ppx52iwcJr0J18v8pc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995670; c=relaxed/simple;
	bh=FLDsd/G4GyfxuVprJh0alYchDBatoJzM3MNX/gk4yEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgFcqCSadmnng3ERT/0I4+pmUyEhR+tnSx34uKlqPjD2UHu5I1612ezbidR/0SIx2NDN3UZvNpsP0EwEfhIDOvbi96R98eqLqny+5Is+86KgAizyGmAHphBTdBbRP1w+6CD3fUIkV8NzUYWxmsDlT+43+WuSR5/8r8PJwKew3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cxUTcAXz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W6J2pwznhh8Vqti941FZTZaR3EDlojdqwXF6+Mptyt4=; b=cxUTcAXzmkKQfTEnIiicIHKqo7
	puSr9ND0l8NF2lBVUUgGLM9iSyQhji3rifYukbk6K5bI1Y9MQBXisZVSiPlhDc3jZagaQuA8qi+Uf
	rAJHr1OYMD6SvxvgvPzfRYzsR3E7uqNwD6MOTIp3ZQRsTOa2z0n5xbZHIFkwJxw+RiwLuCswvlh8J
	UgOGooaPTN2xNOfISGTWR+INL3eSvVoNoaiZze+YkM/P1TQ65kGO7g7xT52oowI2bAJ9dNzGgwXXI
	ggUPNTnZPm75RsElxS7vQbOCjFSINfu+FCS+qEfu8D15eCp2fm7WywXvpHHHYYBsODKq1lUn4bEH2
	+DPCLUbg==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vAxPj-00CGgj-M3; Mon, 20 Oct 2025 23:27:36 +0200
Message-ID: <59c0b135-918a-400c-95f0-a6fdf91cf833@igalia.com>
Date: Tue, 21 Oct 2025 06:27:28 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: EM: Remove an unused variable in
 em_notify_pd_deleted()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, len.brown@intel.com, pavel@kernel.org,
 christian.loehle@arm.com, tj@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251020084429.230322-1-changwoo@igalia.com>
 <CAJZ5v0ib0dXYiNsj8cP6jcGpdqer_ASzMo7RAKhDU7eh_cHAZw@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0ib0dXYiNsj8cP6jcGpdqer_ASzMo7RAKhDU7eh_cHAZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lukasz,

On 10/20/25 21:17, Rafael J. Wysocki wrote:
> On Mon, Oct 20, 2025 at 10:45 AM Changwoo Min <changwoo@igalia.com> wrote:
>>

[..]

> 
> Would you please fix the patches on top of which these fixes are needed?
> 

Sure, I will send the whole patchset (v6) with the two fixes in.

Regards,
Changwoo Min



