Return-Path: <linux-pm+bounces-16038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283BB9A4EBF
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EC2B2557C
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BA152E12;
	Sat, 19 Oct 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="T2bU+FCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7037C2E3;
	Sat, 19 Oct 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348838; cv=none; b=Op6wvePMvclMbRYHmRnpPh5unfCiP+PLBTzRD7KVw43gtlq6BJyvhU4dMo7MdPPpoyz+zz2zr4WrxGb2ewNqW/PlsQ+PQYln+hsJJJbEtagLo41h3H9yZNb9MJu4bilVWAA0MWS1/WgCz//g3EyYHtbH7Cmc+HbLkNyiJluazXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348838; c=relaxed/simple;
	bh=pkgwufm+bq8k6WekP/FLv0/EPjklZE3HX5XQ5xReyWg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xdi+CqauHG2okYmbRhANy/OGtyww4p2ghi1Fb50syPXg8BaZntklLV1s/zxbp4akUbg2LOnDFrF/nRja70bOd3lHJMjG0P0q7D9icV8QIl3hkx9AAa6hX8BOiQPviAZ+xboOi2PlgsqaqzUnNLpdaygRDNlx4aFAAQI+yzFJ1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=T2bU+FCR; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 79FECE459F;
	Sat, 19 Oct 2024 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729348834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EZ0o3avbZ9UgAo2nPmXkLtdwekuw0WM/Mf7T+3Ys1k=;
	b=T2bU+FCRFyKGaxMlZXvxwhZf/FHRJPk9dBBdMB1UrkI8g1aPy3YwXm11G1FcATi5m77a4+
	GcjqkQ0wMy4MaMSfZ9lMXNH+mANNM5Xv4oK8m3bodjnVMWoxdueKjLJYsypPJgWW5ZxEmg
	jfHWSOqCiVzoxsNp5n/cqXW8ZrlDp5KAyIZeFaWgOZDukNuqqGkH1RPstqr4iWzja4BIlu
	U5+TGygcbaJ82mwMP2oG7jrIccZpHtca3ZD9jYRuOcjG8VPRiwF8fGBR6U/RYyfyPuy7Gd
	ZceC7KQxoybbNKIUSdZatvPlLGg2HJogceaiYb/R8HJCG0SjQvszDjxJ1g65uQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 16:40:34 +0200
From: barnabas.czeman@mainlining.org
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH RFC 14/14] arm64: dts: qcom: Add Xiaomi Redmi 5A
In-Reply-To: <jj4ky6uuidv3rdjl7q4ehe7cdgcjxtnmtcufmy462gznkjiex2@pptv6aufsudj>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-14-f1f3ca1d88e5@mainlining.org>
 <pyr3t3kcpjj5zor226fwembjsbpp5zh7mpe2a3bqmwnbqccj7h@a55efscym3s7>
 <46f7b167220a7d54242e9457d00d67e2@mainlining.org>
 <jj4ky6uuidv3rdjl7q4ehe7cdgcjxtnmtcufmy462gznkjiex2@pptv6aufsudj>
Message-ID: <d55a8f5d7f9b371fd2b51ec079adbf8d@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-19 16:38, Dmitry Baryshkov wrote:
> On Sat, Oct 19, 2024 at 03:57:54PM +0200, 
> barnabas.czeman@mainlining.org wrote:
>> On 2024-10-19 15:48, Dmitry Baryshkov wrote:
>> > On Sat, Oct 19, 2024 at 01:50:51PM +0200, Barnabás Czémán wrote:
>> > > Add initial support for Xiaomi Redmi 5A (riva).
>> > >
>> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> > > ---
>> > >  arch/arm64/boot/dts/qcom/Makefile                |   1 +
>> > >  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 295
>> > > +++++++++++++++++++++++
>> > >  2 files changed, 296 insertions(+)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/qcom/Makefile
>> > > b/arch/arm64/boot/dts/qcom/Makefile
>> > > index 065bb19481c16db2affd291826d420c83a89c52a..79add0e07d8a5f3362d70b0aaaaa9b8c48e31239
>> > > 100644
>> > > --- a/arch/arm64/boot/dts/qcom/Makefile
>> > > +++ b/arch/arm64/boot/dts/qcom/Makefile
>> > > @@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+=
>> > > msm8916-wingtech-wt86518.dtb
>> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86528.dtb
>> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
>> > > +dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
>> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
>> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
>> > >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
>> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
>> > > b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
>> > > new file mode 100644
>> > > index 0000000000000000000000000000000000000000..7553f73603fc87797b0d424a2af6f2da65c90f5f
>> > > --- /dev/null
>> > > +++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
>> > > @@ -0,0 +1,295 @@
>> > > +// SPDX-License-Identifier: BSD-3-Clause
>> > > +/*
>> > > + * Copyright (c) 2023, Barnabas Czeman
>> > > + */
>> > > +
>> > > +/dts-v1/;
>> > > +
>> > > +#include <dt-bindings/arm/qcom,ids.h>
>> > > +#include <dt-bindings/gpio/gpio.h>
>> > > +#include <dt-bindings/input/linux-event-codes.h>
>> > > +#include <dt-bindings/leds/common.h>
>> > > +#include "msm8917.dtsi"
>> > > +#include "pm8937.dtsi"
>> > > +
>> > > +/ {
>> > > +	model = "Xiaomi Redmi 5A (riva)";
>> > > +	compatible = "xiaomi,riva", "qcom,msm8917";
>> > > +	chassis-type = "handset";
>> > > +
>> > > +	qcom,msm-id = <QCOM_ID_MSM8917 0>;
>> > > +	qcom,board-id = <0x1000b 2>, <0x2000b 2>;
>> >
>> > Is this required to boot?
>> Yes
> 
> Hmm, did you verify the dts against DT bindings? I think you need to 
> fix
> them.
I have checked with this `make CHECK_DTBS=1 
qcom/msm8917-xiaomi-riva.dtb`

