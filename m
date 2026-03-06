Return-Path: <linux-pm+bounces-43727-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBYhFRopqmmQMQEAu9opvQ
	(envelope-from <linux-pm+bounces-43727-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 02:08:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DE21A25B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 02:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B3EB30333DB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 01:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6D30E821;
	Fri,  6 Mar 2026 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UWio2W4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768730B53F
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759249; cv=none; b=mC99kt4ZH0gYGycTH2eEpQYbyNqJN+4QZjFdEQyQ8MIzeLNZpQ36MQaJ8B+r0NIslHgbKvPetGNUgxTcdo7StRdkvuqyjePfROTRjgvhDiJswEIw/Ee6pNiRkaQVSusk/LZJC90Nva6CBnlyQW8mvLiB2FLhryqT8blN2lKekWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759249; c=relaxed/simple;
	bh=2T1EIpwo21Mjm8tHmMvrEddLMLczOQ3KM4OkkTq4KNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uUuh62wMiCqGE3IqSR+U9yfdXioHemwibevC881ft1LRWPjngqhHnCXBY/JIzB9WZj6HQNrarmKtfPbK9xFg88fD7WvKI5GHrbdMdSV7pE02Cm+bsBlEb0AvTklIfoAxz/t5DxLzAyMtCiZDQvJ9eDRC8m+hseZqQzd8Cdm9LlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UWio2W4h; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae50a33ff8so39716905ad.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772759247; x=1773364047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX8DXSun8vyFDP8tcIZqLzghP41cUIRKTQztSXvRddU=;
        b=UWio2W4h2oSKbY85zpadzqT89GpzVrMnIYTK5TD1d9Pt+gYEuIv+Aj+pynyCHfMeVU
         /Q0tggz9sCn7zkdfc2G+9eiNyB6P+okcLtxay547Riiw9sxDeDV4b5HK90COcpwJpYgR
         Ktc4jyJdp0q8r+kGKX5kqA8UzwJQy0dvZDlx/ACOtnGYJn+En/FueCYVei7LmchkgDTh
         KZzwPMkKEInUrSMOFHp6UUDcU+9Ls5jdl0QVBeGPwM579V+sr4UdXgTKIBtaFDOmT2yl
         SLZ9G3+zXNlnMnL+HL4o5m0yaLByxPh5tzfqw9TO9OHJ4268+oLMl95/cwaOoH04aDQV
         4nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759247; x=1773364047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wX8DXSun8vyFDP8tcIZqLzghP41cUIRKTQztSXvRddU=;
        b=EqWD8ov4Y96Mbi3j6D009ifiv2vvoV2rCdcYvNGFLknLfmTZMTwV5j3nyNkR22LIsd
         jOxrpZHTVQ54f5yEZhHG/CCTL1acbSk5gY02gmTmhBmzPXk5hxKCsBMfiEHWd0AF2yZR
         3HnzMnMqWKNxg7LKNC2ii9VIL17Hik8aevutWvRfowaytZpIuDukE39TT8Rq78cUmUzk
         B6svyIFNNFeCfzu/+DG2oe+f1O9379laGNKwc67EmI+HkulG9xkNrdl2VXuDLYcnGJE/
         pn42jDvFZ39WRCGdXER1JJ3wR6JdEXU/NPp4fY1jT+RCDNyqQFn/KOFZE22USJ/WGVLf
         q9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+R4AO9v864PEahxBhQaLQce8FpwrORjZlHQjHQEuv7eewc53LVMZCX1+iInyr0RlRfQqei0nZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgODy0R5VmjhifVPV4Sp8UcaYkoUSC897sVQtwfcAG1fEjm0q
	5ovbC361WOAhbypNC4hb5pICTB+kxLZZ7HUXXw4opXoyw5zHzSncXI6mJD3YDPyrEIhD2owH4lV
	6Sh3YO5I=
X-Gm-Gg: ATEYQzwOeVWIeHdBg/1qj2gMbXU3KrjIKb57Z1RPESVTXe1ObLHrh/jcfaY9yaJmVe6
	k/ehe7h+hQW966tczqZ6jeWoRqK5G856UZiYSwKVqYaB4ITG7xfWpNcus1t8axVo+3leWP4s6Mc
	nRqzRY5udjEzWrzt7B3rA6ePXrQNLe9D0N+hyo3DHR7FMkRt+lTKitKqq4VUstmSa4Leo8vskJf
	8v/tOihy8y00aPxjV1qQTvFVK3oeBxooZT9WjC5et6P1K4Bs84p4inPOhX9xxPaZMAk6FaBRfXM
	HzcI9ADRdY8O0BAZ64tKqmyTE6RMsrl96m/GQLmPpJcSJmpG3vULmwkHvPSn7yelh+e7CQYi/9w
	UvFKdt0kKIMjQ4W7BBvrsKZrbwjxU2HX2yTuBiF8iBvpk4qrfJIf+XQTFyLGeeNSVZlTsw8iHsN
	Phx7KefIDZjxjiCme4mpVj1WrcH6hoHZk=
X-Received: by 2002:a17:903:1b2c:b0:2ae:46b9:c653 with SMTP id d9443c01a7336-2ae82431855mr5201065ad.33.1772759247109;
        Thu, 05 Mar 2026 17:07:27 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5db596sm247377735ad.35.2026.03.05.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:07:26 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>, 
 Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20260226051309.556228-1-rdunlap@infradead.org>
References: <20260226051309.556228-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ARM: omap: fix all kernel-doc warnings
Message-Id: <177275924620.1445909.6503148696411079106.b4-ty@baylibre.com>
Date: Thu, 05 Mar 2026 17:07:26 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Queue-Id: 161DE21A25B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,vger.kernel.org,iki.fi,gmail.com,atomide.com,kemnade.info,kernel.org];
	TAGGED_FROM(0.00)[bounces-43727-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre-com.20230601.gappssmtp.com:dkim,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 21:13:09 -0800, Randy Dunlap wrote:
> Use the correct struct member names to avoid kernel-doc warnings:
> 
> Warning: include/linux/platform_data/voltage-omap.h:27 struct member
>  'volt_nominal' not described in 'omap_volt_data'
> Warning: include/linux/platform_data/voltage-omap.h:27 struct member
>  'vp_errgain' not described in 'omap_volt_data'
> 
> [...]

Applied, thanks!

[1/1] ARM: omap: fix all kernel-doc warnings
      commit: de70eef32e10883fe74f6df635c616785b24b867

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


