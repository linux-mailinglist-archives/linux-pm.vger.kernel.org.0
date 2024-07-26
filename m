Return-Path: <linux-pm+bounces-11436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF6F93D7B1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B875B20E85
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6496117CA06;
	Fri, 26 Jul 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gj/7IO40"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239018AEA
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015246; cv=none; b=kOtB2DXzhL3vuIYOeqAwT2eM/lp+LqsL6Z6Mag0S3W41yEEZcylLg7bT+kTs0AEOpeNnm/GEAY5xoOePSYmDbyVBo7CKCLdBmM/sLWFs3PyNUH1IoLfky7b82+TWs+6uefu5Zd2nWgaB+/dV28780xJAVDa4rYKx+h9bmdvUkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015246; c=relaxed/simple;
	bh=Oq3oSVvwbA0xqvASyt1GyooPFG/hXeZKO+Yt314jwvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObrvBlZIPVRvyC3zT97lSAyHxN7bZI8LrfG87SW76KEYbCOUsjMf5UAWfRKqYrnsUTQTItVEFEwlc5zCgkaOkWPQQ1IXtKFxkMLXi/gzeJhjU/+PTR4V/yTts8ophZ57wI7zpww3hzE8xODNSUGS8DDTcXHons6TV56mI5xuleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gj/7IO40; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-810ca166fd4so10652139f.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722015244; x=1722620044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGWAAZ/TwFj1rjTRKhy5wZKUVAmZrurARosOPYon/m0=;
        b=gj/7IO40tyNI3njlccKjPcusYW+UZyQrKxuzHCMDrVNCIr90HoHQd0IfXI/SMdSGbe
         TRtwxDLniGhDURfyDF0/l5uHGlZegIG/p5J3GLUaYNs+cno2DFqQKZrg35prPo0uEPAT
         amYD7i7TKUEn34qndeeSL1UeuIBoKrq0VDXi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015244; x=1722620044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGWAAZ/TwFj1rjTRKhy5wZKUVAmZrurARosOPYon/m0=;
        b=MNOVovr4xtZJ6qrKEq/kSTBduBIlUoS6aibUWfIirDxV55oOUd+YejUS9NXzZRH0ta
         h0bmvbE2i3K8X+qX3Cnqd6uw1nfGxlYF2BoIsbof8wn2MpaaaeKA3EMibxSPAJ+ajIBX
         fkfyLYKljTlWSygn+ao5qnf6+xIu8sRGS38lJd07SCy7o58RjHmbN5d4hxnnHBQpWmyy
         FXhbUwXOpCLAKQkCGgNTqDskoJ6l6k6fBypf0GI5Mgty5XZuVB+5vYiDtMwh+/zeIr07
         nJoY6Y/HKmgf/D+xJwXYr8GdjvmhCj3CZuEefuK5GzjUSBGjkkGazVfjTTzuWGFSTJi6
         O+SA==
X-Forwarded-Encrypted: i=1; AJvYcCUv1pOHGoqKWNt8VQg7M5TgTqhkNr6yWLQbyfTskCiwqtaTanmcZTUI4v5+nyVHhdZ8nU4cFE4igw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8Fu0lwyPKlaPf4KgmMjHzpwEdudgQeB6nfPdETE+IuHWbdiV
	XpsZ36wJQpMYHQPUtUYzoxdaOI3sLqVtpU5VDjUdh6qLlLUJj5TAQxxjpIrC4Ew=
X-Google-Smtp-Source: AGHT+IGpm5rbSYB9NckXpuRjYdsG0WfyAnzpN1Zyr9cW9FXYmVh5cHRZUmbyT5bfYLtXkTU3XMohJg==
X-Received: by 2002:a05:6602:6504:b0:7f9:3fd9:cbb with SMTP id ca18e2360f4ac-81f7cfa447amr453793239f.1.1722015244000;
        Fri, 26 Jul 2024 10:34:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa9af9bsm932923173.53.2024.07.26.10.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:34:03 -0700 (PDT)
Message-ID: <47892c73-285d-4b3a-822e-da042be49d68@linuxfoundation.org>
Date: Fri, 26 Jul 2024 11:34:02 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>, linux-pm@vger.kernel.org,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240724221122.54601-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240724221122.54601-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 16:11, John B. Wyatt IV wrote:
> SWIG is a tool packaged in Fedora and other distros that can generate
> bindings from C and C++ code for several languages including Python,
> Perl, and Go. We at Red Hat are interested in adding binding support to
> libcpupower so Python tools like rteval or tuned can make easy use of it.
> 
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
> 
> Another question is do you want more test files like the .py example? Would
> this be used as part of a greater test suite?
> 
> Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
> bindings code, is permissively licensed. Please see
> https://swig.org/legal.html for more details.
> 
> John B. Wyatt IV (2):
>    Add SWIG bindings files for libcpupower
>    Include test_raw_pylibcpupower.py
> 
>

Quick note to let you know that I will get to this once the merge window closes.

thanks,
-- Shuah


