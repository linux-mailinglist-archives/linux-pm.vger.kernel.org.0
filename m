Return-Path: <linux-pm+bounces-18130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D99D98A6
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 14:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C65D282F67
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4681D47AF;
	Tue, 26 Nov 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S+iwmXm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96008BEA;
	Tue, 26 Nov 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628251; cv=none; b=bsvobb5RvLEKuuoAjw64qveGxCpTfvvZ9O3AvMw4DiEmfxZKK6t9vAWU9lX+5kS4Mfn2Y2E3I+tZkIjGg07BcsKFy9KE4cRQQc/xbTYQ9li+H6XaccsyMv1IbBIVaHwDO/Z4+x55bLhsnnci8X5lD9U8ZpO9iFxv1VWCfN9A4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628251; c=relaxed/simple;
	bh=feL856Z/U/ZJKcQL9qTcJgDYB4dVhf8sRnNbDu/43A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyWeo9QetjJdPp1geR7Ot58mQPEZizXbmY9KufwSOsRjATZcPF8qrpgdKlT2Bcxbxxgh5jTYp04a0PZfE55kuTzeWAZmNEEX0I1kciNv2f0kEEH71oKjmhB8RTaFCJJSJzV1/HsfaAgHx8ErkbrgBwBNEXYvXAkaAICb7+Lk5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S+iwmXm2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732628247;
	bh=feL856Z/U/ZJKcQL9qTcJgDYB4dVhf8sRnNbDu/43A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+iwmXm2zgbLIiuraQyUO/tZ2d5bScahmmRI2x6Q5US+CxTwuR/hKnMoXa4kN87hw
	 P9JjVeOSQ72XUjReluFbAJIvK4RYuakk8sb7zEj6/sihkEkdcgpFsgvwgXOhubqm1u
	 SgXK2zYPwB4PiJs0dzYeDYp4N7LNpYYl3IiAJfCpgNxEHtbwTucngyeL7LZbswNUXc
	 DdacJtkmfV7WU36E5NIWGwaaChCxTcmaIuCN/dkHzh9MkvygQ9XY7el8RW9fnZwON7
	 BmWoTq3dxg4IqsWWLKk62bFgdHkKoUkA4yEdLHx/a9MWSyh6/+mQTq7muh7Vtj+pOK
	 YqIIt1G/2+lRw==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 72C1D17E3686;
	Tue, 26 Nov 2024 14:37:25 +0100 (CET)
Date: Tue, 26 Nov 2024 08:37:23 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
Message-ID: <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
 <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com>

On Tue, Nov 26, 2024 at 04:00:42PM +0800, Hsin-Te Yuan wrote:
> On Tue, Nov 26, 2024 at 5:21 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > When configured in filtered mode, the LVTS thermal controller will
> > monitor the temperature from the sensors and trigger an interrupt once a
> > thermal threshold is crossed.
> >
> > Currently this is true even during suspend and resume. The problem with
> > that is that when enabling the internal clock of the LVTS controller in
> > lvts_ctrl_set_enable() during resume, the temperature reading can glitch
> > and appear much higher than the real one, resulting in a spurious
> > interrupt getting generated.
> >
> This sounds weird to me. On my end, the symptom is that the device
> sometimes cannot suspend.
> To be more precise, `echo mem > /sys/power/state` returns almost
> immediately. I think the irq is more
> likely to be triggered during suspension.

Hi Hsin-Te,

please also check the first paragraph of the cover letter, and patch 2, that
should clarify it. But anyway, I can explain it here too:

The issue you observed is caused by two things combined:
* When returning from resume with filtered mode enabled, the sensor temperature
  reading can glitch, appearing much higher. (fixed by this patch)
* Since the Stage 3 threshold is enabled and configured to take the maximum
  reading from the sensors, it will be triggered by that glitch and bring the
  system into a state where it can no longer suspend, it will just resume right
  away. (fixed by patch 2)

So currently, every so often, during resume both these things will happen, and
any future suspend will resume right away. That's why this was never observed by
me when testing a single suspend/resume. It only breaks on resume, and only
affects future suspends, so you need to test multiple suspend/resumes on the
same run to observe this issue.

And also since both things are needed to cause this issue, if you apply only
patch 1 or only patch 2, it will already fix the issue.

Hope this clarifies it.

Thanks,
Nícolas

