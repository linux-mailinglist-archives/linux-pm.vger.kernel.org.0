Return-Path: <linux-pm+bounces-10133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E802391ADD2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DE51C25F54
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4F19A297;
	Thu, 27 Jun 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXyGTbdG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89061199E83
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508705; cv=none; b=T1eqzf0ndqvgxuYa0CT87dWyvDMLl4jfXv5xxp2fn0rZXVA0THM1uBmvjVLXJka2GTcp/+NSTpICSPF64wN6PzXCmMgCJ6fAo5XEuX/+FW0dWJ7bjJPQ2zfUkrrJPdUCbpviB/2gzB45cGkyf5x+AhC8jmDsffrwubFHA76GvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508705; c=relaxed/simple;
	bh=VUpcms+2HbkbSImvdbrctU+WfLpEorrjXreqkwiys1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q749LIxn3ZlleMA6a/dVZSCSJslyO0O2svrMNlTPdm8PqTrBnUv6DRGr4h32DnIRyoMa5Do6GQI7A7YK3bCydnWJcZ1LnmW1zPGmgGj9lCl0Osbjcd8AWWk2L+s1raXbukq/LSgmwge0zJ4XA+dgdPdXfeGwQtwVPyr6voHbNN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXyGTbdG; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f59854ace1so3542939f.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719508701; x=1720113501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6d8l8opJ/oY5eykEPzVftiu0pahNZ/z187byDXg9KXY=;
        b=CXyGTbdG/yPOiB42fotIupVrA1YH3HNwKQ3Om/ujsQDSEooSRnIRJMpEYo0txfxZgk
         mASUu9T3IMp5l9UW/rRvt8IQTeV4fejzE60Z9Qxff4u81HatwdGWvFdq391ftPtHoNAg
         6WyzrU7xzYbNshs41kgsiHXaNme6Lnw8nd9Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508701; x=1720113501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6d8l8opJ/oY5eykEPzVftiu0pahNZ/z187byDXg9KXY=;
        b=mggjo/hfdnNfzIV3ivblgQZ3svln8jVxfITc6N0e/wduxBhOiz/JnmgfjgCJm1unjC
         MldrlUMZq5R/ns714RYMWXJenv2K97BOTB3lVqGh+bZn6JXarETKl8i+1wObAmp+UWH2
         9zvIlHpYFvxPrMTvVdt4DplxDSIr/3Uc5XGDqLDnwtB+mV4RBdAzcvJ2YCgv3ejLJ9A3
         k/GWu9q+8p3jECfR6PEGBjkAGv2InYQAu+i4MRlsJhFzJ7svNrYNdFAB9gJIV5p3yQhq
         GmflZpB6T22dAVhouSd1Hu/xB1SATCOfEttNk0dUVgQzTXh7DPJhgfea63NPiXBW6orL
         URIg==
X-Forwarded-Encrypted: i=1; AJvYcCXyCoGgAnNCqllQ6+0KdcKE4dlpjuPQ1AKL/L69omxTW0ON4BzARYFEsbeVVZYXbCTgj6u/UEIPS3GA+MLvzXlo4wF8lYISthg=
X-Gm-Message-State: AOJu0YxY3Ne9J4jeX25VVpwidImlgVd0ZuUPdkBWvHw9AR6yY0OGrRkL
	3HqXJt3e+wqFpceCT/dCIex6Y61XRuOww39oPPlYW7yWqIjEkUPPvOD2wbEDdC/Z36Gb5q7tTdB
	z
X-Google-Smtp-Source: AGHT+IHkROP+Jrqp5yAFBTcNBkq9NFROm+0Jrr/erSz0JMg4pPu8n9tlmNMd1LMXUndX7eLRd8OyBA==
X-Received: by 2002:a05:6602:3fca:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7f39dd12493mr1834272939f.2.1719508701544;
        Thu, 27 Jun 2024 10:18:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b68b0sm22265173.127.2024.06.27.10.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:18:21 -0700 (PDT)
Message-ID: <0106631b-53b2-4bb2-8b7a-2d1824117edb@linuxfoundation.org>
Date: Thu, 27 Jun 2024 11:18:20 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Correcting all needs work translations, Adding some
 transaltion and changing maintainer of the cpupower tool
To: Daniel Hejduk <danielhejduk@disroot.org>, trenn@suse.com
Cc: shuah@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627092159.7724-1-danielhejduk@disroot.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240627092159.7724-1-danielhejduk@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 03:21, Daniel Hejduk wrote:
> Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>

Missing changelog

Be clear about what you are adding - Send spearate patches for
changing maintainer and adding translations.

> ---
>   tools/power/cpupower/po/cs.mo | Bin 0 -> 12805 bytes
>   tools/power/cpupower/po/cs.po | 172 ++++++++++++++++++----------------
>   2 files changed, 91 insertions(+), 81 deletions(-)
>   create mode 100644 tools/power/cpupower/po/cs.mo
> 
> diff --git a/tools/power/cpupower/po/cs.mo b/tools/power/cpupower/po/cs.mo
> new file mode 100644
> index 0000000000000000000000000000000000000000..e82a23760d4f26a628d9402f84c20bfda1df4263
> GIT binary patch

What's this stuff here?

> literal 12805
> zcmcJVTWlQHdB?}s*c<0!r%lt`dhA*@DRWmOtx7g!-Aq}R*pg`7>RPpp*_}h~aA#-M
> zb6ILP2I?RI5};5T2M7|!iBX~`Py->1^sxYqqAT_x4@J@T&4?dV1PIVR1V(DKPwnqJ
> zXJ&RuE+soiS6KdcX6Kyqo$vd9m-DUOyYKezIlM0N{vz*dw>r+tU~mV2cujxIaXt&q
> zfOFu<{QB$Q39f$#ehRz}{x0}FcprGzU5@ir@C)E+@cZCA_zUn5IC;0@{5jYJSHNF`
> z(_m0>oFm|m!CCM<um;}yamRTUJOZ8rzY87%e*u0M+<lMZyauj=N5He6u+M!5JjnIG
> z=Xn1otvoM*-{$@rDDytSCPcn(gEQd2fPVnq{%Obg68Io^FZd+*1@Hn`1v?;9J8y!Y
> z0e=Gi5%~9@jQ;=>ReqMi&)kBJLD7%TpBKSbK+*5J;BN4JQ0Dm(fA)hj;O~Jx_#MW7
> z4P4^-K9v0}un)@mw=v1H;JqNKbQ++@+s^UNa(oRGx&8{2c?aO{fbZt`s~qp(OS%8~
> z9QS|^aeWMAOHK=v^<Dulg8u~mA^70u9A^SN3Ci`$pzQN|;N#%0LAL1Be&1dn1?yaY
> z6_kCw2MQ05f8KGRqSF9nKa1c?U<bS({Achs@O`k4UOoUtzLy#NB=`eR=6RPtr@{XQ
> zMIXm8CL%b`fvC=T8SI1K1fK(M{j%d6055~H;P=5FgFgdfu!-{ag71Qd!A~p8+l3sz

thanks,
-- Shuah


