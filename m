Return-Path: <linux-pm+bounces-42507-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBLyLFKmjGnVrwAAu9opvQ
	(envelope-from <linux-pm+bounces-42507-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:54:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06A125E05
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC82D302803C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C32DB7BF;
	Wed, 11 Feb 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/+yXU4w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38C3016E5
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825236; cv=none; b=gBAuiF5zz8ivpDtpFNM2N16erZSvg/67b0/hs5muAsTBAFExVeuqwqlGHHbQ/dNH6kzs1+H1TGoUMts5Abx5LB9AXj2RAFshFCzDKVvmpPLSlL7liVQ0roFq6oPA5ivDfVwg9kX5sZQHdVyTloJkIx4hWOe0x3zd2BU6odEcKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825236; c=relaxed/simple;
	bh=WxfAAHB5ctT4iS68tPwOl/boTkbbZfzu/6Ac5wJWpRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyAK83ZFwNUmg0FQ08jsRndfn96i/8eUPVx/90yudG6fZ8qtt+xk0rAhfO+vOYA3Ac4RIt7PAQbNEnMTUEH7TA5oIpjFb0B5kDrD4kj5qO/fx8P2ZocK/W0QOASSJ+UfRL+ApfLZc/ZsevRyb+903k5c0EvjHRyHG7Xqi0Sn/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/+yXU4w; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-354c6619a07so2117305a91.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 07:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770825235; x=1771430035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zE7ZnfqRE83nY0yWWcy2e3GsbSfMVMaykIbRDfGHfaw=;
        b=T/+yXU4wADlOa+MGpe1LUTh9Xuq2PhsEmtg0M89PSprdrlC6W34m5p8Zif/iDVrwMQ
         aLGYmIichR/XpwahXKT2olsxyw/eTnZTCHWNiVTMzYLSWEU95p+maIBXtLMBh0deyH3l
         dp6FtGo4xOTNslx/voZxUgGk845+75mZ3E1/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770825235; x=1771430035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zE7ZnfqRE83nY0yWWcy2e3GsbSfMVMaykIbRDfGHfaw=;
        b=PrJVpB/wnRQ8gVtPDmyxyHIuXk3PFDKiuApHUguV7nhf/yKP2KfbPhl5+QIsRxaDN7
         6rWkm+jV6GprXumqayjGFB3M8q0hzP0rqM+8MxY5qgWLiN9FvAAljb4mDr6U8SvhKqf1
         WljvXuDCuNS1WDTOvSjgxxBuiRLNhhPv2YLwM8PUd7nuej+3myRspe9/ddZieW0lfTjZ
         enCUxC+VSy2DMgU3RQHHX3MD8gZdjoXbexcDM7vhMizQc5wXr9i8RcQyIWSNI47Wp6/T
         FMPiDuz21Gpyvavp8xQmJrw70wTGo945KxqsXxSZLA1Gug/cDx0HYXKdvII/OzEHAcqD
         vzAg==
X-Gm-Message-State: AOJu0Yx96K01wAmIQifg727xD7ntMI9GK5mogTwcE93u38jVDJIgltUv
	kch5zpbgMuWzY3s31DQvWKjjT2xNtE5xi53O6FkzvemzHuMdDpQ5hCyg29l6pxe7wec=
X-Gm-Gg: AZuq6aLVAUySERx4VRLwYXG0gGb3G/84/PEcu9vJfh2AVDis3hnIttSlxrd7n8JwsXE
	u5PxLqauE4k6PeLTBURRHZi1qAI/xMajUAOttI+isvkqfC4VmQ/jsAT+2ub64xUBKO/dcQLPzn+
	kNQRta4n/Tc+1M5CmtVtPkvoRmggi7tjGhXkV5P/wYY/o347kOG9o7UsvpVSs0iGNBItOLG77VQ
	ggvCcfja1wVW/HXDx3zGcgbZfVmDqx6eTRD1G2tb8Tl8D/E53gjGgxT0r4EMPfr7hyr2Cf3mTHW
	RpvvWr1s8T7kk0yK1BJ7hBBAzuEueRqXlBi9MEur8WorObciWMJpGh6y+XQ5eAKIaxsea4d4ysT
	4Wfll3YfIyYMnwqZCso9F0vyOmivFSzn15tAyEGB5JKM7/9YTUUAQVwlnafjufvussy5BtKjEPT
	aDApofMuEt2CgbkgHm4vmaBog9ckmPmzDbrOMyRwEkZBJ86P3UnP2Rssf6eyJplgtjg1RLAbC//
	15kugsz7g==
X-Received: by 2002:a17:90b:1dd0:b0:349:19a8:e00e with SMTP id 98e67ed59e1d1-35667d6f9a2mr4857255a91.31.1770825234643;
        Wed, 11 Feb 2026 07:53:54 -0800 (PST)
Received: from ?IPV6:2401:4900:234f:f3d6:4bac:b2de:dab4:8fa8? ([2401:4900:234f:f3d6:4bac:b2de:dab4:8fa8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e53936sm6530496a91.1.2026.02.11.07.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 07:53:53 -0800 (PST)
Message-ID: <861b65f7-6d84-41f1-a284-95e99f37fc68@linuxfoundation.org>
Date: Wed, 11 Feb 2026 08:53:49 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>,
 "trenn@suse.com" <trenn@suse.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "jwyatt@redhat.com" <jwyatt@redhat.com>,
 "jkacur@redhat.com" <jkacur@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
 <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
 <LV3PR11MB8768F16244C44C0554F1C4E3F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <LV3PR11MB8768F16244C44C0554F1C4E3F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42507-lists,linux-pm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1D06A125E05
X-Rspamd-Action: no action

On 2/7/26 21:34, Kumar, Kaushlendra wrote:
> On 2/7/26 14:23, Shuah Khan wrote:
>> On 2/4/26 04:11, Kaushlendra Kumar wrote:
>>> The get_latency() function incorrectly called get_epp() and returned
>>> error if EPP (Energy Performance Preference) was not available, even
>>> though transition latency and EPP are completely independent CPU
>>> frequency features.
>>
>> How did you find this problem? Are EPP and CPU frequency features
>> independent on non-intel platforms?
> 
> Hi Shuah,
> 
> Why do we need to call get_epp() after capturing the latency?
> 
> The erroneous get_epp() check can cause get_latency() to fail, even though valid latency information is available.

You didn't answer my second question about non-intel platforms?

thanks,
-- Shuah

