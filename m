Return-Path: <linux-pm+bounces-22527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B01A3D0C4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 06:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8DA3B9201
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419C15CD52;
	Thu, 20 Feb 2025 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lyqQEu99"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B0A926;
	Thu, 20 Feb 2025 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029314; cv=none; b=O59jnOZyLWQ9Xbsx9J4MoMGJbckjYG3GhgtagNHOIUTbtA5Zp1D/ak6pRmIzclyJoNSkpR8F+LvOen5+jkZC8Vg99WmUjPUbBueRAkVdoJGAyYTOTuKSbITJzdVH12fohdjz88X2wyYu8Bc17kpYbF0W1AnIsc1adZOnvtTO++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029314; c=relaxed/simple;
	bh=PxBUNi7p6iDDkHAY+V65ove/V7/T8JvwpzcumV7Pkf0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DP5WV9VB1OYln1woMEhJiawD5kwQ58AG89itPIEqpWVGeNARX3hm34ZIgArQKCRXVYgEBhnr2cz/qAQqHPuwlzgy5IvnqDDAANw1eywHx0tivB/LaNa1oh4PY5XkO7iOItY8vmxHPNwFVWpI5ZkYx6VUvx0wXYHvknxjKtAtsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lyqQEu99; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740029310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8osLsKSgydSwhw4gROThJbyX6R2+o/ZDIgdC95qqlFk=;
	b=lyqQEu992K0fRqvzMMznMfHvJVxZIkARIAsYxvNOSLBpmuFAOOLYGM40lZFqE91f8jeGt5
	dYxW/14OwcULDLGcyv3qKv4JF/acKYOM3elq7XjDUeRzl5scbXtTs/CVqEdvriM4quqgoc
	xEe9CDjLsIGccr9rMg3cXQABTI6E9gnlvzy3uDIyCPL0uKEtCZ5tpqEwYa7buay0HXS1bh
	9N+HEP7PTvJ/4QpOLidlB4HtrnErluQWQ97+jHk4OM8ciA1gXT0Q7D4W6PSyQPojtfEyff
	FRHFemAaIJDtC2PFv5Xdg1mUT2QpoHhSIQs+Lgzl2BZkggHvHy4BFyq7LWYI4g==
Date: Thu, 20 Feb 2025 06:28:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, Shaohan Yao
 <shaohan.yao@rock-chips.com>, linux-pm@vger.kernel.org, Lukasz Luba
 <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, Zhang Rui
 <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal: rockchip: Support the rk3562 SoC in thermal
 driver
In-Reply-To: <7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org>
References: <20241224094015.3816301-1-kever.yang@rock-chips.com>
 <20241224094015.3816301-2-kever.yang@rock-chips.com>
 <7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org>
Message-ID: <b4ab86b56177a234f3738c477693e858@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Daniel,

On 2025-02-11 10:36, Daniel Lezcano wrote:
> On 24/12/2024 10:40, Kever Yang wrote:
>> From: Shaohan Yao <shaohan.yao@rock-chips.com>
>> 
>> There are one Temperature Sensor on rk3562, channel 0 is for chip.
> 
> A bit stingy in terms of description, no ?

[snip]

>> @@ -497,6 +509,45 @@ static const struct tsadc_table 
>> rk3399_code_table[] = {
>>   	{TSADCV3_DATA_MASK, 125000},
>>   };
>>   +static const struct tsadc_table rk3562_code_table[] = {
>> +	{0, -40000},
>> +	{1419, -40000},
>> +	{1428, -35000},
>> +	{1436, -30000},
>> +	{1445, -25000},
>> +	{1453, -20000},
>> +	{1462, -15000},
>> +	{1470, -10000},
>> +	{1479, -5000},
>> +	{1487, 0},
>> +	{1496, 5000},
>> +	{1504, 10000},
>> +	{1512, 15000},
>> +	{1521, 20000},
>> +	{1529, 25000},
>> +	{1538, 30000},
>> +	{1546, 35000},
>> +	{1555, 40000},
>> +	{1563, 45000},
>> +	{1572, 50000},
>> +	{1580, 55000},
>> +	{1589, 60000},
>> +	{1598, 65000},
>> +	{1606, 70000},
>> +	{1615, 75000},
>> +	{1623, 80000},
>> +	{1632, 85000},
>> +	{1640, 90000},
>> +	{1648, 95000},
>> +	{1657, 100000},
>> +	{1666, 105000},
>> +	{1674, 110000},
>> +	{1682, 115000},
>> +	{1691, 120000},
>> +	{1699, 125000},
>> +	{TSADCV2_DATA_MASK, 125000},
>> +};
> 
> May be it is time to optimize all these tables out of the memory 
> driver?
> 
> It is the 9th table introduced.

FWIW, I'm also not a big fan of these tables, and I always feel like
"meh" when I see them.  However, I'm also not a big fan of substituting
them with some kind of formulas, because the SoC TRMs specify exactly
these tables, with some additional notes that the values may change in
future SoC revisions.  In other words, these values may even change at
some point, at least in theory.

With all that in mind, FWIW, I'd rather see these conversion tables
included verbatim in the driver code, because such an approach reduces
the possibilities for some hard-to-spot errors, allows easy, direct
correlation with the TRMs, and should make possible changes to them
in the future easier.

