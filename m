Return-Path: <linux-pm+bounces-20781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAADA18947
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 02:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F392167199
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062E14A85;
	Wed, 22 Jan 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZgH7mGEV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com [101.71.155.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC877111;
	Wed, 22 Jan 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507710; cv=none; b=ipXDzf1Np9aiHfk4ahjyGU/WWWRhZqGJLpoP/0xWCXklfnODoRWb0DUBGr09HNVzn/K8IjeWDNuWErSKvP6id2qFpkXjBc+HMfght4/GyepcFJgperAQtFce228RbNa5Y2lvGolQ2qj09wvWnnhW6MMnodMpt1Wy3OjOdmDWg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507710; c=relaxed/simple;
	bh=xUutVR4DYz8A+6MM3DzFI/q5HYBTKLWWWDowen5GM2o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jPwubPPUr0HlIqzrxFh6pcZ+3QOye+I90hnuSlP/YP3YESK7OXs6geoQ1+SwZ5Vf+QSFBb5q1CTZKKwDHicuLhcRIBYljyS+9RC1CYEnP3UsH3FSA05/ktJhdXb1T07TCCxQPQod6sWk35LSEKKjPMZ6IhNilqHqOlpnzJbarlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZgH7mGEV; arc=none smtp.client-ip=101.71.155.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 958360b3;
	Wed, 22 Jan 2025 09:01:36 +0800 (GMT+08:00)
Message-ID: <af72645d-1580-4115-b7d1-5d43afd35921@rock-chips.com>
Date: Wed, 22 Jan 2025 09:01:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: ufs: Document Rockchip UFS host
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
 <1737428427-32393-2-git-send-email-shawn.lin@rock-chips.com>
 <20250121-organic-exotic-honeybee-e90be3@krzk-bin>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20250121-organic-exotic-honeybee-e90be3@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJJGVZNTBkZGhpCTUxDH0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a948b876f9b09cckunm958360b3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Cgw4GjIPKCkwOg4QUU8o
	PEIaFCxVSlVKTEhMTktMTUJDSUNJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNLTjcG
DKIM-Signature:a=rsa-sha256;
	b=ZgH7mGEVaZo8jLdf7H5Vc/0VGo2GTPglS6iiGpb9q47LoLPDAMZi4U5HpIhLKydgSko5/yPxWZccymQNoiWCdEc7jRdEA8Apx1ZfYdsLE91Wv1MBqiSefAnnw5ns/Sdd1+5txx8erFTs3BN/pVZwv7pET/JGzaZOSC4CVRVQLog=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TNkJR2V+hpQI/zspezH6WFR2/g/dlKK3S/D/lHmxGZI=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

在 2025/1/21 16:02, Krzysztof Kozlowski 写道:
> On Tue, Jan 21, 2025 at 11:00:21AM +0800, Shawn Lin wrote:
>> Document Rockchip UFS host controller for RK3576 SoC.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Just because I gave review, does not mean you can send untested patches!
> 
> Best regards,
> Krzysztof
> 
> 

First of all, don't get me wrong, it's obviously my bad.
However, I would like to say it had been tested before sending.
The reason is I didn't notice yamllint was missing somehow from my
environment.

So this warning is burried in the log:
warning: python package 'yamllint' not installed, skipping

I would fix it and resend patch 1. Sorry again.


