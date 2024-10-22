Return-Path: <linux-pm+bounces-16251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A89AB3CA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3961284ADC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4831BB6B6;
	Tue, 22 Oct 2024 16:24:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5141A76D1
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614260; cv=none; b=o6r4v69Q6dQ0xSwWI7YEOGJ89KRChz0kUIE8LcMBd/P7T3/bIHk58l33V/+jQYWcOsJj4nLI+qesJb5mXkwzuyBvEeVrGa0VEmk1k8wXdNzkl/XhC/fekZtlTDVQWeSgN2E5w7rivlIaP56CwdCy/6zsMs7d3ndgxwL/PretOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614260; c=relaxed/simple;
	bh=TaaTMM3UxQWbFXrjZD8NbUwl2Jn1hwjRyh9yQQ+Ff4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LnHXm78R2FtJGyd/t7KmtQeU5MIp0pMJTEWrXoVyRKavHsFS0XFxVPhI5Yc2uWO+StAVz1j4ZxrcTErxAIwdK6Ir3ukvt1t/AGoVNoinKY6mPdYJadQslDszCCgC0nXyxAq3C533wVXq6LtB2ShJTBsuuRqSPliNwAaOxiZTXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c803787abso45603225ad.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 09:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614258; x=1730219058;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaaTMM3UxQWbFXrjZD8NbUwl2Jn1hwjRyh9yQQ+Ff4A=;
        b=ETzqa2CO0TQjTQPWkuWvSQAZ88aMbF1ZEN7rVkmunLFfhfuItjsh2SSHCSNcbz/yjB
         3ny3V8MFD66f9GaN+tINQeLPaSieTObpi1dUwkHBa8gRNSun5IvcQ/3d/svf0G+H+RWb
         O/fdevSd2Qtf+x5LOmqHhZ24E97jXv/+m6touTxANERRRrhldDsJGzRva7CEFPtLpTky
         TmH5hVKNmuBeLa/RQ07Qndoek5gxnwVmESHlAv+D6Qjjwg3x6Szi0px+CqI6gydGfQ/o
         HsylHAlYtbN6cNmLKJB1ug69+3DIJ/bL177mNUwEr5FpL37AM+zp/2WE4LoVSPEai2+X
         mrhA==
X-Forwarded-Encrypted: i=1; AJvYcCVkOkPKlbMPURZZBDV5ZQo6YBQxVmvZ+j/tywrlzETxaxF/NxPCz0cKq7Zos0sf2JtgUmIGM4HH4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwXSTNXjCTMakklo9hiaX3SRd4JrDFMJJUpdgqvEyII7d2IUK
	oRojmZSb+7DxZd2cGZf8MGCqLDi5SH+A+rgZV2XIRUQiF8JxT1K41dF05LXLTyU=
X-Google-Smtp-Source: AGHT+IFaD/j1Rlq40Aw5sjAcS1z8YIlzMkor00MFlOjtln9GzriHDQFJiXnHbn4jt+cYqpNSUiqZDQ==
X-Received: by 2002:a17:902:dacb:b0:20c:7196:a1e9 with SMTP id d9443c01a7336-20e96feb050mr65803955ad.13.1729614257846;
        Tue, 22 Oct 2024 09:24:17 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm44498595ad.186.2024.10.22.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:17 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: tony@atomide.com, u-kumar1@ti.com, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com,
 richard.genoud@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Richard
 <thomas.richard@bootlin.com>
Subject: Re: [PATCH v2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
In-Reply-To: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
References: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
Date: Tue, 22 Oct 2024 09:24:16 -0700
Message-ID: <7hbjzct8b3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Richard <thomas.richard@bootlin.com> writes:

> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.
>
> This commit fixes the no_console_suspend support for some TI platforms
> (tested on J7200). In case of no_console_suspend the serial core marks the
> device on the wakeup path, but without this patch the power domain is
> powered off anyway.
>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

