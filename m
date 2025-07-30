Return-Path: <linux-pm+bounces-31615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36CB16184
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80EE1AA2664
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856929A30A;
	Wed, 30 Jul 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="KpHOo62P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EE299A84
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882071; cv=none; b=ELCQiGkkNr/6LEgjiL4grIRTFgMjU+qk3lHo12BZwW55Q8m4LUMJCqL4241+jaaeUyxPbKvs5YWf0c5nhTy+Zk3RG7Pan33bXa76M7HuTmkpVkod6tdyp1UR5pQ7L6TOkF1/p9K9+45FM448aLjhmTDrfraMUeUaiiad9IiE5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882071; c=relaxed/simple;
	bh=3KhlsfxD1afiXVUFTv0MDo+p5dzoiP4SrD8Q5oUNi40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mroM8NWvVmZv2zW8tXPOsk+T2H80BULk3f5FmyEfAdZ7TRyEeFKBO8JiKwEslX/thlh9CCBsZv05cHVm8y1/zXT0iWVRcXEQMX7AwGD9gZ1p4wHaeJEmlpBKyl9MBaNOKwwEnS7eBK3jXRFqlDgwkomRHET1Mt1hx9twX9v5fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=KpHOo62P; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae35f36da9dso1385651266b.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1753882068; x=1754486868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75YOp4HxyEEORrkg+J0iH+aQiJlUPUOSbZs0eZIgZFI=;
        b=KpHOo62PCC2rNJXNQJNxRK6voenzjlPx4XXUxi62BXzAVuincYa3c2Wwofe2WciXrO
         AjlPvA068vIU5mH2deS3dBwN4ZKeOnjrDkDUPwB2hdOrv4nqeYFi/8u8YkmC+VMfEw5i
         kBQR+DdqUpKX/lFZc5wfcbhgtGMm316eiyw5b1/B3gE9rpDTJ2j3vBx6GhOhq+ltcMr1
         0UXxp1gewF3iKUpmhhmP+1ebb1pmxMPUckwwWZoFkFc0wmls3b8kONMjcyuHB04s7wxD
         nygtGvpgaOlFFNnMAQAamq2iZh5+b+FpfRHVK85weXlleWoouAo6l/G6f9EYHyHxnlvl
         lalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882068; x=1754486868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75YOp4HxyEEORrkg+J0iH+aQiJlUPUOSbZs0eZIgZFI=;
        b=Rmki+SRredvV1Pbp4ioFwBIVqv5iYdqcOpdfbe/W6KBmzl1AYJKth11R70QVL7uHmI
         x/4YgxhmlEMmUFsCEdev/hR9lI59Vv7YNyEuqd75WJBDwSgIgZTd/4//eHWQ52hJMWIh
         3HPxXLsLrZbGsosXiv9MR/5/x2mtxQkfMOPnBXiuUbgsVlCCgIM1l+JgB8WIyYX1GdfO
         dwhNK2VbknszRg2ihOV/xOQgenJPggQkt1tCjZxGQzNKj66lPSBOLgS2Fq8HoTmHOeh6
         XRVs0kYVNj4wzcXzx3BJ54RPfRpHglucZBRSvIElVhWnj9bna7BU9ybPimlJhuxSrkoq
         vpVg==
X-Forwarded-Encrypted: i=1; AJvYcCXfYZcQWUOwENhiakrKX+kJ7js1KOmU+AywX8mzPnRm+Ry/MyNpmC68mOmf2A/zPBcbtRMlF0e7ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJcaOX3ARGIIBU3vofn8sk4PofOLK8fwE5EEKkAul+V8dvC7i
	+7XhC3MrBSzz/YVc3/3C/Yq0uXwkbiS/oYZOSYhM46Sg3VNW5H4TPspqxOnxFuPKlWM=
X-Gm-Gg: ASbGnctvXuvrApKW+vCoDNZ89apUBh17/5pUj7Xu2IsBQ+5Gx6lkmSLR+rd2QSZNp5f
	/QAUMcbrVtRh/fdl9xAnlBzv8mFln9+hOagqHQn3TVwf19DE86XkTjf4e36X1P5Yiy9hSZWS8T1
	DFjrFKDk8GINGpxLrpdagrL3tWVKAmdq4sxmVALICGcLP/4EiVmlfGyCS7OLHLk+sLtvfYGTvJ6
	GRUHKyhYJ/8fso9TgBuZtPT0KsUXIBKSC2Q2ujQlRARdQ7/BIbjprBHvBEP0rsqOqMUnc+GYhp2
	htJDdo96x1Cr3/bBhAip3WZBzqpboVJ0IrfhiJqevSL+egbDOmzLMWG5o0pbvJlNcP4Q0VTOZIb
	G0Td3QtRaqp46bkbjFG2YtyKp2As6Xc1oa7SqypeHzvWekgsNkNM/xMbTFQx1GOSUQu9g+ubx
X-Google-Smtp-Source: AGHT+IHyHy7GapLEq74VfzWCjhi43qnvQ0e9vbEsRdz+rw2buMQvVQfT6+EDh1DMqSayb4erGZDneQ==
X-Received: by 2002:a17:907:e98b:b0:ae9:c86f:c778 with SMTP id a640c23a62f3a-af8fd96e1c9mr429180766b.30.1753882067956;
        Wed, 30 Jul 2025 06:27:47 -0700 (PDT)
Received: from ?IPV6:2a01:6400:11a:26:d163:a794:aa16:5e2d? ([2a01:6400:11a:26:d163:a794:aa16:5e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a2743sm752906766b.48.2025.07.30.06.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:27:47 -0700 (PDT)
Message-ID: <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
Date: Wed, 30 Jul 2025 15:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: clk: use the type-state pattern
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <lossin@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
 <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
 <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/30/25 2:59 PM, Daniel Almeida wrote:
> […]
> 
>> We essentially would like to have a `#[sealed]` attribute that we can
>> put on a trait to avoid the `mod private { pub trait Sealed }` dance.
>> (so a trait that cannot be implemented outside of the module declaring
>> it)
>>
>> ---
>> Cheers,
>> Benno
> 
> This is not exactly what you said, but how about a declarative macro? e.g.:
> 
> macro_rules! sealed {
>      ($($ty:ident),* $(,)?) => {
>          mod private {
>              pub trait Sealed {}
>              $(impl Sealed for super::$ty {})*
>          }
>          use private::Sealed;
>      };
> }
> 
> sealed!(Unprepared, Prepared, Enabled)
> 
> Note that I am just brainstorming the general idea here, I did not test it yet.

I think that API-wise it would be better to have a proc-macro #[sealed], 
something similar to [1], as it may provide better error messages, when 
used incorrectly. So the outcome could look like.

	#[sealed]
	pub trait ClkState {
	…
	}

And then

	#[sealed]
	impl ClkState for XXX {
	…
	}

If you are interested, I can try to look into that.

Link: https://crates.io/crates/sealed [1]

Thanks!
Daniel


