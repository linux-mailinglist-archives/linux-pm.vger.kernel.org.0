Return-Path: <linux-pm+bounces-21150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022EFA2333E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60A01619FE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A51F3FD8;
	Thu, 30 Jan 2025 17:36:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480391F12E7
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258608; cv=none; b=sS9OLKEAMKh1YS7boevOpLqeV0btAVbOpvEqFM7o95HVibDKzVHSBDrGjvvo6xO7sa6WShwZkIBwSEZfETSKPfwexvazxtXCmgH4vfG23Xzoba/y/RDZumHh/zTCOSSWfRBCKL0Xx97itTCYcE31O4aFM3FeL9qZ4PrcR4H7Qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258608; c=relaxed/simple;
	bh=fEvX637Z7c33Zk5WCEhwiVVgzZ0aKNk8OcHlF0sVoOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pf6dUsg0DX08lNz8V2r1aidXfTbsb2jlt8WWF86u1v+9a89uC8OmhFbDGDpgBLNonlbw/vhDn93vBzP4lW/YWL6VOuz4owOHqY2iIircMx3kxRaRB0D5oAP2U+2QJnf7rcDHvnwyBgIxLN4Mp2VfAsSKBrBVJSOSivGjRww+yUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21669fd5c7cso19108425ad.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 09:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738258605; x=1738863405;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wba71lrlJHRpHNYwCSUOMwjfSnFCdMmwKcitB9A/Re8=;
        b=kq9cguoFEJiFCz5GNTtWy0R9lrJnCKcSUVyuIudjCY1WHHZYIc9/2d4XlrlgNNWzvz
         9ZZ/cupVfSam3M6pG/Igk198CC/pEruUhqqPnK4hMEE8NSbwOIyWb4Q4H1rrxTBlGRPJ
         wcYXTtdNazAFhubNXn0SxPddE54YAtFVBa/RDisoU0f8WpfB8JxAJ8jd29if0/vO8Ek7
         g8CE3GsOoiF6vNsXWnP1t1IhP9Ik0Oqi/AXNW7PdXVFKyH6Cd/zKPZz8neVozd+SeGWg
         VYEWVzgHX/gh7yTwfeWalzzoshl7mTE35CLqUXvXOZFlknl78hGIURZ5yN6/kWa6FXit
         5seA==
X-Forwarded-Encrypted: i=1; AJvYcCWR5JMC9KpTbUZdryAhjU6BvoP7m9JrriRKWk3wxtCp6vL0+q3bmB4DOBmPcBhB0UEHJfrAjoczJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMdsPaN917DH5q+edp4p3ke4nKd9DwGx8EbiML4+EAiMCg0L9
	E8ikDZh3A/tkREcLJftFWTBBWOCbSQ0vnCN0jdWMU4HW1L1/4bA+TL62lJpDyls=
X-Gm-Gg: ASbGncsWIaig/eTB6x8GTX7zH3Ji0lvPdYi2t/D7mF1YhMxCgb1Hfo6UzxiZTqN+dNS
	Bc7jRvO+1jWcwK61lBSgP1UbGoLPHJs3BP+AHt6ngKvYLFgCoVe5v0dsHKqSMI+72hHG3rIgEZ1
	tINH36Jnui4usRZpukvhxZTxAMYPsocrEDoltGuI2B669jtLo18n39xf37vpUfM29tLPkZgWKUi
	AExBk7hRY57ivQ0SUtjNFmVoELPa67SGRchF7h3xV7U1WKkuZtAAcPA6xzxLnB12Gazfwz7nl/z
	xN4j6cvg+kakzw==
X-Google-Smtp-Source: AGHT+IHPgtyksfxV717Ovby5/EZ85xi1T/C77gVscvPLkijnPA2Hto/kR8guWoggO+GeixLtqrCFiA==
X-Received: by 2002:a05:6a20:7345:b0:1e1:c03c:b420 with SMTP id adf61e73a8af0-1ed7a6b820dmr14182766637.31.1738258605613;
        Thu, 30 Jan 2025 09:36:45 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe384272sm1423838a12.18.2025.01.30.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:36:45 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Keita Morisaki <keyz@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: aarontian@google.com, yimingtseng@google.com, Keita Morisaki
 <keyz@google.com>
Subject: Re: [PATCH v3] cpuidle: psci: Add trace for PSCI domain idle
In-Reply-To: <20250125013145.1664062-1-keyz@google.com>
References: <20250125012734.1661860-1-keyz@google.com>
 <20250125013145.1664062-1-keyz@google.com>
Date: Thu, 30 Jan 2025 09:36:44 -0800
Message-ID: <7hy0ysi4pf.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keita Morisaki <keyz@google.com> writes:

> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
>
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.
>
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
>
> Signed-off-by: Keita Morisaki <keyz@google.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Kevin Hilman <khilman@baylibre.com>

I've been using some local trace_printk() to do exactly this, so I fully
support having some official tracepoints here. 

For my local hacks, I was trackin the state index as well as the state
value since for quick debug, I find the index to more human readable
than the state value, which I have to compare with the
arm,psci-suspend-pararm from the DT.

Anyways, thanks for submitting this!

Kevin

