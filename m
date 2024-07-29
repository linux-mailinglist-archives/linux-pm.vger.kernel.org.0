Return-Path: <linux-pm+bounces-11539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A824B93F68C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0631F22000
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA58148FEC;
	Mon, 29 Jul 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpTmCQTH"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDE1474A9
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259251; cv=none; b=YOPCxHwU4NwORSPkSHzEkKo3M66041rhv7H06Hel71BtdhfFfBm6CgQoZtoaaBJ0vZKpzWz+Ozhb0OlodYlgDYZrSZv54OV4yp/6Cq7eZo1Vi2qgrF3JTtpTEkUJCzm2mS1Akg9u6JQ74bvFMGAuPVkpSnY40/lW+9qhdCyMyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259251; c=relaxed/simple;
	bh=8rb1hikXPiW6MAOHtbRU55mbhiA52HsrwlinY9QcZCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AboiTzKMYFnlxYM0R/t4soEYkPPon5A1L/KSKsSSXHRHQVQd7yOoW5F9CzkeV1htfVZQfIgoOkGdKV8G1kekLcH426VdbMCQhg3Fg8OsjpWiBrPrF4nqSX8ypET/MX7XSfkmEZ5WOrInWy6ocbBrb5QHd8rPtb1feXtYMp2yF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpTmCQTH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722259248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGHqvqp2b7N1mb9JLu1vjjXTY3vN6uA44omJS2BabFk=;
	b=fpTmCQTHv5TJCfISQYbCJIS92fg1ygSx62YLpmOO5hFoM7de4GWv4SLoyQ/X3WGKrd+fj4
	0ZaZkRXDSjsSpHEko5OaLUMeMz5FS+MzYBpioYNa7N5DOgpI4bm+kzkfocKCwPCbMwkCBb
	wJgT9dt4PCDwC+gW9vXD1twlFT82ICw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-SmXBmjq6O9KYfXnzpFGCPQ-1; Mon, 29 Jul 2024 09:20:46 -0400
X-MC-Unique: SmXBmjq6O9KYfXnzpFGCPQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7a4ba59bdso49151316d6.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 06:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259246; x=1722864046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGHqvqp2b7N1mb9JLu1vjjXTY3vN6uA44omJS2BabFk=;
        b=TuLlkA0yKP3i2ZhnE7xM7mQ2238VM+GSGA8Y81l9GRqpeINoGjc74z2BwDi8cEx3LH
         2vsg37RSxNiBmIaIRs85vCWbaUwhu/vKiBlzyA7bF/wejnM60axR/BDOVsI5JkH3cp2s
         osiRGfdLFPAOT4sEp7fWRBQNPUWgm7+mRZ1mdAHM5EH1KRKMkiqWp/3lMHz3IwXwC6oG
         Z2d3Gc0wsWugrc97/xZnVKdN+n//gbHRtYYYaLw/cztkuDwa385HzOcXCW2eRhoUt0DH
         GJUjMb01x7FlbKU+nB8VrD0QHBzyH8Ofo2dhL3qGM/lPB+DsSHmvdp0o+yYAgsYJaEU7
         t3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWAVyIyP7FmoEemJWuaBptz4qTK7hiauYbqk+/JvHXWSnI8EkmNXWvovpUcOMqvaDFDjr2X/QL/mpfks9CU3TB1hxBc/z+ZcHI=
X-Gm-Message-State: AOJu0YwViocjsyv41T9i1HfbaFf89HNW5cyIwRGIY4yep6oFIz3wZP3y
	ZMvDHr6ObcoX7qjgIQR4qwjCSv9KBOPscXBkwegq5lSeWvIfL0QqRDSKf5JYDDmAW8IH07TvLCG
	Hg+fdQ4isg+mdQn+MeibUCHr5W9vg9Nn4yitu72nZ7FUT8kcP7XxRYgEm
X-Received: by 2002:a05:6214:ac4:b0:6b5:4338:e029 with SMTP id 6a1803df08f44-6bb55a17e8dmr121436606d6.28.1722259246301;
        Mon, 29 Jul 2024 06:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIagqEI8ZwjW73vt5z+orzpnYd0SPiKxoIzZhWtBnW4nvuyx6llnUZpaBZpAmhOo2HZ1kI9g==
X-Received: by 2002:a05:6214:ac4:b0:6b5:4338:e029 with SMTP id 6a1803df08f44-6bb55a17e8dmr121436316d6.28.1722259245956;
        Mon, 29 Jul 2024 06:20:45 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f943352sm51735096d6.73.2024.07.29.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:20:45 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:20:42 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pwrseq-qcom-wcn: Depend on WCN36XX
Message-ID: <bgev74hvkl7q5cbxuako6ljlesf256kz7kmolornhrczkwgsjv@tkfclj66d5rm>
References: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
 <CAMRc=Mcop3+00G3kZo+dazpemuj0PjXNc_3+EiyFukLevBGd_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcop3+00G3kZo+dazpemuj0PjXNc_3+EiyFukLevBGd_A@mail.gmail.com>

On Mon, Jul 29, 2024 at 10:12:27AM GMT, Bartosz Golaszewski wrote:
> On Thu, Jul 25, 2024 at 6:28 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > This driver does sequencing for the hardware driven by WCN36XX, let's
> > make it depend on that. Without WCN36XX, we're sequencing power for
> > nothing.
> >
> > Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > I *think* this makes sense, but if you disagree please let me know. I
> > was sorting out configs in fedora and noticed this was being asked for
> > builds that didn't have WCN36XX enabled, which seems odd to me at least.
> > ---
> >  drivers/power/sequencing/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> > index c9f1cdb665248..a4765cb33a80e 100644
> > --- a/drivers/power/sequencing/Kconfig
> > +++ b/drivers/power/sequencing/Kconfig
> > @@ -16,6 +16,7 @@ if POWER_SEQUENCING
> >  config POWER_SEQUENCING_QCOM_WCN
> >         tristate "Qualcomm WCN family PMU driver"
> >         default m if ARCH_QCOM
> > +       depends on WCN36XX
> >         help
> >           Say Y here to enable the power sequencing driver for Qualcomm
> >           WCN Bluetooth/WLAN chipsets.
> >
> > ---
> > base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
> > change-id: 20240725-pwrseq-wcn-config-0b6668b5c620
> >
> > Best regards,
> > --
> > Andrew Halaney <ahalaney@redhat.com>
> >
> 
> What if we want to disable the WLAN driver but keep the Bluetooth
> driver enabled?
> 

Should we:

    depends on WCN36XX || UKNOWN_TO_ANDREW_BLUETOOTH_CONFIG

or, would you rather base it on something else, or nothing at all? I
don't have any hill to die on here, but I wasn't really sure what to
set this config option to for arches outside of aarch64 and was hoping
some Kconfig dependencies could make that more clear.

I'm a little unsure about what the WCN family of hardware is, so I don't
know if that's something we could gate behind a different config more
intelligently (say just ARCH_QCOM if it only makes sense as part of a
Qualcomm SoC itself... not sure how this hardware is sold).

Please let me know your thoughts!

Thanks,
Andrew


