Return-Path: <linux-pm+bounces-41289-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI+QJmgOcmksawAAu9opvQ
	(envelope-from <linux-pm+bounces-41289-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 12:47:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC69B66344
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 12:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83A5B8CAB25
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DE43E48C;
	Thu, 22 Jan 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcP34y7e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EBB421EFF
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080807; cv=none; b=gpF8GTGlIPqWY08JCEOcUVI5aVxBQr9Tlqbu1gcCcMdWnTZP1BqYF1FHkI8vD6lObUUMtKlc/3zYqi9E5iKoDF8M4hZxVXS7MUT+o9qcDaGcz6rnbcYHUn1acCKjHTTDPpM3vQjJxsbDC3gyTTbwebcbzvZHQQDPXanDyKHYOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080807; c=relaxed/simple;
	bh=9drDpY6+z/ej7FB1CPcTn/nYH3WOGUJooU/8D7OpAgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h50V5WAJfbH7eNZlGaMzzRQWWOGqwA7VhGjmZHV8lelIEOIJ1nrDcYwPRDpRXzC0/kpTbK1qDrpKQUcNEGCAt29GJdjCiIgYbEUyptgnHT9sSlib0CxTiBjB3e7/VCZhNCbqgd58GJyehdrmPIpS3CtX8ox/0HM1whJLUcNeoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcP34y7e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so7061195e9.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769080803; x=1769685603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE16nPS696hV6qrtA4V5+Qb8uv6z8ojCk8XJiLozdcQ=;
        b=YcP34y7evYlbP8KjZPr56OD/ulJ5DfPGRL+gMMA58U5ujb3+c8LGrj3KtZrTJ7Ri5l
         u/70JMAcJIx28U6HHH5XR8a/yUxOetwQ8H1wtuYjuPanuGdIIeTAG4A/GwIvhvNPrXGi
         kT+kMcYS69OlVKs2EvjtKG2j+2KpC74MGYCCfK4xgo0a9JZZCkMnKsV7IEdKb5505zZW
         Bjflg77EIqPa7wUOh2fIgTAPGnTZ0TF2uqIftBva5lHvFAi8SLeqAC2tKXq3Dl0QQymU
         IRajj3c6eEjzL6asrKBycVhFdr4cAfFrP+qQEB3VnC5INdYHBLlB1clGd+yfs22NGk8S
         cseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769080803; x=1769685603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vE16nPS696hV6qrtA4V5+Qb8uv6z8ojCk8XJiLozdcQ=;
        b=f6sxxtlgxRJKni5qQdUM7vn+aEYkw/ShDp/CQ3uqaZ+hlr9pdjhzCGFWagGDp5Evrj
         TrItCxmFIaEQl282gWlHLAvHZbKlX7tJ3g1dSEfDl99J6kSNk4rbfVfE33e6kDDzqMdV
         kKwM7cDbmjtf55uBqPQ3cbEYCmoCqlz+HqU0BhYoONgMJO1CwdJZE4s0MTu3h+cLZifc
         PCxFDfyYeHQhYEXqaE77/g8t6zn+sb24XHNxmQvl6nu8vceu/U2skn+p50qtDLwjOCqU
         45J1rtQRaWxriq2Kks+XnSFUo98yMi9Zw1VeY87jmP47isQqDZZCxuBNfQpbyjoSoHZ1
         nWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2AxtYJuSCKowHW2Pf+tgK85wLMt0wRYuMWeFKryhJ36E3eiM6inI6ZluIHdQrupfD3B6ZkbgAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGexHG7sRhC3H46QHTAZiHxR8fALRZcdkRsj8WD8aws6UHlMu6
	EZNJIWWaBQmqGHePbpUFye88yFi7M7BKjpMH0aUO5zgO+LtWZVYnuq2O
X-Gm-Gg: AZuq6aLyz4Qn/KFVgv+BxyO7EbQJj89RaeRZRa1ih5mBq9+7JEGhu49NMP0M7GOGgP4
	vCwW7Sr+bOstuCmQwWu79JvTgobltBfQ3JUMxjcVJ9aczLW+zGF0HplV2tP98xqVhSgSTIWjRn2
	6nhLT2qEPWkG13fZjLAjKma4spB48Egv8IH3dyW3ntQrXP4F/Fce4BdAUpwDt7BtXHoUQZlWUxC
	tjP6Xplhv4thaYLubcm+UgL//XZ3d4uTk8TpeEPtQHq4kQT+ErD3TCsJ5zXZ1iqTiRyrB/ucDzP
	5czTodv3zAmh1KJaEZXOBoiKEfw8yVvDYU27+RFYNSyDUQz09hvYr4+grJJkN9BRlfLOk9weBLB
	ItQuiG9uftnvTXkzM7NoRPsTiTaRh+Vtr6WMVXzXn/RP8S05ucjf0sGcliqUtscocvOTjm2/XGx
	qIZmgbU4Kkfj97dPUphO6EdVg4VwC9HOeL3aHo6eXGAwlnedVQBAr9
X-Received: by 2002:a05:600c:4748:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4801eb10a4amr295290455e9.27.1769080803227;
        Thu, 22 Jan 2026 03:20:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424aa344sm51662315e9.3.2026.01.22.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:20:02 -0800 (PST)
Date: Thu, 22 Jan 2026 11:19:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, christian.loehle@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 yumpusamongus@gmail.com, Ionut Nechita <ionut_n2001@yahoo.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cpuidle: menu: Use min() to prevent deep
 C-states when tick is stopped
Message-ID: <20260122111959.14e8fb3e@pumpkin>
In-Reply-To: <20260122080937.22347-4-sunlightlinux@gmail.com>
References: <20260122080937.22347-2-sunlightlinux@gmail.com>
	<20260122080937.22347-4-sunlightlinux@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41289-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,arm.com,vger.kernel.org,gmail.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: EC69B66344
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 10:09:39 +0200
"Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com> wrote:

> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> When the tick is already stopped and the predicted idle duration is short
> (< TICK_NSEC), the original code uses next_timer_ns directly. This can
> lead to selecting excessively deep C-states when the actual idle duration
> is much shorter than the next timer event.
> 
> On modern Intel server platforms (Sapphire Rapids and newer), deep package
> C-states can have exit latencies of 150-190us due to:
> - Tile-based architecture with per-tile power gating
> - DDR5 and CXL power management overhead
> - Complex mesh interconnect resynchronization
> 
> When a network packet arrives after 500us but the governor selected a deep
> C-state (PC6) based on a 10ms timer, the high exit latency (150us+)
> dominates the response time.
....

We had to disable the deep sleep states on much older Intel -7 cpus.
The problem was that we needed to wake up multiple cpu and they tended
to get woken in turn - so it was far too long before they were all running.
I suspect that pretty much anything that cares about latency has always
needed to disable them.

	David

