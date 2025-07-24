Return-Path: <linux-pm+bounces-31355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D1B0FF74
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 06:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C40583A97
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582D1E9B35;
	Thu, 24 Jul 2025 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvPAy11r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EE1DD0C7
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753330198; cv=none; b=LU1ekIh1L9dR9R+PO9TBGk30MAnF1uyDn9Kdgdyvl/hgrMFtSSQO8qfARiTzL4VLCH+dHQdyP6+uwpi4OSvc4rFO/sThrWpsy6AeG5Ost/ApojiQljnmnu1DyPKItDegukNWGsBW2oU6hNvsyzLqkBp9nSLYQTtfikAzQNxJ3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753330198; c=relaxed/simple;
	bh=5z/JpKYT0iblmh3bfN3/sRPSaWHe33+K/5cw2mtLHzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bloUQeUDxJwKWJwU0gCkMey58DB86urcRiHGTe//d+3uHqZvxiUmPZIRrPlYfyoGO3btodO9fwaikehSgDcH2iOHBTU8yq/jhm412ZeVUtvTOCEhKCZoH0KtglwY/xR3VVNyz45Psb8atYgGF29eJ7h8uMxs1lmrg4jALYMyB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvPAy11r; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ff8d43619cso450643fac.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 21:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753330195; x=1753934995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XMC9fDx04kAnAlL4rer5kIsAzlzjVre8I/Tm4EK/q2A=;
        b=PvPAy11rhZ3UiF+h1r6XO5naVr01oAoVgQ/ZcF87IsPAH1TB2G6WLsjWr6grUINWdn
         OYtmSG9I8MUjC3OIBiK/wJXmY/BRmykWUpP0W4QDGNqiNh8PS8kz4M44JTy03/sRorN7
         u9gLcWhO2LrOOjQGqYItSCi7jXEDKpp/f8RZEpofc/wk2Mv9GnHQ7lO+N2azCe/oljum
         sty2dmicQxpM/IZ1JKjXX21LsnbgrF49lympwiDwD6bN0iS5XeZ0qqkQxPVZBo/QzYkE
         KQ6m6VOjkrdDmydetTctPgWzYNYs7+dSFqVIeXzJOTeWgQguvVVJSRB4l1ZGJEMKlikz
         eJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753330195; x=1753934995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMC9fDx04kAnAlL4rer5kIsAzlzjVre8I/Tm4EK/q2A=;
        b=kCnm8MdXTwOFo9B67vGSHwEDrzdSflKv4Tt7Ln5qZG97AQCSnqu7AUIgmX9xI8f5Bs
         uiZqe9t2nWoBxfeAtfUmwvgK1uSby/5uvbMaEO+0sd12/sA2wi15tzzd21iEahi8GsWO
         EIi8735vBOL6etKLouUyMZLlCGTqJqBnlmw1HRid+3oTHceh6kGBn0aLHEZF9OsEhXeb
         CfXLvppNiWZqX23knCp0KmooqsxDTDR2R8p7g4Nnnf6Q18PCTDctWqtTGc0xV+TdOsI/
         /Bkiyeaklhz26KjT4rWJrc9/YvEtU6AQOsfzHgPqopBmPWXKEjAfnLzJw0Nb26FKdrmd
         yEqA==
X-Forwarded-Encrypted: i=1; AJvYcCVS8HYYV33upMADrKrjziYQRFeMpYdOMg10ZPN7bWO9qk7HZ+Hs0O9zLH3ox9yeV8NxI1lSOsZJhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqPKyYO/vzXN911nrw+85xIBWjW2P3mqluRQ3CZWUpSaINJO8u
	GwEmKx1yWihud61J2vWXc4p+stFkTYr0gAuQwTfmFvwEyVhcEocUNFZNyjcfkjCd
X-Gm-Gg: ASbGncu/OaPnsN9UKmU7gOlCcTcnX6w8C1riPU4s3tZKWWXCXmaXNzm9avrQEjdnb6E
	j/u5VsZWxC40cpVaykObzHgNUP4cfmqL11YbarOkNZ8Nejd5rasbIkcEthvpkDLiNGZZboyF3tU
	3yerMzD5kUZmJ1MHCWEEvOCoCT08iGyxXrA0opQcD2kcToGPV4TyDdNkzPsGk19INANP3yzUeJL
	w2/gdwQH1aUO7DdfHK44wz5q80tVprFNeTm+YD6ilR5O5rG52Nm6fQjZFMNn24hg4FpvOfjVoUo
	6nkgfNtg+WnTMWAJUEUKPcfwrijqbsEwau2B2CuwejiJlbHgfLDZtSizF1UDT4d9FlyF/OUfzCx
	7UmKY5Ft75GXgA9zMemhR9KURcMB9GrC+uKlAuQ==
X-Google-Smtp-Source: AGHT+IFWHe57orunsSZbTpUaLPDQA5Rlv4sjcntqeP3XgqGM6EPzlhsVGOcQRt0XJVsLi9W/EwOl7A==
X-Received: by 2002:a05:6870:5306:b0:2ff:8bc7:44a9 with SMTP id 586e51a60fabf-306c7299067mr3545242fac.21.1753330195413;
        Wed, 23 Jul 2025 21:09:55 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-306e1c4e079sm245752fac.11.2025.07.23.21.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 21:09:54 -0700 (PDT)
Message-ID: <eff379db-658f-4e3c-b6e3-0623760004f2@gmail.com>
Date: Wed, 23 Jul 2025 23:09:53 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ping: How should userland app be notified when kernel comes out
 of suspend or hibernation?
To: mcron-lsfnyl@rdmp.org, linux-pm@vger.kernel.org
References: <1e2af6bddb8cd51e5076285659a6f5bc92b026f9.camel@rdmp.org>
 <c8c2f8fd741f1d212d67e7b732305c5afc2fa3fb.camel@rdmp.org>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <c8c2f8fd741f1d212d67e7b732305c5afc2fa3fb.camel@rdmp.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/25 11:54 AM, Dale Mellor wrote:
> Just bouncing this back up.  Is anybody able to give any advice? 
> Thanks in advance.

TFD_TIMER_CANCEL_ON_SET flag, perhaps?

Maybe for belt-and-suspenders, check wallclock time before taking any
action. I think a descehdule/suspend/resume can happen between any two
CPU instructions though, so I don't think there's any way to save you
from the ToC/ToU problem.

Good luck,

Russell

