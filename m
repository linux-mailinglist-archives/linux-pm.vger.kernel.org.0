Return-Path: <linux-pm+bounces-10725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624B49293E6
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E51C215E9
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227012FF9F;
	Sat,  6 Jul 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqkbaKJj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8F23BE;
	Sat,  6 Jul 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273569; cv=none; b=T9WNjsS/phNh60+h0Zqr1szFUtA5uKe0c5118O+FgvBCUV9n0GLT1tAWPf7r3Yzp86T3jwsvyl9UEeI9JbcaOd0XPVrkr5OAZIw1E9VLQ8fP9SQ8aO2XH3OcvGX0Dj+t7lyquI/IbC3fB+cAo1vWdMDnw/POxwNAt/1C9wG+Icc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273569; c=relaxed/simple;
	bh=a0xkC2CLkpYpkF8G1wQwLuQnMKi3EUIfeGO7uLK5X2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pd0jZXhtGDZ6S5auhEsvzSyAQRLXwMnQ1FVQ1rChPm9hm74QLrfbothYJwVPOKR8BGd8HZnemA3jiVK1YUTZlPFFZPwpTMWumT1hbc9ziQnoGDIII0dAxt7+gYiCjBDzSC/8zou379x0NPIoxUm2vePbl0/CZ5BW+ntFTcIlFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqkbaKJj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so4209135a12.1;
        Sat, 06 Jul 2024 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720273566; x=1720878366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAJC70EpEcbjk6VlaxzRollcBomBiQ2/i0MAtk2+5fM=;
        b=AqkbaKJjfLVtfpCbUJF03CAzB4EqvGveust/mCLk7Jj8WJhgC8f0kKbPytzPz5cEzR
         LRBz7fQ5rom/79wcybr07mGlfLGDt+RphhHjVFU/I2+1Q7ETDC2NyuaemBOIHs9mUwSv
         T3DuyTGc27dsxL/o+2Muj9g+OW1+iGC/eWhcOZPiYLXsApoVPxRt228RR51647RRNBus
         7Mwt8fNaA0R5d2Gb1NWK/RXoVfAmo5ETJYQWtJaUt5LDU8l2mMOHHEr/SLAP/vGYGCZJ
         upUrB285Te4la30PhuZ7gFcyCVosxT2ziR6QkFsDxrEOlyMxDs694ELCAF+DFx6q00YF
         VxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720273566; x=1720878366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAJC70EpEcbjk6VlaxzRollcBomBiQ2/i0MAtk2+5fM=;
        b=EKf6O18BJ8NlNAkqT/izeQV/QgH4ZAgtb5JGn5EIA5nghgOhOrd2f3RZk3pXWFXzPz
         8MraLLVav9XX/Fr3yJ1absJuBY4nA/y6l/7GaRkvEfPqPY3BYDLlbl5mXIeg3llWavJD
         oMT0Vz2LW9B2dNcB23RL1fe3O6+SKR0CFqZje317NUMmQ+2X/t75s205H9us2v2MjHht
         TkvG5jaVBesuux2zMaH/mZkKkRPbIkSyNQtozHOC8QQdR7IyNqLd//UZ+nPz7LWubK8q
         rNkt9T4yRnwcVyTYPxQ+3bHAsB70My+rrGsKmCk8HQRenO5Jyi32kgZdwhgNV1u/70Xq
         JhqA==
X-Forwarded-Encrypted: i=1; AJvYcCXaTGeUAZCbFMXEbzuYvkyEsL6nFtiDnZ5Mi/NPMLKy+ri3miZF35wLRDpMjvaf8BhUglDDqa6Y0b/YPwn6fN1JQrtA9aFI/Z3ptHd8bBAeuqJIney0/ipy2iiJhrTVsgtRflHZcDGKNhXiSaXZ5rVOBzzUXnllic6WpP8VzOQ5LoXDWsM0pUZmN3Wg9woSm1XIPDOmjaN6VequYlmM8V/5LA==
X-Gm-Message-State: AOJu0YwCsEaCg8mOScdupLckjW9ALR+HxvZ7GVfesF7yqLbIlBjWCzXL
	to7BcVOG4OgApUZD2wtSjHeMgWH2p/Wtb3XjQxIeMUNyI7bI8edI
X-Google-Smtp-Source: AGHT+IGrL3cRO40LFioSD/y8T+h3SDJ4vWA2cnDjypHphTEGvbO3m+TIBosJdQKRoB6xVO/mWRPz+g==
X-Received: by 2002:a05:6402:50cd:b0:58c:77b4:404b with SMTP id 4fb4d7f45d1cf-58e7b6efab1mr5477282a12.15.1720273565769;
        Sat, 06 Jul 2024 06:46:05 -0700 (PDT)
Received: from [192.168.1.13] (bzc167.neoplus.adsl.tpnet.pl. [83.30.48.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-590377a7e8bsm1440661a12.14.2024.07.06.06.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 06:46:04 -0700 (PDT)
Message-ID: <375de691-59ed-48d8-9af2-83f330745b48@gmail.com>
Date: Sat, 6 Jul 2024 15:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: interconnect: qcom: msm8939: Fix
 example
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
 <20240704200327.8583-8-a39.skl@gmail.com>
 <52ef47d0-8344-4367-b0ee-32e9471bc64e@linaro.org>
Content-Language: en-US
From: Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <52ef47d0-8344-4367-b0ee-32e9471bc64e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/5/24 08:57, Krzysztof Kozlowski wrote:
> On 04/07/2024 22:02, Adam Skladowski wrote:
>> For now example list snoc_mm as children of bimc which is obviously
>> not valid, drop snoc and snoc_mm and leave bimc alone.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>> ---
>>  .../bindings/interconnect/qcom,msm8939.yaml         | 13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
>> index fd15ab5014fb..3aed8b77f35d 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
>> @@ -56,19 +56,8 @@ examples:
>>    - |
>>      #include <dt-bindings/clock/qcom,rpmcc.h>
>>  
>> -    snoc: interconnect@580000 {
>> -        compatible = "qcom,msm8939-snoc";
> The one correct example would be the snoc, because it is the most
> complete, but well...
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> Best regards,
> Krzysztof
>
Will do it for v3 so this r-b ain't going to be carried.


