Return-Path: <linux-pm+bounces-10724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E929293D9
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC16B2172B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C88C12F5B1;
	Sat,  6 Jul 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3QUkE3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA082757EA;
	Sat,  6 Jul 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273297; cv=none; b=oHJbQlR9Jab2NrwElzKfgC9D/253dZswugU8uzbifEIuFUquZKP0graAprk5BfexG16SMAcXZz8RGkATW3iTqFPv1dGglfhjcWdRX6yxlFT20wtMwWHHFMIcTZVNS8V+TK3wB4TFYyBJYuzL0Ttyn+X3gaglHurp+qunbpZ78ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273297; c=relaxed/simple;
	bh=tpCfZvqW9yvz1Mou1k19Lf7SlicdQ3FqOCMPrEm8fKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td0/4ianOsgfOs0ZDtXm8AWdZUN3gabxUi01Mj8UGPfjQaLT6ZkYwI+8IOZBS69/MAFNkX3tVAcj83eBTSNHbAk66iQohmiqrjSsFY8OEb13OKCF9nZnFo3iNRxpMfSLegsK2icsh/7uLhCpJ7NIZO7GCf/ky0Eii/pAu7HuVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3QUkE3W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c9d3e593so179742666b.0;
        Sat, 06 Jul 2024 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720273294; x=1720878094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpCfZvqW9yvz1Mou1k19Lf7SlicdQ3FqOCMPrEm8fKo=;
        b=C3QUkE3WsT6MpIt8UFXyRgo65yqe82zcg8y9HqjZHOQyeL7vt/EovnI/Hf2p7iPfkK
         HmJGO2d737Ox/v3Z0NC7+ykt9VbRAO8ZkWK6YPphhOCJo+3wpSFGXorfwo1AFnvRWq4N
         6T1QhM+THizQ4Y5rT1cooo09QTr00zxcUd0uW7i1rcKIIVKadKHS/9n0K3Ick7m6ZOxg
         3JXUfu0V4PPLxXsOlQTOI7qrbzWDbF61M0XzV6QPGOeCtdvOvvyJJsEwlV51PTmD+0Up
         tOedLHgsuHBdXQCYEwc6CG6/aMwz6S9xmDNas5sVSi+KvPIVuY6LBi37vvocIq8042h8
         /GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720273294; x=1720878094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpCfZvqW9yvz1Mou1k19Lf7SlicdQ3FqOCMPrEm8fKo=;
        b=geVVwDyVTiGID0U7PD5U+t0it9zsGK3k8DWVREkIdvM64jDL3gK+AQ35Kb7i9+ufbS
         8M3tDDJN3FpIb1T0l+0/9XM7LANfn5z/i7LIt1wpFKFwxnH4p/SQbQCYFbUWaMOez6i6
         WgilZ9Z2wOB7Y15ntXcIBO7MB1UEPV6PE4pHHS4LAr5Kvly3Q4gwtY3m5kqkgGD7v6I4
         hkizgpNvZprYqZeF2VfKpXu48NuCV2AagvzfJdn7Mv1aYUdDVN868vrNSsD5Dyhtb3ID
         P9MqOlExR7Vrj+i2nPD26BtQzRxI5If+MI6upf8e3lUNvt9PlFtQEU9QrWAveWAuCtpZ
         XcOA==
X-Forwarded-Encrypted: i=1; AJvYcCXpUxTIw0A1Jl5vrFOXjTylfJkfBd+kMwRMHK0GRQPniG6BoqTjZLRzay8Eu2Mc0VefV4EZ7Va/ux820h/7XTgYQa7hOAn6uQaNXPTeURs4tsnRODm3GL/3ZGoalypxgTxce42QKqaLk1IWnJK50iwV64HxxOwISjLxvqJIomPWd4rIRjMem871SvYMA5B8uMxY+McwefIiiAnPrRJEQVIL+Q==
X-Gm-Message-State: AOJu0YxA9OlxfaMl09axa+UJBA/YhzlXp/gwijeA+17xJXFr58DSG86Y
	28DQCj+VhmLcJ70VIZ0zvBr9lwhwatKXwjsJydBevmSJ88rOkemZ
X-Google-Smtp-Source: AGHT+IE0ZemeIlvOgoNhCkacJ61zvRUuBkEL0wi6xZgy1jnf1+/l/KIsA+BVHMf2hMT1fUew2XvFzQ==
X-Received: by 2002:a17:906:5293:b0:a6f:b67d:959e with SMTP id a640c23a62f3a-a77ba71188cmr379032566b.53.1720273293897;
        Sat, 06 Jul 2024 06:41:33 -0700 (PDT)
Received: from [192.168.1.13] (bzc167.neoplus.adsl.tpnet.pl. [83.30.48.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e1ff678fsm66100066b.137.2024.07.06.06.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 06:41:33 -0700 (PDT)
Message-ID: <5bb295b8-a79f-48ea-800c-3176c2402021@gmail.com>
Date: Sat, 6 Jul 2024 15:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] msm8937/msm8976/qcs404 icc patches
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240704200327.8583-1-a39.skl@gmail.com>
 <b4b94938-903a-40ba-baf3-d04226dc9f90@linaro.org>
Content-Language: en-US
From: Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <b4b94938-903a-40ba-baf3-d04226dc9f90@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/5/24 08:49, Krzysztof Kozlowski wrote:
> On 04/07/2024 22:02, Adam Skladowski wrote:
>> This series introduce new ICC drivers for some legacy socs
>> while at it also updates a bit of qcs404 driver which seems
>> to not receive much attention lately.
>> Please take in consideration i do not own any qcs404 board
>> so i cannot test anything else than if it compiles.
>>
>> Changes since v1
>> ================
>> 1. Reworded commit messages
>> 2. Adjusted yamls.
>> 3. Adjusted examples.
> Adjusted to what? This is supposed to be specific.
>
> BTW, you use here odd email address, so:
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> </form letter>
>
> Best regards,
> Krzysztof
>
Indeed i send patches from different OS with old kernel tree inside,
i haven't had idea about that.

Will update tree before sending.
Regarding v3 which im going to send anyway, should i reword changes in v2?

Like in v2 i Adjusted yaml to look the way msm8953 is(seems its wrong).

Adjusting examples refers to removing redundant nodes from yaml examples.

For sending i use this command:
git send-email --to-cover --cc-cover patch-dir/*.patch --cc
phone-devel@vger.kernel.org --cc ~postmarketos/upstreaming@lists.sr.ht
--cc-cmd='scripts/get_maintainer.pl --norolestats patch-dir/*.patch'

Is switching to any different tool required?
I doubt i would be able to do it without making some big mistakes.


