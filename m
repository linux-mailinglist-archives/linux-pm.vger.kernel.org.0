Return-Path: <linux-pm+bounces-31393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42CEB110C2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC181C23B83
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9772ECE89;
	Thu, 24 Jul 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DBsE4oTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208854723
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381299; cv=none; b=iyIXv6YZm45dpnrDDb1aMbmIs8+BM/7dJes9IXW6Rpr888K0bFRS9IVFxwO2UvgarcMKEzs6i7WVsWzcPmId9PcF0AKWY1s+qEEIAg+RvmcEK5uTzyUHAiBxCSLllKzUe1jUBBxUabCvSMkToNXs18CPJipFU2HIrd68M1N544s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381299; c=relaxed/simple;
	bh=LFto+7nmVk/9DNgIsdyBeYPDr2MTNvHNhGUL1ft9WHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jG/UH88Qxn9K2ptb92BEo4+jQRjxZQpINzKFd0yqtuWGV48541TFI6QDXKehHnw1s8LoVVUf0rC+nRUYDaPR5XUOBLu4OTfbMdf7JkjQFXg/1y1dqm7AajQbTKXAioNSxMwFs/BhjjcrqG3hGG1RPN/YS7RGlrZ85I6pXlgBZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DBsE4oTm; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87c79b55898so25807039f.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753381295; x=1753986095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdPQZf7gEv0BC5TALPGgtfN6EoB9E9z3HERM82woW60=;
        b=DBsE4oTmYW639KR5DoypMBSXFHXkAv8BFL5S9JH7m/9xa7sPXXWRAs5XyMjatZmY51
         Hw5pQDyZNJVH+QpJSOZdJBhwYfuZISSz0YeenqWiIXyl8mCgI7eWSuZC03cH2HftkWMq
         qX3WDQ9Kqq8pMLGQqbFfq/TlQ0fxSSjZv76H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381295; x=1753986095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdPQZf7gEv0BC5TALPGgtfN6EoB9E9z3HERM82woW60=;
        b=ox0MuvKyS7lAQBkJJxHrCR1woR5//RzVKU5sDxEuiRDUSR3slwwHvk3F3CaGkBpz75
         kreXKbo5D7obeh3RSVELJhYDtOPu3ZMmpWBQnzbrpteNA+uO+xrTvVeyh4ILmeq0S0Ii
         wD1T1nehomzjP/iDjJfUEa79oPwEoHibuMzyhphIzwRYpFSweGIHk9veXqx7eIXmddj7
         bj/UDYQ3cMFS0k0GuDXkyehNA66a8CrtNqUo8y5BCnOtM1kMnZpD1mSylMrqN4PLFas3
         TS4v6I8HoOrRiDYEKBTSvatkPR43epdx4HT844l8/NzmUOztCF3asCkaUEmUQenTCR0P
         eYgw==
X-Forwarded-Encrypted: i=1; AJvYcCVKUv6M82EAjBFicVgIWyFwDIg/F5bZ7k3NDOtrXUsOH3s3NitoyollImVvTE8wYXIqB7HZDwtaDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUv42j5NOuX2o5/lmmhDqHHgeseGffnkIL33peoTim+o8cmNX
	Gc+jFx25uF2kPgG7IC980qx4LeEiCGRoeBhXqdTXJ0Eb8OiiwXIJp88MLiaWf/S9gbca5AbmuXC
	zths2
X-Gm-Gg: ASbGncuKa9WRjZa6PsJnIGR2Md1xkH5YItVYiGcjZkJZ0PD1oj6pqTMpZ5lIiYPM39o
	csvCzbaIIKdu3HdBC8NDOopLiFYZ/kZruGGrR5YOKrUuvmDnOQE3ZlbZ0nkoDRopTTfsw2JtfZw
	09wWwxF6icUqe+qTHj+Gpc5maprHJ1XHUCEvr347YCNtPQ9WiVzGp28i1nNjdFdgS4IHdon7WKV
	tvLKAJZEZn1dCAhL2hx9lGbd76+ZWjz7ydxo3IxCVRZ+szemp4U/wMMGEYC8qU9ud99Xe+o8KNh
	Mj0zNcApQ/67SSSXEtxCaXBFbKBVJdx83aEJUdqzvEi1rts4mEkeO7V94M6stevb/WimqcF6+d8
	5JDbMqIndbqPFHrxDQYc014jpEPd4ZQ8wRWboTpIMMr2a
X-Google-Smtp-Source: AGHT+IFhsUlGWWXmuUUxipbvDO2LKjfiJ3JY/g3kNX0QvZGP9clzEw28V4lNKY7x0ex7gVSefyCIaA==
X-Received: by 2002:a05:6e02:3b83:b0:3df:29c5:2976 with SMTP id e9e14a558f8ab-3e3355601a3mr130529145ab.14.1753381294729;
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508ae900b01sm563729173.0.2025.07.24.11.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
Message-ID: <54b648f7-2756-4db2-a6c0-7869b7ae37d1@linuxfoundation.org>
Date: Thu, 24 Jul 2025 12:21:33 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
 <aFWZyPs4eBwGcKPu@thinkpad2024>
 <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <aH_RecWNuC_UqUlx@thinkpad2024>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aH_RecWNuC_UqUlx@thinkpad2024>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 11:59, John B. Wyatt IV wrote:
> On Tue, Jul 22, 2025 at 07:30:27AM +0000, Shinji Nomoto (Fujitsu) wrote:
>> Hi, John and Shuah
>>
>> Regarding the subject, I submitted patches to cpupower, but so far I haven't received confirmation that the content has been approved, nor does it appear to have been merged into the shuah/linux.git master branch.
>> Could you please inform me about the current status of the patches?
>>
>> Thank you for your time and consideration.
> 
> I do not see any issues with the answer Shinji gave on testing.
> 
> I am fine with it being merged.
> 

Thank you. I thought I pulled these in for Linux 6.17-rc1.
It appears I didn't. I applied these now to my cpupower
branch.

These will be in my next pr to Rafael which will be after
rc1 comes out.

thanks,
-- Shuah

