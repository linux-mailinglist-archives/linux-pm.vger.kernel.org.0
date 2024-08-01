Return-Path: <linux-pm+bounces-11797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D39446A0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025A11C225D3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06017130E4A;
	Thu,  1 Aug 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owbB2t/g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F519478
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501083; cv=none; b=Xsn7Exto5dpoVpDUsUU/yMthy2TjEZmSY+ByUe0Jp3oKwYTCbEyi+ZY6Q9Zs072S8QeZ7dTkfZFupH7zJqy92gEoR04BjwmdyohjFbW12QaQ2OQBtppuZMrXpKXzhkQn/dSNZct6keAC7BXPlsOfcu4urJBNhM85OzUMAwhB+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501083; c=relaxed/simple;
	bh=j35qK7hgEdLDisIrenEFMd9EiCzNO2JfnVmaHQ9kMZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyIu4ksimnJLQaqCScldhDamCSKbiDhB0Cmw5gS0BYHMxDAjkfderwHDoNX5KiQ5P/DFjaFjx0NlqckXdWuDC0+H98MOWxYe5vEcpeJWsx4g10dcs7wleIcMZjfjOHuqCWYf1eoStp6rtiaBAoIszK2uk7CR3QSLFz4143/sSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owbB2t/g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd9e6189d5so53471025ad.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2024 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722501082; x=1723105882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6DIqP6SgLThiqKeTL1B0jqC1r/AlJW+EfZyuiDXv98=;
        b=owbB2t/glVjqOjT80UWdn7BCkEPQhsD4j+QhoASp+8XZ4JQsPwTDBXgq1H1Tj8gHN0
         i1F1KQL/9qbEwuRT6kKbpLORO5YstPxaDszLSDvtEW93fL5idhq7dLwGHdf3AtOaL5G4
         NwAR5XeZe+7srAcbTKr+PKd5AIBT4FvZWx/jKnxu3JyVlSvM6zyDNQfS7uIjBcMX5NGN
         lZ2Oqkcq5+t+XEBI8Fz8sJRY5+AazQvBMZzrYj8nHUa6mfX+TCZ3ABANG8v2gbNgC1th
         lsXM5mqdJG6LmhvhVu1RernN7e0bseS9SC9Yyb1ftAkYX226V/ZQnXG8eKmRluOgCbfy
         zAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501082; x=1723105882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6DIqP6SgLThiqKeTL1B0jqC1r/AlJW+EfZyuiDXv98=;
        b=wYNWeMQdrsfbt5xwlQrZ+/gx2RvLCwHCess3JUnkB46x5YOJ3z7rIoncmdToxlimvZ
         rsHy03pvqczNOW+Y8l7+ldK5HdQTGy83qVt9bxDdVI+Odnlj7DoyobrgkGsk/aV1EwPl
         xftb6dBuB0cAa+fFEMvMlN0Y3zFEGMRLvH7TszjNmADjTVOGCDFad7dwr5gn06l5GBLO
         bzdnKejW2JbmEmZUDmvxlY3mOl4M+Ibo4+Lu1TvDXV18vtavzho2jOfmm6sDBmy6Vh4l
         iAJKCeQvqwAcxFazy0kKj7TNudH7z6c5nq3Z28bQdHNx6o8AwGzFC72YVLYPdWeG3Ml0
         uLcw==
X-Forwarded-Encrypted: i=1; AJvYcCV7NoSrDcvZjyrH2K88p7D3NgVnp1qwg/aML8ZAvLZJ/PRQd3MuquvYn/ksdz+SrXZHkdLWIwwtvzPllV7C6gf79QkiUfVv+TQ=
X-Gm-Message-State: AOJu0YwwdJ52f+ZZr+b7nk9/cgpNd4US0Esxa+aJdJprA6rbUlVhSRyO
	hBy/GEYnJzDTgXJn3SgXlKHuNwrSqaiy2Kpx5Rp5zwo/jB49rHesiQW2Wa8Tg5Q=
X-Google-Smtp-Source: AGHT+IEFbcz8UfvSIGynalkuH6rlmXwWqz3KVvNjKxzROzhzmV0ozLRqPOZ3mGMQ5a9sLQ4urpd9tw==
X-Received: by 2002:a17:902:da8f:b0:1fd:6b87:2147 with SMTP id d9443c01a7336-1ff4ce57f02mr20721685ad.6.1722501081886;
        Thu, 01 Aug 2024 01:31:21 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1482sm133790605ad.155.2024.08.01.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:31:21 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:01:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <20240801083119.bwd6k6vimwyhv6cl@vireshk-i7>
References: <cover.1722334569.git.viresh.kumar@linaro.org>
 <e0df2db1caa49f15628aa18779b94899dcf37880.1722334569.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com>

On 31-07-24, 15:14, Rob Herring wrote:
> We don't want anything in Rust based on of_find_property() which this
> is. That function assumes a device node and its properties are never
> freed which is no longer a valid assumption (since OF_DYNAMIC and then
> overlays). There's some work starting to address that, and my plan is
> using of_find_property() on dynamic nodes will start warning. The
> of_property_* API mostly avoids that issue (string types are an issue)

Okay. Migrated to of_property_present() now. Thanks.

> Also, it's probably the device property API we want to build Rust
> bindings on top of rather than DT and ACPI. OTOH, the device property
> API may be missing some features needed with OPP bindings.

I am not sure which device properties are you talking about. Are there
any OF related examples available there ?

-- 
viresh

