Return-Path: <linux-pm+bounces-29933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E680FAF0162
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E57A1E74
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105927E048;
	Tue,  1 Jul 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/IQ4LqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93927CCE4
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389877; cv=none; b=p5kw9c9nyPdm7Ctr695SA24nMvl8zNo2pFWEzQhsAFSbOPwZ7avxwVgqy8UmhGbRbjMvcSJLuMRjGr5uUmEySWoAnuR28yjPKBzREMWRtCO5hUIaHVoymTUA3eKxamleyOsDwFoemadglnaZD42zVh4QwApSaav9qUrdTKliVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389877; c=relaxed/simple;
	bh=iH0TDbe8VNWwvdmFqK8APOT2xukPLMWBMeyUf5tfGg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/jw5vG8ZVzB48CFO4cUrb+1m/vOk4mbM9aAX47I7WPZzsLR4L1bp+N3XqlB+XTLj4w2FFn6GLxEoJCHuctwqPnFIyB9gtDzmwJFCl4Oy2xDj7xC2tp60kA4kAUKoJ1gfzQqskOUq8pCuOIZYAO8AMHXeiX15Yj+u6GhHlXUUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/IQ4LqX; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-875dd57d63bso247235139f.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751389874; x=1751994674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+wX+K4f2/MFAj/Jdnu+2FqfSGpN09EzrvZCmNS2CqY=;
        b=f/IQ4LqX9HOrMB6LYi52+5ajWtLWi+K8cEt7dKJ5JocjxU71XswURhF1qUaAVI499n
         IdfMNH90QeWrrGQLo/uNQ94FbeIxBlO9NaoOcHh/YMoaDlwyiVWs1F8lmdIgvQuulM2/
         uk+IcHjpsUqyL49jlQBhc4rjK7wZ0A+Mg7YkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389874; x=1751994674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+wX+K4f2/MFAj/Jdnu+2FqfSGpN09EzrvZCmNS2CqY=;
        b=A68BICtYXYKDSWUE6HP1P7LzJaq1wl8SNb3QOtZCwDb+fAAW/D66k4G5lrc2wfoMe0
         zigiZjl7QJK1vfCW4Ngl/7LpOFN3NVy8wCSVhTLZqvgowIia5He+F9GdUPl5scjHh2GS
         HmR1xFuiRCxIBj8R0whOxO0X0lUwADKZm1Os/bgbjV1IeYtJiYajFlWcWwtN5xebhSGM
         uwJCTDxLAP/Cy2ZFuJ4T/S9SOdzA1tXn3d5rPOOr7LibtwSQhe7TOATYMy1f6DWtBV4G
         F4SxslJRh9fK82ZrlBUUX7XyvqlqmdAzvrkfHeDMJIObcgKmBZb8x2mA9igc59u8OPD6
         bAWg==
X-Gm-Message-State: AOJu0YxZw+XXvG309OmjwL4tEgipW285fY1NHIfAm/IphF4rXszCTrBk
	EJHWHut5r/rS8EPatYo4TbL1weaPWtSLRWYQAYymjQnyaAG9ezALvp2/0fP6KnluXec=
X-Gm-Gg: ASbGncuDqhIstsbZ66F3FUk+pNFihr6QsG0JJ5eSvBiE+oBGgQ9fbv1ypkMJKhFMRti
	uPcii+KSXzP1eZBmpgFGZsG7KxHBvz7f5iMuJTzmwz6sFmDxZGclbp7aDXUsnkZ+aC6RkG8VAQR
	kEZMvrTDS7ubbVVM3rna+bQ5joApXog/5+PY8IMpyBG+c+zoHezzKt2pK5zN0S8xIVYtNyL/WEI
	zXPns1SbpTsQ2/EMh5uYpxkCav0WwbTVJStt3XW336L70CcoIcF+xr3byJnYAhOwdQD71tcYXph
	O6iOGmj3WgQbL8WKjIHuelRO11VFt6N9tGe4yVcZ29clp8Advgmyve5ScX4oF5xBXHnSrKe3Ow=
	=
X-Google-Smtp-Source: AGHT+IGWgeEaEK/0GkLqXIvblpd+mixokpaJEx481G3pNqH6IXmxkbQDpSGr13gQ+qGaEdVblqLgqA==
X-Received: by 2002:a05:6602:4142:b0:85e:73da:c56a with SMTP id ca18e2360f4ac-876b90cab8bmr546249039f.3.1751389874133;
        Tue, 01 Jul 2025 10:11:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204a8c2eesm2557194173.94.2025.07.01.10.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 10:11:13 -0700 (PDT)
Message-ID: <2ad5a6e4-23b6-41c1-a2c9-3190e9bd256d@linuxfoundation.org>
Date: Tue, 1 Jul 2025 11:11:12 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Improve Python binding's Makefile
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250624204105.457971-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250624204105.457971-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 14:41, John B. Wyatt IV wrote:
> Add a few build variables to make it easier for distributions to
> package the bindings. Allow current variables to be overwritten by
> environment variables that are passed to make.
> 
> CCing Thorsten Leemhuis <linux@leemhuis.info>.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/bindings/python/Makefile | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 

Thank you. Applied to git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux cpupower

Will include this in my next PR to Rafael.

thanks,
-- Shuah

