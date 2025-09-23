Return-Path: <linux-pm+bounces-35199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46788B95146
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 10:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76FC19042A1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6331E0FB;
	Tue, 23 Sep 2025 08:53:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6B2ECD33;
	Tue, 23 Sep 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617639; cv=none; b=UgYMLpqHVURX85mkpxfT6ZRE2cK0p+JI+z7P1eA/8FVELJWPNiklZP/Eg9hYaIHMn5cnx22FA9OnX2z8LID4/5x/3bU2yGYInxGqYEyoiztkunyjPWuNlyumZe02cMCmtXIwoiF5ACbBoQYgM7frteLNVoN5rr34EMH78Txb8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617639; c=relaxed/simple;
	bh=4tPKjI3An5l1wBqNlztW/imYQlNnEUjqc/C8U+ZQRfI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K4m1QKTBn6JyfDQHWHKfyECGyXVkOe6fXI9HsuwtIHiIOO1NABH7sRTuU5uLtzOBTgiCFP709UJPa2856AR2luCba8PQTzttJQJKaCTwNmuZ0mB8hqjPAsSwz4apUY6mGVvDTJuiz9hNoiLrB5HgxOR1O8R1qcf1o5czyPcVMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d22b4136985a11f08b9f7d2eb6caa7cf-20250923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d9e18b8a-24a1-4c5d-8d73-6d70262c6481,IP:0,U
	RL:0,TC:0,Content:25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:ec635f4d1b978130b1c196cf2dc9acee,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d22b4136985a11f08b9f7d2eb6caa7cf-20250923
X-User: zhangzihuan@kylinos.cn
Received: from [172.25.120.24] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1897735611; Tue, 23 Sep 2025 16:53:48 +0800
Message-ID: <e221cef4-a26c-4f9d-ae5c-7dffa78b5e66@kylinos.cn>
Date: Tue, 23 Sep 2025 16:53:46 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Rafael J. wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [Question] About unnecessary policy_has_boost_freq() calls in
 freq_table.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

While reviewing the cpufreq code, I noticed that in 
cpufreq_table_validate_and_sort() the function policy_has_boost_freq() 
is still being called, even though most cpufreq drivers do not make use 
of the CPUFREQ_BOOST_FREQ flag.

code in cpufreq_table_validate_and_sort():

         /* Driver's may have set this field already */
         if (policy_has_boost_freq(policy))
                 policy->boost_supported = true;


For drivers like acpi-cpufreq that don’t rely on CPUFREQ_BOOST_FREQ 
flag, this extra check looks confusing and possibly unnecessary.

Would it make sense to move this check into cpufreq_boost_set_sw() 
instead, so that the call is only made when boost is actually relevant?

Thanks,
Zihuan Zhang


