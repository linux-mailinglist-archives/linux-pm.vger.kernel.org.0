Return-Path: <linux-pm+bounces-20077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980EA0566C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 10:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC721888884
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230C1F12E3;
	Wed,  8 Jan 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYuJTzFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B41F03CA
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327489; cv=none; b=jRtOAPWYyJnT0IuUh0pT4TbMZAcN2w3UacN4eudT79j7tj0BqEzbQ/B17eTtjDe208n0eTC0O9c5W1qQqcnGUkF2i7tvOMCcqmelNRfz7xV/JYfreCoXlwvmzXep8QqLwzaK2jFa87TTmOsEAxMLlmXKLjgRoB2a14kLrXfO5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327489; c=relaxed/simple;
	bh=PRXvJPDLmIV+SkzsVccWpjDkCQMDJtS/ouRJL97YwE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ76pb9eO26oy+SRNqjkYXA35cfxbIBDFlgJTZC0GR58poCrNuvTPn+BXLGZ1hkuXFuR3Q9cuCPLg8n4Qe0M8dIjpay8x1swVUu19ON6wCBKcKHkJytWyfdefvk9OO9OPp4LKU2rNfOzd1YRBsJnmcUkEgOHhlaNX+Z1ki0eptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYuJTzFv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21649a7bcdcso235898635ad.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 01:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736327487; x=1736932287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih+RxuSmmPqp1GyCbwJ2zhAAFkHO2nXzakJsmmbgiHs=;
        b=VYuJTzFvkAImL8o+KcXulmF3dM5k+cOxT+Co5zyBbCSXkqwQPH9eXzaIWi7CUlI6cQ
         lmUJ47KHthHMYTX03EAKRd/5hO6M6D2821AqVPu2REyQaqxnofa8WvPSiAY10jp5ZfaA
         QO3MGAA3IILoimPjPtstKogl4TVLFRtTe8YH2X5+TzXXwI+eA//REhbo146Zvy2cfN3l
         bEKtq8qK+88iIJkYnE/uHOcLkeeGMqEOmlqCdyEblUwcGpNI19nqYmYqMTYCdQNVmptR
         0ga4kNExtpCf1Ua0dd/cTKYf9KaV/iRgTyAMGo/+2DN+wp3WLYVseQEUa7KAvB1O2ePV
         pQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736327487; x=1736932287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih+RxuSmmPqp1GyCbwJ2zhAAFkHO2nXzakJsmmbgiHs=;
        b=jv3fVUaTmeGnzvQgwE3RmaC61/HDF5uVAghhHohcWxIgxmJ0Ar62vT/tLsxo0uzu1H
         IybHwaNRE25KuscUQf0k+MueYz0uBrYgX5GvVqiKWDacn2TplTKuc1hjrmujfGXvRli5
         pXtBVCpgYTfkiXBIex/XJq7apuzw6caxVjQPubogLejP20C21sYJrrgiwIT7kmFxbGBa
         13txbmKdLRtrFlU6ThW9sN4sY3iOnr2nFHZqt8A/dhxIhhFLIE6mQWTDNnD8imlUIHU1
         1wpkF4j6U7CsIvT6HnWr/l1ugXsTlryaEKM2/WI05cte3eq+/7teu5XBBYCW9wwqa8KG
         XlHg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+H9CVLCh6HSSZyuVc9+v0TCTeSJe2bTBukLXg1vgq9lCr6mcEf8W5LlQ4mMSYdVbYg2/d7Wzqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kMaTiVb3nL+/zCmYxx8zkBKe3PdcWz9lgUwLm2YifV0FeWlg
	vWm5Q/9iKZG03RBp0/x0DHdcb7Sozt2R3Af6P1TcY04lalBp4v73wmxEluFQGec=
X-Gm-Gg: ASbGncsDL6r5KrUshG74LwHYBgJTjymbMlS5aUdCSy8PzeQCr9XAqdoFgAg2QDo5D5v
	/2O5nIqw/C6eEuJxSMi/XK0csj0mEG9Ew1isF6FZCIMZ1KBxiagVOVS1GcBBEOaDirhG6VLyjkW
	E0yM8dMbQuY+m0iFMr6VNXEAd1xexxEyYFkqasS23qvhqi1nWqd3+vwvqkBc9OusvRaUmreXfBa
	R/pnyZ23Hde/Es3MJT78qdJyBSf//h9Jcfd9op9RJ/p5LVIWhTpJxug8Yk=
X-Google-Smtp-Source: AGHT+IFyNbZVZ+zegqkrmebADogddz3aKSlII6j+c+eN38z4QYi8g14gCzJV69Rzr79D9N0EVYoUoA==
X-Received: by 2002:a17:902:c951:b0:215:bc30:c952 with SMTP id d9443c01a7336-21a83f4298fmr30968735ad.6.1736327487368;
        Wed, 08 Jan 2025 01:11:27 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdf02sm323287095ad.151.2025.01.08.01.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:11:26 -0800 (PST)
Date: Wed, 8 Jan 2025 14:41:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <greg@kroah.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 01/15] PM / OPP: Expose refcounting helpers for the
 Rust implementation
Message-ID: <20250108091124.3cqgjk4k45uuvppk@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <fa014791cad083ad77125cebad11a6d5ec9592df.1736248242.git.viresh.kumar@linaro.org>
 <2025010759-errant-lather-a64a@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010759-errant-lather-a64a@gregkh>

On 07-01-25, 12:58, Greg KH wrote:
> On Tue, Jan 07, 2025 at 04:51:34PM +0530, Viresh Kumar wrote:
> > The Rust implementation needs these APIs for its working. Expose them.
> 
> Why is the rust code unique here?  Why does C code not need these
> exported?
> 
> And that first sentance isn't really good grammer :)
> 
> Also, you created a new function here and didn't document it anywhere,
> nor do you mention it here in the changelog text, making this a
> non-starter right off :(

How about this ?

    PM / OPP: Add reference counting helpers for Rust implementation

    To ensure that resources such as OPP tables or OPP nodes are not freed
    while in use by the Rust implementation, it is necessary to increment
    their reference count from Rust code.

    This commit introduces a new helper function,
    `dev_pm_opp_get_opp_table_ref()`, to increment the reference count of an
    OPP table and declares the existing helper `dev_pm_opp_get()` in
    `pm_opp.h`.

-- 
viresh

