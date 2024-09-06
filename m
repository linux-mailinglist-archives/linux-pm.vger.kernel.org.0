Return-Path: <linux-pm+bounces-13809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7156996F9B1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0151C21827
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B521D4601;
	Fri,  6 Sep 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pm40blkQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166AD1D3656
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642159; cv=none; b=L1ixHxgPQjqvk9H1p+bGtScifFM9btGu+6Vg9u7HSFQ2nI6CROQniTjD+qyDjj8/ZGQmxUfY3/JGk9RFeWbDXhRvFHAJFIyq/Ro6orqDnWVDJvWo6eRq/gAdNa8fAMVk/3prgJ3Ugc7xtk3Jxk7e6EoQnS4yN4P1Uttoc+jpZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642159; c=relaxed/simple;
	bh=mU+7YTbY2cbC83aTzs5Q7wMols2wjhBlt/E+BMmwOnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+EoGnTssfNnyXoypOph/2zrLDyDDh8P9I0AKxcUY+c5KM1HMOuZkRP4fzenxRO2ZAWGY1SnZ+kD1KolytpjmXzGbH5mykRgV0J8sqwnKluSCN3gwP40w8R/OCQajFeT0RIg6G0blBGhYmJ8IRLTzIe7XZWu7Ezs+mSgKLMdobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pm40blkQ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a24dec9cbso66286939f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725642157; x=1726246957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTYtTrezlEgIHIrFQym2IVARwbfSxyG8P5tjZUW2MiQ=;
        b=Pm40blkQlRWfLxsyKRkO26pgDLdEEoOm7C1QmP+dqPUWh8m4/voQw30LS2J8EKLy0y
         QX2D3Ei2HFnSUHbdyDz1KS/kU4G/ylyNIrofIMBjsVm0Wshei41h185zNsqtJqdEXMM0
         AzywDQ9MF88DlQ/frR1GnR6le87asZpPDB+y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642157; x=1726246957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTYtTrezlEgIHIrFQym2IVARwbfSxyG8P5tjZUW2MiQ=;
        b=EzoooNlZrj9VCMKFWzSm3Y6+TXFY5M/r+jhelHoHln3Qmb+UmGeN7imw5gXLwZHzYC
         2xKcECrPd+MhJcZALf4v57vGoPlqvtT++KHTLlGUEOYTmNVHQqFu/qnyG7ic3LEq9cVr
         QDjALGWwvdNJ0lLZtku5AwCPBWzoJ3pu/Ja/ogI6WdZx/ChTqb7O351VW0WNS2cpnqyT
         bLklrC6F5Kh4SZnlnMdvc4sELm13JsdA8s9aZ8Ltsj0yhmR5mxDEZe8YmwgQHU71dBho
         Imr6Sd7uzvnHokNse1YfcIrf6z403/K1Cmy+1K4NG0wmtI01MdBWwhp7wCZE+5mcbMkW
         sorA==
X-Gm-Message-State: AOJu0YwV5sXajL273JMI/Pi80QhvdKdJ0z1d2yb8YmvR02hz6XUi67bR
	5SaPrPtAkyuGYJDqm5RCnilDtVWBcrI3WGNCn9eDppZ9t2ADLqPcXnOs6sAyG/A=
X-Google-Smtp-Source: AGHT+IGXlEq3ar3gi4kyu08brgXzSlzjKQHvDhfb600baLQW5Hf17R7js0wEVkytHgykuGGrPnOSww==
X-Received: by 2002:a5e:cb45:0:b0:7fa:244c:bfe6 with SMTP id ca18e2360f4ac-82a7920e3damr949307439f.8.1725642156913;
        Fri, 06 Sep 2024 10:02:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e9632dsm4161190173.93.2024.09.06.10.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 10:02:36 -0700 (PDT)
Message-ID: <29d23b0c-02ca-4087-b96b-c24767f64323@linuxfoundation.org>
Date: Fri, 6 Sep 2024 11:02:35 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pm:cpupower: Add error warning when SWIG is not
 installed
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240906130010.93773-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240906130010.93773-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 07:00, John B. Wyatt IV wrote:
> Add error message to better explain to the user when SWIG and
> python-config is missing from the path. Makefile was cleaned up
> and unneeded elements were removed.
> 

> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>

Thank you. You don't need 1/1 in the prefix for single patches.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupowe
for Linux 6.12-rc1

thanks,
-- Shuah

