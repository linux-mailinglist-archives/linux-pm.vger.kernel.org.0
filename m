Return-Path: <linux-pm+bounces-11720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC049421D7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E78D1C233CD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3E187861;
	Tue, 30 Jul 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VLlBVjiu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9ED16C86F
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372526; cv=none; b=EE82CQL6hzeHI5hA6Z6ehy/wdhFKpXYqgrtyx4C3vMhXQvNWMnP3WWP3/5QCGM/WtUYuwuDLTVikRY5j9H7SKVsxH7tWtVChI6r1h3e1odgYeV+wH4CdIlcjsWTg4rG2PmbVNEpWQ94delv8hhv2Sh93ShUdRgNrol+iabJrGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372526; c=relaxed/simple;
	bh=zlmxKJVeWA3oHd9G7AnfjtuKBtDzkCg3f81KvxTWXM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4/4vJcWq6eN/oIWihhVJnd92GDdaf4hrX0r1LNb90w4YKSelFWAJZTlsY+hHS/EQ9yDjnSD1E8mTXXa5opiSoDp55N3KBEPv5er0FbCk4LaMNiaXpTVBZzXOf4yMxbxBgiPVxRho30RAS5MHOMnTaSG5SCnTi0NBpUDcyf4JNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VLlBVjiu; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81d05359badso31598239f.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722372523; x=1722977323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLu6RgQ5Eh+YjjtGbbOi90zX8eXSiNWKUGxZbqoGkS4=;
        b=VLlBVjiucD+L2UWgKXXmdUeLj8eoh6cUXu2W5N3ZoYrzktQFb9v6tCe1n9nUehG2/g
         ib7zoWFkVzqp/4akte8Y2ZkNyZC1UOpHv3YiM3586SfnwUITXIostNR4krNC3nK1lA/Y
         DrbSllRJmiO1J6rgUOEfBCooNwhV3YZAiEmAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372523; x=1722977323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLu6RgQ5Eh+YjjtGbbOi90zX8eXSiNWKUGxZbqoGkS4=;
        b=AJkaK6gOICeiP52PwcOzz82o680KA2CEPCfRkBpp4cr6WXmmmymSSYNEVsUtTKkhIg
         NWZSUmqhgQbpFlyIgJKktvBGgcWzhUuRq4KRqjMmSsVABgrTRGkxv/xPN6ZvPXpu8fSt
         6sqeJVLyRJ6uVPLtoZkOL6f49aBxIRNUyiFjE0bIhQgUmntqQK8OGxt7NjlQ+qQpEZcE
         /tuzk137XPVLB1W1E9VWCbiCJ3neBhmvQWAfO+Tz2/zMbD2Ma19y3tM6EYHr29W+5qa6
         BRajmz0r7fS1dI6JGWDSVDPkNyn2yh7qdE+Kb86ty8uyUchJga1ZOALK8nJHGTLAVX1g
         YeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPpPq67EEaY5IIcMCcGO3JV9zYev89XmB8c6YULheEAansiWLBhUO82WlnzYzBoePwdeeUZ6TqLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuywGBCqw4A9EGt/o3eFIzA7PiSy4IuXbY66uI5t3lRi138a0H
	+p+YUMZWlGEasO2y/yu5BD1jOFDcH4VvOA6LotG66U47OF1Dla6EGoZpn1dN4RI=
X-Google-Smtp-Source: AGHT+IEwRQpKNrZno5wLNmW5oJckAxM93vvPkIbQfERqJ8kyjoJu4rJzPojTUWuKwzjcRO3CGCilfg==
X-Received: by 2002:a05:6602:1ccb:b0:81f:bf02:fd0a with SMTP id ca18e2360f4ac-81fbf0301ccmr155854639f.3.1722372523500;
        Tue, 30 Jul 2024 13:48:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa995f0sm2874197173.56.2024.07.30.13.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:48:42 -0700 (PDT)
Message-ID: <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
Date: Tue, 30 Jul 2024 14:48:41 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>, linux-pm@vger.kernel.org,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240724221122.54601-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240724221122.54601-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/24/24 16:11, John B. Wyatt IV wrote:
> SWIG is a tool packaged in Fedora and other distros that can generate
> bindings from C and C++ code for several languages including Python,
> Perl, and Go. We at Red Hat are interested in adding binding support to
> libcpupower so Python tools like rteval or tuned can make easy use of it.
> 

Can you elaborate on the use-case and what rteval currently does and
how it could benefit from using libcpupower with the bindings?

> This RFC provides a limited subset of bindings as a demonstration. The second
> commit provides a Python test script to verify the bindings. I wanted to get
> feedback on this before implementing (and possibly testing) the entire library.
> 
> The name raw_pylibcpupower is used because this is a demonstration example that
> only provides direct bindings for a few functions. A wrapper `pylibcpupower`
> may be needed to make the bindings more 'pythonic'. The bindings folder is used
> because Go bindings may be useful for Kubernetes or OpenShift in the future.
> 
> How should the bindings be built? The current example requires the makefile
> in cpupower directory be run first to generate the .o files needed before
> running the makefile in the python directory in a seperate step. Would the
> maintainers prefer the two makefiles integrated?

I can't answer this question until I understand the licensing.
However, I would lean towards keeping them separate.

> 
> Another question is do you want more test files like the .py example? Would
> this be used as part of a greater test suite?

I would like to see document outlining the dependencies and examples of how
this would be used. I see the README which says that

"Next you will need to install SWIG. Using Fedora:"

The document will have to include more than Fedora instructions. Instead
of a README I would like to see a document.

Before we go any further - we have the licensing implications to figure out.

> 
> Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
> bindings code, is permissively licensed. Please see
> https://swig.org/legal.html for more details.

Adding Linus and Greg for their feedback and input on this proposal.

What does it mean by "the resulting output, the bindings code is
permissively licensed."

I would like to get a better understanding of the licensing angle
since this code adds dependency on SWIG which is GPL v3+ to build
the proposed python bindings.

thanks,
-- Shuah

