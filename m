Return-Path: <linux-pm+bounces-13801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F196F8F5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DF1B2309A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B61D1F7B;
	Fri,  6 Sep 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TO21w6Vn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF11D0481
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638490; cv=none; b=L+PHJ3DNslXQMxWGZVrB3m0y8vYazENlwYfGOKXfVcKj9i3Z5klse18cFYB4LRzmZnTAXa4iQVYwRaSDH+7RtHX+/OWDMu/sVKrpPCdOH4yOIYVWW5hCHYEt5v4E5AwncA1tXkLGv0+U32w4jx9VGJoHKCH1KH0hbALg3l7Pqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638490; c=relaxed/simple;
	bh=E5dl+ODA7ZwdKUFmEhO2rwmI//8AUu2GNeSdPWItsxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgYtANPpwCn0UdV8KIXNW/MsDTNYWtm3ydhhPZI/YgT1BTFC5NtGhj/ZIkkgXTJAFER294zSLqqJqp3vTbjDAhV+wM2FLYFYI0aoaWpmKXZGoM+GLTCk/6CWmMKAz0OB+YhfIyBKRAIMyYtDS0gR5Ev4qgw1Rq6yLavt4A3pz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TO21w6Vn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1620449a12.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725638488; x=1726243288; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dl+ODA7ZwdKUFmEhO2rwmI//8AUu2GNeSdPWItsxk=;
        b=TO21w6VnhjeQ2mxyl7nMCp8KRig0Bwwu/C8N61CN8whF8dKa0veH5uz8COBYfb0gOL
         Rf0F/VsNZg73cPuF1a+zhEfhKhwZiequNz9YLWh9zMWTu0OCVRj0RiPzG/DywRloglY6
         MkaqQ7AFVpSarS//qNtF8sCNqUJxlNge7Pb1Z955DjnYs9M3FGwGdPItonz6HgTfbUD0
         jmNN1Qz+1TwXh0a4lNso/XYIBNFte0BA78uP+DZQu9CcnOS3fFsDxGY9RMjbZfJo57Hk
         qrbzIqUf8xiJztq5/7HrUZrM5VK/uh3Ngj4ZhAtl6X1lKAtEv/nI1Gzq/Kwes1gL98yO
         cksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638488; x=1726243288;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dl+ODA7ZwdKUFmEhO2rwmI//8AUu2GNeSdPWItsxk=;
        b=mJIFFFMCp0Yh9dFK44PObpvK768dFY3YeJoavksohNPjHvcWK/pDTicznIq85IWtgE
         m5P4tFwylegbBxNmfVBoyGDHnHimzzd5IL312m2pgeuf6YuySftdvKGVTZWim74aSXtF
         fzztiYWlYIUzcZU8IB4V6wPijeklzfdnNqIRq0M9U7dQ+C9eUU1d60CCxk5etCn9vyfx
         e9HXSRNPvzTo0VikFUkvM/dAXuUFySbBpsvRsomL4WKET3fMpw+ojRC2uCXAjSkVPJ+j
         f/hM+V5tzA75ugr+eHAdRXuPHEEH59UBl3jL/eib9NzvlX3VNEcMl7isxfbTO0rAEuLb
         I/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXvg7CK5ZvbC9VOruKa8wLg+UgdAU6w4O2gN7lKXCzU+CJRwYdxzUHahIfihZqhrrvxFnFB1VvKdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDOvuDwu0Y7Fh3zhclfZ0Y7WcsOIo+VcsDYxRu8TtVqnsQ3UL
	Jj8dLa5wdJ22/j6xeaClJ3XsduDyn5Ve1YQLErqoYYHJb58aEmw29mFNSX4RibQ=
X-Google-Smtp-Source: AGHT+IEVYSDo+Viz5H19s+SaMCawwx3yMXZY4ie5Hu87TIb+qJoh7/HUoevJqj/Y0xEHGnjVO/AdzA==
X-Received: by 2002:a17:902:e809:b0:206:ac11:f3fd with SMTP id d9443c01a7336-206f056f7e6mr36117715ad.30.1725638487275;
        Fri, 06 Sep 2024 09:01:27 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea65b54sm44784045ad.243.2024.09.06.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:01:26 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v12 0/5] firmware: ti_sci: Introduce system suspend support
In-Reply-To: <20240904194229.109886-1-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
Date: Fri, 06 Sep 2024 09:01:25 -0700
Message-ID: <7hbk10ai0a.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> Abstract
> ********
>
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].

Tested on k3-am62a7-sk along with my related pmdomains series[1]

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

[1] https://lore.kernel.org/linux-pm/20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com/

