Return-Path: <linux-pm+bounces-21784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8BA3053F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7146F161A07
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA631EE039;
	Tue, 11 Feb 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNJ/M+P4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF81EBFE6
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261292; cv=none; b=FZDXjI1rMwN0xO2cCb0tgZ6ZSbx05sk0DHox0qbRq6jjpgldVZPWmwGG/7P6A5cz3MP95pDABex5CtFYZHe0nU/DQhvaKWoh7mzSJ/o0kR79nonRlESZfFrKNDs4XEK2CEB04OovsjOLLVtXfKjvwI07uxaSR/QWK8auHXCNQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261292; c=relaxed/simple;
	bh=sSpoVF5tKRxtaZqs6uZeX1TfHNKBHsN9FJ2ZMpPBbCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=np0hESO2AVng5e9WreFMPZsAOgFnAE2k913mp/z6yH4xtGFepMnY3J3cDDn7Dyyz9V0xJfFywT2YLE+js+NTMJ27orcFzxiZZMOohDLZzPd9JXW9Ups7VCsURwAKuJmgbyhB7hmPj9Jhk+T97zHMkMELA/K2ihHSFFPrryZIRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNJ/M+P4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so2413405f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739261289; x=1739866089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiK7BHSVgTdQkQZzP88yLZAKhA2S6bWhUg1LMOvnPkc=;
        b=MNJ/M+P44eCpvjNzhHf+T9kXx8foal5f8Jnktvpw+2I/lFKyFtcVVrR9E5PGbVYp5k
         2nqq0spvzUITEVqIZkkXWL71H0zknQ7lpVPzWrSoMp3OEG3Of336/LFERHEaG0tOf5Vw
         Yb8YXX240uaaEUWDk6iTywKWqYUj4B+nN8H09uS9fA/0eAnpgVuCWEgEFCuNLTR0Q6Xb
         PXvjTPLbFxwNBcidp4QYnJMJsbLVprlXzMKuopJOsoInH76/KA0aD3U+3cX0cFP984TH
         zrm/RH8TYZ55+Af/vdd0B2KLEoq1PxK/wzUgmq85iBwu/6y2JRATl8/dZ4tFCk7BN514
         tbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261289; x=1739866089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiK7BHSVgTdQkQZzP88yLZAKhA2S6bWhUg1LMOvnPkc=;
        b=wuYimc91V3VAIx0ULmmFI0FPQldvQf0e/thd1Nb+2Px+c/RaBfTFcPVSn83w4N5wYe
         I4phXbTZCeDDks76y+hIfZeCJFtutvrvysMTpn7C4J5ibQQU+2avMGKkLUpammVaj+o2
         xGNoxy7cwG/A8JFopFAj1bz9eFut1VxXlrHMXjuXbemA/bTNzZ2YvEnqXf4Vm5qfkiTJ
         DC20CMOaPLR438JCN3RRt3KnO4E45mXle3sKgQzXTY4xPIZ8zfmB6Gg7n4rsm46pp7XQ
         uBy+grnBEDU5EJ6GCawDX1RrWbdRS37RsxbGuDl1XrRs19DJOJbc5uPfQYIACOUeBCae
         RR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNmeK/WOjtMDvOzKsGGJvhKGjtsAiBLDTcG5BsDAIdbAnQTlfaEl7COe+IIBme2escI8diAQiwoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUInLqPOEp9GPqMgwVrTmhKLkPkqdMdQuqvvAE/iKmTEXLnEs
	ASB5IU3UvKFJJJnSmNXlowD7J8xCTC3Te3CcYc9ja9y9WoI86BKMtcnoJXQdJ9E=
X-Gm-Gg: ASbGncvlnna6AvVDFB5596Xb8OcfvHyBQMSlIb82kuWLkB9RwnbXJLgpIsr4Qqbth4M
	kWnZ8Zwuft7Ke8M2zaDVf7yC4akE6P6M7C/vlunBgLH8B+VRAO4k00bnkYgut/T4XCty10NSv2T
	9lHDB6c4wE9exw9Q3jF4R3Z+cdbvikuxMOugTsMpxJ5XY3OAVJCowz+aHCoNtISZYG2nlbOJgg5
	X7dvBpTimR9CpBTZb9uA+ybozdbl+CGQpLY+FlGOmGUMhfWWt7Z6TheODy9+c/UrW8bWtdJFSwV
	ZMywNHIHGOlZ2oYE3BK9SFmomHQlKMGlFMe6YA3FY7SZgQ0uQUeNHe8=
X-Google-Smtp-Source: AGHT+IE2oWYuWjmjvpu3ABr0HEe1925aEaOPbTS7VONKBvqKWoMObjwVOs9MsKRzrKKQMRmZMw7JGQ==
X-Received: by 2002:a05:6000:1561:b0:38d:e38a:5910 with SMTP id ffacd0b85a97d-38de38a59bfmr2866271f8f.28.1739261289162;
        Tue, 11 Feb 2025 00:08:09 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4392fc7ceacsm102977005e9.20.2025.02.11.00.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:08:08 -0800 (PST)
Message-ID: <0b37e5e1-6dd6-49fc-b874-741e75c8d56a@linaro.org>
Date: Tue, 11 Feb 2025 09:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal/drivers/rockchip: add missing rk3328 mapping
 entry
To: Dragan Simic <dsimic@manjaro.org>, Trevor Woerner <twoerner@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Heiko Stuebner <heiko@sntech.de>, Caesar Wang <wxt@rock-chips.com>,
 Rocky Hao <rocky.hao@rock-chips.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
References: <20250207175048.35959-1-twoerner@gmail.com>
 <5f9cf65221690452d7e842ee98535192@manjaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5f9cf65221690452d7e842ee98535192@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2025 02:40, Dragan Simic wrote:
> Hello Trevor,
> 
> On 2025-02-07 18:50, Trevor Woerner wrote:
>> The mapping table for the rk3328 is missing the entry for -25C which is
>> found in the TRM section 9.5.2 "Temperature-to-code mapping".
>>
>> NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
>>       4096-<code in table>. Whereas the table in the TRM gives the code
>>       "3774" for -25C, the kernel uses 4096-3774=322.
> 
> After going through the RK3308 and RK3328 TRMs, as well as through the
> downstream kernel code, it seems we may have some troubles at our hands.
> Let me explain, please.
> 
> To sum it up, part 1 of the RK3308 TRM v1.1 says on page 538 that the
> equation for the output when tsadc_q_sel equals 1 is (4096 - tsadc_q),
> while part 1 of the RK3328 TRM v1.2 says that the output equation is
> (1024 - tsadc_q) in that case.
> 
> The downstream kernel code, however, treats the RK3308 and RK3328
> tables and their values as being the same.  It even mentions 1024 as
> the "offset" value in a comment block for the rk_tsadcv3_control()
> function, just like the upstream code does, which is obviously wrong
> "offset" value when correlated with the table on page 544 of part 1
> of the RK3308 TRM v1.1.
> 
> With all this in mind, it's obvious that more work is needed to make
> it clear where's the actual mistake (it could be that the TRM is wrong),
> which I'll volunteer for as part of the SoC binning project.  In the
> meantime, this patch looks fine as-is to me, by offering what's a clear
> improvement to the current state of the upstream code, so please feel
> free to include:
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> However, it would be good to include some additional notes into the
> patch description in the v3, which would briefly sum up the above-
> described issues and discrepancies, for future reference.


Applied and added the additional notes in the patch description.

Thanks

   -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

