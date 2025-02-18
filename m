Return-Path: <linux-pm+bounces-22292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04CA396BE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 10:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D4716286D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450E22F166;
	Tue, 18 Feb 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkPj8ud3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDF1EB1A6
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870242; cv=none; b=U9VoWpYvHwDCPXV1VREFQ6dkYgb1hwIWy1iv1s+rn46dUqqoh4Ag8aBmalviGzFRkkVlzq6V7E/B7NB/8H8x1tIUJC9I7JI0vwKHVxLho6w7RAabEVkInfXXoyPFkT0aWSRkf8n1wyo1f6asXAfBFlcTi9ahHxqVzM6T5jrzE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870242; c=relaxed/simple;
	bh=e9eawh0CQTC6B4XkVXKnBZTw+De/FpP0oA2+UhyUCeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SSG3uZ5WoVqyx2Z2s8EdAYZOkp2G8lAnOerVxxJEX3f/moG/3hMf49FfctJxnYNo4M+sJHReAPExf8DdkK66FmGgK3hMQ8iJO96pGJhUgJn1hhJrQkYVNZeyrV+AGKKK4N8SBSx2ZemgK021Z0T3dYffYYTYNMLTpWgpDC9yu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkPj8ud3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso10509645a91.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739870240; x=1740475040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9eawh0CQTC6B4XkVXKnBZTw+De/FpP0oA2+UhyUCeA=;
        b=kkPj8ud3WPOPuoa0aG9XMxegP/Uq+j0KH96YL0HqV29MJuctdCHRzz/bveDcYoCg0V
         ej2vzyGqUpLHMrlTblU6jzAY7CCBO18QKE4bujyzOEvMKVVHOoViJ9SZE0b/6dzfgyAm
         Fuvb400lk8JQSqPhzP7b+yiiVkLghzLZ5GqjsekFQ+zF8OaAX2NQ5C6ct0TN7nqiDSsi
         yyTtM5PRPHySogNoVqsAvTJGuri7vRTWI3ZqHhcME+6pcBBa0Uy3VK1PHRAUP/D5HrSd
         iNKui2VODNumGEgLaQyCD0ZKEXN6EydrMNhW47w7k5TYKA0uWzoSw43SZCjyFqKvDF1c
         3wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870240; x=1740475040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9eawh0CQTC6B4XkVXKnBZTw+De/FpP0oA2+UhyUCeA=;
        b=kH8PDhFCWF/Hs08DjfJaCDxscenMU2XoFNV3lQLebEBE8H9VMV1s0Wepb1AnJxlaZY
         h/a4/LZ82TvTy8XtpErl2RKKTq4eNzzMflTwo8/7URXlQNOqOf42rbE23q2I+5AmBtPR
         iPLcG8KYtOgoqyPqjkOeDj6/fb3FUB/zYFxYKOeT+l+KbwGOYQAS/023GT9Z5aVG5l/t
         q0NuYMuVMaEtBiPNmENMyv533JNfybv7kws2Ade+tohuvK5mfdQ0fZYVpiV3OQyeCZYj
         cM8civI2m7+DYs9298XNV1Rutu2j+WpOnGGQOe8oaGcWlzw6+QYiTgZHOIQWzgXXr6F+
         UuEA==
X-Forwarded-Encrypted: i=1; AJvYcCUueC+NqqnXh25Kifs/DWp5IL+2dlU41mxmmlZmT7d0caCTYhrRKuePopT6u6w9xDo3rAjG1wzJhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEnT/NI2ya49tWoD/V/PdVqYh4BN6bYPBBJK38L9HUcP1plq5
	R+eH8/A3rLYG8OaFUSLwd+TxuebjT8MMPGcyJaWyYPWqH4h+mp5FTiVaJNe+8NaB1GvLEA==
X-Google-Smtp-Source: AGHT+IGEUf1IAWU1YfH4BCxWMw3DbzclxHXWfJ0bKoh4oebNPcKR4H3sJDIdZaS1HGUEr9wC1aKrwoRL
X-Received: from pfbdn12.prod.google.com ([2002:a05:6a00:498c:b0:730:92d9:52e3])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124e:b0:732:23ed:9470
 with SMTP id d2e1a72fcca58-73261901144mr18452340b3a.23.1739870240161; Tue, 18
 Feb 2025 01:17:20 -0800 (PST)
Date: Tue, 18 Feb 2025 17:17:16 +0800
In-Reply-To: <CAPDyKFor_kP1hcNC1YwLBjH=eaLG9qSyvOYvj+FQrNu8Piu2Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPDyKFor_kP1hcNC1YwLBjH=eaLG9qSyvOYvj+FQrNu8Piu2Dg@mail.gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218091716.1450623-1-keyz@google.com>
Subject: Re: [PATCH v5 RESEND] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: ulf.hansson@linaro.org
Cc: aarontian@google.com, d-gole@ti.com, daniel.lezcano@linaro.org, 
	keyz@google.com, khilman@baylibre.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> Looks good to me. I left it to Ulf, FWIW:
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Applied for next, thanks!
>
> Kind regards
> Uffe

Thank you for all the review! Excited to see it in the next.

Best regards,
Keita

