Return-Path: <linux-pm+bounces-34189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA1B49E4A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC4C1BC75CB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 00:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6C1DDC2B;
	Tue,  9 Sep 2025 00:47:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3817A5BE;
	Tue,  9 Sep 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378845; cv=none; b=oOREr6dtTZImbb6pcTIf1s71v+wU/pO1PonQIkD2h+IRa9t60kku7nWfY9zVXYOpujPFi6dtLlBkPi22e79wXAuFbRr1DadjFCqeYmpqb5Ngd1EJ0OaGtKo+Oo7TnagNT+4nq9q2KxtsH7+yW3Ww95YrRMEIlJ8i+AJLRF92H+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378845; c=relaxed/simple;
	bh=H8CU6DSuTlyKuz+uXCF5+9KV7UMV6QpKxqjSFd705lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPtb2d0bQycuQD/DSqUEnmbNiE+14RYcxpbv8HFhyRVuJdewKzNV2wWah2KfTGcjaMoZVH2SujeFgkzqLnj9I+BZq3u/r8e08QLpxoamn1S14mCun80FUoY2aiZ+jkhp11j8RGDe9mM59Nl+nOWFAJTYmWfKyROysDNRBTn3Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8308ce108d1611f0b29709d653e92f7d-20250909
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:abcc27a3-7beb-415a-b184-63a807d6f293,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:da68fd040d7950670556a72e52599e09,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8308ce108d1611f0b29709d653e92f7d-20250909
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1981216402; Tue, 09 Sep 2025 08:47:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 58A05E009007;
	Tue,  9 Sep 2025 08:47:07 +0800 (CST)
X-ns-mid: postfix-68BF790B-1929853
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3578EE009006;
	Tue,  9 Sep 2025 08:47:06 +0800 (CST)
Message-ID: <2571f264-62ea-4e2c-96f0-a61b6f7dcde7@kylinos.cn>
Date: Tue, 9 Sep 2025 08:47:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: intel_pstate: Rearrange freq QoS updates
 using __free()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <5028967.GXAFRqVoOG@rafael.j.wysocki>
 <3026597.e9J7NaK4W3@rafael.j.wysocki>
 <a6104009-d0ad-4d76-9079-0e81e74cd32a@kylinos.cn>
 <CAJZ5v0i+GBpv_mGnYMbNjr2d1pvXJ_NqYCp8+pgOTNpCTuue8A@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0i+GBpv_mGnYMbNjr2d1pvXJ_NqYCp8+pgOTNpCTuue8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/9 02:10, Rafael J. Wysocki =E5=86=99=E9=81=93:
>> I also noticed that in this driver some places use one naming style an=
d
>> others use another, so it might be worth unifying the style here.
> Well, I'm not sure about this.
>
> I guess it may be confusing sometimes, but then I'm not sure if that
> justifies the code churn that would result from changing it.

Agreed =E2=80=94 there are quite a lot of places that would need to be ch=
anged,=20
and perhaps it=E2=80=99s better to keep the current style as is.


