Return-Path: <linux-pm+bounces-17186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0E9C1775
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 09:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734D51C21BEA
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3051D221D;
	Fri,  8 Nov 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ct4C7n03"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886441D0DC0
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053282; cv=none; b=fOgNYwT/nUNkhcYuttyn9E/i++yFGtNosDxhETipj2ZCZAQJTI0F04vYZtftbo6VVZHYzmDbRwx0hj+sKB9T6MAx3jUiMWwP7t5FL+BcluhQHRyuQP4fwwefLwhYLP4BLVDbz/ELbXEX3PbKaBoMgFokj2lzKSpbjCtuOhj73XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053282; c=relaxed/simple;
	bh=BxCAif6wBpfReu8TvZw3mVT33TIGWApsV+3A+vA2nTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpmtyHRcDuAQPdhLa/sPsCnNgXLR2P+tX9zSgnBxTHFBHjSeH65ypKG5/eRIwyXSbD8Q4Voi2tSBJRDdL9BUOlL+MCsFpMaEAhPc248Dn3crxpwQlBLUhA6FLontvIbQ+HrtJB3/zX9K4aKhiQOwsaUacfMSY57r152zOpolfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ct4C7n03; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso29971401fa.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 00:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053279; x=1731658079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxCAif6wBpfReu8TvZw3mVT33TIGWApsV+3A+vA2nTg=;
        b=Ct4C7n03xwW94PDgpvQkF+5YOyVeIkYaZwLrR8pRkli26DXB9U+Hy5l9Sd/oVyICIP
         PyYN+L6zFhdKaybMwISi3RQ59YwTUX/cVHRaoA5Mbm5R7OSQ7N4OnmVViWdTYTUNazf9
         GIO45C8LSdkO336imguOwIRxHnmxukTiBYUQaBG7llcF57HW44z6f8Ld46meaDcC7r9U
         a4sJD7r7GCuKn5BtrEKiaAOkFadablpcIkIqAi95oxeVH2PzbYYYxW0TxFWsmK7Xa7Fm
         gCPfw/ryTSqe/b5R9RL0gBft/gge+a3x7aCcpvSop8MBOT3aDmNwOZW6Gqk6e22uiM+Z
         43vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053279; x=1731658079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxCAif6wBpfReu8TvZw3mVT33TIGWApsV+3A+vA2nTg=;
        b=xL6ML4NT/Fx2KmMMCQLyY+3ypdf92xfqZ3BEmz1aPsuOIajQOxKV5Uc2J/dbC1Vexp
         jxvHCgNJbnhnV6mQwQRkh4r/F8lLOWxGW0SN4+apRAhLq8WN66saqQHcsbDuB7LjKQTD
         TzLWmymupWpFQgWq/TynhmdGsqlwoxXT3YmFgScTmte3sNv7bbNk4XWx/WkBd9L0fA5O
         5L3rR8MZAYOaJRWyHd9ER+4jQ/k8Jfd8iJS9fAQxFgZGM+ssha13qlKPQdggTh2zZDFP
         aCrrlSRAxJEB/QjcbvWDJzhuwNOsMtCISzC8OtrJ7YMIhi7mejYmXdo0gqz8P94Fpe7h
         B/JA==
X-Forwarded-Encrypted: i=1; AJvYcCUlEyvLrcNyFTsJD4JNs00Vh160VV7FppEVFdBOsmdsJvP679KGMjojvgx16PIvk/I+gGWCCNbhfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbsY8SqovTSZ/bzcYpV76FjBRBFiAQTzmWqtVLyNE/2BjU6sj
	vPT9F62Pflvp0zvVFZIoYw0yWQxl+kgsCg55FmPO+3tUDzDYyyKNCNaDYqjKrTJKEVdDfoUmNBW
	lIXlGA/y4ckNot1MGT2bhO2kv4i4a2hICtAzYDA==
X-Google-Smtp-Source: AGHT+IECFYZgmqXq90uc6fU+GhsZFrNHgfgkpCoMfSI20MKSS84Aidx6qe2DptwPr7H2EP4ELmSvQSeK05aPSJkA+5k=
X-Received: by 2002:a2e:a10e:0:b0:2fb:510c:7237 with SMTP id
 38308e7fff4ca-2ff202c3c9bmr11587911fa.41.1731053278604; Fri, 08 Nov 2024
 00:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-2-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-2-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:07:47 +0100
Message-ID: <CACRpkdZJmetNUHhBOfoZuygEXW7VO0Go2bmngxciVeOoyzVaxA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] pinctrl: qcom-pmic-gpio: add support for PM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> PM8937 has 8 GPIO-s with holes on GPIO3, GPIO4 and GPIO6.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

Yours,
Linus Walleij

