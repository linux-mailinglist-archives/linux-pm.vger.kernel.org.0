Return-Path: <linux-pm+bounces-8159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F379F8CFFFC
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928041F22E6D
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F515E5A9;
	Mon, 27 May 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NQA7PTxb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93615DBC0
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812803; cv=none; b=NyYIbgVZd7HrWHfEsVXREjXnDZRmQR06ZJnQ5FNRPZ5aLaZzzxVyoefkLUpMZG1rHWjhsElBoh93s207NtCIKkW4YEjnzT5LNF2K/2JwZWjKyXK2UoD4jxcWc+vyI7myXKdFVmck7ldDWkKMERtjOESZyTMW+3vC2v2g4qlIu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812803; c=relaxed/simple;
	bh=uEBh5knVxjgMQ2FRyTCSQ4x+NhsByRN32pPubCK078Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjRMy4CM+pwmp9bhuRER910JMcF+gd1KTn//QT7mofmOzsWdiQFO3sqgq2vp+mwcOn5MnQG2rHaqbSKwj0/cCVGtbRVpjTUlRYpHLuPKFFmvzrxg55FnmLe++5bdhHzbUbDHmV+yHZRS/LXXw53Co1UvyBC0W5TZBdDj8hYxmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NQA7PTxb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6302bdb54aso87239766b.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716812799; x=1717417599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Z0jYksGWYDCzEC0W0rvVy6TJouZUOtG78WV9BnuANE=;
        b=NQA7PTxbCPG0ilvX5Jmqt9nVvq7Q9khn1iJbRYalCvF8/5AF3M0Vc7K5j2wDUY0Q5X
         bi4LLvY41IHuf1Fu5WQNOQKFlmlUHIrFucZS394h00CW8cZz6aEtwEQGBj2LBeJJXLIA
         zOCBJjXbVBcNzz+9QNqFkVv+b0Qmm0GuBuADFSnU2qxCRSxnTiZXUQ7GLTPFJG8c/j2F
         0tTc5qGV0SpG6KuB+eGCohUSIRDiphWhEjJto/z7A6iJ+ygJrBi78zNNF6UTqiQKdMKl
         bS75WclvfdTksam1E4TmvTcOIKlVJlZ9BspwboQNQ4BbvrF5Lx2IuHUZEVpbwl1subnV
         ZZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812799; x=1717417599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z0jYksGWYDCzEC0W0rvVy6TJouZUOtG78WV9BnuANE=;
        b=qDTLEMTZEgHY11Z1yf/wNYQ5+yVn//mF+v+KZFheQKG17nJoYq/PB0j0yYyFpVm6FO
         SC7UkST/+C0Szh/R1P8s0cY5qCUqjzawQur00Z2ltlNxk9v83nk8WLwXm2jr2Wpb0n/j
         +0HnJvqWmD0HNU2l5T12Yl3uJvhUlPEifceKSN/fgQX4zf1LKkPjHcxqu52BqO+++Wsy
         eStg4t9hDmRogAzjnRU5ELm47W3HDok/xY4dXDROA/sOrDe7yy8seU3KuiEv+2wP9zbW
         sxRV2vPs5oOd0HuMIsZad/JNKElisx+hz4qxKv/uHnbm/ApfL+jJmo2hxxQ73pQ0M50g
         35MQ==
X-Gm-Message-State: AOJu0YyNWhO0IIvI8xIgjhyoDJzyadz3cIfYonUlfAlj6LLrFTkmQcAK
	M8qiupIVj+9H1ycxKwWHqAIarwLufsXUW4pu2Umtwi4oRoBLEhMoLcA9kDWTjTs=
X-Google-Smtp-Source: AGHT+IGdiAI18N5SLWq542WfS9dm3HTYqjqz0CDg1sVYs7nLcvCMNTWyAiOq78S1awvR6RQ9LsxoIA==
X-Received: by 2002:a17:906:478c:b0:a5a:7a1:5d9c with SMTP id a640c23a62f3a-a6265146984mr646663766b.62.1716812799534;
        Mon, 27 May 2024 05:26:39 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817bffsm488121266b.32.2024.05.27.05.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 05:26:39 -0700 (PDT)
Message-ID: <ceb1f7b3-2787-4166-846f-2427b44b3e62@suse.com>
Date: Mon, 27 May 2024 14:26:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nikita Travkin <nikita@trvn.ru>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-4-327a9851dad5@linaro.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240527-yoga-ec-driver-v3-4-327a9851dad5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.24 12:03, Dmitry Baryshkov wrote:

Hi,

> +struct yoga_c630_psy {
> +	struct yoga_c630_ec *ec;
> +	struct device *dev;
> +	struct device_node *of_node;
> +	struct notifier_block nb;
> +	struct mutex lock;
> +
> +	struct power_supply *adp_psy;
> +	struct power_supply *bat_psy;
> +
> +	unsigned long last_status_update;
> +
> +	bool adapter_online;
> +
> +	bool unit_mA;
> +
> +	unsigned int scale;

why do you store unit_mA and scale? This looks redundant and like a source
of confusion to me.

	Regards
		Oliver

