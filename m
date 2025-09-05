Return-Path: <linux-pm+bounces-34033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CFB46663
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 00:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EBA44818
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0027FD4A;
	Fri,  5 Sep 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eCSH5kw8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328F25DB0D;
	Fri,  5 Sep 2025 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109645; cv=none; b=Ypc8hzJoKxFxcpif7dQeR9h4nCV7MQWiENjpYGgiYIpABpHOBKV5W5v8OZR2GDgwcfwP5PYsaw/PTx61bXy7qnHixqbBXBFfa0m2h/T5M2vvROwOGZKMDFrv0jyAu6ipwqYjCM7/GkJ43VJwkpdc4YaHHJaN/3J5bCQZGGReFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109645; c=relaxed/simple;
	bh=jCaKj3PMwoRDYdGQHGUNKiZrC2PINAiafW7/ulScedU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeJlfgMyBOnBUIuUo5Dw4F7DG34pY6xnbyr83hDeARQhXUqE5zUgX6mFrgE/LR3jr23lDKxwcNpQ797+5K2r6b6JVXGyu3HyE9mEixEyIPGJSKbMdffp3gjo10su13DcP5f2ELhkTmwWFUSjdY5PzCxtSIY+qlTZ41RRp+yEaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eCSH5kw8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2sZTWD8rWRNjtfXFfF5ulIWiPDJJEtcOzCD2ZWH2xAg=; b=eCSH5kw8TQchkwmRLEmkkgYr+z
	tCUQ+NAvDj0QHa/2hHFjXk9Xy+TdIu7k2X7r8KSOvNWKFkgTjZeaw53iPgI+ItoyFPz8EASpRAqn7
	GrBNVc+XwB+SKh+eoj6lZTxIoRkU/C+BHZDfV7gsrH5JPCxc2qezYFaccYKg7yKx6kXZOJtqFEtjz
	P06DoUZBylFnt9ZzDxAqudKYxaTzvBjfDDSz9Uo/V0+QTBQFXILAukcZRC4dniX8Sq08b6KabjMCL
	2r5K+nPZKS6eyVxTjRetw+0ySLFs7iXBz5P27CJpaYnBrFsuzVa7018YGe28Wlgh8cP7e3bUaZ3ch
	Bf9g8gog==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uueU4-00000004thW-01dp;
	Fri, 05 Sep 2025 22:00:40 +0000
Message-ID: <491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org>
Date: Fri, 5 Sep 2025 15:00:38 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek
 <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/25 2:02 AM, Jani Nikula wrote:
> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
>> Provide some basic comments about the system_states and what they imply.
>> Also convert the comments to kernel-doc format.
>>
>> However, kernel-doc does not support kernel-doc notation on extern
>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
>> I can use (insert) it into a Documentation (.rst) file and have it
>> look decent.
> 
> The simple workaround is to separate the enum type and the variable:
> 
> /**
>  * kernel-doc for the enum
>  */
> enum system_states {
> 	...
> };
> 
> /**
>  * kernel-doc for the variable
>  */
> extern enum system_states system_state;

Duh. Beautiful. Thanks.

@Andrew, please drop the v4 patch. I'll make another.

-- 
~Randy


