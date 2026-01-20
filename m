Return-Path: <linux-pm+bounces-41189-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJUZNafrb2m+UQAAu9opvQ
	(envelope-from <linux-pm+bounces-41189-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:55:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A78864BCED
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 21:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8946B8E11D3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EDB44E052;
	Tue, 20 Jan 2026 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLMcHqyq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C53EFD02
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938222; cv=none; b=C4CakfU/c+8aIXGVaLFrC2VA5wp8ug7HiKt8+nxXyrOdaGdjDo8zQT0NyYK0j8temz02DzPfKvs0LEWflZH1bxwdg/UEIuTzUtxX7WQXO4isdxglqCqCphLu0qTyoMg5h67ceN7UoyjN9UIYKvkKkSwuu7mPDQNgPCO5fuRgYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938222; c=relaxed/simple;
	bh=GKWq3qNE+QoMVDzsvfKNUwlNGiGFagl4gqpCzyoCY3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mM+jJ/rz4HB9HCQtRFY8zqmwNralVC14zxQap5626BGio+fNvZzM4/Js9gSFSJPaSY7GzBgYOvFCiy7+Jp/hAVnGlTZ0l/FO1UD0B/k4XkMa9fz9N2xRF/FQzz/140qoTzlAhfvbrzjLPFli4oKik6W/dThrbOIY2YrWof/wMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLMcHqyq; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801c314c84so37621435e9.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768938218; x=1769543018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sy76whdWsr2+0uhdxqV/7DmqprCp9p5S0npWuG2odvI=;
        b=CLMcHqyq18QGIbHDHKxhvQzUNYpLwtxU8CkC/ajU14Qlkhg5FB+b7s3OUPe0kCFpcn
         P0Vp5Up/zxJAdC+FOVnpkKtNDj0Ey7runCp2ExbNQOHgVmj5LusIR1uIcW60VPJDNNJJ
         yBaYSoLJJjkuR2VteezvqyUt6A38dEahrzbjM2eawzoFqJ1/PLZtQQ9W02zYXkKC5nOg
         f9bkEzfDlDGHeL3xFSQOnNfIiO3B2coMPGeFDDneQLiwiewTAah3nFG+yr5DMb4r3/v4
         z1ZmhSwYEgkYXAqv16E1tc8AlQd6VK2jIf7AgIGB5SF6I2tFIM6g3qqx1xSQ5qnqYBRa
         ao2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938218; x=1769543018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sy76whdWsr2+0uhdxqV/7DmqprCp9p5S0npWuG2odvI=;
        b=PT7WMDteo8h6mNBGpN3YNcS+Mku/vJzYhs2QjRXul3Q6QvzRhhJpjVwdp/K9xW8RBt
         ey7XyBA1qCcevIz6hdwCDYgg1KZ1NW14m8rWgPBSd8bDwAPYvLDkAPNzukfYLgNZtr3U
         aeYcG9i++QruL5qfzJSMIjA9x+UhRNwb1jMUUI1NxzgyV9lokx/xFy+a7hdQLKVu7T4A
         K8Yu7XqiRh6UNIlAzEGKUC7xUSjbOSzLvTY6+OI+cnUylXIV7qTgJtMUrVqGCqagAde6
         oldEjnkvw0l7b+ltZw3bdWBqXW5KNoYFvhnRQOtbF0s2WUkQtc5dWKgYuC1wjmMoG7DZ
         UUzw==
X-Forwarded-Encrypted: i=1; AJvYcCVi/aFtaWkBDM2NFLEIwzdK6n+bCG157+JaOp9dFRuiIN6SCZEN8tu6c2xhGeVCNTn/WArjmwcm9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXh+Xvb6IXGYcJQ8esOPdtH2ari4uWGQCMXeLcEk5/Pa8n+DF
	zv3v5lCiy2K9yDMNcNU0FBKDu6XA7irjU/upZG5BYhnTXYABwIVet8fdPY5BzPYMkxw=
X-Gm-Gg: AY/fxX6xUcttFn9spdWbCUHGGWU3VhvamnlYnq9HDIy8ltViZ/p5tIc5TagVkGcI8ro
	Ma5CbDCRk52ZDuBmWwzfwqvJkLYZl011oMiWVgaW04OvmJAEil2b5pJkD8AFcUumx6nuiKuNyVU
	RaptR+AGPrvwVOhw/e4nvfBC1Zd3GDdvDlKZgI6fsrze3QyUKyKE9uiYiapNLIA373k/KLyvhmw
	W7D+xIIKMwNWD3iijmiOx+HfviIwINs2Oles/1KKj8Kry10w0FZygeMv0LBb6V1t4SKOqs997iM
	D4+uVtCO+Z/8TqNNjwb+sTraQCCUX9YVuJiUY+lMCtu5Ox2kJY5I9lywv8fnUQXk55KIEHVuP8L
	XukziXNfAKMGtYoidF7fXR471xbR+kmAm7bKA0jCYV1/5d5cQEtm2RlkSs77El005lxpI35rtNt
	/dSljaA7aY7y+VMz9hQvEOaG65AKpcnTvcLhc0ZRlbE6T+cODZBaaywZNyKolE2pc=
X-Received: by 2002:a05:600c:458d:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-4801e341e2emr173523155e9.19.1768938218443;
        Tue, 20 Jan 2026 11:43:38 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:ebda:5627:9bc:1ede? ([2a05:6e02:1041:c10:ebda:5627:9bc:1ede])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm257889055e9.3.2026.01.20.11.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:43:37 -0800 (PST)
Message-ID: <b43cae11-e67c-4979-9e9f-b49a0cd640e0@linaro.org>
Date: Tue, 20 Jan 2026 20:43:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Add thermal sensor driver support for Mediatek
 MT8196
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, fshao@chromium.org, Laura Nao <laura.nao@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
 <382ef406-6abf-4d6f-9f0c-42b0bbbd6918@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <382ef406-6abf-4d6f-9f0c-42b0bbbd6918@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[collabora.com,arndb.de,gmail.com,baylibre.com,mediatek.com,public-files.de,vger.kernel.org,lists.infradead.org,chromium.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[collabora.com,kernel.org,intel.com,arm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-41189-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[twitter.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,linaro.org:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A78864BCED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/19/26 13:06, AngeloGioacchino Del Regno wrote:
> Il 25/11/25 17:16, Laura Nao ha scritto:
>> This patch series extends the MediaTek LVTS thermal driver to support the
>> MT8196 SoC.
>>
> 
> This series has been there on the lists for *5 months* now, and it still
> applies as-is.
> 
> Can we *please* get this picked?

Sorry for the delay, it is applied now

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

