Return-Path: <linux-pm+bounces-27646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930FAC3DB8
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4425518950CD
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D81F17F7;
	Mon, 26 May 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bu/4jCXL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FA1DCB09
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748254361; cv=none; b=MbewhiCGl0C0QddXfZhcmD6EGwgnDDaSixB/V4rBJfZtjAqWmu3m446BYPU6ciRODf4jkX+/gVaFNBalAl9eZt5g6Xfr4zqBbG2OCqJaayk1XK1EEXD9blLzugAXPKBHoGQZBtQjtWdtxLYPoCldkLMgrTz/X9ojxB0tYsuafuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748254361; c=relaxed/simple;
	bh=wNDOt/KgMMP7lsIAa87g1prMRWTJTTagQvC31pmgO2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZbZWA3C8QqOzG3C/wDfnHyUTHJAgHdMFosYi79kicUQezKKEsFdET6wJv+Z9TDqpBVzsXS9w6q4Ae089Y8SkeAtHDINiNTLX3/HcZ3P6DatQ6qX4PV4uM4xhpACXlCB7F6uBYBT+qq6+QYp5fk5tbgWz7AWW/jXx2/x1GdmH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bu/4jCXL; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7db7334738so336062276.3
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748254358; x=1748859158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNDOt/KgMMP7lsIAa87g1prMRWTJTTagQvC31pmgO2A=;
        b=bu/4jCXLBfgyWSxXuOjtGpgjGvbDvjib9BCju7rEnPC1PEy7+yBMb6hsDiSYy3zI8p
         A5cT1MpgVYgKvL/wgX/IPmlOXoRZ6RJcZMaCY5oFRh1TM/Zmd+AZdh//QMb0SESMbFPp
         yFWwdPXQVYm/Y8nEFFg2+7K6gTdu972XrnI07lduhghtk4BZBKM8/rijmoz5jUwRFY++
         59iA16et8pymKvoVaM93JuF+pO/WLAIrivstrKJpeBJj3rfDKtRt1z8sKYlYMBeZ1ZYz
         9To3HGlBHRGUb3fOkRK9lpnD3hprjjgjY8Ieu6fm5gLEiJ1JeYgWd1oUFObdqwYuHuBe
         XUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748254358; x=1748859158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNDOt/KgMMP7lsIAa87g1prMRWTJTTagQvC31pmgO2A=;
        b=YwCRWYlrKzhDfe4rOT+5+JaJu3kn3geN3ctxQF2bqcGRoQkilredAVhCPQgJVa9HUv
         PohqAbLkPFlMWX/o/c6mVBNvWQJluedvQwQS8JSuRoXdtWCavaAptBQKtTCrfFpiq6ia
         LoYmb4vPhlx8yXSfAFt5TGSeJMt8YpNGFk8pLOERfizoFY+8hKnkkyr5NTRFHnoKhfMu
         HG1s9CGX9RerAKG546+P7bzAmbO3teCfG4hSSUYOwoIQ/q6jQnOxPw2hAPku0gsUK2ca
         Tkem+Ko+qf8OvJY6YU1WMFp/3etVZgIq8b0EOsQL13XgDnzAUV08Gntj7aIz9uHyvsHm
         7fIg==
X-Forwarded-Encrypted: i=1; AJvYcCUD1tGoKgMMSNvi7PJ4eqD3y+jvgWz3R9FS8ijC1qs18A2Aq31dEyw2YcwnaGFJ79oi731kXDQmtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzragUe7XGq1wxnMB2qXD/aEvUI2x+RR9KMUJgXQzwF1awKC2s8
	WNResdyC8PG3qFardJ8O9ZQQnDFDl5Mg7KqcUmay7FVy+UKZYw+RjCkTAOWfPlogTLaqlhWY3eh
	vK3ocmZwlVkvAK8iIhhGOHJN2/EUxQ3agDughYKODSw==
X-Gm-Gg: ASbGncswFw/QUzfwDcvK0TSAymwOQPoxo8fcY5ni0gNCRXxOMRMPHEHlDF56Hu9Bhvr
	s2rGs8NfkZk5Q18gNB7xrcQPulcUo+5Z4POREQN1z7ftWYIsJRrXkkT4nKCzjowVfg0h0FeyU6V
	S8jQ2Z4i0o3v4pl2Lom3JtPex5qnEe5BCvCxrZ07/0MBu4
X-Google-Smtp-Source: AGHT+IHi2XOZ9dRIdDcFBl3BRRFnnGCoagXOgAmEZ2Ih20GPqbGzZkP+XJCYm0HJs1gaCBhpq5GmobfeIAleVXtAPSQ=
X-Received: by 2002:a05:6902:1082:b0:e7d:b5bc:aa7c with SMTP id
 3f1490d57ef6-e7db5bcabb1mr1985809276.16.1748254358450; Mon, 26 May 2025
 03:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <20250523134025.75130-10-ulf.hansson@linaro.org> <4a0ec467-b81e-4282-8e09-b7adc67eba97@oss.qualcomm.com>
In-Reply-To: <4a0ec467-b81e-4282-8e09-b7adc67eba97@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 May 2025 12:12:02 +0200
X-Gm-Features: AX0GCFuhoe61jaT4ElHv6kD_woYqu09-YjR-85TQ3dhfrASylj73JDHmzoEBPqk
Message-ID: <CAPDyKFo+DDuBiic78hdN6JVSO1iQbJTvJgPwYaO8Y8soaJyEhg@mail.gmail.com>
Subject: Re: [PATCH v2 09/21] pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Konrad,

On Fri, 23 May 2025 at 21:42, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 5/23/25 3:40 PM, Ulf Hansson wrote:
> > To make sure genpd tries to power off unused PM domains, let's call
> > of_genpd_sync_state() from our own ->sync_state() callback.
> >
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Konrad Dybcio <konradybcio@kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
>
> note: the subject is wrong - this driver is rpmpd, the other
> one is rpm*h*pd (patch 10 has the correct subject)

Thanks for spotting this!

BTW, would it be possible for you to run some tests on QC HW for this?
Any help would be greatly appreciated.

Kind regards
Uffe

