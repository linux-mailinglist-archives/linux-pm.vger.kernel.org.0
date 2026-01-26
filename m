Return-Path: <linux-pm+bounces-41498-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AbXJczMd2mxlQEAu9opvQ
	(envelope-from <linux-pm+bounces-41498-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:21:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB88CFDA
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F45F300531E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BD2D5408;
	Mon, 26 Jan 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAl4i0h7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA4271A71
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458888; cv=none; b=tgb30/XvgqRf9j23dgaJ0xlc3WB3FnKREWLMD4kFQIp7s/wyrR6uLfubwffgXD3M42MMvVb7E5v6Oy3NkkkidkYmQDTKFoZxRy/zuqyP6qHuBsOnYS/U4o+EUtoybLTYqKN7+4soS2qQeVuBV2NFerRkYXiG3Krsp9Fjc4JwJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458888; c=relaxed/simple;
	bh=xqu3YwpJVEVQZH29jJY+vRv4Bg+re1h9wvYTGv6IRJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgrLnMtBtiYlI4vqPvXpX+7aLE/g9RI9vFar+lFWDl6v8oB8bbj/OzFmuOFg1FtihzBBavG3XOQzihFhdJYOM7BDiqO2QcdHQ6uOk0yK/G/hIbSE+cfrE6moQdv8iNOFLBueON6YMdO8QLUo2IUaPnCR/rEO2A3SbdoJE5v+cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAl4i0h7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso38936045e9.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 12:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769458885; x=1770063685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhqRfC+ZkjKLBE27+UTSNmoxUrR+mo//ucpkrQIn4x4=;
        b=dAl4i0h7boIgW0uIEEKTxNpC0P9r4PcScZKTusrs2i6LmPohifk86m7DLXmmV3DUlY
         7WuuH2EaFuwqaUYK0idLZ2tpZmWtmLIL6j8dt65Ia6w9gMmt1swT842oAi4vs9Kx0rT/
         1klJvhSoP8KN5D8FuRDRfoB4I8hI2lNOGHMygFbjomtGPza4EmI55d/rGKV5QXSEBx8B
         iq9QqF1qbmfL/QE2F1cgplKZuwDy13Nd/y5baysA594U2zxxrK7zRReAD+ULq5nAPEc0
         7yfFdo2wCqEAbCYvmjhJ5ym/yrw/3JMpjV1+ny7MtyHN+FgJaQfJOJfJfeOf01hDOc1M
         Gb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769458885; x=1770063685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UhqRfC+ZkjKLBE27+UTSNmoxUrR+mo//ucpkrQIn4x4=;
        b=p7gP7a8kRF5vGG1j4g0sjIsDyd0NBbMdDVlG2eYiQJujH/9bLcCnjJbZEcqRLhDN7A
         yVeOJ+0tZgfnuZMA4P8vYl6hC57hgH2Qq0wTx3RfXC4PORqYlW3l6/1b/xYCHBxNs6cm
         HGt0ZnJfy7hReADwvOgm+2XLsudTWv9Efil5HFWWCxQfZF2eAxwG9e9o4axxgDT7M5fU
         jOOLs/kzwy8VThrhaIfue9Sendgow83RHSJMpm66keu//jbSkmqIntc5jtq+8gEMKYLi
         aIJ8X28qdc3uZps5QOytuw9zU0SWeyEcJmYR2yWLCmDJkInMnEghLB6/5DLFElT1mzCT
         lgPw==
X-Forwarded-Encrypted: i=1; AJvYcCXAosGLVqcHfO419fjdKu1MM4Z0hhpeHZHKWXUPU9xQCfDVCCtmmEAQtCoOyWoP9EUI+5ZX1pwQNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+DayMvRvifqKzJBk10KMRyb+WjdtonTQ1MKeQKyy9EWcJn59
	/uI3iUYzTzNeq09/WQccHymA0XrajrW955MD2CJSrtx8M3yjF6/KHp8n
X-Gm-Gg: AZuq6aJQVr2HMgKSXCMYAydMSX3Cj+0FH+L7riFdsDUROlRCuLNhj+X1bK1DpdnRIeM
	BQqU7KX41xZFhgSH31EcFjOi72Duq4VbSLyUud9QIfEO1YgwlqzeZBlo6xC+hGFfbZ1kGSqN1zT
	8bwPrB3RnFMKId7MGzydaqD9bYMkPnURziA9qXCC9p1j/b4Yku1agayDlvUxempGS+Z8mYbMCIh
	aNxFKdOSZDi83IIMsiC/0PGoIuKBM4kYTIoTpD1UkyZ0WATxK04JkTlNRdv63NWjFkQAN674+HJ
	kc+vA2r7X3Pux3wbLexDI4B9DSRClbw/YzRCVN5RFz5NF3faPpJ59paEpgGmG/m/9JKvCuZEueg
	0XZOM4xM1ITj2qg6iE7/rCT1RtsSbC54AnFP84egVwwKWnCE+p5f88paS0lVRNLy1WMVa6B0jcX
	bin6bG5OH2tFjwbIK5eTesT8OkyhUbnSRYRI1CVA==
X-Received: by 2002:a05:600c:34ca:b0:480:4a4f:c366 with SMTP id 5b1f17b1804b1-4805cf5ebdcmr95592855e9.20.1769458884833;
        Mon, 26 Jan 2026 12:21:24 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c30b:500:c472:222f:bc60:d893])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee24dsm10554565e9.5.2026.01.26.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:21:24 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: christian.loehle@arm.com
Cc: daniel.lezcano@linaro.org,
	ionut_n2001@yahoo.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	sunlightlinux@gmail.com,
	yumpusamongus@gmail.com
Subject: Re: [PATCH v2 0/1] cpuidle: menu: Fix high wakeup latency on modern platforms
Date: Mon, 26 Jan 2026 22:19:44 +0200
Message-ID: <20260126201943.11505-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <54478318-cbee-46f2-9ff1-9c0ae15a89ab@arm.com>
References: <20260122080937.22347-2-sunlightlinux@gmail.com> <54478318-cbee-46f2-9ff1-9c0ae15a89ab@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-41498-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,yahoo.com,vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4CB88CFDA
X-Rspamd-Action: no action

From: Ionut Nechita <sunlightlinux@gmail.com>

On Thu, Jan 22 2026 at 08:49, Christian Loehle wrote:

> It was more of a question than a suggestion outright... And I still have
> more of them, quoting v1:

Thank you for the detailed feedback. Let me provide more context about
the workload and the platforms where I observed this issue.

> You also measured 150us wakeup latency, does this match the reported exit
> latency for your platform (roughly)?
> What do the platform states look like for you?

Yes, the measured latency matches the reported exit latencies. Here are
the platforms I've tested:

1. Intel Xeon Gold 6443N (Sapphire Rapids):
   - C6 state: 190us latency, 600us residency target
   - C1E state: 2us latency, 4us residency target
   - Driver: intel_idle

2. AMD Ryzen 9 5900HS (laptop):
   - C3 state: 350us latency, 700us residency target
   - C2 state: 18us latency, 36us residency target
   - Driver: acpi_idle

The problem manifests primarily on the Sapphire Rapids platform where
C6 has 190us exit latency.

> Also regarding NOHZ_FULL, does that make a difference for your workload?

Yes, absolutely. The workload context is:

- PREEMPT_RT kernel (realtime)
- Isolated cores (isolcpus=)
- NOHZ_FULL enabled on isolated cores
- Inter-core communication latency testing with qperf
- kthreads and IRQ affinity set to non-isolated cores

The scenario: Core A (isolated, NOHZ_FULL) sends a message to Core B
(also isolated, NOHZ_FULL, currently idle). Core B enters C6 during
idle, then when the message arrives, the 190us exit latency dominates
the response time. This is unacceptable for realtime workloads.

> Frankly, if there's relatively strict latency requirements on the system
> you need to let cpuidle know via pm qos or dma_latency....

I considered PM QoS and /dev/cpu_dma_latency, but they have limitations
for this use case:

1. Global PM QoS affects all cores, not just the isolated ones
2. Per-task PM QoS requires application modifications
3. /dev/cpu_dma_latency is system-wide, not per-core

For isolated cores with NOHZ_FULL in a realtime environment, we want
the governor to make smarter decisions based on actual predicted idle
time rather than relying on next_timer_ns which can be arbitrarily large
on tickless cores.

> A trace or cpuidle sysfs dump pre and post workload would really help to
> understand the situation.

I will collect and provide:
- ftrace cpuidle event traces
- Complete sysfs cpuidle dumps pre/post workload
- C-state residency and usage statistics
- Detailed qperf latency measurements

Regarding the safety margin question from v1: you're right that I need
to clarify the logic. The goal is to clamp the upper bound to avoid
unnecessarily deep states when prediction suggests short idle, while
still respecting the prediction for target residency selection.

I'll send a follow-up with the detailed trace data and measurements.

Thanks for your patience and valuable feedback,
Ionut

