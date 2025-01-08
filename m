Return-Path: <linux-pm+bounces-20074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B0A0536D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AE37A24CB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3131A8405;
	Wed,  8 Jan 2025 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8ietw9S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177171A8400
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319232; cv=none; b=BtSqZNbMQ3qSgh75b1aM1YWOozl8vQX556qcZZbh8zvkRKRUMGoG962JKGMdu0vAOLk7PxC7h176atsvOKWktKD/A+LagtcPIuYTEUAQ7PiRzJTqvDp1HT6jusOwpPMEYYZxgRRWegOxJ5EBnc4/NBv3pUDtKf8eZnD+qP2Xfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319232; c=relaxed/simple;
	bh=qqHug9/s36cd12z+EVh/TDfQACCzQnrs66JnP902TIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQlPC+D+7swWJCCGbQqsQ/bVA0pyllp9uioFd3pKU3I3qFSkJ3dw/ffNMyO5LGR1FR1uYF8GBShfzN2nRAqyTY0+egolIVaE4sWXRMLtd3i3nAlI/p4681Apytc1LewTCqtXXW21jD2Nf/BuJqTrJCI/p2oaIlLu6D8tBun8bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t8ietw9S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21636268e43so67895975ad.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 22:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736319230; x=1736924030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TR+by4BWVJ8o0ZvzthYMJxPWMPi0A3Wu6cOaNAiYqWA=;
        b=t8ietw9S0th3Bq8lrLPNLA6c3h58Zpnp3srjDEtLVU82a7pk9AK5wDfCnbDBoHuZkb
         ed39Iz9ZSV7fowcEKXnOPf0Ft+WR5+Q+vNvVOqTHej3Zij3Kgmgv4VEZLeJpSZWM2GzD
         m8yGU6OR3qlhyVO4lVVDPbWfP/18iPRNZcRgVykaxRMTtPf7uQSl3FekMil6kDvTfNz5
         l08y7LZBNSFPoMMALuedtRP+6BI+6m4xhqmVL3WdnmBPMxL6q1u70/ieE3VCp49DrzSC
         b+dJbBVFmG4KvmFa8eXtJo4lGVMV4PnWnx/O4EFxhBDYoqNPcTl2a0bsZeXVFI3RwlgE
         XZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319230; x=1736924030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TR+by4BWVJ8o0ZvzthYMJxPWMPi0A3Wu6cOaNAiYqWA=;
        b=sDxEdvN5yt6SHHQzjLYu2PwpouL4r3UDcACo9M1zq3agFGenK0MYJsBV7kgt6Xg3ml
         whP3uPFQ030ce/KEgT35IX/5SCCFKunHiNQH4Wn83jMK0HmY0D+X0bMluodANAX2ox2U
         fPzRoEwAEgETKBuyU9rJIKlOix8Xln/VVzAcKZjA4HB6REY3TNdoqSYuATaSYRtTerPm
         4FtRMI+ZcIDRiyLLixBO0V93KESQPcDdfKc9vciSJ0EweGGg/028KihSLb2liDfVwi6M
         DDeRCGcsGMSmLKW+CitmYS0jkMWv28Z5kzz+HkhcoEM19TPNYDVJT6jsJdnPx4lBha1f
         s9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Gr9nRoNQk9XgcLi6hwfubpuNLHl6JuVkfYqbaSP+tljLsMthLtoFWTNBC19qBrcqVicMjpX8lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkSdc2hm6w0/CVwnyinMl9e5QoDY93gpXWPTbW7KRQaXoS6TQ
	PHMenRyXKN5DCpyZn9m9+PwSKaReJc/fg9442nakxv2vg4PVozyFAw+rwCcNpJk=
X-Gm-Gg: ASbGncvPIb1MYNcN1SvrrEs7K7FwBP9aDbTeCUZleqtmhtRsaZZfuvS8aQXRSOc0I9O
	1DBJMH3J7LDCOoYcq8uiGXW/EUdUwoDEjuqwFa5fdD6MP8A4QsyTOAqeaKoQCXmh0/jZsSgZ2Ej
	u5dXHNwZAHfaNsc/GDllP1xubHXH+nulLkZ6s5zt54ISClWVMTz1KAleEuXvAOgmeyKng+Ekojl
	LgilxE4AiceTgNMGrIlI4tBv1/wm/woEkO4CIS/mFwf2PiroclvsqBl0C8=
X-Google-Smtp-Source: AGHT+IFWpYewyVhbM9Lfm2gTjJvjaH0MyBz4zZWbWgpn0kP9jZoyHHdS5UoxV703zrzryWEOMSWbMA==
X-Received: by 2002:a05:6a00:4190:b0:72a:83ec:b16e with SMTP id d2e1a72fcca58-72d22031471mr2386253b3a.21.1736319230195;
        Tue, 07 Jan 2025 22:53:50 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72ad3393d5fsm30478573b3a.154.2025.01.07.22.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:53:49 -0800 (PST)
Date: Wed, 8 Jan 2025 12:23:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse
 BIT() macro
Message-ID: <20250108065347.k67aqosuefcjdiqi@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
 <2025010752-vagrantly-juiciness-cd81@gregkh>
 <37DAF91C-2A1B-4848-A66F-3B50285AFEBA@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37DAF91C-2A1B-4848-A66F-3B50285AFEBA@collabora.com>

On 07-01-25, 10:29, Daniel Almeida wrote:
> Viresh, FYI, there’s already a patch for this floating around [0].
> 
> I can send a new version today. From Alice’s last comments, it only
> needs a minor fix anyways.

Thanks for the pointer Daniel. I was expecting that I would be able to use the
definition from bindings generated with bindgen somehow.

The C header contains:

#define BIT(nr)			(1 << (nr))
#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)

Bindgen doesn't get me a definition to CPUFREQ_NEED_UPDATE_LIMITS now. Is there
a way to make that work with nested macros ? I wanted to avoid defining them
again in the Rust side.

-- 
viresh

