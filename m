Return-Path: <linux-pm+bounces-34411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4FDB520B8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0AA5836E4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F52D542B;
	Wed, 10 Sep 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH06cekx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9C2D3ED7
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531843; cv=none; b=bs1BHjQrxVFZXUt1vLEe5ruYSItSGtJ9hzjSrZmsTmTRQbaKdbR/G7m2b/a9imHD5YgVnoLDan79MfsfemLeTea6eW/fF5zA0sQ53Am0qZ4XqkNq0q0OiQcX68UUWd88/1sTX7Sp1hLEibYVZ/hBwKVhTYzWpsThwfj8RCNmYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531843; c=relaxed/simple;
	bh=SCwHNEdMA8MEn00BiFAEH+58S7M3dIzW3LxE3UwmJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udyQ8gXkjWEWvjvMupeUKVtX2erqLpXQdvmK9MlETRHqH1W0Ro0mpXIUk8VQBZUGwFmayy2iWRcnm6p0ioM+S/Nj4WCLU2HO+dxny0aY1q2ba2yNHSFXFOtaFFAJSKoXEPSeHsvwKX7jFZK+fotKIwvnPhuESF4jYNgTgOr49uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH06cekx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-811b06efefdso635882285a.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531840; x=1758136640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7snMmseLVBcfubyQhVWOsGdoU6rRK3K5ZVTv8Xsb4Kw=;
        b=CH06cekxPOyCvZx6yIU5SYzBawHUX7+Ou9ol6PsbLwgQMoxVU/XSh5CCgN4hFYWiOf
         anUv3FzI2ew7vmF2m6/M5LEWmQuVo8ri6AhRqBL7L7o6yr4NxAFfBg6lvAOWynrhsCXB
         Kiq0OfhRAa/gLlZLDrWduev0vokcxAu5cifZX8A4B76uQqZs3wpuv9xuqLyL/6XSGo84
         7bS8rPRw5Xm//UADI0zPEusNm3gj7DJv1tWZsCRkqHM7RLXClDmNIPewLje2KvcG3A/g
         vbwrREuN1aDQwzBnXaa741+z1/D57fOVQBdMLAzSXtPwx94a7yk4Nqou5OOpx207vnHS
         EcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531840; x=1758136640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7snMmseLVBcfubyQhVWOsGdoU6rRK3K5ZVTv8Xsb4Kw=;
        b=fINRvT61zezABRLkoI9dKCM6JzldWT9fktmxWN1CMmNkb1yWU4Q0VR7Bu3TPhK/WHx
         vC3gmuVmL0AkUw/2txv8q/pHkT9s7omzGeZTS+f1kmdrLECyUeQVLWbrQh/TJJMQDRlN
         I2Byh31Ed+Uy2WnOFtNBD6ttJ+r2zyJXWtsN06fz00Su11Op36aQd+riWVrXBnLDsbn7
         WK4lRVl7aA9YvsR/wkiGAC3nS5472uuBz8UaSvAGfp5NaXOokUTA8uu+wcAZwAEsxsxB
         JwslEKbutWudOeKL5ExjqDQflFcppMieI9U5b1Ex5qrzhXbSKMdvgSTOlYGq8lXtaU0D
         nzfw==
X-Forwarded-Encrypted: i=1; AJvYcCVNW40TzH7dpLb2Uaa3gjzSuzLPMwuHsTqN5MMTH+sdcb+/qC0kJRTOH0bCPY+ZAGfKf/goET6dGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwnsanI/lN3Ye8zWksUH+i9tgoyGLLffYgjrw8D/jyd5iA58L
	W0/EV8q4YcDlom7dO1SC2egLW9rbEGSSbWqe4AtrHYE6lHK0zGHkQtGI
X-Gm-Gg: ASbGncsu5oCigQDxu+mu4Z4as5Cff0u4U3RewE0/4WEu8D28IUTpUTm5z5uBMBqiXxD
	qZiXTkGkfChIMSttDSzEYzwFhincdz1h/Qf7Bu+f05xQDi8rPWjRF6ZTQ9cNmo6SsdRFyS6+iS7
	APLcJFZo4r9bFLCfATO+wAYJ/7s5S4bFi0sX3qIMsV+o5uAggH7Xi8cG55tONELpgY7nlO+/1wl
	WIQOrwicI4MwvBCNJ6MC8plwUYEMCn3vMyXzKFP4IKjRR+UgbErpDKPtGgZBo3mQo+aRFBQ54EH
	gkYlLX0Ycb/rwydVZyPN2BHVEIIJu3N0aq94haQrDpqrjeaX6+d8IbFjZ6eDTacDs1PSanIpcmu
	oclyGwBmTMkp034rX641kIWobifAkhIzU6T9McHVlusr9u/E+OZTGnY8wa8iTV8HRObQ1vmz2f7
	Frj4rmVNzjy02bDNxfNhNzvCGk3iLXDaRUrA==
X-Google-Smtp-Source: AGHT+IFLKs6Z9Get2FJtBN4ng6d/qG2NCMDW+y5NcESyPYI9AIJUrHThVuklIbRDXM58AvJuPVzh/A==
X-Received: by 2002:a05:620a:1aa0:b0:81f:65ec:81c4 with SMTP id af79cd13be357-81f65ec834cmr243699785a.30.1757531840153;
        Wed, 10 Sep 2025 12:17:20 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm339500585a.61.2025.09.10.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:17:19 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0ABE3F40068;
	Wed, 10 Sep 2025 15:17:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 15:17:19 -0400
X-ME-Sender: <xms:vs7BaMrfJnJJaKjAwwUZFjHkcowQFr90Uappl8VwGH64mC1icAr97A>
    <xme:vs7BaEEXxLMrRI7bjn4Vx5gMJ6SdBnKTuuPAoDkfBp8nePt7ar2Z2zzsOA8tyLloq
    elTF9DA04Tjxz5OPQ>
X-ME-Received: <xmr:vs7BaMmEBKriaFO-_h-Vq16kCQl0nuR_1_HSE710wuBgF44U_F2gE-nrTArSgEqObqyZFWWOL5JvsYa_dXXI4VfziYP1bWow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddunecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieffjeehjeeludekfeeikefgteevjeeitdevkefghfetkedvieejfeegtdffvefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrrghlmhgvih
    gurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvges
    sggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vs7BaA8U5EQtHz1zKERGJb3k6OGLdrfsoPQffVVwmIp89t-BgJD88A>
    <xmx:vs7BaNnbxzvsQ2CljPyMOb-M9oOnOvxNIDjN_TL6X8Q8UZeMm9g5zQ>
    <xmx:vs7BaOnZ9RBsFZtQviMk7wSNXq29pqqscy0DO2Xp4m8Vs94YcOpgNA>
    <xmx:vs7BaBttROfvd0vxfGSIjSVq41YX6UMukAVvWxkvR6V4zeZfFxoCTg>
    <xmx:v87BaIKdIPqWmathmBQEKcgLgWc0tBCAB1qBhIe0axQDGa39kPZhkm0H>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 15:17:18 -0400 (EDT)
Date: Wed, 10 Sep 2025 12:17:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
Message-ID: <aMHOvYI6VKAnh6WE@tardis-2.local>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>
 <aMG6JVMcMxVuX7De@tardis-2.local>
 <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>

On Wed, Sep 10, 2025 at 03:47:30PM -0300, Daniel Almeida wrote:
> Hi Boqun,
> 
> > On 10 Sep 2025, at 14:49, Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
> >> From: Alice Ryhl <aliceryhl@google.com>
> >> 
> >> These traits are required for drivers to embed the Clk type in their own
> >> data structures because driver data structures are usually required to
> >> be Send. See e.g. [1] for the kind of workaround that drivers currently
> >> need due to lacking this annotation.
> >> 
> >> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@collabora.com/ [1]
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > 
> > This tag list looks a bit weird to me. Why is there a SoB from you
> > before Alice's SoB? At least for the usage I'm familiar with, outside
> > the case of Co-developed-bys, multiple SoBs is used for recording how
> > the patches are routed. For example, if I have a patch that has my SoB
> > and I send it to you, you queue in your tree and then send out to other
> > maintainers for merging, in general you would put your SoB after mine in
> > that case. But I don't think that's case here? Alice's patch has only
> > her SoB:
> > 
> > https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48d023320eb8@google.com/
> > 
> > What's the intention of the SoB tag here?
> > 
> > Otherwise the patch looks good to me. If we get the tag list resolved,
> > feel free to add:
> > 
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> > Regards,
> > Boqun
> > 
> 
> You have to include your SOB when submitting patches from others.
> 
> This is something I tend to forget often, so I made sure it was there. The
> order may be indeed off though.
> 

I mean you can just use `b4 shazam -s` to apply the patch and add your
SoB at the end ;-)

Regards,
Boqun

> - Daniel
> 

