Return-Path: <linux-pm+bounces-20546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16BA13B0E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1619162548
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E21DED42;
	Thu, 16 Jan 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DPMmvO8L"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B422A815;
	Thu, 16 Jan 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035114; cv=none; b=ZObpyKfSQAh/U57vnRcghADzylYrtoFtT/IgvUChxP+75Oazk484RgFe7Xl9rkjsrrHn+1rGk73L62GAuNko5ULcxy3EC3ylenyEYaHkITqqP1mIygtvrC7UinDrghH8xqKlBYiwTs8ZAy1hxG4SzIw8g1sCp6L3V1mpPWqb6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035114; c=relaxed/simple;
	bh=D07iJIxZgL4Eb284YnQCEptX34FdVpYWwiTTYDL2kgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IojsDUmtFbazdOmyBiVEmcvn1zVZrYL2YGG8ll8DUKkqtKhnSiDsr6dxO6JHLFmZ4hBHyMLdtkFqUID9GsHSGb/N8iQW3hIRzF6IN+uN6kybTV3Q96UuR3QZBun3b+dA8Yrqz40qKNVkOOGR12mvxZyjkYqCGy6Zm3C20ZztzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DPMmvO8L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737035109;
	bh=D07iJIxZgL4Eb284YnQCEptX34FdVpYWwiTTYDL2kgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPMmvO8LK5AIvAlhPQDFwCLUTfmnYXxtWxtXl6syBmjm0129bgMzy+GJzfd4Ohru4
	 mqdhf+8jbskUx98gV1rT07I1ZLh18oClUUvRw7AxEaezZF7B2T1hwExSghjXreXrZz
	 wZEtIvorszfExkenmmsJxfIaOLj6P75w3s8VaxUO+8qhkROQ3SAfkJfLBZjSTrV7Y+
	 K1mEo0jps2+hjioZp9uhb9I7Zm1uxegrLNWbWCQgJ24/7a30HeqL/+i+PO0LmmV+Up
	 xhcPSqEk9K8JGZKt/1NCHjZ5D5xEm+efrmf1aHY3o7uwGflY3OLMwf5shZtA6ySC4W
	 W08BLW+aWPU6A==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E24A917E0E48;
	Thu, 16 Jan 2025 14:45:03 +0100 (CET)
Date: Thu, 16 Jan 2025 10:45:01 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/5] thermal/drivers/mediatek/lvts: Disable low
 offset IRQ for minimum threshold
Message-ID: <22c4fc5a-2634-4e14-a659-1a2a6329c7b3@notapiano>
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-3-07a25200c7c6@collabora.com>
 <90dd8d93-5653-47f1-8435-f03502e4c0cc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90dd8d93-5653-47f1-8435-f03502e4c0cc@linaro.org>

On Tue, Jan 14, 2025 at 07:30:31PM +0100, Daniel Lezcano wrote:
> On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> > In order to get working interrupts, a low offset value needs to be
> > configured. The minimum value for it is 20 Celsius, which is what is
> > configured when there's no lower thermal trip (ie the thermal core
> > passes -INT_MAX as low trip temperature). However, when the temperature
> > gets that low and fluctuates around that value it causes an interrupt
> > storm.
> 
> Is it really about an irq storm or about having a temperature threshold set
> close to the ambiant temperature. So leading to unnecessary wakeups as there
> is need for mitigation ?

Yes, that's what I mean. The irq threshold gets configured to 20C, so whenever
the temperature drops below that value, the IRQ gets triggered. But this usually
does not happen just once, because from the thermal frameworks' perspective,
there's no thermal threshold configured for 20C, since that's done from the
driver, the framework thinks it's -INT_MAX, so the threshold doesn't get moved
after the trigger and it just ends up triggering hundreds or thousands of times
in a short span of time, hence why I say it's an interrupt storm.

> 
> > Prevent that interrupt storm by not enabling the low offset interrupt if
> > the low threshold is the minimum one.
> 
> The case where the high threshold is the INT_MAX should be handled too. The
> system may have configured a thermal zone without critical trip points, so
> setting the next upper threshold will program the register with INT_MAX. I
> guess it is an undefined behavior in this case, right ?

Ah, yes, I don't think I've tested that before... I'll test it and send a fix if
needed.

Thanks,
Nícolas

