Return-Path: <linux-pm+bounces-19307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF89F31BA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E2166B9B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209552054F3;
	Mon, 16 Dec 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHtDWwpv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753753FD4
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356413; cv=none; b=Oz0TtZK0A9ojO9EdfmGda/qHzMBhtZOO5C8HdHDOIKhEHGdkitP1thqTTIaJaaIiEOAfyrPCwNfvcHK7Y+RdyGcJPRukVWYOLbBZxeRwIKr4WKhq5jzHJM+QoQ+4TnGSFOd9p4+/bGdVOpZYhxPiR1jM4M2T7P/USMn6oqV+Res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356413; c=relaxed/simple;
	bh=D/uvSqLEeDS9Op44MoBmxMHKOE6+s52+bTzYPdHFTlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgoHJ+2hiP47d5MM95srWA82ZFS2hh9xVrvGB5uUjKNp+aN0mdPfpODXHn6NkmYcO2uGzGKdXOTWCPwXXfQlqPxxVwi4YC/OYPTCuRycT4ibXs56wwH8F8uvwkX3qB/JaHYWSfSgcl1F0vGYfZZqj5LemGwEF+BHHHexS6yzUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHtDWwpv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72909c459c4so2496063b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734356411; x=1734961211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xNbqTCrGZMZzefPzauDW5eoAcfNyutFYXR4KBYQHxXo=;
        b=QHtDWwpvWRYi7UsQTxJ9wWVh8jmYiPYmApjjSle8xDQ9k9UmUXXoVGG3BNVoNuLUHM
         YFDMvQUUK6fdM2KXwf7JXEMU96idjsQqH6fqxTp5iGhAMzfYsgaml2pqfPwJDc+4246z
         6TuMUUUVlsW8d3tQYZvD3pVIKcmYQaVZf914XoIiDLruDdw+dYy4BTAecNm2Akkmuo5s
         enP2Dz/hyGnMsANFZpOSWVw20G9psO1snQr5ZqsnaBzYuxp2Uw0iYPNTt8DhhNnM5L+i
         FSj6B1/BSyKUpiYcsYdQ6RFZVLn1ILxCItKTsRIEbumUQvPkpcr3BaVAKawNcsl4jfva
         Ulww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734356411; x=1734961211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNbqTCrGZMZzefPzauDW5eoAcfNyutFYXR4KBYQHxXo=;
        b=eHHVfYb3hGObFh//YIbpeQBiMXMj+aghLpzKvxaANAz2xKv+p624GTSb3aSyR+rz/1
         Roo5mpke1114B9gIncktYk9tkn8/7akT/Wy1qmQrFl0VJxat48vQwletv86SJ0oxj5st
         r+jM3qhSkHOZIH9mG6ZatAmcY5W8U91SQ6v8uNaexnEKmKwKl0g//hyLg4Cq5pupv95Z
         XPh30LG/dvkzDjzCZHr9KSJ5sqWM1jH5I0WZlQH89qBayp0qGmQsc75UuR/jQKc/8LEo
         X+H4HUdLi0rwN89vpMDWYbxCLzTZX9tBlg7mN1GINepQSVDmARWVUijhDTqzZ1+90usg
         VHZA==
X-Forwarded-Encrypted: i=1; AJvYcCX/OzzT9S4SiksZSqrfnzsqxuO11i6yDnAIb3H1bH55n7mu6rxLWoJodzOzkr1ZPAifZYY+7gSuaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTcZ9yzS1kumvXDkLsNJ+8GyPiMcl0c7Z/N8og7kh4zHW6hbu
	txnifJb8mOkvegMqg1gpVdu1VYR8nvd6ZFJCs5FkxWmrBDZ2aUGuyFQ/2EBRHA==
X-Gm-Gg: ASbGncv4WtrQrNk/jwBuk57sZMrCxXYowpYVZTclpTXFFGa6MvH4F0NZl4DwhvwpHdu
	sec6sj8LmT9I7KTwbCUzUDiZZwYAMbBXY1nl4gS+sTQ440p4irw9PVuQxFtdQCZTYblp9MmQI5U
	PBoy0lr0i2T4EFp/09YUXiAYcQ9cBdcNBikit5yerMZsyOCQFN1Pnb2NI5aeynMSGdg44wdoC9W
	eQe1dJMXQC6VdJ8pYXB6x3b7tOTm0TlULA8gGG+8+330VDo8nYurynHoEv51yN/K1cZ
X-Google-Smtp-Source: AGHT+IHtU3bNVTDqxmrxLIdO6qRoEtt3sZYQHonGIC2rgqRgj+BLKFKHXozqcq+GoPpoJAqJTibUNA==
X-Received: by 2002:a05:6a00:330a:b0:729:597:4f97 with SMTP id d2e1a72fcca58-7290c243231mr19778124b3a.20.1734356410414;
        Mon, 16 Dec 2024 05:40:10 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac7789sm4725660b3a.12.2024.12.16.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:40:09 -0800 (PST)
Date: Mon, 16 Dec 2024 19:10:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <20241216134005.bjmw5vo4hn6fzp34@thinkpad>
References: <20241203141251.11735-1-brgl@bgdev.pl>
 <Z1x6ti2KaMdKS1Hn@linaro.org>
 <20241216070554.ym54ozdw45zhveo7@thinkpad>
 <Z2AF56PDj1m1BS1S@linaro.org>
 <20241216132445.vjkxxknvzaht2ltq@thinkpad>
 <CAMRc=McmTUPqhF9uTdxBttm9RUxLgd68uanbxAVt-jbHe27h2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McmTUPqhF9uTdxBttm9RUxLgd68uanbxAVt-jbHe27h2A@mail.gmail.com>

On Mon, Dec 16, 2024 at 02:36:24PM +0100, Bartosz Golaszewski wrote:

[...]

> > Your hack is making sure that the default state of the GPIO is not changed at
> > all after initializing the controller. So even if the pwrctrl driver probes
> > later, it will try to enable the module by doing,
> > 'gpiod_set_value_cansleep(ctx->wlan_gpio, 1)', which would do nothing to the
> > device state.
> >
> > So the issue is not with the pwrctrl driver but with the controller
> > implementation. Ideally, once the device is removed, the PCIe link should move
> > to Detect state and then to Polling state once the receiver is detected on the
> > lanes. But the DWC and Qcom glue has other logics that prevents the controller
> > from doing so.
> >
> > So until the link down handling is implemented in the controller driver, we need
> > to carry this hack that preserves the GPIO state.
> >
> 
> Thanks for the explanation Mani. Regarding this patch: I suggest we
> keep it for now but maybe I'll add a comment saying why it's still
> necessary?
> 

Yeah, that makes sense.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

