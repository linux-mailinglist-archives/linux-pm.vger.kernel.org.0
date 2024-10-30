Return-Path: <linux-pm+bounces-16708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE609B5DDC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 09:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5150A283081
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A82F1E1C07;
	Wed, 30 Oct 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJOpCx1G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCC1991CF
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276901; cv=none; b=IR6fcUSb6s0cbeEpQBev0wbcQE+M1QoofDLZtUQQntkhDnmdCG2+YknjpCkeMDkRPHtYICOY/08sjYp9Go7/if99+I37jo/J0qvjM3+PtJ35WBgLmLEWuycD28zIf1MADOGUCac/Pbkir0Y6F2bZEFiwL6jkG3fMlkEmUo8lbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276901; c=relaxed/simple;
	bh=intKQltl8qe04sX6ih8WJjx4/6q7A5aJSvz7oVoo5PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JahgPJRSHyXv10dGIE7ATA7da5OncbXeKvsHbI7oMPOTi1OydcMX4xknZb97nKPyo3dIUj+scYLF5iu2fonXknXKV3ET0kVbIFO5hH9Mge44IpNoXo6T2NYkmFRbcKOUIz26WXhaNAjS8AOCzesLbBJzKiksz2ChTWUQMgcINrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJOpCx1G; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431695fa98bso59574505e9.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730276896; x=1730881696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL2HqkuSmHQ7OPeQE/93gQ+LDrEwS9SDaauaieTM4CQ=;
        b=wJOpCx1Gaf8LTArqtp2fT6X+gmETexc+s9V98CpqALLzROINVQ7PV9/CjxJt6h9rFZ
         ipiJi4zQ0FsCZv3jfXY+SjUfDzS6g+I/SgFF8jwTBJlmYl5XHBUGiasLTLdOFeMlkm2R
         HFBRPfbzPOh1eVRnaq+wfJiei4iPe5KPMfFAnb5+/OjQ8j/58rDX5G6k+J+5wLqpPruE
         bj3qyVa/00LWMvgi3lBA4vpFKMVDNQO0q5+RcrEca+0GmBlacnqewODf7OG6jXHCHHRs
         spYq1/Ldcqd5fT6U9lQrgdKUdSdLilUplA+1yRVTyrvghVJXm+QT/BXhDVfHVo9PBZfo
         H6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276896; x=1730881696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL2HqkuSmHQ7OPeQE/93gQ+LDrEwS9SDaauaieTM4CQ=;
        b=Jm4p6Wj7I/mih1kdTOeIiwzn1ecJpfiVOFbqDEFxGhZIg36+w8iRVB1OJEptH/s903
         JlUw78U9VM/F2FUhANPAKQ8kyTvunnorMVxDXx/0Is/aK+ELXWLhocSpWTiGrvf+DLdg
         vTNvFsO9RcttT+2RG0DYdtwxBe6iCfvkJbjOZOvPvr/V/rpWcOcOQ/ay0q7OnyLi+pvq
         BfzNJWDOPh00Xnr2Bu320+xlwYe9b/P/86vWLsQHxpp9vVXLOVVXeJPuOC1UU2Gv2L7v
         3UtdaM2NoV0I3xN01pJHEYE5qh5mcIgrNXeOlKDe1mhPXq7rbg4S/jH5wVYDLwi2lsoQ
         gbRw==
X-Forwarded-Encrypted: i=1; AJvYcCU8bNhGG7Pyjn5TZ9t9H51gDIvbDYl/f2aqAA33qUhbdwlCLfyd98a5yLzhUZoxpiqgAZrf80u8Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuE1EjnBMvP+/JyRkqc5HkFzxGdwuS7ARvDiX8eYeJ50jhrbIb
	8XPKZiktajKjMROzG16E2C+gfrTAosxonsQvfvx11uDsS37rQl1dE5QL+ROTkJo=
X-Google-Smtp-Source: AGHT+IF2VwBune3eYE6REO5H1xO9vZLSDRXCcz1HESbflFaHLwuvzmPQ13IVdJ+0j1WTo7gHVfIs0g==
X-Received: by 2002:a05:600c:524c:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-4319ad24a7fmr142258435e9.29.1730276895897;
        Wed, 30 Oct 2024 01:28:15 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8549sm13853315e9.10.2024.10.30.01.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 01:28:15 -0700 (PDT)
Message-ID: <7b57ccc2-7060-4adf-b896-8992ec05125c@linaro.org>
Date: Wed, 30 Oct 2024 10:28:14 +0200
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
 linux-pm@vger.kernel.org, djakov@kernel.org, mturquette@baylibre.com,
 evgreen@chromium.org
References: <20241028163403.522001-1-eugen.hristev@linaro.org>
 <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org>
 <6f14d8d7-7b9a-49e3-8aa8-5c99571a7104@linaro.org>
 <b587012e868f8936463c46915b8588c3.sboyd@kernel.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <b587012e868f8936463c46915b8588c3.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/24 02:40, Stephen Boyd wrote:
> Quoting Eugen Hristev (2024-10-29 06:12:12)
>> On 10/28/24 19:56, Stephen Boyd wrote:
>>> Quoting Eugen Hristev (2024-10-28 09:34:03)
>>>> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
>>>> index 3acca067c72b..152947a922c0 100644
>>>> --- a/include/soc/qcom/tcs.h
>>>> +++ b/include/soc/qcom/tcs.h
> [....]
>>>>    /* Construct a Bus Clock Manager (BCM) specific TCS command */
>>>>    #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)             \
>>>> -       (((commit) << BCM_TCS_CMD_COMMIT_SHFT) |                \
>>>> -       ((valid) << BCM_TCS_CMD_VALID_SHFT) |                   \
>>>> -       ((cpu_to_le32(vote_x) &                                 \
>>>> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |    \
>>>> -       ((cpu_to_le32(vote_y) &                                 \
>>>> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
>>>> +       (le32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |    \
>>>> +       le32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |       \
>>>> +       le32_encode_bits(vote_x,        \
>>>> +                       BCM_TCS_CMD_VOTE_X_MASK) |              \
>>>> +       le32_encode_bits(vote_y,        \
>>>> +                       BCM_TCS_CMD_VOTE_Y_MASK))
>>>
>>> Why is cpu_to_le32() inside BCM_TCS_CMD at all? Is struct tcs_cmd::data
>>> supposed to be marked as __le32?
>>>
>>> Can the whole u32 be constructed and turned into an __le32 after setting
>>> all the bit fields instead of using le32_encode_bits() multiple times?
>>
>> I believe no. The fields inside the constructed TCS command should be
>> little endian. If we construct the whole u32 and then convert it from
>> cpu endinaness to little endian, this might prove to be incorrect as it
>> would swap the bytes at the u32 level, while originally, the bytes for
>> each field that was longer than 1 byte were swapped before being added
>> to the constructed u32.
>> So I would say that the fields inside the constructed item are indeed
>> le32, but the result as a whole is an u32 which would be sent to the
>> hardware using an u32 container , and no byte swapping should be done
>> there, as the masks already place the fields at the required offsets.
>> So the tcs_cmd.data is not really a le32, at least my acception of it.
>> Does this make sense ?
>>
> 
> Sort of? But I thought that the RPMh hardware was basically 32-bit
> little-endian registers. That's why write_tcs_*() APIs in
> drivers/soc/qcom/rpmh-rsc.c use writel() and readl(), right? The
> cpu_to_le32() code that's there today is doing nothing, because the CPU
> is little-endian 99% of the time. It's likely doing the wrong thing on
> big-endian machines. Looking at commit 6311b6521bcc ("drivers: qcom: Add
> BCM vote macro to header") it seems to have picked the macro version
> from interconnect vs. clk subsystem. And commit b5d2f741077a
> ("interconnect: qcom: Add sdm845 interconnect provider driver") used
> cpu_to_le32() but I can't figure out why.
> 
> If the rpmh-rsc code didn't use writel() or readl() I'd believe that the
> data member is simply a u32 container. But those writel() and readl()
> functions are doing a byte swap, which seems to imply that the data
> member is a native CPU endian u32 that needs to be converted to
> little-endian. Sounds like BCM_TCS_CMD() should just pack things into a
> u32 and we can simply remove the cpu_to_l32() stuff in the macro?

This review [1] from Evan Green on the original patch submission 
requested the use of cpu_to_le32

So that's how it ended up there.


[1] 
https://lore.kernel.org/linux-kernel//20180806225252.GQ30024@minitux/T/#mab6b799b3f9b51725c804a65f3580ef8894205f2


