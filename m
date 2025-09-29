Return-Path: <linux-pm+bounces-35532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C759EBA8230
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 08:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8646C1C0568
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 06:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109A29D270;
	Mon, 29 Sep 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="U1V3e/cp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DF256C87;
	Mon, 29 Sep 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127726; cv=none; b=fx3NxAtHjh4aIHJ3EZP3xwKweqjtqO25VvQVTwyyhHLkf+45Je3z4AOJhEkCwY8kFcSxTG8g3y1uQSynPBoeLcuQWJcl7m1MKYIaEma2vMAZs65vN7o8NBXqV2QFi6nK4vmPyYHCXsYhTKtRut625o+EJbujyBPZP7QzDr6sl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127726; c=relaxed/simple;
	bh=3BDlhAYjKpAwNf4nXL+xwodfJ4mfUZA1oxHiXd4vkoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTVMCnCt7mePPhAX2UiYHgbVHGgmnrd7+8/K9G/yAD/rFvZClnYieLVfgQrzoZRJZbwkIwte9DqWk2g2v5ObiDEoD6s6gTsatLIjZJ/p/rSq0b04I/ddxz9AtWEJn57Rl1E6IdcRUqAWkh9eUkZtXN50a9+9j0KSFl84wDxXHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=U1V3e/cp; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759127718;
	bh=ejimwnI9aX/m1BdqmcNn5j7nwrGn30aTITlrZgI0KGk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=U1V3e/cpRooeSNyGBHA8H9bLmiyzPvwRGe/ym5gTinSrwZslozpTPclhf3bNF8/1z
	 bamLM5/XgRyAcuZzK0GyFeJBAHl9pcveeGVm8enuDUTTQ6sYjC3D2h1ZMvxeWVbGGz
	 7FOMow6QNODalfyNieeoB09+4THTVZaZ7y7IljsI=
X-QQ-mid: zesmtpgz8t1759127713tc7836ab9
X-QQ-Originating-IP: NwVyzrEDCHyZaDavr4gvamMM7hZdIJSffBPvgKhI67s=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Sep 2025 14:35:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9334752308087901994
EX-QQ-RecipientCnt: 13
Date: Mon, 29 Sep 2025 14:35:11 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <BC3683F224622068+aNoon0so2erXE5I2@kernel.org>
References: <20250927220824.1267318-1-aurelien@aurel32.net>
 <20250927220824.1267318-2-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927220824.1267318-2-aurelien@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MNbA5mkmBXEJBIKhaJOpC3fZmZ05lea9ZhrDtPenZJUApDfifsLePWu1
	9Wljha/p41ZjRLHG/ipRbmpxYgf63TICPtS2nO7IUn4x/Gj1tcXW/iiSCH/YRWTCwfiPUns
	EpW97Gz8akDTBlzgMTPlrnrG/qR8RRqIF9GLSBJej6t+tI0PfRKwqz8LVqyHtR7TKR4ogAO
	3rdJ6c3xKBRZVkAxhRS9KqFdzcqxsD6Z3eQT+eiFPrAW+2s3L9l+NdyxQAJ0Ud6zeacdRO+
	PaJboQpVc4rUI3IfGWttCTCFITjzrxponNzEyByMKxSLDNlFMYhwvqX+KmJ75JHZ6vITIaw
	FYeT2VYQdM5LZ7l0XGrISzW6nrcO9FQsaIwqiYL4CiVv4gfa35ywoVYiTqejE672mbpy3K9
	V+F6ztzeNbOvainFC7vJSf8pA1SQEKOvU4byMMcWO74oi8VyadPHzLe3Xg3J7Oi/B37LV1R
	IkQ71ha/S2i5TXSa6VBgA7e49zN/Whdff2JWz1hSrpVB7LY/RY2Iu1VywtAGE0jd62zyRyT
	Q7ygGl4luuqP4kwa48Jl79j4M+2dqfJSmPLLmxRpxV9cTlNNc4EMOuFdVH4L/eUrV8aPX2B
	IaEFpAoF1mbxtEmgK8wO+WXQcNPlC21z4uRoQVGW3egxdzfiietZXf8TEsQhe/SMuaWHBEh
	Jq1dTQz0MOFJg+zjaIkW7jvSaN1b3bbt9qKhXhqwtHWeO1gH0aeBxAPsrRYqI4e5rRVtdad
	Er6ua+RIENZuMK63Ngp1ffUXBGvan4X1lCN96RlFewoKsE5G2gbOTZS7YrZOVAhIGoQOKpJ
	MMWJ8AxBpuHmlkWgaZ8MaMIKAaOt0zqaHefYjjrglVdtc+1MmaqnMFH5RINEdM3VXZSkSA0
	WRQAnzLB2g8r4H/DSl1achHJtzDAsyCe9ENqnUVD7wiZXUdgmWPo3tRauvFnyN9u3iz/GE3
	NRPHsxXs/LpeajVJm331RgTLGPCOYdsDKWLK+GrmZnjzw//S2nOxtWpA4+cvLXf+cKnx677
	PIBaMOGdol0uxycKGKqodmYPla04HFci7KPzpgCYrMAWPJt4we
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Sun, Sep 28, 2025 at 12:07:40AM +0200, Aurelien Jarno wrote:
> This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> chip, which is commonly paired with the SpacemiT K1 SoC.
> 
> The SpacemiT P1 support is implemented as a MFD driver, so the access is
> done directly through the regmap interface. Reboot or poweroff is
> triggered by setting a specific bit in a control register, which is
> automatically cleared by the hardware afterwards.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Thanks.

Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

