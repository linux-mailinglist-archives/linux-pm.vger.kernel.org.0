Return-Path: <linux-pm+bounces-18876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781649EA3F3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788442889AE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB322612;
	Tue, 10 Dec 2024 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jfn8WX97"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE93C0C
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792335; cv=none; b=PCVmpEqnHKq0TKIGOwf3JwjfholwdfJQxX2r0Kj2wjHx2DHvANeS38j4orIhcc6DUiMM/aPNs2yqMKtuJFlM0tPM/i4FbxKkkPLa6t89yq4kO3/lOjrNDy9skCYAUFSJWb9ic3hl+WTSRrAUo2SZYDpeT8N8WjzKWvKLcB0mikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792335; c=relaxed/simple;
	bh=DxAm7kB2JcECl7gkapIzceGKJiE+AFE7Hpp0h/5e9u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EQSn9WZgR4hY6KMnzrR6QB6wt/tJCCSgmlrBDfNyXu3jdhsOA93lOEQ5LSUlfy/DfuFzRLG7/X6bRLeCyuLTQIMxY9wC5csX727PA1dT+8UGD6Y71CfCs4RX4Rld3dvA+qQm6PEByDXExLipTaEzcCDfxzyrtzi21b4Y4V8+Y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jfn8WX97; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-841acc8151aso362658139f.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2024 16:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733792332; x=1734397132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEjpZPJq8u289IHUov+/X17hbI/fbgadb77smhqlSX8=;
        b=Jfn8WX97H8LZp5TPqijjgUZ8sJQk9GamWeVOdaxZafHte8TNTTuk/4IjTGnyTCBnI/
         AlmoWE/r7JAj+OSLU2TlTxXu6dvq30Sklij+ZY25ydjBDjjU5VeuLmR5D3nZQtYXzdwd
         7b83Qnt+n3cZIp0FZz63AJuj1lWSh6kOEhc00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733792332; x=1734397132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEjpZPJq8u289IHUov+/X17hbI/fbgadb77smhqlSX8=;
        b=XdrUClF9Q+IlAiJbTC6w/CvvQ63P3QnDmWz+EvAgSdqmCQ9BU9M98ivP2OZtRtjGsm
         +OfQfPwSKSzHrWxN2v2AfvFgac+y7pk0mNz5jNFRdZGOumMQ2g1y0DsjRb1Jf3X2wesP
         cmdbtsyVwa+tFonCYUpXICQpF5IybHcB650388o5cKFigEUANYYGkS0LQj3UoQiqJE9s
         BLrPRNv7uLqQ+jQVOvwpzOsdSOJcMz7KNHKsHKLZt0vNA8b/mc/V/61oGtAoo30si69J
         rg5CwrOPvCOhPU8aGoPf3VHkA8ekYTQfZSArAUIbwjk8k/+T7DImkDpPvYwHRtQ/bZV+
         UDww==
X-Forwarded-Encrypted: i=1; AJvYcCUkz6R3tqoBm4vp8Fj7PysshmYoHwM2U/Xo1INIvphZ1JNGLJZKY8bgqwRi+V2n9a6R2GS5vyzrEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznjmar8nSl0twA3l+2I2XfndQ3VLmkNMURcYkwPn9XjRMO0NsC
	m7kwEl9EpYe9x7q92s1fIcB7IgpxP22Ccf9FLYtRObTEpZBVoMI1lnowVkHaeV0=
X-Gm-Gg: ASbGnctI3waraffHWhRN3nZ/Ctqqk3q0Rti9HcUDwXrJxM+4gNwsZpk7iNOQNqmungZ
	/qjSJLW95kwMUfL8rwDXawjMX70vHiKv8X90qcHm4ph5m05XX+lgTSw7nkzktr/U8i1gQAturZB
	Sx6cc1Ml3FodV15iSZW71zAuXTJ5vIgM5lrYotMU2rBCsIdZiimZlQh5V+YsVX3kVOEY4l/HJ2Z
	Hz8s/yVVkMSmlJK/Rxza3pn65o1Phc0UQ2afZy2c18MMXz1gN4bnGTWSphaQ3uD4w==
X-Google-Smtp-Source: AGHT+IFtcBzpMhyjSQe9UzBOfjoOKfl8uNNpbJPlBJbRvrs/Ojhx1komTQp0qnO6A25grb08jLMKjQ==
X-Received: by 2002:a05:6e02:1cab:b0:3a4:eca2:95f1 with SMTP id e9e14a558f8ab-3a9dbac0352mr35106495ab.6.1733792332487;
        Mon, 09 Dec 2024 16:58:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c64c24a7sm540644173.78.2024.12.09.16.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:58:51 -0800 (PST)
Message-ID: <16615e97-268e-4daf-a991-6cad7803ac16@linuxfoundation.org>
Date: Mon, 9 Dec 2024 17:58:50 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
 <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 10:12, Florian Fainelli wrote:
> On 11/28/24 17:20, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> After commit f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
>> cross-compiling env params") we would fail to cross compile cpupower in
>> buildroot which uses the recipe at [1] where only the CROSS variable is
>> being set.
>>
>> The issue here is the use of the lazy evaluation for all variables: CC,
>> LD, AR, STRIP, RANLIB, rather than just CROSS.
>>
>> [1]:
>> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in
>>
>> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross-compiling env params")
>> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Closes: https://lore.kernel.org/all/2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com/
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Thanks!

Thank you. Applied to linux-cpupower for my next full request to
Rafael.

thanks,
-- Shuah

