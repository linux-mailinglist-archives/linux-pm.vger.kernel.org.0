Return-Path: <linux-pm+bounces-33786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A4B43134
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837AD3A89E0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B31DFE09;
	Thu,  4 Sep 2025 04:37:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB617E107;
	Thu,  4 Sep 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960625; cv=none; b=IkHENp+gReqSPB5v1QpjSOewbfEFQNmuVNq3cmCKJ5ms9KgSjvZeCshrvFEek8WXWvCjB20x9HvJZ2XedR0yhYOTY/3pz/J9vFc7FrA7d8ITX/BOjiC24c7/7Je+JGi0gTJPt6QEBTCIHkqv8yNzlng8PqEnNUnyrSEyqaGmoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960625; c=relaxed/simple;
	bh=9ved98S2Y/yppTVs9t/GKLHEoY+iW7CpgxRP3NqNsos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bijY7bK3sNsN2WFSDqKNDeZnqkD+bk0O1thV3ySdcrYiZZUZprmOqhHeqx7fZ0u7t4mv/PXZoYju11zvPsiFzLmkXzURowo1JS9ZUBzpQuXFpJKA+dVBL2TV+zPytsswzB+TOkEXESsK6BDwcmTM0lT1e1Yfs+ICAn6kXT2SdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9aea0aa894811f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:caaf830d-cb59-43ba-a061-0468ecd39a47,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1e55ea995bba187285f54a16e0693ecd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c9aea0aa894811f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 972788480; Thu, 04 Sep 2025 12:36:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0FCD6E008FA5;
	Thu,  4 Sep 2025 12:36:56 +0800 (CST)
X-ns-mid: postfix-68B91767-9218656
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 300EEE008FA2;
	Thu,  4 Sep 2025 12:36:55 +0800 (CST)
Message-ID: <ba6ddb11-43b7-444f-a907-c57755a71423@kylinos.cn>
Date: Thu, 4 Sep 2025 12:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] cpufreq: Clean up frequency table handling
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>, zhenglifeng
 <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904042441.y6os6koxp5giglx4@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250904042441.y6os6koxp5giglx4@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/4 12:24, Viresh Kumar =E5=86=99=E9=81=93:
> On 04-09-25, 11:22, Zihuan Zhang wrote:
>> This series contains a set of cleanups around cpufreq frequency table
>> handling.
>>
>> The first patch drops the redundant @freq_table parameter from
>> cpufreq_frequency_table_verify(). This has already been Acked, but is
>> included here to avoid build issues with the following changes.
> Yeah, this is not okay. You are resending an earlier patch, which is
> already Acked as V1 now. You could have just mentioned the link to the
> dependency patch here, and that's all.
>
> Don't mix things like this, it doesn't look nice.
>

Thanks for clarifying, Viresh.


I wasn=E2=80=99t aware that I could just reference the earlier Acked patc=
h as a
dependency instead of resending it. Your suggestion makes perfect sense,
and I will do that in future submissions.

Sorry for the noise, and thanks again for the guidance!

