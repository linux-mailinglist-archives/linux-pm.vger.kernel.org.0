Return-Path: <linux-pm+bounces-10209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F391C604
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FDA1F2186D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2DB2E633;
	Fri, 28 Jun 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ive+c2L5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA84D8A4;
	Fri, 28 Jun 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600387; cv=none; b=dhpRVVeT63ndD1y9/SxPLwmUmoM1W8NpOp/75KPv6nI0EIjqRycJUv8dCPkpGr/7wSAfkQPSzvPtoloLOh7dUPEQ+oi3TKaTOiDH523JdOmTfoGi5KvoEPgXYKiUNIoRiiOaQ+NKjtUxAKXOTXMq4YTlcg2gH3hWFma914fLnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600387; c=relaxed/simple;
	bh=0r6f63ulA9CwTR3yoCkbKFiWbjYB54RLFTB0WR0OmGE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qicHWNcYAnsTCf6O9pR5BmjSLmNbY3xHegPnAbOO90fBRIsFtnJje3Omu1EnavWuWb4qOH+NwfQB8DGP8vd9V56ZEMHnSfzaVXajQw9mNb1z1apsPYpERWyTh5c40l+1POeUvZqVsuTVv+9Km2ftbt0zSWGH1E1VhyzY55ZMMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ive+c2L5; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id CF3E3E44E7;
	Fri, 28 Jun 2024 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1719600376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpU/Dtg64x1wGAsewul/5TSECTFm1fUjMyrQHl9v2fE=;
	b=ive+c2L557wOI4nhKut8Qeo3C3Zo1MKb6gxf5MNqdT8stvsaGElvFBdbPKWfJX2LQkQLKj
	PuOhL3qiWFX1uNxnet6Vm0yv5zna7v1ZTggWJxL717VdXOTetANsiWQcSg/33n24z0jjQq
	75zfPD1se+Cg0/kYsTHRtnU472ZIhwTeA+6S8CHbPtDCq1BFaK0BsyOg5Sawne6AduEDkV
	56dc91nns7NW7fuwHSG/UqpG2OWut7rhKG9lWutBTAQCVtZrBjRh5Lnrf/ck8nzRvxnPE7
	OMIdJj1R/Ph3kvRa1MhYiSUnWTTlXaI1ZKJ1lyRY0HdoUq1DzaVnP5v418FJig==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Jun 2024 20:46:16 +0200
From: barnabas.czeman@mainlining.org
To: Georgi Djakov <djakov@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add MSM8953 driver
In-Reply-To: <f0f09455-5bfd-4dbc-b393-dbef75441e8a@kernel.org>
References: <20240628-msm8953-interconnect-v3-0-a70d582182dc@mainlining.org>
 <20240628-msm8953-interconnect-v3-2-a70d582182dc@mainlining.org>
 <f0f09455-5bfd-4dbc-b393-dbef75441e8a@kernel.org>
Message-ID: <a4b6cff7ac6ae69ff8bfe76ab72544c3@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-28 20:39, Georgi Djakov wrote:
> Hi Barnabás,
> 
> Thank you for the patches!
> 
> On 28.06.24 17:01, Barnabás Czémán wrote:
>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>> 
>> Add driver for interconnect busses found in MSM8953 based platforms.
>> The topology consists of four NoCs that are partially controlled by a
>> RPM processor.
>> 
>> Note that one of NoCs (System NoC) has a counterpart (System NoC MM)
>> that is modelled as child device to avoid resource conflicts, since it
>> uses same MMIO space for configuration.
>> 
>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>   drivers/interconnect/qcom/Kconfig   |    9 +
>>   drivers/interconnect/qcom/Makefile  |    2 +
>>   drivers/interconnect/qcom/msm8953.c | 1321 
>> +++++++++++++++++++++++++++++++++++
>>   3 files changed, 1332 insertions(+)
> [..]
>> +++ b/drivers/interconnect/qcom/msm8953.c
> [..]
>> +static const struct of_device_id msm8953_noc_of_match[] = {
>> +	{ .compatible = "qcom,msm8953-bimc", .data = &msm8953_bimc },
>> +	{ .compatible = "qcom,msm8953-pcnoc", .data = &msm8953_pcnoc },
>> +	{ .compatible = "qcom,msm8953-snoc", .data = &msm8953_snoc },
>> +	{ .compatible = "qcom,msm8953-snoc-mm", .data = &msm8953_snoc_mm },
>> +	{ }
>> +};
>> +
>> +static struct platform_driver msm8953_noc_driver = {
>> +	.probe = qnoc_probe,
>> +	.remove_new = qnoc_remove,
>> +	.driver = {
>> +		.name = "qnoc-msm8953",
>> +		.of_match_table = msm8953_noc_of_match,
> 
> Why no .sync_state?
Because there is no cpufreq upstreamed
> 
> BR,
> Georgi

