Return-Path: <linux-pm+bounces-8268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C198D2282
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B6286314
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3F1CFB6;
	Tue, 28 May 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="oxJuOQtP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0762563;
	Tue, 28 May 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917668; cv=none; b=lpp10KrvZUpLFWKeCWwUWJLjEY0HhBvyNhz5KtDEN0Zb6Bs+PIfpCy4Z59DaExG1L+lnzYrQV+y1bGHjrVZrgRweSxDsaxrzpmCt4o9jp6Oawy+RWtc/zCN/Su2eVSblcH5z6G6+mJFXdaboA7dGMfJoZH/aKln+HQbfsDv7W6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917668; c=relaxed/simple;
	bh=Jo4q+rtPtpqg8nO8+3pGwO34OAH8uHmnEy4GW8MT9us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ/rRdz1KfSjCr9QDmaRRTYvgch0BQUhFyLMRQQAYoOj1Vd/zPLblGDUUeMxeRlkdIZQMlDOA9HJmyL9Rnkz4r+XhWqMCra4a1ZBqPRxcd0fs1PxsPTrhvuG+pN2WaJlD0Y38SW4hkqzlLABpwJQ71uNr1Hfr1bRyjJW6WoAZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=oxJuOQtP; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90A6B280599;
	Tue, 28 May 2024 19:25:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1716917117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1m27YV+Npck5o3cnPSRggNl9DizV4QqsbBxedq/OX7g=;
	b=oxJuOQtP3DddR9rb03nGWWVzDKWL+KtZLYMn/g24eoSPt+zLXXbtGp1HFvbk2uJ+M/vqW/
	xY/5OAKSJT8/RhDPXkkl1nlPOrsmBCB5b+Tzcri3f9MN0inkJMq5i4y6mB3SGs7gwYJep0
	oUS1R7weJZlcTF0KDeNkHtLrDTQrZXheAYLg7FGAAt7M1/ocMW0nQi9d/JcB7yd1+5famC
	VTuK73AiiuIZVaJDgwHhhCAU9QcdkARXaSLyCDyMgwj5tda6UN4CpKOdRjrQEzunLmgyZh
	fI73bFCti5PyP0CaCy+q4M/RFtBLuzOGDVlXLsIfUl8V8h5NJ1UyCT5JYfaLCA==
Message-ID: <e14333bb-fa2c-4d14-a2d7-d29c19c18ea5@cachyos.org>
Date: Tue, 28 May 2024 19:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: Fix the inconsistency in max
 frequency units
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, rafael@kernel.org,
 ray.huang@amd.com, viresh.kumar@linaro.org, ananth.narayan@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Perry.Yuan@amd.com
References: <20240527051128.110091-1-Dhananjay.Ugwekar@amd.com>
 <929aec0d-690b-4277-90b0-d0b4adb437d3@amd.com>
 <ZlSqmYDaPNE8jybO@BLR-5CG11610CF.amd.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <ZlSqmYDaPNE8jybO@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

 > > > Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD 
P-State driver to support future processors")
 > > > Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
 > >
 > > Acked-by: Mario Limonciello <mario.limonciello@amd.com>
 >
 > Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


Tested-by: Peter Jung <ptr1337@cachyos.org>

Fixes also an introduced regression in amd-pstate=passive reporting 
wrong frequency values.

Also, see[1]

[1]https://github.com/CachyOS/linux-cachyos/issues/253#issuecomment-2135659124


