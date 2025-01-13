Return-Path: <linux-pm+bounces-20353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F15A0BDAC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2649E18819B0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86E1C5D52;
	Mon, 13 Jan 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCmcKgVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30033A8D0
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786197; cv=none; b=mPmy/RP5zvgSSk2oOkiwT4SMBT1MnhI3ubqlMq2sS4yDVgTgfSOTTgwA5qL0qAFc5uUu5l4PH62hsrKMNvH8YKFUNEM01YFjj4ZN+J5bcWZMadT4C8arBM1aTTAjkSCdHAtHwfVnG3aWc8S+C57iFAogblHAcrHM/oi+TWf2r+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786197; c=relaxed/simple;
	bh=q9UKaurFTuhBnPZFCnQBR+mLk9QnRFoXkoVcvbEpr8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUzT7WUT4ioXvWJGcpVJYNPkqfqWIWAyAuPq6pQ/LYhorhAyECoj7EzLHAMiciqB2Bc7U9BpjldqnRbSXz406MsnPAIh5PJigQcmsEUo7xKE7sHtoXR215xw/Pzo1JMzsbMHanqEUd8MKjd49rbu6VCRp5V5muRI10zj77rKOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCmcKgVB; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cdd57060acso14492595ab.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736786195; x=1737390995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fDlN2wR9lbXaBkAAjT1/4Mke1eVB5abZ4PdWHu4Z+8=;
        b=DCmcKgVB/M6c8ipWhR0rlS5bkgoXmmp8JwIVE/mviVr0CFMYy83kLI8eHHe/u1dC1Y
         W1+uygWnhgUVWVfZARWRnwUnZ5hgmfnSVzszAY0sUoyter8O5VUM0xVl+r4H5tS2/8UB
         dHSII6zDcnhXBDBes6sTtgKz2YHHoRyoAYj5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736786195; x=1737390995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fDlN2wR9lbXaBkAAjT1/4Mke1eVB5abZ4PdWHu4Z+8=;
        b=sUT3kUw6uygkCuvxyCHHXeHOgSKoc8/aneQhS8ntxXwbmRT7YNTxynTYiTW2uyasDE
         +F5Kou1vxCAVZc4jlov7wgbQr5CYDN5qz8NKK4elfSYANbruIf7YF18hWuqmo1oA6EBF
         qOHYfuYCohB8Aun/JILc/3DeQU+8rEaCCpZNlMI2tqZaOU27THEIySuSWOXvijCbNe2b
         t5jfPism/2fVCQrzBEfpXR4zyhb1lTACVrDYKG7HaXPJxuj0ikt2LicaKH4zkjYVAsHS
         evkdahDr3IJb7CcAT6KiuQzVJZrOtEpMJRG9SngR/xptTnjPmeQFyfy4fhQ5+GmrqKnm
         TPRA==
X-Gm-Message-State: AOJu0Ywx/LNElrWyLcTHwlbzmPOtty9PFh8sF5G0fpHpdjeYm0zeb89p
	Zx+dzMYN+nhS3tq/HU7RpnLB555U9d4n/uqWsljwoMgbMAXGeCXncH/LJqTwaUY=
X-Gm-Gg: ASbGncs+dmooi7Ia/O9iQYNnsP+67vgRfFdGCL2smayjRpYO2gJLAnTy+2hyH/wAtvk
	/xRG/5iknbpf28onvFVSMM0l+6FNKL+kGNvQjMdXMgFsMeK2DXMVCG+sBzmEmdcwaIpYgCZfcJS
	+WZWmdd8Oo9ALkjq2GY6icDB45S6gIYbRzQ5v1KYjsD6xOmvO4THTtA9WsZr6Yzw4JnJBCDAT0s
	h6w10+F6eH+d+dREW+kvAeom5upKba69doVv6wgnDi0N0SzUmvIpf3qjWDQsE2aGII=
X-Google-Smtp-Source: AGHT+IFsrZ22e17zJUtqpJryrtg55/98d5DNr3yDC4VfBtu8H6dbeQCPQ1bPQxqND1qK7H844dmM0g==
X-Received: by 2002:a05:6e02:3dc1:b0:3ce:7852:129b with SMTP id e9e14a558f8ab-3ce785213f1mr12313055ab.20.1736786194798;
        Mon, 13 Jan 2025 08:36:34 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4ad93a6bsm27396715ab.16.2025.01.13.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:36:34 -0800 (PST)
Message-ID: <4f4ad06c-b2e4-4e3b-8ec9-85cb81e61ae0@linuxfoundation.org>
Date: Mon, 13 Jan 2025 09:36:33 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Add missing residency header changes in
 cpuidle.h to SWIG
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250108221852.30771-1-jwyatt@redhat.com>
 <Z4UdWpRie1ZsJ4tk@thinkpad2024>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Z4UdWpRie1ZsJ4tk@thinkpad2024>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/25 07:04, John B. Wyatt IV wrote:
> Hello Shuah,
> 
> Did you have a chance to look at this? This is the second header change
> that was missing from the bindings.
> 
> On Wed, Jan 08, 2025 at 05:18:44PM -0500, John B. Wyatt IV wrote:
>> "tools/cpupower: display residency value in idle-info" added a new
>> function to cpuidle.h. This patch adds them to the bindings.
>>
>> Link: https://lore.kernel.org/linux-pm/20240809083728.266697-1-aboorvad@linux.ibm.com/
>>
>> Tested by compiling both libcpupower and the headers; running the test
>> script that does not use the functions as a basic sanity test.
>>
>> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
>> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
>> ---

Yes I did. Looks good to me. I am waiting for Rafael to pull my PR
to apply the patch.

thanks,
-- Shuah

