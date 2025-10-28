Return-Path: <linux-pm+bounces-36963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBCDC14518
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 12:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428014251D1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975F3081BD;
	Tue, 28 Oct 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqmuLUON"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBA3074AB
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650269; cv=none; b=Qj4ymkZ+kTmeOH7c/KUj4J8O2kfqlchrttB3Uda28BfrLsveERB+bgKtjLBqWjLMwGUOPGA6OOC4tzQBe45aKW71HIaukGlS6LrH9F/UUIJxCneYqYpLofyewSWodShOZw3OOYq3R6mSDDFWIyJRd5aUUT0tO5QZYYDS/lvop70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650269; c=relaxed/simple;
	bh=+2aIo/f32hCQHq6Q5gQnnB0WmZc06ascKPhiAXVgU7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+6h35SdW33GIkGZQdXBA++5PWVttEJWvGyn5StZ0Z6Qp8GibFMUYGjLzMNWibfySflf8WPSI1GTeUt3SnKEef05ZnwUF9gvRHxhOLS+65o2gSzOcXNIP5WEVi59iiHWNK0GHCaf+teSyzKN/y/K1PNMFIe7QoAZzAAwiKbuEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqmuLUON; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso12492840a12.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761650265; x=1762255065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj7ktmHq73qKPElv2LS4tSJ0bsxaZTOBfvrVRElg6Ls=;
        b=AqmuLUONDBjuK6FSaU2xTLfg0p9cu1dVOhm3+yE9cYi2TfdnbYxshSUSkC2McOgizr
         WU6TNkMN1RIWYEizkLrz8m+J61lEPIonqJzoYAmNK0ArFoBBx4CXupM3/d9I4tXMbs9J
         JReryBC+18FgVzDC1yVJ+v7C+FzzthqzgzaiQ8IiC6fWFADBLrPglyaqO0iECZ3vgy7c
         ZYG2J1Kx+fNYnZ6hfNDFjFuYFXr5ldxGR7nbdW0AqYUOW7Usr7Nkc81zijiCKsLSQHTY
         /GQXyj2os2vwR0/HvRspcaKxuXIRrQYzbtWp3DFaxlabLeg72H6t0Hg4uUFS/G9lB8C4
         odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650265; x=1762255065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj7ktmHq73qKPElv2LS4tSJ0bsxaZTOBfvrVRElg6Ls=;
        b=LuDrWdqQUFw78OUAbTk5KgwlvL7BBjJLkXqmcbZELUXONPeFoPzb/aUh/OKURWeHzs
         o3raR7AgKIfhYQwFYqlTritwWorjKyt+qhsF8Z1/GSLnfAq0ISmY0v1/P/kvJCBC9Om6
         K2HjKqy+6wh117N/niDaIY20JiLlFTJ2JQHeVauuRLMlsfUKte0JZsAms3nrU6z56x3k
         VZ0iswXRUhTnWxG6BU42YOc/ngWIwZ9+j1dbT2G5fwmNYVK+nrv+jQujTB1XyiSVJ95D
         5wWFc0Z9PjWETlenYI2al0BU/OY1T8lvmAyMrFCC2bqxOtE0JmNbh5fWmFz9XqEo8XA5
         5vsw==
X-Forwarded-Encrypted: i=1; AJvYcCVLv38OpsX+gEGDK9nWR2C08OQThzBhrV5pBuu80eb2xKXAwMhIH3bX3IMGbz+TfyCOmUaJYGgmmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DGQzANveFKcCEdRcuYedix+yWHB3MXikONXAi8pc9vAbOAZZ
	HfE1To3kBpnl+Wrl7mXCOFmX9Zb/3Lq1AI2b1GYQ89ag0qjpaizUtyiz
X-Gm-Gg: ASbGncvH5us8SLDLN3W+/A4p6JjKjZ72trjSKVnHfP2eLzNBXFvDE17r6faiVC4zIye
	Bi6qYjIkizU59V+XWQ78UepNKrxTxF+HZ9W/upwIqtLCD50JqRdYmgCYKbAp0GiVOR3JCAm4Bu1
	MDYucSzQM0ZvMs7E/V33a7T0gR8WbNVHpGg6OMo8wo4DQ3PFpTgAbD/tl+aIiTrduY3lNY6r2Ac
	fjK4Ch2o5dxLEId+6ubQ8+vCEIEW9+Xa9m16WeKQ5P0dFUvjzTyVwh6mDfSTp5wYOx7ehyfIHpE
	uXdyFBytYXtt+x35QggMoUcQM9bhQdlQhefAqOUTpp9MQJ28gqOBJ4AAEax5gF1DfQm9IoOGoVp
	wkng44HcNQvb5CQ1hWnJKTXriyOL32Bv6CJbt1dYNfO8o9H5aQsuDxhoS2vrCRGmGOu7vFu/1Fr
	MD
X-Google-Smtp-Source: AGHT+IFJXHB9ihVZZL8J+a7Fon8pv06DyyQ1n8l/4i3l1xAYu53PrgJF4mUG+pRFHQfwm4wGmzsewA==
X-Received: by 2002:a05:6402:4553:b0:63e:600a:d341 with SMTP id 4fb4d7f45d1cf-63ed84c7751mr2136864a12.37.1761650264979;
        Tue, 28 Oct 2025 04:17:44 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef82e07sm8598632a12.8.2025.10.28.04.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:17:44 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: superm1@kernel.org
Cc: lenb@kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pavel@kernel.org,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
Date: Tue, 28 Oct 2025 14:17:30 +0300
Message-ID: <20251028111730.2261404-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026033115.436448-1-superm1@kernel.org>
References: <20251026033115.436448-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Mario Limonciello (AMD)" <superm1@kernel.org>:
> commit 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in
> hibernation_snapshot()") added a restrict GFP mask call that leads to
> mismatch when using the platform for hibernation.  As part of calling
> hibernation_platform_enter() the mask will be restricted when calling
> dpm_suspend_start().

Are you sure this is proper solution?

As well as I understand, pm_restore_gfp_mask will make pm_suspended_storage
to return false. And this will enable swapping. Thus it is possible that
we will write some pages to swap after this pm_restore_gfp_mask call, and thus
we will damage swap.

Note: I'm not sure that my explanation is correct. Anyway I think you
should explain in commit message or comment why we will not damage swap
here.

-- 
Askar Safin

