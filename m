Return-Path: <linux-pm+bounces-12249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AE95297B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 08:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1681F21364
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20541791EB;
	Thu, 15 Aug 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ClIPBtss"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D069178CCA;
	Thu, 15 Aug 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704540; cv=none; b=G4DAcy5RKL5hsQgK9GwGwsAnaMxgDmThHMm8fDhg2CKcV0j/UBkvaAv4Q1puEYie4bdXjH4B2W7edssVGBzzlyVjE4ezlUUPBsUtY4ZWR9qjFgTWQSUZ/Xnw1eJjjdo+TFBsmaLESBMF5C4Bu9paMYVf0hdcyndxdzPTLtOJCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704540; c=relaxed/simple;
	bh=mWOaouGtbDKsYQdGv0jggBmrDBnJHD8xQ8HL5gUYJ+E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fWCBqZSOy/xNFnAyZwm4ADAsbrKcnOpYfI9xUSsw5SQ/7PvmansdmNDIsuQOf29Ikm4knjAB2ven7NlmgwnKjiW+fP3i/9i6TggHs6phVQLKFz3QwDjb4g/QjPfHqyAwPorfvfM0k6CqzpOngb/FNfdZriHtLc0WrudgsWwxSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ClIPBtss; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723704516; x=1724309316; i=markus.elfring@web.de;
	bh=mWOaouGtbDKsYQdGv0jggBmrDBnJHD8xQ8HL5gUYJ+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ClIPBtsspNiU++Q2niceSwX2d/fXTyqz088aFWoL32eCb5KQ1phquRlFDxiySpwx
	 01pCqbka/UPHlVwMZqjvX4OGoQbabSaSpYox5RfbbdiODT3oargUU0TE8q9ys1l6E
	 fJz9DEyCY9Gby8oUtsvfIRe9clLafIXdi2YqGkPi/O1/YHEB+s2HdaKluUsw+49iV
	 ZK+9SuFKlUSUHRh1HoWxus3ev3xUoEffBevfyqTbhWakv+pOdIQK7lPBvAMXpVRYh
	 r2A5wkqjcDXHcp5F0jDzXV7tR5qXcIw8J10kk9WhdcwecOwwtoH2uleVjJXexZ83O
	 35O1hTre0u4Z/oUpaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1sBnIa0EVk-010QtW; Thu, 15
 Aug 2024 08:48:36 +0200
Message-ID: <7309e626-214e-4623-b3dc-2e4e2f68b1e4@web.de>
Date: Thu, 15 Aug 2024 08:48:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y4LYm9M+cHdWv5CBLcVL1JI9ZqLYGEXS2CCmJQ2UUH9/pEx+lQq
 O9oHPY08kqK3EPyhG2ANIVolA7uef7tsdkuy5xJAlh5PCZQWXc0FNOzclM5P+ZukC756pWA
 oir3rUEEOCGWjY2zgn16cGbZqnKtFEAxQ+WIbP0TYop7HHv5KLord+oyCY0nyFb/JxmiCDQ
 XmaqzooGFU9lfFeQTN5dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PSfSfel47F8=;eIbnGqTUMp7UrIuGfZxudeMcuMh
 a3njT3AZh9X3QBiVD9w7HVUxjj74TPbOGztAzZmWpI6Fm5+tVOF/ZDyt02v6TyFg1/IVGyqgl
 GCszqpERF4oVJtVAQpAnm6F3Oc0Wr9HaW5fiTNI2mIcnQCGq+R8xX4YO/vYhxxrjqGjYGxstk
 8ClUZsdtMsHPgEYk1FEMAyllp0iHWYXMj2x5NuQIynRR+06a9GZatltKHlEMONda56jgV9OtV
 I9afxFSyOYFMCV1nwRu7UbqIrBiW7x419f6tYFt7arvrxKoTSnkxuxRnAIypTTCa9eqpRp+nc
 KrwTmJvWCsTZzDBR/hGHVxL6XD6DbvpBAab1JeSu0TZuUi3a0Mkv3wHRLElrEBmY+SGKj01wm
 g7WALNsapmHr/hV6wKvqeA9FouL85AyMrUKwYWc3NcGxPdlqRHbqjIpE7uLBuldyhEvva70Xs
 8sOYgtCoMF3+YApLZwubmvP1C1ZZ9O2vD7N07nQGjMjimP0zjFqICZw17ez4GY0eg9fk60vMh
 ve8w9LfU6SzwI+zlsVdsyghqGYVD9wOUrXQbOGft7uB7y/Yj1yb79puTfO1ePaD4ycuYGnRJE
 vG7DFy7KSHFRGDw3yqdwZmeHQBgWQ25881xs7byZLl9FNJt/+dTGJenZFB+JjQEDfA3RphHQK
 ysVQ63FhJPkRqYuMOTBGJE+HDX2EPmKDZJwIyJbMBHbGrzE9rZrhS7GbyjWJRhDz+s7y3FxmZ
 FOg+XVhkUKJncKkbW9fA6HK+3RyN2X2z3CHcejGfruIxENO9tZeO3zM9OJBJHPMVSTEzZu/AM
 e0geVIMCew4XmIv2GElUTm6w==

> Terminating for_each_child_of_node() loop requires dropping OF node
=E2=80=A6

Can a cover letter be helpful for such patch series?

Regards,
Markus

