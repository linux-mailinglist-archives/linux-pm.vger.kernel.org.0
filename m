Return-Path: <linux-pm+bounces-36026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A95EABD7003
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 03:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F57C4E12D5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 01:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057DC26CE33;
	Tue, 14 Oct 2025 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IOBb2nMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34E2609DC;
	Tue, 14 Oct 2025 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406262; cv=none; b=evccowA4nLhMifLrPnVbPkEJgdrRkh+yOrt9QWdh8j4SOtcDAs+KDDPovzhyXn6Bq+NngwmlgXNjnRdydTdIHSQg8d4mXHJqZZE2+A+JbENs/aOlCU4c3wTfq/IOpKxubvjsWV5MDxrFXQRE3cFR5l3dgNScwvIRM5NmoBESKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406262; c=relaxed/simple;
	bh=MWJawC38d3DQF2xxTQwepjeyvR6iXNQAqsk4XFghRi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpRAG/231RxMOGihL+IJ+1eR3pCMvWKpOaxoUYmJc9smTtvEl/jCbXal7RrRV3nZ/eQZlyb3jx+U7ZmT84Oba++lCDPmYlYqDKDPW8NSPbyeNO6JeLA2wYBc+fnkPhMwgs8JkRAdDE9FM6sdSVeTGu9e8mMQdwbNa7o9KXpIw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IOBb2nMA; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760406256; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DVRratCb+w1LO/KMq/+W6HX9LGsu6Q/19KQetFr8p0w=;
	b=IOBb2nMAD3eiUNItd7gaEZ1dX5X2WA33QcwZ60qkWTNR+BUBheO4wyyZtHq3PRCRWgj84tznu2B+fy2/t+xTxCpJWbftU3ohCokQqFGyqN7B4lBxFVzcMAK37+Piw8h968s5eRZ1mnsRbtvPocODQPznxkwLK3hkRKNSdBwCyzI=
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wq9t95U_1760406255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 09:44:15 +0800
Message-ID: <982105c4-9dbd-47dc-bfc3-ef37a390a14c@linux.alibaba.com>
Date: Tue, 14 Oct 2025 09:44:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] power: reset: sc27xx: Add support for SC2730 and OF
 match table
To: =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
 <20250926-sc2730-reboot-v1-4-62ebfd3d31bb@abscue.de>
 <58441250-1f00-45ee-8583-9863efc938e0@linux.alibaba.com>
 <aNtq4qyYNqZThjeI@abscue.de>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aNtq4qyYNqZThjeI@abscue.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/30 13:30, Otto Pflüger wrote:
> On Tue, Sep 30, 2025 at 11:30:16AM +0800, Baolin Wang wrote:
>>
>> If I remember correctly, the original driver supported SC2730 and SC2731
>> chips. Are you sure the current changes are still needed? Have you tested
>> them on the SC2730 chip?
>>
>>
>> config POWER_RESET_SC27XX
>>          tristate "Spreadtrum SC27xx PMIC power-off driver"
>>          depends on MFD_SC27XX_PMIC || COMPILE_TEST
>>          help
>>            This driver supports powering off a system through
>>            Spreadtrum SC27xx series PMICs. The SC27xx series
>>            PMICs includes the SC2720, SC2721, SC2723, SC2730
>>            and SC2731 chips.
> 
> The driver was hard-coded to use registers 0xc2c and 0xdf0. SC2730 has
> different registers, which were added to the downstream version of the
> driver in [1]. I have tested this with a UMS9230 phone which has an
> SC2730 PMIC according to the device tree.
> 
> [1]: https://github.com/MotorolaMobilityLLC/kernel-sprd/commit/6165e1afe3eba33089fecc86767d47af9ab176d6

OK. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

