Return-Path: <linux-pm+bounces-9704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8C910E63
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2652841FA
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121D1B374E;
	Thu, 20 Jun 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAJXyoxr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10A1B3737
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904203; cv=none; b=LqauD2FqYFCG0oLWlFUdFhU2xU6PxG6fNIBuEB6BOavG1Lz06+YRjNRrG5KKzdS3GY6i1TN3PYKpcnJd+pvU9PgVzZk6T0aU29Y8+5b+MVAKRV+p6fXqmUnkxSPamUH62Xg1xg6EQk09KW+VDWDkOKPnE5J2kqXRZgDAQFH2H3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904203; c=relaxed/simple;
	bh=iR1hJtv87pNQjsUqNnTsI+mBP3fSI2lFXI8PtdSiVJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxT//TTZCFlfu7yKZjYjtG4KZ1/ell1llCoL92MGpohOArxkQnH8EWGVzLKZ0UrIYaHBX3jGo3D8a/Bm0MUJ0v6t/6WBn6G1bDQnZPbMmz/XTiSz8CYg4DPkxsxBWfBBQqHQJnGJu3dvbXzFgrqrifBpPJFpVNFcuOWuDyeN77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fAJXyoxr; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ebac4d032bso2508139f.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718904201; x=1719509001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlU6+y4BHLjXwtlM+MZtrekLVfSINHVJwdH6Sy90VoQ=;
        b=fAJXyoxry3pFgtbr1sDUqIqeXGHrhh6sj37+c+kbMe6Wk0MpHI9hFovFUaOCOS7sLc
         GcXvS0Bk8xykeTVjpW2qPk/o75fofYuOBhacNKHtqQnhcbJOveAkBcoiC1Dtn0Io+oPk
         9C2lkWdvy0psLSIIpMcuFpfNCB9I9b41om45s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904201; x=1719509001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlU6+y4BHLjXwtlM+MZtrekLVfSINHVJwdH6Sy90VoQ=;
        b=QKOhPRxTUeznf5odNVK1kXZecbIciqTAw7URZSRo3ynp2zzFfITnRm6OMR3XMktw1Y
         CSytFoCjQD+PeeQSH76zxkaVGjpMei9VDJXAT+f+H3MoHukJ2Gt+8yQoL1aQgyIXIlnd
         BzvQWGk6uprHEyUqz84++aGxVaFq0CV/SyPNTeqrK9dxm/bC7/EJcBmp8ZEa7L+HKBmv
         uzjwcGW6kSZwHxO7z3d647AHYOHCesZAuwpAaTMk/Jy18fJkhOca12fqBXPoc2dvlt+q
         ULXX4ndVsg18iNPboxTzp9Q///zoYg/VqCABnc8/GWRWcWAz8XQt3wfnKVIs/QsWxsmJ
         D0Og==
X-Forwarded-Encrypted: i=1; AJvYcCV2lskUxWlGwWDqo6D3KzNlC27hkWEDx035WDMMyJTXvvaGJMQOcTq+8xzwuOVBcDtj34S1XzkE026LwA7oHpfNymwVVogBXe8=
X-Gm-Message-State: AOJu0YxsDPdRwUeauySw7Mk7rP1VevP4Wdvl/S4tygO7vORe4hClhvkO
	4qDvFNW9te40JThu+bU4TSpwYxAOeQWFeGKx0m8Wz6NpnMKQBN6qIo52ZMFHtYY=
X-Google-Smtp-Source: AGHT+IGWet0XQ+vzyT13uHf4e001ipaSD/KmPeZaAUUCneyTN6bP+l80PqUd4Z+6PSqDwRdi++onag==
X-Received: by 2002:a05:6602:3b84:b0:7eb:73f1:1357 with SMTP id ca18e2360f4ac-7f13eb9a591mr646959339f.0.1718904201518;
        Thu, 20 Jun 2024 10:23:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569ef046sm4644835173.105.2024.06.20.10.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:23:21 -0700 (PDT)
Message-ID: <78166e23-d3d8-4e20-a453-33af1689e6c4@linuxfoundation.org>
Date: Thu, 20 Jun 2024 11:23:20 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Change the var type of the 'monitor'
 subcommand display mode
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240620-change-mode-type-v2-1-8c3a499be64e@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240620-change-mode-type-v2-1-8c3a499be64e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/24 09:57, Roman Storozhenko wrote:
> There is a type 'enum operation_mode_e' contains the display modes of
> the 'monitor' subcommand. This type isn't used though, instead the
> variable 'mode' is of a simple 'int' type.
> Change 'mode' variable type from 'int' to 'enum operation_mode_e' in
> order to improve compiler type checking.
> Built and tested this with different monitor cmdline params. Everything
> works as expected, that is nothing changed and no regressions encountered.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Changes in v2:
> - Moved cover letter content to the change log
> - Link to v1: https://lore.kernel.org/r/20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com

Applied for Linux 6.11-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah


