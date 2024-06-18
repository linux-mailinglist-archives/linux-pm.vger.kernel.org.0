Return-Path: <linux-pm+bounces-9510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358190DD4D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 22:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B749D2823ED
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98516CD01;
	Tue, 18 Jun 2024 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ffTN8y3u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF415E5DB
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742136; cv=none; b=JbX+I1GeTGSkKSO7SHLhkvFz9xtHvew2qnvDjX69uBILofst9Q2uOkYw5Y5LQn2LFNppePokhOo24dyPZNfSyxxc2d8qI/y2KlOfJiFzWg+7kcv/HHWlAraTGPHrf95nhC/VzKSoTGf9j71ICDKqKjY3eya4X2KKwgDB9seYv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742136; c=relaxed/simple;
	bh=ruEwwY0sCQgIx4+51Mr+KTsL/uQU36KsSPbTkDJyj4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB5v/0QuMgxZSNJQn1VPF2EiZvSEUeM+PStONB4anrFvjamT3vAMJw7wk0sSRabdRXNDwn84LweQiOOm9sWv2O90GKEgXj9PkuVdZ1OG0c6X3mlbGhWkKk7Y6BCaRPui5RhVIcBl47LSZDvxnmc+5PPMTGidXR7H6Irah5M7lWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ffTN8y3u; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so2999505ab.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718742134; x=1719346934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OD3hjWlOreueuZ2eKAGTshwNE/qfElO5xeeHy8WIAhQ=;
        b=ffTN8y3urhcX4LBsgrcWlZxxhNxD7pRo1Zzva4Iap1XLRTFz+v8cyZZhQeiOhSLv4g
         fW3n/Uy1MiODrBsyJs/za6CqRnqZ2S8/7Jk1htUJRksRHMjakqg2k5J/d9hxWhpFnly2
         UiqqiKdjA4QaFmwOteEgoTVf7IA2zlHoNxSdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742134; x=1719346934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OD3hjWlOreueuZ2eKAGTshwNE/qfElO5xeeHy8WIAhQ=;
        b=QbZVv2paVcj6un5hDmvpNewBGj/PZj1kB66yOrLYACaEiEzEv4lzmhIP9uEcE8f7QJ
         F3ORurO/70bPMKwzfIgthaeaULiZy3go7HKDQuK+M6j/bo05PUH1NxZDmHxGqRsYn9R5
         kJhg3v3Jg3iljhB7Ie3j8a2arn56ORkIJQvvnAv377sYvl2HkSG+Xs95EKf2Gwq6ExZu
         lK4qZPOz4QM0h5gzxnt5ulbi4am7T8kZ2YHMyGUFCjle4oR7K11fnmtVWCftdNEcjYP9
         FZriQ5kE04A6QujiMC3i8J+y1pVGT1mx9vGFrLdF7IKtOg2OW/rWx5qTTjTboAbzdINY
         SIvw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBaeTRONbMuKw5m9HgyNuybkq8W+2UhzbN40TxnmqLIjkyO9oVJYjDbt+NFYT6gyg+dMvde+cBW0bPtr9JTtm5zO4OV3cWUA=
X-Gm-Message-State: AOJu0YyLQhQLXkmSk1n5hlkIHDsZXKu6x2vX0HlInn/qJdI09yRillaV
	ExvYmTQyTVo792ZzJ7PDwJQxbI6R3N0FmKkggYAs1KA6GH83S0DTyywk1n8+pRQ=
X-Google-Smtp-Source: AGHT+IEKrbwpMAjzjfhp85KwcKFf7Fg/nY7eNZEcazaP5FLtxaCvOFmjeTpwJXw8irpidJKaiyifiA==
X-Received: by 2002:a6b:7203:0:b0:7eb:f05a:7d4d with SMTP id ca18e2360f4ac-7f13ee8b981mr94008039f.2.1718742134360;
        Tue, 18 Jun 2024 13:22:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b95696ae3asm3331249173.75.2024.06.18.13.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 13:22:13 -0700 (PDT)
Message-ID: <d47043de-628c-4f9e-8791-a2a8dbf4ed21@linuxfoundation.org>
Date: Tue, 18 Jun 2024 14:22:13 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Remove absent 'v' parameter from monitor man
 page
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240618-change-mon-format-v1-1-efa263a8e286@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240618-change-mon-format-v1-1-efa263a8e286@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 13:21, Roman Storozhenko wrote:
> Remove not supported '-v' parameter from the cpupower's 'monitor'
> command description.
> 

Nice find.

> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> There is a '-v' parameter described in cpupower's 'monitor' command man
> page. It isn't supported at the moment, and perhaps has never been
> supported. When I run the monitor with this parameter I get the
> following:
> 
> $ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -v
> monitor: invalid option -- 'v'
> invalid or unknown argument
> $ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -V
> monitor: invalid option -- 'V'
> invalid or unknown argument

You are burying important information in throw away text. Please
add all of the above text to commit log and send me v2.

thanks,
-- Shuah

