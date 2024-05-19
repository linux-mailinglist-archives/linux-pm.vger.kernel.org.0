Return-Path: <linux-pm+bounces-7971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D28C937D
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 07:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913A9B20E10
	for <lists+linux-pm@lfdr.de>; Sun, 19 May 2024 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63266E554;
	Sun, 19 May 2024 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iyzWNVs3"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783F9450;
	Sun, 19 May 2024 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096771; cv=none; b=BrDYgMDAqPvwpASrwHwhxCi0Sf7gm/78b4eNXlSxw7arVtszkcwed+zKniK0EhIVmQdXJZb10kVOKTc8tk92mm8qs1fTuUH+NsFSs0PWaN48iYTdfdGaWqjp8A77plY8HKXkJ6v+8VnNb5JTJmvc1P9qFmfyZ3xrUxxsIuNZseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096771; c=relaxed/simple;
	bh=Xkll09NzcXRMEDvaUMAQDVObEDOYOIOCqOZFJSdiRRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENcfSXgu1lQP2Q59LRWwV7i2AIS4G/cD4XjT08MCvRHggfsx/X0xJsIXu47TOuI8LBs5o+FSv6YY9q3XKIXd4e7T7/h2Iryd++rM3W7/6H2U/kneCbjLHxLhXBCpkx4bWd2+ffvvOPPaOPpzyFygyArIDXfeG6NxUaMXwSphDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iyzWNVs3; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Xkll09NzcXRMEDvaUMAQDVObEDOYOIOCqOZFJSdiRRM=;
	t=1716096769; x=1716528769; b=iyzWNVs3/WRHnF5ipGL1O+iembIf6lYZM71+rTuV0PUqMR9
	ZCFCXTsGGthU2DT0JYuV8i9tjs3sRHhvOXMyHIQWjv7klZSdZtgboPPjnY1t2LZ76iVcuqzhxJyFq
	pwjn7vJY3oYfIFKKuSmQTtp+gjinTPwLZPghYA+4CKR9xukw40Vbw6kzD9JckV5wYE+PsAuXgnow+
	nrM0iXqnx3XFziCY33ZHa3nL2wQkQikfd4rqUdrRWfqSDdoNsUUeFvOMwdwMa/1OuvfYB+vLdd31g
	V8wHd3rh1jRL4qGH5zazZKW+qI5Z/J4ySh+oDXIUkUzJI/4eQxpPvVyaas3sq2Ow==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s8ZA6-0003gZ-7X; Sun, 19 May 2024 07:32:46 +0200
Message-ID: <7ed1e3ca-2160-4c52-a19e-8b5f2a90a0ff@leemhuis.info>
Date: Sun, 19 May 2024 07:32:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue
 which limit performance
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>
References: <20240508054703.3728337-1-perry.yuan@amd.com>
 <4212df0b-5797-42a8-9c64-3e03851293b5@t-8ch.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4212df0b-5797-42a8-9c64-3e03851293b5@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716096769;d0a3a4cb;
X-HE-SMSGID: 1s8ZA6-0003gZ-7X

On 19.05.24 00:07, Thomas Weißschuh wrote:

> Please backport the mainline commit
> bf202e654bfa ("cpufreq: amd-pstate: fix the highest frequency issue which limits performance")
> to the 6.9 stable series.
> [...]

FWIW, that commit already queued, as can be seen here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.9

Ciao, Thorsten

