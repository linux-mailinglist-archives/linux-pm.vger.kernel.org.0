Return-Path: <linux-pm+bounces-37742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFE8C47379
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D73A3FE0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC211212578;
	Mon, 10 Nov 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VV+4JH1K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BM2IaOWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A9199935;
	Mon, 10 Nov 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785089; cv=none; b=Woa9FegSwXPncq9ZsFt+e98bVrNS9tSQFDJfB4+WU/NcLI8hR/4HdOih3o77y5CqugMXft1Sa/hXpTIkA7r6pVObZEBI4G3XgdLpRzyV6HTSiaUfnZQu7pV+lPpRhGOA8SJ3rGRT4zveYKM8RQeXDEudf21Z4/tEHfIk1YgU+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785089; c=relaxed/simple;
	bh=GptMQRmamfxGJO6Q9+2ObRdKXFaiQ8T7ahS6jh1zbLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnnukEQVzwXbb2UXusRF2Dp2Nn5AIFQzsBmnVUYBUvq84WE9/qFpWD+pyprdLACyYK/9pIzdc4c2Bkr/EGNB9emi9wZGpWfoXkIK15FIvqL6Jst8CMMzKCBMAYQOUUCOklgvC1fTVmBtZ2CJqKTFNKSxhIvWv9Q93lTPs/mBbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VV+4JH1K; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BM2IaOWu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d4sYB1pjtz9tqP;
	Mon, 10 Nov 2025 15:31:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762785086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4Ecn2xIE/9bgMNQjvLjfriQN7fZ/JS5vEyQ5W6UA7s=;
	b=VV+4JH1Kt5sFz3updBLPxh0+kUwQ1UFloN0NPs6epYFvg/ulWf3RVXaT6pjfAkkfbZBk/h
	7pOBSYP+Dyozb/GfQAD08nQNBEN7Ka4g0X46dEZHeUvLYkpiMLWxSJMRnC04XG362NFyGw
	ZwH8RbiU9jYAmazItq+kGtHS0PeKswVhu2DIRSndg78ULg0ae6rQP0sfvKygsNwIN49ofA
	4haBqsMdtqO2tTPwpPJ8fBGex3H9yZzaKhJBd2C+y/h1b3joZCcBjB5fSG21oNOzfT/V74
	bYf7bWOMtFewwEfOjvar1dWcE6KMbKPqAf8uWsae2SBfsPQkksOnxXjiPpCm7A==
Message-ID: <82659179-665c-4c64-bb83-e786285e0f79@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762785084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4Ecn2xIE/9bgMNQjvLjfriQN7fZ/JS5vEyQ5W6UA7s=;
	b=BM2IaOWu6pfKU/XTV8q/lwyuS+ILs+Ormnd0xOM75hvgbFRU1sRFk1H/jwMtaS6ULpd0Ul
	2O/N/8IdJyl0tHbWIcMYFYrgiy3HZY1IDPdh+taN6J500O+JYIklWuXKOvojQTTIasryeF
	nnYnV48Ua0rbQqr6WgpVLaLr40E165hyshe0rdFEDeRb8on+W4bRdqiDVu0wiOQkA3901H
	xUVhkb115H4qlwbuoF9mf75RFutp/BkBUPgqSKmCP0mbeEB9fEHn23j4XPVXxM0U2Kf5LD
	Z+1rgbl0k4EdynsOafR3EFvPjBOV4Ogoz8m1ce/SCbhoacKMDL95eM/GgNEQPA==
Date: Mon, 10 Nov 2025 15:31:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <20251015173303.GA607688@ragnatech.se>
 <48f394d9-69d4-449b-8478-f2f24b230e94@mailbox.org>
 <8f4e2705-6174-462d-9160-6723c28ea08a@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <8f4e2705-6174-462d-9160-6723c28ea08a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a14a86e9984ca172679
X-MBO-RS-META: cf1j7kfau7omsh886hfgn1iou3ix6qfp

On 11/10/25 12:54 PM, Daniel Lezcano wrote:

Hello Daniel,

> On 10/15/25 20:11, Marek Vasut wrote:
>> On 10/15/25 7:33 PM, Niklas Söderlund wrote:
>>
>> Hello Niklas,
>>
>>>> - *  R-Car Gen3 THS thermal sensor driver
>>>> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
>>>
>>> Super nit: I would write "Gen3, Gen4 and RZ/...". Compared to v1 you
>>> updated the commit message not the comment here. Not a big deal all the
>>> information is there.
>>
>> Like this, right ? I will include that in V3, thanks:
> 
> Did you send the V3 ? Not sure if I missed it or if you had no time to 
> send it yet
Thank you for the reminder, I sent a V3 now.

