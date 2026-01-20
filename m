Return-Path: <linux-pm+bounces-41188-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OChLw/nb2lhUQAAu9opvQ
	(envelope-from <linux-pm+bounces-41188-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:35:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4F4B639
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38D6F7EBBB0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1647D932;
	Tue, 20 Jan 2026 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvQ+wO0R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933847CC9E
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937893; cv=none; b=iMw8ynZ1koijiL2jX92mzYNA6yo5AbuHXcPQVUW/05Epd7iu6c33AFMJKvSX1WKwMD49wxZh7crpwyOLHhu8J/IoRTGNKZuuc2DRiXURz8aL7Vn3zXwe5Bm8WKiqWZvCYt17VszuaHr67Zrk9h+FhfFEIZMzHwB7FvRvPgTEMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937893; c=relaxed/simple;
	bh=qzGTiN2DSgATC7AFVwABYmmpSrfrGrCKEt9PfSUj1y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddIegWQAtZj28AHliRghFF9BeRfqStAKWM1hLUdqqAtPQ8oI4Ke1eu6k5xFhY/Un3YWJe6TKFTP5oPgR8/uSuaD77MC2Eq+DXP91TzfenYVTasZuxXcep139ft5VGqgK+WaILZyy59jvEUbuz5MpeHV2BY8KgK+wCRvUWKZszcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvQ+wO0R; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso252202e87.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 11:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768937889; x=1769542689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5oQNJxHngLfb7biqEV9kKz7u/Vfq13tGGqUE/lHiBo=;
        b=NvQ+wO0RqcW/fSmJGiJj15UVsjEfrpS9i55ntqGxqpMHVzxP1uhGkEOmPWWSTPSIox
         FM2Mz+Wc6x2SoQW1UZkABQR/IyjhJRrfUceaxXZTuvso3RtEi4vFYU5D/Oi1OV7mliLn
         y3k8OkouKS+ze3+/Z7JFfUbB5UfGFxm3MiSqz7E8dOYhD9dOPEAoilWTkF3Rx048WDXo
         04529Q9gjZ/Zg3cbk+M5Oc5V3A++ZPAZTjRuOxpP0AX8dM0h7v1jBVkAPyTmwqKsxpi7
         RaAC2xkjJKYCyux2HGR8Cf3oD6FcUbh4dOB3A8dRgDdCUciQphBbaE9/Kj4/GhmqjxC4
         5Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937889; x=1769542689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5oQNJxHngLfb7biqEV9kKz7u/Vfq13tGGqUE/lHiBo=;
        b=dK2oQXTPuTuk+J3JfR0lvB7BDceFw8BkvrRmJZQ3NcAm8eh+xjrIZy1tpJLLaZIj0M
         zxjhMXDjzK0ELFAwQPdQ8aklwDisMr9y44aZsSa21niHolTKdVK7wr+ceQgsVIBOwu+y
         YX7Plzn5kxnqivJNZLp1IXQgqHMIbD0GNEvtqJDw3S2lg/INpz7IGzkP3uEKvweLI0+R
         NHLywYXsV0xg5X8Wkv7cFO8MQus0qQ/SsZmFTSsGXOrUSswJK3AcjF34EXSjCWrLG14T
         O6a976I3EomVd2KvUASMCsbxIdXJaTM0VHVQkM2BLQVjZA8wBKp3EPBIf6GHza2OQvNj
         z06A==
X-Forwarded-Encrypted: i=1; AJvYcCV2Tz1QzwtSyPr6K3l91oIhoFDUFH75jrRNuEjcdB/31913tzbI0/vHZ43OJAAJMCL1bRnnCcMv/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YybjL5HagtFQV5Qr0NMF9tbguVyDqm9m+q9qU5laAT9KsrGZbyV
	ZJydxQ0zY/oZP0mrzDKl6iRdHjejqYyGG+rAziUHmrpVgzvrfjk3bcAxjW/1gaPOwEM=
X-Gm-Gg: AZuq6aL8PPN261Sl84C2uc5A2GopyRWkhrWzihjgM0RcTcnogdKFVnlLB1qSkK1P8oV
	VhtLA8V9PrIcM6gT/lOYiUF+nvrC/v6Jjy+Q9QLxXG+UsLoYdUTZaCWUrT0lVMQR1r0qynhHD7j
	IBbnCEcO8aq0bUBPIzpYuA+gqEEnMBUBbCLAy+2IQ1AysAxCY4kpGpxjF5kvOec+OGDQROJtjg3
	DX3abUekK9Pgfd0//uCnFECDTSG7QStAkxl9lDUyMupyuqOc9EfL81FTZoLAhm6qfXztL4o6tqO
	f8xf1BUb/6cmy4YxMTVJgoDts834R11METJeW7bwc1AJb0C1TjUOWmzBuNbaKhGhJOJD+gJQ3ep
	CI+1JyMh89HkT0uhD3vdt4kgdj51EqEtfIo1ktGknjtvDW4IQLqoqtc6J3o0BQ3tkXh6NQcaNUd
	Ez9thK35RZ5rHZonJc82kL4z7Q3oZl6IQO5D0mQHCrirzM+9WFmS+gkTwZwuKkTB4=
X-Received: by 2002:a05:6512:3ca8:b0:59b:6d18:d777 with SMTP id 2adb3069b0e04-59baf192842mr5614998e87.22.1768937888893;
        Tue, 20 Jan 2026 11:38:08 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:ebda:5627:9bc:1ede? ([2a05:6e02:1041:c10:ebda:5627:9bc:1ede])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59baf3a17b9sm4293525e87.92.2026.01.20.11.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:38:08 -0800 (PST)
Message-ID: <4c7dc145-1b25-443d-9ac8-e5c7561e2597@linaro.org>
Date: Tue, 20 Jan 2026 20:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: lib: thermal: Correct CFLAGS and LDFLAGS in
 pkg-config template
To: Romain Gantois <romain.gantois@bootlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251226-libthermal-pkgconfig-v1-1-3406de5ca8ea@bootlin.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251226-libthermal-pkgconfig-v1-1-3406de5ca8ea@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41188-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[twitter.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@linaro.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linaro.org:dkim,linaro.org:mid,linaro.org:url]
X-Rspamd-Queue-Id: 7FF4F4B639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/26/25 08:54, Romain Gantois wrote:
> There are two issues with the current pkg-config template. Firstly, the
> -lthermal linker flag is missing. Secondly, the libnl3 include directory
> compiler flag references "include" instead of "includedir", which leads to
> an unexpanded variable when pkg-config is called.
> 
> Add the missing -lthermal flag and correct the libnl3 include directory.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

