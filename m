Return-Path: <linux-pm+bounces-13168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26815964643
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 15:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94AB282DD1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52871ABEA8;
	Thu, 29 Aug 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qgrwq2c9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j//U24tI"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F774197556;
	Thu, 29 Aug 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937460; cv=none; b=HZ0gcgiUJCvqV78zB8z+bMhNisgXZMzt7XfXtCQiE3TnMhijIwiAjbzXpb+Huk+E8v7ygGlYKYj5rOy1600wrR12J1h/zlbvDpshciVrXL+yirfYj1hgbJp3g+Bbq25TfgUEjIavaCPLFfr3ly51feccKjVltG+WxlUFCGBCMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937460; c=relaxed/simple;
	bh=mJUfGvnKfFlfYGBHRUQNB0hYyo1uxmZU2xj4XUEsfpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBZadvDXqrx2fRvYVCbYlRzPxoJC0P+mOjSizibU7QlCgy8FF4eIqVDTuOdLxD4um309URbaYcfUBM/HICqUTOpPe0KJph0pQLr7Z6BFthWY0H1vPvESXXV1ZfywvV/V/xhsmhEDpxNsZoht/tBenxDr7TGxdHbjdJ+NXKnfAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qgrwq2c9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j//U24tI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724937457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=youFcPf87GqwsFGdI3PQ8XPzwTZN5iwwAfKfN2vKR4U=;
	b=Qgrwq2c9q4LNAMc5RqPXshTZgIHMNDcJJU/4pLIJr8BTNH/Ipw5qRiXSy3mdnAAfwSE+B4
	BZmC/hZv1Socip+Jx3qfRQrYPGPZbAj3jw1vDIuva20w2sSWXW5KJewV5AnNegq9WvrY4b
	3O0zDj/i8BjbcgO3Ool3cFNlWqC0dZYVvP1GwlTo1kfB0uCZL9JRu0jLHXIYEEu5VfCjir
	ourg+oU7ZYgMpN6Cnu4Bx6m/k7CYQTG9ADZDmZPNOj0Jo0HvKkU/gcWLPZTgNwxzvMNyP9
	/0EtyItUXzVf1aFMEyWOXOXCSsq3Qd2s3wDgze/BGucjUjiuSS+rmo37xsvh0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724937457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=youFcPf87GqwsFGdI3PQ8XPzwTZN5iwwAfKfN2vKR4U=;
	b=j//U24tIqkO/Au/Dzblw+G1ghH5gA/RjwnGzD+tFBR3LirNK/M3GMvTroI+YKQXUTXWC7D
	0pXD/t8kj75YvRAA==
To: Yangtao Li <frank.li@vivo.com>, rafael@kernel.org
Cc: Jonathan.Cameron@huawei.com, amitk@kernel.org, anarsoul@gmail.com,
 angelogioacchino.delregno@collabora.com, daniel.lezcano@linaro.org,
 frank.li@vivo.com, jernej.skrabec@gmail.com, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
 rui.zhang@intel.com, samuel@sholland.org, tiny.windzz@gmail.com,
 u.kleine-koenig@pengutronix.de, wens@csie.org
Subject: Re: [PATCH v5 02/22] thermal/drivers/sun8i: convert to use
 devm_request*_irq_probe()
In-Reply-To: <20240829032145.2851567-1-frank.li@vivo.com>
References: <CAJZ5v0iB5arngPxxduafyZ+hbxqTRLXm_5iwNoEcQcqVyCdCYw@mail.gmail.com>
 <20240829032145.2851567-1-frank.li@vivo.com>
Date: Thu, 29 Aug 2024 15:17:37 +0200
Message-ID: <87ttf3a2oe.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 28 2024 at 21:21, Yangtao Li wrote:
>> It is not clear to me what the purpose of sending these patches is.
>> 
>> Because the devm_request_threaded_irq_probe() definition is not there 
>> in the current -rc kernels AFAICS, it looks like they are sent in 
>> order to collect tags from people.  If so, there should be a cover 
>> letter making that clear.
>> 
>> As it stands, it is also unclear how you want them to be merged.
>> 
>> Moreover, sending the series without patch [01/22] to linux-pm has not 
>> been helpful.
>
> Could you please merge the entire series into the pm branch? 
> Also, do I need to send a new version?

There are review comments in this thread which you have to address, no?

Thanks,

        tglx

