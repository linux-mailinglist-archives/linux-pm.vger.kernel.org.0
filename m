Return-Path: <linux-pm+bounces-34802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697BB6207E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 00:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156BF526158
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 22:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612129B778;
	Tue, 16 Sep 2025 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJv59My3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C329A31D
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060697; cv=none; b=DIsFBnW4uUsU9qV07+9jXaL2/5TBkLFC9gDVF7yra08PUNqXD0G3y3D9sw1U6sSchsVnVnXFOzEj/VrNEhjy8ltDdrl35P/sZji1WuHqZsRJ64pz1pUVBnebaXCPLf6kzusUcEB2TnC0x5ajMvpzFZWpyOpx+/gY4l4HocR9Ui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060697; c=relaxed/simple;
	bh=I8wyRRLvbiMDBl8pklNldZigpLPCz9T9o6aSgEKTqvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2nIPn47U7KTMALfKdwl6sqiNc2JdtHlvMLWc6CVLLBEoYZaztuS1dLr2ANalZBJIGjOeDU/dkXJb9E8QYU5q0oRpssqf4s8RxKVnWEeSouTLlwlXktyCvkreBzt0OxHIIOGqoal1B7r/k/hujaHg8bQZZo8zuKG1n4CwaswY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJv59My3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-71b9d805f2fso56017166d6.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758060694; x=1758665494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d00RcpMSyaxo5uctkiUad7Ihu0StiE54G0FuRNxP3k8=;
        b=WJv59My3xtLKxrxf0DAuu53Hz2JA5asUEIvPNbFF9Ux6gue204UnV/zo3Nwg6jF5Od
         HMdoES20m0M577oo/D+p75jhtQeIeDY+3BzY5XisYphM/Suv3SSAG/ZyCy0TgBknIBry
         jywDXOWKvBmgkMgk52/WWvBqLBMJv+sdyG/4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060694; x=1758665494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d00RcpMSyaxo5uctkiUad7Ihu0StiE54G0FuRNxP3k8=;
        b=RBNFBBmc6nMbZGP+XvzW8uQEcj/EhYAQNgjdADTD370nweac+WMSOgHKS2lD7ymCbd
         k9G83PRVY1om92Yt2wQVWGW/3OQlwxegnu4Bx9qt04hBctei0t+Zqe0xDH7eNm9eerN4
         QEuPaBO8Goi31CrOq/OnPQWE1jiTtVhUDEtCAtaE6OHrJ/5lCGwWlKSGHAlso/YckDLG
         YP8F3UOI2xi2BxtNGUc5uabzauGrwqVvd3p4QqYam/+Y7QoLWBRFdvj87ocvt+lgxvvN
         qJzDp7oOC6fwYtk1rN0PhZjw6cYyJFnC+thY4jl28QjMYd+t2iFa4CNPhB3YAPNnfPOD
         YAQg==
X-Gm-Message-State: AOJu0Yz48nZrLg5kWF3O6nsC9x6qx1wh0TBulrC1ZoagtEjQJ4njayJJ
	uiNDafq9JTf4ecbJyyKUAeaR4TD3N/gsB7wg7Hkxe4GBCqRu9Hf/FgaoohHrQ857lxc=
X-Gm-Gg: ASbGncvkjaEpGm2gQjjxcc9vfwXDinpYe7snLfgulHTHzy9DOIb0i01zDcJBcIfXmHW
	EvrB2mPGu7Hiaj+4YWwux2uvpMPEuADS1Rdx6RKftpmhhqYYZASGLeLPVmxnfhgEbnGmRjWoHpv
	Sr3Lth82u5m2nuyLx+bidEDZ035HSpu4E0LCXuEhNUkyCl26HwBgT+Z07mpFkP4JkM5EvrD6or/
	G1y4I9Z0qyR52pZV87UPw/ZgZakVxB88tLTz0/iSBkZ4ctpNeoWgi6cS7hEo3kFucZa9LWyjEIf
	mX+dl8O9qM4TP7RmVW5dAWCJeApNNZrF/labL/4acCz2TyPG2C4Oy9pC6dDCY7wkFuka2EjcDNt
	pQp35QI0Tn4b4RzawpoFzq3+TwA2f8DtaqbncLF8PfZrfBrCo5E6gdpBbog3FizRtL1os6CzIxE
	kOM3ydrwVw7263yfi8blO5gx4fy0ICb4faWMZAuCbWFoQ=
X-Google-Smtp-Source: AGHT+IGMUpImZ6crknRGU2PsJlxv8cDUNX2ZESpVJbIPemvPjmHSaTDNVGyZfiAaKH0MKZWsfkHuzg==
X-Received: by 2002:a05:6214:2249:b0:779:b212:3efa with SMTP id 6a1803df08f44-779b21240aamr129726246d6.3.1758060693830;
        Tue, 16 Sep 2025 15:11:33 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bfedb916sm100684966d6.57.2025.09.16.15.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:11:33 -0700 (PDT)
Message-ID: <61f224bd-c82b-4f16-a127-f337bc60fb4b@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:11:32 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/cpupower: Fix incorrect size in
 cpuidle_state_disable()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250826065440.2908389-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250826065440.2908389-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 00:54, Kaushlendra Kumar wrote:
> Fix incorrect size parameter passed to cpuidle_state_write_file() in
> cpuidle_state_disable().
> 
> The function was incorrectly using sizeof(disable) which returns the
> size of the unsigned int variable (4 bytes) instead of the actual
> length of the string stored in the 'value' buffer.
> 
> Since 'value' is populated with snprintf() to contain the string
> representation of the disable value, we should use strlen(value) to
> get the correct string length for writing to the sysfs file.
> 
> This ensures the correct number of bytes is written to the cpuidle
> state disable file in sysfs.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   tools/power/cpupower/lib/cpuidle.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
> index 0ecac009273c..2180e63c963a 100644
> --- a/tools/power/cpupower/lib/cpuidle.c
> +++ b/tools/power/cpupower/lib/cpuidle.c
> @@ -244,7 +244,7 @@ int cpuidle_state_disable(unsigned int cpu,
>   	snprintf(value, SYSFS_PATH_MAX, "%u", disable);

Can't you get the length from snprintf return? You can avoid calling
strlen()

>   
>   	bytes_written = cpuidle_state_write_file(cpu, idlestate, "disable",
> -						   value, sizeof(disable));
> +						   value, strlen(value));
>   	if (bytes_written)
>   		return 0;
>   	return -3;

thanks,
-- Shuah

