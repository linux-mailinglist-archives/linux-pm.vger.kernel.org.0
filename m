Return-Path: <linux-pm+bounces-20463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A230CA11B66
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45001686B5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F07236A65;
	Wed, 15 Jan 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGn2nMM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A80231A49
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927944; cv=none; b=QZ2eEkDYsG8JgQrLFYhF6n+MkjUoaVx5TprSTQx70TWJA1UvL5QxtXsnlbKiQVk3jGzgU26HO1ZfyViz/6fslTCYVkhU7DH989+c+9J2WI4iXAjMmn5BEWcGnVuBVpeEp//Kl6XcyNLAYL4WElFBRrLw3eDYTPRO4tKpP1SPyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927944; c=relaxed/simple;
	bh=J2w1v+NV+T5uhbEKgTi7hl2GwvQCD6c2XVc5LAAOvqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uou4YaxjLi5cwMmZe2aa9Zh2DY2swClY3ynoqcWc5oWFijm5gU/n4jQJjwhCr/IEV4T4dvSRFJx7Hj3MfMsUVXKjFJ3EoHy34ZGny/h0keTWf2w5cZtqQqgvkJPLv1pIWNorbYFJEpg1nOBJib+2JBZ6dauYNz822bWlXqY53Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RGn2nMM0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so902793a91.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736927942; x=1737532742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRtBI0eYzN3zGO4Vt6OPuAhGWkPsdo3j6PfD/pb2oxs=;
        b=RGn2nMM0KcdSmzteXNxfBuF2cZ2kfZ1qMHPPoYRMN84ell97y2/yeUPvsf2JQnnaOQ
         vEz+wEog006IGCkwrlPL/IribcgZl+rQwWHt55VfJY/NPBRsO1lljA27ZZ3CUJqJJ4Ea
         aj25aCCiqH/xfzmDj+ZO6rqQvkCexjvI9UhKU0Qaq1+BlYgCISS27LYJtkM3WlTTr1Fr
         6sT8Khnnh6HjCXS1aZi/Xw3YMiVfBCgER+xgqEZ+b+/pOkkhFrSxybLtObLrhypVN6WT
         9pT0/9WxDYHXwMKayp2Jcdf9PyCS+w6eqXVAJksAQM8C/h+LiD/YOgGTdO4+BBaA+WP5
         RQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927942; x=1737532742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRtBI0eYzN3zGO4Vt6OPuAhGWkPsdo3j6PfD/pb2oxs=;
        b=NWOozt4olKi4/vvxKlp3rRmimoegY25w0ZDXV32WQ7PcxOHBNj1qxWP6Ate2KV+NeJ
         0tsURgUi/PL8xgYTz0apzIWmpCzyENxOY0VzLIYrcCrq+OC8rdcYROuCPOdf1bkVUJOl
         fYjagJRYCh1/CgW/E/YJMrvW4Fq277hwzvrAtfzCUzhhuJPz1aFx01aPNEIbiTS7+i2/
         gvp4DyLFORfvOzYjbhPsre3eKEhHqui6tni9/YXaV8yVxKZkF4P/UeutOWuFM4K9v90P
         JpSiL5cM4JwjfDM1ZXofyxRVEu+3fUMWtp8ZLZqnXRPBdtPPoX6xMsWs4t4dcvTjXFyd
         0f8g==
X-Forwarded-Encrypted: i=1; AJvYcCVQfBo9zyCnESOiOmLsw/EQsp4+1yow3GwkQBIjy9//WimYkff/Lq9AFXw3WEAhVn4vhs+hXsDBcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGShXgi8oGMnQ2X5GSjIGlOGhRsaQgwIepUxKb8krSUsP1pO/9
	gZckqbLetPk06WErOqSkDE6cByGj3j7EoaCZ7/WuExhJyH6i1Ein9MJkW7yijBM=
X-Gm-Gg: ASbGncuA4i1dVQXOkVIbEV3ubJMD5xnMEBAgCojwTlb3gQN1BtW5HW4nqwsb9XRs7w8
	BBrXUa/bDsP5gr7yOV45tatjoyCsgRDj4V2dCgoM1h0gvXR0gRWYnEulAxR7q9i/r4RmYgKdQDV
	o6uqFq7hXiXBQC5poqyZYARD90hxpK7NpkWAk5TqJA1abp/tSYzXOhk4MDJmdVfVxvSHmruxXn9
	SEpQGD5T80L0pXH4YgsIf5XqcumN/27JRu3WRoCddEniAXKAmWTZmol8LI=
X-Google-Smtp-Source: AGHT+IHbm+cIkQU1YgDeK8Q7V6/SVahQX+CN1MsZawbsf5oCkbZN5Kt2kwHxxZIcWIfANw+NsvdodA==
X-Received: by 2002:a17:90b:3ccb:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-2f728e001damr2666575a91.9.1736927942136;
        Tue, 14 Jan 2025 23:59:02 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2bb340sm760400a91.39.2025.01.14.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:59:01 -0800 (PST)
Date: Wed, 15 Jan 2025 13:28:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Message-ID: <20250115075859.mjpcvwctxx2vutpu@vireshk-i7>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh>
 <20250115072050.72oeibi735k3pjdq@vireshk-i7>
 <2025011537-shuffling-unpaved-121a@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011537-shuffling-unpaved-121a@gregkh>

On 15-01-25, 08:54, Greg KH wrote:
> Ah, but that's not really something that SAFETY should override, right?
> 
> Yes, you know your implementation of this will stop using the pointer in
> the hotplug callback before it goes away but that's not documented here.
> And having the device "fail" afterward isn't really ok either as you are
> relying on the driver core to always check for this and I'm not so sure
> that it always does on all codepaths.
> 
> But, I'm ok with this for now, as you are just copying the bad C model
> at the moment, but it really feels like a huge foot-gun waiting to go
> off.  Any way to put some more documentation here as in "use this at
> your own risk!"?

What about marking it unsafe ? That would require callers to document
why it is safe to call this. And yes add more documentation here too.

-- 
viresh

