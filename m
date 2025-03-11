Return-Path: <linux-pm+bounces-23863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D4A5CB17
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DE3189E72A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97825F987;
	Tue, 11 Mar 2025 16:47:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1925E83D
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711653; cv=none; b=U6m2qmiSHed/dTiCJHDLP3zLxOhWZPDCi5k8zBc+Qwy5AQoqk32L69eqIuPsqsH8D6z6TNeLDP9aYCcigSk2GacTXwEzk8FzKVYWA6VmqFnN4ixzkOWM0H8J57it5ojkixUbsr+peYmYJSnxFgYw3Ss7is7t0TmtDfAUpNKs91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711653; c=relaxed/simple;
	bh=wUTXcAHpwpmKsr+UxpX+ZI9sHFNA8VWAnkJrODG1d8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHZ6bTcYQX7bUlaHUvrXERk9PTYSSjY3EdAtWzdNcBHl714+YXWOkA3H63IyRWe0T8SlFkJj+mawOy92MM1Zmfp3D26hbGuna1w2aQDjyoY2y1ioNH2IIrK3/mqMO7c1HtLYCv13sxuPz2uJRvjk9d4XulgfccCyeLD4l0/iJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25498152B;
	Tue, 11 Mar 2025 09:47:41 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E3BD3F673;
	Tue, 11 Mar 2025 09:47:28 -0700 (PDT)
Message-ID: <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
Date: Tue, 11 Mar 2025 16:47:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TEO as default governor ?
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 16:31, Daniel Lezcano wrote:
> 
> Hi,
> 
> I think we can agree the teo governor is better then the menu governor.
> 
> Would it make sense to make the teo governor the default governor ?
> 
> 

Rafael's position seems to be quite conservative here.
Fact is menu is still the default on many systems.
Even worse, the really bad performance disadvantage when
using menu in an intercept-heavy workload has been fixed by Rafael :)
https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com/

FWIW I proposed this a while ago:
https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle@arm.com/



