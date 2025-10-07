Return-Path: <linux-pm+bounces-35794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F278FBC2B4C
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29D384E5F7F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F523D7EA;
	Tue,  7 Oct 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlGUFpSs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1485464D
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870411; cv=none; b=beKos9oW0u+go9mGBip1+q/E6Yg61DTb4Df0w0afY4W2c/MvjkX8vpULUvipYkTF84kO0qyxwX5kRz4M5sc/wuHadUMsfVYQJiLHczUn0qJv1KqT3hk5QzwFK3EkklqDRvdEqP6mLi/oSU1hWMord97bNMlJ3DWa9Nn6+gLyas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870411; c=relaxed/simple;
	bh=/hCZP75SmDHrCZY5PWLz8NOVMBMSMd1PrqQADWHi6tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwTCrNgBmU+vBsHxsNw7TDu6McfKcxi6Ne9AhP1R/YtmQI3ZFmQQnOVec+S3bC9PRHIp0JAI9GLIDoMSXG2VNZi26QCHoH0X5xKiNSFki4sSKD8q30PDS6Pe9GYNjynsAZCLpe8IwVZ1MgMxbHVqk7hvKjGlnzu3NJDQpz1KnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlGUFpSs; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43fc147aee3so911025b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759870409; x=1760475209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hCZP75SmDHrCZY5PWLz8NOVMBMSMd1PrqQADWHi6tM=;
        b=SlGUFpSspz44Aw5wUKlHa342PN49vvlrUAMNLdS7xKJR2gulKpDZtYd70s33EVMqUB
         d2k3McBx8l0aDVxdmSsZYHq7L/xqAPwE8CZjoHAllk/QjDD5JiHdDeNEhI8oiAVpOzhi
         8hZrwkurrQLZdIa7JXTR0wxcwFACOC66xYgoSX0HRda5WnPfsxGs6DNKq4NQvnrnZaIc
         sk80RjesUNWg6H2sQwMcC4WbFP9/AY9uqfQaUHVxfhKflrpPxDr5eUfyBk4tdFa036G5
         E+ttBI2bX6sr1uowZuA8z/ToSCxC7e/00glVZRQ5OT3Tvbddfh11h7E/BXYBOJsBAzPl
         /F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759870409; x=1760475209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hCZP75SmDHrCZY5PWLz8NOVMBMSMd1PrqQADWHi6tM=;
        b=CnFOf8RQrZTE9UMmbCd8Onc0E72lPPQSYgPtGVIs2beEJcVdvlzL1IlsK2FCcJ/45J
         Xc7DnbF+FNiY6bs1Ek4ckXgtoNBpy75sEIcjHE7cRwLZzhZEugNO+l1ks+w6hf3R21Yy
         w5CKgmvJHwCIic32yQ0ZQXsVeepOyZelW35rIIUJWmvUe77YEkdY10v6pTD2gOwrG94U
         4B15f/3PcAZuN144qx5d6eab17+zNQKxRMYozGXa8t9/ncrD5CJYtLkZ6n31LqiNhk+s
         75Rv+89s5FduldDqTeZi7+Zyv3234FJytrYlop/t2JszFn2JQzz666RRZLzy9JSqLrzv
         Ne/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRfC5GW9zfZbcF5mTsmySksLyYGuekgdaDjHhdzBqosiijtwd+sTrGZpLHfivbPBWOPKmwY9O0VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpoeQxV73Q/BeCZsunUMXF0WlcRTioUZtY2BephmR462Pv/zt
	o39WWEwgbK3gkCWLEqH5p/VC+GC+bmrREzzDx6v5H/XRpy46wYBEaboHGCZ916/lRmCiJapnDmB
	WSYdYijJf2dHsyb7HZYJi1kBsrGvk3hJhyNWtmPqJcQ==
X-Gm-Gg: ASbGncsuCNFfZr7PKgarX0KhhlbIP4xd2t21K2r27ynY8qwtUhzR0QgHlr4O5o1D7Rj
	TggR5yO665lnDSbmXq1M3x7zZsD4Uw1wm2K1U8y6pZGcGlyyiXM11ePNJFLT33eT3gs4ypN4xLZ
	H24oI5Py4e7QCaJN2ewcH4rwfapLgtlSq+4oAASTfcxHaZgFTwZyVA6Jg4QBmBBK3f9P+FTTlq4
	hDVhJtYz4hw/1QSF3m6oTxC0q0G149wlykQxg==
X-Google-Smtp-Source: AGHT+IFQJZVs4LBnBVbWSGDsdN3906KKw4UjF5sMiH1fvSeD9gn0otajPAH5kYHA1+VAEseWAd1TdVpRyCmSlYYSQ1w=
X-Received: by 2002:a05:6808:1988:b0:43f:57cb:7f83 with SMTP id
 5614622812f47-4417b3e3209mr436998b6e.46.1759870409126; Tue, 07 Oct 2025
 13:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org> <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:53:17 +0100
X-Gm-Features: AS18NWAUUQxOHKEKFHDJ43bMyMuc1k66q_SOXE8Wv3pAaENJrBaMTokvZjBYJtQ
Message-ID: <CADrjBPoharrk2BwLuFaAicErLxZXre+gSSqwws6Q07E4C9f8nA@mail.gmail.com>
Subject: Re: [PATCH 03/10] pmdomain: samsung: use to devm_kstrdup_const() to
 simplify error handling
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 17:43, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Convert to using devm_kstrdup_const() so as to simplify cleanup during
> error handling.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

