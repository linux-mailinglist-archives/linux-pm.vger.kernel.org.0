Return-Path: <linux-pm+bounces-18877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C59EA415
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10C1188209D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CBF13AF2;
	Tue, 10 Dec 2024 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRchwwsb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5312E4A;
	Tue, 10 Dec 2024 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792768; cv=none; b=umjVMa42jA0/qr9VJRd+KAGAltBawPXTElEqsG58mc69vReRmfMo4RUgYgeBdHfGHdTl0gqCIjPR5rIUiE39p9Ao4Z7kCYbsEzvAfSPpMcE4VHkVATt25NnbrQmFLq6WrehM9kZkIvHwZjF9XHMcIQB7nP9g26FRX1IOkjEdLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792768; c=relaxed/simple;
	bh=plFKYBbf8IJN7Ou4n4DVFDuPlHgmBZ2BLNtsxdyjdLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZ55AgJ7UGuIfPK6P0TnG8v1GpD5/hUDZIQc+UHo0RzciV7xQWdQP/yRi8t9f8rJwlCh7a4kx6BFxko+XCSDbbUTax4mxPWm/69cD4SjVCAJ8BEAXx8WBlU63nK66zHrUQa+FVw5rdlOwPuriLz4SZBIY0st+2QUzUsCosdKAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRchwwsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EDEC4CED1;
	Tue, 10 Dec 2024 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733792768;
	bh=plFKYBbf8IJN7Ou4n4DVFDuPlHgmBZ2BLNtsxdyjdLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FRchwwsbFi6o8bpQxl8ETvGB7KZQGjTTaLUjNmA10Jss7arfzLT6DVSG4eDLDqrZ6
	 MJ5b9aMozqC7Zf/j9zdcCrR03HR82ntEiZiiSmpZLrJTbitN4Z0GgZ55W8enEHoaDK
	 Z0iEdeWN40QeaHNtUFeJ93Wi6bVI5LBMk/BMCuyc+T44w7EJ9U+muACAgNcv3HOxla
	 SO6BXEkbyvVJMfQTazYbXgZmucg3Xcl27t8vOc/LxYbBN/V034k1VEia9ns5mjBu3u
	 UeQ923skEVi3LcjRKGonbIPmyYGZyvFLKU8tP16vkAdga6ARByhEE0fc3o1Tlymg4p
	 iqEbJ+/Bzljpg==
Message-ID: <c3e724b7-96e7-4e80-ab88-d91ca37786a3@kernel.org>
Date: Mon, 9 Dec 2024 19:06:04 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.13] Power Supply regression on bootup
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <93978193-1273-4954-893a-f27528ed1d0e@kernel.org>
 <zcee6jxypyq6uumftgu43rbqt2v6bwdvdu7nriw3iaschjaitu@gevwwgvwdbgj>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <zcee6jxypyq6uumftgu43rbqt2v6bwdvdu7nriw3iaschjaitu@gevwwgvwdbgj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/9/24 17:25, Sebastian Reichel wrote:
> Hello Mario,
> 
> On Mon, Dec 09, 2024 at 04:16:00PM -0600, Mario Limonciello wrote:
>> I have a laptop here that upgrading from 6.11 to 6.13-rc1/6.13-rc2
>> is causing a kernel panic at startup.
>>
>> I caught it with a crash kernel and it starts with what looks like a race
>> condition of some sort to me.  I didn't see something obvious on the list
>> about this so I figured I'd raise it now in case it jumps out to anyone
>> before I have any progress on a bisect.  I'll come back with more details as
>> I have them.
> 
> My guess is, that you ran into this:
> 
> https://lore.kernel.org/linux-usb/20241203200010.2821132-1-lucas.demarchi@intel.com/
> 
> Greetings,
> 
> -- Sebastian

Thanks, that looks spot on!  Sorry for the noise.

