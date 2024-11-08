Return-Path: <linux-pm+bounces-17195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9499C1A0B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 11:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ACB28217D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC41E22F9;
	Fri,  8 Nov 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="r5JSBQFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B51D3625;
	Fri,  8 Nov 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060712; cv=none; b=J5nueqxfbqEkBiO7QlcQUoJPhcEqH/6qUNTcmdHPuCDP9SLGQ2CktXzChasd1ihbMFCnlBYEo6EqMbtKOhwdkWEh2nTCguiZQALSoCBIUojDJUhIegEreBgJNzv3Whoa1uU+CBu9/Ds+UKybcOkTlx32Y2mBSiz49pAYsdu0m7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060712; c=relaxed/simple;
	bh=l/rUYTtLBoZdyLaTZknHT/dDTcsmBbHTevO92xNdKD4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EmZmVGmHeY32943fwZha2G4J8Eoy1VdUi2HtPso5IZnlNEs8gfx5BO4IQnJgaIJ0S8Q+2OUQXa4PdxnyYtS6QXLauQDDH4HOLIHVJ1cz/TGYhVhF6Chh6pPdn5+b/KWZa+SqnBL0Fgkw0D6n1gmRF/sZ7hjfe5qYN4nVmRHUJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=r5JSBQFv; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [127.0.0.1] (254C262E.nat.pool.telekom.hu [37.76.38.46])
	by mail.mainlining.org (Postfix) with ESMTPSA id B2ED3E45BA;
	Fri,  8 Nov 2024 10:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731060707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/rUYTtLBoZdyLaTZknHT/dDTcsmBbHTevO92xNdKD4=;
	b=r5JSBQFvrXn68+6+DaTg3bewx71mLwK1M9p4Z9Yy0zL4f+JLUcontlSns9CG0wIY0Y71hs
	IQZtysEWobt/PgYn5eubVunNvcdiptorp93W5Aw3QKruKNp2xb14Y0+v48wRyDI23vuqaA
	hZrFGYWvFtyE2VconJxJsR6Tf4DS4o2N53912gPUidmbXALU4eDiG8hdgwknRSSJluo7Wb
	jCQMKZAJ8gJ4phJkthoq5wlhGZDaQXeLU+iMGV5qlxwqC3ZyEVc+8PIhGJ2Y1mD6UdYVqa
	7mgaw25TyJfOJUWgpp91CnSpvp2IkYHDmMCBOxXRV1/spsmD67JINl+vX+Ecqw==
Date: Fri, 08 Nov 2024 11:11:46 +0100
From: =?ISO-8859-1?Q?Barnab=E1s_Cz=E9m=E1n?= <barnabas.czeman@mainlining.org>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Dang Huynh <danct12@riseup.net>,
 =?ISO-8859-1?Q?Otto_Pfl=FCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v3 00/14] Add MSM8917/PM8937/Redmi 5A
User-Agent: K-9 Mail for Android
In-Reply-To: <CACRpkdamugexe6y24Tk2fDYPP_t7QLynibdGQrUMFMwF4y90cw@mail.gmail.com>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org> <CACRpkdamugexe6y24Tk2fDYPP_t7QLynibdGQrUMFMwF4y90cw@mail.gmail.com>
Message-ID: <43C3A05C-2D28-428B-AEB4-7BC92C55B66B@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 8, 2024 10:03:00 AM GMT+01:00, Linus Walleij <linus=2Ewalleij@=
linaro=2Eorg> wrote:
>On Thu, Nov 7, 2024 at 6:02=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
><barnabas=2Eczeman@mainlining=2Eorg> wrote:
>
>> This patch series add support for MSM8917 soc with PM8937 and
>> Xiaomi Redmi 5A (riva)=2E
>>
>> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas=2Eczeman@mainli=
ning=2Eorg>
>
>I merged patch 1-4 from the v2 series, don't think the have any differenc=
es
>in v3=2E
They are same I will remove them if there will be more iteration=2E
>
>Yours,
>Linus Walleij

