Return-Path: <linux-pm+bounces-18265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA429DF040
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 12:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D964AB215C8
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC683192B83;
	Sat, 30 Nov 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIb8eqCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8214A630
	for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732967157; cv=none; b=YsnUGYS1nOffObToe59UDuzGhgPkDINuGo6wyLPpmBAJ07sU+wbXiM7VHXx0NAp48mPVk55/9qogl1VEwHiPRbaHqF2vae/UBNhABiEr2Z34DzC38n5SScwMCT2tYVARrSyzTCN58oj/UrDTcsGR4ygphbN1H9ytxE0fSUlfFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732967157; c=relaxed/simple;
	bh=r1e0yUCyDDwKPlm63GtdgkD7CHFhpuCqZeRfGb0SRpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeRvND98MU1hml5v0KWy+yfU6zOKMTNwCGGwbSV3f6hxFPZfAHGRElcCS9ENEzsAyWG7XYt9F9w8YIybplP6cuxLWH03mEomz80MRVPT57l1d6qpyhz3yMnTo9ebDajgrBufqz0lR3vkfTwp50C54Sv2hg5qJO/X+zZoRbbVItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIb8eqCT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1940962a91.0
        for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732967155; x=1733571955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZLt8uumTsVK4PRtt2vPFNMECzkd5X7pvdUrrrYwcuk=;
        b=lIb8eqCTB/teUES3ilAePby0+wZ5lipqBQsr5ydfF4sU2VLfZfLSYnpldF61qz1duX
         IiNpI+799ApHZPB0Fp4vFOMuHioeT/hTDiaDgeN7gWbCgKmRws2PMmxTnSaI0a7kK6ug
         AmX1pv1gH8QgTA+OErVhuJeok8V8X4V6cs1fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732967155; x=1733571955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZLt8uumTsVK4PRtt2vPFNMECzkd5X7pvdUrrrYwcuk=;
        b=iaogYdRg9G20y0zbCR+QYegpOFKph1TKGb9mJISfuBNU+qXNRTpmIlnrsM2n8alge7
         Cv6CeKFg9qdIatUw14SpnqANZsYRIYbR7LArgu7Hc5YQD8GOL5DuL15N2My6qmHnAYND
         QvW2d8L7RUoj2rBNRPBsyjd8ZchS8MRG31ymbNf7OOWwpIYeqgz3d+VeAQuf89Y4rzVk
         eRQLGDkOvWZ7LwquFb1V19SSHwquCx4/OzXHRwZgfcO80t07lDSKIBLMnlFVlg8EwYgR
         hSZI3t7/uMgiZUwUYgR+EcDBCE+Ika/MEaKjq7Wf5ut3BHUJnNpSAYaYd4miwkkwBiWW
         8nPA==
X-Forwarded-Encrypted: i=1; AJvYcCWektWARdzgoCfPegzFlG1YlfZLc3KPyUhG0jsiaHwK7f/9753VDTDn9qzv8GUbCSoggRMvV2Bizg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyFaWtj0jMUxgyvRPTPHdQ7CzC+qDuxj5hj9eLfHuvJ7H9OO4
	b/EIqhheXtlllhCo3X9LEVYm8SKAGX+Xe7jxtvBzaVVfflL3SBQH194/KZqr9w==
X-Gm-Gg: ASbGnctH0dRF9wVT/Qk8yD9VrkeEYIZ7icZli6PUi7hiRx+SoQis7y80RQLuhojLM1a
	UUgl4qY3DLkLuFAI4vnVeqwnylzRUVTzZ/4RCL0xPtWWVplfltDLJAdNg9nhDVH3uACYJUa9Pm9
	AoShfsUSmTSp/01lzBMCFWQi+Tcnb/pJ2wwKJINvDQ1F/gGO5slPh7STaaayEpNBBBCfTaeDqRM
	FxeaC1VGT0i5gSLd5Fev489n66uxt4BQ1br7HLOGvw34x3Jz8rKGQ==
X-Google-Smtp-Source: AGHT+IHgAsdwCtIGni0kUusDMWjJYG3oPVjW5T6ZOyx1CHulNmaI/ielGsyBmh1jVqjnM8DFAz+dAg==
X-Received: by 2002:a17:90b:3b87:b0:2ea:83a0:4792 with SMTP id 98e67ed59e1d1-2ee097bdd2emr16602262a91.28.1732967155689;
        Sat, 30 Nov 2024 03:45:55 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:18ff:40bf:9e68:65f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03bcsm6794650a91.33.2024.11.30.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:45:55 -0800 (PST)
Date: Sat, 30 Nov 2024 20:45:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: 20241015061522.25288-1-rui.zhang@intel.com,
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com,
	peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
	x86@kernel.org, linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
Message-ID: <20241130114549.GI10431@google.com>
References: <20241128111844.GE10431@google.com>
 <87o71xvuf3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o71xvuf3.ffs@tglx>

On (24/11/30 12:21), Thomas Gleixner wrote:
> > WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> > The relocation at __ex_table+0x447c references
> > section ".irqentry.text" which is not in the list of
> > authorized sections.
> >
> > WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
> > The relocation at __ex_table+0x4480 references
> > section ".irqentry.text" which is not in the list of
> > authorized sections.
> >
> > FATAL: modpost: Section mismatches detected.
> >
> > Specifically because of wrmsrl.
> >
> > I'm aware of the section mismatch errors on linux-5.4 (I know), not
> > aware of any other stable versions (but I haven't checked).  Is this
> > something specific to linux-5.4?
> 
> So it seems the compiler inlines the inner guts of
> sysvec_apic_timer_interrupt() and local_apic_timer_interrupt().
> 
> Can you try the patch below?

That works, as far as I can tell, thank you!

