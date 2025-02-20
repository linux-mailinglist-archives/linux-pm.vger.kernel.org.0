Return-Path: <linux-pm+bounces-22557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC150A3E0F5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650743A6061
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBF1FECCE;
	Thu, 20 Feb 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hf+pMkWq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D19200BA8
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069207; cv=none; b=Apag04U5CtSoejuPnKU3M0vMbJ+CwgJZSbb9PqX3g87pahQOdtQkyUEjihu67SgCRxxGlU9r+ENPpTUAkMvwRf4oYdOwfLdsrCyljnKVtjrCZZfSGDzCvbSdA/xV1uwAYgVQ5kCH76iYNQCi3hD0vUHVrnLvW+prdbQKdhgcN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069207; c=relaxed/simple;
	bh=7fiCUVGvnZKBNcDUsUvPuCzPc7G+wMawo3kXVYzlUR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFhoNzmztY0tY0i025bJ5z2FJSE6ymulIUW0CQg5ivdjgcsCgIScNqwCBt/nzgHOe6QiS1daHy3DauzUl9WMxB0vRmObP3WxO57buoJWp4uDVOgpHnpKo10TsYCpbj/BfI99PtoDsEgkGky+SZs9JXv6ENsbUDSnXTBFXlOSrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hf+pMkWq; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855b09fca35so83851939f.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740069204; x=1740674004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKb1BncJOwIWJqWtv7Zjj0T3YozvuQ8tSWJ9NbLs/tk=;
        b=hf+pMkWqvsEspd7OTfPAB9MI7vPn1zeEBWkQyCTbiiQiHvVK9ZyiZmZUs21V9SPNTp
         lsmKWctZPLR6v432ip5yswfjuVe6ZqAMQlwA+YaMPiZESw8cf3bSbvD0aDH3ancDRj/U
         YtcahBnoAeB3etchG6Idc0MykQfCzz42NS13s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069204; x=1740674004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKb1BncJOwIWJqWtv7Zjj0T3YozvuQ8tSWJ9NbLs/tk=;
        b=X8zHVobb73A/UttjjeZ08eIibRf7klS0vfRxabPZFhBswwtc1H7vuNE7t+sPiR3X+g
         6HjQ9Tq6YQYHx7h0/rOCKhJ/oGt8qEg25cGPJrk+oO7smJJE/IdgcabfwMNhB4NQaN+P
         3K14XXXQ+5NrluESaf5zY9VsRVNbL3Lfm9zdB2j86k3zLD4t6cGbbdrN/wIALlT2mT/x
         BE5iRp45DRx41RcoY0Ai8C773aJWsAJR7jH8QrsVIBwIteWOraVvrDuLrMoPRGqD9a8R
         ONQ664qCgMNDocMWwiwvLP/R9fPsgb12jokhYAxSoIUAXyaDSnIezYvJMBNomE0Rav8y
         9TuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6jHCHaZ/rphweTAKlChtgpRWuJTrLaW2VQs6HsMUHfM9XZr+NshXqCiAe0xKN5TnGl/4/mMaQ3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPOxsBBHYM94GO/FA5GxBs5m4KgnY+GbVjZDUPno/JhEJscll
	vDpOJ2oK2I1+3xgY/a3KaMbeD2/OaDEH5HOzOnKIA3q8YO+bTkZSX2a17S37ZIg=
X-Gm-Gg: ASbGnctglRKD2bIpaJxOZAeKYbr4QRzIzhS35vWuo9dZ1zxOhpHvGdIFoLSWCchopA7
	MjzfC9SZUko1xksTfq0A2dwGhZEGUptOuwdDSY9xm9mumh6xnnsW7fq7efl838qzTSiDeO2v4AE
	BZZR7lKahYhvzUAaesyP8MjeNrlf0iVX+S3rHMV5wr0cjYUhsVOWr1zJYeKIhJQE7aTeVsDNKIZ
	vaAfyCIwRuH1DGfRZvF9+a33nJWOVGc0jvdRoyGw4rST9Q3UtYgtdd2UKbzwvhMBmf+Ny2BNYN8
	yfMPc1y5AVnsJgLbH1jvmSR75Q==
X-Google-Smtp-Source: AGHT+IF6yVD4wsPjyz8e2h/6OJoszjWF5yxh5mB4Bsk1h0QMP9lLCfi4Ha2lyGFIlqFEjO+w/xSR3g==
X-Received: by 2002:a05:6e02:1689:b0:3d0:21f0:98f3 with SMTP id e9e14a558f8ab-3d2809a9d26mr253833345ab.21.1740069204058;
        Thu, 20 Feb 2025 08:33:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee8b1db680sm2541642173.58.2025.02.20.08.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:33:23 -0800 (PST)
Message-ID: <24f77be1-5b91-4b4b-93eb-4be5d8bd32c1@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:33:22 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: monitor: Exit with error status if execvp()
 fail
To: Yiwei Lin <s921975628@gmail.com>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220130529.4515-1-s921975628@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220130529.4515-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 06:05, Yiwei Lin wrote:
> In the case that we give a invalid command to idle_monitor for
> monitoring, the execvp() will fail and thus go to the next line.
> As a result, we'll see two differnt monitoring output. For
> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
> is not executable.
> 
> ---
> V2:
> - fix according to review from Shuah
> ---
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index f746099b5dac..7f8958f68eaa 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -6,6 +6,7 @@
>    */
>   
>   
> +#include <errno.h>
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> @@ -294,7 +295,10 @@ int fork_it(char **argv)
>   
>   	if (!child_pid) {
>   		/* child */
> -		execvp(argv[0], argv);
> +		if (execvp(argv[0], argv) == -1) {
> +			printf("Fail to execute %s\n", argv[0]);

Invalid monitor command will be a better message than
saying "failed to execute"

thanks,
-- Shuahg

