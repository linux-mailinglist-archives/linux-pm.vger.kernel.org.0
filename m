Return-Path: <linux-pm+bounces-35043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6ADB8A51C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F157B3A7F46
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23D3176FA;
	Fri, 19 Sep 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoKi0E0+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE4192B66
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296111; cv=none; b=WmZI3L8F6fu+HnhjuaUO2tOdCP6X2wlHXjlhLEo1ZlR9l2/Cjogs1653mFK63EF3WJcHvN/OdkinUDH5urGWCvhM6dWMOHhDg/APsNeA8FuZPr/iY6MjnPPJ4j3GULAWcDhIxw7nCym9hbvO5xdblzCt8OHHeAml0FqWxrEHaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296111; c=relaxed/simple;
	bh=eTWf0PO9mv+rTbVMmJ0b0B+mt8XNGOqlZu172ARy+Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnPkk3UHJG5lMpNgXyPZ1TEMfSuCNolXKIhkUVe+SUJRQDK2hyT+AAsQZOU2mF0BYV5h8EIubXDSStxQyB8vmZUF8UkMbp/2wyQKBJ5j7Kvs4yYic6eNlf/5B2MuFIrKXlEZN4AZjj7S2UhItQiJ0EuHr4N/6b0WOZi9YGZ/sxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AoKi0E0+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso22735325e9.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758296107; x=1758900907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sg77gnAfv1VmZ7w/Slv7Z+RDQVw26Pq4VwEULeHQZFo=;
        b=AoKi0E0+zbXV6pwQhkC5STDf/iOc7ZySP4oGbYXB2bBuMzX6g7sBnknSRVK1PWag/t
         UmlmKiijet+6tegsWbw/izjd4Iw0UfyJ+ZkpLqGWXgB8iXggHTZPTbz6iToyahK+b5eW
         xRpW1W8V/a1psM7bic4Mu5JG70LzVv9KeT6fGDLc8KCIPnA6qG7Pzn10T0ot/CfdC8Lc
         ZoOrQIs8jFSYxeN5yNHub57zEwoLKX8kQeMuGb6qVdjul+hEOBOSDq1KR9jwz/3O/b0O
         k1lf1dPMs2XQiTPms8sIHTn4qcfu2+tecx0fs0PtxKpPBaXVve2IjUvesxy+K+DDjGsE
         gJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296107; x=1758900907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg77gnAfv1VmZ7w/Slv7Z+RDQVw26Pq4VwEULeHQZFo=;
        b=iCwwVxULTzWJf+q+YOvS9d0dKCHzvIMF7+ro+MUoyS56yIJPI97n+we8jq/or1JXUh
         YTtLli4y5mvRbZf+z7b612CvPEPUQW0GI7++r8n8/yXol/Pa8dNc0sgZ9+x5maEZtsQb
         5mpyNHnuHSnBm5hsyB5Xqbhrd+LLCdF5CJAx8X+1EOQsYWhnnsJXFLEh0u+5J/mEHfuz
         PkPfQ2kvA86xPDrJGTvzG7DkU1iOkKe29wIOjZ6kjdmXnihuYs8vyXs26oi6XLaJIK+6
         Rpfu61x1hDE3x8eRDiedYrGCpJoEbGFUe0Q+vPjWQYTx4dZPpB8wf9t72zeqx1Bjeprt
         J2lg==
X-Forwarded-Encrypted: i=1; AJvYcCX4S9sTK5TCBO9FPG6ZXzD0vCM8b7TF2FAZjRMWBfg6oUduzH/4o4YEaMJNcnFETh+z+RP6YCDQCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDW2U9sPIwMK4dtLDRjzS1vn5FbK/l1UtoLwggSpHoucywSTCx
	ECK30etsHHLqf5/wdTMmQgBKxb31xaukOsaUlFMpQkCY9lQVAEoOcGO64xQY5nRxggc=
X-Gm-Gg: ASbGncvzCV0tKle3Zk50ZdllqXKlS7/1vafOqEmRQe5OKSki21HI9qGRsUF1YdRLqH/
	FxQ0N6kin8FgP2M3ASqOl823RWZiw4Of7O2eXsC850icaLSHOa/4BE2mwG+3Z2xA3dHF8aCvGEX
	cRUF2aBkh5oCaPe7jqFbwSQb12+eLKbFtL8OJql0xsmH2qbB+S/PJp0/QWgn3nNMUxhgu0OllVL
	u2srUSR3zhzrU2oes3bAAyn+6SxEYAMm3TuO32kjxw0Aa78BXkNe9oUVQ+UbIq0/BvL++vd2Nvj
	wAXKEqDKY3GUyTRLPiRPPz3jBd2ZaiGRC6iKoelyQYUYrQ7t4BOqJiNTRCTFuLbwb5MogSaz16S
	Qj+iiomgJFscDttl3CiAsqScCZUQBb+7BE347cK06PNf9ZAI/ttVTAZztq//lkcE7eyf9G427C8
	z+rA==
X-Google-Smtp-Source: AGHT+IFy7Dj8N6gYfL+jhWcvEkvYrz3Su9+hU8mu+33/hZoSVy239ih6pL/rb05L3vQtZWkPx65Y3w==
X-Received: by 2002:a05:600c:3587:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-467eb603b52mr32347595e9.36.1758296107505;
        Fri, 19 Sep 2025 08:35:07 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46139123102sm128369815e9.9.2025.09.19.08.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:35:06 -0700 (PDT)
Message-ID: <013d1911-50f8-4891-823b-566bd90a0601@linaro.org>
Date: Fri, 19 Sep 2025 17:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250828055104.8073-1-clamor95@gmail.com>
 <tdknls7jieu4ple3qhmdqntllmctks2auxhxzynwjjmgl3hnx2@nubqlzpgohwf>
 <da8aa4c5-4aa0-42f6-acb6-55d37cc29774@linaro.org>
 <amc5e3sffmwqguivwch6b5vtmlgu5dlwxm7bsrn6nd3rllbvxg@koqmavn6uuy5>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <amc5e3sffmwqguivwch6b5vtmlgu5dlwxm7bsrn6nd3rllbvxg@koqmavn6uuy5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/09/2025 12:26, Thierry Reding wrote:
> On Thu, Sep 11, 2025 at 08:56:12PM +0200, Daniel Lezcano wrote:

[ ... ]

>>
>> I can take the patches 2-5. Regarding a shared branch or wait for the next
>> version, I would prefer the latter
> 
> Alright, let's do it that way. I've picked up patch 1. If you take
> patches 2-5 now I'll pick up patch 6 once v6.18-rc1 has released.

Applied 2-5, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

