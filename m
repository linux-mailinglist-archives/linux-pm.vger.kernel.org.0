Return-Path: <linux-pm+bounces-20132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9972EA06D68
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 06:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A7518899AA
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 05:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C72144BE;
	Thu,  9 Jan 2025 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHwOicnQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479C2144A3
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736399693; cv=none; b=eC7qSm5d/gvv1htBkUO81smi9NUKUM6Aa/7VLBJadISB7TcK6OoNoZOzQ5hD16pAx7E14I+VZx+Nh/ZiM3z3ffU19zB+pYR4E+ae6HVxCypULQPoe8CZncJAFApQNpSqu4Ak/hUB8UDQERuGljbapfkaZ+K/XB74t05EB7sgAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736399693; c=relaxed/simple;
	bh=kCmPpkSLiAKVuZ95e/7mKBE+sinlh6/yM1qdu2FaZR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDZV19dvMC7AK8plWFXPkeD9V+f0c2XuOwxzP5BtVUX3nBESPzxpYou1icik4Ow38KSdxpUSF9IuU0oYc2Sjys4Emlmj2EwLnDKeav4S/guXO8VmLCffhh3VxZyJtFElcQrgevdbX5HV7XHUOjjyV4GNnh5AexlQhDMCAaZTpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHwOicnQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso732574a91.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736399691; x=1737004491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpvr7W3/jJn0AS0gG1/EuGnzadSe4E7oYDGzSsbTQWw=;
        b=LHwOicnQABRdOBII9j/Vj4yWwrXEqXjXuAyygajBWJJEs8ShdgnIHmGTiyAu1OeH/G
         gWNIqfpuw88Cx3JKMi1T+zi8y/bRD5grKN7FsE2u5lltHkZPaolkpUDvTVQznnU/W6/g
         RhOTJlTz2mqMqkuthG6rhcsbncNYiyqrmw4dhAIjdGuVwU/57nf6VUvz+09K06vqxjZT
         SmpDO+fDNwdr8KsoJqqCDD3j4wZBMmBzmlvQiLN+2bWoENU9HWwL4yOm/Iu3b+LIi6n9
         tUsRU6msvo3E5tSq+BstLqoMHXVoYpBWQn+HzSI7Jk09m8OrmywxjbczOz+hsH4uvVCS
         d8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736399691; x=1737004491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpvr7W3/jJn0AS0gG1/EuGnzadSe4E7oYDGzSsbTQWw=;
        b=hxI3LOEn7Vrsu1WQL2E9JGQc342IdRvhPu6QoLeyVi8VKRZA82Ub2kqTw8inW9j4V8
         /PeYjby9R0YU/HCVsAP8shh/O74nkTYKjsZMCtmd+R8UJr4NIBk5AQmJHL5oPiPHKbWg
         5IV3OVxhFELXEcAmk7Vpfbc75pr+jgjFAYq48cEsyUa9X35X3J6oQjfvaagFOcPxWS+M
         smuYA7aRR1sumjqO4N9+hmQNk2qnG4VctJBOzdf2ud733clJmBT5QU69+oLeKxNcRZe/
         /Y7R4SVo7lIqcoalTqri2dZcZ+UmooMctT8b5ZJjpCnyqh8XmAHXjdGQLTaBVc9hJ2HW
         gjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjIkqEQdWESDOYg2BwCrLmpJleFmY6AEpFJPjferpl+rjg3v8/aQZmZKgaFOTbWvLrZObrytonPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsTEf6sLgTs/9rVxPUYDpoIpMgEto/BhULlosub30no7KDdFG
	4EWnGo+YIYefST1YjYOlK4lzEbO+usvnWOb40yCMiZ9eeSM5SfK40IqkkIrGUCg=
X-Gm-Gg: ASbGncssyLV2QSPsXEUXqLRlRGxFhzQL8KdLnWxvQ0/KRKkmycKsPNMuzSwgeOV1YTm
	oGxK9gSTWT9lTGt1nuHl4IPNTEF+jXCNdu75x4gEdFbvXN+4rfKdeBzX1FraEDu4B81I3OVBqzU
	ZrbK4cUWnNr2nfon1aiKAKkfJ06duokw1nM67nmGwtV+Tf6UCAAnokPCvI6i5mLiZ1IarKfOECF
	+pJtZngYeXUemf0il+pwhM59/9SFVgG9FWZI8mp+OcCO5FLbINZH+9DTTY=
X-Google-Smtp-Source: AGHT+IEoV9m5MeEWcpU/+NuG/OXICA2uZ6J/IzU4JO9kw3gQrINA8J+Ec6p2KiJvjnTmUXVCV2Xo2w==
X-Received: by 2002:a05:6a00:2c86:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-72d21fbcf06mr8331717b3a.17.1736399691119;
        Wed, 08 Jan 2025 21:14:51 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164d3sm36167387b3a.15.2025.01.08.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 21:14:50 -0800 (PST)
Date: Thu, 9 Jan 2025 10:44:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
Message-ID: <20250109051448.xfjbzle7becrnows@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh>
 <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
 <2025010835-uncover-pamphlet-de5b@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010835-uncover-pamphlet-de5b@gregkh>

On 08-01-25, 12:52, Greg Kroah-Hartman wrote:
> How about fixing the reference count of the cpu device?  :)

I would try my best to avoid getting into that trap :)

> But seriously, this is NOT a generic 'struct device' thing, it is a 'cpu
> device' thing.  So putting this function in device.rs is probably not
> the proper place for it at all, sorry.  Why not put it in the cpu.rs
> file instead?

I can do that, so it will be a standalone helper function in cpu.rs and not a
method in an `impl` block.

-- 
viresh

