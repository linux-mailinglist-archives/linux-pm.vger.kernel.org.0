Return-Path: <linux-pm+bounces-25772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755CDA94C7A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A993A83AC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 06:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0125743C;
	Mon, 21 Apr 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0r6QPBh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A46256C9B
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216409; cv=none; b=RU1rJHs8MiLomlYWrMj/EY+bW0nXVg1andFquSyI3ifryr18445LpzNe2je5qUR0EtqO3Xs2DiyO5j0ub/s810OBrwqd3FSP1rXFiG7lLKDGYb+qkPXsPhY6KAGUE+I7EQemaLX9bWfojrkzD3JlOyLwcyvwWxVeChsPxdFwS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216409; c=relaxed/simple;
	bh=5ShY1vAOjKO9LkFdxOS4Dz8PnV2WVVq3VAPLn3aR2MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5EKYVmgEqo/yxhuneVWDst+cBeWwBA8onBE3ZfWRA2kwJe1/2YGi2GwX/fXZ35Xg4h2j5kIeAr81/rDcorJwKIHpyR5rq5YehkNo4IsTH8M+YzBkOYq/iDVjhd6uucrAPMOtm+bWfZKQJz7DqLniZCegB+d20mtCPx0QIG4F4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A0r6QPBh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso52686645ad.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2025 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745216407; x=1745821207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yyoS1DmLQn/njuhu79GSmOu58DF5dEFijXO4m2g5lE=;
        b=A0r6QPBhm4p5bXkLQcj1OCOICkvdS+UkrVl1n815IMm8V4xhx0RtWs8iTWi5AWBo7B
         OLMtbbUC/TkNTEnPRJJTihCLvlTOXEnbAMOfOTcmhxBCEu/Vac8N4jO2uaclJyd3ZojF
         5o7WNqzbHAPidlMpkNO6HnogycKcONcwoNfeXsmKDDOqw5Gj5r1ofQWoHuHzjEjwDLb7
         UBncXBdvqEnjt/pCfs27VF5j4jIUOkNp7QtFRAEqsat4VHwy/aFEfhfGHrKqILhJtFnM
         taSzrTeLQjNSnNkFC0aulYGF0+ySa3N0qaSb6IXNFz090ZWjIPv/Vet1X6xp9WfhXbFy
         CVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745216407; x=1745821207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yyoS1DmLQn/njuhu79GSmOu58DF5dEFijXO4m2g5lE=;
        b=Hiw7RbQmXS5tkqAapPyG45cxDmRnTc2if2GYJXHod8zBFkoseYPKMW/0tvfdEJQTQ4
         PiRmNqtdW0xBsntitwqs6Kb6Ufd5h46Y8fLR3oAFNa3xIxQtotsTL4tKicjGPj0Wz2EV
         ANIZYmwcGbHkE4LAWXI2Iukm8ItZfG0sJTq7e5Ixx1IzYECWxjbNU1qjnUiAbl/i1WIW
         wKVdcHEVk9XBzfsP3eRzzTe4pqL82suotBR82FWP3WI9g/kLzn+KspCgtYVcz7I0QlFe
         DVQYnZCKW1zYQWf1PZp16gC7oSQhIraKiixrpnL313ZPdvBYyv4ee3+y5U2ndVIp6hPv
         1FVw==
X-Forwarded-Encrypted: i=1; AJvYcCUHS8nFnyax6IjtwqBguvgCdlcON2WfQ+R6uV0joSx6Q75RgWLZgIbVw0q2tttnNt2sA0oH3MfTQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuGWI57sWi6gCKB9fRvNflYdu4NYiCX8ms4eRcXVgF2mWiCJn
	DEAYqj/9gJmdi1CPB1jAqpNGx4acFgpslo/X0BNWJ3dt8sPrSBZXGlOLocj2Zx8=
X-Gm-Gg: ASbGnct2bfHLwosqHeHbtCE+xbcHLfvvzRwKAKheIweaMLenU/K0Rr1pB5rfsnjulnV
	1ETS6YTHDJhz4ggHI7Zblwe650/BqJMGaMF1ctPc/OPuey2QgJRZgCo0vK7XhqkpDkwcrtLpFhc
	hgkrWl3G012LbBq/4mRVwyxLiTBXvgaM7fFC0kk1rs5rKzPz5XfK1ffeEyntJ5LF3Bel1b8aFfZ
	xQ4PgCG8pwgqioYWXpbm82oiccyV9XKOKukGzIYyP7b9C8nQdTZsMk3SrQCY3gXgYAl8NoBT23P
	IaWTCI5x1BXZIyTGUTo3SMCb0IU++ZjQnCbUFpFLDw==
X-Google-Smtp-Source: AGHT+IE9Eww3HoH4RLAEaMq6rXZiNmV6E4Np474my0w4C0bQJ32+oOoJCrbqu7P7aWjSR6KjdYIX6w==
X-Received: by 2002:a17:902:f690:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22c53618cfemr152910315ad.41.1745216406731;
        Sun, 20 Apr 2025 23:20:06 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdbc5esm57552985ad.222.2025.04.20.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 23:20:06 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:50:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250421062003.lbxdxhlp6ulnjq7f@vireshk-i7>
References: <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
 <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>

On 19-04-25, 17:35, zhenglifeng (A) wrote:
> Yes, the policy boost will be forcibly set to mirror the global boost. This
> indicates that the global boost value is the default value of policy boost
> each time the CPU goes online. Otherwise, we'll meet things like:
> 
> 1. The global boost is set to disabled after a CPU going offline but the
> policy boost is still be enabled after the CPU going online again.
> 
> 2. The global boost is set to enabled after a CPU going offline and the
> rest of the online CPUs are all boost enabled. However, the offline CPU
> remains in the boost disabled state after it going online again. Users
> have to set its boost state separately.

I agree that both of these are valid issues, but so is retaining state
across suspend/resume too.. There is a difference in a user manually
removing a CPU (offline) and suspend/resume.

With a manual offline operation, the code in cpufreq_online() is doing
the right thing, default to global boost. But the user configuration
shouldn't change with just suspend resume.

> IMV, a user set the global boost means "I want all policy boost/unboost",
> every CPU going online after that should follow this order. So I think
> the code in cpufreq_online() is doing the right thing.

Yes, but any change to policy->boost after that must also be honored.

> BTW, I think there is optimization can be done in
> cpufreq_boost_trigger_state(). Currently, Nothing will happend if users set
> global boost flag to true when this flag is already true. But I think it's
> better to set all policies to boost in this situation. It might make more
> sense to think of this as a refresh operation. This is just my idea. I'd
> like to hear your opinion.

Makes sense.

-- 
viresh

