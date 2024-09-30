Return-Path: <linux-pm+bounces-14974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D698AD83
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 21:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77138282313
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 19:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F519DF4C;
	Mon, 30 Sep 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7bf/H+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25F19D8A8
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726131; cv=none; b=e/k3qDdU7PMvaFLYapEUvDTRiVl47jhnk1xcQjuZbe7E6eEwkY7rmYcB/pdMMhbsYXJAkYREF4YLIKfShRP3p5+5WO4T1R5Xqsn4dvoFe3Xpg2cm5Ba0rLjHGYV1s9Mxo0oM0KUKXmVO9dnlBlDpHedw4dpf8t2alVEpf2r1U9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726131; c=relaxed/simple;
	bh=g5fMr9ssjRNO3v4PW6U1/SqvJs8wYDgf8jrXLBynUBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3sDTNUcQFrfyejfpCyeCCWrwxLivXR0298pLy1GtnPOOn4xsH2mUfS+dmZRKBtQFgAkiWE5ShuSX8FMRh4SMyxIV2lXE4wpo27lG64c6rIMwhGWNWSM8NIDYtj7HJox1GccFagKUYH14mUhDTbDc4p023t85Nrm/y15tocmgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7bf/H+c; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cd93a6617so195772139f.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727726128; x=1728330928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltFBB9pTQWA0tvRjbV8xqc5b7dISTnlzZOqkmzWgOeA=;
        b=L7bf/H+cnfdk+4K6/EsvfkrEMIm4Ud+caUT3llgkEor+Lw7D3F+J8HqTmu0iXiakkH
         uvM3YyiUOVCPMxUYzSe7CWqQ8funhzHS552auzDZspr8m0cyffG6GouPvne75DUu9gRH
         Wns1hSVrL9nmPWHDq6nV/BNRLR5yC/S/Xe2K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726128; x=1728330928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltFBB9pTQWA0tvRjbV8xqc5b7dISTnlzZOqkmzWgOeA=;
        b=FiLBYTcjA2vcUxl5WOREqMTcM6jLxFDUk+wwPM+B1zxzYX2Dnky9XnycKpzdBWqjF0
         DfWFGTELrYB1uss/6Rnhiu3zT4rIyWOHulrGWjLO5SllhOmLYBMctO7IqYe2kNIoHXVv
         C0u0Uw/j0CUHYjqk/EufviLuzrds7OTJKk4ij/qH1ern02AE6PJ86rDc78VM4LNt3dh+
         JryswgPhwNRRrEZp5cf8iVVEjO+dd90lpwi9ZJlFst/F7qQXTfimQG36HEn+WQvgdx/Z
         pkGl65IYlsBjb5YeaFHYadSNjHcVgoKOxYSX72fg/d2tyxr4G/bR5rXZZ/QBlV8cJTFn
         DMNw==
X-Gm-Message-State: AOJu0YyQaL3Wqiux3/YXODvr7X+MX5vRLfNXZy/+dbUoVkU6cNZ55lrc
	mSczcLNUDOSqJX1K36QHDw7uuac0WGy3yjHjnVtKk9jJtrpt+2QMUKlbIo/m15Q=
X-Google-Smtp-Source: AGHT+IFYanqJoCX2mOrtZ7bd/mpFJL6rX1n+AeppJU6W9Dg27ZEkQzm2qaOUtIaZ7th7s6PqkKZWKw==
X-Received: by 2002:a05:6602:340d:b0:82b:c70f:5061 with SMTP id ca18e2360f4ac-834931e636bmr999571739f.7.1727726128170;
        Mon, 30 Sep 2024 12:55:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9b30sm2268228173.171.2024.09.30.12.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 12:55:27 -0700 (PDT)
Message-ID: <ad442d07-4c04-4be5-9273-3970e7f41a55@linuxfoundation.org>
Date: Mon, 30 Sep 2024 13:55:27 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: gitignore: Add compile_commands.json
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930172330.7076-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930172330.7076-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 11:22, John B. Wyatt IV wrote:
> A compile_commands.json file is used by the LSP in tools like VSCode and
> Neovim to look up function and type information. The file is specific to
> the state of the current system; add it to the gitignore.
> 
> Note: the kernel root's gitignore has a similar entry:
> 
> /compile_commands.json
> 
> I am not sure why they use '/' for a file as it is used for directories.
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/.gitignore | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.gitignore
> index 7677329c42a6..5113d5a7aee0 100644
> --- a/tools/power/cpupower/.gitignore
> +++ b/tools/power/cpupower/.gitignore
> @@ -27,3 +27,6 @@ debug/i386/intel_gsic
>   debug/i386/powernow-k8-decode
>   debug/x86_64/centrino-decode
>   debug/x86_64/powernow-k8-decode
> +
> +# Clang's compilation database file
> +compile_commands.json

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

It will be included in my next pull request to PM maintainer.

thanks,
-- Shuah

