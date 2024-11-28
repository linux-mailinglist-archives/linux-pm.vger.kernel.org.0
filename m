Return-Path: <linux-pm+bounces-18206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9769DB65F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162C3B218D2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A271946A0;
	Thu, 28 Nov 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuA7I5Nc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C091482F3
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792733; cv=none; b=sGf+3FhidEgchocmaaeOaNhS65Yn4Bh+SWmdGMo7srmynvWdf1kH6ypYbPMwBGj1lwlj/pclSiYcMqd4W5ZljVc9qT/SZCc+ops7Tjy5/1Mvs5/PwCIuXUSZql7qjY4qEwCngQbBUHl5cOcs1qi7oF+TLbTDVx1Zn6Kbj2ZiU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792733; c=relaxed/simple;
	bh=1Dr/9wK0GiPUXbwSM3pXd7ht9BNkBZhC+a1phGPu4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TbApRXgKLy/jp5K6FT9Yy1VuESp3/jPP6SDznH1H9UDReGaeTO1Ffb882pE+QsPql9MKx16GUbxAUTQtmvHdNFg8ZTfm0rKRne96ZdOgjXGYh+MytTZpCvqPKqYvWUb4tTmRiYp2UrZKwbM/s49mf3soZrHx2JyR3PriORrMOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DuA7I5Nc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso698183b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792731; x=1733397531; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7g0EDzT90oSJRMdudNKevE+2bYFLsEd5Pd/+GTWI7E4=;
        b=DuA7I5Nc/yBWzCzpYtAGYexy6CLXEgr0dTpwIAWbZTU73W4Q63fju9fXqqVRZZj29s
         d3XJ972aZ9SLNRoq/EHZtdvrjZ0MDN41ydzxahJDvZSdrEJryUhagnLaWzx1/O9pWTWR
         unifArbhbMMpQZ2WZH1/ob09VE4jbF3hqGDxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792731; x=1733397531;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g0EDzT90oSJRMdudNKevE+2bYFLsEd5Pd/+GTWI7E4=;
        b=N/qnk9zV99NbNJ8UOvQNa3zB7Q1QNLibwNUqVbfAkNDyF3egnwTFiBcm+Ss2C/gRZR
         iZW4ZAXwyT0TR3sZFugyUZUBhlZabbUSyrS9gk1iGTvnuPp54uXk+/vw/Ek713XM2B6f
         d3jnaDznwT3G9jffLxnUlTKxPl5wWkcq3uS5dNFNobwgRRGrMsKsxLP6AzvOamDcKjo+
         KQK/g3WO5ukQMwOdUmkOJbY27ByseN40DWJSBKCj4dx/bn0RzGRsCBHpaxrYovpdr6+1
         2IUSF6GB8qlZJJiHfs1oEgSDqZKfILMYHNPUMfB+3cccFuw6MnqetPnv1tFZRpE2B5gQ
         XA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJnSXxMvIH7aodnitVPbXH1OtVElory1YiXAqCQ/taNMy3uQ+ClMk6qPQzEGPaJCSl24zvG9h6qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJbDBcKinsSJKWFazuygWeZTlpw+M4fTV5yEWlzDiijabjZde
	t/9ew97+oL22yIVCJ2X2b75mk1oOQUPT8WjX/rOqVRNBi889ob4FAeM25lJJsg==
X-Gm-Gg: ASbGncvvjYK3rcHmiSEV3sz7r0pbzK/hZ3z2Zu0dEFFw0YIxwRjMfgnzNMuea5YyShG
	2iGV3QWzcn0AEd9BnYT7SDlM2SIOiHgQVx/BMK8JgOce6df5gKSt9E9Hxx8SrTO0Vhju3fap4Zf
	Qg7Na4Sm1RjU/XLhoIpD6fTWBOseloFmMjRuuEuhOAfOyd0Dr/ehgOiQInSHBBHVEcFblBW7cWd
	eessGIJVULSuo+fb2wcn28mEQGizFHnofD8ppr6xm4SMtVZBIPbgg==
X-Google-Smtp-Source: AGHT+IEUKIyiy9WVkqcupbZQIOcf/4lQH7Ewcmkw42yxvQRWkwZbjCYyNcNqjlql/El2bpIiD4PCIA==
X-Received: by 2002:a17:90b:4b88:b0:2ea:95ac:54d1 with SMTP id 98e67ed59e1d1-2ee08ec82c8mr8162430a91.19.1732792730979;
        Thu, 28 Nov 2024 03:18:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa30fcesm3222262a91.8.2024.11.28.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:18:50 -0800 (PST)
Date: Thu, 28 Nov 2024 20:18:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: bisected: [PATCH V4] x86/apic: Always explicitly disarm TSC-deadline
 timer
Message-ID: <20241128111844.GE10431@google.com>
Reply-To: 20241015061522.25288-1-rui.zhang@intel.com
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,
sorry if messed something up, this email has never been in my inbox.

> Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
> MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
> to the initial-count register (APIC_TMICT) which is ignored in
> TSC-deadline mode.

So this commit hit stable and we now see section mismatch errors:

// stripped

WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
The relocation at __ex_table+0x447c references
section ".irqentry.text" which is not in the list of
authorized sections.

WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
The relocation at __ex_table+0x4480 references
section ".irqentry.text" which is not in the list of
authorized sections.

FATAL: modpost: Section mismatches detected.


Specifically because of wrmsrl.

I'm aware of the section mismatch errors on linux-5.4 (I know), not
aware of any other stable versions (but I haven't checked).  Is this
something specific to linux-5.4?

