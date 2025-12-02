Return-Path: <linux-pm+bounces-39101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E29C9CC78
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E32CB34AD8E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5D2DFA40;
	Tue,  2 Dec 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGPCLLDs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1652DF3F2
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704205; cv=none; b=bseL1ZY55OI7J5L7t+kWLxp9mqiO5P1ii0ICqJdJl3LREx+j+6nRr6oBMC4DHKuULJSg9ljkLVXRp7nXb6r2e5EHHqtF1Xz4RjX79pp5Rp3wNjomnpZnwzasMPElbapIL1GNZ7Sh1X476k0yTImOAnAaxo+wmCh4SZS0wJTyyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704205; c=relaxed/simple;
	bh=iVB2tUU9NyWCJwyr17jsnJeWp7fxwKZUMJnAoi+NC7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZetB6onlRymbbI/NFih1P2SWqDuPjBBGzPaM00aOI8CBTAI9IMW9f2yGZfx073uX/krZie8zQbTy/zW6sFypS7L3bnWNUjmjnaUi5HFS5nQcUxZBtsDlAWyyBt1GZYdJxfuQH4br81DSNhyKU8XM7X2CdUBiZV1dNGehjhdQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YGPCLLDs; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2a45877bd5eso264189eec.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764704203; x=1765309003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqCqs0wMDbUotwFHzh9uTitZSgBhU4Iq3Nx1nhtFb+M=;
        b=YGPCLLDsJbszVKDlpz43SN4xrJo5aCRc9fmxorSa2Y4m3PbLuM6Mv1c08mirS1ZoDS
         YYpsBBxVRsxer3V28qIhDMiHYlxhwt1YceB3EAxx+Sbro4uxLIFvBA53mb9wllx3dyYX
         0S6beqq9Nr7Ei/gDldQVGIQBO9yJlp2pcbjs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704203; x=1765309003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqCqs0wMDbUotwFHzh9uTitZSgBhU4Iq3Nx1nhtFb+M=;
        b=oIGrWXRPOzDywYTjPGMXUl26UFU8h/SbeEdIN112ATq2CaEkh7J4ll32qZUtswOYYA
         QuZDBnVT//sHWXsMvVMHiHBKt9r5SaLgKtTTCSo49vqZL3mZX+UyUyeW5r95y2KB/lGB
         Uiti1jHdmnrENHlUIiMv55Qn6rEm82h/7xdtrEDdgE+i3TwZ8tN7ziunbiFaWkqYPqnq
         ERdMwqVjVACBpDYx5w+AaXwxr3utwH++agm+1fm4QaztRhNqmnDm1YZidwd6Wm6iCbRv
         DH88m57l6dkUnsucG+kxK0UAkZwSqmAPzK7n6DkwdKE1PHHJ3wNgqPOIQcihKou7ipWW
         WlbA==
X-Forwarded-Encrypted: i=1; AJvYcCXzX2q8cSx4F30dhReA0jEUz9G8rD43I7nM+EHmRJiGQ8uqkY++Bwv02Fts95a5/Go1UknF/J0hLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHWZ1XU6uM3HwmC8z11Su5PIURXN/7ghuCnmxelsxX1d5SSrG
	x5Y8kPWZlpos+rDZO+8KEx+t54Puid0laJa+TL1RtCVkRR/ocPTz/BwJltX6HlMuCA==
X-Gm-Gg: ASbGnctPfLT3XiOb72ZDNPzrj6IFF6MNtS/0fKstMqUzZCOxKc/x0e4hnlD5nh70Bxh
	cVIHQ2gNXZnC1Kr0sDOJsiHGRdGFXq6IP3+mHqMrPXkRZYRP+BupP6g7W2mnARhZOhL1YDT5UkO
	lAT/uHgsVge6qCfXtH3tKxYPMjISkE9S9fv0MAYNHj0U6Mcj/IDDVrPJeAX7qDJ0dKAhiFE2UgC
	/7a4V+povWumcazAFgdQlIBQTYMFl/3EaWoKqX0gkegyijhYYzOQDsDT/F2BEHW9hKXdLBBlfkx
	0NarcrQvIQp1FcyHkHEcgohI/W2lei1tClmlEDpD+Xqt61CLXbpzN53pheGz1OFpKww2iZpNgGw
	L2b8yA31VpnKyd4VvWlAHEUtQxtVTLFbACPoYzdFaXsj+4jeTb79URc1rFKJArS+J5yH2s55npq
	agf596HVpDp5GlOxGx9QKa8b3S7Cxg9H+V8pE/9ApjFQN82AzhCQ==
X-Google-Smtp-Source: AGHT+IEVQx8sB6NEuDyNpChjzmxkOnJrEYSN+w7QdGbEZQrDRISastygm8L56l8ae3QxxfzVClWTZQ==
X-Received: by 2002:a05:7301:3f0c:b0:2a7:760:2b49 with SMTP id 5a478bee46e88-2ab7e6a91bdmr2479816eec.7.1764704203092;
        Tue, 02 Dec 2025 11:36:43 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a9655ceb04sm56613186eec.1.2025.12.02.11.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:36:42 -0800 (PST)
Date: Tue, 2 Dec 2025 11:36:41 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 6.18
Message-ID: <aS8_yf3huoqDz2hB@google.com>
References: <CAHk-=whnC+hRftevTLeVs3tyyqwn+7un=jUES2-WX+pZhDdKNw@mail.gmail.com>
 <93259f2b-7017-4096-a31b-cabbf6152e9b@roeck-us.net>
 <aS5wCcwpgkS9n67u@google.com>
 <fb19346c-908a-47e1-ad45-bc44f0a10f7c@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb19346c-908a-47e1-ad45-bc44f0a10f7c@intel.com>

On Tue, Dec 02, 2025 at 03:37:58PM +0100, Wysocki, Rafael J wrote:
> On 12/2/2025 5:50 AM, Brian Norris wrote:
> > Looking closer at this part of the API, I think checking the return code
> > of pm_runtime_barrier() is a bad idea, since it's inherently racy, and
> > there's really no way to control that race. On the plus side, this test
> > is the only one that does it. So I can probably just go ahead and make
> > pm_runtime_barrier() a void function, and stop pretending it's part of
> > the API surface. One fewer weird part of the runtime PM API to think
> > about...
> 
> Yes, pm_runtime_barrier() should be void, the return value is a leftover
> thing.

Thanks for the confirmation.

> > Maybe I can get around to that tomorrow.
> 
> I can do it unless you specifically want to take care of it yourself.

I wrote the (bad) test, so I figured it's good citizenship to fix it.
And anyway, I drafted it most of it yesterday already.

I've submitted a version here

Subject: [PATCH 1/3] PM: runtime: Stop checking pm_runtime_barrier() return code
https://lore.kernel.org/all/20251202193129.1411419-1-briannorris@chromium.org/

Feel free to tweak it or do it in your preferred way though, if you'd
like.

Brian

