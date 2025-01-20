Return-Path: <linux-pm+bounces-20686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF91A16B86
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5653188595D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711B1DF24A;
	Mon, 20 Jan 2025 11:27:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47EC1DEFD4;
	Mon, 20 Jan 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372439; cv=none; b=brjHOhTfdat0u9zSAxhq+Y1YQJbhE4HIv41Dd+myAFU7pYW3xA6LWVEJ3Whu4kBUKWGC6CZr9nj8w1RbLec/cTd1WsXExb9Ru0U1exdNoZuYDkLeVU7wpp3530Sn9FyCihHncaVvY+pCPy9lFvM8ELQid8wmbxE2p+5RJER5G+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372439; c=relaxed/simple;
	bh=IqkvgTzrFXT6ISpRZMlA38AcY0OHfWde00hyQuW7caA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7ndPLWK0lL+t/KzrvmtDFjLnCzNRWRJRDjX6aZRaApgertiicVPi7JUMLaDhM/Oo0kPv0022e5QSBcHkafTRQTEqnIDGVCGbqxFrTf+ODyZ0ZJ1xDwWYuDDDSx0aqCz0xpOidnxjkFfqaYEzS7CQtUjxvPFCiebpb1Jq3NzoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 314B11063;
	Mon, 20 Jan 2025 03:27:44 -0800 (PST)
Received: from [192.168.3.143] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF3643F740;
	Mon, 20 Jan 2025 03:27:14 -0800 (PST)
Message-ID: <cdc955dd-04cb-483a-b074-739532a675b0@arm.com>
Date: Mon, 20 Jan 2025 11:27:13 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] cpuidle: teo: Simplify counting events used for
 tick management
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <1987985.PYKUYFuaPT@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1987985.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the tick_hits metric with a new tick_intercepts one that can be
> used directly when deciding whether or not to stop the scheduler tick
> and update the governor functional description accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


