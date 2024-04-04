Return-Path: <linux-pm+bounces-5924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F30898612
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C692885DB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F7B82C7E;
	Thu,  4 Apr 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA59ZEEz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C3433AE
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230325; cv=none; b=YCLLMeiM1AUG7vXh6kAPfXwQqoJOpHxNdv/VNwjZZMxzIAOrTEQmAHFnGJaBEVF8odOnrqbs9mwZMY0A1X4ukrDv6BUAQrBA4M1AySjyIFBVe1DomUmpFQZDh6Qj3NH7YpXI1rB3uThtYbnGN76M42K0zkp5UH2+4+JrYbPlvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230325; c=relaxed/simple;
	bh=9If0XtA6vQ76sg5ExOoZ54F9SUJdVYOOxPa1/FISYM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRIVqbt6crZcjSV1SQHJpJNn+BuQ6Ox4bHvl0WwEUkRfGPscTFGnnvuUS+MBGV4L0MB+n9rZQj8YaK/1jxbv0vAQcriXjwql8TNGnKFEf4piKQh2HXpDGwJq/AA2VfLWoUI7KjozGim/pW5J2kElRKx46+4AQYWaQwR0acWvSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RA59ZEEz; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so944190276.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230323; x=1712835123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKQIYElA5vVGkv3RkaF0hOprjYsSE6NY+pJuj6+PnGY=;
        b=RA59ZEEzzPKyCcnxSYBNovDs3nzejjpXzAF5q8fVgMl6LHPESeJxPbk3BeW64t0nXo
         bhOZWowpTbLtofciO8Q2DOavVh8dUMZaenAA3hP8hfupT0eq9JAQy7a1hxTYNWA+Aa3p
         z0qgBQfSw0MiiFuVt7T8FiMNCH3pUczbB1cD79rxo+oE6fj6JDeuX7yorGesY4363HE+
         T0BDZOMhtcXFqiGT7iDJV1wOKUhfR8tQNRtl2J38canRlRsGOigHhoM5dbu0tUYgZkt3
         LR0QuCrXdmbFqLcU6xbh2fl+Ri/6RlfqsaDmUh+W4M6s0sbuxRkZX91002U/j8PncWMT
         pOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230323; x=1712835123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKQIYElA5vVGkv3RkaF0hOprjYsSE6NY+pJuj6+PnGY=;
        b=v7b4UwTBrZv58HpFDdy8WUjXmEW3pZc1k+LTKt2qhLxnR6Qi43M6OHw9B1im+FJHhr
         TYyrT2TsdHIJSmJxjcX+99iIFLRis/9vCuXZ8X7BKjjFNkYvJwq7kgRWaVORsK0U5q0M
         Lys65Y8D7hI4TdIWfLyQ5bxsfg52ev8N9WawKYvmEOERCOqz939Pk7VUnfJOtfIdSKW/
         QdJVdIuz+RtKhNBqaPYdpiLKUBwjzLQ3LrUVqv5pdbIuO1xzwsQ8S/L204oqGslB8fib
         cAkjK0AXckL0uoSmehN2eFUHSDVoSDGhoxHn0Tbvxh+zc0m+koQQfuc8L37bmqpDGKBn
         6L8Q==
X-Gm-Message-State: AOJu0YzX0EKkok1TDMltim8+izHF5Av3O1CmmqlLKj10l9Rp0ThStlSz
	TkASnotVDMmsUXsW5ASGyWYM+0QBTOzhu0u7++Plvc7q4Zrmj+djs+Cq7AVHKD0b7iyf1s2baxX
	hriMIj1CWopfVaQUp/lO5fst2m/UmfAvYcOMmxQ==
X-Google-Smtp-Source: AGHT+IFqNt92U7yLFdz2oe/ajXPZqO5IfI6WmCzMNQdPrAtPqOcNh1m7jCx/xaDrKu6YoxlGR8S2eo+SmWTLtPsK88E=
X-Received: by 2002:a25:8f89:0:b0:dd1:48cf:5c8 with SMTP id
 u9-20020a258f89000000b00dd148cf05c8mr2190103ybl.2.1712230322872; Thu, 04 Apr
 2024 04:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0i+G7q0jxLGEnoigWf8Aa=zi4esC3EzethsBkxrp=sCLA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i+G7q0jxLGEnoigWf8Aa=zi4esC3EzethsBkxrp=sCLA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 13:31:26 +0200
Message-ID: <CAPDyKFrUKZ+h37YEhkkLj9ffPtV_gn5_8_dqUrSGNsYn7T_ozw@mail.gmail.com>
Subject: Re: [CfP] LPC 2024 - Power Management and Thermal Control Micro-Conference
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>, 
	Nikunj Kela <quic_nkela@quicinc.com>, Kevin Hilman <khilman@baylibre.com>, 
	Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

+ Dhruva, Nikunj, Kevin, Doug (I probably forgot some of the last
years attendants, please loop them if you know)

On Mon, 25 Mar 2024 at 12:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Everyone,
>
> This year the Linux Plumbers Conference will be held in Vienna,
> Austria, on Wednesday 18th,  Thursday 19th and Friday 20th of
> September (http://linuxplumbersconf.org/).
>
> As it has been a tradition for the last few years, I'm planning to
> submit a proposal for a Power Management and Thermal Control
> Micro-Conference to the LPC and I'm looking for topics that people
> would like to discuss in that MC.

Thanks for continuing to drive this! If you need some additional help
around this, feel free to reach out to me.

>
> The LPC is focused on work in progress and future developments, so any
> work that has been completed already is not a suitable topic for it,
> but if there's anything you'd like to do or you are planning or
> considering in the power management and thermal control space in
> Linux, please let me know.

We had a BoF last year around "supporting multiple low power states
for system wide suspend".

Not so much progress has been made I believe? (Except for some local
hacks that I am working on).

If possible, I think it would be a good opportunity to continue the
discussions from last year, assuming people are still interested in
this topic.

Kind regards
Uffe

