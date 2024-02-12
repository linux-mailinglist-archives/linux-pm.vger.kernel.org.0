Return-Path: <linux-pm+bounces-3771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B08850D7C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 07:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC57B232D7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 06:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648956FBE;
	Mon, 12 Feb 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcHsw1rh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC861F9D1;
	Mon, 12 Feb 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718313; cv=none; b=Upi09WKRM8hPVdETN6RDMnyRYQ5UP4QuJ+zTu3qo3pwT8HyZWbbq2tC1ll5kA9kNPTStYQkMLX1nnI34Pwq+dm4H+S9ijZU/9o/rV9t2lb28W3mh5JlGV2Xscmrsp7B07EzlB2lfbQG1EUJ10JUyl+RJZNakhct4tAyFBZvaDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718313; c=relaxed/simple;
	bh=PlHK9CCsTs8D6azUeEDIXZlPcQJLKpJaihyd3PHAZNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6Q0Pmhvx3SSAJohlCJhnSlZYJ8jnS1//zlir4NrBqdMCE35OplBbxm12t8BdfXA3gPXUDfRvtvtG8QEdu4BMWhwwsBU/BZXquN7PNTx14hvY7ZaBtX0XnWV8Hrre0qqcq4Qg0Bspyb5lLS6USQm5PXiRchv35PfNHaxab7d6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcHsw1rh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3c0d92ca8aso240212766b.3;
        Sun, 11 Feb 2024 22:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707718310; x=1708323110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5QbIiyRM+fMrKstQjJH9uNnklIepSlFhtf1nMp0P7g=;
        b=FcHsw1rhOVmITA04t6yAsvAIEUz8gymxcAqjuBlghDp3FWNGq1ZHfkzb7avmSdpztP
         DP3WUvnQ/+0bxpSIlrLsKgg6uGuYPSMzlQAgLRbKm6msVXWmMQujxmrXyn4TW1gSJ0io
         0vWPgm7gOAVxZMjb0UHqYR2KJQZWvzQQUX6uAjD9Zg8/hF/cBFm8amlkONbfc1I6scxY
         lrJdDbXhoNV/oOJVAcJuoQhbI79ZjPvxhMxLceOJQtNL9DWNaPSPGwJLIYK9hxWNst/Y
         dD5rCbsQkxbBmanPlp66dFkbyDeiz9qG+OmJNrsNWsf33YcpWv+xOvNIY6yLAnnL9dWw
         fDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707718310; x=1708323110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5QbIiyRM+fMrKstQjJH9uNnklIepSlFhtf1nMp0P7g=;
        b=JIbSZKWUzw/B1F+ji2cF/SUCJkKbHy7N9iiP0nkPYkTfs2upqO2rKXFKijedr0sngk
         by2D/sp4UdZYF24jDTwlLe27Ujj2YbAfl6gLHOAZvVX4KTnwgSEx22QineyJB6T6FOVX
         xHJrTadgh3yLVuPDlo4OELsAEXIuMU2uNEAg5h4MYbPdtHBK6tI4uLaQQW/R24UFO+bE
         BUa9qtii68OGacWoXzSCbYfTBc8NyC50BTPSVqUWz+SSHt9gBxmjhCoRjaDQWNBZTWKU
         lP0Ps9U+3jZIIpoKBWwVEJLzc+ouYWNrRzTb/YGwnkp0k0Dh9TsldakEkBtfw3fzKJnc
         niDA==
X-Gm-Message-State: AOJu0YwJUhVlYbQvUEqdViQTra9O35HGcpiiFkD0EhwDjxnaoHNHfZqB
	a56+BGDSjAUqc1vZSBa7B6Rv82dv1hqylM/i4fQz3Lx4ob3gtZnx
X-Google-Smtp-Source: AGHT+IFAfGb9D/1qfnDYuPJTF+gzyNmJ7c6d/v/wtsR71MQpk6I5dGl5tzWhoc3fL20LZ1w070TxhQ==
X-Received: by 2002:a17:906:560e:b0:a3c:2f9a:71d1 with SMTP id f14-20020a170906560e00b00a3c2f9a71d1mr3263751ejq.10.1707718309767;
        Sun, 11 Feb 2024 22:11:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMQLAJ1EeJ2Y3B5LJrtaiGj3Ihng8GWG7UeJeg2/KeNXdPkHZn1BAyQ9z6JMQEm1wbdZVXHAMu/EKIOUHZFU1lxE+U8qBYggvY/DemHmtsF6o4rH6HDUEj5GWNDvNLdug7CxJBssvbpUD6mRnaaT5yR3O239Xkjo9Mq0eBpZtDgI80ae0q5gfDgbHFybrbmK+Za8ZEF2ZGtynwwe4sQj4Gs0HyzE7XWYWrna/ZpFxJNza3SF7KVsHu7txEnc1u8rPwLuXfLYfqZtQ+iK0/+Dn3IMRN1lo61EEamXFmyZXovILUyl8lM3IzemCOwdCJHgJTnZsFWjsnYpvzx0ESE29ZjoqPt7Jz4GEhvie1CJuZGFAF1s5YRpTrmWJTjkad+nShFaMmWxyI8lfcRac6fMJ/T1Vbjc5eCPNZxDbEKyuRQZotCepYv6yDMoL1C3pnLXbZ5jfrd307lrHlFJE+/DlJJdCOYqUwWXnrBYSdQJ2bKskZUnp7NZF3G20bRGm1Pkef3JDbbIKNYcvdAXA+3wc7MqZHIPvPWiQiy9V0aoBBz5pTO72bhkcicrMunXc=
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id s6-20020a1709060c0600b00a3af8158bd7sm3526159ejf.67.2024.02.11.22.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 22:11:49 -0800 (PST)
Message-ID: <ddec28a5-8d65-4e52-bb3c-9587acf7bca1@gmail.com>
Date: Mon, 12 Feb 2024 07:11:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: thermal: mediatek,thermal: document
 AUXADC 32k clock
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Daniel Golle <daniel@makrotopia.org>,
 Sam Shih <sam.shih@mediatek.com>
References: <20240209055203.17144-1-zajec5@gmail.com>
 <17d143aa-576e-4d67-a0ea-b79f3518b81c@collabora.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <17d143aa-576e-4d67-a0ea-b79f3518b81c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9.02.2024 10:13, AngeloGioacchino Del Regno wrote:
> Il 09/02/24 06:52, Rafał Miłecki ha scritto:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> SoCs MT7981 and MT7986 include a newer thermal block (V3) that requires
>> enabling one more clock called AUXADC 32k. Require it in binding.
>>
>> Cc: Daniel Golle <daniel@makrotopia.org>
>> Cc: Sam Shih <sam.shih@mediatek.com>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> So, I've made some research on this matter.. and this is a NACK.

Well, I can only thank you for the research.

Let's drop this patch. I'll sort out the rest later.

