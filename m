Return-Path: <linux-pm+bounces-19334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CF9F38AF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A21918807D6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C79206F2A;
	Mon, 16 Dec 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+ADwBcm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155D206F0F;
	Mon, 16 Dec 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372768; cv=none; b=CVEG105K9c2SJSksnZwjh6wZyIJaWt/OWbqQlyxpuQ2CkMtR+C3RyaT+M/NE3N2CdZgiLYXL58CLz3v2new42TnfM+osWhPgDqHLs2T6Mpn3XZHEef3BogvsmHlewvW4zMRGwoLqMOkJZvs2zA0i11wsiONf792oJcA8/WhFCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372768; c=relaxed/simple;
	bh=DUkVfiQpE2JGlPYJlGIK1NVTtF631+822lb2UxWnrxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtcNSOGXgpiczZqHolWpRVgMzf8k+XVDHmM6EKgiVA6FanE+4J54DrPvEx2V6DmXaY0Zz0R9SSNG0M4DL1wnAxOLtW1dSkk1rPcspHmZZrsyKhTTSKs2+5pPDNBNDuPP632uOXzmzdAIwmzhDaPHkA526dTTfiBVXBHpilY44UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+ADwBcm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso47083125e9.2;
        Mon, 16 Dec 2024 10:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372763; x=1734977563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8+tf3TDOawM/lv4clujwPsMyNwbXD2M0VgnWH5gLGk=;
        b=M+ADwBcmG3j2skdAKbFLzm38dbV6PciGEsxUZez7wS/x3gVv4oazkz3w0n73W591Kj
         11V9Quregj3qqMAfSS+i5dIW2x8c3a71wAXxQMOqwFaVoPc8XmZW5Gw4i9oMqJLJUDZw
         DDPErqn1TrPkz80T/kKULoFlhXgfOffwbAwBkWa6uMuD4aPcO2UWZTy7MUbeA00Was1V
         4kBTgStN0lWyOu6pOCvjHRQAjBptGPt3g5YbS4Cn7tnF6e9p1uPMUd53gO7iIVPN3Rr5
         Z+1mt4s+Y12LV7BKxUg24pCOheo2j2+y7LXxYj8vQXem6za3ki/0wtgFo4NLWE6j7k+5
         lAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372763; x=1734977563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8+tf3TDOawM/lv4clujwPsMyNwbXD2M0VgnWH5gLGk=;
        b=KaPojWt0NSLOypHGe6xjjLg7I70GTenJJJjxj31C8L67FkYIygOJb4Mbri8mtqPbKB
         hRa5h22pfvTYHOTt/VXR0ZikuxFItAPeVZobu6Gv+zkrho8b7dc/SPvwFucdK0QGIWAD
         uCYVGZmsgjtuXt3rtVCKI0VaGorq5v7Ge2FhAahXc7bJ3tAuLVXmsk5boxPAc+mFK9wc
         4ctI9YuvtsMs1iuxlQGglsMfiBnuxZGMdzJIGe2hI+CRECMhhsCZMjhc8RFL7Bgvr41n
         CPtxA+T7sArJY4ndIrB+4rTjb/xgiTX3Mmcpr9HGaQl4m8XodiNoPHxgT2lB9zbz4SaJ
         o2rw==
X-Forwarded-Encrypted: i=1; AJvYcCVHpkiWjLBBgiKCyMz3z6faDgZ8Tu7oR/yr39gpgxhgoKXx6QYajHO9s0SNTfkM+H6z62ZVEskorO6V@vger.kernel.org, AJvYcCWRYIcmJO8w3sYS0GAk24esobVuxbMZ80aCiQ0xdbX/2OE13ATevicCNZiIs22VIRHvC2MaSn8/SxuKe/GI@vger.kernel.org, AJvYcCWRwakCW2GgJHAsh9f7FU/9IR61n51ax3RLoitVG5mYMWdGzs8ColzXl2Ho8eboCRTYGBweN4weQRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iXRT6MzDKXRkzYq/Wbhm7YXsROKFJyQ2y/KM+2nmgTvmHvg7
	pD8AeQNUqKjJQ+4PB9iyPtPd/p4mt+bQkRTu1aq3Yx5BXBTFT/7d
X-Gm-Gg: ASbGncvWMbj7w3QZEK0ij04vsknh0uCtZVEk2V1UA1hz3A7gwlu38/cQBf5TtpbWczb
	Qvaiwha1gdNw8jaNtv5YSOMnqnYznfkhvszCXg0npsv7jFn4xvqALqyDFnDRw3u8+n97u43BIu9
	7XIGJUgmcueoNWqSQCUqMT2lk0WeJxABOnnmBg/5m0L/+XDoAnKrL0mOfMCxmHuZ+937tPoS5WP
	/7xemwrslIwuXNQWVlkudOM/qgfli6toqZRoAV/dBvH72ZaduqJ
X-Google-Smtp-Source: AGHT+IGakOLIjQok9FG9G0GUi4nA62ROZgNnyuZVlEdLBvYp5q0BiDcIZFq8DQ/9RI9j1Fr0ChLXHw==
X-Received: by 2002:a05:600c:3ba1:b0:434:a160:3647 with SMTP id 5b1f17b1804b1-4362aa2eaebmr115716315e9.12.1734372762507;
        Mon, 16 Dec 2024 10:12:42 -0800 (PST)
Received: from debian ([2a00:79c0:65c:6800:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80608e3sm8691419f8f.103.2024.12.16.10.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:12:41 -0800 (PST)
Date: Mon, 16 Dec 2024 19:12:39 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: add
 support for default charge current limit
Message-ID: <20241216181239.GA462174@debian>
References: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
 <20241213-default-charge-current-limit-v2-1-45886fce905c@liebherr.com>
 <2tk4mnzzhr3se3sts7gyt27izhlsmzajvdgfszubgy74wggeom@kggdt4go667b>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2tk4mnzzhr3se3sts7gyt27izhlsmzajvdgfszubgy74wggeom@kggdt4go667b>

Am Mon, Dec 16, 2024 at 11:04:40AM +0100 schrieb Krzysztof Kozlowski:
> On Fri, Dec 13, 2024 at 08:32:33PM +0100, Dimitri Fedrau wrote:
> > With DT properties charge-current-limit-gpios and
> > charge-current-limit-mapping one can define charge current limits in uA
> > using up to 32 GPIOs. Add property charge-current-limit-default-microamp
> > which selects a default charge current limit that must be listed in
> > charge-current-limit-mapping.
> 
> Last time you wrote the point of it is to avoid defaulting to 0 A for
> charging, because existing implementation uses smallest possible value.
> This is supposed to be here in commit msg.
>
Will add it. Thanks for reviewing.

Best regards,
Dimitri

