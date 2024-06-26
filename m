Return-Path: <linux-pm+bounces-10084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ACF919A93
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 00:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396091F22B1B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE716EB40;
	Wed, 26 Jun 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSXF52Ax"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F853364
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440692; cv=none; b=rDbL3dgHNQwwysBDujfabg8J0/wOuDy70ppE+jny+J4IPURsW0daMtAl9QbKqY+wNBIWzf7emSk3dd+cA3T60LojaZYQkjzy/7KwrGWid4KnvHLXq8b0Q2N0T5JSDBmtVrMThl0xgi+bc6NnikBszUEAoYaIRSl0qU2uhgRnz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440692; c=relaxed/simple;
	bh=5DTTAerSJwzlfmqyczD8ZaF9MGbbFbBwON2x3pLK5Q4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=capMVQ/HMjPNSigLGlg+WawotatIGKl3mxoLcsZhjsYIxt+kIXDqB7GSSUvS+fGTF2JXlteLb88VWQHXhczLKWKYRT7+P49b9gjAcd3Un3VyLCSi8snQTk3JOez6vBXUk44od7irJXkjvB/9nwEXEHR+d5XrlQ9JrCoFjPd5BY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSXF52Ax; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-366df217347so4123460f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719440689; x=1720045489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dR5oX0UVuydxUmpXKZtTc5WmDysPLKtV6oC4GqwAWtY=;
        b=aSXF52AxKK7s3bd2BdlOu+qRMlNhLeqWHNzJYq1wdpyNn7Ij5WM7KvAKwHKVO2jsfH
         ArrzaW3INXU/S+RVUX/H2byw06eoRxvxaOqJPD4/IJ1igf1Fnxb1J9EsNrN2YhZiFOBw
         uuDWNOV4sLzQjx52zdBfy3TYi1UjRB6zQQ4Bsv7Di3zHj6nEVgoxlrZlYX5Tw+/zHssB
         eH9rKw/A7pjwqR6+dAy5QENF9PHsB3y4MKwCkjbBGvSiYNaaeXY4Qtd1EqqwcgD8KC95
         ohMcQ+lxP25+CKtJDCV8pjLbktRBheBPmWFX7oVi15NwjjHEVQqOENgzmtM3OxEiUfhM
         arEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719440689; x=1720045489;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR5oX0UVuydxUmpXKZtTc5WmDysPLKtV6oC4GqwAWtY=;
        b=ZUmeI0R8EigHWe/YQPKiwrWnfqRiSjLUDhjEyFdNhIuoIjyD6SpLQBVS9LlAIJpko/
         TXeZWD9+pnTAMTNceCJdAITo+WsVkLrvBuYTnyZ6r1hVcmZZN3Eqsfe0+5zTuvf5FVe0
         nZRQ5KBZuOo4r9MZz3Vqxw0giG/NZgdQOEKT++4SvQvdBg46Y8PRGovxTB6IFDfs/x95
         UPGTA656TPcu8phTFjLkPxP7uCfngbsekFseVuE9rp9kWdmNX3qrkX26pV6nd2B4NTNs
         CQLqplKairHOZA9BbiZXzXy6cwYMXMcYJeF/GqOarNCCkjpifqq79NYzDruZD1vQg+xC
         4p2w==
X-Gm-Message-State: AOJu0Yzab9+VlKObQUyRtDtKah292HYJCdUH3yWfy8j4Xdrqtpa7nooC
	OlcQExYm4DHixVRYKjuKtPD8UMZ8Q6LbqsPxv8ZFVeCg4d8y1XHpJCGviByqZjs8lxQhD2bs9P+
	x
X-Google-Smtp-Source: AGHT+IHk4eJPb/551eiJprCbLvmxVAqr0C7aDgjZyoO2qjo6Q17yd/N8i9k/6X4MuAyGI8CnrvBa7Q==
X-Received: by 2002:a5d:64c6:0:b0:360:7971:7e2c with SMTP id ffacd0b85a97d-366e95db108mr10649312f8f.54.1719440688832;
        Wed, 26 Jun 2024 15:24:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3674357ff03sm53171f8f.45.2024.06.26.15.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 15:24:47 -0700 (PDT)
Message-ID: <025ac119-e940-4dfb-aff6-9bd6121eb5c6@linaro.org>
Date: Thu, 27 Jun 2024 00:24:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trip points crossed not detected when no cooling device bound
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>
References: <dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org>
 <CAJZ5v0iu9dg-tzfzZH5vfDZAv_OD1PKiZwaU-Q07Jz0-ULjtYg@mail.gmail.com>
 <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org>
Content-Language: en-US
In-Reply-To: <a1600a02-18e1-4e5c-bb64-6b1058a09fe5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2024 23:21, Daniel Lezcano wrote:

[ ... ]

>> Oh, I see where the problem can be.  If the zone is polling only, it
>> will not rearm the timer when the current zone temperature is invalid
>> after the above commit, so does the attached patch help?
> 
> At this point, I went far when bisecting another problem and I ended up 
> screwing my config file. So I had to generate a new one from the default 
> config. Since then the issue is no longer happening which sounds very 
> strange to me.
> 
> I'm still investigating but if you have a suggestion coming in mind, it 
> would be welcome because I'm failing to find out what is going on ... :/

I finally reproduced the issue. That happens when there is *no* cooling 
device bound on *any* thermal zones.

Your patch seems to fix the problem but I'm not sure to understand the 
conditions of the bug

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


