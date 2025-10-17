Return-Path: <linux-pm+bounces-36373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52078BEBB93
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 22:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 413B84E1DEE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91426261B9F;
	Fri, 17 Oct 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnIFHLZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA0248896
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734117; cv=none; b=YM+9zqRdQxQt8I43RxUiLTsTBoJOw9d0IB05ltjC3SB+rdSgFkqj3zjWdj8rpwEcxDKbzII2WzN676uUpt2NBH0mEN0rjvs/DPjXEy2vxT1KLT7u997C8cFLznvTMzzMnRsZP5sCd75GmEoRzW0g4gqtFTNGSzIIIMLgtwEbP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734117; c=relaxed/simple;
	bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEv++JUYPS7pnAdpcby6pWdgmTQ1z2W/OZNPK1zyq9liVbFexGUk55PuN0ja/u0nVskUIxaYWZrO6kgbipvJMOeL08xzxtLf2eEk7530vDk8+2LMPbUz11KVcunHxryMxkngxidVBnRGZMpa1iA7owJ4Po9zw7QB8J7vBLELBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnIFHLZZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1648811f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760734114; x=1761338914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
        b=SnIFHLZZs7YhF2m0vcAe6oe2xSQE7X5HerxWIZHUhyYeXUfr/vpSeIuV2rCIv4Ej1Y
         ZvCk1M9UfrxvmkrBhjvhTfzrpcEjQ5i31aiY1TEDK9+gw7ES+bcHEB9K4Qv2ZL8lFwau
         w2onrMDpEfDdqPAmxo0vDNbqdxfCYANz0jtb22JO+be/pGGXtDJbiEhV/qr66XMN/Xi3
         qaVkTy6tgfAXQs1ioibH64ugtYfJtBOZPzPUTpkcUIpSrZjsL7yvUQDdeHjCTLlv+kp1
         0TghXFfBor0vE/LkNvPq1EqIl92DvkMBSS8QuROhu/tsu/pJEJFPAn4nSNSLPd9Ffx5z
         06og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734114; x=1761338914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ/gGtYvav+gWWdoIlX8Zb6LNC9cOW2UkrE8R2Ydnos=;
        b=eyBUWsNZgQFMSdPPepZGDVxn1EPNbycSVgYeVZUXd039X6feGcxsl9aEPHJVnTU3r2
         EAxn1Q4VJc8R+/3nsR9BWkFI3mgZ3HdqGJBXLizG5SJRvC0r1/rzu84mmHIN3XyZJRis
         SKctEptuxl/U1kjfnpJ4+4yPnKwz7WJEqlW14rtcYU5IoZQZQFGNwqJJ93FzNIEUgDj8
         BMCH010kmE8kv9EYP9vnY2S3AcWpdBPlaUskqCyRNFVCcE6gFcmmyLs47GOwuOOOMB4i
         KTpXG/Qnw+zZDif5nzCdlewruUMou+sZuyUgP2myBMaaG+wkxK24J37GZ7JMKww5u/9j
         k7cw==
X-Forwarded-Encrypted: i=1; AJvYcCX8HQzxscfqtfRzT7xGd3keSUpRYgmt0Em7A0z3BKOxOia6igIynO7pYQP6qo0D4PO7NISfmjFKUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhe6enRVabal3c2iZYEe/5mYDIq7ZZAjiM7MzU+4YFMHZBLmXM
	A4Vr/qroGzc+ZP7u+rzAh5i5BLr+3txtO5TqearLCw7LMolFeYzx0fi+VR/Ib2SyAQQjYL7m0So
	QJt/rMv+jy0jd9AGghq2Z4q5zlhrJi4rZ9lBFaoiz
X-Gm-Gg: ASbGnctJtEWeLhjz5YHaYJbf+JMMzeP1bzPfKAe6SHpC42NKmU/dp1w7rj1MSow+4bK
	5rfL6ITzgRFANTInjwuTwb7RwLIm9qEJJmlEHQSYcNAdjfiDtntzCFeJKVRcaTFOf9BP6svYhBo
	lhQE3idzXJrIF8WsXyGxWwK9Mrqil2AfWqc6Kmm+X08S0USyjABOoqlqMCS1YG6GLzGppqzAVda
	MH7iI9iyAs1YgPhLITXObN7SK5ZIaLpFo0iKmnzrJD73/+WcO+kZ3S7o/DkrKm1P7+uaGp0T6mm
	qICJtwHE6MMKgrD3Oa8dhP4=
X-Google-Smtp-Source: AGHT+IHAavia4dajmjd1wu0ozenk/EgHnS13fnhiNCGOo15GBQoO3qzrk0f46KUvjIzbKPhJBuIwwZghoR1ZvbV+ZV8=
X-Received: by 2002:a05:600c:681b:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-4711792a6bemr42023365e9.37.1760734113965; Fri, 17 Oct 2025
 13:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017000051.2094101-1-jthies@google.com> <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
In-Reply-To: <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
From: Jameson Thies <jthies@google.com>
Date: Fri, 17 Oct 2025 13:48:21 -0700
X-Gm-Features: AS18NWBOVLDYxDh3NOr1aYj7ImsXftnVZMr0nHmHk5U7INnmD_I0toUf4vs0lBc
Message-ID: <CAMFSARdUMJ3WX1L8U-2k1w7kmH8Z4y7=MKKEBjCmyY-94wiBig@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
To: Kenneth Crudup <kenny@panix.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
> Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com

My mistake, I'll send up a v2 adding the appropriate CCs.

> I wonder if this is the reason my (Kubuntu 25.04, FWIW) system will
> sometimes show the battery icon as "Charging" even when it's discharging
> (or nothing is plugged into either USB-C port)?

The update to set max current to 0.1A for BC and default USB operation
landed only a couple months ago. If the battery icon issue is a recent
regression, it's definitely possible.

