Return-Path: <linux-pm+bounces-16660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE02A9B4AA7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D66A28409A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2DB205AD2;
	Tue, 29 Oct 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EH4Pvtd9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC117188010
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207538; cv=none; b=kXSdN0EMqZO/Ikh6efGv6RLcHTLubdSti9yJjICwsYztwvyddJvqDd2CFVVsYv8hxwdu1BrG7q72cGR6eWtR01q6NojoLzEwSs5a/F1/9vnWBk53htizgvDyUeTm8/OvsfOlCiHGevJWJ0pbdNE3HK9YhCO4+oyjON4SG/cLiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207538; c=relaxed/simple;
	bh=DalTr6KSesO2fNEh/7GLFOsPw4W4aPg7jZFRMiFZBME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV0Of/Q7oeZMuGCmvu7tkbjfBREQ0InDcmPSBR1DirJCo8LutKtzm4Zx0RG22vg7tDVJVLaurir7b48Gz8cUeaNTl7vvkL7MouocdScVuCANIXOKwA+vewmd36AYSI9I7yYf+ZFCOHFsy9HRIlosr8RMaKfBGVQiSWoQI1u/Ak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EH4Pvtd9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e3f35268so6421204e87.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207534; x=1730812334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsUvFzGFORfkYDgAVvQACC5zCdmfXYvvTdPQxvM3XIE=;
        b=EH4Pvtd9RruuZb2/XhmkTTbdSsIIXTMQHPr45DQsBHUuVnrlj0SVhCedoKMBTYvzYa
         cCOEjUEBRAFWvPsFzRuYJx2FcFsIzeyqiXnNBEIhYoBUHgH/7iYMfdk+GTZAaQxGjaY+
         YoUOupcJOAw5nGeRtIqS1i0lzQGgN4CL+DNtOMLDtF9xrKf9Qp5/fgQHaSu0h4fWZL2Q
         FE1uvATN0+jHgOBVySHXq21qDlBcvmxJaRILsyDp5oGD200Ko/ls84EPTuu+rYVgiOsQ
         mraQZ+7w8PpER9XE5h7+u05Drhml7UGQnia/gw8+YO7Iht3RIKZVVoUP7YGIqzBPcD4a
         +qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207534; x=1730812334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsUvFzGFORfkYDgAVvQACC5zCdmfXYvvTdPQxvM3XIE=;
        b=hlaiuiPh9+t3e8jMJRjLxcW/EMIjzK3GNP823V79vmqL9PBoSKXiIO+XMe16Nu9PkH
         FylyGJRDEYcKCPzFgEia5IwAnmggfkF9PFEu0pfovsmAHuBKFmsWP9x2T9opTjVsNKiO
         rKztFENqlcKxrk+ThcP4fnEc3gBtO1/zr9sovdS2cO8mvHWt2hJVANCedUGIeNomW5m2
         ciEv11JmB7Mi+Opz4+5INjlBaGOahzTtdc9/c+92QH4D/M7wHqi+rvau8rDMlwhHQzC2
         JMiZBqapHqwlFwuIsLsakkexFsVIwTXfcEA4hOIM3ghCP5NcR1TN+LL2e/xZb1/CDkQ4
         QU/w==
X-Forwarded-Encrypted: i=1; AJvYcCXrJTve67dqySwGS9j+CBAgEu0oxS4CMxOyKgrHn14v3UmiJr5D8sfcaR0GVozxeJyJUHq6Jnu8Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaoSqq0hWZ7c3lavEXXTJYsluSKaeb40rC+1Lvs3Yi33z2Akj
	lt7dYWYvrQguxcTPByjHUYvlsCIBRevwXFkN+FOiUcsCTApRFw4dwQsoTLE+AlTdEQVDluWCKY6
	IRQs3CQ==
X-Google-Smtp-Source: AGHT+IGFp00dxkBL2I0cIJ+CyKncogPa4or3is/rSrNWQLlvdCOjjwDeXdQdY9wXicLggr4Q9p/N4A==
X-Received: by 2002:a05:6512:4023:b0:539:d428:fbdd with SMTP id 2adb3069b0e04-53b34a31123mr4419550e87.53.1730207533943;
        Tue, 29 Oct 2024 06:12:13 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b8ffecsm12441925f8f.91.2024.10.29.06.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 06:12:13 -0700 (PDT)
Message-ID: <6f14d8d7-7b9a-49e3-8aa8-5c99571a7104@linaro.org>
Date: Tue, 29 Oct 2024 15:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: Rework BCM_TCS_CMD macro
To: Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, djakov@kernel.org, mturquette@baylibre.com
References: <20241028163403.522001-1-eugen.hristev@linaro.org>
 <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/24 19:56, Stephen Boyd wrote:
> Quoting Eugen Hristev (2024-10-28 09:34:03)
>> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
>> index 3acca067c72b..152947a922c0 100644
>> --- a/include/soc/qcom/tcs.h
>> +++ b/include/soc/qcom/tcs.h
>> @@ -60,22 +63,19 @@ struct tcs_request {
>>          struct tcs_cmd *cmds;
>>   };
>>   
>> -#define BCM_TCS_CMD_COMMIT_SHFT                30
>> -#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
>> -#define BCM_TCS_CMD_VALID_SHFT         29
>> -#define BCM_TCS_CMD_VALID_MASK         0x20000000
>> -#define BCM_TCS_CMD_VOTE_X_SHFT                14
>> -#define BCM_TCS_CMD_VOTE_MASK          0x3fff
>> -#define BCM_TCS_CMD_VOTE_Y_SHFT                0
>> -#define BCM_TCS_CMD_VOTE_Y_MASK                0xfffc000
>> +#define BCM_TCS_CMD_COMMIT_MASK                BIT(30)
>> +#define BCM_TCS_CMD_VALID_MASK         BIT(29)
>> +#define BCM_TCS_CMD_VOTE_MASK          GENMASK(13, 0)
>> +#define BCM_TCS_CMD_VOTE_Y_MASK                GENMASK(13, 0)
>> +#define BCM_TCS_CMD_VOTE_X_MASK                GENMASK(27, 14)
>>   
>>   /* Construct a Bus Clock Manager (BCM) specific TCS command */
>>   #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)             \
>> -       (((commit) << BCM_TCS_CMD_COMMIT_SHFT) |                \
>> -       ((valid) << BCM_TCS_CMD_VALID_SHFT) |                   \
>> -       ((cpu_to_le32(vote_x) &                                 \
>> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |    \
>> -       ((cpu_to_le32(vote_y) &                                 \
>> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
>> +       (le32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |    \
>> +       le32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |       \
>> +       le32_encode_bits(vote_x,        \
>> +                       BCM_TCS_CMD_VOTE_X_MASK) |              \
>> +       le32_encode_bits(vote_y,        \
>> +                       BCM_TCS_CMD_VOTE_Y_MASK))
> 
> Why is cpu_to_le32() inside BCM_TCS_CMD at all? Is struct tcs_cmd::data
> supposed to be marked as __le32?
> 
> Can the whole u32 be constructed and turned into an __le32 after setting
> all the bit fields instead of using le32_encode_bits() multiple times?

I believe no. The fields inside the constructed TCS command should be 
little endian. If we construct the whole u32 and then convert it from 
cpu endinaness to little endian, this might prove to be incorrect as it 
would swap the bytes at the u32 level, while originally, the bytes for 
each field that was longer than 1 byte were swapped before being added 
to the constructed u32.
So I would say that the fields inside the constructed item are indeed 
le32, but the result as a whole is an u32 which would be sent to the 
hardware using an u32 container , and no byte swapping should be done 
there, as the masks already place the fields at the required offsets.
So the tcs_cmd.data is not really a le32, at least my acception of it.
Does this make sense ?

Eugen


