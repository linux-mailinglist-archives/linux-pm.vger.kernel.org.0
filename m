Return-Path: <linux-pm+bounces-27464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B45ABFB19
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294657A8552
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3B22B8D2;
	Wed, 21 May 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd/Nx5c5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEB22B5B8;
	Wed, 21 May 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844568; cv=none; b=B1p7TuLxsOxdqj0XEeRCD5AV0FY51UUGhItvoPbakoTCMb6MgvmgIgtGetiWcMrzMDelDJ7U5OoazvYwORneSkRVTCKq/0AUGqAMOAee2Hb97RA6I5mLZ7mDPAUCXVtOut9dQC2m+jNjctNlNgHm59zYtFyVljjz8lLRyLhu0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844568; c=relaxed/simple;
	bh=7QyBpzaFWmfvqCY8x1bE06bfccfv/HwSnrjxeEw9fWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AY4Zkle/lqhI1osRJ3LQmAOJcg/r/t3M7MIGD7wJQm/sYHlFNCPAv6sOHLYPE0vrG+4PG5jrYOnzT7Zfw8URs2eDSrn1eeH2tXIwYdofVOw672FzIk2oXtHLOj4Gws3khSsAX8+gEaJPNYoH/uv/KEStItFTp9Mk5K2BdpFLB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd/Nx5c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A42C4CEE7;
	Wed, 21 May 2025 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747844567;
	bh=7QyBpzaFWmfvqCY8x1bE06bfccfv/HwSnrjxeEw9fWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wd/Nx5c5ecu+zQ7VBykECOW6F8q+J7zmuQOSzSszSC9lk7rFLKXYcFkYL0znIlDHv
	 0VtQvGHysNqcdmbPwTjZgrg9RKW9YBBLI6LZM74tuh6eBqgCbrJhdhzCUlNSWZfaz6
	 9lqIWkbe8NO0BqWge44VgDu+cnVRvaoCC9pV8/QkwLDwlcwx/tkiu1Uw2lLVqSKSz7
	 DdYOJR8jSM2EfkAr5UjSBPM234adA9rvQfvqJs0ATPVUw+i7+2R7/9zQhQPw8A9Ayy
	 +/IzYWLOGk4AxSvlTuoCLpn38ByKlgg3Uh0hmfLNC2RV9ThbAuWQPUQA7/ySV1IvtV
	 cbOEPmXjPgQQA==
Message-ID: <a227bc1b-60df-4c0c-9f0f-ba89c96b78a7@kernel.org>
Date: Wed, 21 May 2025 18:22:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] dt-bindings: mfd: add pf1550
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-imx@nxp.com, linux-input@vger.kernel.org,
 Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
 Robin Gong <b38343@freescale.com>, Enric Balletbo Serra
 <eballetbo@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <8be1626f970c9fab8b50ae9ad45e0ddd88fa36bf.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <31542315-5ea1-4849-b2f9-686cabce914a@kernel.org> <aC38a4hbxPqsUpXS@fedora>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aC38a4hbxPqsUpXS@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 18:16, Samuel Kayode wrote:
> On Sat, May 17, 2025 at 01:16:38PM +0200, Krzysztof Kozlowski wrote:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  regulators:
>>> +    $ref: /schemas/regulator/pf1550.yaml
>>> +
>>> +  charger:
>>> +    $ref: /schemas/power/supply/pf1550_charger.yaml
>>> +
>>> +  onkey:
>>> +    $ref: /schemas/input/pf1550_onkey.yaml
>>
>> This makes merging via separate trees not possible...
>>
>> Just fold everything here, drop compatibles and then put binding in the
>> regulator. Unless children are re-usable which would justify
>> compatibles, but then please provide arguments for that.
> 
> Yes, compatibles are not needed for the children. For adding binding to the
> regulator, did you mean for all children: charger and onkey included? So,
> replacing the separate yaml for all children with bindings in the mfd yaml?

Up to you. Onkey looks small so could be folded for sure, but other
bindings are not big either, so I would personally fold everything.
Otherwise you will need to be sure MFD is not applied before they reach
mainline.

Due to lack of testing I did not review charger patch, but just after
quick glance I see already that you miss power supply ref, thus it seems
you duplicate some of the existing properties from monitored-battery.

Best regards,
Krzysztof

