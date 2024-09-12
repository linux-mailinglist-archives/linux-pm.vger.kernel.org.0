Return-Path: <linux-pm+bounces-14095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7A976D86
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35065B22E92
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0F1AD245;
	Thu, 12 Sep 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gl9HjWgx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472621B9B3E
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154136; cv=none; b=JkloDqYnk+Wwh6X5uTRuMeipqDup7A47agoWiuYhpcrCGP3EWUtiI26x08C69Dcth5MFeLH0AbaZMaA8Cvp+VP+LlpqR8d+P6j+KYDYDH9VwBf3/XA4IRTMDLSzxUzBEZ/QT6RTWpqt5n/eibAEDew4NjiEiQuh4pRxPbcj6yW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154136; c=relaxed/simple;
	bh=ZPx4h96mRwkldOlgceAEmagWmM1V8EKIPeCKc7K0/Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U9sIn4M70JNoC5KcQ3v6ENsYkmeyky36kMOP8aIwbVh0w+GfMU+YHBEBSwevGyVQiOxfCCUI5Xf0l6bRNqoeP4XfVT28JGHqke0RLeZW1/chd+P82BwTXd4z91fNbuUJO/nR5pgqwOuo/o8fm0WvYbHu7aJbqLhghpdob0P1aQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gl9HjWgx; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82cf3286261so43779639f.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726154133; x=1726758933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qsd4xIZ2+CjD4Q1wOFyd3+yQAtEqnkaWLKPfVRRwPdk=;
        b=Gl9HjWgxMVzvH1ehkCUaa0kBrXD4Nr8q/tgGprNZhoBRRjuPUHOaU6ESDQjh1W4wZj
         KV5Ytsti4BapSYH92+m0if7uOsMzYNq4gfveUKaYvfvf53AKm93bI5027xOf3MK3pjon
         csX9U8rp4rcUH6APk+0cEF5u8dXnh9MV4MNO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154133; x=1726758933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsd4xIZ2+CjD4Q1wOFyd3+yQAtEqnkaWLKPfVRRwPdk=;
        b=pvKsjP1K/mmStIB/aD+HpRr/1cWklBjj58+DG+IqEEWyhgscZZ6/K1+/Y7Bn9ZELy3
         ptPB5o/V7Bg91hvpmd5Ciw5voVgL91IMnsSmOrcj0LP/HorXErkf1rPWFIWsO/3oMaQe
         wK7HbfB8JpAQ5bS67u/fjwIBHgUlQRrkHUSczzJwZCSX4Bj5t1q7l9st/HS2r/ier+rA
         rrF6NjftxoR7IDSKMR29i7YsLS0Kc53Hf0dn3KuGKFMuoeb3rpVHH1cOGkBrlW9K3hAm
         Eeh4cFSCvcduPC5JWj64kJ4e10/gVhYVYXr/YJprOpCSDkaVd4wTXRhhRuqjUMPORj49
         tmJw==
X-Forwarded-Encrypted: i=1; AJvYcCV1d0wK8LvXgV74zecobHhgl/5Gmv52cZD8hrnCZ6Kr7KgtNuVuV14PjYPdHiI1kdYQyIkyiuIxew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwx9d8vymhCIfbbAmOKZxw7YaFIyACp9/gDCNY08GMmUQOEuf6
	RQK4u03/9bR19VeCBWETuv1ZnzJd1EkUR0I/MIF+1/GXlZWd1z6eCEMu4e0VhPs=
X-Google-Smtp-Source: AGHT+IGFR+J+i/XR3KgbXvrHYqHt6yJiEXDvvVlLm27Uhq8xsIv+4DM5IjAe0bIdrqg/kJJSPOQBiA==
X-Received: by 2002:a05:6e02:1708:b0:376:410b:ae69 with SMTP id e9e14a558f8ab-3a0848ff007mr31017695ab.15.1726154133134;
        Thu, 12 Sep 2024 08:15:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0882aae74sm2171745ab.30.2024.09.12.08.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:15:32 -0700 (PDT)
Message-ID: <e4d79b9f-3a8e-4e54-9033-cfb8998d06de@linuxfoundation.org>
Date: Thu, 12 Sep 2024 09:15:31 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 19:38, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Print out the config file path when fopen failed. It will be easy
> for users to know where to create the file.

Send these two patches as a series with a cover letter.

Also what is changing - you can include what change: use the
same subject line in here.

The subject line can be improved to say more than fopen() failed.
Which file open failed?

The message can be informative about which file:
  about which file.

e.g: pm: cpupower: bench: print config file path when open fails

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   tools/power/cpupower/bench/parse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index e63dc11fa3a5..366b20f9ddf1 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -166,7 +166,7 @@ int prepare_config(const char *path, struct config *config)
>   	configfile = fopen(path, "r");
>   	if (configfile == NULL) {
>   		perror("fopen");
> -		fprintf(stderr, "error: unable to read configfile\n");
> +		fprintf(stderr, "error: unable to read configfile: %s\n", path);

While you are at it, fix it to use strerror() instead of calling perror()
followed by fprintf().


>   		free(config);
>   		return 1;
>   	}

thanks,
-- Shuah

