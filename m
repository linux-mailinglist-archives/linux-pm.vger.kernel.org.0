Return-Path: <linux-pm+bounces-3333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9C848BD4
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 08:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2098B20E0A
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 07:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069579DF;
	Sun,  4 Feb 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeKjXkch"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C475B657
	for <linux-pm@vger.kernel.org>; Sun,  4 Feb 2024 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031457; cv=none; b=A5/I4lq7cFOf9VMRuC2HiT5ov3SnyY4W3u374M3yZXGYnVGnOZMP3QlDWgGiPGfEG5nMQAmi0plrh2HEej31WzGwfqGuyzLwJSHAs15SlbkfwnJxVJFqtnegBZIv3J28tjeMn/059rApwYXNd0KTYYnVAhQ0A5e/p/449XEbSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031457; c=relaxed/simple;
	bh=PpXmBZu/ttOrrnuRCVGr3y72VEUBIDGQLIInsAyMWEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLWAI3BvltkZCLn1BJCm3wUkBPJ8JjFO1bfRROgaD3xvxhZvLt59T0fQk18kmg1dPFByW9NVLGEYIWDB6rmHuVFSI/1wvi1grMDpucQB4TUZhFXOWxBUrsfXkpweKKB/8AsDjrFLzXd2GNTNkcLQ4CSGP+YdoWda9+x0yA2zffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeKjXkch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707031455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLETy/iNSKfFzyXqJhNJJwR2MY8g0ACyfE+gPoZ7mPo=;
	b=VeKjXkchSyqeR8Uk0kKugr6DiZGLnfGIUwpVD6SbFcbL6L+oqOlrn9D267s19bBMz23QjJ
	mpfyCRaACwcCW9J7Rqfy9jPLSHsB5S29pMbRBfMg0YBqwGWHIcWyEtrMfF/JTAS7QbjZyV
	9KI+prDktkQkcXU9fpaJNiw1G07aOZ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-J9QbNA0cMnGCtkMEynAW5g-1; Sun, 04 Feb 2024 02:24:13 -0500
X-MC-Unique: J9QbNA0cMnGCtkMEynAW5g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b250a4bd7so792495f8f.3
        for <linux-pm@vger.kernel.org>; Sat, 03 Feb 2024 23:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707031452; x=1707636252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLETy/iNSKfFzyXqJhNJJwR2MY8g0ACyfE+gPoZ7mPo=;
        b=vU6ZMShsM8kHN50iZL2s2Tz9388d6S7YwcoM23g2QHK3REvXfTsAwyFU3GrDWQam9K
         3M2u3KyCZ6B789OTqnfqTFyMFD2KplA8sr5nhTGChRPsOJ7b8qn4rc6AGvsNAnkE7Y5D
         jpdwmiXP3GtqZD+DOnPSL0CHRsgHLGwg0d+Mo7GPv5zZNcDj8WqH5NZZ88TbzcxhIvBE
         58tmNhiHeyjWKAy6MXdbFGrDUdFvxpwkQcr7QV2Sj8XZWfw1YhzO5fuVEe2Mtedoq6+X
         f4oo88Pzq0m9iPwWOiHRc70GUv9HZuvPSl5CT5T/8LwM4cqn8ze3PSvb+OJ+h/Nv9Qry
         zlzw==
X-Gm-Message-State: AOJu0YwBP+1caJchSEgIMJmI5exSm+BF1Ai0WRG1VGmUyaTWcjlpmECj
	uOKY4r3KGNIV8ldMo2d22JXLcKjH2nOe2obbm5pxzM4Sk+biD86H4nrJQAu9YEvvv6DQQEvAk6p
	KyAChvLiw1FK8kNOD+uyZ6W/0e77MS0y8dxINl3BJwYvw4aiNFuniWuOVotHGKwra
X-Received: by 2002:adf:e985:0:b0:33b:2471:9ff5 with SMTP id h5-20020adfe985000000b0033b24719ff5mr3256116wrm.46.1707031451976;
        Sat, 03 Feb 2024 23:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMw5edd8lPXARt8A2JFbHjrwLPmBc12RNW0e5ysvLp152+mHyQquq7fCBabJATf0C76BdENA==
X-Received: by 2002:adf:e985:0:b0:33b:2471:9ff5 with SMTP id h5-20020adfe985000000b0033b24719ff5mr3256107wrm.46.1707031451643;
        Sat, 03 Feb 2024 23:24:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYrNuqjyi5br+xZFq0OWe3dCqS9NovmmPjW6l/DKHV/zC0AYf+MMsBbowh7c60uXqe7pA3mWSNfg7qpg/VCOARIebqG8UH5NF+cMb75FCo5B7KV0QmBpr05KpZiF6N8N9Npi8VsUHmftypKEE2phJwkpeqwHU+G4h69RUxHqJ20WCMNIOuG4B8lWgq+fe9DdMDR8AFr6rxqSNxVX9FM2ZFROG66MzZPbw2t4v2Ov+nHQMEVrXaSPK+cXECpZPbq3f0OKK04z7xF35K6uPfECTJ
Received: from [192.168.1.149] ([212.76.254.34])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d574b000000b0033ae4a3b285sm5440377wrw.36.2024.02.03.23.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 23:24:11 -0800 (PST)
Message-ID: <a6093a70-29bf-458d-b981-bcd95af7b472@redhat.com>
Date: Sun, 4 Feb 2024 08:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: + XPS 13 9343
Content-Language: en-US
To: Antoine <debian@r2rien.net>
Cc: Dell.Client.Kernel@dell.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 pmenzel@molgen.mpg.de, regressions@lists.linux.dev, 1061521@bugs.debian.org
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
 <bc166c19-8da3-cd42-b749-e35eaebe7822@r2rien.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bc166c19-8da3-cd42-b749-e35eaebe7822@r2rien.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Antoine,

On 2/3/24 17:16, Antoine wrote:
> On 1/20/24 21:26, Hans de Goede wrote:
>> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
>>
>> The next question is if the keyboard will still actually
>> work after suspend/resume with "i8042.dumbkbd=1". If it
>> stays in the list, but no longer works
> 
> Hi, thanks a lot for taking into account our hardware,
> just a supplementary feedback:
> 
> In my case (Dell XPS 13 9343/i5-5200U):
> - Dell Inc. XPS 13 9343/0TM99H, BIOS A19 12/24/2018
> - Linux version 6.6.13-1 (2024-01-20)
> 
> commandline with `i8042.dumbkbd=1` fixes the issue,
> with capslock functional but without led
> + as a side note, hibernate doesn't trigger any issue
> 
> (before getting informed of and testing `i8042.dumbkbd=1`)
> I had attached logs before/after suspend against 6.6.11 and 6.6.13 :
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1061521#30
> 
> I remain at your disposal for any further infos/testing

The issue of the kbd on some Dell XPS models no longer
working after a suspend/resume cycle should be fixed by
these 2 patches which are on their way to Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=683cd8259a9b883a51973511f860976db2550a6e
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=9cf6e24c9fbf17e52de9fff07f12be7565ea6d61

Regards,

Hans


