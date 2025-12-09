Return-Path: <linux-pm+bounces-39328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D4ECAEF48
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 06:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEF8306C16C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A4A2D839F;
	Tue,  9 Dec 2025 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TygR5e0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36972E613A
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258628; cv=none; b=UZcDXSFLlrQFfx9aBmBiY2jdp+Z6doGA3UC8OlKktxhgDZGSbuKiNNt1nj3511+7hyXGtyJuV37/kAVCgJfmk385gvEnQUdd2bo/UYLMQwEN/CyxW2RuXzO1Gize242Ck1plPrDiVgpNp4I8BEOUpm8heVq8S6fxLdEItllowcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258628; c=relaxed/simple;
	bh=CefoIGQ0zOQjtmKmWVEDUPlyuLPa7NE4zw3r0FVAacg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJZ6k5jYBLA8ffdjxngZfbJUrM0UVgfVFwEoZT2oIn/rqhz+DumG4j7NOWYk1D9UuyB+D/eOYT2Jn9VhZHT+7zaHWY2SPbMBI1ANNf7UiUf0JMCIcGVaK61WzYOl0GkseAU1oTsApI/UOpNoih96dtwHX7G4HOscbFhjdGqrY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TygR5e0p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555415c5fso60311505ad.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2025 21:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765258626; x=1765863426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYp0OCC+sWKk+L/Nrm2Iw3UAwf4IWVfQUc4OYEyL64A=;
        b=TygR5e0pdfNG0DkYfT8QeEU0i14YT8E/MuqoIQVSr6oD9LKyBLnyIV9fJ4PfeFL9uO
         gXvKAroGKLLl564WaCyUJNyf5maKa9o1TcBac8u9WA+QMXu9dz3VYvJvw73WTCt04S7q
         YKpIu64uPS5+uKbXnMcENZqsm9jyY5QYQIO9iLltEw/DSxPqZXu/286iKWB9RMAGBOIh
         3IA1n6VCA0ywjF8XHwUMHJ6WhcDsKTKA2D+6GC/heww/HtPCZEJg9Qtz3i1k8yWyrYdz
         lMqSATmf1BhO1L0zA0eo1brTYpJMzjNQ11clf5kLrxLyqFRR6vLiwjnFiVX2ru1rmDTd
         NifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765258626; x=1765863426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYp0OCC+sWKk+L/Nrm2Iw3UAwf4IWVfQUc4OYEyL64A=;
        b=qQq2JWKai3V9spaTDCLApPJpuixA27ZCwiNHydCYNnf6f/p9LQOpCHOkI9nWpXlxMW
         JSeJ8wSg6aku/pAU3chAy4fREsHOBZKbo1bX5GEvPQdaP/vAp5pO3OP/x33jyMofk8s1
         mNG2IAk6170XzfHiL1rBoKBwRQYx0z8eLKvpb0cWUqXeJE5xs4JNZa2yGCfN8Y4ApPPJ
         mYbyUQZHb7Uww6ACnmnP6lnEsdlvLd016i2qYAToPv4wO4DJUvzhM5wqPR6mQyS+D9Ar
         Y/g5hRO5DpZFC1j2rbuDZn3fIce3R49XBT2PyLRFjnWo/tIAd3/en688V7URANKMZJvh
         PU7A==
X-Forwarded-Encrypted: i=1; AJvYcCV1sTG6sy8iiFdDHqN3xFXxmXyDbaiHA2gVWiJVxu4vjt6UVd3unBbg9U1qK+QdBSWlJRQ+aiJNmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YynP4rAPQySqPxEq0PGPWWsLoAkISV50FYeSXCIJERBR4F+jzfl
	BFlcSp71wC7RiAF2Tm2NZZtryVMDgp1HUJQybQ3tyHDB1fczmE9xInHkqRWB5BugjvDWtn/sS5U
	q/mP/
X-Gm-Gg: ASbGnctThaz+16WnIx0nC5AnmtzDjdEvxSq8CigZt87nSi+2xvmH877iOE0ukVPSkwu
	eYaG0PiVkSUlrOHBXHTH2SoIXYNtVGdrGxCuN8pKeuOpt85b/OKeSCg19CxnPApaEaNgbUs4GFK
	l9Zc2J6EA31Zv2tPQFGK38Hr/M9PUVCe0bHZNkP7eP5QJKABUhP10dvfupmDy8qp7SOGj81wuYP
	ozROCcBqZx1gxZdA1auSEfplpuDoyFtJCNjwilV3O06VIb/3fsLEYKzJapZARI99A8P8HJxUc3V
	Ux17M4BWAWWsn14lrVt/c8q666mc9eXvhYfwTDmz5Jf6ddprmL+kgqEW1/5LfXrHHqMMqB/WcMn
	Q21s0lzfx80BlKWN8bnoKG0cJmXeeZ3uJpEFk9+nH628d3VKQZpb2AHGg+lrwL6GZdptcvt9IrH
	o89SkwhWR6yIA=
X-Google-Smtp-Source: AGHT+IF+CGH2QzU3Dl95CmIg5IQq6FWrXkY+cXpVMFk5o3ZnZs5sjLTXCyRmo4AHtVL1EzlP3sSzPg==
X-Received: by 2002:a17:902:c950:b0:295:7b8c:6611 with SMTP id d9443c01a7336-29df55765d7mr86969205ad.15.1765258625617;
        Mon, 08 Dec 2025 21:37:05 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4d3934sm139522225ad.24.2025.12.08.21.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 21:37:05 -0800 (PST)
Date: Tue, 9 Dec 2025 11:07:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Michal Simek <michal.simek@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Pavel Hronek <hronepa1@fel.cvut.cz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: arm:xlnx,zynq-7000: missing CPU freq in /sys after
 6.18.0-g8f7aa3d3c732 from 2025-12-04
Message-ID: <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
References: <202512081758.02574.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512081758.02574.pisa@fel.cvut.cz>

On 08-12-25, 17:58, Pavel Pisa wrote:
> Dear maintainers and developers,
> 
> we are running CAN/CAN FD subsystem daily correct function
> and latency evaluation on Zynq platform with our CAN FD IPs
> on mainline and RT kernels for years already
> 
>   https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing
> 
> and we experience problem that attempt to set performance
> scaling governor though
> 
>   /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>   /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> 
> started to fail on mainline kernels. The last day
> when setting worked has been 2025-12-04 with
> 6.18.0-g8f7aa3d3c732 kernel. Then the cpufreq
> /sys interface seems to be missing.
> 
> I have checked boot even with latest DTB and the
> intreface is missing still. The driver seems to be
> present
> 
>   /sys/bus/platform/drivers/cpufreq-dt
> 
> the code builds cpufreq-dt-platdev.o which contains
> "xlnx,zynq-7000". The directory
> 
>   /sys/devices/system/cpu/cpufreq
> 
> is present, but it is empty. The module is present and
> linked into kernel
> 
>   /sys/module/cpufreq
> 
> The next config options are set
> 
>   CONFIG_CPUFREQ_DT=y
>   CONFIG_CPUFREQ_DT_PLATDEV=y
> 
> The whole kernel configuration is attached.
> 
> Please, have you some idea what could be a problem?
> Is it necessary to update something or is something missing
> in the device tree?
> 
> I can try to bisect to exact commit or add some debugging
> printks into kernel to obtain more information,
> but it would take some time. What else do you suggest?

Try reverting:

commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with of_machine_get_match_data()")

Also if you can provide your boot logs, it could be useful. Either the probing
of the cpufreq driver isn't attempted, or it just fails somewhere now.

-- 
viresh

