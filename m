Return-Path: <linux-pm+bounces-31637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7351B165AD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E434216C87D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3352E0405;
	Wed, 30 Jul 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UXukJdB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291E15D1;
	Wed, 30 Jul 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897418; cv=none; b=Dq1UsfarOr9aM50od6w0B3J1+chKHE1Z58Y+rAxtj56g/7BOSqWRKe1JeFxZNDjaobRE5HrvYzBZ+ZXkgbKlqRMBz6/RX/NEPGRp+YDPfaOyOxrNbWXy+iCaQX16QrM6emakJcI23bDH2zizLBlZGLVQRrajyfVXHA4v2/HScpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897418; c=relaxed/simple;
	bh=yOnC3LAB+G0bCJPDjWoyBgtASg13XZvxDppizWRfBi4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tTJoff0xlpnBiI/TVxAwChqv94B8HgRveg1JCsXcM1CFjKHpZ4P0m+Mj3ibPJfc6PtjJu/B57Jthoo49xmKtEpuCD/okoPwJuyugC4skO9ACA3Tocgc3MMN92gNeMO2LgM+K5plkyTZ+ECdmmdrdpI2deNp6I7aL0cpcsl96uTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UXukJdB8; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753897394; x=1754502194; i=markus.elfring@web.de;
	bh=NoJr9LpCsSwb3VNh7diC8gnn41/JMa7TFepotFO+Bqw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UXukJdB8EaO8jz5441wn8f7GujfhCv8yX14uT4NyJlX4nbQiMOFsALtSIOFZ6o0Y
	 Fei40dK0Ui9IeV3gmkUQgOyKyY8GRRTn/Zkr9xTfF7ILLCJbJ5N4Vc0z0GYUCAbm2
	 YUBXwv7fvzVwfsfaDS5EQtGsFYor9W4+rDEfc/jMbc7lEIlcTkfNKR2YwibeI0uGV
	 hg1ivLGcG7mbNoGxjtamgMFxjyzxoXR/EtzAwtf3y9vXWdQl03vkyfdH8+TllVTJz
	 WrKWvkhknV+G2SeQoKaubHLOJM4hfJHBFGx6acRO4e1BPsBOfy+Oyn3qU9zPse1Jh
	 9EDjETqgRWJEPGBJEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.238]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1u7q531dC7-00jLRF; Wed, 30
 Jul 2025 19:43:14 +0200
Message-ID: <cad798d5-fea5-49ea-8b27-8e05cd888806@web.de>
Date: Wed, 30 Jul 2025 19:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Colin Ian King <colin.i.king@gmail.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730135441.2078022-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] thermal: tegra: Fix dereference of pointer tz
 before it is null checked
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250730135441.2078022-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XW1Ne2gi2nmBwiEEjlPxtF4bQ93ZRxlPMLqRDU2akRsg0cSyIq2
 Zs/Xrh3cqqqJ+LS6WavxuoGweTkhlggfpyTqvIJ+lpgjAYYk4OcOSUisswhfhef0MfejlM4
 Szk370dLSrMlqOINhBlir6N9B2MDf1WDP4TXPM0820MiiefBjustMZUGy59YNr0tay2Qenn
 tSJe0ENtkNvzE5cMV3dLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kpZx+8YHJOo=;r4rfv00ZCRyaKutR7ZnSagmRK2d
 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
 JF7exBwYygRqbI=

> Currently pointer tz is dereferenced before it is being null checked
> leading to a potential null pointer deferernce issue. Fix this by
=E2=80=A6
                                      dereference?

Regards,
Markus

