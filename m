Return-Path: <linux-pm+bounces-40615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A8D0F929
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C1C3017356
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3234FF57;
	Sun, 11 Jan 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfOPh2Fl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01A34FF6F
	for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156279; cv=none; b=p43LfCYWe8okXgDTFNF54+RK2fgzAjETWnGMCs5rUReUQsw5ChZ6L0ch92N6WdrIZK4fOE8eJHTuXYchNr5C2noX5zlWNQF1ukJFxT674tK0XTBIz86hCVF4OkLidL0hHWAv/sUyW+DddweEBpIBsv6Y8BPTVWU1HqZY/XzG4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156279; c=relaxed/simple;
	bh=26XSF8abaacHWOSeK0Gpp40CHuhyJtv5EuYNp6TvHIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIfXRGJJ2YIJSMJxpPF6pQVaVmDCsCYb484Xy1IdIgatyKqExb199cUe925oTwpycbLoCJZLiJ+CgkQI1G4ac4zzmDHoZXe73BAG1/ZbYqjOeRfUXknAHMsmmQ3hhl9E1wQgqFYTVKH5ChUWu+LqDNkTXgMSP8+XKh3yUv6i7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfOPh2Fl; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b25ed53fcbso18087185a.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768156273; x=1768761073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxHKoSi46iPA5F9rX5ZhPp9IruXA7MeRTiDagdmtDXE=;
        b=RfOPh2FlvMoAf9SYILdrhI8HVRowzFDtoQpzaXHmlIWZroaU+GatjpvQ1DRSBroCo3
         9MUXAq9N3qcsh+j7Q2p1goYSOq0yJxrxJvWaic1BTOolszs/ZfPuukAs/hvdN/h6/f6A
         thzW3zlrMdkTfRk9rbpRz24it+aVNzsoUhlYXPCeX67zMgStum4g/igCGUNzS6xPGSvu
         gX77ruUk2Q0SbkaBQdm1XKrV/MwsgcdBaSoANLaqEFHiGRgeqAox2oFqNxYhwZmj7etN
         6NzG3vLpuWvg9FFLaDQsAx0ZGuy43UVzuHLgs4vBLgBN6aDdkVOp7Ybf19ynkLdaRNGh
         gTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768156273; x=1768761073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxHKoSi46iPA5F9rX5ZhPp9IruXA7MeRTiDagdmtDXE=;
        b=APnerzuXe3bO6rm+823nRk6LF07NNkNCQyxBENFevphehXYA2CJPEvLUTW8F+bAMw3
         PWSNKS5M9oJqayZjZ+caoLpY7NXjcvq5AlQN5qklAm/baaQPvivNQeUMPD3hjh4tiS0s
         jtJdSadrXGLp9sovkaDMIcGnlyo6wYmgFOxUaIqWvMrogExuc6C23VrWq/gz422SKmGc
         qrB14wHT50ujBbV9cpDUZSuxwHJgP9pSYTthbv6yAFrrl7OfnnfeLefd1QkagWy8ipGC
         jUH2yc+CpcY8QBEcXW+x2ipZfQrteBQF6ZFI9N6INFnh81ShOqOab/avEuFufJGXolFY
         Hj1A==
X-Forwarded-Encrypted: i=1; AJvYcCWORdHVcTM3MqknvzN7QbBVmoaSdSG2JRnDsiNS0zzF0OP/BKZIXV85w64Aqz0KFpGI+mlMVoJjlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEbnAxWZ1Z6VdamxQt8tvDFqTqA0AsBFelOXoXXkVC4eyMdAV
	0nD1my4Nw+Xt8YferM4bNgO94HkfEfCq0UDsN7TN4hkRucFH6kHuSvhPpnfDkA==
X-Gm-Gg: AY/fxX69yzuqgC1aMYHMs4Pr/J18CAvcxyZNCQqSTs1Jo9ohVvpSH7k8s/d5NUn+sXE
	bUPjr+52tZpmmt81nM2w8xfel5x9cOTdZVOueUGqDHCWunuTZalgRqkoUvB9nsuSZhU5z860Nl3
	tgADh/jwbpqiR/upXIZ1E7zWOu2htDEiyoKRWRa0rIFOus+adI8jRM0PM4tdHTGR05Op/pDLu3T
	3Zf/zkQSaNHCi6zrPI5v0+06avE5aC3W1im5kusjOgtow6LdgxNDjh3mKSUhJwIOqMWBeBZRsNh
	KJ3q1W9Uv+588Ozc5zhT5y4mA2Btw0s6p9z4xM8p5ygnDfTTqN4118zCusi+XFsFE4MgR2oMX3S
	7twQtxSxwIq74LHjgxur357JMgpTZl0hPMIfTJNOy147RVapNhnIZ1FnAEFKpVg7Bl9VVIjb8va
	RXYwiMmK95b0vFWW1LYh1iwG7Z3PjHMbMRi1NIslO793bBLyP6RiKCV4eP+g==
X-Google-Smtp-Source: AGHT+IFr0AfQqdzuLfF2we3Zx/EJP2hZFx2oG+SaK1KaO8OqQ9sYp0F8cg/P9dtkorxfQtRFUlfUMw==
X-Received: by 2002:a17:90b:28cc:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-34f68d3b273mr14688746a91.35.1768150214300;
        Sun, 11 Jan 2026 08:50:14 -0800 (PST)
Received: from google.com (61-230-24-179.dynamic-ip.hinet.net. [61.230.24.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b19ebsm15175971a91.3.2026.01.11.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:50:13 -0800 (PST)
Date: Mon, 12 Jan 2026 00:50:08 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com,
	sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <aWPUwCbFoIItG7n3@google.com>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
 <20260108080836.3777829-4-visitorckw@gmail.com>
 <20260109-remarkable-crane-of-exercise-6bc17f@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-remarkable-crane-of-exercise-6bc17f@quoll>

Hi Krzysztof,

On Fri, Jan 09, 2026 at 09:23:33AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 08:08:33AM +0000, Kuan-Wei Chiu wrote:
> > +
> > +examples:
> > +  - |
> > +    keypad@9040000 {
> > +        compatible = "google,goldfish-events-keypad";
> > +        reg = <0x9040000 0x1000>;
> > +        interrupts = <0x5>;
> 
> Same comment as before. It applies everywhere, btw.

Oops, I actually had a local fixup for this but forgot to apply it
before sending. Sorry about that.

On a side note, none of your replies regarding v2 appeared in my inbox
or spam folder. I had to retrieve this message content from the lore
web interface to reply. However, your replies to v1 arrived without any
issues.

The only difference I noticed is the sender address:
v1 came from <krzk@kernel.org>,
while v2 came from <krzysztof.kozlowski@oss.qualcomm.com>.
I suspect gmail might be silently dropping the latter due to some check?

I'm not familiar with the email protocols, but perhaps it really is time
for me to start looking for a gmail alternative... even though I see many
entries in MAINTAINERS still using gmail.com addresses.

Regards,
Kuan-Wei

